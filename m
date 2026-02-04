Return-Path: <linuxppc-dev+bounces-16603-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850A7EA7944
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 21:02:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5t8S4ZT8z2xJ5;
	Thu, 05 Feb 2026 08:02:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770238936;
	cv=none; b=HL2ljsMmBN8FcT9eMDS/qcaYwv068Z/zVn2Un3puJNT3A9jVxu5WHlpQgRLgA5RPXV53l6WeVStiCrVq6Ampl2sikqMexqQeE69yKWu8BVX9CybmXJfrjh+S0yA45FTFM1UGYmFoq+lbnPVRs95ELn1a1aqkn7c7gMHxwMr/r7HedgpvFDxbfTKYl5KgruASWfrFH7sTDl1Y2B3gdRbsM2Vu/ZQLJP/GvuguwGuGfTK/wAkaFQY7yYepCFTJUfDa8J2VI24pzmT5p8g7FYg4kcGZeI3VzvfgY3k/o+VPEs5iFyRFbeZsjypkNhBph+a2C/RF5GLvQNkG3JsXO4aheg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770238936; c=relaxed/relaxed;
	bh=2V/4lpM1tyoivo3E/+Mz0tbhlWt4A1di3YB0XAjK7Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WWl7p8Um2klAx0B6VJBAw7100fPYLcblx441FEQBdjZkdvBY+VcZKtIC+hisHneHjGAtn0nMAT18GlWi7bhSDbRA7XHxQqUzc27BdaiAPsKp+F4YQ1F3ZspekRKph9RLyCOTWmeDM4tZWGYn5uF0lzYbaVUv8+rbQrEXIQV5BnxxJLQldreJQk9q3aynTAHWSuopnkYsa1rq3/+CWBgVuBL+mPSPfw0p+ZFLZoX3dNpn5RR75HnK4OS1ZO4/GF7HgW5tAonntPxeXURWl85f4DeA/8zyIRAuzIeNqhGBtuJk+SDSsasPTcYXFpP0G+N/FBBQb+xKwwlmq3Aqsf//qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MDziLQ9z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MDziLQ9z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5t8R2JTFz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 08:02:15 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c551edc745eso62288a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 13:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770238928; x=1770843728; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2V/4lpM1tyoivo3E/+Mz0tbhlWt4A1di3YB0XAjK7Lg=;
        b=MDziLQ9zlL1jwugjkAoVCjtHesl5gLLkZl6+FZNZ/TKjrLrgGfYX15olVlzgFfFPIt
         UzdF+xpxjDPabHqObPJgiShKJ3ymexhG1dz5FXCxIQPCmwrNHZhJR6AO4HBGGT5Rwe0r
         iO3768QsePo9CLHDYabdNP/Vli/piIc3EPVYmhQ0Ja6wKfcOulm9CLaWCbyucjLvKYnR
         ld8NB3XkEGfDXT5o4Jdd7FjAixZDA0y7W6wEIR9KqWBiu/6s2Aec3bN7uZ8sCx72k9ca
         m8TNNDh9h70xjWOPtHGvHibC2KwK50WTTHFaHl5AGyWgGHnW97/IRsyKTSu0Yn4T1mS3
         AHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770238928; x=1770843728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2V/4lpM1tyoivo3E/+Mz0tbhlWt4A1di3YB0XAjK7Lg=;
        b=kT1qJYbzjbGr9hJowz2GfkygZG898Ye3y7aXrL6Nz0Vg7GSW2RQLQt8yq6Hs8yJhTG
         dARntRZkg6Uh1t9Dt/wLq+R8BTcgItlVPpBU6tqANw4Sqp+z7sq4MTTBbbICse/IenMJ
         8hOvNsS209UQIAin66bsgHL+9pnYQ6IIARThzvtG1TPVnqtuwqc2Aidlr3OtJ3+JiaCu
         BIub/0Bfx3jSudsGGh9ckoxsfm3c234IdgyjlWYwIyhSbScdBGG3VS1puOG1qYxBm7RX
         H1vGoglr06oJPAVfhHTYDeot+JLThERtlJOG1zymoW2aAhlQfuv3tY8vaM/0uk5hQldQ
         Ly9A==
X-Forwarded-Encrypted: i=1; AJvYcCUzu4uQTd2Lws0qTppsRElvC+fi7HNCTD55vvVkpLuRdPgDgFnBuauhflxcRfFJF3cFsTfYcBFzEwbKKJo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx5N5lDZGl7mc5UAgNVEdKl+zwnFlmPmdJOP5JAjoLQh+bOsnvX
	qVtfvrU5z2otJcDiJZHlnOJHooXdBqGZyDX/btaZIja03oSSrLNa+cBc
X-Gm-Gg: AZuq6aI+UaogM75UlNG9LqsEypAK8HoKg+dWUcyA70gWAEHgM8ZtxppMsSO5e16Ie4f
	EEIv7dgLhVi/8+8ovFF8eAVTnAGAKOf63x8bLOrUBt0iqzYKM+gjF6QEXplWCj90K9/fz3Mtijs
	VQk3p8X1X+QPucug0f5ryLcGp5cs7d6Jc/5yseLX3BNE5Venx8k2fPuAQemLDdfYVrtThaS/z7M
	zT9Edo82oYhOvndesTDHO5OfupwjiYVYrwYezmIDIImXejLY18fFwgZ8EBi3YGbzATk/oja/8ST
	EVBliDcXhe42dTJVZFmAwAcBHAjVQaYYwEIOzcn1CmoEBb9duLF7G/QE9fb3tUYxRJR5YxSaCeC
	O7yY8BcvAvANcia3f70HHy0UR0EqCfqPJ0viFUtnu8OXw1hB/Z6ueoKOuocvmrcq9xttRwqmey6
	8KfEvVsxNgQKfcONUjtiScBslJVTOSwVrl3XhiJ5LFpQol8jA6z6NnckVwYgJhX1S0
X-Received: by 2002:a17:90b:350d:b0:341:315:f4ed with SMTP id 98e67ed59e1d1-354870eb613mr3795120a91.10.1770238927704;
        Wed, 04 Feb 2026 13:02:07 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d1bd466sm3277977b3a.20.2026.02.04.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 13:02:07 -0800 (PST)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: linkmauve@linkmauve.fr,
	ojeda@kernel.org,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	corbet@lwn.net,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH V2 0/3] Rust support for powerpc
Date: Thu,  5 Feb 2026 02:31:22 +0530
Message-ID: <20260204210125.613350-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.52.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable experimental rust support for ppc64le and ppc32be. The patch for
ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has been 
merged over it. ppc32 needs some toolchain fixes mentioned in the patch 
`rust: Add PowerPC support` and the discussion for that is done here[1]. 

This has been tested on powernv9 hardware and power10 pseries qemu. I
I request Link to test the ppc32 part as i don't have a hardware to test
it out. 

[1] https://lore.kernel.org/all/20260204030507.8203-1-linkmauve@linkmauve.fr
[2] https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@gmail.com

Changelog:
V1 -> V2:
- jump label fix for rust has been moved to a separate patch
- PPC32 support has been taken
- rust support has been marked experimental
- target.json dependency has been removed
- HAVE_RUST now depends on CPU_LITTLE_ENDIAN for PPC64

Link Mauve (1):
  rust: Add PowerPC support

Mukesh Kumar Chaurasiya (IBM) (2):
  powerpc/jump_label: adjust inline asm to be consistent
  powerpc: Enable Rust for ppc64le

 Documentation/rust/arch-support.rst   |  1 +
 arch/powerpc/Kconfig                  |  1 +
 arch/powerpc/Makefile                 |  9 +++++++++
 arch/powerpc/include/asm/jump_label.h | 23 +++++++++++++----------
 rust/Makefile                         | 11 ++++++++++-
 5 files changed, 34 insertions(+), 11 deletions(-)

-- 
2.52.0


