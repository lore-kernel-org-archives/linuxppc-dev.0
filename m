Return-Path: <oxymoron@waste.org>
Received: from waste.org (waste.org [66.93.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "waste.org", Issuer "waste.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4B1E8DE173
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 08:30:47 +1100 (EST)
Date: Mon, 29 Oct 2007 16:13:20 -0500
From: Matt Mackall <mpm@selenic.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Pass PID argument to _tlbie (WAS: Apparent
	kernel bug with GDB on ppc405)
Message-ID: <20071029211320.GF19691@waste.org>
References: <20071024194640.GB19691@waste.org>
	<1193363202.7018.36.camel@pasglop>
	<fa686aa40710251945l51604c5vdf0b49b03b9a1a57@mail.gmail.com>
	<1193369005.7018.46.camel@pasglop>
	<20071026144134.GW19691@waste.org>
	<1193448653.18243.9.camel@pasglop>
	<1193470322.18243.63.camel@pasglop>
	<20071029070824.72854629@weaponx.rchland.ibm.com>
	<20071029151546.5af0e843@weaponx.rchland.ibm.com>
	<1193690106.9928.32.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1193690106.9928.32.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, gdb@sourceware.org,
	Kumar Gala <galak@gate.crashing.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[adding back gdb list]

On Tue, Oct 30, 2007 at 07:35:06AM +1100, Benjamin Herrenschmidt wrote:
> 
> > Did a boot test on my ebony board with this patch included.  It seems
> > to be happy about things so far.  If Matt gets around to trying this
> > out and it works, we should probably look at getting this into 2.6.24.
> > 
> > Oh, and I'd need a signed-off-by for it Ben :)
> 
> Sure, I'll send you a cleaned up version (the version I posted for test
> breaks 64 bits builds :-)
> 
> But I'm also waiting for Matt to test first.

Ok, just backported the 405 bits of this to my client's sad sad MV
2.6.10 kernel and it appears to work fine. Only tricky bit was
context.id -> context. So:

Tested-by: Matt Mackall <mpm@selenic.com>

And here's my backported patch, just for reference:

Index: k/arch/ppc/kernel/misc.S
===================================================================
--- k.orig/arch/ppc/kernel/misc.S	2007-10-29 15:33:03.000000000 -0500
+++ k/arch/ppc/kernel/misc.S	2007-10-29 15:34:29.000000000 -0500
@@ -496,7 +496,13 @@ _GLOBAL(_tlbia)
  */
 _GLOBAL(_tlbie)
 #if defined(CONFIG_40x)
+	mfmsr	r5
+	mfspr	r6,SPRN_PID
+	wrteei	0
+	mtspr	SPRN_PID,r4
 	tlbsx.	r3, 0, r3
+	mtspr	SPRN_PID,r6
+	wrtee	r5
 	bne	10f
 	sync
 	/* There are only 64 TLB entries, so r3 < 64, which means bit 25 is clear.
Index: k/arch/ppc/mm/fault.c
===================================================================
--- k.orig/arch/ppc/mm/fault.c	2007-10-29 15:30:04.000000000 -0500
+++ k/arch/ppc/mm/fault.c	2007-10-29 16:11:10.000000000 -0500
@@ -234,7 +234,7 @@ good_area:
 				set_bit(PG_arch_1, &page->flags);
 			}
 			pte_update(ptep, 0, _PAGE_HWEXEC);
-			_tlbie(address);
+			_tlbie(address, mm->context);
 			pte_unmap(ptep);
 			up_read(&mm->mmap_sem);
 			ltt_ev_trap_exit();
Index: k/arch/ppc/mm/mmu_decl.h
===================================================================
--- k.orig/arch/ppc/mm/mmu_decl.h	2007-10-29 15:34:48.000000000 -0500
+++ k/arch/ppc/mm/mmu_decl.h	2007-10-29 16:11:25.000000000 -0500
@@ -54,7 +54,7 @@ extern unsigned int num_tlbcam_entries;
 #define mmu_mapin_ram()		(0UL)
 
 #elif defined(CONFIG_4xx)
-#define flush_HPTE(X, va, pg)	_tlbie(va)
+#define flush_HPTE(pid, va, pg)	_tlbie(va, pid)
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(void);
 
Index: k/include/asm-ppc/tlbflush.h
===================================================================
--- k.orig/include/asm-ppc/tlbflush.h	2007-10-29 15:31:29.000000000 -0500
+++ k/include/asm-ppc/tlbflush.h	2007-10-29 16:11:32.000000000 -0500
@@ -13,7 +13,7 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 
-extern void _tlbie(unsigned long address);
+extern void _tlbie(unsigned long address, unsigned int pid);
 extern void _tlbia(void);
 
 #if defined(CONFIG_4xx)
@@ -28,10 +28,10 @@ static inline void flush_tlb_mm(struct m
 	{ __tlbia(); }
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				unsigned long vmaddr)
-	{ _tlbie(vmaddr); }
+	{ _tlbie(vmaddr, vma->vm_mm->context); }
 static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
 					 unsigned long vmaddr)
-	{ _tlbie(vmaddr); }
+	{ _tlbie(vmaddr, vma->vm_mm->context); }
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				unsigned long start, unsigned long end)
 	{ __tlbia(); }


-- 
Mathematics is the supreme nostalgia of our time.
