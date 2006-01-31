Return-Path: <bgill@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B281168A3A
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Feb 2006 10:53:09 +1100 (EST)
Date: Tue, 31 Jan 2006 17:52:59 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@gate.crashing.org
Subject: [PATCH] powerpc: Fix Kernel FP unavail exception for BookE
Message-ID: <Pine.LNX.4.61.0601311746250.18350@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: Correct BookE FP unavailable exception

Updated FP unavailable exception to refer to the correct
function in traps.c. head_booke.h was using the old name, KernelFP,
instead of kernel_fp_unavailable_exception.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

---
commit 6e481b074a1cbe44dd5ccc29fe74857986a41e14
tree 5e3d59136176a927dae2f42ce83b393b17fc86e6
parent 2a68349345a9bf292d06a8baaa8182b946c7056c
author Becky Bruce <becky.bruce@freescale.com> Tue, 31 Jan 2006 17:41:00 -0600
committer Becky Bruce <becky.bruce@freescale.com> Tue, 31 Jan 2006 17:41:00 -0600

 arch/powerpc/kernel/head_booke.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 5827c27..8536e76 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -358,6 +358,6 @@ label:
 	NORMAL_EXCEPTION_PROLOG;					      \
 	bne	load_up_fpu;		/* if from user, just load it up */   \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
-	EXC_XFER_EE_LITE(0x800, KernelFP)
+	EXC_XFER_EE_LITE(0x800, kernel_fp_unavailable_exception)
 
 #endif /* __HEAD_BOOKE_H__ */
