Return-Path: <slightlyunconventional@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id B68FBDDE3A
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 05:05:08 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so285365ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 11:05:04 -0700 (PDT)
Message-ID: <fb412d760810301104s228a6036s50adba8605a13a98@mail.gmail.com>
Date: Thu, 30 Oct 2008 13:04:51 -0500
From: "Hollis Blanchard" <hollis@penguinppc.org>
Sender: slightlyunconventional@gmail.com
To: linuxppc-dev@ozlabs.org
Subject: 44x _tlbie() ME/CE/DE disabling unnecessary?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Regarding this patch:

commit aa1cf632bd6f998cb4567ccf1a9d2e5daaa9fb44
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Tue Aug 7 14:20:50 2007 +1000

    [POWERPC] Fix small race in 44x tlbie function

    The 440 family of processors don't have a tlbie instruction.  So, we
    implement TLB invalidates by explicitly searching the TLB with tlbsx.,
    then clobbering the relevant entry, if any.  Unfortunately the PID for
    the search needs to be stored in the MMUCR register, which is also
    used by the TLB miss handler.  Interrupts were enabled in _tlbie(), so
    an interrupt between loading the MMUCR and the tlbsx could cause
    incorrect search results, and thus a failure to invalide TLB entries
    which needed to be invalidated.

    This fixes the problem in both arch/ppc and arch/powerpc by inhibiting
    interrupts (even critical and debug interrupts) across the relevant
    instructions.

    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
    Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index e708ab7..8533de5 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -301,9 +301,19 @@ _GLOBAL(_tlbie)
 	mfspr	r4,SPRN_MMUCR
 	mfspr	r5,SPRN_PID			/* Get PID */
 	rlwimi	r4,r5,0,24,31			/* Set TID */
-	mtspr	SPRN_MMUCR,r4

+	/* We have to run the search with interrupts disabled, even critical
+	 * and debug interrupts (in fact the only critical exceptions we have
+	 * are debug and machine check).  Otherwise  an interrupt which causes
+	 * a TLB miss can clobber the MMUCR between the mtspr and the tlbsx. */
+	mfmsr	r5
+	lis	r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@ha
+	addi	r6,r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@l
+	andc	r6,r5,r6
+	mtmsr	r6
+	mtspr	SPRN_MMUCR,r4
 	tlbsx.	r3, 0, r3
+	mtmsr	r5
 	bne	10f
 	sync
 	/* There are only 64 TLB entries, so r3 < 64,
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
index 0da5536..a22e1f4 100644
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -237,9 +237,19 @@ _GLOBAL(_tlbie)
 	mfspr	r4,SPRN_MMUCR
 	mfspr	r5,SPRN_PID			/* Get PID */
 	rlwimi	r4,r5,0,24,31			/* Set TID */
-	mtspr	SPRN_MMUCR,r4

+	/* We have to run the search with interrupts disabled, even critical
+	 * and debug interrupts (in fact the only critical exceptions we have
+	 * are debug and machine check).  Otherwise  an interrupt which causes
+	 * a TLB miss can clobber the MMUCR between the mtspr and the tlbsx. */
+	mfmsr	r5
+	lis	r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@ha
+	addi	r6,r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@l
+	andc	r6,r5,r6
+	mtmsr	r6
+	mtspr	SPRN_MMUCR,r4
 	tlbsx.	r3, 0, r3
+	mtmsr	r5
 	bne	10f
 	sync
 	/* There are only 64 TLB entries, so r3 < 64,

I don't think it's necessary at all to disable ME/CE/DE inside
_tlbie() on 440, because the interrupt handlers for those types save
and restore MMUCR (they're all the same code path; see
mcheck_transfer_to_handler in entry_32.S).

However, I think EE does need to be disabled, since the normal EE
handler doesn't deal with MMUCR. So instead of all these MSR
manipulations, I think a simple wrteei 0/1 pair should do the trick?
Or maybe mfmsr/wrteei/wrtee, in case _tlbie() happens to be called
with interrupts disabled already.

-Hollis
