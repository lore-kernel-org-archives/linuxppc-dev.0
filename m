Date: Wed, 19 Sep 2001 12:14:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 4xx icache and tlb flushing
Message-ID: <20010919121403.C13693@zax>
References: <20010918143359.B817@zax> <3BA79D3E.E5BA495A@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BA79D3E.E5BA495A@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 18, 2001 at 03:15:10PM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> > First on icache flushing.  I noticed that flush_icache_page() has been
> > changed to a no-op, wheras it used to flush the whole icache on 4xx.
>
> It is now done when we detect a PTE change that affects an executable
> region.
>
> > Now two questions on tlb flushing.  First, 4xx uses a __tlbia() macro
> > in local_flush_tlb_*().  Is there a reason we don't use the _tlbia()
> > function already included in misc.S?
>
> I dunno, avoids the function call?  We keep swapping between macros
> and functions.  Whatever.

Well, given that the tlbia is about to cause a bunch of TLB miss traps
to occur, the function call overhead is surely trivial.  In the
interests of not duplicating code, here is a patch which eliminates
__tlbia() in favour of _tlbia():

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/mmu_decl.h linux-bungo/arch/ppc/mm/mmu_decl.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/mmu_decl.h	Tue Aug 28 07:59:35 2001
+++ linux-bungo/arch/ppc/mm/mmu_decl.h	Tue Sep 18 16:10:42 2001
@@ -52,7 +52,8 @@
 #define MMU_init_hw()		do { } while(0)

 #elif defined(CONFIG_4xx)
-#define flush_HPTE(X, va, pg)	__tlbia()
+#define flush_HPTE(X, va, pg)	_tlbia()
+extern void MMU_init_hw(void);

 #else
 /* anything except 4xx or 8xx */
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/pgtable.h linux-bungo/include/asm-ppc/pgtable.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/pgtable.h	Tue Sep 18 11:25:44 2001
+++ linux-bungo/include/asm-ppc/pgtable.h	Tue Sep 18 16:02:25 2001
@@ -15,18 +15,16 @@
 #include <asm/page.h>

 #if defined(CONFIG_4xx)
-#define __tlbia()	asm volatile ("tlbia; sync" : : : "memory")
-
 static inline void local_flush_tlb_all(void)
-	{ __tlbia(); }
+	{ _tlbia(); }
 static inline void local_flush_tlb_mm(struct mm_struct *mm)
-	{ __tlbia(); }
+	{ _tlbia(); }
 static inline void local_flush_tlb_page(struct vm_area_struct *vma,
 				unsigned long vmaddr)
-	{ __tlbia(); }
+	{ _tlbia(); }
 static inline void local_flush_tlb_range(struct mm_struct *mm,
 				unsigned long start, unsigned long end)
-	{ __tlbia(); }
+	{ _tlbia(); }
 #define update_mmu_cache(vma, addr, pte)	do { } while (0)

 #elif defined(CONFIG_8xx)

> > ... Is this a bug, or am I missing something?
>
> I thought I checked that in....maybe it's still hanging out in my
> with a bunch of other random 4xx patches.  I'll look again.

Ok..

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
