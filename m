Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FFFC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:10:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079232087F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZfV6Cc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079232087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43811v1tztzDqhD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 10:10:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rZfV6Cc5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rZfV6Cc5"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4380yj4w8mzDqgj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 10:07:57 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id q1so7146356pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 15:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fsIQWT8fp06IrEyHg92VCjuQxMGohN4oaxHAJmGohiA=;
 b=rZfV6Cc5FMNKA9glXExvf6VJXa0pxJX3KDBX/UODLRDL1Xg2ConwJdWgy88Cd348Nf
 rEdd1oC+OKXzeW3MvZKaR47tQnODZRu+UzAD7ws9E5fXKVAdKmJn1DlyQgCliZ1MSRIq
 MPOyzFkZDZYElTEUQiFRU36KxjAhaTwjyWjsovCRC1rvQP/NJwNiqjtWa9fThAEePlFE
 vxbtgGy6/4bz6dFSbdV5IvV2UW7w/x6ghO+V0CIpT2yysJJhCp3GeKJPDhIKCpCWf6QR
 Ol1HOXyQQBqy3mIrhCWdzy2Kg8s+C5OEmWjBXZUsq8jFikyv0FT5zE+R0hbnDqz3+cbw
 UfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=fsIQWT8fp06IrEyHg92VCjuQxMGohN4oaxHAJmGohiA=;
 b=sw8XJG3pS/3y68jQP5GIqlDAy3sYwk9C48M+JD+EghZCS2IyIRQEr6QdPatdh+lbWp
 yTA/A25vB3YvabVl/3Raw0HsHU7IsX8syDfkG/yt6vDQojJZgfi9cUSeecz+kPmgZ6N1
 5Mqr2YgFDVJDB0649Ao538fgSACgKCiKjyTunq29LWsArmpSqkyR/IwJZvD8HI6pHLNA
 evN3D3GzAfN6eSU1opaVXEAOpLj1psqwP8lKXdOG7+jQ2pl0XKseztK406iJLpr6QZpN
 prwj8olNsPcmW8SbgDtU40lWP8MXqWz5MOGqkLhvZI8Xle4ZQmKVyb7d2pLMtW39CtNC
 QQrw==
X-Gm-Message-State: AA+aEWbFwsgD9m8e7J+grbkMdHTJfFKI6ans30JtJxMazL2e3pHC5/mG
 iYFmlG+PA0jHBIe9Cy4YqPGtURKr
X-Google-Smtp-Source: AFSGD/V4P3SefP2T7H3CnK34jJI1l7anQJQ0F4NWjcY4Tksz6vYkJpSXNTE9vBbcHSVwLUICFML/vg==
X-Received: by 2002:a63:fc05:: with SMTP id j5mr15133139pgi.434.1543878474785; 
 Mon, 03 Dec 2018 15:07:54 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id w136sm20112399pfd.169.2018.12.03.15.07.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 15:07:54 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 04 Dec 2018 09:37:48 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] powerpc/math-emu: Update macros from GCC
Date: Tue,  4 Dec 2018 09:37:46 +1030
Message-Id: <20181203230746.27196-1-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The add_ssaaaa, sub_ddmmss, umul_ppmm and udiv_qrnnd macros originate
from GCC's longlong.h which in turn was copied from GMP's longlong.h a
few decades ago.

This was found when compiling with clang:

   arch/powerpc/math-emu/fnmsub.c:46:2: error: invalid use of a cast in a
   inline asm context requiring an l-value: remove the cast or build with
   -fheinous-gnu-extensions
           FP_ADD_D(R, T, B);
           ^~~~~~~~~~~~~~~~~
   ...

   ./arch/powerpc/include/asm/sfp-machine.h:283:27: note: expanded from
   macro 'sub_ddmmss'
                  : "=r" ((USItype)(sh)),                                  \
                          ~~~~~~~~~~^~~

Segher points out: this was fixed in GCC over 16 years ago
( https://gcc.gnu.org/r56600 ), and in GMP (where it comes from)
presumably before that.

Update the add_ssaaaa, sub_ddmmss, umul_ppmm and udiv_qrnnd macros to
the latest GCC version in order to git rid of the invalid casts. These
were taken as-is from GCC's longlong in order to make future syncs
obvious. Other parts of sfp-machine.h were left as-is as the file
contains more features than present in longlong.h.

Link: https://github.com/ClangBuiltLinux/linux/issues/260
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v1:
 https://lore.kernel.org/linuxppc-dev/20181102033713.31916-1-joel@jms.id.au/
v2:
 Instead of setting the -fheinous-gnu-extensions for clang, fix the code.
v3:
 Sync with GCC version instead of GMP version
---
 arch/powerpc/include/asm/sfp-machine.h | 92 ++++++++------------------
 1 file changed, 29 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
index d89beaba26ff..8b957aabb826 100644
--- a/arch/powerpc/include/asm/sfp-machine.h
+++ b/arch/powerpc/include/asm/sfp-machine.h
@@ -213,30 +213,18 @@
  * respectively.  The result is placed in HIGH_SUM and LOW_SUM.  Overflow
  * (i.e. carry out) is not stored anywhere, and is lost.
  */
-#define add_ssaaaa(sh, sl, ah, al, bh, bl)				\
+#define add_ssaaaa(sh, sl, ah, al, bh, bl) \
   do {									\
     if (__builtin_constant_p (bh) && (bh) == 0)				\
-      __asm__ ("{a%I4|add%I4c} %1,%3,%4\n\t{aze|addze} %0,%2"		\
-	     : "=r" ((USItype)(sh)),					\
-	       "=&r" ((USItype)(sl))					\
-	     : "%r" ((USItype)(ah)),					\
-	       "%r" ((USItype)(al)),					\
-	       "rI" ((USItype)(bl)));					\
-    else if (__builtin_constant_p (bh) && (bh) ==~(USItype) 0)		\
-      __asm__ ("{a%I4|add%I4c} %1,%3,%4\n\t{ame|addme} %0,%2"		\
-	     : "=r" ((USItype)(sh)),					\
-	       "=&r" ((USItype)(sl))					\
-	     : "%r" ((USItype)(ah)),					\
-	       "%r" ((USItype)(al)),					\
-	       "rI" ((USItype)(bl)));					\
+      __asm__ ("add%I4c %1,%3,%4\n\taddze %0,%2"		\
+	     : "=r" (sh), "=&r" (sl) : "r" (ah), "%r" (al), "rI" (bl));\
+    else if (__builtin_constant_p (bh) && (bh) == ~(USItype) 0)		\
+      __asm__ ("add%I4c %1,%3,%4\n\taddme %0,%2"		\
+	     : "=r" (sh), "=&r" (sl) : "r" (ah), "%r" (al), "rI" (bl));\
     else								\
-      __asm__ ("{a%I5|add%I5c} %1,%4,%5\n\t{ae|adde} %0,%2,%3"		\
-	     : "=r" ((USItype)(sh)),					\
-	       "=&r" ((USItype)(sl))					\
-	     : "%r" ((USItype)(ah)),					\
-	       "r" ((USItype)(bh)),					\
-	       "%r" ((USItype)(al)),					\
-	       "rI" ((USItype)(bl)));					\
+      __asm__ ("add%I5c %1,%4,%5\n\tadde %0,%2,%3"		\
+	     : "=r" (sh), "=&r" (sl)					\
+	     : "%r" (ah), "r" (bh), "%r" (al), "rI" (bl));		\
   } while (0)
 
 /* sub_ddmmss is used in op-2.h and udivmodti4.c and should be equivalent to
@@ -248,44 +236,24 @@
  * and LOW_DIFFERENCE.  Overflow (i.e. carry out) is not stored anywhere,
  * and is lost.
  */
-#define sub_ddmmss(sh, sl, ah, al, bh, bl)				\
+#define sub_ddmmss(sh, sl, ah, al, bh, bl) \
   do {									\
     if (__builtin_constant_p (ah) && (ah) == 0)				\
-      __asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{sfze|subfze} %0,%2"	\
-	       : "=r" ((USItype)(sh)),					\
-		 "=&r" ((USItype)(sl))					\
-	       : "r" ((USItype)(bh)),					\
-		 "rI" ((USItype)(al)),					\
-		 "r" ((USItype)(bl)));					\
-    else if (__builtin_constant_p (ah) && (ah) ==~(USItype) 0)		\
-      __asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{sfme|subfme} %0,%2"	\
-	       : "=r" ((USItype)(sh)),					\
-		 "=&r" ((USItype)(sl))					\
-	       : "r" ((USItype)(bh)),					\
-		 "rI" ((USItype)(al)),					\
-		 "r" ((USItype)(bl)));					\
+      __asm__ ("subf%I3c %1,%4,%3\n\tsubfze %0,%2"	\
+	       : "=r" (sh), "=&r" (sl) : "r" (bh), "rI" (al), "r" (bl));\
+    else if (__builtin_constant_p (ah) && (ah) == ~(USItype) 0)		\
+      __asm__ ("subf%I3c %1,%4,%3\n\tsubfme %0,%2"	\
+	       : "=r" (sh), "=&r" (sl) : "r" (bh), "rI" (al), "r" (bl));\
     else if (__builtin_constant_p (bh) && (bh) == 0)			\
-      __asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{ame|addme} %0,%2"		\
-	       : "=r" ((USItype)(sh)),					\
-		 "=&r" ((USItype)(sl))					\
-	       : "r" ((USItype)(ah)),					\
-		 "rI" ((USItype)(al)),					\
-		 "r" ((USItype)(bl)));					\
-    else if (__builtin_constant_p (bh) && (bh) ==~(USItype) 0)		\
-      __asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{aze|addze} %0,%2"		\
-	       : "=r" ((USItype)(sh)),					\
-		 "=&r" ((USItype)(sl))					\
-	       : "r" ((USItype)(ah)),					\
-		 "rI" ((USItype)(al)),					\
-		 "r" ((USItype)(bl)));					\
+      __asm__ ("subf%I3c %1,%4,%3\n\taddme %0,%2"		\
+	       : "=r" (sh), "=&r" (sl) : "r" (ah), "rI" (al), "r" (bl));\
+    else if (__builtin_constant_p (bh) && (bh) == ~(USItype) 0)		\
+      __asm__ ("subf%I3c %1,%4,%3\n\taddze %0,%2"		\
+	       : "=r" (sh), "=&r" (sl) : "r" (ah), "rI" (al), "r" (bl));\
     else								\
-      __asm__ ("{sf%I4|subf%I4c} %1,%5,%4\n\t{sfe|subfe} %0,%3,%2"	\
-	       : "=r" ((USItype)(sh)),					\
-		 "=&r" ((USItype)(sl))					\
-	       : "r" ((USItype)(ah)),					\
-		 "r" ((USItype)(bh)),					\
-		 "rI" ((USItype)(al)),					\
-		 "r" ((USItype)(bl)));					\
+      __asm__ ("subf%I4c %1,%5,%4\n\tsubfe %0,%3,%2"	\
+	       : "=r" (sh), "=&r" (sl)					\
+	       : "r" (ah), "r" (bh), "rI" (al), "r" (bl));		\
   } while (0)
 
 /* asm fragments for mul and div */
@@ -294,13 +262,10 @@
  * UWtype integers MULTIPLER and MULTIPLICAND, and generates a two UWtype
  * word product in HIGH_PROD and LOW_PROD.
  */
-#define umul_ppmm(ph, pl, m0, m1)					\
+#define umul_ppmm(ph, pl, m0, m1) \
   do {									\
     USItype __m0 = (m0), __m1 = (m1);					\
-    __asm__ ("mulhwu %0,%1,%2"						\
-	     : "=r" ((USItype)(ph))					\
-	     : "%r" (__m0),						\
-               "r" (__m1));						\
+    __asm__ ("mulhwu %0,%1,%2" : "=r" (ph) : "%r" (m0), "r" (m1));	\
     (pl) = __m0 * __m1;							\
   } while (0)
 
@@ -312,9 +277,10 @@
  * significant bit of DENOMINATOR must be 1, then the pre-processor symbol
  * UDIV_NEEDS_NORMALIZATION is defined to 1.
  */
-#define udiv_qrnnd(q, r, n1, n0, d)					\
+#define udiv_qrnnd(q, r, n1, n0, d) \
   do {									\
-    UWtype __d1, __d0, __q1, __q0, __r1, __r0, __m;			\
+    UWtype __d1, __d0, __q1, __q0;					\
+    UWtype __r1, __r0, __m;						\
     __d1 = __ll_highpart (d);						\
     __d0 = __ll_lowpart (d);						\
 									\
@@ -325,7 +291,7 @@
     if (__r1 < __m)							\
       {									\
 	__q1--, __r1 += (d);						\
-	if (__r1 >= (d)) /* we didn't get carry when adding to __r1 */	\
+	if (__r1 >= (d)) /* i.e. we didn't get carry when adding to __r1 */\
 	  if (__r1 < __m)						\
 	    __q1--, __r1 += (d);					\
       }									\
-- 
2.19.1

