Return-Path: <linuxppc-dev+bounces-25316-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC29C55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 23:41:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDY8S3QY9z3brP;
	Tue, 04 Aug 2026 09:40:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785800456;
	cv=none; b=OAn0VW9eaulYc10RNOlfbGef0JXqMrpMlfY9ro4ksZYAgkPshY8z82/Du1X3oa+3BENC2Em1O/9tKD7cZfzzuLz4+OKi71F9AqwH0Xird0HFJULafbHJJy65CxY5rbKG3LkMi0AklRDJKCDheqgFzk6e6mZfMZr14ULbqRZVIMk6HS98T+wTqgdbd9BEo3ykBJXKQskXjldoAxNWadhFHvAT38QirSDzCRmz2ElKZQKj2naueCb9KVwImQbQ0QZ5acPVr/c4MM3+Tj7Dq14e9Jg6V3S9b4LLdJlzSZ8cNY8x7wKZlVMeAt4P3ldMC+gSiJD7YYoEfwTYS9rOm0DViw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785800456; c=relaxed/relaxed;
	bh=5Jv9folb9jOklDdXuGWBrNQv0WmbSuUwS788YmUFoOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCcXePCBk8+I/kB/8GbG6Z4li0lxkqo/K2Ronv9NfbHBfyuxZxfBFyF0ZTt3KUnGwulIC/CH+ZiZEmgyhszqUxjHFbJyR93MB4wpper6Ipc3RXV4jD3DlwEDfQQVVpj7QShq3kz0aJ6DPzLMZU7tqV7/JQ2gMn/cUFAffFnIsqycKQR4PQ1xRzkQC3RUgQIlXvEIEl+YoHngG+c2ZldB4TNF148rADNixA8DZkH7/K9FIc6im89x57vRoDlrZLIIc8dlypwLAiEfYWYhErAdv0/6OFa1dy+EbFXvfQWghHslwRvpHQSPaOIHYS1ssIdrEjJJZgsnHy7lrNeuY6+FgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m1K04jXE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m1K04jXE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDY8R32BTz3bSn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 09:40:54 +1000 (AEST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-81f64e8dfbcso54735807b3.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785800452; x=1786405252; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Jv9folb9jOklDdXuGWBrNQv0WmbSuUwS788YmUFoOM=;
        b=m1K04jXEyyx716NPGG3U2gH4jUtDoGzxzr5KmxpFuKo2L418NxFlvoUyxnOMlNyskp
         LbCECn9dXA8wR/ymuEe+CDPs/snOCvq79wTGOUV5lkcGFM1J78zJvTP8KsFg2Aoo4oIO
         bSjVpusv/8GhisSQ36yBY3Yg5mDL6iLetDd+XtkEyCkcoKCI/3HcNyOElCPrqAV+Ud5O
         OWs0mhsBTOVWcuikMQjApUWchNZ092OuNHsE9LUTjhldyaqc0PCulcyF5DbakIusMxJp
         9w71fmUZN9x3wUZgUHJbY5uI36cVlvibBozGxsphiRjXAuG1lY2Ymb0r2EHOVyePeFUN
         c2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785800452; x=1786405252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Jv9folb9jOklDdXuGWBrNQv0WmbSuUwS788YmUFoOM=;
        b=O7ukPvtVaLliXoBO+Qukp9wa5GhGFj5jfqHhyAsE4t55UEsi8SQSlk8biyiVSptdlD
         IPoe597Sw1wxocnr8fKTYQkFFWWR8Jtgv2xgNn45eO9c/2/+nBLHQi4FmHZWr/2RqC41
         Oc5vNb+ntx/xghK2X2yjR1Bi8q9bwW3o+uU/ZGBMgAeH7yk5LE8Z2EB/J/gdpYpBFcPJ
         +nXomoOWm2YsnpYJHFYD7A0Adc5qOtE/7EaiyDOwZfbAwP+alAPpkj2me113I3v6G9CD
         OQa4/HuoK3OdqnXxH/JLwgG2mYFjU8BfP3NXJgOOTqq/VwY7Kb1WV3QiAKeR0t0KKGaQ
         hVWw==
X-Forwarded-Encrypted: i=1; AHgh+RqStMTrfuxHNVA6hWLd0eCjCURdCt2Y58YMa57pNrPoi99Ol/bK4vIbsqMdX99Vl4F1FoE8xoCZGnYtloI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFrSCdEbslr5R5bTLjv3YudQH/veonhDkQfpCxMJZyuUqAbpce
	ErD+f+yOWr/kgbUvM8OUMf7OKenMPNOVoA3ZghTbWp010mT/rTPstHsK
X-Gm-Gg: AR+sD132lp1Yt6+pkZGsP80JXjKxXwb1mKWOYnKjADgtqybD3L69XTXqiq/Roh96WP+
	avQ63Dho+ky4btFStyVs0hR9hDtX0LpS8KME+Onv83NQvyPC6xped/ZReMGA9AaZIxF3NECQGp4
	zySbXNjKoZYQmKxZZnF22R6WUaGDQdihhz5SyFWxIOp2PgaNvgnFN8kXgR0sG3+ANWWzhGFaEda
	tTm7OpXwLn4wCAxsJTlc1eA7JQWsjlgwx+G0ou+2AnhH7ANLJdqBHsJ3zodw0ghEqg+6T+6GGLk
	IRLpipkXy/Cj8GKgOvDyYBz9CR7pEk2+4q/S4ZzTyn39AuOH5h01LLhJJz86+7iuXwlKuRVSLbb
	qb93UnVm3FhG93ALPdjVwgKriMkFx9P8dzMI0VrwJtnJX0S5vi+B+H7/1zBNdNziWDxdjXgn4Vg
	EkgF0qrSHDNCOc4Z4p0cNpE7mvlrQQGn8i0yN3YgCU6YgC284TdNeYhBqRFX0VXaYy+Omk0sU=
X-Received: by 2002:a05:690c:ecf:b0:814:7a54:3a93 with SMTP id 00721157ae682-81fd4b372d9mr163845447b3.23.1785800452413;
        Mon, 03 Aug 2026 16:40:52 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d68b0sm65571757b3.28.2026.08.03.16.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 16:40:51 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 03 Aug 2026 19:40:47 -0400
Subject: [PATCH 3/3] alpha: determine tininess after rounding in the FP
 emulation
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com>
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
In-Reply-To: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

IEEE 754 lets an architecture determine tininess of a floating-point
result either before or after rounding, but requires the same choice for
every operation.  Alpha determines it after rounding, and stdlib's
tst-tininess confirms the hardware does so for the results it produces
itself.

The soft-fp emulation has no notion of the distinction and always
determines tininess before rounding, so a result that the hardware would
not consider tiny is reported as underflowing whenever the instruction
happens to trap for software completion.  The two paths then disagree on
the same machine.  A multiply of the largest subnormal double by
1 + 2^-52 rounds up to the smallest normal and raises no underflow when
the operands are normal, but raises it when an operand is subnormal and
the instruction traps:

  glibc math testsuite, test-float32x-float64-mul:
    Failure: mul_double (0x3.ffffffffffffcp-1024, 0x1.0000000000001p+0):
    Exception "Underflow" set

Add _FP_TININESS_AFTER_ROUNDING, as glibc's copy of soft-fp has, and set
it for alpha.  It determines tininess by rounding a copy of the result as
if the exponent range were unbounded, which is what the definition asks
for; a plain check of whether the rounded result came out normal is not
equivalent and would be wrong for values that stay tiny under an
unbounded exponent range but round up to the smallest normal in the
subnormal grid.  The macro defaults to zero, so powerpc, sh and sparc
keep determining tininess before rounding as they do now.

Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/sfp-machine.h |  4 ++++
 include/math-emu/op-common.h         | 23 +++++++++++++++++++++--
 include/math-emu/soft-fp.h           |  8 ++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/asm/sfp-machine.h b/arch/alpha/include/asm/sfp-machine.h
index 5fe63afbd474..bff1ad963c68 100644
--- a/arch/alpha/include/asm/sfp-machine.h
+++ b/arch/alpha/include/asm/sfp-machine.h
@@ -59,6 +59,10 @@
     R##_c = FP_CLS_NAN;						\
   } while (0)
 
+/* Alpha determines tininess after rounding, so the emulation must do the
+   same as the hardware does for the results it produces itself.  */
+#define _FP_TININESS_AFTER_ROUNDING	1
+
 /* Obtain the current rounding mode. */
 #define FP_ROUNDMODE	mode
 #define FP_RND_NEAREST	(FPCR_DYN_NORMAL >> FPCR_DYN_SHIFT)
diff --git a/include/math-emu/op-common.h b/include/math-emu/op-common.h
index 8ce066c035cf..1d1ce5c08efc 100644
--- a/include/math-emu/op-common.h
+++ b/include/math-emu/op-common.h
@@ -135,6 +135,24 @@ do {								\
     else							\
       {								\
 	/* we've got a denormalized number */			\
+	int _FP_PACK_CANONICAL_is_tiny = 1;			\
+	if (_FP_TININESS_AFTER_ROUNDING && X##_e == 0)		\
+	  {							\
+	    /* Architectures that detect tininess after rounding	\
+	       only signal underflow if the result is still		\
+	       subnormal once rounded as if the exponent range	\
+	       were unbounded.  Round a copy to find out.  */	\
+	    FP_DECL_##fs(_FP_PACK_CANONICAL_T);			\
+	    /* The class field is not used by the rounding below,	\
+	       and is unused entirely where this block is dead.  */	\
+	    (void)_FP_PACK_CANONICAL_T##_c;			\
+	    _FP_FRAC_COPY_##wc(_FP_PACK_CANONICAL_T, X);	\
+	    _FP_PACK_CANONICAL_T##_s = X##_s;			\
+	    _FP_PACK_CANONICAL_T##_e = X##_e;			\
+	    _FP_ROUND(wc, _FP_PACK_CANONICAL_T);		\
+	    if (_FP_FRAC_OVERP_##wc(fs, _FP_PACK_CANONICAL_T))	\
+	      _FP_PACK_CANONICAL_is_tiny = 0;			\
+	  }							\
 	X##_e = -X##_e + 1;					\
 	if (X##_e <= _FP_WFRACBITS_##fs)			\
 	  {							\
@@ -161,8 +179,9 @@ do {								\
 		    _FP_FRAC_SRL_##wc(X, _FP_WORKBITS);		\
 		  }						\
 	      }							\
-	    if ((FP_CUR_EXCEPTIONS & FP_EX_INEXACT) ||		\
-		(FP_TRAPPING_EXCEPTIONS & FP_EX_UNDERFLOW))	\
+	    if (_FP_PACK_CANONICAL_is_tiny			\
+		&& ((FP_CUR_EXCEPTIONS & FP_EX_INEXACT) ||	\
+		    (FP_TRAPPING_EXCEPTIONS & FP_EX_UNDERFLOW)))	\
 		FP_SET_EXCEPTION(FP_EX_UNDERFLOW);		\
 	  }							\
 	else							\
diff --git a/include/math-emu/soft-fp.h b/include/math-emu/soft-fp.h
index 5650c1628383..02ada0a9fca1 100644
--- a/include/math-emu/soft-fp.h
+++ b/include/math-emu/soft-fp.h
@@ -31,6 +31,14 @@
 #include <endian.h>
 #endif
 
+/* Whether the architecture determines tininess of a floating-point
+   result after rounding rather than before it.  IEEE 754 permits either
+   but requires the same choice for every operation, so this has to agree
+   with what the hardware does for the results it produces itself.  */
+#ifndef _FP_TININESS_AFTER_ROUNDING
+#define _FP_TININESS_AFTER_ROUNDING	0
+#endif
+
 #define _FP_WORKBITS		3
 #define _FP_WORK_LSB		((_FP_W_TYPE)1 << 3)
 #define _FP_WORK_ROUND		((_FP_W_TYPE)1 << 2)

-- 
2.54.0


