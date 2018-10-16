Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E2FC04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:24:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AC520869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYUM7y/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AC520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZGHC13vKzDsN0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 00:24:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WYUM7y/k";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WYUM7y/k"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZG3n3GN1zF3WQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 00:14:13 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id 1-v6so11011040plv.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=b8n7ekTz4I5WPtItNykHetIxRP9150gP8kPb0BQtO90=;
 b=WYUM7y/kL8/+heRnnym3+/pjQXjKvyJ+4vExqnWSUKAt5OCcPWLDKAyjYXXX+3tTNR
 T6b0g4t9dmXMbmx3FIvcAqX7O329x5zhDruzeal6OmBiza0FOgjbU1RMeljPcpkbKp0/
 TFo8sX1VGUzkmoHiR1PFKoUwS+KpHNocpFVRrcfhk+rx6fduiPzvcVAXqnIL0cBl6THr
 hbVSz2bbtVDrUnEsJdSAy25sFuItTMKF0xRIJvWJnmBDgjGpCixgOlx4aG9rDmg6RsAx
 /uuAKEyJO8ldmQhR9iNJHXbr4spuqd6ROpfB/V469ofmS6CbDMXdpP6hxlUKVxCe5x+R
 3iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=b8n7ekTz4I5WPtItNykHetIxRP9150gP8kPb0BQtO90=;
 b=EYTRWc1s0SKCNGSznREEYD6LHrtn7g/7iIBt2Z8qLkNUQLe9JcFYo6PSO7LbHegvgT
 4qJQW6CvxNYlwZazY2jfKosu5zE6PO/yAb/NuGENnufOecj4eaY4u64RlTuDLqed9Q1C
 YS6lm0BwDVjPZhJe35hXgz68+jojZvGFwd2Dqva0tuDIBhn4PwcF663W4Z7XxU6xW3MP
 f8QhEKiZgunwmkQePBqDICUFMPI4YlIYwJbq6DFgcN+RdVbBOXIjATjhkaf0/o0bhGnd
 hzYGAjW6SPzJOMNWLkF3H0rs8mxXQ5kiHT1HGMfn3bpCclseU4lXgISo0m1xwBASaSjY
 ia6Q==
X-Gm-Message-State: ABuFfogA8qCeVOuFSCihFR0pxJeLUB3fLLis4fSeF0/NQKaTcPiJetD8
 190HyvG6yyB2scXJJLa5Yw4=
X-Google-Smtp-Source: ACcGV63ooqapdfib9rvEhAj6eX85EavZn0yGkIHSWlSmi1u/6UNdDgdZJZkJZsL5NL3zvWoE/2y3vA==
X-Received: by 2002:a17:902:4681:: with SMTP id
 p1-v6mr13592768pld.97.1539695651671; 
 Tue, 16 Oct 2018 06:14:11 -0700 (PDT)
Received: from roar.local0.net ([60.240.252.156])
 by smtp.gmail.com with ESMTPSA id j62-v6sm16043423pgd.40.2018.10.16.06.14.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Oct 2018 06:14:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/5] mm/cow: optimise pte accessed bit handling in fork
Date: Tue, 16 Oct 2018 23:13:41 +1000
Message-Id: <20181016131343.20556-4-npiggin@gmail.com>
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

fork clears dirty/accessed bits from new ptes in the child. This logic
has existed since mapped page reclaim was done by scanning ptes when
it may have been quite important. Today with physical based pte
scanning, there is less reason to clear these bits, so this patch
avoids clearing the accessed bit in the child.

Any accessed bit is treated similarly to many, with the difference
today with > 1 referenced bit causing the page to be activated, while
1 bit causes it to be kept. This patch causes pages shared by fork(2)
to be more readily activated, but this heuristic is very fuzzy anyway
-- a page can be accessed by multiple threads via a single pte and be
just as important as one that is accessed via multiple ptes, for
example. In the end I don't believe fork(2) is a significant driver of
page reclaim behaviour that this should matter too much.

This and the following change eliminate a major source of faults that
powerpc/radix requires to set dirty/accessed bits in ptes, speeding
up a fork/exit microbenchmark by about 5% on POWER9 (16600 -> 17500
fork/execs per second).

Skylake appears to have a micro-fault overhead too -- a test which
allocates 4GB anonymous memory, reads each page, then forks, and times
the child reading a byte from each page. The first pass over the pages
takes about 1000 cycles per page, the second pass takes about 27
cycles (TLB miss). With no additional minor faults measured due to
either child pass, and the page array well exceeding TLB capacity, the
large cost must be caused by micro faults caused by setting accessed
bit.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/huge_memory.c | 2 --
 mm/memory.c      | 1 -
 mm/vmscan.c      | 8 ++++++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0fb0e3025f98..1f43265204d4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -977,7 +977,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pmdp_set_wrprotect(src_mm, addr, src_pmd);
 		pmd = pmd_wrprotect(pmd);
 	}
-	pmd = pmd_mkold(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 
 	ret = 0;
@@ -1071,7 +1070,6 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pudp_set_wrprotect(src_mm, addr, src_pud);
 		pud = pud_wrprotect(pud);
 	}
-	pud = pud_mkold(pud);
 	set_pud_at(dst_mm, addr, dst_pud, pud);
 
 	ret = 0;
diff --git a/mm/memory.c b/mm/memory.c
index c467102a5cbc..0387ee1e3582 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1033,7 +1033,6 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 */
 	if (vm_flags & VM_SHARED)
 		pte = pte_mkclean(pte);
-	pte = pte_mkold(pte);
 
 	page = vm_normal_page(vma, addr, pte);
 	if (page) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c5ef7240cbcb..e72d5b3336a0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1031,6 +1031,14 @@ static enum page_references page_check_references(struct page *page,
 		 * to look twice if a mapped file page is used more
 		 * than once.
 		 *
+		 * fork() will set referenced bits in child ptes despite
+		 * not having been accessed, to avoid micro-faults of
+		 * setting accessed bits. This heuristic is not perfectly
+		 * accurate in other ways -- multiple map/unmap in the
+		 * same time window would be treated as multiple references
+		 * despite same number of actual memory accesses made by
+		 * the program.
+		 *
 		 * Mark it and spare it for another trip around the
 		 * inactive list.  Another page table reference will
 		 * lead to its activation.
-- 
2.18.0

