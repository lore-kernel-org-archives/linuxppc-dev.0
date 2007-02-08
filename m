Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id F403DDDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 14:54:46 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l183sigV026101
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 20:54:44 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l183sglt018425
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 21:54:43 -0600 (CST)
To: paulus@samba.org
Subject: [patch][4/5] powerpc V2: Add the action of rounding for packing
	denormalized numbers
From: ebony.zhu@freescale.com
Message-ID: <ZCH01EXM20lwotWTXs800001060@zch01exm20.fsl.freescale.net>
Date: 8 Feb 2007 11:54:41 +0800
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the action of rounding for packing denormalized
numbers, in order to fully comply with IEEE-754.

Signed-off-by:Ebony Zhu <ebony.zhu@freescale.com>
---
 arch/powerpc/math-emu/op-common.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/math-emu/op-common.h b/arch/powerpc/math-emu/op-common.h
index afb82b6..434e3dd 100644
--- a/arch/powerpc/math-emu/op-common.h
+++ b/arch/powerpc/math-emu/op-common.h
@@ -82,6 +82,7 @@ ({int __ret = 0;						\
 	if (X##_e <= _FP_WFRACBITS_##fs)			\
 	  {							\
 	    _FP_FRAC_SRS_##wc(X, X##_e, _FP_WFRACBITS_##fs);	\
+	    __ret |= _FP_ROUND(wc, X);				\
 	    _FP_FRAC_SLL_##wc(X, 1);				\
 	    if (_FP_FRAC_OVERP_##wc(fs, X))			\
 	      {							\
@@ -100,6 +101,7 @@ ({int __ret = 0;						\
 	    /* underflow to zero */				\
 	    X##_e = 0;						\
 	    _FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);		\
+	    __ret |= _FP_ROUND(wc, X);				\
             __ret |= EFLAG_UNDERFLOW;				\
 	  }							\
       }								\
-- 
1.4.0
