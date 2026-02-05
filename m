Return-Path: <linuxppc-dev+bounces-16632-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB856ECD999
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Feb 2026 19:33:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6S7L0bB6z2yF1;
	Fri, 06 Feb 2026 06:33:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770319998;
	cv=none; b=RM5LlzbKWs6utmry9YByfCMWlEBh0HgD/5xtbrkqdBIxa5iRzXMgss1JO6YJg+qNdFCc1JBagD0JCe5epPxZ8vHMqUxMhsWqP6cvLfSJKdRQZXXVdaPbu4+gi7+eVf/dBro+I185aTzCZ64K/0Qu7Vh5L/Hk3VoIZL85nNGRV8vYB7m4vcP70377JqIzIHsP7vxCLCePeytaGYsGLfkioXmxPeG8J3hpgirOPapBdXYhBAw0hYr4AtZ7M6DazLx8zSWml/bBrQQoR0MnRBu0ELDDV+GmZgGn/OY2wiMnLK+vucztl71SuXSq129bO7nruraSJyPIcjWHF7P2blNGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770319998; c=relaxed/relaxed;
	bh=lutadAeu4e7BBQbDMidbIXRD6r3yDEuccAzMlRoMGq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZPu5sTMqyCPqHblV/KPZNpWGkz+s4GJ8EbJD9xvKrD+bTvVX62L21MgAqUykxc9yhalc9zRnyK3lV4iGvkccDTTuJMn3DAJ3gQ6eC4IAe1oBi4oLUnAg1syemvz3/qwbMMVzv5ZlGyEI8/+deeFG1m5toJxM/XtjeSjy/nC2nkgy5FfGCclnvJ12s2n/W14+0xfkIKHehb9fin2DBGGwTpLkMb4iPtudmW3xkia4qYgrsLDB/bAW2mLNT9MXC+gu6LgcYtvK4Hw4ire//zynIxcCjXgRKL46wisWE2muZJmy7Lq7ZpjzBKuYcuXgaeafvd4Qehd4m5OnRQ7Z2a9mmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gJp09Z1J; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gJp09Z1J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6S7J40cpz2xs4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 06:33:15 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-2b7da62b487so2441626eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 11:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770319992; x=1770924792; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lutadAeu4e7BBQbDMidbIXRD6r3yDEuccAzMlRoMGq0=;
        b=gJp09Z1Jwg6bHek+zXjKBm/iwq8gmYP+FSnMVhVxi/+JyBcrPLKq6HuLmdp2/KvDtJ
         nSKUdsc1eJg+ZaCdEIdHjqiSNXiDpM3XuarxHdRxpvfDoFKn2Sqf1Jcb5mivc/IofZLo
         ZYx1W4fLxXGzBXpEctrzWeBumjjzYNEV9MyBpCNiOHjdtOwurq76IuMK4qPs1p6+Kmvq
         8jxxB3ih/sYBZ+eOu9SrJX4Y1ygDbvba4Wi/0B5AQejz0fX2sa3Oh8XMRRuORNHPKbPW
         8mxpFAwGvJ56M+j9b5+EJGltC5byJb2bPhNnAfUz4kENEviFD5fS640hh4012WwEwtOA
         qDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770319992; x=1770924792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lutadAeu4e7BBQbDMidbIXRD6r3yDEuccAzMlRoMGq0=;
        b=pKyKQTTLNTuY1Rk07CJU+wpziIjgH1dIElHSsY5vyWkzR85zHweGZ9nuqB2pSgD+sR
         s1Y4tynhi1W0Jdjia866r1rKNXqtZTWrAaGG+NH1FUmjSrH3xlOXeH1nAaVOqI946dv2
         20QKKWgdyiUFuTr6kIgu9nN9NxYCN4sDbMCGLsOxL6F+AiCM5pQENzM8bdRVZPLiqACl
         mvnWcqZzERjqZ89q+k0NLojJtA8/Gp5HpLiLGS4McEXwH3U8duOywtQeSAOIOswQNn8C
         yreIA5U5d5vNeZz3Y4Y9+olXIb06aW4LxRrrdK95rC5YfuUcxEh1CfGCL/htJAo73lMF
         bnPA==
X-Forwarded-Encrypted: i=1; AJvYcCWHiSuTytCojCMs9xp95pSOQI8+DtH0kqfJ1GEg59+/ehM3jI7cNOjLgYyQUayJyBzaDCjCgEko3P/SSgo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy/RtUPvNbAIRA/jwsqtl61i7N7cjIZZHMmrPedz7tznI6kAW7o
	4DA6eAyaNoIuu4MBpsloGV4LvWm/lcSEPObOhI9ueZZ39e/XNkTsgYIlrngYzA==
X-Gm-Gg: AZuq6aKO9kHE5lQEp8TFGD5jG5akkAqBnpoeJx9G81rn6zsuGdQC8t0IefOiId1DthC
	GOdI6ee780GwUfA3waJdnkMTVe8FjYvFPMqSqtVTtRcHaPSRlqTGkaeLw9cv7IfjC513uSkVdRr
	8Vq8Zy+OIOwvVJmiqKn7M3+ksly2kNeeXOU5z4E+1gkD9SBIxqw6pV/JF7kaIJ9RTro+p7lyfAY
	CEgQ/DeNaV90TMcXVzxYU/f+Xg4N17MKZb3rVZV6Ho7YRJtBYYdyukJ9u3YW/I4mCru96JivIbk
	SlwMB8Mdtc5UHlouUjZ9GzUVY7v9NB+T5SaNCX3IQmEw04rROIlycuhbwLTvrO06tNZJpA8UjeU
	wH3PM5dR64PiDhGVP7jOSSqAuOIXSUYY0E7OlndSgaZcislWM1SIKTLBuYBWFmB0rh2iqIWgytf
	R0QNstddJbh348JrssUcm3OCB2tyjXIz5KvwwZ+Ap11l74LkmuPLjKyiuJuC2CxA==
X-Received: by 2002:a05:6a20:3d0a:b0:38d:f405:709e with SMTP id adf61e73a8af0-393ad307e51mr212862637.48.1770314685545;
        Thu, 05 Feb 2026 10:04:45 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.167.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5436c5sm99812a12.15.2026.02.05.10.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 10:04:45 -0800 (PST)
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
Subject: [PATCH V3 0/3] Rust support for powerpc
Date: Thu,  5 Feb 2026 23:34:26 +0530
Message-ID: <20260205180429.3280657-1-mkchauras@gmail.com>
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
V2 -> V3:
- Splited HAVE_RUST in 2 lines
- BINDGEN_TARGET_powerpc initialized before assigning the same to
  BINDGEN_TARGET
V2: https://lore.kernel.org/all/20260204210125.613350-1-mkchauras@gmail.com

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
 arch/powerpc/Kconfig                  |  2 ++
 arch/powerpc/Makefile                 |  9 +++++++++
 arch/powerpc/include/asm/jump_label.h | 23 +++++++++++++----------
 rust/Makefile                         | 12 +++++++++++-
 5 files changed, 36 insertions(+), 11 deletions(-)

-- 
2.52.0


