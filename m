Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F083DE067
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 04:49:22 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m5BInIlj030132
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 13:49:19 -0500
Date: Wed, 11 Jun 2008 13:49:18 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/booke: Fix some comments related to debug level
	exceptions
Message-ID: <Pine.LNX.4.64.0806111348540.14337@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---

In my git tree, just posting so people see it.

- k

 arch/powerpc/kernel/head_booke.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index f277fad..9501c58 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -240,7 +240,7 @@ label:
 	 * the code where the exception occurred (since exception entry	      \
 	 * doesn't turn off DE automatically).  We simulate the effect	      \
 	 * of turning off DE on entry to an exception handler by turning      \
-	 * off DE in the CSRR1 value and clearing the debug status.	      \
+	 * off DE in the DSRR1 value and clearing the debug status.	      \
 	 */								      \
 	mfspr	r10,SPRN_DBSR;		/* check single-step/branch taken */  \
 	andis.	r10,r10,DBSR_IC@h;					      \
@@ -278,7 +278,7 @@ label:
 	RFDI;								      \
 	b	.;							      \
 									      \
-	/* continue normal handling for a critical exception... */	      \
+	/* continue normal handling for a debug exception... */		      \
 2:	mfspr	r4,SPRN_DBSR;						      \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
 	EXC_XFER_TEMPLATE(DebugException, 0x2008, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, debug_transfer_to_handler, ret_from_debug_exc)
-- 
1.5.5.1
