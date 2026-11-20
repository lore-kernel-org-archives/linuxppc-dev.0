Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726EE606A336
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QvXFL3RD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1sg0xR0z2xmh;
	Fri, 20 Nov 2026 15:03:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147415;
	cv=none; b=FetuNQbIrRZddDhoimXuFuAEX6ijL5a498+fNqp957OKh5xqka5xFh0Itlinzv4FyqJXvhcyLzvMgJlg9lRuZscg+PwtVa3RcA4NRAn1YFlWfpgPOStXHmh8HMkMV5X9uNalOePPM1X+gmUjJtWAWpjHBau5iXbeds5XyZ3KvFqaqCxT33ked9Eo77m5X8BgW8wThT5TRLC7R+E56PMkPEQnLTyxSKkUO63VPbkhjDCoqjDGdb5PMghzIOaZzrCnELyDmpu0MZIR2FnKOauFVdylbFEtNt4E0yQM1YGXqtU2B6MG/KrBaYDUDUFqg03kP93P2L0Z4NGOP4y5afJBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147415; c=relaxed/relaxed;
	bh=VrGBV7RnHyqY/luoSQkqMxgQv+Ks7bSq84D1rzXmpdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XHTQ/BzzxV5DmKJEwVxsRc1MTLbg0Y27rb9zg71AVwff/D8eU17zkUnoXT06p7w7JKovgm+3zk1SuPX/zxmDk8SQNoknrSVr5PZJx4X4ndku5fG18PDADkIEz2uU/I90wFdc8ct38L0CiPi9fmVbnXkt9YtrAR+bowFMqONytxpH0nEdJm3A6Zh1whX5WHF0WxFhQpMDAtK3IUuDO95KM1HO3jB9RFXpL/EL49ffB4YwlPF0YTFzd9XOQ3G9Lb64ZkB7jCHZk3R2D011fh1XWvERPnO5DUUMm61i/bRZshaRRq65twqqyDWVfkfGyAicHOTg1yoaxB1B53mQe49kQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QvXFL3RD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QvXFL3RD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1sf2NFBz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:03:33 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-38190551625so707659eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147410; x=1795752210; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VrGBV7RnHyqY/luoSQkqMxgQv+Ks7bSq84D1rzXmpdg=;
        b=QvXFL3RD70R+b6SSzNdShnhSjcRokKq8MOnyJKscWjnAFCSoLmGWmNrQrYWUmC5h7J
         2dXpjx97k/XtcW/G6FqRQrnT6fVGZ4dxo1j56ZP3zrWD4AOtHZQBZW9PCUA3JysTFJ2N
         RMFej/3skGqTA9Vn+bz+mzQE7nmGc+ME/CobpSj1a83/ydcXrETd1l3K1Qp6DahTZclR
         OTPAaXFHE2HYGK9+dIblDixvpEI58Z7AAbZ0LnQxcn0H47dzlVt5+30Wxw02V4qiG+DN
         pjANm581sa+jWvRODafZ7zi+8EfrvvZAbE09lAP8KQkMRIs2RbJK1wN8L1y0BYrjuORp
         xHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147410; x=1795752210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VrGBV7RnHyqY/luoSQkqMxgQv+Ks7bSq84D1rzXmpdg=;
        b=Ibzkzl1zs0JJZG04l76jVIHL+N+PAPDqukGgE0o9KebhZJujp7SpXZ4u+14n6tc0Cw
         wt+bAfXP78FQKvHxg0/Iqk6nWIzx447ZE31il3tD2HaRtJSnGv5PDvtLIPGmySmUQidX
         nRyewGUkvsKklkUCclCOyLOqtkNKeZRM2yFJTGDJbTQXQGpGdz/zbGoA+E13yYUxdzFp
         aKvE/w7zxFJoyHx/ywa57kupimZbrSPdm74khSdhzxW8Z8fPid5mtnJVN4djeFfbIy1q
         1ZRMRU7Jq4yzhTWjnsB1Px5QzdovCIpa/7NXUrBfzGhCuxtwOkGamuFp1paZnrR3Ob8F
         jrnA==
X-Gm-Message-State: APuU4Z+kwZJlHGKrBWX+2flBG7/bXYgcC54Os/LFrYLuz3dFyIqYVS2g
	mwXs1JMzySzLslGRMmuzDQZ51GKkMsFVWKFnwHR55wj15BUENmNDzMMjADRlng==
X-Gm-Gg: AZFdTZf8OFhT7tLEtrNT/AGAcyiqiPKYcfvvCK9ge3jAKG2Yacb4dVSjvCMBBKwm26z
	hdBTNbaIJqLdepO1ttn9uNV0ZS8aby9S+WnVg0Zm6zXS5E1z3Mn2g9ZNuteA63S1M48+FTRlghH
	19TtNYxuQWeFNxCR0IIXZHls+GZaEqrN79jbDmJWhi9bAGdhpixuBN78Edc5iIUmq8gSVYI0K10
	1+uxYvxeEGDabSe/uB6ggxWXYBrbRdYApl6MnxpxFqNPes6zjBVXGQ9CHs9OEkNtfqXMdEFrF7n
	FMa1YD5pYP+DW2XrHHrI9o5+5U3Fnjb++Li5Sm8V8q3sg5rN3UgAFECDVedIRBpAM/Y54rnLjg8
	xmdPZ6vgPjzeiQ0dF68IA4BTnDs9Ufi8HkiLO2+ntS0qH1c9CnlLOs9oN8wDyvb5eUR/UjaHjrz
	FC2t3OZg4ppWj1OG1T7u0xWyS3jzz38mBPRKQtm8wectSxB+oZrw02O35LfGKtKzyjuI3UWG1Om
	IfVSauohzTLfuvfvwPY/gLWrc+K1/JMnTIdv/tKm44kPFL0YZdnKh/GxMAibb99kjZsPizEKYjW
	rIQmMr25/rD2zVHUs7Q3KJ6N7FjRPbHFwQ==
X-Received: by 2002:a05:693c:864b:10b0:377:1ad4:1947 with SMTP id 5a478bee46e88-3856f14d3c8mr1630324eec.6.1795147410323;
        Thu, 19 Nov 2026 20:03:30 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:03:29 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 00/19] powerpc/mm, pseries, powernv: Enable clang context analysis
Date: Fri, 20 Nov 2026 09:32:59 +0530
Message-Id: <cover.1795147055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable Clang context analysis checking for most of powerpc/mm, pseries & powernv
platforms.

Lock acquire and release checking used to be done with Sparse. That support was
removed [1] and replaced with Clang context analysis [2].

Note that enabling this caught a real locking rcu bug in arch/powerpc/mm
(Patch-1). Note, more invasive checkers to check what each lock protects
is deferred for later enablement.

The series was build tested with LLVM/Clang 23.x

[1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
[2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")


v2 -> v3:
=========
1. Added patch-3 to remove -Wunused-but-set-variable on 4K with Hash (reported
   by Sashiko).

v1 -> v2:
===========
1. Dropped RFC tag, since this series is looking in shape to be included for
   v7.5
2. Clubbed both RFC series {pseries|powernv} and mm into one.
2. Patch-3 changed the type of i from "unsigned long i" to "int i"
3. Fixed commit msg for patch-14 - as pointed by Sashiko


Ritesh Harjani (IBM) (19):
  powerpc/mm/book3s64: unlock RCU before returning from mm_iommu_is_devmem()
  powerpc/mm/book3s64: Rework tlbie() to remove conditional locking
  powerpc/64s/hash: Reference all arguments in the 4K pte_iterate_hashed_subpages()
  powerpc/mm/book3s64: Rework native_flush_hash_range() to remove conditional locking
  powerpc/mm/book3s64: Annotate the subpage-protection PTE lock
  powerpc/mm: Rework nohash TLB broadcast locking
  powerpc/mm: Enable context analysis
  powerpc/pseries: Drop inline from hugepage invalidate
  powerpc/pseries: Rework hugepage invalidate to remove conditional locking
  powerpc/pseries: Rework hash flush to remove conditional locking
  powerpc/pseries: Add context annotations for the DTL worker lock
  powerpc/pseries: Annotate the VPD sequence lock context
  powerpc/pseries: Annotate the RTAS indices sequence lock context
  powerpc/pseries: Annotate the RTAS physical-attestation sequence lock context
  powerpc/pseries: Annotate the DTL debugfs read lock context
  powerpc/pseries: Disable context analysis for the CMM hotplug notifier
  powerpc/pseries: Enable context analysis
  powerpc/powernv: Rework OPAL console write to remove conditional locking
  powerpc/powernv: Enable context analysis

 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   4 +
 arch/powerpc/mm/Makefile                      |   2 +
 arch/powerpc/mm/book3s32/Makefile             |   2 +
 arch/powerpc/mm/book3s64/Makefile             |   2 +
 arch/powerpc/mm/book3s64/hash_native.c        | 122 +++++++++++-------
 arch/powerpc/mm/book3s64/iommu_api.c          |   6 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |   2 +
 arch/powerpc/mm/nohash/Makefile               |   2 +
 arch/powerpc/mm/nohash/mmu_context.c          |   1 +
 arch/powerpc/mm/nohash/tlb.c                  |   8 +-
 arch/powerpc/platforms/powernv/Makefile       |   2 +
 arch/powerpc/platforms/powernv/opal.c         |  30 +++--
 arch/powerpc/platforms/pseries/Makefile       |   3 +
 arch/powerpc/platforms/pseries/cmm.c          |   1 +
 arch/powerpc/platforms/pseries/dtl.c          |   8 ++
 arch/powerpc/platforms/pseries/lpar.c         |  59 +++++----
 arch/powerpc/platforms/pseries/papr-indices.c |   3 +
 .../platforms/pseries/papr-phy-attest.c       |   4 +
 arch/powerpc/platforms/pseries/papr-vpd.c     |   3 +
 19 files changed, 183 insertions(+), 81 deletions(-)

--
2.39.5


