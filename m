Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF650C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 02:37:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244D620863
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 02:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MIsLuu95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244D620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448xXB2DcszDqKP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 13:36:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::841; helo=mail-qt1-x841.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="MIsLuu95"; 
 dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448xVJ5Mb1zDqKP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 13:35:19 +1100 (AEDT)
Received: by mail-qt1-x841.google.com with SMTP id o6so21838971qtk.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 18:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=yjIoD8uEGLjwoz05d/LFqR2eoJsjuUHWOdyAMv0Rd4Y=;
 b=MIsLuu95LZ/nQkIjs8oqgO+nrZDrGP09lhGBvpILxiDBv075A86LdH3KefPA77Lbft
 W+D0dvkG6tY0YqK+toC+Y9F3rg4mocacw1kpqFcaLac9tQXAoXEUjCWNG/GcNP4wUgfH
 IcedeDYwmE6jtS3okm5jB7uJBrQ26oSO4XQqjeKN7CHgC8ZsmW8r18r3uvuCG3PoEgS1
 xVQH/cNfKqPUSJdQZKSL/t0V4fl4Hr9RM4NTAA7UAu8qQTAXkkll7D8mp+gR91F/TzKN
 wEgTygGMdtwinvU3RLd5yCWkX4876BZWskW3VlohxmWc9coOWzXSz4yLKoHUtmyLCkCq
 gqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=yjIoD8uEGLjwoz05d/LFqR2eoJsjuUHWOdyAMv0Rd4Y=;
 b=Sn2WBAFGlC0nlX630kv1DQL83C+Ev0tbn+q/PEYN+/uQMDC7V1joIMRf4MCtiA719N
 dYLFmjgfA7NGb73N8knpK4lJznJbdGkMTR19TojVKel3T65d6dAiMDsmt9JNIl0sXdgK
 KIZiPtukxjXTBBNnI0Hzyv+CosgnBd8X9317WG1NdFxKjLGSdwDt3kKu83Da8cIVy67F
 ccd87bPhB6JZ+YrSilBdAJareMISwNsm5oUj9ZTGiqet2I+PqXg8fz9qovZd9FifCxxM
 zPpuYkMLYe+6eB/QRE999PoYznyTn4XkckY/3Ag/kKV8BtfA6TGWKuUyg+Mi4ns5oGrs
 rszA==
X-Gm-Message-State: AHQUAuZUD3MzNPKj9ofXz6g4RIFDFMCk4smwo/Vpug/HevwRTmF0KRox
 jIZjeLB1x3IusJrKOkVAeRjnxWdlWcg=
X-Google-Smtp-Source: APXvYqyzdAPC7rFIDGKtvUajimBBDviMi4BApuwltgX5Rn4/ua0nLWNWPzJjWgHD0jCFmTtqkjJ//Q==
X-Received: by 2002:ac8:fb0:: with SMTP id b45mr4529312qtk.146.1551321316271; 
 Wed, 27 Feb 2019 18:35:16 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id s19sm11703228qth.80.2019.02.27.18.35.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Feb 2019 18:35:15 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: fix "sz" set but not used
Date: Wed, 27 Feb 2019 21:35:05 -0500
Message-Id: <20190228023505.80092-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

arch/powerpc/mm/hugetlbpage-hash64.c: In function '__hash_page_huge':
arch/powerpc/mm/hugetlbpage-hash64.c:29:28: warning: variable 'sz' set
but not used [-Wunused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/mm/hugetlbpage-hash64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 2e6a8f9345d3..f6b09edc5e6e 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -26,7 +26,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	real_pte_t rpte;
 	unsigned long vpn;
 	unsigned long old_pte, new_pte;
-	unsigned long rflags, pa, sz;
+	unsigned long rflags, pa;
 	long slot, offset;
 
 	BUG_ON(shift != mmu_psize_defs[mmu_psize].shift);
@@ -73,7 +73,6 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		offset = PTRS_PER_PMD;
 	rpte = __real_pte(__pte(old_pte), ptep, offset);
 
-	sz = ((1UL) << shift);
 	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
 		/* No CPU has hugepages but lacks no execute, so we
 		 * don't need to worry about that case */
-- 
2.17.2 (Apple Git-113)

