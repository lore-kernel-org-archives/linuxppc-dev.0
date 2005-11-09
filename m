Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 358D46868F
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2005 00:42:08 +1100 (EST)
Date: Wed, 9 Nov 2005 06:42:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20051109064205.A9157@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: fix ppc44x fpu build
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixes ppc44x fpu support that broke from a bad arch/powerpc merge.
Instead of adding KernelFP back in (which duplicates code) we use
the same kernel fpu unavailable handler as classic PPC processors.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/kernel/head_booke.h b/arch/ppc/kernel/head_booke.h
index aeb349b..f3d274c 100644
--- a/arch/ppc/kernel/head_booke.h
+++ b/arch/ppc/kernel/head_booke.h
@@ -358,6 +358,6 @@ label:
 	NORMAL_EXCEPTION_PROLOG;					      \
 	bne	load_up_fpu;		/* if from user, just load it up */   \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
-	EXC_XFER_EE_LITE(0x800, KernelFP)
+	EXC_XFER_EE_LITE(0x800, kernel_fp_unavailable_exception)
 
 #endif /* __HEAD_BOOKE_H__ */
