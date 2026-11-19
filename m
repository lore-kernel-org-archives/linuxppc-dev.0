Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794AA60A261A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rBUOSHkF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPNp2CDLz2yDm;
	Thu, 19 Nov 2026 14:39:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059594;
	cv=none; b=NR1X8ksuqYlVzh7mMOJXK6MRCn399UUxpGsjh9s7QUOUJATAYl8hLJS7MZSsmJMRtwVJRR8muBIbXjp+QmVicq/p19XreO8qK6WVh4gw4nZncCtqri78cD7JLAIsOOzy0Ob60hY0+DdVw/FmeqNAZ7rOM8kiptFEt96zRwmxhSkF5q736PAYXMYwBOZe3P5Q3xbJoBz4XvHGYmHkYdkVjlTvvrnne0o0xVTb3HEonupFwpjhk0cto9BP2ucSBtb59BDHck5a7CQ1dNQUWTX3ADCD3IRhVzeZX1tjIUAXt4aEbxI+x67mjmZw0PLZjK/R+dc1kks37L8bi6E8BP6lQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059594; c=relaxed/relaxed;
	bh=Nf/66osJudXLuEZ03+OHFd4peJaJBQJPrvu5ptsPZms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AND95hZdNdgR3sDKoyP/kzkOzs/6uIz2KklxrpJCXB3ouAp+rFpE0WXCha379IwId8a8k+enuto++XnGrA4BN2GV2RODBQ3/5sv94P5qY2C8FbyZGjhVGzgwnlYW0IC0Ua1wvcseBWO3JNRtzIJvq2T3R35ByTvyuKaQMYyeRsi8TD0rU7hr7fdgQyuoIRj9LrmVo+LIcTRM0Uum8p96UFNbl7HoR2nJF0Tw52nBYBLqUT0Am3f+SNacF9UKiVdCFGOd0HMMz2x8MQA+kpQxBZrZ+JiAEtV4JSKqif75SlYBvJ7udMtfUxwMj9DOQDuj2ZC2Gs3iO6bmPvIVTBo3/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rBUOSHkF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rBUOSHkF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPNn53Fcz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:39:53 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so2529310eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059592; x=1795664392; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nf/66osJudXLuEZ03+OHFd4peJaJBQJPrvu5ptsPZms=;
        b=rBUOSHkFghPpBDL+Dr6AgHb3V2MftsSCms5X4dmUPMhPm/Y2szuNK90SPlgS3ymZJn
         EWPe1b3NOlv8l2ykKSTH0+CjFKjilsK5qyF7lREs3WbA22b1njsNbKOK38vo8oTdwY91
         S8IJIQV7vljCj2Lsh3nfOUNZ8LBUPMvvdigqJqy/zOfDyjdKRpxcLkJ3H6h9kIo2JuhS
         WGyY9QrfMDJUnTT7tlfvRiCQyQ/Fd2wH52jHKmdQdTju7R6flYkx7Lolq/32w5g/jEqB
         lADkEnVSKj/6MP8s9LlcVB/uB/hlWm+7hlLv3yVp+lJbI33c9tyULmw5C/tsQmq52Ut8
         pV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059592; x=1795664392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nf/66osJudXLuEZ03+OHFd4peJaJBQJPrvu5ptsPZms=;
        b=xe+mEWdvhgjA4DqLOvzPLyI4OGHRiNCx5Gc1+4DJ1ZXGruKpuyHYmruChoivmHnrNt
         6p1ZuvThHfF43f7dnzCTNvZNS5mLo2RaTMQ22YXFL80owWKtmro8iET9t0J/+Xzr+2ZV
         x7XDANPJmm3n0BZx9beDIEBSiZXnPNwTeTndcmDPHcxlNEInYGP5WpNH0iSzp/A6kGwI
         ckD5c6Lz0UhHXD6qI9N9uKZtKmupwWC5Gu6HZ9LdDCtkfz6dHFmC0i59IyzRxT4IHYAd
         SMl+wdrV53TmnT92v8x/SQl7Qqd+J30O7cxX27zv6ToNKBHy3TNPqDj4kCtwXhP7yfpZ
         2pcA==
X-Gm-Message-State: APuU4Z9MWBHekSlU3ZPLXdf9IMMGrWwGsoTehrKJqFAHXEdYqnjAQiy6
	U+IkNMukxoXLG7u/jQJSz1hCFlDbVOTzBwboKBPUN4YdzKX5SzzpFRfHskPaCQ==
X-Gm-Gg: AZFdTZd5S7kGppxYrpLVbd30ltw975aHsTozVKbHlEZcCAGIZKXJaZ5vAjLZgVK4Kie
	dkzcJdd9VTvsDx6VRjO0lZhb7M6ToPxQcxmGvJi9KpfMri0sVUT81F+FsJUBemOdAUbjg0m/9Bh
	zSO4/GeTfdYB9y4NhoBp6wDAkWnRoMvcIvUGCD4H6KZ72My758gtBY67z6yKY8d/Yr6zCEOyU+r
	uKyQ1Ys6y4bdJGKo5Jitszy2t8TfhiFhXB9bIWc4uADntkzLeppNHR5kr0XFQlD27GX8l+cEXFe
	aUvbkSjQxdnuvbjs53GqxUfxwdUoc6DxSaw01gCXSGlgwp4BTaEsF8OzLFSF9hZ7PfwdJDGPGdC
	El9DjXxcy6KFwL4Kv7CIBacS8AJYFQWQsfEC8/CQ0mIh81O3tMOgpUYWfyl4HPVvsA4lLlhCjkG
	Gsu76eZ6vbtSjiM6g1pQMoVaoMOUGFWaQ12sAuX1OEbJr3Lb/EhtaExK8bhzLiLT3jy1xwMuPdW
	15PAjsIwNxUW0eDxiDPaHUelQdUAx+xCufQ3Yl7p9KYsu9YwuUpN5K1JhC2kLyb1Q8vmr6jW+7X
	hQPBpoZIGLGDHowm7GhoPn2JcFVRqqN1AA==
X-Received: by 2002:a05:7301:228d:b0:36e:800a:71fe with SMTP id 5a478bee46e88-3827d81f0cbmr5255735eec.1.1795059591435;
        Wed, 18 Nov 2026 19:39:51 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:39:50 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 06/18] powerpc/mm: Enable context analysis
Date: Thu, 19 Nov 2026 09:09:01 +0530
Message-Id: <5b3ab875b1537a36c1eed735e50911be4a1a48a3.1795058683.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795058683.git.ritesh.list@gmail.com>
References: <cover.1795058683.git.ritesh.list@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


