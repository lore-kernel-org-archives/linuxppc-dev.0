Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6AD606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=I18o4Ghf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFZJ82vrLz30Ng;
	Thu, 29 Oct 2026 17:36:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793255784;
	cv=none; b=C8XO3EENJsTN/wqRQu8KcaaDhTMo30qCzooRbZs3uR9h2rYIzGWo+a/50h16gJA7AivPdnogTs5Kr4GQ13f+K2Rug++NSJxL2BzVBGrfwEhTnnMAznfSUOjX+w0VtdmnNDftxR7JchwvQv6cQZycDdGcTxMrt/EUTtWXHkn/ZQHz5vWkrSg8g7uXSYTALgOfnO9QrcX2Td2kHmIzAXTg3TzRQnpNpB/e9kd2YtYlNibzDvqtk9Db3rRW11XzLy4SSiP4U3BrsUXarWOpG5JjeVG4hn7TYiwfOUl1T9Hdq1mS7dUodq8sERKBbrjfuDhU3PpyLdAkGpxE5CDCt+093g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793255784; c=relaxed/relaxed;
	bh=BTXYfxfVOBhpvhPnAVq2lfmYKNgysPKxlm4ckRVwZ/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZmwiJCKzBUhPO34wpOPSNmXH+O+M1hBIX/WGzk6qNSjUzgHDcP8cPvLz1pre/K23+2ATJFw1bHxFrdCLitk2WBjgS8NTyn0KiaS0QDsSSH2lxBxi0rCdJgiUS6lmbZhyQx6s25zSPHyJt+9I68gE2NlJDMqNJ+Q8fy2Ag3ggyUOPmRfZV42r5TpbKOemLmn2fyfmlCNfg1N1LNBW0dxIPr68AvxsBTIjeHKyfeIU2sFH07wO55O1sE7G13ZZAijtJz/KMfH7zx+4rRQDtMZUVDFPzhVHUMnq8AVLFHQiklj2mx7Tj/lPtqwv+uKJ5AUbkshYqSUfBALYAY24NK00w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=I18o4Ghf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=I18o4Ghf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFZJ53dmgz30NF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 17:36:19 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso79633a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 23:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793255777; x=1793860577; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BTXYfxfVOBhpvhPnAVq2lfmYKNgysPKxlm4ckRVwZ/U=;
        b=I18o4Ghfi4qwxoV/bLRSXZfLe3Yva3wicGGVjsyzNlwe3V9dJgi1jolX7/sfLL51U8
         oviyahWaPec/tMy0quqbKR+GOd3/utT8FinRphetKEoU5Ev0xbl5QQxrvWBEWwM6TGfp
         x2rvpAu3VILmABxvdEf3A3zaa4xmhPJ3MlCeTgAzq3MGeE6aQVlhH4i+IdkDHkuVfXYG
         up4KcW80qOara4qzvUC8t/xdd1z2ekTBPBrdqsAFFAm/IHm4R+6Vop95HbNMzCp62eaY
         PuZKNK8AWo+idPGNq0yLm0bd3f3HVyz0kNSMxfLGp4yBXbxR0lzS9oI+K7xVzvXS3dqZ
         HDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793255777; x=1793860577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BTXYfxfVOBhpvhPnAVq2lfmYKNgysPKxlm4ckRVwZ/U=;
        b=JTijfqia65IWiGP+aZfO/voirHuj5RpQjqo1yK5Tgryt+o4BcqBTodHPTFWa6RQHHB
         OGcir85DjgC1vG62I5jEYonOtC4HpSb00NI41LW+urNnn1t/iM/U4vLJn6q3qjvWO92M
         oTFznOwJeM8QLulJCREj+ZmVn9x0XL21YRTIiNn0OWHiq5SnyLngBv+syK+sLdUvHGWn
         1JHgIxxQhR9sLEO8WzLHKOXNIsj8DAuFgz7xUl71kYIP/mpz77FxSsFZ+GKMGfLBmuhz
         F1880o8+kG71JyjLKlvzQ34qRxDUFzuso30DlS7nNGQQXBGSmlcIdM2X9CXIDUtITtIR
         ZwMA==
X-Forwarded-Encrypted: i=1; AKwUvBw0TNT/6Yjc8zHctcCjw1irMGuMddKwR/bwHUdQ2XbAH7mygb/68RcV6IC+t5bJOz7xlGpjoS/Bx8ZkxHg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKgL3pcnyB9e9ulNuK/CeKdlWWXfVRwPwYku0pecHyCvNsoIzMm
	rfgUSsd2EPLgRKA/lvfLSXaKtefnvCw0FfQ0DCbpGDA5Bl05qnU63Aq9o3czhVowTt4=
X-Gm-Gg: AYBFou3jO/xcCMx6tONRWOAN2/6ocXyTOtBZX9Ubt0litwxPxIu/S+lSMD/XO479eRC
	ivcTExzhscuC71+otMEDfneWhYEhIcdJFDPbqbdkVffEjVZAY3SF+NX00nM2K5KrBFz1JVh0lnl
	YHHUdxOcgsakWrKugqKdF3rBy6oaeSaAVlthZ65uyn/Ter1ljD9Ycjef0r5dyS9YctGSPjRKACs
	Iq/SEK5fZO89rHRQMs4d/UBDXVZngMR2cTgricOm7+3oKJlQ1+YAPqNJbV/oYPmoMzSYzyDa8br
	0gKDnSVpUePL3B2m9DWHZRT8XbeUbnHV2JYuI7KpnjReD3ZJJxujM+6p2UkfAPTlPnRbeqcRmc6
	5sND8zg/ZA9hoNab3FW68otjKWoqXsONNzjC0jy6NNja3wQm9QI6uK5FCxWrBNt4ejHGNY7ruu2
	6h9uK1yIFy1c9wOgO94kmig/KAnKe6LYb0XFnVT9DQ0UQrS3ibiuDkHrF1dj9Zk5XZP22jCX5yj
	Sv2Aivir7SEsWmUnvl7Sc+HLGpAMYO7zfs4lMbEpeWrj9uxu1wJGqwjfWBSc/dXmKO1C2twjRyQ
	K6Vx0X/FVOLE9vTkknXqfvOZTAA5ZdiUmeuIDekl0Wf9ii6Lkg==
X-Received: by 2002:a17:90b:4d10:b0:3ab:e588:c275 with SMTP id 98e67ed59e1d1-3ae57f9ae1emr3026634a91.20.1793255777049;
        Wed, 28 Oct 2026 23:36:17 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e2a703esm2734757a91.0.2026.10.28.23.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:36:16 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Pavithra <pavrampu@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] powerpc/mm: fix uninitialized ZONE_DEVICE struct pages with PMDs
Date: Thu, 29 Oct 2026 14:36:01 +0800
Message-ID: <20261029063601.1961415-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PowerPC radix vmemmap population can reuse an existing PMD mapping while
populating a device DAX range whose section is marked as HVO-enabled. The
reused mapping is an ordinary vmemmap mapping: the redundant tail struct
pages are not remapped to the shared tail page.

Leaving the section marked as HVO-enabled makes later ZONE_DEVICE
initialization treat the range as optimized and initialize only the struct
pages that would be backed by a real HVO mapping. The remaining tail struct
pages can then be left uninitialized even though they are still used as
metadata for the device DAX compound page.

This first triggers a zone mismatch warning in __init_single_page(), then
faults while initializing the pageblock flags:

  WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
  Call Trace:
    memmap_init_zone_device+0x164/0x430
    memremap_pages+0x43c/0x93c
    devm_memremap_pages+0x3c/0xa4
    dev_dax_probe+0x264/0x3d0
    dax_bus_probe+0x140/0x1c8

  BUG: Kernel NULL pointer dereference on read at 0x00001400
    __set_pfnblock_flags_mask.constprop.0+0x34/0x160
    memmap_init_zone_device+0x358/0x430

On kernels without these initialization-time diagnostics, the
uninitialized metadata remains latent. When userspace later maps and
accesses the affected device DAX range, the kernel operates on those struct
pages and panics at that point instead of during device initialization.

The Fixes target predates the section-based vmemmap optimization
infrastructure, so older kernels do not have section state that can be
marked non-HVO. Backports to such kernels need to handle the PMD-reuse case
in powerpc radix code directly, for example by initializing the tail struct
pages that core ZONE_DEVICE initialization would otherwise skip.

Mark the section as non-HVO when reusing an existing PMD mapping, so the
section's HVO state matches the actual vmemmap layout and all required
struct pages are initialized.

Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
Cc: stable@vger.kernel.org
Reported-by: Pavithra <pavrampu@linux.ibm.com>
Closes: https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 44868b62b14e..4f75f10ed68f 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1261,7 +1261,16 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			return -ENOMEM;
 
 		if (pmd_leaf(READ_ONCE(*pmd))) {
-			/* existing huge mapping. Skip the range */
+			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
+			struct mem_section *ms = __pfn_to_section(addr_pfn);
+
+			/*
+			 * Existing PMD mappings can cover the edges of a valid
+			 * HVO populate range. They are ordinary vmemmap mappings,
+			 * so the current section must not be treated as HVO-backed
+			 * when its struct pages are initialized later.
+			 */
+			section_set_compound_order(ms, 0);
 			next = pmd_addr_end(addr, end);
 			continue;
 		}

base-commit: d865f2677c44cb2171b833d6775cf692756fa8be
-- 
2.54.0


