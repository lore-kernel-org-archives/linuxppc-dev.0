Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] fixes for the SLB shadow buffer
Date: Wed, 01 Aug 2007 14:56:12 +1000
Message-ID: <17055.1185944172@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We sometimes change the vmalloc segment in slb_flush_and_rebolt but we
never updated with slb shadow buffer.  This fixes it.  Thanks to paulus
for finding this.

Also added some write barriers to ensure the shadow buffer is always
valid.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Paulus: unless someone has a problem with my implementation, this should
        go up for 2.6.23. 

 arch/powerpc/kernel/entry_64.S   |    2 ++
 arch/powerpc/mm/hash_utils_64.c  |    7 +++++++
 arch/powerpc/mm/slb.c            |   10 +++++-----
 include/asm-powerpc/mmu-hash64.h |    4 ++++
 4 files changed, 18 insertions(+), 5 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/entry_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
@@ -389,7 +389,9 @@ BEGIN_FTR_SECTION
 	ld	r9,PACA_SLBSHADOWPTR(r13)
 	li	r12,0
 	std	r12,SLBSHADOW_STACKESID(r9) /* Clear ESID */
+	eieio
 	std	r7,SLBSHADOW_STACKVSID(r9)  /* Save VSID */
+	eieio
 	std	r0,SLBSHADOW_STACKESID(r9)  /* Save ESID */
 
 	slbie	r6
Index: linux-2.6-ozlabs/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/hash_utils_64.c
+++ linux-2.6-ozlabs/arch/powerpc/mm/hash_utils_64.c
@@ -629,6 +629,9 @@ int hash_page(unsigned long ea, unsigned
 	cpumask_t tmp;
 	int rc, user_region = 0, local = 0;
 	int psize;
+#ifdef CONFIG_PPC_64K_PAGES
+	unsigned long vflags;
+#endif
 
 	DBG_LOW("hash_page(ea=%016lx, access=%lx, trap=%lx\n",
 		ea, access, trap);
@@ -759,6 +762,10 @@ int hash_page(unsigned long ea, unsigned
 		   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
 		get_paca()->vmalloc_sllp =
 			mmu_psize_defs[mmu_vmalloc_psize].sllp;
+		vflags = SLB_VSID_KERNEL |
+			mmu_psize_defs[mmu_vmalloc_psize].sllp;
+		slb_shadow_update(mk_esid_data(VMALLOC_START, 1),
+				  mk_vsid_data(VMALLOC_START, vflags), 1);
 		slb_flush_and_rebolt();
 	}
 #endif /* CONFIG_PPC_64K_PAGES */
Index: linux-2.6-ozlabs/arch/powerpc/mm/slb.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/slb.c
+++ linux-2.6-ozlabs/arch/powerpc/mm/slb.c
@@ -43,17 +43,17 @@ static void slb_allocate(unsigned long e
 	slb_allocate_realmode(ea);
 }
 
-static inline unsigned long mk_esid_data(unsigned long ea, unsigned long slot)
+unsigned long mk_esid_data(unsigned long ea, unsigned long slot)
 {
 	return (ea & ESID_MASK) | SLB_ESID_V | slot;
 }
 
-static inline unsigned long mk_vsid_data(unsigned long ea, unsigned long flags)
+unsigned long mk_vsid_data(unsigned long ea, unsigned long flags)
 {
 	return (get_kernel_vsid(ea) << SLB_VSID_SHIFT) | flags;
 }
 
-static inline void slb_shadow_update(unsigned long esid, unsigned long vsid,
+void slb_shadow_update(unsigned long esid, unsigned long vsid,
 				     unsigned long entry)
 {
 	/*
@@ -61,9 +61,9 @@ static inline void slb_shadow_update(uns
 	 * updating it.
 	 */
 	get_slb_shadow()->save_area[entry].esid = 0;
-	barrier();
+	smp_wmb();
 	get_slb_shadow()->save_area[entry].vsid = vsid;
-	barrier();
+	smp_wmb();
 	get_slb_shadow()->save_area[entry].esid = esid;
 
 }
Index: linux-2.6-ozlabs/include/asm-powerpc/mmu-hash64.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/mmu-hash64.h
+++ linux-2.6-ozlabs/include/asm-powerpc/mmu-hash64.h
@@ -262,6 +262,10 @@ extern void slb_initialize(void);
 extern void slb_flush_and_rebolt(void);
 extern void stab_initialize(unsigned long stab);
 
+extern unsigned long mk_esid_data(unsigned long ea, unsigned long slot);
+extern unsigned long mk_vsid_data(unsigned long ea, unsigned long flags);
+extern void slb_shadow_update(unsigned long esid, unsigned long vsid,
+			      unsigned long entry);
 #endif /* __ASSEMBLY__ */
 
 /*
