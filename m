Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [209.128.68.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A66E67A46
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Apr 2005 10:39:48 +1000 (EST)
Date: Mon, 4 Apr 2005 16:17:18 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Dan Malek <dan@embeddededge.com>, Pantelis Antoniou <panto@intracom.gr>
Message-ID: <20050404191718.GA30281@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
Subject: 8xx v2.6 TLB problems and suggested workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

(need volunteers to test the patch below on 8xx)

Hi, 

I've been investigating the 8xx update_mmu_cache() oops for the last weeks, and 
here is what I have gathered. 

Oops: kernel access of bad area, sig: 11 [#1]
NIP: C00049E8 LR: C000A5D0 SP: C4F53E10 REGS: c4f53d60 TRAP: 0300    Not taintedMSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 100113A0, DSISR: C2000000
TASK = c53f17e0[1224] 'a' THREAD: c4f52000
Last syscall: 47
GPR00: C783D2A0 C4F53E10 C53F17E0 10050000 00000100 0009F0A0 10050000 00000000
GPR08: 00075925 C783D2A0 C53F17E0 00000000 00076924 10077178 00000000 100B4338
GPR16: 100BBDE8 0ED792CE 7FFFF670 00000000 00000000 00000000 00000000 C4F41100
GPR24: 00000000 C4F3CAD4 C783D2A0 1005078C C4EB9140 C53861D0 04F85889 C034A0A0
NIP [c00049e8] __flush_dcache_icache+0x14/0x40
LR [c000a5d0] update_mmu_cache+0x64/0x98
Call trace:
 [c003fa7c] do_no_page+0x2f8/0x370
 [c003fc44] handle_mm_fault+0x88/0x160
 [c0009b58] do_page_fault+0x168/0x394
 [c0002c28] handle_page_fault+0xc/0x80

What is happening here is that update_mmu_cache() calls __flush_dcache_icache() 
to sync the d-cache with memory and invalidate any stale i-cache entries for
the address being faulted in.

Problem is that the "dcbst" instruction will, _sometimes_ (the failure/success rate is about 1/4
with my test application) fault as a _write_ operation on the data. 

The address in question is always at the very beginning of the read-only data section, 
thus the write fault (as can be verified in DSISR: 0x02000000) is rejected 
because the vma structure is marked as read-only (vma->flags = ~VM_WRITE).

8xx machines running v2.6 are operating at the moment with a "tlbie()" call at 
update_mmu_cache() just before __flush_dcache_icache(), which worksaround the problem. 

I've been able to watch the "problematic" TLB entry just before update_mmu_cache().
Here it is:

SPR  824 : 0x10011f0b    268508939
BDI>rds 825
SPR  825 : 0x000001e0          480
BDI>rds 826
SPR  826 : 0x00001f00         7936

As you can see by bit 18 of the D-TLB debugging register MD_RAM1 (SPR 826), this entry
is marked as invalid, which will invocate DataTLBError in case of an access at this point
and handle the fault properly in most cases. 

This is expected, and is how the sequence "DataTLBMiss" (no effective address in TLB entry) -> 
"DataTLBError" (existant EA but valid bit not set) works on 8xx.

Kumar Gala suggested inspection of memory which holds __flush_dcache_icache().
With the BDI I could verify that the instruction sequence is there, intact.

I'm unable to determine why a "dcbst" fault is incorrectly being treated as a WRITE operation. 

That seems to be the real problem. Likely to be Yet Another CPU bug? 

I've came up with a workaround which looks acceptable (unlike the tlbie one). 

Solution is to jump directly from the data tlb miss exception to DataAccess, which
in turn calls do_page_fault() and friends.

This avoids the dcbst's from being called to sync an address with an "invalid" TLB entry. 

Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

--- a/arch/ppc/kernel/head_8xx.S.orig	2005-04-04 19:43:23.000000000 -0300
+++ b/arch/ppc/kernel/head_8xx.S	2005-04-04 19:47:40.000000000 -0300
@@ -359,9 +359,7 @@
 
 	. = 0x1200
 DataStoreTLBMiss:
-#ifdef CONFIG_8xx_CPU6
 	stw	r3, 8(r0)
-#endif
 	DO_8xx_CPU6(0x3f80, r3)
 	mtspr	M_TW, r10	/* Save a couple of working registers */
 	mfcr	r10
@@ -390,6 +388,16 @@
 	mfspr	r10, MD_TWC	/* ....and get the pte address */
 	lwz	r10, 0(r10)	/* Get the pte */
 
+	li	r3, 0
+	cmpw	r10, r3            /* does the pte contain a valid address? */
+	bne	4f
+	mfspr   r10, M_TW       /* Restore registers */
+	lwz     r11, 0(r0)
+	mtcr    r11
+	lwz     r11, 4(r0)
+	lwz	r3, 8(r0)
+	b DataAccess
+4:
 	/* Insert the Guarded flag into the TWC from the Linux PTE.
 	 * It is bit 27 of both the Linux PTE and the TWC (at least
 	 * I got that right :-).  It will be better when we can put
@@ -419,9 +427,7 @@
 	lwz	r11, 0(r0)
 	mtcr	r11
 	lwz	r11, 4(r0)
-#ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)
-#endif
 	rfi
 
 /* This is an instruction TLB error on the MPC8xx.  This could be due
