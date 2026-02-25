Return-Path: <linuxppc-dev+bounces-17184-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E78CF4BB9E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 11:05:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLWw85jGtz3fFq;
	Wed, 25 Feb 2026 22:05:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772017528;
	cv=none; b=CIUGEoXbUet6+p3qxG3BVeaS3kC8S8/QAI67Fotp7qxxcNr+WluEqtSPipA3ocgu5T8/A6zbyhDx6dwLPo6JKl0QPvPXPMcXZajBcEpRAQ48kw3tMUi2mTpVr9ZrCuRYS4h16cjkvtxANpQVgKpso8NDFLSfoionEHs+XFWt9WaxJbCIVg6a3w+eMstIlUfmN9AgHypHN3nLQvMSKcJRrQb6OByYLvq+wjYVYQMeX5HBdEGw0/PquKoobfm2aipN2FYlw9Ww5GaDkCVv80uchBocNdj1H2NmPEFigtKyQUZft7HXXrOwkmnkr6xCL2wZJk0a5fkcw0fiLsZKjewRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772017528; c=relaxed/relaxed;
	bh=zzyMxNvzMyycWrQ4teqi8VMBfU5GZXWjfAFiWBwDYeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLXY+/1wceEXLbD0ATmN/gJXNa1h0spKaHlvqK+aPQgvpH5F3Zd0i1TR5neF+fjMn41UDoC64io8YjpiKAUFqZOumuYnqWjBM2nGsxsb7A5HiZN7xYpKWVhZ3g7Jio0L+u6gCgm3MLnrtv/FatnJMglyzWTT0UpJT6dqm4TWKwgQDeSRGptKpkU6+nDPfOVfPxPOF4htIsMEW9uyRDhpzfAAQcnynGoaGIWnz+VyKdmTilB+RUq67VAySVGLJM1WrdCTosK6Dq9CCAkCG2aegJfjScy4kVNRqrKTvpO6aotwT2vqdk9+4CFlrHHO6z3HY4wiBOHFe1iVavpL6VIPOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H8ToNto9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H8ToNto9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLWw816Djz3fFm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 22:05:28 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2ad3f12a496so3044655ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 03:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772017526; x=1772622326; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzyMxNvzMyycWrQ4teqi8VMBfU5GZXWjfAFiWBwDYeU=;
        b=H8ToNto9MqpsLDMafHwf4YUG2HOoeoEUBJoPU8V/XbS3vrZ9IG5dyLVo/SG8KSIiW+
         TpCCmV2RRmX5OAZHp9y8ueq1JvLpI3kotzwR42el+VyawduEN/Podzy35KVqYAJs6Rd3
         5Op14RoctB9Gkf3a8HyYwSKTkfppomm1xiDlGCeLokW/tStY0pacwq7ucnTLJXJWLDtx
         f/+8ua7kcTjhnA1ExPfvvy8H85RS/ABUSOvZnlUQU40TQ8HWqJOk9VNoB+qpMczIYGsY
         BttGSUJVbAyA9Rn571atpJ/4skkky2L+F/OlYR42yAC4pXsm10bb5Hp/kJmz/vaIhYBi
         WjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772017526; x=1772622326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zzyMxNvzMyycWrQ4teqi8VMBfU5GZXWjfAFiWBwDYeU=;
        b=BZvf/StsNnh49atgMeW7D9Z1TOTXJMEPgh54AIgO+ac/J/JuzGAWtVqcb/0kauTnyA
         ssBlWVXlGRQ9AGYy9wYZJCpL4BwDgPBOjXp6udYhNTn0MMnOA24VSGnpXParQGZ9m+rd
         5kgFUKyPSDiU5DrFrjLLfYYEuDTvkRHa1D0c8Le/p/3vq7oOMvHZeff5kNO/EJWIUQ6W
         tV1IE4XuxuQUvsY1gkR2yrR1kKGaOjr47RQJ+S4yRlUjdG3d/MylAtGv9877wprd13C7
         aHo3NWL/05r9NTFV3sLYS3v7OcN4bNSxzlgxxDJ14xZMQXVzZChfRYb2MaWzOmqj7w+f
         iuJw==
X-Gm-Message-State: AOJu0YwDGGo4P0A9VhRUtQSF/Qj2eoa2gqgRIQAGm/XOeP2qRWluP94I
	A2auL8Mj7VO3mymhR4pSILNBh8Bpw/DyMAsPKBsYvJdnn45oCmrDqas92iT6gw==
X-Gm-Gg: ATEYQzzrM2EtY9zbGb1W6Ycx3FBRuR4P3ZhK9cYp4G9wg4OVe+twf7FT7cEcgMfztie
	OMB9kbbDHrnJg/kD/KMOI2UYpPhAG7jlkNB6uQ1xi0b7UWNiARfoRllleDe/xShMW5KIL7aOiRR
	TBOFpxGzxOYnxKeIXh9gUKxHMIJsYzRGrJwBl3En82Jqka4H5tMWJbnHfpoQJWsKVm1RAUlnign
	n/RZhff2wcGBm6Px0SAT4BD9GXsFNFcgVFTanB1EaI+FGLbgw4xniF5gDcdB2CZ4fCh75hvhDZV
	NndMA/idiUQmEj4MLRRo+kZDHMbzkK5wflWuPMV8FRxlKoxHl5w35/EfBnWSXrt/c5rZMN2+Vzg
	9/u4C7CPboUiN1UIXNDSNbW8j23AsF1qNdh2/A9G2H8vJK9csnbnRDYlCID5k+ETe7wJs7VCehS
	4P6HpzAwIojjO+xanxkstDcnJuFt/q7MU=
X-Received: by 2002:a17:902:c946:b0:2aa:d6a1:e183 with SMTP id d9443c01a7336-2adbdc3c51cmr30803075ad.1.1772017525603;
        Wed, 25 Feb 2026 03:05:25 -0800 (PST)
Received: from dw-tp.ibmuc.com ([203.81.242.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f9f5sm138365975ad.77.2026.02.25.03.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 03:05:25 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v1 09/10] powerpc: book3s64: Make use of H_RPTI_TYPE_ALL macro
Date: Wed, 25 Feb 2026 16:34:30 +0530
Message-ID: <3fb34ebce6a92855ce6c20326c1f7f99097227e3.1772013273.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772013273.git.ritesh.list@gmail.com>
References: <cover.1772013273.git.ritesh.list@gmail.com>
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

Instead of opencoding, let's use the pre-defined macro (H_RPTI_TYPE_ALL)
at the following places.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/radix_tlb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 6ce94eaefc1b..7de5760164a9 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -885,8 +885,7 @@ static void __flush_all_mm(struct mm_struct *mm, bool fullmm)
 	} else if (type == FLUSH_TYPE_GLOBAL) {
 		if (!mmu_has_feature(MMU_FTR_GTSE)) {
 			unsigned long tgt = H_RPTI_TARGET_CMMU;
-			unsigned long type = H_RPTI_TYPE_TLB | H_RPTI_TYPE_PWC |
-					     H_RPTI_TYPE_PRT;
+			unsigned long type = H_RPTI_TYPE_ALL;
 
 			if (atomic_read(&mm->context.copros) > 0)
 				tgt |= H_RPTI_TARGET_NMMU;
@@ -982,8 +981,7 @@ void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 	if (!mmu_has_feature(MMU_FTR_GTSE)) {
 		unsigned long tgt = H_RPTI_TARGET_CMMU | H_RPTI_TARGET_NMMU;
-		unsigned long type = H_RPTI_TYPE_TLB | H_RPTI_TYPE_PWC |
-				     H_RPTI_TYPE_PRT;
+		unsigned long type = H_RPTI_TYPE_ALL;
 
 		pseries_rpt_invalidate(0, tgt, type, H_RPTI_PAGE_ALL,
 				       start, end);
@@ -1337,8 +1335,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 			unsigned long tgt, type, pg_sizes;
 
 			tgt = H_RPTI_TARGET_CMMU;
-			type = H_RPTI_TYPE_TLB | H_RPTI_TYPE_PWC |
-			       H_RPTI_TYPE_PRT;
+			type = H_RPTI_TYPE_ALL;
 			pg_sizes = psize_to_rpti_pgsize(mmu_virtual_psize);
 
 			if (atomic_read(&mm->context.copros) > 0)
-- 
2.53.0


