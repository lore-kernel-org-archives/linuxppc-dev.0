Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B78E41A08AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 18:48:09 +1000 (EST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BBEF01400EE
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2014 18:48:08 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 11 Jun 2014 14:18:06 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5D8B43940065
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2014 14:18:03 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5B8mtUo6357418
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2014 14:18:55 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5B8m2Gr023228
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2014 14:18:02 +0530
Subject: [PATCH 2/4] powerpc/book3s: Add stack overflow check in machine
 check handler.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Jun 2014 14:18:02 +0530
Message-ID: <20140611084801.9634.18318.stgit@mars.in.ibm.com>
In-Reply-To: <20140611084756.9634.82266.stgit@mars.in.ibm.com>
References: <20140611084756.9634.82266.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Currently machine check handler does not check for stack overflow for
nested machine check. If we hit another MCE while inside the machine check
handler repeatedly from same address then we get into risk of stack
overflow which can cause huge memory corruption. This patch limits the
nested MCE level to 4 and panic when we cross level 4.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 274a86d..8a0292d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -439,9 +439,9 @@ BEGIN_FTR_SECTION
 	 * R9		= CR
 	 * Original R9 to R13 is saved on PACA_EXMC
 	 *
-	 * Switch to mc_emergency stack and handle re-entrancy (though we
-	 * currently don't test for overflow). Save MCE registers srr1,
-	 * srr0, dar and dsisr and then set ME=1
+	 * Switch to mc_emergency stack and handle re-entrancy (we limit
+	 * the nested MCE upto level 4 to avoid stack overflow).
+	 * Save MCE registers srr1, srr0, dar and dsisr and then set ME=1
 	 *
 	 * We use paca->in_mce to check whether this is the first entry or
 	 * nested machine check. We increment paca->in_mce to track nested
@@ -464,6 +464,9 @@ BEGIN_FTR_SECTION
 0:	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame */
 	addi	r10,r10,1		/* increment paca->in_mce */
 	sth	r10,PACA_IN_MCE(r13)
+	/* Limit nested MCE to level 4 to avoid stack overflow */
+	cmpwi	r10,4
+	bgt	2f			/* Check if we hit limit of 4 */
 	std	r11,GPR1(r1)		/* Save r1 on the stack. */
 	std	r11,0(r1)		/* make stack chain pointer */
 	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
@@ -482,10 +485,23 @@ BEGIN_FTR_SECTION
 	ori	r11,r11,MSR_RI		/* turn on RI bit */
 	ld	r12,PACAKBASE(r13)	/* get high part of &label */
 	LOAD_HANDLER(r12, machine_check_handle_early)
-	mtspr	SPRN_SRR0,r12
+1:	mtspr	SPRN_SRR0,r12
 	mtspr	SPRN_SRR1,r11
 	rfid
 	b	.	/* prevent speculative execution */
+2:
+	/* Stack overflow. Stay on emergency stack and panic.
+	 * Keep the ME bit off while panic-ing, so that if we hit
+	 * another machine check we checkstop.
+	 */
+	addi	r1,r1,INT_FRAME_SIZE	/* go back to previous stack frame */
+	ld	r11,PACAKMSR(r13)
+	ld	r12,PACAKBASE(r13)
+	LOAD_HANDLER(r12, unrecover_mce)
+	li	r10,MSR_ME
+	andc	r11,r11,r10		/* Turn off MSR_ME */
+	b	1b
+	b	.	/* prevent speculative execution */
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 
 machine_check_pSeries:
