Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BFCC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:30:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49852084F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="ATBmIW2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49852084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JHVM621kzDqFw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 12:30:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="ATBmIW2/"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JHLq5P1dzDqGC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 12:24:19 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id s23so536807pfe.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 18:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i6lRa0MXhBJfNlOXnuZs54DEOA2agjgObgma9iqIuRU=;
 b=ATBmIW2/d6B3fg01lGAMvxruJLhxj+WW0dwgAZiY+woAvJRqbjUmU61/il8dCE/gLd
 JqIbkr80dthGgEHlaqZrrbWfG386KyWfk0I/DbDSIeur5aIUP6IdrJ5Vfd4o3U3YbYs7
 Z/TiOKXoG6O9HCjvorag/6VowkHo4YforWUXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i6lRa0MXhBJfNlOXnuZs54DEOA2agjgObgma9iqIuRU=;
 b=HVvBwlZjQg/NHcNs1zPuKAhBsAnH7gS6bmF6T37SS5tBpBd7avZS8prssmRs/MSnvq
 CEiDVzCs5WVNOyRvk2SN8P80Hv3cZl4vdbEvffxnKqYlVLEBd6I+TnTBKyTvKQFuwLOL
 MHSqhCxZf+4CJvY+6hTl0XaDYMEqRR8CohUkVa4O+c/AvnCTK9AsDkrTQnG1trwvJXtZ
 tgn5uAws6OAz6uH51dtnGOIQ343myiT0AYNVal/9wUmF/f42WeUiuRkztaCwh1wCOEE/
 3QLpP3fMukv2vQGC95MtRGwDXjjCvodYpHKnC2DNxiy/uq6QmRQAmMYH7gKMLJmxIyAz
 RWwg==
X-Gm-Message-State: APjAAAWsy3qcJl2Tkn7pafmirewSwHh224k0SyC1IsX8WUwPEA0RJQvH
 1ZaiD9KVbeWTM89BjOwfL2L7VQ==
X-Google-Smtp-Source: APXvYqz4nUGuUAj5JuvJGSrd0AA2dxOB88BDLPK0Fre+823Pm/7s5+LBLKhUyBXUT/R7+XpS3PPXrw==
X-Received: by 2002:a17:902:7c03:: with SMTP id
 x3mr2227341pll.323.1552353858125; 
 Mon, 11 Mar 2019 18:24:18 -0700 (PDT)
Received: from localhost (124-171-102-1.dyn.iinet.net.au. [124.171.102.1])
 by smtp.gmail.com with ESMTPSA id e28sm3269181pgb.65.2019.03.11.18.24.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Mar 2019 18:24:17 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: aneesh.kumar@linux.ibm.com, christophe.leroy@c-s.fr, bsingharora@gmail.com
Subject: [RFCv2 PATCH 3/4] kasan: allow architectures to provide an outline
 readiness check
Date: Tue, 12 Mar 2019 12:23:47 +1100
Message-Id: <20190312012348.4854-4-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190312012348.4854-1-dja@axtens.net>
References: <20190312012348.4854-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 kasan-dev@googlegroups.com, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In powerpc (as I understand it), we spend a lot of time in boot
running in real mode before MMU paging is initalised. During
this time we call a lot of generic code, including printk(). If
we try to access the shadow region during this time, things fail.

My attempts to move early init before the first printk have not
been successful. (Both previous RFCs for ppc64 - by 2 different
people - have needed this trick too!)

So, allow architectures to define a kasan_arch_is_ready()
hook that bails out of check_memory_region_inline() unless the
arch has done all of the init.

Link: https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
Link: https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
Originally-by: Balbir Singh <bsingharora@gmail.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
[check_return_arch_not_ready() ==> static inline kasan_arch_is_ready()]
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 include/linux/kasan.h | 4 ++++
 mm/kasan/generic.c    | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index f6261840f94c..a630d53f1a36 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -14,6 +14,10 @@ struct task_struct;
 #include <asm/kasan.h>
 #include <asm/pgtable.h>
 
+#ifndef kasan_arch_is_ready
+static inline bool kasan_arch_is_ready(void)	{ return true; }
+#endif
+
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
 extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index bafa2f986660..6c6c30643d51 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -170,6 +170,9 @@ static __always_inline void check_memory_region_inline(unsigned long addr,
 						size_t size, bool write,
 						unsigned long ret_ip)
 {
+	if (!kasan_arch_is_ready())
+		return;
+
 	if (unlikely(size == 0))
 		return;
 
-- 
2.19.1

