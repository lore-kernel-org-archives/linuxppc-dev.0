Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C4C50B6FF8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:51 +1000 (EST)
Received: from mail40-db3 (localhost [127.0.0.1])	by mail40-db3-R.bigfish.com
 (Postfix) with ESMTP id 1B2FC3405B9	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 25 Jun 2012 12:25:10 +0000 (UTC)
Received: from DB3EHSMHS008.bigfish.com (unknown [10.3.81.236])	by
 mail40-db3.bigfish.com (Postfix) with ESMTP id 4DD69180047	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:06 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQeoT019307	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:40 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 10/17] PowerPC: booke64: Refactor exception prolog for
 save/restore regs
Date: Mon, 25 Jun 2012 15:26:28 +0300
Message-ID: <1340627195-11544-11-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Refactor exception prolog to allow save/restore register parameters. Add
addition none definition for exception prolog usage.
This is needed for exceptions like Guest Doorbell that use GSRRx regsiters
which do not map on exception type.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 7215cc2..52aa96b 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -35,7 +35,7 @@
 #define	SPECIAL_EXC_FRAME_SIZE	INT_FRAME_SIZE
 
 /* Exception prolog code for all exceptions */
-#define EXCEPTION_PROLOG(n, type, addition)				    \
+#define EXCEPTION_PROLOG(n, type, srr0, srr1, addition)		     	    \
 	mtspr	SPRN_SPRG_##type##_SCRATCH,r13;	/* get spare registers */   \
 	mfspr	r13,SPRN_SPRG_PACA;	/* get PACA */			    \
 	std	r10,PACA_EX##type+EX_R10(r13);				    \
@@ -44,54 +44,47 @@
 	addition;			/* additional code for that exc. */ \
 	std	r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */  \
 	stw	r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ \
-	mfspr	r11,SPRN_##type##_SRR1;/* what are we coming from */	    \
+	mfspr	r11,srr1;/* what are we coming from */	    		    \
 	type##_SET_KSTACK;		/* get special stack if necessary */\
 	andi.	r10,r11,MSR_PR;		/* save stack pointer */	    \
 	beq	1f;			/* branch around if supervisor */   \
 	ld	r1,PACAKSAVE(r13);	/* get kernel stack coming from usr */\
 1:	cmpdi	cr1,r1,0;		/* check if SP makes sense */	    \
 	bge-	cr1,exc_##n##_bad_stack;/* bad stack (TODO: out of line) */ \
-	mfspr	r10,SPRN_##type##_SRR0;	/* read SRR0 before touching stack */
+	mfspr	r10,srr0;		/* read SRR0 before touching stack */
 
 /* Exception type-specific macros */
 #define	GEN_SET_KSTACK							    \
 	subi	r1,r1,INT_FRAME_SIZE;	/* alloc frame on kernel stack */
-#define SPRN_GEN_SRR0	SPRN_SRR0
-#define SPRN_GEN_SRR1	SPRN_SRR1
 
 #define CRIT_SET_KSTACK						            \
 	ld	r1,PACA_CRIT_STACK(r13);				    \
 	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
-#define SPRN_CRIT_SRR0	SPRN_CSRR0
-#define SPRN_CRIT_SRR1	SPRN_CSRR1
 
 #define DBG_SET_KSTACK						            \
 	ld	r1,PACA_DBG_STACK(r13);					    \
 	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
-#define SPRN_DBG_SRR0	SPRN_DSRR0
-#define SPRN_DBG_SRR1	SPRN_DSRR1
 
 #define MC_SET_KSTACK						            \
 	ld	r1,PACA_MC_STACK(r13);					    \
 	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
-#define SPRN_MC_SRR0	SPRN_MCSRR0
-#define SPRN_MC_SRR1	SPRN_MCSRR1
 
 #define NORMAL_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, GEN, addition##_GEN(n))
+	EXCEPTION_PROLOG(n, GEN, SPRN_SRR0, SPRN_SRR1, addition##_GEN(n))
 
 #define CRIT_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, CRIT, addition##_CRIT(n))
+	EXCEPTION_PROLOG(n, CRIT, SPRN_CSRR0, SPRN_CSRR1, addition##_CRIT(n))
 
 #define DBG_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, DBG, addition##_DBG(n))
+	EXCEPTION_PROLOG(n, DBG, SPRN_DSRR0, SPRN_DSRR1, addition##_DBG(n))
 
 #define MC_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, MC, addition##_MC(n))
+	EXCEPTION_PROLOG(n, MC, SPRN_MCSRR0, SPRN_MCSRR1, addition##_MC(n))
 
 
 /* Variants of the "addition" argument for the prolog
  */
+#define PROLOG_ADDITION_NONE
 #define PROLOG_ADDITION_NONE_GEN(n)
 #define PROLOG_ADDITION_NONE_CRIT(n)
 #define PROLOG_ADDITION_NONE_DBG(n)
-- 
1.7.4.1
