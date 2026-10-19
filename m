Return-Path: <linuxppc-dev+bounces-29681-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EDFCCF2D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 07:30:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7RzG00ZFz2xjN;
	Mon, 19 Oct 2026 18:30:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792375106;
	cv=none; b=SHVFcZtV3+y5LvrCT0ud72mEteGmO1/g6eihxbwRJir8YNgwMgLbtnZJyX8ujXQmRLiF3hqnnRqt/TLfL+p0jEGsR78R/vCjMva7eYCpGrWL+TFGjY0V0vOvKLOVUpZGT+Mz0FePs9FQqNFlYrx/uluBLuH1bGcyhFTNrWUhNT4sWdyx8ax9NlbnwXAX4XFwP7tjAsLbdR2fxPqjCm6HrmEBvoJnlvww98DIxH8E/LQQ305kAJodq17Ow9Dzxp7TEfTiRXtkyKOFBJDaReRaW7rO04GfKDGbHq5Aip7FmBbF4SjXFcSU4b5aWuZ9msynqutr8S2AwhAiosW4sz7V1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792375106; c=relaxed/relaxed;
	bh=DIsHUtJOv8JTVFKl2AI7iFPSk57QktOjQTbDJ2/Phac=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dc2uO4zpdKX9+8lbdRH8+nDrsZhvv9g+ujB+oXdhvamETc7eVlx52KZSArwTG4l7cBvs3YAytcbKlyKAy0qDt8BWodE5QtTfrU7rNLfyNitlvg3H2+HjCbz5n2oTD12tvyfAPYhMosGBmUdlWb0mX/MTcx9W5qfnP2KyS523EGgKv2JVltHkSMyVDjN5Bg7PQl0NewqtqGlRtZ/IrBVnG6vyxW7oycSqXKxGSpUGVf/wIJjCVsJSAWm/sbrgIabqLi60w+HXIhPBEWIdO1jMz1+H4GsJJY4Vx4BQEEAiXJynr0kGPLOKszNXfoV8xLY2FS1TkFwqSqN6wsAUaJeP6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OoGpqc6Y; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OoGpqc6Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7Jc06kj8z2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 12:58:24 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-3535a54bed9so2151908eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 18:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375101; x=1792979901; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DIsHUtJOv8JTVFKl2AI7iFPSk57QktOjQTbDJ2/Phac=;
        b=OoGpqc6YN4Hb/gpVQuNnWybCiSq7ktbI541lRcjRkMvQst7AHYVmL+0ZbZZi5qKEjN
         rO0dGleFpZqgxujO5vrnf+jKXliqesJe9+YxKUG1a5lC9y0cNQbXX+l4ffdROTa2hErf
         930QXPRXguviJa3ytihq3SD6bttutceabhQqW4VvB1rM8YF3UB0NHjRkkMJ/Ucv0/57W
         oXeiJjD0AYlWDC+nvz4OOacEgfgfNFLKVv3lokh/gKqQwz+PJF1AFzLSAjHg9E5RvTNc
         /DXVL450yyiYku2/fWmxQvgvEKo4hgCHMy8wBQ/0cMtE9dBkPEYrsLNa4KsBTI+v6aM2
         qr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375101; x=1792979901;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DIsHUtJOv8JTVFKl2AI7iFPSk57QktOjQTbDJ2/Phac=;
        b=Ux0VcUrh0IUWedKCZFHChKLGzKHvYz1136+LxMhn9GR2/+gm3UT7s5VXUdDLNQFCGx
         XjrHOTWkdUqRyRg5f62cUTxC7wCoW/0KQH/WBUMj1omjWU0Vs7A+SynagT2uAbWqO6wG
         /0fQ4J3OZevfEx690ID0kZKrvHus7WAcWnGwtiQa3eGcUFolKNs9kVt6TcJ5lCAGLpsM
         QOU1VxOdzhLeHbgqLpnUWcXrdMzsFtV91BLq1OMb41ZPYEFNvDO6VOE8boXzGpJaVy3A
         IZKKF4y90jwKDQ07s2IdSVDXUWH9CpHj2QhnKxBvTgzPUhdHhdxDlLxnLvtx6aPIpnjK
         JvTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxx36O6F+nirUQ4LYSJoWwEErmGpW56sk2+1Dqy9d1fbHKm4dl47ljh6MKwmMfN5wDRqF3oq0RuzU+brBY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLNaYbuPj+Hn46Ezc3MM5sLMm3To3qQZsYvgvQtWdyHE3Et3p3Z
	WiG1K3BXLhpHsyLUoxAOgseUGk39Mcau34FmpzundEfdv4d1m93PZAC5
X-Gm-Gg: AYBFou1+yxxPpczKF1V8tTKx1hb56x61nb1uIPAf+fXEbrBYYVG9SoXPiO+Wq/xUja1
	Q3nLggdVqQZw29NnaqN/eBwUR9mUCNHVr58ks7sifCjBsB9NR8CYYsddo4qVp+b/ouaPnxJAJag
	rPRbh7yuaxCcRsBdipY6msgrz5KVsfrdhdx2fSwVqwVRUqiQ/0a05qTJj9h96TbYGq6fH702ZMs
	cfgu1No/vNioWpqTc5gebhzhStN6UABT9OfHz3tBYOpyJgNW9Am0gwnFZ0dIawl7+HTWvd2V5lN
	4Pr7anbwHZbpkch7HQNQH6v+fq5EiPkIys7kneQaeAkTIpBGXqD0sqqyUFn5DBT18ObiVTMErsb
	jkND4COhNWE9KWGHRN+5UXaflz67/cxRQqTwoCrzjohm2WgsYIKptmNrD81x6v1VegFq3aIJUO3
	6xgM5+c45hWBF3J/q5bA37Ftk1etVMDuP+qWJQH9GCxPMhNHvIEM+N+Q0eQsrIe5ioD2c=
X-Received: by 2002:a05:7022:150e:b0:141:b2c3:d84e with SMTP id a92af1059eb24-185120a8bb4mr10990864c88.11.1792375100720;
        Sun, 18 Oct 2026 18:58:20 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm24177311c88.17.2026.10.18.18.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:58:19 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH 0/2] word-at-a-time: let KASAN see load_unaligned_zeropad()
Date: Mon, 19 Oct 2026 09:58:08 +0800
Message-Id: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIADB51WoC/x3NwQqDMAyA4VeRnBdoiwT0VcYOmY0aZK2kTsfEd
 1/Z8bv8/wlFTKVA35xgsmvRnCr8rYFh5jQJaqyG4AJ55zt8vic8skXkDRk3fQl+xfLKERcunJD
 H0JJriUQIamY1GfXzX9wf1/UDDOF2FXIAAAA=
To: Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, Peter Collingbourne <peter@pcc.me.uk>
X-Mailer: b4 0.13.0

load_unaligned_zeropad() is inline assembly, so KASAN and KCSAN never
see the word loads that sized_strscpy(), the dcache name compare, path
name hashing and x86 csum_partial() do through it. While reviewing a
strscpy() KASAN fix, Peter Collingbourne suggested checking the first
byte inside load_unaligned_zeropad() itself, as read_word_at_a_time()
does [1].

Patch 1 adds that check on the six architectures that implement
load_unaligned_zeropad(). Patch 2 adds a KASAN KUnit case for it.

This is independent of the strscpy() fix, which makes sized_strscpy()
copy byte by byte under software KASAN so that every byte it reads is
checked. Either can be applied without the other.

[1] https://lore.kernel.org/r/CAPQLkRhXZwozmfhNd_PEx1ihwdH1_5qthP6PANYJ_m-v9vfQTw@mail.gmail.com

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (2):
      word-at-a-time: check the first byte in load_unaligned_zeropad()
      kasan/test: cover load_unaligned_zeropad()

 arch/arm/include/asm/word-at-a-time.h              |  7 +++++++
 arch/arm64/include/asm/word-at-a-time.h            |  7 +++++++
 arch/powerpc/include/asm/word-at-a-time.h          |  6 ++++++
 arch/riscv/include/asm/word-at-a-time.h            |  6 ++++++
 arch/s390/include/asm/word-at-a-time.h             |  6 ++++++
 arch/x86/include/asm/word-at-a-time.h              |  6 ++++++
 mm/kasan/kasan_test_c.c                            | 24 ++++++++++++++++++++++
 .../powerpc/primitives/linux/kasan-checks.h        |  3 +++
 .../powerpc/primitives/linux/kcsan-checks.h        |  3 +++
 9 files changed, 68 insertions(+)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261019-bug-word-at-a-time-zeropad-kasan-af2460466ee6

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


