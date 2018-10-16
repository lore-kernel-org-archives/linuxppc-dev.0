Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28105C04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:21:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E99B20866
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/SSJVZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E99B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZGD046HbzF3VM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 00:21:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A/SSJVZx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="A/SSJVZx"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZG3g5VqVzF3W6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 00:14:07 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id 1-v6so11010934plv.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vbOXilnyHM7Y3HZf42CmhT0al3ZotZPzM5/9KSS+Wl0=;
 b=A/SSJVZxVxROnzdtTJGd3Rl0mtQnn0aeP262cO0PG37AB5aJFbY1kcl0Q9RVU+AsSN
 hnGdUUZtKTqK8l4cdbSjbZ9BUzn/hPxOFdEPN4vlGKIB25R+NFVzhjzkDFWSAaFBLaSt
 xrSM6/l6UKnNfWzsSJg7ulrXaZrJXIUqdvEaGukSxIoLvU3Es6tmC1I+PECGOfrldZKg
 NLn/cJoSesrvsErHZ4uFkC2dmA03+a8M23DZATqifHAalHpK02AeaGxYq3X86uOI4su5
 c7wNfOzT0sZv7rpzm5n9vvCGcZMKbl4VkQEOnVbCI02AICWJXxrRFSVG1IEGRym457Rs
 WgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vbOXilnyHM7Y3HZf42CmhT0al3ZotZPzM5/9KSS+Wl0=;
 b=SJY2JxLR10qfo334Rl05KiOzS4DPrYWaeES1De7azdaptlQ+jqAAt8fqVBowcRwCxJ
 j9/a5IVND4jPJU5OJaa/Httgsy+nCtOuO6P/2XAYuiYYV/suQ3c/H9x7WZZJ4K8AXEDG
 W8b6h76Wt3Eg9m8A0G7e4aBd2NfeNBAR3szJIJfdRyzT+8eH97RviBSytBJyzuSWuJAQ
 OOkXVQN7lNsgMv3NETUYyM6fo/bQpQ8CbrM/3PpWqtTdB3tMdYJlkW3zcBU77lwKNjJJ
 Y3jPZukVIaqUWVGd9d6x6aukE44GMJkXmU2pZlPSLc8oieOT5mK+YG9TenE4SJDfTYUy
 PEHw==
X-Gm-Message-State: ABuFfojfKhb5q8vtjnjWFRpELzrpKl4pLDwbHNGI1vUTYzcT349WxKsN
 Bvwl4p11HLr6bUa3aGbbu3w=
X-Google-Smtp-Source: ACcGV625ozmXlwQNgWm1xWhrstSjyDp7scuMStIV7BLFGcBHbvseOYBjb3efegUxYSoldpVrEtpcww==
X-Received: by 2002:a17:902:9b84:: with SMTP id
 y4-v6mr21817926plp.332.1539695646081; 
 Tue, 16 Oct 2018 06:14:06 -0700 (PDT)
Received: from roar.local0.net ([60.240.252.156])
 by smtp.gmail.com with ESMTPSA id j62-v6sm16043423pgd.40.2018.10.16.06.14.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Oct 2018 06:14:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/5] mm/cow: don't bother write protecting already
 write-protected huge pages
Date: Tue, 16 Oct 2018 23:13:40 +1000
Message-Id: <20181016131343.20556-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181016131343.20556-1-npiggin@gmail.com>
References: <20181016131343.20556-1-npiggin@gmail.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, linux-mm <linux-mm@kvack.org>,
 Ley Foon Tan <ley.foon.tan@intel.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is the HugePage / THP equivalent for 1b2de5d039c8 ("mm/cow: don't
bother write protecting already write-protected pages").

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/huge_memory.c | 14 ++++++++++----
 mm/hugetlb.c     |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 58269f8ba7c4..0fb0e3025f98 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -973,8 +973,11 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	mm_inc_nr_ptes(dst_mm);
 	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
 
-	pmdp_set_wrprotect(src_mm, addr, src_pmd);
-	pmd = pmd_mkold(pmd_wrprotect(pmd));
+	if (pmd_write(pmd)) {
+		pmdp_set_wrprotect(src_mm, addr, src_pmd);
+		pmd = pmd_wrprotect(pmd);
+	}
+	pmd = pmd_mkold(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 
 	ret = 0;
@@ -1064,8 +1067,11 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		/* No huge zero pud yet */
 	}
 
-	pudp_set_wrprotect(src_mm, addr, src_pud);
-	pud = pud_mkold(pud_wrprotect(pud));
+	if (pud_write(pud)) {
+		pudp_set_wrprotect(src_mm, addr, src_pud);
+		pud = pud_wrprotect(pud);
+	}
+	pud = pud_mkold(pud);
 	set_pud_at(dst_mm, addr, dst_pud, pud);
 
 	ret = 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5c390f5a5207..54a4dcb6ee21 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3287,7 +3287,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			}
 			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
 		} else {
-			if (cow) {
+			if (cow && huge_pte_write(entry)) {
 				/*
 				 * No need to notify as we are downgrading page
 				 * table protection not changing it to point
-- 
2.18.0

