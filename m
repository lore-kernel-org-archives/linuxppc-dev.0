Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60DB6DE186
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:59 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:52 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>
Message-id: <patch-fsl-1@bga.com>
Subject: [PATCH] powerpc: remove non-dependent load fsl_booke PTE_64BIT
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

b38fd42ff46a4a31dced8533e8a6e549693500b6 added false dependencys
to order the load of upper and lower halfs of the pte, but only
adjusted whitespace instead of deleting the old load in the iside
handler, letting the hardware see the non-dependent load.

This patch removes the extra load.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Kumar, I think this is right from my inspection, please review.

Index: next.git/arch/powerpc/kernel/head_fsl_booke.S
===================================================================
--- next.git.orig/arch/powerpc/kernel/head_fsl_booke.S	2008-10-05 02:40:38.000000000 -0500
+++ next.git/arch/powerpc/kernel/head_fsl_booke.S	2008-10-05 02:40:58.000000000 -0500
@@ -658,10 +658,6 @@ interrupt_base:
 
 	bne	2f			/* Bail if permission mismach */
 
-#ifdef CONFIG_PTE_64BIT
-	lwz	r13,0(r12)
-#endif
-
 	/* Jump to common TLB load point */
 	b	finish_tlb_load
 
