Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsLnT3ZkJzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 18:37:33 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org,
	mpe@ellerman.id.au
Cc: mhairgrove@nvidia.com,
	Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powernv/npu-dma.c: Add explicit flush when sending an ATSD
Date: Tue, 20 Jun 2017 18:37:28 +1000
Message-Id: <1497947848-4625-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NPU2 requires an extra explicit flush to an active GPU PID when sending
address translation shoot downs (ATSDs) to reliably flush the GPU TLB. This
patch adds just such a flush at the end of each sequence of ATSDs.

We can safely use PID 0 which is always reserved and active on the GPU. PID
0 is only used for init_mm which will never be a user mm on the GPU. To
enforce this we add a check in pnv_npu2_init_context() just in case someone
tries to use PID 0 on the GPU.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---

Michael,

It turns out my assumptions about MMU_NO_CONTEXT were wrong so we have
reverted to using HW context id/PID 0 (init_mm) as that is quite clearly
reserved on hash and radix and it seems unlikely PID 0 would ever be used
for anything else.

That said if you feel strongly it would be easy enough to add functions to
reserve a PID and an exported function for device drivers to call to find
out what the reserved PID is. I was avoiding it because it would be more
invasive adding code and an external API for something that I'm not sure
will ever change, although if it does there is a check in
pnv2_npu2_init_context() to flag it so it won't result in weird bugs.

Anyway let me know which way you would like us to go here and I can update
the patch as required, thanks!

- Alistair

arch/powerpc/platforms/powernv/npu-dma.c | 93 ++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index e6f444b..9468064 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -449,7 +449,7 @@ static int mmio_launch_invalidate(struct npu *npu, unsigned long launch,
 	return mmio_atsd_reg;
 }
 
-static int mmio_invalidate_pid(struct npu *npu, unsigned long pid)
+static int mmio_invalidate_pid(struct npu *npu, unsigned long pid, bool flush)
 {
 	unsigned long launch;
 
@@ -465,12 +465,15 @@ static int mmio_invalidate_pid(struct npu *npu, unsigned long pid)
 	/* PID */
 	launch |= pid << PPC_BITLSHIFT(38);
 
+	/* No flush */
+	launch |= !flush << PPC_BITLSHIFT(39);
+
 	/* Invalidating the entire process doesn't use a va */
 	return mmio_launch_invalidate(npu, launch, 0);
 }
 
 static int mmio_invalidate_va(struct npu *npu, unsigned long va,
-			unsigned long pid)
+			unsigned long pid, bool flush)
 {
 	unsigned long launch;
 
@@ -486,26 +489,60 @@ static int mmio_invalidate_va(struct npu *npu, unsigned long va,
 	/* PID */
 	launch |= pid << PPC_BITLSHIFT(38);
 
+	/* No flush */
+	launch |= !flush << PPC_BITLSHIFT(39);
+
 	return mmio_launch_invalidate(npu, launch, va);
 }
 
 #define mn_to_npu_context(x) container_of(x, struct npu_context, mn)
 
+struct mmio_atsd_reg {
+	struct npu *npu;
+	int reg;
+};
+
+static void mmio_invalidate_wait(
+	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS], bool flush)
+{
+	struct npu *npu;
+	int i, reg;
+
+	/* Wait for all invalidations to complete */
+	for (i = 0; i <= max_npu2_index; i++) {
+		if (mmio_atsd_reg[i].reg < 0)
+			continue;
+
+		/* Wait for completion */
+		npu = mmio_atsd_reg[i].npu;
+		reg = mmio_atsd_reg[i].reg;
+		while (__raw_readq(npu->mmio_atsd_regs[reg] + XTS_ATSD_STAT))
+			cpu_relax();
+
+		put_mmio_atsd_reg(npu, reg);
+
+		/*
+		 * The GPU requires two flush ATSDs to ensure all entries have
+		 * been flushed. We use PID 0 as it will never be used for a
+		 * process on the GPU.
+		 */
+		if (flush)
+			mmio_invalidate_pid(npu, 0, 1);
+	}
+}
+
 /*
  * Invalidate either a single address or an entire PID depending on
  * the value of va.
  */
 static void mmio_invalidate(struct npu_context *npu_context, int va,
-			unsigned long address)
+			unsigned long address, bool flush)
 {
-	int i, j, reg;
+	int i, j;
 	struct npu *npu;
 	struct pnv_phb *nphb;
 	struct pci_dev *npdev;
-	struct {
-		struct npu *npu;
-		int reg;
-	} mmio_atsd_reg[NV_MAX_NPUS];
+	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS];
 	unsigned long pid = npu_context->mm->context.id;
 
 	/*
@@ -525,10 +562,11 @@ static void mmio_invalidate(struct npu_context *npu_context, int va,
 
 			if (va)
 				mmio_atsd_reg[i].reg =
-					mmio_invalidate_va(npu, address, pid);
+					mmio_invalidate_va(npu, address, pid,
+							flush);
 			else
 				mmio_atsd_reg[i].reg =
-					mmio_invalidate_pid(npu, pid);
+					mmio_invalidate_pid(npu, pid, flush);
 
 			/*
 			 * The NPU hardware forwards the shootdown to all GPUs
@@ -544,18 +582,10 @@ static void mmio_invalidate(struct npu_context *npu_context, int va,
 	 */
 	flush_tlb_mm(npu_context->mm);
 
-	/* Wait for all invalidations to complete */
-	for (i = 0; i <= max_npu2_index; i++) {
-		if (mmio_atsd_reg[i].reg < 0)
-			continue;
-
-		/* Wait for completion */
-		npu = mmio_atsd_reg[i].npu;
-		reg = mmio_atsd_reg[i].reg;
-		while (__raw_readq(npu->mmio_atsd_regs[reg] + XTS_ATSD_STAT))
-			cpu_relax();
-		put_mmio_atsd_reg(npu, reg);
-	}
+	mmio_invalidate_wait(mmio_atsd_reg, flush);
+	if (flush)
+		/* Wait for the flush to complete */
+		mmio_invalidate_wait(mmio_atsd_reg, 0);
 }
 
 static void pnv_npu2_mn_release(struct mmu_notifier *mn,
@@ -571,7 +601,7 @@ static void pnv_npu2_mn_release(struct mmu_notifier *mn,
 	 * There should be no more translation requests for this PID, but we
 	 * need to ensure any entries for it are removed from the TLB.
 	 */
-	mmio_invalidate(npu_context, 0, 0);
+	mmio_invalidate(npu_context, 0, 0, 1);
 }
 
 static void pnv_npu2_mn_change_pte(struct mmu_notifier *mn,
@@ -581,7 +611,7 @@ static void pnv_npu2_mn_change_pte(struct mmu_notifier *mn,
 {
 	struct npu_context *npu_context = mn_to_npu_context(mn);
 
-	mmio_invalidate(npu_context, 1, address);
+	mmio_invalidate(npu_context, 1, address, 1);
 }
 
 static void pnv_npu2_mn_invalidate_page(struct mmu_notifier *mn,
@@ -590,7 +620,7 @@ static void pnv_npu2_mn_invalidate_page(struct mmu_notifier *mn,
 {
 	struct npu_context *npu_context = mn_to_npu_context(mn);
 
-	mmio_invalidate(npu_context, 1, address);
+	mmio_invalidate(npu_context, 1, address, 1);
 }
 
 static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
@@ -600,8 +630,11 @@ static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
 	struct npu_context *npu_context = mn_to_npu_context(mn);
 	unsigned long address;
 
-	for (address = start; address <= end; address += PAGE_SIZE)
-		mmio_invalidate(npu_context, 1, address);
+	for (address = start; address < end; address += PAGE_SIZE)
+		mmio_invalidate(npu_context, 1, address, 0);
+
+	/* Do the flush only on the final addess == end */
+	mmio_invalidate(npu_context, 1, address, 1);
 }
 
 static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
@@ -651,8 +684,10 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 		/* No nvlink associated with this GPU device */
 		return ERR_PTR(-ENODEV);
 
-	if (!mm) {
-		/* kernel thread contexts are not supported */
+	if (!mm || mm->context.id == 0) {
+		/* kernel thread contexts are not supported and context id 0 is
+		 * reserved on the GPU.
+		 */
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.1.4
