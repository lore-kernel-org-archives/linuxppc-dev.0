Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] fixes for the SLB shadow buffer 
In-reply-to: <18096.6654.934841.561238@cargo.ozlabs.ibm.com> 
References: <17055.1185944172@neuling.org>
	<18096.6654.934841.561238@cargo.ozlabs.ibm.com>
Date: Wed, 01 Aug 2007 16:02:27 +1000
Message-ID: <31580.1185948147@neuling.org>
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
> > +		slb_shadow_update(mk_esid_data(VMALLOC_START, 1),
> > +				  mk_vsid_data(VMALLOC_START, vflags), 1);
> 
> Could you re-jig slb_shadow_update to take ea, slot and vflags, and
> call mk_[ev]sid_data itself, rather than exposing mk_esid_data and
> mk_vsid_data, please?

Sure... this closer to what you want?

 arch/powerpc/kernel/entry_64.S   |    2 ++
 arch/powerpc/mm/hash_utils_64.c  |    6 ++++++
 arch/powerpc/mm/slb.c            |   19 +++++++++----------
 include/asm-powerpc/mmu-hash64.h |    3 +++
 4 files changed, 20 insertions(+), 10 deletions(-)

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
@@ -759,6 +762,9 @@ int hash_page(unsigned long ea, unsigned
 		   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
 		get_paca()->vmalloc_sllp =
 			mmu_psize_defs[mmu_vmalloc_psize].sllp;
+		vflags = SLB_VSID_KERNEL |
+			mmu_psize_defs[mmu_vmalloc_psize].sllp;
+		slb_shadow_update(VMALLOC_START, vflags, 1);
 		slb_flush_and_rebolt();
 	}
 #endif /* CONFIG_PPC_64K_PAGES */
Index: linux-2.6-ozlabs/arch/powerpc/mm/slb.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/slb.c
+++ linux-2.6-ozlabs/arch/powerpc/mm/slb.c
@@ -53,18 +53,19 @@ static inline unsigned long mk_vsid_data
 	return (get_kernel_vsid(ea) << SLB_VSID_SHIFT) | flags;
 }
 
-static inline void slb_shadow_update(unsigned long esid, unsigned long vsid,
-				     unsigned long entry)
+void slb_shadow_update(unsigned long ea,
+		       unsigned long flags,
+		       unsigned long entry)
 {
 	/*
 	 * Clear the ESID first so the entry is not valid while we are
 	 * updating it.
 	 */
 	get_slb_shadow()->save_area[entry].esid = 0;
-	barrier();
-	get_slb_shadow()->save_area[entry].vsid = vsid;
-	barrier();
-	get_slb_shadow()->save_area[entry].esid = esid;
+	smp_wmb();
+	get_slb_shadow()->save_area[entry].vsid = mk_vsid_data(ea, flags);
+	smp_wmb();
+	get_slb_shadow()->save_area[entry].esid = mk_esid_data(ea, entry);
 
 }
 
@@ -76,8 +77,7 @@ static inline void create_shadowed_slbe(
 	 * we don't get a stale entry here if we get preempted by PHYP
 	 * between these two statements.
 	 */
-	slb_shadow_update(mk_esid_data(ea, entry), mk_vsid_data(ea, flags),
-			  entry);
+	slb_shadow_update(ea, flags, entry);
 
 	asm volatile("slbmte  %0,%1" :
 		     : "r" (mk_vsid_data(ea, flags)),
@@ -104,8 +104,7 @@ void slb_flush_and_rebolt(void)
 		ksp_esid_data &= ~SLB_ESID_V;
 
 	/* Only third entry (stack) may change here so only resave that */
-	slb_shadow_update(ksp_esid_data,
-			  mk_vsid_data(ksp_esid_data, lflags), 2);
+	slb_shadow_update(get_paca()->kstack, lflags, 2);
 
 	/* We need to do this all in asm, so we're sure we don't touch
 	 * the stack between the slbia and rebolting it. */
Index: linux-2.6-ozlabs/include/asm-powerpc/mmu-hash64.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/mmu-hash64.h
+++ linux-2.6-ozlabs/include/asm-powerpc/mmu-hash64.h
@@ -262,6 +262,9 @@ extern void slb_initialize(void);
 extern void slb_flush_and_rebolt(void);
 extern void stab_initialize(unsigned long stab);
 
+extern void slb_shadow_update(unsigned long ea,
+			      unsigned long flags,
+			      unsigned long entry);
 #endif /* __ASSEMBLY__ */
 
 /*
