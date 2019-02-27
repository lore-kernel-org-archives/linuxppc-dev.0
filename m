Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316D3C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 22:39:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909B42083D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 22:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UyLXQp/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909B42083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448rGb4mHMzDqLj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:39:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::841; helo=mail-qt1-x841.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="UyLXQp/x"; 
 dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448qfs58n3zDqKJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 09:12:17 +1100 (AEDT)
Received: by mail-qt1-x841.google.com with SMTP id s1so21239014qte.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 14:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=gJVRQLlqnwk8sxjewpHNesdly6P+LqOTjUsl1nOlzTg=;
 b=UyLXQp/xZQLZdLznUzhv0eDX+KSDYCghve1vumeb29D+/9quguhYCPT4+S9j2aGDsb
 mNAbWPvVLEeIuu3AH58JDKad3Pwl3VoBmhOZiEpJnuKEnickaMF5t3GzyjlWcW9pOXDJ
 p6zOpKL2o78jVDEiunfb70Sf+0dRcjKWPz/CQMUqOdg6kr/zR2hKntRFPoAZ3qaNXhjh
 Hf6RmnyaJyacgGy5nNz1y+ML1+srkoE3Uv3d/D59N3GbV53AXFx+53QbolnIAPuPcb40
 YMJ+BywVLOBaQbZrm+1Fp1/cwb9pebK9SyjHDHrATqqrqBO8ZS3hoNZn9eLsImqfUBa+
 GNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gJVRQLlqnwk8sxjewpHNesdly6P+LqOTjUsl1nOlzTg=;
 b=bAV98WGqVYki5cY+1DgmY6HgvzypWBZF+lFg5mr5lKZxhLzGhIskh6TdgGG+ARvByu
 pEwucEAGMX3K8zyzC2YFCvn9tUt7aM1NOLgq5KrQOaCVKN83W1VGDguQA57qU3aKNe+L
 PvzdxQK1OBBTkr6jExNf1yZoUr/fkfQ+V/aNLop4aS4kq3wTt/TyxWeNJIWhjg1TJEs1
 ive8KirWsjdQLGWiIQfUACJHdcOrY5dPESY+Fy4enaHaTqA618CldN5tZf8p03wWuefx
 u3TDsdKdvjlS53WvHG3GrwOiCNi/3PxgOqmds8QuS5Ldp+TxlojFQWF9XSlF2h0iUhzz
 E0XA==
X-Gm-Message-State: APjAAAV5utVaC6i2KCVrBmdM3JIN2p9Qk7n4Qov26HqpE+OQhJxEEMJW
 /hsSaucAaQcKlW9zRmwNZEDIPw==
X-Google-Smtp-Source: APXvYqwmi81Gngi8eMRRAO/I0i5iJ1vm93qc7mPf9+eZoRVTqADL3XHCZ4Q7jR52GigDXpvfSOMR9Q==
X-Received: by 2002:a0c:8b50:: with SMTP id d16mr3753432qvc.233.1551305533940; 
 Wed, 27 Feb 2019 14:12:13 -0800 (PST)
Received: from Qians-MBP.fios-router.home
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id u1sm12116671qki.36.2019.02.27.14.12.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Feb 2019 14:12:13 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: fix "section_base" set but not used
Date: Wed, 27 Feb 2019 17:11:59 -0500
Message-Id: <20190227221159.78055-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Mailman-Approved-At: Thu, 28 Feb 2019 09:36:56 +1100
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

arch/powerpc/mm/init_64.c: In function 'vmemmap_free':
arch/powerpc/mm/init_64.c:277:16: error: variable 'section_base' set but
not used [-Werror=unused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/mm/init_64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index a5091c034747..a4c155af1597 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -274,7 +274,6 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 
 	for (; start < end; start += page_size) {
 		unsigned long nr_pages, addr;
-		struct page *section_base;
 		struct page *page;
 
 		/*
@@ -290,7 +289,6 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 			continue;
 
 		page = pfn_to_page(addr >> PAGE_SHIFT);
-		section_base = pfn_to_page(vmemmap_section_start(start));
 		nr_pages = 1 << page_order;
 		base_pfn = PHYS_PFN(addr);
 
-- 
2.17.2 (Apple Git-113)

