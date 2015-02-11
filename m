Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D5591A056B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 15:55:49 +1100 (AEDT)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 4/5 v2] powerpc/boot: Fix stack corruption in epapr entry point
Message-Id: <1423630544.753239.249639260955.4.gpush@pablo>
In-Reply-To: <1423630544.752188.889982625387.1.gpush@pablo>
To: linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 11 Feb 2015 12:55:44 +0800
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, a 64-bit little-endian zImage.epapr won't boot in epapr mode,
as we never return from platform_init.

Before entering C, we initialise our stack by setting r1 16 bytes below
the end of the _bss_stack:

  stwu	r0,-16(r1)	/* establish a stack frame */

However, the called function will save the caller's lr in the caller's
frame's lr save area, at -16(r1) to -32(r1).

This means that writes to the fdt variable will corrupt the saved link
register:

 0000000020c06018 l     O .bss   0000000000001000 _bss_stack
 0000000020c07018 l     O .bss   0000000000000008 fdt

We'll need at least 32 bytes in the initial stack frame, to handle the
LR save area. We bump this to 112 bytes, as that'll be the max required
by ABIv1.

Thanks to Alistair Popple for debugging help.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/boot/crt0.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index 14de4f8..e004062 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -218,7 +218,7 @@ p_base:	mflr	r10		/* r10 now points to runtime addr of p_base */
 	beq	6f
 	ld	r1,0(r8)
 	li	r0,0
-	stdu	r0,-16(r1)	/* establish a stack frame */
+	stdu	r0,-112(r1)	/* establish a stack frame */
 6:
 #endif  /* __powerpc64__ */
 	/* Call platform_init() */
