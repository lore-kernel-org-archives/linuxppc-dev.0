Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89C351A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 21:25:46 +1100 (EST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 113B11400B2
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2014 21:25:44 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 7 Oct 2014 15:55:39 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id AEFAD1258043
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2014 15:56:23 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s97APtBe40501318
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Oct 2014 15:55:56 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s97APXeK012736
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Oct 2014 15:55:33 +0530
Subject: [PATCH] powerpc/book3s: Don't clear MSR_RI in hmi handler.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 07 Oct 2014 15:55:33 +0530
Message-ID: <20141007102515.30449.56223.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

In HMI interrupt handler we don't touch SRR0/SRR1, instead we touch
HSRR0/HSRR1. Hence we don't need to clear MSR_RI bit.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 050f79a..72e783e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1270,11 +1270,6 @@ hmi_exception_early:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	hmi_exception_realmode
 	/* Windup the stack. */
-	/* Clear MSR_RI before setting SRR0 and SRR1. */
-	li	r0,MSR_RI
-	mfmsr	r9			/* get MSR value */
-	andc	r9,r9,r0
-	mtmsrd	r9,1			/* Clear MSR_RI */
 	/* Move original HSRR0 and HSRR1 into the respective regs */
 	ld	r9,_MSR(r1)
 	mtspr	SPRN_HSRR1,r9
