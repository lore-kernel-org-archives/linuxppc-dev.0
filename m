Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE58C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 015D7224E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWvqhp0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015D7224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vpmj64KFzF3PW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 13:47:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rWvqhp0v";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rWvqhp0v"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vpjm2kxjzF3Fg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 13:44:28 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id g7-v6so7090154pfo.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 18:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=odJvOv7D65GdhcuF0iG/SITKTfD5A0xMKLGldMtvhs0=;
 b=rWvqhp0vVAldIcVLNuptQL/ua1hNoNvKSJ5ur7Qil8z5m9roorRbpgMWsEkPxkShdn
 g+wHMlDpBY0yg7UNcKo8SwBpR5p/0HU4W0hLbStPaH3Gqyh/MMgn9ZOrfcfgtkY4AeEl
 JaRgqvJZCqASjyFb3CPmiU2A49O3JiJLMAU5Cj6L2EZDWBglWK9gZlz1Qq/0gyo8sh/v
 gsqmSi2MMJI3M7K6qR+S+mqirpFZJndpDw7U3NhRfOSbrEt5ljR18g/m5tRAIZIh9ofi
 DPWebtCL/2KtkNolPmoikFTtm2MYvqSvFL4TrcICvrMD3ZUXfVHrpIvfAvHy3V36DRm0
 30uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=odJvOv7D65GdhcuF0iG/SITKTfD5A0xMKLGldMtvhs0=;
 b=R7K1nenc6b5Hdcwc3HhWKvqNdBOJ/KGgDo8TQZkN7/gWJ/Mfdx6rV12YrhEanax9cK
 HHDj/rtzeF4OM8AN9eUagYDm9f2Q+QItSpJT5MmApcQScSbi9qH3stUyOQ/k/l4qKKUF
 HCiJLJFOswuEHtTywiBklDCamlGWmcGq9EWTpFOk4Sgt3MudGPsD3JM/RP8oQZajKza3
 /uGjfVu564DjHYe4a0NU059kFguPD0ficfLIJW0krq/aD970HbhqIggOmnxJfaMFTgeS
 N1Bw19CP9PulyrTrAtoz/rfOX+yBKNOpCXRa0hC+haBAs/XtS83ajMYR5ptqLYXs9fFi
 tPRg==
X-Gm-Message-State: AGRZ1gJC4fKMRMbsJDjCCDK9ORf7gsDWSL2FgrG8amLmQR06lIlgWb8q
 uPyqu9iKfDkKQ1Hz8BRtD13fTzb3
X-Google-Smtp-Source: AJdET5epjWPbYCasmcoj8ksd8n1jWYm86IfVjVMuAsqjbeOqyD9qVUJ/Q++SscsugtCTDu5bloniyQ==
X-Received: by 2002:a63:4a4d:: with SMTP id j13mr107309pgl.127.1542163465667; 
 Tue, 13 Nov 2018 18:44:25 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id f64sm20061520pfh.0.2018.11.13.18.44.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 13 Nov 2018 18:44:24 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Wed, 14 Nov 2018 13:14:19 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/math-emu: Update macros from gmp-6.1.2
Date: Wed, 14 Nov 2018 13:14:12 +1030
Message-Id: <20181114024412.19368-1-joel@jms.id.au>
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
from GMP's longlong.h.
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

Update to the latest version in order to git rid of the invalid casts.

The only functional change I noticed was this in udiv_qrnnd.

    __r1 = (n1) % __d1;
    __q1 = (n1) / __d1;

Becomes this:

    __q1 = (n1) / __d1;
    __r1 = (n1) - __q1 * __d1;

This is equivalent as it instead of calculating the remainder
using modulo, it uses the result of integer division to subtract the
count of 'whole' d1 from r1.

Link: https://github.com/ClangBuiltLinux/linux/issues/260
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v1:
 https://lore.kernel.org/linuxppc-dev/20181102033713.31916-1-joel@jms.id.au/
v2:
 Instead of setting the -fheinous-gnu-extensions for clang, fix the code.

 arch/powerpc/include/asm/sfp-machine.h | 99 +++++++++-----------------
 1 file changed, 32 insertions(+), 67 deletions(-)

diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
index d89beaba26ff..a6353d9dd5ba 100644
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
+      __asm__ ("add%I4c %1,%3,%4\n\taddze %0,%2"			\
+	     : "=r" (sh), "=&r" (sl) : "r" (ah), "%r" (al), "rI" (bl));	\
+    else if (__builtin_constant_p (bh) && (bh) == ~(USItype) 0)		\
+      __asm__ ("add%I4c %1,%3,%4\n\taddme %0,%2"			\
+	     : "=r" (sh), "=&r" (sl) : "r" (ah), "%r" (al), "rI" (bl));	\
     else								\
-      __asm__ ("{a%I5|add%I5c} %1,%4,%5\n\t{ae|adde} %0,%2,%3"		\
-	     : "=r" ((USItype)(sh)),					\
-	       "=&r" ((USItype)(sl))					\
-	     : "%r" ((USItype)(ah)),					\
-	       "r" ((USItype)(bh)),					\
-	       "%r" ((USItype)(al)),					\
-	       "rI" ((USItype)(bl)));					\
+      __asm__ ("add%I5c %1,%4,%5\n\tadde %0,%2,%3"			\
+	     : "=r" (sh), "=&r" (sl)					\
+	     : "r" (ah), "r" (bh), "%r" (al), "rI" (bl));		\
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
+      __asm__ ("subf%I3c %1,%4,%3\n\tsubfze %0,%2"			\
+	       : "=r" (sh), "=&r" (sl) : "r" (bh), "rI" (al), "r" (bl));\
+    else if (__builtin_constant_p (ah) && (ah) == ~(USItype) 0)		\
+      __asm__ ("subf%I3c %1,%4,%3\n\tsubfme %0,%2"			\
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
+      __asm__ ("subf%I3c %1,%4,%3\n\taddme %0,%2"			\
+	       : "=r" (sh), "=&r" (sl) : "r" (ah), "rI" (al), "r" (bl));\
+    else if (__builtin_constant_p (bh) && (bh) == ~(USItype) 0)		\
+      __asm__ ("subf%I3c %1,%4,%3\n\taddze %0,%2"			\
+	       : "=r" (sh), "=&r" (sl) : "r" (ah), "rI" (al), "r" (bl));\
     else								\
-      __asm__ ("{sf%I4|subf%I4c} %1,%5,%4\n\t{sfe|subfe} %0,%3,%2"	\
-	       : "=r" ((USItype)(sh)),					\
-		 "=&r" ((USItype)(sl))					\
-	       : "r" ((USItype)(ah)),					\
-		 "r" ((USItype)(bh)),					\
-		 "rI" ((USItype)(al)),					\
-		 "r" ((USItype)(bl)));					\
+      __asm__ ("subf%I4c %1,%5,%4\n\tsubfe %0,%3,%2"			\
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
 
@@ -312,28 +277,28 @@
  * significant bit of DENOMINATOR must be 1, then the pre-processor symbol
  * UDIV_NEEDS_NORMALIZATION is defined to 1.
  */
-#define udiv_qrnnd(q, r, n1, n0, d)					\
+#define udiv_qrnnd(q, r, n1, n0, d) \
   do {									\
     UWtype __d1, __d0, __q1, __q0, __r1, __r0, __m;			\
     __d1 = __ll_highpart (d);						\
     __d0 = __ll_lowpart (d);						\
 									\
-    __r1 = (n1) % __d1;							\
     __q1 = (n1) / __d1;							\
-    __m = (UWtype) __q1 * __d0;						\
+    __r1 = (n1) - __q1 * __d1;						\
+    __m = __q1 * __d0;							\
     __r1 = __r1 * __ll_B | __ll_highpart (n0);				\
     if (__r1 < __m)							\
       {									\
 	__q1--, __r1 += (d);						\
-	if (__r1 >= (d)) /* we didn't get carry when adding to __r1 */	\
+	if (__r1 >= (d)) /* i.e. we didn't get carry when adding to __r1 */\
 	  if (__r1 < __m)						\
 	    __q1--, __r1 += (d);					\
       }									\
     __r1 -= __m;							\
 									\
-    __r0 = __r1 % __d1;							\
     __q0 = __r1 / __d1;							\
-    __m = (UWtype) __q0 * __d0;						\
+    __r0 = __r1  - __q0 * __d1;						\
+    __m = __q0 * __d0;							\
     __r0 = __r0 * __ll_B | __ll_lowpart (n0);				\
     if (__r0 < __m)							\
       {									\
@@ -344,7 +309,7 @@
       }									\
     __r0 -= __m;							\
 									\
-    (q) = (UWtype) __q1 * __ll_B | __q0;				\
+    (q) = __q1 * __ll_B | __q0;						\
     (r) = __r0;								\
   } while (0)
 
-- 
2.19.1

