Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsyJR5qcczF1pJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 16:18:47 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>,
 Mark Hairgrove <mhairgrove@nvidia.com>, mpe@ellerman.id.au,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH v3] powerpc/npu-dma.c: Fix deadlock in mmio_invalidate
Date: Fri,  2 Mar 2018 16:18:45 +1100
Message-Id: <20180302051845.26844-1-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When sending TLB invalidates to the NPU we need to send extra flushes due
to a hardware issue. The original implementation would lock the all the
ATSD MMIO registers sequentially before unlocking and relocking each of
them sequentially to do the extra flush.

This introduced a deadlock as it is possible for one thread to hold one
ATSD register whilst waiting for another register to be freed while the
other thread is holding that register waiting for the one in the first
thread to be freed.

For example if there are two threads and two ATSD registers:

Thread A	Thread B
Acquire 1
Acquire 2
Release 1	Acquire 1
Wait 1		Wait 2

Both threads will be stuck waiting to acquire a register resulting in an
RCU stall warning or soft lockup.

This patch solves the deadlock by refactoring the code to ensure registers
are not released between flushes and to ensure all registers are either
acquired or released together and in order.

Fixes: bbd5ff50afff ("powerpc/powernv/npu-dma: Add explicit flush when sending an ATSD")
Signed-off-by: Alistair Popple <alistair@popple.id.au>

---

v2:
 - Added memory barriers around ATSD register aquisition/release
 - Added compiler barriers around npdev[][] assignment

v3:
 - Added comments to describe required locking

---
 arch/powerpc/platforms/powernv/npu-dma.c | 228 +++++++++++++++++++------------
 1 file changed, 139 insertions(+), 89 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 0a253b64ac5f..0dec96eb3358 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -410,6 +410,11 @@ struct npu_context {
 	void *priv;
 };
 
+struct mmio_atsd_reg {
+	struct npu *npu;
+	int reg;
+};
+
 /*
  * Find a free MMIO ATSD register and mark it in use. Return -ENOSPC
  * if none are available.
@@ -419,7 +424,7 @@ static int get_mmio_atsd_reg(struct npu *npu)
 	int i;
 
 	for (i = 0; i < npu->mmio_atsd_count; i++) {
-		if (!test_and_set_bit(i, &npu->mmio_atsd_usage))
+		if (!test_and_set_bit_lock(i, &npu->mmio_atsd_usage))
 			return i;
 	}
 
@@ -428,86 +433,90 @@ static int get_mmio_atsd_reg(struct npu *npu)
 
 static void put_mmio_atsd_reg(struct npu *npu, int reg)
 {
-	clear_bit(reg, &npu->mmio_atsd_usage);
+	clear_bit_unlock(reg, &npu->mmio_atsd_usage);
 }
 
 /* MMIO ATSD register offsets */
 #define XTS_ATSD_AVA  1
 #define XTS_ATSD_STAT 2
 
-static int mmio_launch_invalidate(struct npu *npu, unsigned long launch,
-				unsigned long va)
+static void mmio_launch_invalidate(struct mmio_atsd_reg *mmio_atsd_reg,
+				unsigned long launch, unsigned long va)
 {
-	int mmio_atsd_reg;
-
-	do {
-		mmio_atsd_reg = get_mmio_atsd_reg(npu);
-		cpu_relax();
-	} while (mmio_atsd_reg < 0);
+	struct npu *npu = mmio_atsd_reg->npu;
+	int reg = mmio_atsd_reg->reg;
 
 	__raw_writeq(cpu_to_be64(va),
-		npu->mmio_atsd_regs[mmio_atsd_reg] + XTS_ATSD_AVA);
+		npu->mmio_atsd_regs[reg] + XTS_ATSD_AVA);
 	eieio();
-	__raw_writeq(cpu_to_be64(launch), npu->mmio_atsd_regs[mmio_atsd_reg]);
-
-	return mmio_atsd_reg;
+	__raw_writeq(cpu_to_be64(launch), npu->mmio_atsd_regs[reg]);
 }
 
-static int mmio_invalidate_pid(struct npu *npu, unsigned long pid, bool flush)
+static void mmio_invalidate_pid(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
+				unsigned long pid, bool flush)
 {
+	int i;
 	unsigned long launch;
 
-	/* IS set to invalidate matching PID */
-	launch = PPC_BIT(12);
+	for (i = 0; i <= max_npu2_index; i++) {
+		if (mmio_atsd_reg[i].reg < 0)
+			continue;
+
+		/* IS set to invalidate matching PID */
+		launch = PPC_BIT(12);
 
-	/* PRS set to process-scoped */
-	launch |= PPC_BIT(13);
+		/* PRS set to process-scoped */
+		launch |= PPC_BIT(13);
 
-	/* AP */
-	launch |= (u64) mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
+		/* AP */
+		launch |= (u64)
+			mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
 
-	/* PID */
-	launch |= pid << PPC_BITLSHIFT(38);
+		/* PID */
+		launch |= pid << PPC_BITLSHIFT(38);
 
-	/* No flush */
-	launch |= !flush << PPC_BITLSHIFT(39);
+		/* No flush */
+		launch |= !flush << PPC_BITLSHIFT(39);
 
-	/* Invalidating the entire process doesn't use a va */
-	return mmio_launch_invalidate(npu, launch, 0);
+		/* Invalidating the entire process doesn't use a va */
+		mmio_launch_invalidate(&mmio_atsd_reg[i], launch, 0);
+	}
 }
 
-static int mmio_invalidate_va(struct npu *npu, unsigned long va,
-			unsigned long pid, bool flush)
+static void mmio_invalidate_va(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
+			unsigned long va, unsigned long pid, bool flush)
 {
+	int i;
 	unsigned long launch;
 
-	/* IS set to invalidate target VA */
-	launch = 0;
+	for (i = 0; i <= max_npu2_index; i++) {
+		if (mmio_atsd_reg[i].reg < 0)
+			continue;
 
-	/* PRS set to process scoped */
-	launch |= PPC_BIT(13);
+		/* IS set to invalidate target VA */
+		launch = 0;
 
-	/* AP */
-	launch |= (u64) mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
+		/* PRS set to process scoped */
+		launch |= PPC_BIT(13);
 
-	/* PID */
-	launch |= pid << PPC_BITLSHIFT(38);
+		/* AP */
+		launch |= (u64)
+			mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
 
-	/* No flush */
-	launch |= !flush << PPC_BITLSHIFT(39);
+		/* PID */
+		launch |= pid << PPC_BITLSHIFT(38);
 
-	return mmio_launch_invalidate(npu, launch, va);
+		/* No flush */
+		launch |= !flush << PPC_BITLSHIFT(39);
+
+		mmio_launch_invalidate(&mmio_atsd_reg[i], launch, va);
+	}
 }
 
 #define mn_to_npu_context(x) container_of(x, struct npu_context, mn)
 
-struct mmio_atsd_reg {
-	struct npu *npu;
-	int reg;
-};
-
 static void mmio_invalidate_wait(
-	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS], bool flush)
+	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
 {
 	struct npu *npu;
 	int i, reg;
@@ -522,16 +531,65 @@ static void mmio_invalidate_wait(
 		reg = mmio_atsd_reg[i].reg;
 		while (__raw_readq(npu->mmio_atsd_regs[reg] + XTS_ATSD_STAT))
 			cpu_relax();
+	}
+}
 
-		put_mmio_atsd_reg(npu, reg);
+/*
+ * Acquires all the address translation shootdown (ATSD) registers required to
+ * launch an ATSD on all links this npu_context is active on.
+ */
+static void acquire_atsd_reg(struct npu_context *npu_context,
+			struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
+{
+	int i, j;
+	struct npu *npu;
+	struct pci_dev *npdev;
+	struct pnv_phb *nphb;
 
-		/*
-		 * The GPU requires two flush ATSDs to ensure all entries have
-		 * been flushed. We use PID 0 as it will never be used for a
-		 * process on the GPU.
+	for (i = 0; i <= max_npu2_index; i++) {
+		mmio_atsd_reg[i].reg = -1;
+		for (j = 0; j < NV_MAX_LINKS; j++) {
+			/* There are no ordering requirements with respect to
+			 * the setup of struct npu_context, but to ensure
+			 * consistent behaviour we need to ensure npdev[][] is
+			 * only read once.
+			 */
+			npdev = READ_ONCE(npu_context->npdev[i][j]);
+			if (!npdev)
+				continue;
+
+			nphb = pci_bus_to_host(npdev->bus)->private_data;
+			npu = &nphb->npu;
+			mmio_atsd_reg[i].npu = npu;
+			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
+			while (mmio_atsd_reg[i].reg < 0) {
+				mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
+				cpu_relax();
+			}
+			break;
+		}
+	}
+}
+
+/*
+ * Release previously acquired ATSD registers. To avoid deadlocks the registers
+ * must be released in the same order they were acquired above in
+ * acquire_atsd_reg.
+ */
+static void release_atsd_reg(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
+{
+	int i;
+
+	for (i = 0; i <= max_npu2_index; i++) {
+		/* We can't rely on npu_context->npdev[][] being the same here
+		 * as when acquire_atsd_reg() was called, hence we use the
+		 * values stored in mmio_atsd_reg during the acquire phase
+		 * rather than re-reading npdev[][]
 		 */
-		if (flush)
-			mmio_invalidate_pid(npu, 0, true);
+		if (mmio_atsd_reg[i].reg < 0)
+			continue;
+
+		put_mmio_atsd_reg(mmio_atsd_reg[i].npu, mmio_atsd_reg[i].reg);
 	}
 }
 
@@ -542,10 +600,6 @@ static void mmio_invalidate_wait(
 static void mmio_invalidate(struct npu_context *npu_context, int va,
 			unsigned long address, bool flush)
 {
-	int i, j;
-	struct npu *npu;
-	struct pnv_phb *nphb;
-	struct pci_dev *npdev;
 	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS];
 	unsigned long pid = npu_context->mm->context.id;
 
@@ -561,37 +615,25 @@ static void mmio_invalidate(struct npu_context *npu_context, int va,
 	 * Loop over all the NPUs this process is active on and launch
 	 * an invalidate.
 	 */
-	for (i = 0; i <= max_npu2_index; i++) {
-		mmio_atsd_reg[i].reg = -1;
-		for (j = 0; j < NV_MAX_LINKS; j++) {
-			npdev = npu_context->npdev[i][j];
-			if (!npdev)
-				continue;
-
-			nphb = pci_bus_to_host(npdev->bus)->private_data;
-			npu = &nphb->npu;
-			mmio_atsd_reg[i].npu = npu;
-
-			if (va)
-				mmio_atsd_reg[i].reg =
-					mmio_invalidate_va(npu, address, pid,
-							flush);
-			else
-				mmio_atsd_reg[i].reg =
-					mmio_invalidate_pid(npu, pid, flush);
-
-			/*
-			 * The NPU hardware forwards the shootdown to all GPUs
-			 * so we only have to launch one shootdown per NPU.
-			 */
-			break;
-		}
+	acquire_atsd_reg(npu_context, mmio_atsd_reg);
+	if (va)
+		mmio_invalidate_va(mmio_atsd_reg, address, pid, flush);
+	else
+		mmio_invalidate_pid(mmio_atsd_reg, pid, flush);
+
+	mmio_invalidate_wait(mmio_atsd_reg);
+	if (flush) {
+		/*
+		 * The GPU requires two flush ATSDs to ensure all entries have
+		 * been flushed. We use PID 0 as it will never be used for a
+		 * process on the GPU.
+		 */
+		mmio_invalidate_pid(mmio_atsd_reg, 0, true);
+		mmio_invalidate_wait(mmio_atsd_reg);
+		mmio_invalidate_pid(mmio_atsd_reg, 0, true);
+		mmio_invalidate_wait(mmio_atsd_reg);
 	}
-
-	mmio_invalidate_wait(mmio_atsd_reg, flush);
-	if (flush)
-		/* Wait for the flush to complete */
-		mmio_invalidate_wait(mmio_atsd_reg, false);
+	release_atsd_reg(mmio_atsd_reg);
 }
 
 static void pnv_npu2_mn_release(struct mmu_notifier *mn,
@@ -726,7 +768,15 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
 							&nvlink_index)))
 		return ERR_PTR(-ENODEV);
-	npu_context->npdev[npu->index][nvlink_index] = npdev;
+
+	/* npdev is a pci_dev pointer setup by the PCI code. We assign it to
+	 * npdev[][] to indicate to the mmu notifiers that an invalidation
+	 * should also be sent over this nvlink. The notifiers don't use any
+	 * other fields in npu_context, so we just need to ensure that when they
+	 * deference npu_context->npdev[][] it is either a valid pointer or
+	 * NULL.
+	 */
+	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], npdev);
 
 	if (!nphb->npu.nmmu_flush) {
 		/*
@@ -778,7 +828,7 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
 							&nvlink_index)))
 		return;
-	npu_context->npdev[npu->index][nvlink_index] = NULL;
+	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], NULL);
 	opal_npu_destroy_context(nphb->opal_id, npu_context->mm->context.id,
 				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
 	kref_put(&npu_context->kref, pnv_npu2_release_context);
-- 
2.11.0
