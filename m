Return-Path: <dgibson@ozlabs.org>
Date: Tue, 7 Aug 2007 14:20:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Fix small race in 44x tlbie function
Message-ID: <20070807042050.GJ13522@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Todd Inglett <tinglett@us.ibm.com>,
	Volkmar Uhlig <vuhlig@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 440 family of processors don't have a tlbie instruction.  So, we
implement TLB invalidates by explicitly searching the TLB with tlbsx.,
then clobbering the relevant entry, if any.  Unfortunately the PID for
the search needs to be stored in the MMUCR register, which is also
used by the TLB miss handler.  Interrupts were enabled in _tlbie(), so
an interrupt between loading the MMUCR and the tlbsx could cause
incorrect search results, and thus a failure to invalide TLB entries
which needed to be invalidated.

This patch fixes the problem in both arch/ppc and arch/powerpc by
inhibiting interrupts (even critical and debug interrupts) across the
relevant instructions.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
Paul, this one's a bugfix, which I think should go into 2.6.23.

Index: working-2.6/arch/powerpc/kernel/misc_32.S
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/misc_32.S	2007-07-27 14:19:46.000000000 +1000
+++ working-2.6/arch/powerpc/kernel/misc_32.S	2007-07-27 14:30:46.000000000 +1000
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
Index: working-2.6/arch/ppc/kernel/misc.S
===================================================================
--- working-2.6.orig/arch/ppc/kernel/misc.S	2007-07-27 14:19:46.000000000 +1000
+++ working-2.6/arch/ppc/kernel/misc.S	2007-07-27 14:31:31.000000000 +1000
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

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
