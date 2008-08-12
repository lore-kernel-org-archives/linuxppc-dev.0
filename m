Return-Path: <mohan@in.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2400EDDED5
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 18:13:15 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7C8DBLW030705
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 04:13:11 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7C8BV79151972
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 04:11:31 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7C8BUji019625
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 04:11:30 -0400
Date: Tue, 12 Aug 2008 13:41:28 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/5] Relocation support for kdump kernel
Message-ID: <20080812081128.GE19619@in.ibm.com>
References: <20080811201120.GA25283@in.ibm.com>
	<20080811201821.GE26566@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080811201821.GE26566@in.ibm.com>
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
 arch/powerpc/kernel/crash_dump.c       |   19 +++++++++++++++++++
 arch/powerpc/kernel/iommu.c            |    7 +++++--
 arch/powerpc/kernel/machine_kexec.c    |    6 ++++++
 arch/powerpc/mm/hash_utils_64.c        |    5 +++--
 arch/powerpc/platforms/pseries/iommu.c |    5 ++++-
 5 files changed, 37 insertions(+), 5 deletions(-)

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
