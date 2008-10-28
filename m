Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6DC61DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 14:57:29 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m9S3vNi5026102
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 20:57:23 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m9S3vIg1014573
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 22:57:22 -0500 (CDT)
From: Liu Yu <yu.liu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] math-emu: Fix single float point division bug
Date: Tue, 28 Oct 2008 11:50:18 +0800
Message-Id: <1225165821-15998-2-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1225165821-15998-1-git-send-email-yu.liu@freescale.com>
References: <1225165821-15998-1-git-send-email-yu.liu@freescale.com>
Cc: kumar.gala@freescale.com, Liu Yu <yu.liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PowerPC float point division emulation is derived from gcc.
I reported this problem on gcc maillist and got this reply:
http://gcc.gnu.org/ml/gcc/2008-03/msg00543.html

Since UDIV_NEEDS_NORMALIZATION is not used by kernel, we should use
_FP_DIV_MEAT_1_udiv_norm to make sure the single float point
is normalized before udiv_qrnnd.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
 arch/powerpc/include/asm/sfp-machine.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
index ced34f1..da12ea7 100644
--- a/arch/powerpc/include/asm/sfp-machine.h
+++ b/arch/powerpc/include/asm/sfp-machine.h
@@ -82,7 +82,7 @@
 #define _FP_MUL_MEAT_S(R,X,Y)   _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
 #define _FP_MUL_MEAT_D(R,X,Y)   _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
 
-#define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_udiv(S,R,X,Y)
+#define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_udiv_norm(S,R,X,Y)
 #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_2_udiv(D,R,X,Y)
 
 /* These macros define what NaN looks like. They're supposed to expand to
-- 
1.5.4
