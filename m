Return-Path: <linuxppc-dev+bounces-25313-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C504FC55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 23:40:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDY8P6Y0Fz307v;
	Tue, 04 Aug 2026 09:40:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785800453;
	cv=none; b=R6KsDRvWl9I+93Uk05BbcVzo0dWtU3ewfhaGxDHVGeR3Ruz3ZYYJXGUvCpb3A4Ja4rOPhjJ4gXftfG88wpbYnmez86c18U9EPJ3pepqv9BueqfHgUG87u1lWqJ3hMrCfxp7cwgp0UFh2+dELewykTiTLADkYTc0fc1Rnd44+uTe4BUuHRD0zgfUQyBzTiQDZ4zfqKyfoZaXqj2YhP9kMgmfLoA9mmLxIjMfZSUyMken7KRsb15kSID3y/Z9hr/zHIKrfxqV9i0QmsMnQsqPEbMlG3s5TF1HsKkvKXLaQDIL3pJIeM9yPs74b6srD40mNRPio56CExgIU4SsmQo/c/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785800453; c=relaxed/relaxed;
	bh=U+7Ru6jZFSxz7ibFdQEbmpjCAkPd7K+3B96IxICOxK8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eGxJKoy15CSm6/b9DSJDbxsr79lTAqYd4oaqlXt/8r3EjTKgntWu8nebYGGsnnFmawq03riqH3ryOAh0Amubbl7+KAlpowqFFenCIc1yH1VJYobrnP4642onPL/K9Bc2TUIzJBMW/MSIqxjpxAQDMH9d9E1cEGRwoumKOrl1R+P3v8s5Et20MF3fkQrwduvIDfCmEuZPAEHFAw6TizrzuhFI008smUQREIVcvRF4UxArABbH8n5Imm1E1UX4dlyURuAUJpoTqiyeKw5YEVNXut5DF2OgOGUAQK1zDc7gcei6xG5TXVxcAswdmurRALLtJ4cAGVWx64njz7bLw5Ldrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EtjHvJlz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EtjHvJlz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com [IPv6:2607:f8b0:4864:20::b12f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDY8N01PVz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 09:40:50 +1000 (AEST)
Received: by mail-yx1-xb12f.google.com with SMTP id 956f58d0204a3-6688acd1a51so5760706d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785800448; x=1786405248; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U+7Ru6jZFSxz7ibFdQEbmpjCAkPd7K+3B96IxICOxK8=;
        b=EtjHvJlzMz17UMx3p2duWsNBOgJkUAcs4RLBhVVSptXFvGtTFytlZ81dLMJpof7QRj
         sXQRa7S10rWwO/M4UZL29QVtTeDdkDZ49KnGHTGIRi7MaWo+Vwzl8JKha/OgX4AIA7bf
         uEFXD3UI4oKJ5JFIHXIj7oEcbGQER5FuXBRCkUq/K+Gd1fYvlu5X7HE3wlnk/ZIpGHOe
         HF+prRygmtZsASEfd+GsvXcCAq/jvrDBlokKcOX314SUL0JTQKcJOre4e9UPbWdtJzjL
         1pZnvOD07nZc+Pi9vRGLJD0ahm8E6N1FFCdEoxuMpfew24d9EGQqfqjQrPtgiFS4Yf91
         scNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785800448; x=1786405248;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U+7Ru6jZFSxz7ibFdQEbmpjCAkPd7K+3B96IxICOxK8=;
        b=pGYLf5c9+gb7Z6PkAk7YIoaOr14FHIvB8x21jbB+Oh9pKVtUbwKz8kpH36/AO8nhuS
         XWDG/g2qrnPPh2jwhk+ajhMakT+lfsXv6o5a9owfu/EuoEdf0MCPicIuPjB+ZsG9B8tg
         Z36KU0ZZOkZeytCzvr53cnlFo+FwjK7sMSVllOmhAcmolfIMyMEQd0qYph11/fAW/o3X
         +xUrlBp+e357qj399qdJCII/fPO0DyZHiVkoxo7wE3lNOESKIOPb3/sDYeHFIxk7hTpF
         fEN2kLAo+ZrrNjHBNCbLgrMLnTT22mRiPhomdWSI3LqpDXVpi/E5krCJfjxnzRnk+EyT
         yyvg==
X-Forwarded-Encrypted: i=1; AHgh+RpTHdQgHhNM+/zs+d1+l4Pg5G/+THnxT6WLL/k0pKZyq8SspfraPAoNLo3+DMl2r/I+khn/G3gJFiG+Zaw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyz3RJ/S3CQGGnSuAFIP5kyDDUgqrsdt0w6bJX2gHAI9o+tIYrW
	Mil+/ODFgHici6nfXmbZME6dO4NCLLUDFK4GDCPP6nsCEAR/xVyBkeIw
X-Gm-Gg: AR+sD10KClL/rc4oJfx+woDcuSEW2F5zUiHOax0DAl1dnmE2KSnIAt8FI30lWgnorrF
	0/U0ULRBnVorhpx0yN6g19zRMxFQyuJNNslUmoFKDBA410rMoplYzsgP3at3IN9A9ymLsFUbRdJ
	8X39ESPerfr1gHpNi2BfRh2yxhmrdKB9K7vvxdlm+q21K57wpPUImxENT9MnpA2hwAcO4c6//X/
	89hI/fGmw1eU6mlmX5nChF7Nq6hOquBegT33Lp8iWUdVb4JGvIb5wXZ6j1XYjjqbJzmy46PVZA4
	1B58q4a5+08FSIIxVXGnyy/EMUu1pAPKqJq1iOWOGbZv61OM6FSCyNRA4CB0jXD32tdcDsRY+US
	9Qudjm5mTTs9g3jkmOZxTMIT0Ss6JtxStn0eWLvhv4CtHYHSb23ZoU23Wx8IW2h/UDW01aZInG5
	+Mf1d3lefVCe2VZPgsAeshm/uQvuRmfnGH1o3ppnSp/0xdISRlgm9GPIMGN6WF+bKIwqINFhw7
X-Received: by 2002:a53:c745:0:b0:668:43a3:9db2 with SMTP id 956f58d0204a3-6694f17d897mr10635045d50.32.1785800447478;
        Mon, 03 Aug 2026 16:40:47 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948b98babsm6681654d50.0.2026.08.03.16.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 16:40:45 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/3] alpha: fix floating-point exception state handling
Date: Mon, 03 Aug 2026 19:40:44 -0400
Message-Id: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bsGKsvpKdBBbcyFMNEIQ/550H
 JiZDJECU4S1yRDo5ci3q9C1DWir3EnIR2XoRT+JWQyoLm8VGo+UNPmn6hFHLeWxkBilGqCWPpD
 h9F+3vZQP4EcgZ2UAAAA=
X-Change-ID: 20260803-alpha-fp-exceptions-5c77d9e057a3
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

Three fixes to floating-point exception handling on Alpha.  The first two
are a pair and should be applied and backported together; each commit
message explains why taking one alone is worse than taking neither.

The first fixes ieee_swcr_to_fpcr() setting FPCR_DNOD unconditionally,
which disabled denormal operand traps for every process using the default
FPU settings.  Instructions built with the software completion suffix
never reached the kernel emulator, and the hardware silently substituted
zero for denormal operands.  This affects anything built with -mieee,
glibc included.

The second stops hardware-fabricated exception bits from reaching user
space.  On EV6 and later the hardware writes exception status into the
FPCR before delivering a software completion trap, and those bits can be
wrong for the instruction that trapped.  alpha_fp_emul() only wrote the
FPCR back when soft-fp raised something, so whenever it found the
instruction exact the fabricated bits stayed visible to fetestexcept().
The exception summary register is now passed down so the handler can tell
which exceptions the hardware attributed to the trapping instruction.

The third makes the emulation determine tininess after rounding, as the
hardware does.  soft-fp had no notion of the distinction and always
determined it before rounding, so an operation that trapped for software
completion could report an underflow the same operation would not report
when it did not trap.  The two paths disagreed on the same machine, which
IEEE 754 does not allow.  This adds _FP_TININESS_AFTER_ROUNDING to the
shared soft-fp code, as glibc's copy already has, and sets it for Alpha
only.  It defaults to zero, so powerpc, sh and sparc are unchanged.

Measured with the glibc testsuite on an UP1500 (EV67), with
CONFIG_MATHEMU=y.  Without that option alpha_fp_emul() is not built at
all and roughly 830 math tests fail on their own, so it is a prerequisite
for any of this being reachable.

  glibc make check subdirs=math

  before                              831 failures
  after patch 1                        48 failures
  after patch 2                        28 failures
  after patch 3 (and glibc fixes)       3 failures

The three that remain are a GCC bug: a long double to float cast on Alpha
is lowered as quad to double to float, but C requires it to round once,
and the intermediate can land on a float halfway point.  Two glibc fixes
are being posted separately to libc-alpha.

stdlib/tst-tininess passes, which confirms the hardware determines
tininess after rounding for the results it produces itself.

The shared soft-fp change was compile tested on sparc32, sparc64 and
ppc32 in addition to alpha.  Only Alpha was tested at runtime; elsewhere
the new code is unreachable by default.

---
Matt Turner (3):
      alpha: fix ieee_swcr_to_fpcr setting FPCR_DNOD unconditionally
      alpha: don't leak hardware-fabricated FP exception bits to user space
      alpha: determine tininess after rounding in the FP emulation

 arch/alpha/include/asm/sfp-machine.h |  4 ++
 arch/alpha/include/uapi/asm/fpu.h    |  8 +++-
 arch/alpha/kernel/traps.c            |  6 +--
 arch/alpha/math-emu/math.c           | 88 +++++++++++++++++++++++++++++++-----
 include/math-emu/op-common.h         | 23 +++++++++-
 include/math-emu/soft-fp.h           |  8 ++++
 6 files changed, 119 insertions(+), 18 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260803-alpha-fp-exceptions-5c77d9e057a3

Best regards,
-- 
Matt Turner <mattst88@gmail.com>


