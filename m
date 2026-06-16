Return-Path: <linuxppc-dev+bounces-22726-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E52CD98E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 18:30:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfwX56HJ3z3c4Y;
	Wed, 17 Jun 2026 04:30:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781634613;
	cv=none; b=VX8yhIJtQeDXCKPdOdYDv2LII4aD5Jwp2Ed3LGgmN5DGjumbKhnpG82Y9Xhl0ipYSsQJbZ+g3wUKRnUZk8Z6NGuylz/NWM8I2ioHGGkoTEZ1yS7leRQmU6uVO9kUpoPKv9qfoxNsPPoKOx7OXAybK2bsPBKUK2YCymgDnf6Zt2zpq/M8xWvzqcjqdATL93ohrO4qfv52NLkNLK+PG+IcyRzISd+KRwEZM21JBay1sC4vjUYA2wa0cnXCPoMSYcinPjGx9x0RGiw2DkmltvliHxq6sYEMXLeL1VopeKOysnppA3VMiG3Ox01l0LnfZj52O7bTqgu79k56sRwxPmPZgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781634613; c=relaxed/relaxed;
	bh=Dv06OEZvF8tRVAKSy2Zj2XParkcF+9FcOKnYnV3pt4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVFkKVmKASWNauuPiKpVWPLcoede/wwatDq5qOGX3OVGNoqODBY5Ako3Ox9Eu5+7P2+9gKGY9q/BB2y/0W76a68XmVqIHFkYiXr2xFgZCr4ieaKlFgjO8062m0gafiSlVFTScBzTR/aoXJ3AYv58AS0VDZL6nl9E5oocyw2APopcYf3aozxg3oU9t3tT/Ogmih4gYGJCWU2yU1sS5fZkDW6nEKjaySxoKFGZTbX69SWygNHNx965aXFGCdKp1UOP6nuBe32CoImCfdGvY6WmaHQblzqQOnKcHICs2L7wNTzR+/acXVPXeNpu7lFSB0z4vjAfNUULOFzMGjvbvfH/aQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cqTdS7Io; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cqTdS7Io;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfwX454htz3c3v
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 04:30:12 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so4788123a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781634610; x=1782239410; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv06OEZvF8tRVAKSy2Zj2XParkcF+9FcOKnYnV3pt4w=;
        b=cqTdS7Io6xFHs02vtpbsgrfmXArFvnxcoaJ/p3L5RO9ARZsWK2bfkJLyL98PKBVyeG
         wZptocUHZCCc1zHbvGUxcTi0CFlZUPZwovIOjrE214Q08eSS0l25lwlEBGcx/koD7asy
         q69HUgjFSvar9e7DdK0V/B/n7KhD3wByXdN1PIwfZ5xfMqM+d5h8e4DaYgzuuTIE5S3F
         TPCuxmGqCnn9+OiWOq+PzRN2PSO8KbqvsiQ7fN40rftUmYkdP7DTQqFyoZLsrCSslhPJ
         ZL8aeEzmxkbChdf0eHLnyVriNEjmFqIUOHTw1U/arJDdWjBN6iVpBZHNApUKkJmH2dVS
         uVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781634610; x=1782239410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dv06OEZvF8tRVAKSy2Zj2XParkcF+9FcOKnYnV3pt4w=;
        b=eqt5pyl3Yh/LxSoYAFDRBhufDiZSm5vbhUuIzVeX5yH7rbb/v0JDIevxiJm0i+C9cw
         R8dMXKVpIEs9bx8qaPZilpOrPusjciCZqYdQQqRxOfTsFt1EdBU1lGdLopUydNNQuN+O
         AXQhfmwrA+KD2NSGjZyL2C1t8o5pZEOWxJ/UPoQC2Ju2+AcfFftOyPeHARXTuCk7s23C
         ledCqXralfJnZKS9Q3nfe5IPt3DTN3qtrrvPtmvJfuyS6/SOyUlMnCpEqbx9VXpIl3v9
         qGAyEf0TUodviDirU4gex2ysuZRwCflbOsJySCVp4U6D6vf4mqye6y6qxKmhL+5WX0rM
         +SGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NWa1P14lfkXUCW0blRo9AkLuwmbplB3Bk1YnZIhRDCGagyyJbXhjCc9MzAUrVkEakjVPRPLxiuHbvkTU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwD5a1UTjZCRmufuDqCj6m4EAGf+tppo7FnyLjt+1n1WDtbDZjK
	myr6puRm/4XDqtaxPrmIF43MhpPsPhBOsxcfOGiDSoqqz2qf+HIZ2kSv
X-Gm-Gg: Acq92OHhR77AXj8OIyCm+An3MN1ResePMHVT84Hj43+yKamgD1JenuVSdc8jR0bZ+xT
	itLUv+WmdNVrj82Vt+pi+7KHnAeHqc3fK9YjHSqgaqqGVeaOd443QUBMFiPbuixA0jdWGvFO1k0
	tbKgCS4N2L1u2qdTqb1j6yZLaHHzIZRvzicjZFLBENq5dHCud3u701eX+7YDiyl+MigputPXBOi
	NPIjDze8mMnD9/CaNDq/a+TN0U1Q6FKtjRPu4/sRmvsLBS3ebHC/SkYmt5o3sS9zvcmu+A2B1mj
	h+oECN9Bgxlz5ReBTCjzsbNK+hgLOTr4bFMMA0jK7ZO3OBF63Vv7QEpyOUOcusjAWOqM4QJ4JyZ
	T1hTvfIIXfcVNuXTgmngGQjcfAPPvaiij2PrYIw/WeAs92OpK6a4dH7d5XC74o//a1AOBCaESts
	bxW2QiqmF71H9VTGkfCg==
X-Received: by 2002:a17:90b:1fc4:b0:36b:75:6387 with SMTP id 98e67ed59e1d1-37c9343455bmr629532a91.8.1781634610240;
        Tue, 16 Jun 2026 11:30:10 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43345e3ffsm141092685ad.71.2026.06.16.11.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:30:09 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Chris Zankel <chris@zankel.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rich Felker <dalias@libc.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	x86@kernel.org
Subject: [PATCH 0/5] treewide: remove unreachable memblock_reserve() return value checks in early boot
Date: Wed, 17 Jun 2026 03:29:51 +0900
Message-ID: <20260616182959.2429774-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit

memblock_reserve() can only return an error after memblock_allow_resize()
has been called. Before that it either succeeds or panics, never returning
an error.

Before memblock_allow_resize() is called, the return value checks of
memblock_reserve() are unreachable and can be removed.

All the call sites are in different trees, so I split the change into one
patch per arch/subsystem. The patches are independent and can be applied
separately.

Sang-Heon Jeon (5):
  x86/setup: remove unreachable memblock_reserve() return value check
  sh: remove unreachable memblock_reserve() return value check
  powerpc/fadump: remove unreachable memblock_reserve() return value
    checks
  xtensa: remove unreachable memblock_reserve() return value checks
  Revert "tpm: do not ignore memblock_reserve return value"

 arch/powerpc/kernel/fadump.c   | 14 +++-----------
 arch/sh/kernel/machine_kexec.c |  7 +------
 arch/x86/kernel/setup.c        |  7 ++-----
 arch/xtensa/kernel/setup.c     | 13 +++++++------
 drivers/firmware/efi/tpm.c     |  7 +------
 5 files changed, 14 insertions(+), 34 deletions(-)

-- 
2.43.0


