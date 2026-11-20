Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D652606A338
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0zDkuq0Z
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1t92Jrzz2yr0;
	Fri, 20 Nov 2026 15:04:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147441;
	cv=none; b=R8lG9dC2LpwX/yGlkjy2eHjjMWu59Quc9WkplPs5I00ux/URSka7ApTTbpmm5+Hyuttz6kVvRnzGhT3L/8E39jsbQ/o3cHC9+RwOlkorEqMQVr0W9JxlczjpvjZpbLJrHAtP12TlLikGjT90ZotdtWX8/mZM6KdXZSPazu+F612L7FHivlFxXsobJlEDLmojibsQ6BkciwDzBaMQkXPsAS+XqqJC0S2M0pzG+TbKXWM5JF3KPshpxbfS7wW0jH6mVLOY+BHsCaDP5nFOuwV0wtnjYZVuWbdkCRikIoK8H8hqJFD0hQO+nSyf0UeTwOEMorwK06edvC+CXJFNF15mKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147441; c=relaxed/relaxed;
	bh=Nf/66osJudXLuEZ03+OHFd4peJaJBQJPrvu5ptsPZms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXCWdp3QVCP9CzGLGlocuL7qaXlz+0Uv/hQBOvHrley7bGRHvmsDeS/For/rzQwiddbwSE2DAa8G7EJvdvIqe4wGprec8j+b254c8GV/8RFcEeQB7DF3+EyDUi+Z6R2LMzhZ+isrMuD5gT1iWO+v1HPs4fsorerNHzZubLDGvy7BZ9Lu9GT/B6WZr/G0Swo+bVB39idn8gq5cqW75Ubq0OeKktGLgSO9UOGFhdPnhGYlYioSBH81dk6uhgC4qXxq7BxM6p0NTtn5TjRqdntZ4HXjQJwlMUNEcLmibCoyC7w3aClcTDy24u/qDCWav7XZKuJYjtUl/Ka2/RSAToikyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0zDkuq0Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0zDkuq0Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1t84CvRz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:04:00 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso979776eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147438; x=1795752238; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nf/66osJudXLuEZ03+OHFd4peJaJBQJPrvu5ptsPZms=;
        b=0zDkuq0ZjRq0y08WNNVCcALIQo1+dR3BGghnBHdd35bQXJp5DzGVyJ64KqHMSvcT7p
         t5PfLzu0IutpYV3VH+Q6Cmf2t0ZLtKu5gYA23W3BwqDCY0S3r/BJIgqQBH9LaZKwyOZq
         vMPYItX5ByFx9zzTZoTsNqIUftO2I/Y+0WmD9uxL0VUkjlMQ3Z7fRObC7LbRmVh0kyCL
         7MNN/ivDriSblg7l8uFc+PlGL8SWvwVM9x06oOMXL4k6QbSF+co0ML3MYdaNoPI62uuT
         PQVuNrImzOmjZB933CbHBxHoTITyjcrXD75wvwM46idgJFXwaeoEJfqPAN09RTmhst4N
         8bDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147438; x=1795752238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nf/66osJudXLuEZ03+OHFd4peJaJBQJPrvu5ptsPZms=;
        b=Uq0pV0iKhB5JEqy/Z0qwlQ4WTysTRWb819DWWtOvgUeVzfdD+hp1xsEtRCuGN23oJD
         7AF1P5V+taPRSsLLIH+YI/7kRZk3JYKe5AIsALonpc+i7zTs3x06WVSFqaEWSEvqPH6Y
         A6HTarcV5TsUFupgOVa3tHzBL+vZr2byxbfICYRHByUYs72+nfHjU4njwPl2cru5Gyju
         swS64d7HehNkZdxhO1lVTpL5Z6wcTLsNKl+j+VidN2b/+db3AXrY3obiHOIUSlFfaOKY
         SrjKVUbr3y668xEswNFj0jwpmZ5gyfLy2GZ6F1/1o2jeGM/g5pXiich0ugZiPlnvlvWK
         CeKg==
X-Gm-Message-State: APuU4Z9UYmB6UK0T5lMnb2ya1vBpsAZ2cYXcpDRngUu7WxrhsxWZb4Tt
	18VVRjw9KrjZpXtQGpti3m+W+OXoTDUmrtl42btoy7GWHynx9McaetIWHQI2jQ==
X-Gm-Gg: AZFdTZdrncCSv0TJvdYVt0GAwz+2Vssv6m3RSsqsWOkHbBiJoRh5AbFntMHHhk0skk3
	Ic2OIW4cveouIGRwRdsCBGrtc4UXAfsSECKlHIqU4gjk7rR6tKstRTB2rjxO2AFIGr3cJG+ToST
	6bSCYKmRrcOZIiGXCiPgRFopZ+RI8kBcdIRDSbE4ZgZfehQK8LST0xLEE7JxAXwamIivvyi9MAy
	zDsPtJS4Z9mScH16w9Sj2aBpTVsmCGHV/uO2NnxcSzON39ot7hqE4hukMoaQg/wt48peR5xsVyk
	61Bg9ixoJdL4Rdt2q6HXwLbV88+hVgWg0RF2BYDV5diCoKzynDG3AreOtVEpAPFpgVkNc8CTITd
	2QfbzkXIEqbQod2gFrGDC1aL+vO/MWuFTPFPCVUKv743pez4IAxplYJYZIkd7XOa9s6+0IXTqhC
	0qCjFbW4eHLwdedEH+9ZaxRl7eDtBu+liHxOUR2QfnxvKsDhQ7xEIymPV7hYWtr/0a0RkzAzroE
	K7l00wledkfr5P5gqD8uoDq98Nn2mclW4puOO9t+yQWHcIBeOSeJqBiQiqKpr66PZvNvAGoZ9NL
	bjht0wBdWzCL5tOw/e7nCbGD+VpVlw/Rhg==
X-Received: by 2002:a05:693c:41d9:20b0:382:cef9:e354 with SMTP id 5a478bee46e88-385715183f6mr1436107eec.36.1795147438538;
        Thu, 19 Nov 2026 20:03:58 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:03:57 -0800 (PST)
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
Subject: [PATCHv3 07/19] powerpc/mm: Enable context analysis
Date: Fri, 20 Nov 2026 09:33:06 +0530
Message-Id: <9381c873240a164ea8ebd69dd40ebbf1a94fea45.1795147055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795147055.git.ritesh.list@gmail.com>
References: <cover.1795147055.git.ritesh.list@gmail.com>
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


