Return-Path: <linuxppc-dev+bounces-28391-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB7EC9833E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:45:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htdHf3Hwyz30W9;
	Mon, 28 Sep 2026 20:45:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790592318;
	cv=none; b=S9sFYA0LrHkasJ6fPj88UwQ2rpQ1iMCA8PvuF+Bv31B15ro1dkW5R8Ffa779HH5m52xnLYEn+CoZVfL8OQZZqvUmRJQDBL6yQc3TC+bjkAQyTEVaB1X+HlDygyxnSTFXG6/IogevyKs5qzSMbQZpW+MOLzgYMDq8GBhKRF+NqFSuTG+SP2nc6iPEULL7HArJ0kvdHGPJFLwedeL73yI1o7REdmhUdxQKFEk9Lc322a2y53I9jwZIM2m5j/DCQqn6GmG9rIFbiT/ff1WQB+i+iytyW4NsWgOP5XP9/7vwXBj0sHyI7ohjpZxbeFSLLTLECQ8yyzr+xdQqu/aJpfdPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790592318; c=relaxed/relaxed;
	bh=Nf/66osJudXLuEZ03+OHFd4peJaJBQJPrvu5ptsPZms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=od3CPoCZz5lmoL94E2e/XV2mjyDuvyTTixiolm0ob2N3+Q1eIK2yDbw1WE2a4MvEe/bOMU+4DRF53dNXOk31oFK5D78wXJyEs0Is+wGW91lcUU1KNIogCbZhTDvVfc79+qranrg/lcVQLmlePeVLGD5GMMAW95/591lpQH/CB7i3EwjjAnSDGUt64t99UUhlzjq03eB2QO+0h3vp/XVdPNt854tYroo6twhwdycgjwiH5xS1Lua8vlGUasaaxYrYHbhWO1Yc0pCjtdT/ZSpl+3/1+llq9JtWsjp55p3fqdyvUvaE4/B6p6FQ/Futyo8WfdP5DgVluyptvtxHh3MrlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qgVswJxa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qgVswJxa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htdHd5Vj0z2yqq
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 20:45:17 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so1133932a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790592315; x=1791197115; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nf/66osJudXLuEZ03+OHFd4peJaJBQJPrvu5ptsPZms=;
        b=qgVswJxaMQmabY9DXCor95JEsRkNUZbPUOyf7qVa1TxoMN1yzJN/A6WJceZ32qntYC
         ADei4kv/NWP8wC/G6OPb6OFYf4YT/r3Ma9aVFemqzbFpwedjb1cHDExHhgrF5D7u8OIT
         gut7J1A/Ca+B/GAZdRwBx6kf0Nay0lusHhRVb4ZHc89UPhsr3PYH+rLPqWJ3f7BXYkcp
         Gy4UHSBb/Q2082zfnCy8IG2qDCpZqa1hOwk4EMga4wVtKFqu49qo17i6dLS5ISmhrfWt
         jG2T0GoCxAxB7mv4yypMRpSHW6u/UAcK5t0Fne3uLt2kf4VYGy7SLYaqmF+gTwSlmHqe
         c0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790592315; x=1791197115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nf/66osJudXLuEZ03+OHFd4peJaJBQJPrvu5ptsPZms=;
        b=unmNC4vpwNBtkmIGYlTqW/uAaEPnyj5JCqarw231HKVym1cgj/BSKNKNfgMN1cCUid
         EmjEuIfOijfD6CEQSx51XI7CGhgZxWrox4qut1243hhDAXqFVr+yMVZuTG8My1X5UGE3
         1T37qCjBgYnPwqechd+b3ybI8Y3lWedUD2mDpuJVuXQ1ZJZfvtPViaK4Kkq4PWvSBGYS
         qChHqVU2kOpbxUEwGiSQWTKn8+K+ikY0eOC6pUNxcBnIYA8Q+1JC4cOMZANVIAfUBRAx
         EoMC6P9cckmg35Zd/7XRRT6cTv7PQOOvnQ7dF9GY8OxbK3CVZxQroofX7jXs7TryfbTD
         CYAA==
X-Gm-Message-State: AFq9FYKlSl/MHeBmcdkzeHj3D9ODukn8ytD3KjrlQQTFajpgZzJ7P8OJ
	CgmsReXPcPcUtl7Bb3cEQaz56ZJrAWaNpv8ohPAhQzeriOytR+B8BzeuCF0FANx6
X-Gm-Gg: AYBFou3+RGGklcTJnXsZRj00Mja8srNaB+lDn+5b3pj1U+Q2sdd+82+N5S/76ZYdwn0
	Wz2NC3/4N5XiXOJRxiuO5SYiIOHQRZZabld7P9kNPqTJr0wCc25aEfFMKgLFh9lF2/p6TbSJcDU
	w9SuEgc3Db8OTpqFlOHZ0fQ63XV9M3juvT5BsTdPQ180VS7Gf5OgwQuCThf6zpH3BDUJyHCrPPP
	U04HgdApx+xk3bdFTytqWa8odmUP567j+2CJ9UjEuxietIOluJAYS4YsmmF5StK6rSU1DBzG10V
	6oNL6T7KzWB+7XPZuNw3Guotwy8EXvOs+g1PUR9itUGLdShFLFTCE6C6Y7Rg+vxN9P3HXCaOAr3
	l2UWgCb3n5mpEySjBo2Nz2ba4X1xxuj1FfgVEIVPJpTyanVC3GUamWGNw4yUOMLhp8CY6czbDib
	Kip8sQtWz0KSvinmvWPaz+CaaR6zkvRwhHAZT3MWqktZy5NwAO8AW6kuEAGegMq4lVG23kdU5VB
	IJHEpdh6ol+SFIAYDT7LQ1pK4ILpVECnwe7QUw7iugbuxEdMXDg2AxJTMUJ
X-Received: by 2002:a17:90b:4fc8:b0:39d:f4fd:8075 with SMTP id 98e67ed59e1d1-3a098ce492amr9654551a91.19.1790592315575;
        Mon, 28 Sep 2026 03:45:15 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c8f8dsm27071975a91.12.2026.09.28.03.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:45:14 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 6/6] powerpc/mm: Enable context analysis
Date: Mon, 28 Sep 2026 16:14:36 +0530
Message-Id: <f7cc79150caab4f355de8e8c44fda5f954f55130.1790590014.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790590014.git.ritesh.list@gmail.com>
References: <cover.1790590014.git.ritesh.list@gmail.com>
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

powerpc/mm/ objects now build with Clang context analysis enabled.
Turn it on for book3s32, book3s64 and nohash mmu.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/Makefile          | 2 ++
 arch/powerpc/mm/book3s32/Makefile | 2 ++
 arch/powerpc/mm/book3s64/Makefile | 2 ++
 arch/powerpc/mm/nohash/Makefile   | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 8c1582b2987d..33e51abb5aac 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the linux ppc-specific parts of the memory manager.
 #

+CONTEXT_ANALYSIS		:= y
+
 obj-y				:= fault.o mem.o pgtable.o maccess.o pageattr.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
 				   pgtable-frag.o ioremap.o ioremap_$(BITS).o \
diff --git a/arch/powerpc/mm/book3s32/Makefile b/arch/powerpc/mm/book3s32/Makefile
index 50dd8f6bdf46..d5069a586c7b 100644
--- a/arch/powerpc/mm/book3s32/Makefile
+++ b/arch/powerpc/mm/book3s32/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0

+CONTEXT_ANALYSIS	:= y
+
 KASAN_SANITIZE_mmu.o := n

 ifdef CONFIG_KASAN
diff --git a/arch/powerpc/mm/book3s64/Makefile b/arch/powerpc/mm/book3s64/Makefile
index 33af5795856a..c5d8d2ef72ac 100644
--- a/arch/powerpc/mm/book3s64/Makefile
+++ b/arch/powerpc/mm/book3s64/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0

+CONTEXT_ANALYSIS		:= y
+
 obj-y				+= mmu_context.o pgtable.o trace.o
 ifdef CONFIG_PPC_64S_HASH_MMU
 CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/powerpc/mm/nohash/Makefile b/arch/powerpc/mm/nohash/Makefile
index cf60c776c883..7d7409d2cf97 100644
--- a/arch/powerpc/mm/nohash/Makefile
+++ b/arch/powerpc/mm/nohash/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0

+CONTEXT_ANALYSIS		:= y
+
 obj-y				+= mmu_context.o tlb.o tlb_low.o kup.o
 obj-$(CONFIG_PPC_BOOK3E_64)  	+= tlb_64e.o tlb_low_64e.o book3e_pgtable.o
 obj-$(CONFIG_44x)		+= 44x.o
--
2.39.5


