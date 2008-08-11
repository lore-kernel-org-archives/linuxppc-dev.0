Return-Path: <mohan@in.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 158B5DE2BE
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 06:18:30 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7BKBu96028384
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2008 16:11:56 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7BKIOH5166912
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2008 14:18:24 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7BKIOBM001630
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2008 14:18:24 -0600
Date: Tue, 12 Aug 2008 01:48:21 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/5] Relocation support for kdump kernel
Message-ID: <20080811201821.GE26566@in.ibm.com>
References: <20080811201120.GA25283@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080811201120.GA25283@in.ibm.com>
Cc: paulus@samba.org, miltonm@bga.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Relocation support for kdump kernel

Add relocation kernel support for kdump kernel path.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/kernel/crash_dump.c       |   19 +++++++++++++++
 arch/powerpc/kernel/iommu.c            |    7 ++++-
 arch/powerpc/kernel/machine_kexec.c    |    6 ++++
 arch/powerpc/kernel/misc.S             |   40 +++++++++++++++++++++++++------
 arch/powerpc/kernel/prom.c             |   13 +++++++++-
 arch/powerpc/mm/hash_utils_64.c        |    5 ++-
 arch/powerpc/platforms/pseries/iommu.c |    5 +++-
 7 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index e0debcc..58354b8 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -29,7 +29,12 @@
 
 void __init reserve_kdump_trampoline(void)
 {
+#ifdef CONFIG_RELOCATABLE_PPC64
+	if (RELOC(reloc_delta))
+		lmb_reserve(0, KDUMP_RESERVE_LIMIT);
+#else
 	lmb_reserve(0, KDUMP_RESERVE_LIMIT);
+#endif
 }
 
 static void __init create_trampoline(unsigned long addr)
@@ -45,7 +50,11 @@ static void __init create_trampoline(unsigned long addr)
 	 * two instructions it doesn't require any registers.
 	 */
 	patch_instruction(p, PPC_NOP_INSTR);
+#ifndef CONFIG_RELOCATABLE_PPC64
 	patch_branch(++p, addr + PHYSICAL_START, 0);
+#else
+	patch_branch(++p, addr + (RELOC(reloc_delta) & 0xfffffffffffffff), 0);
+#endif
 }
 
 void __init setup_kdump_trampoline(void)
@@ -54,13 +63,23 @@ void __init setup_kdump_trampoline(void)
 
 	DBG(" -> setup_kdump_trampoline()\n");
 
+#ifdef CONFIG_RELOCATABLE_PPC64
+	if (!RELOC(reloc_delta))
+		return;
+#endif
+
 	for (i = KDUMP_TRAMPOLINE_START; i < KDUMP_TRAMPOLINE_END; i += 8) {
 		create_trampoline(i);
 	}
 
 #ifdef CONFIG_PPC_PSERIES
+#ifndef CONFIG_RELOCATABLE_PPC64
 	create_trampoline(__pa(system_reset_fwnmi) - PHYSICAL_START);
 	create_trampoline(__pa(machine_check_fwnmi) - PHYSICAL_START);
+#else
+	create_trampoline(__pa(system_reset_fwnmi) - RELOC(reloc_delta));
+	create_trampoline(__pa(machine_check_fwnmi) - RELOC(reloc_delta));
+#endif
 #endif /* CONFIG_PPC_PSERIES */
 
 	DBG(" <- setup_kdump_trampoline()\n");
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 550a193..9ae7657 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -494,7 +494,7 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 	spin_lock_init(&tbl->it_lock);
 
 #ifdef CONFIG_CRASH_DUMP
-	if (ppc_md.tce_get) {
+	if (reloc_delta && ppc_md.tce_get) {
 		unsigned long index;
 		unsigned long tceval;
 		unsigned long tcecount = 0;
@@ -520,7 +520,10 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 				index < tbl->it_size; index++)
 				__clear_bit(index, tbl->it_map);
 		}
-	}
+	} else
+		/* Clear the hardware table in case firmware left allocations
+		   in it */
+		ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
 #else
 	/* Clear the hardware table in case firmware left allocations in it */
 	ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index aab7688..75dc6af 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -67,6 +67,12 @@ void __init reserve_crashkernel(void)
 	unsigned long long crash_size, crash_base;
 	int ret;
 
+#ifdef CONFIG_RELOCATABLE_PPC64
+	/* Return if its kdump kernel */
+	if (reloc_delta)
+		return;
+#endif
+
 	/* this is necessary because of lmb_phys_mem_size() */
 	lmb_analyze();
 
diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 85cb6f3..28718ed 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -20,6 +20,8 @@
 #include <asm/asm-compat.h>
 #include <asm/asm-offsets.h>
 
+#define RELOC_DELTA 0x4000000002000000
+
 	.text
 
 /*
@@ -33,6 +35,17 @@ _GLOBAL(reloc_offset)
 1:	mflr	r3
 	LOAD_REG_IMMEDIATE(r4,1b)
 	subf	r3,r4,r3
+#ifdef CONFIG_RELOCATABLE_PPC64
+	LOAD_REG_IMMEDIATE(r5, RELOC_DELTA)
+	cmpd	r3,r5
+	bne	2f
+	/*
+	 * Don't return the offset if the difference is
+	 * RELOC_DELTA
+	 */
+	li	r3,0
+2:
+#endif
 	mtlr	r0
 	blr
 
@@ -40,14 +53,25 @@ _GLOBAL(reloc_offset)
  * add_reloc_offset(x) returns x + reloc_offset().
  */
 _GLOBAL(add_reloc_offset)
-	mflr	r0
-	bl	1f
-1:	mflr	r5
-	LOAD_REG_IMMEDIATE(r4,1b)
-	subf	r5,r4,r5
-	add	r3,r3,r5
-	mtlr	r0
-	blr
+        mflr    r0
+        bl      1f
+1:      mflr    r5
+        LOAD_REG_IMMEDIATE(r4,1b)
+        subf    r5,r4,r5
+#ifdef CONFIG_RELOCATABLE_PPC64
+	LOAD_REG_IMMEDIATE(r4, RELOC_DELTA)
+	cmpd	r5,r4
+	bne	2f
+	/*
+	 * Don't add the offset if the difference is
+	 * RELOC_DELTA
+	 */
+	li	r5,0
+2:
+#endif
+        add     r3,r3,r5
+        mtlr    r0
+        blr
 
 _GLOBAL(kernel_execve)
 	li	r0,__NR_execve
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 87d83c5..453dc98 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -65,6 +65,9 @@
 static int __initdata dt_root_addr_cells;
 static int __initdata dt_root_size_cells;
 
+unsigned long reloc_delta __attribute__ ((__section__ (".data")));
+unsigned long kernel_base __attribute__ ((__section__ (".data")));
+
 #ifdef CONFIG_PPC64
 int __initdata iommu_is_off;
 int __initdata iommu_force_on;
@@ -1163,8 +1166,16 @@ void __init early_init_devtree(void *params)
 	parse_early_param();
 
 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
-	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
 	reserve_kdump_trampoline();
+#ifdef CONFIG_RELOCATABLE_PPC64
+	if (RELOC(kernel_base)) {
+		lmb_reserve(0, KDUMP_RESERVE_LIMIT);
+		lmb_reserve(kernel_base, __pa(klimit) - PHYSICAL_START);
+	} else
+		lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
+#else
+	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
+#endif
 	reserve_crashkernel();
 	early_reserve_mem();
 	phyp_dump_reserve_mem();
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5ce5a4d..29474e9 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -677,8 +677,9 @@ void __init htab_initialize(void)
 			continue;
 		}
 #endif /* CONFIG_U3_DART */
-		BUG_ON(htab_bolt_mapping(base, base + size, __pa(base),
-				mode_rw, mmu_linear_psize, mmu_kernel_ssize));
+		BUG_ON(htab_bolt_mapping(base + kernel_base, base + size,
+				__pa(base) + kernel_base, mode_rw, mmu_linear_psize,
+							mmu_kernel_ssize));
        }
 
 	/*
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index a8c4466..480341b 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -291,7 +291,10 @@ static void iommu_table_setparms(struct pci_controller *phb,
 
 	tbl->it_base = (unsigned long)__va(*basep);
 
-#ifndef CONFIG_CRASH_DUMP
+#ifdef CONFIG_CRASH_DUMP
+	if (!reloc_delta)
+		memset((void *)tbl->it_base, 0, *sizep);
+#else
 	memset((void *)tbl->it_base, 0, *sizep);
 #endif
 
-- 
1.5.4
