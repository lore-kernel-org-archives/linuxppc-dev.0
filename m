Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD65AC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 14:22:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134D22084F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 14:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XL4pegDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134D22084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449s7w6Kk0zDqQM
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 01:22:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::844; helo=mail-qt1-x844.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="XL4pegDt"; 
 dkim-atps=neutral
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449s6D1KtXzDqQB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 01:21:05 +1100 (AEDT)
Received: by mail-qt1-x844.google.com with SMTP id d18so27819093qtg.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Mar 2019 06:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=EUUs3LNFAaKHMETr2fU5c4ctC/rfaPesGA2Y9uePxyI=;
 b=XL4pegDt02QxO47umZ4m9BxVx4M0b7LtcYYXt+KoGucZF9eBwAXz0RMBkbHFh/Soje
 fl7F63DRdLES8p88ieLGs/UvsZGGwIzQPF2/+zV4W1iKf3EBrv2UxgQrbcS85QYPcl2T
 Zy+1VHFj8mPP9EGQhL970Z5d7hBTwjy/hFZJm6f8YC3rR2aad3wC0z6t2rJkbh5QhO1k
 T9HzhW7Kd+JVp0CACnsO0ulIjdwsa8gYJeMIwCVazIjh1VLjMnaBK06FBCog7Miegrn7
 W2BhKD/md0u2/0QlaTDUZIiZFJV+lnZrK7zJolTtlUf/XdM8IA+gUopPlwt+NPMAy9S1
 cRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=EUUs3LNFAaKHMETr2fU5c4ctC/rfaPesGA2Y9uePxyI=;
 b=puTsS0hrEQRDBnlDSUmlAnNQA1XnoYVSG2Z2SyxqKgJOlSIgQtVXnkqSzYn8zcWHmx
 d4jTXFP/JUL4DyKhxy6WUFFixQx3kniElCrvawayiRfvejjGCS/ka1LYPGk4P2ckOJ40
 VZkHQeqORk/I7MYN98xzQNTLhXGCRCPapdnTNQOjDk3+IqTpV6PPsWSXgzOf7le/jkc+
 rj0YFgkbewYTfjqRhuX5V+xgK00HK/k15qNw15Ay5B/hMA3tYE4L2jrhbfjvZ5NqaLum
 lgLOjLmyi7Clqgwd49Ual13VfHYEjM/5U91gTWiHEfXJIuG/k8dQuiKB8Tj7r75rswsN
 2yWw==
X-Gm-Message-State: APjAAAVemvu90OkVm4sQ7QWVoMorciSi8Et/KsGSGEfDAxeQJC51mILp
 MBoA8ho4hr2UqC29b8C3pJEDGQ==
X-Google-Smtp-Source: APXvYqzELWawwCnip9FOUA+7LIn0MK7kwll1EGvfP0DW2Fkdg98c4eXqvP19Uj2N1CovMa6phNHmgQ==
X-Received: by 2002:a0c:d237:: with SMTP id m52mr3906179qvh.219.1551450061046; 
 Fri, 01 Mar 2019 06:21:01 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id p127sm11396151qke.97.2019.03.01.06.20.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Mar 2019 06:21:00 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH v2] powerpc/mm: fix "section_base" set but not used
Date: Fri,  1 Mar 2019 09:20:40 -0500
Message-Id: <20190301142040.94204-1-cai@lca.pw>
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
Cc: Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, hch@lst.de,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The commit 24b6d4164348 ("mm: pass the vmem_altmap to vmemmap_free")
removed a line in vmemmap_free(),

altmap = to_vmem_altmap((unsigned long) section_base);

but left a variable no longer used.

arch/powerpc/mm/init_64.c: In function 'vmemmap_free':
arch/powerpc/mm/init_64.c:277:16: error: variable 'section_base' set but
not used [-Werror=unused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: improve the commit message.

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

