Return-Path: <linuxppc-dev+bounces-22474-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AE5CD98D2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:48:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbdB46vCDz3brx;
	Thu, 11 Jun 2026 19:48:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781171292;
	cv=none; b=bcwFVOdI7VX5/d8jCFZKW/mMQH4Ox8OHSIVFrxb+KMBbVHqe9d18UWJx23MwzXEuwLSrhPlHUzZppRfKmY55aCMu6AUQmTOpPmg082j/8jCtf7X0iXFR2SdbH1EX4RVdvnjV+5WOENHRWF0Xp0aaHsyt/XTITlrZAWDvoWjuibOkg/7hqs/X/Azlt3J4UB7eRy3nXjy14AUrJUsuTzBeZK9vzlpqewBem46vE5+sSQb1QbALX2qdOPVR+pBzrXtsPUMfWha07dJHn1zYMrlTGNdsHSpJM1Pi5kX73eGnYaag99j5crLanAKPLNXy7IrBuRHC2JrHFclC0DT4vgtu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781171292; c=relaxed/relaxed;
	bh=RgDnCy/Lqt4KlSBPy89Hrdxm/Zy1/HrZbOMvwPuOqc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XoB6i+i8J8pG6P98WZ/ZZP+6ktVW5PHqj5KoUIJTtCpHQbMWeNW0IbwEqjwr5bpvZsJ4qB+0bM7cEXi6x6ViSMbtES/JJa2ut2rlVUpVI6Qsu97FJRDhv5atSXXBv2mRx+x/mQyD9A9s+yRIHa2X+9/aao+QhrbOafQs3O72ib+htSMdfJdrjZGMpdNxAxdf/DNn1lu1Zqf81QQR6nIGk6CWPGJU+41vLQwj1xkBNuFjP+9UDYcbtRfvPm+ztEr7E58mzlJ8R6VRldygVHpc22/zIeEVBz5+WXjUmORpmIGnOnr+FLmYXWVEaE+hGNtclktqJC5TVsSrZWTEZR+GWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=im3uT0jo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=im3uT0jo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbdB42hdtz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 19:48:12 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2c0c35980fdso76016765ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781171290; x=1781776090; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgDnCy/Lqt4KlSBPy89Hrdxm/Zy1/HrZbOMvwPuOqc8=;
        b=im3uT0joGZl66JPeeoL+6dbYcNko1q4j4+H33yf6b87r2fPMG4mu/lAe7fqIkdzzbS
         s1daEpqIvqJ7kPWJloyqd4lj++nSvZl9MG8xbDeWc5VB9VczCi7oODPhoXl9Vu0h3on8
         /K9L4xFeLcjL6nm3siPdr5K3XUmBPuxVnxccJt1IwnidWFd+KxatCNOi93mwDSv2x1hX
         QFnYer0qi0InsGNenNsmBfry9DxX2FylyoldKddq4Uz7nER0lIviO0xB2dN45ewAltC4
         1xp6OSiL/3taMsZvx9fW5sj1XUHdQ+apRbPKsxg551QX/mAO4FMxxsLVBQWUZ1Se2DzS
         B01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171290; x=1781776090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgDnCy/Lqt4KlSBPy89Hrdxm/Zy1/HrZbOMvwPuOqc8=;
        b=irKdAs6d+ujd1oJxzpBbhPvL6/wk8MeKqTpCe7Fa3GUGM0yNX2m2+lCuWuFBMXe5bi
         bGevatHOiyLuhg03CGk2dZTBrvdZPi66JNBmf5UaHcVT8VTegOIvDRpq420yXH0B2rSo
         M3IITNvOMcv/sKRwdI/MI+IYMgyToYUdDk0XnkVYBDtSiJ5oNwRv4GwXi+BWkWOBzAuN
         aCTww/hFZGb1hGmLXVZdwUUe+bfhSNt7xRwqJaecKO32UqZx6mNer9b91VNh4nXwA4Qr
         pJsKjtU/+C8/BcSQ01uEnGBplcyOAdQe37RNp3dsVjetjKUuICtWYVWjGbpvhxI8NRgV
         LAjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WNCGaIMCrvoRVDu11mlo7axGT5qDl+y+wP5RUy5L+jUSeMsLwxJ/76Sxqg7JfA3FOFqXaOWJhiWeDbWg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxBS95zbAIz7rBWdLjod+SR6Cfyo8zDhcvv1uWlLzKJ6I64MGP6
	+VFd3BKlVl7S11G4+ecKJkYPQXRbUy02ZgM/8btsem/ihOsjX3ksZplA
X-Gm-Gg: Acq92OH/EnmbMQ6K9J2yHlxWES/9FjSvXNpUiJFpA+gFYi3OYWblSHV+jhh5WeY4ddD
	RDRVSEjF05RahIXMIHa2FpLA9wDvZsSDd/Bw7OcK+Neu2GZx++FVyhohsLXmFjTCF8tnIdLXx1H
	7KRMAwFFKEqqfzVXYXrT5R6uxKmR9ICGiyEnTNY0Q874xDn32XgkVEjzL78eFK+MySwbCjnCTww
	NhayhFFKvfid/pg0TWHRq6GA8PX7MIm4KJhimsOq2Yx5RH662kxAbVzgna4n0FyWPT6usfIYqDh
	UHnOGL+Q5VP4El4d1WCK2lAuPstoA3wcFNJeWFguA6+wtzRb/N/SVm8Pe3TXjul+iOmwEmubsO0
	H2l/UfgZI2pCVfdo1Nj0ujdlsv35YtF2yPrNLlq8w6+7MR/p1gyZOWZIL8Ito1oKO8pQn+Jh9M7
	zKuq0r6Ra9ygb+dO5p9pPcH1cg6og2zmKnEktBzeqOBUY=
X-Received: by 2002:a17:903:38c4:b0:2ba:4e84:966 with SMTP id d9443c01a7336-2c2f2a77a19mr24838595ad.36.1781171290236;
        Thu, 11 Jun 2026 02:48:10 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm283324905ad.60.2026.06.11.02.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:48:09 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-mm@kvack.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	David Hildenbrand <david@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Sayali Patil <sayalip@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 1/3] mm, swap: make SWAPFILE_CLUSTER runtime
Date: Thu, 11 Jun 2026 15:17:51 +0530
Message-Id: <442a71907f1dddf12c55a74c0aa24fb70e3fb412.1781170904.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1781170904.git.ritesh.list@gmail.com>
References: <cover.1781170904.git.ritesh.list@gmail.com>
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

On PowerPC Book3S64, MMU is selected at runtime, so macros like
PMD_SHIFT are effectively runtime variables in the Book3S64 code. THP
swap code uses these macros to size some of its array data structures
based on PMD_ORDER e.g. SWAPFILE_CLUSTER macro is used for this very
purpose.
Hence this patch initializes SWAPFILE_CLUSTER at runtime and also
modifies swap_table and swap_memcg_table which were earlier using this
macro for defining the number of table entries.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 mm/swap.h       |  5 +++--
 mm/swap_table.h |  6 ++----
 mm/swapfile.c   | 27 ++++++++++++++++++++++-----
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 77d2d14eda42..956879a69ddd 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -26,11 +26,12 @@ extern int page_cluster;
 #define SWAP_TABLE_HAS_ZEROFLAG		((BITS_PER_LONG - SWAP_CACHE_PFN_MARK_BITS - \
 					  SWAP_CACHE_PFN_BITS) > SWAP_COUNT_MIN_BITS)
 
+extern unsigned int swap_slots_in_cluster __read_mostly;
+#define SWAPFILE_CLUSTER	swap_slots_in_cluster
+
 #ifdef CONFIG_THP_SWAP
-#define SWAPFILE_CLUSTER	HPAGE_PMD_NR
 #define swap_entry_order(order)	(order)
 #else
-#define SWAPFILE_CLUSTER	256
 #define swap_entry_order(order)	0
 #endif
 
diff --git a/mm/swap_table.h b/mm/swap_table.h
index e6613e62f8d0..90e2a7852300 100644
--- a/mm/swap_table.h
+++ b/mm/swap_table.h
@@ -8,16 +8,14 @@
 
 /* A typical flat array in each cluster as swap table */
 struct swap_table {
-	atomic_long_t entries[SWAPFILE_CLUSTER];
+	DECLARE_FLEX_ARRAY(atomic_long_t, entries);
 };
 
 /* For storing memcg private id */
 struct swap_memcg_table {
-	unsigned short id[SWAPFILE_CLUSTER];
+	DECLARE_FLEX_ARRAY(unsigned short, id);
 };
 
-#define SWP_TABLE_USE_PAGE (sizeof(struct swap_table) == PAGE_SIZE)
-
 /*
  * A swap table entry represents the status of a swap slot on a swap
  * (physical or virtual) device. The swap table in each cluster is a
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 78b49b0658ad..016a5aa0cb93 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -129,6 +129,17 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
 	.lock = INIT_LOCAL_LOCK(),
 };
 
+unsigned int swap_slots_in_cluster __read_mostly;
+bool swap_table_use_page __read_mostly;
+
+static unsigned int generic_swap_slots_in_clusters(void)
+{
+	if (IS_ENABLED(CONFIG_THP_SWAP))
+		return HPAGE_PMD_NR;
+	else
+		return 256;
+}
+
 /* May return NULL on invalid type, caller must check for NULL return */
 static struct swap_info_struct *swap_type_to_info(int type)
 {
@@ -437,7 +448,7 @@ static void swap_cluster_free_table(struct swap_cluster_info *ci)
 		return;
 
 	rcu_assign_pointer(ci->table, NULL);
-	if (!SWP_TABLE_USE_PAGE) {
+	if (!swap_table_use_page) {
 		kmem_cache_free(swap_table_cachep, table);
 		return;
 	}
@@ -456,7 +467,7 @@ static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
 	if (rcu_access_pointer(ci->table))
 		return 0;
 
-	if (SWP_TABLE_USE_PAGE) {
+	if (swap_table_use_page) {
 		folio = folio_alloc(gfp | __GFP_ZERO, 0);
 		if (folio)
 			table = folio_address(folio);
@@ -471,7 +482,8 @@ static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
 #ifdef CONFIG_MEMCG
 	if (!mem_cgroup_disabled()) {
 		VM_WARN_ON_ONCE(ci->memcg_table);
-		ci->memcg_table = kzalloc_obj(*ci->memcg_table, gfp);
+		ci->memcg_table = kzalloc_flex(*ci->memcg_table, id,
+					       SWAPFILE_CLUSTER, gfp);
 		if (!ci->memcg_table) {
 			swap_cluster_free_table(ci);
 			return -ENOMEM;
@@ -3912,14 +3924,19 @@ static int __init swapfile_init(void)
 {
 	swapfile_maximum_size = arch_max_swapfile_size();
 
+	swap_slots_in_cluster = generic_swap_slots_in_clusters();
+	swap_table_use_page =
+		(swap_slots_in_cluster * sizeof(atomic_long_t) == PAGE_SIZE);
+
 	/*
 	 * Once a cluster is freed, it's swap table content is read
 	 * only, and all swap cache readers (swap_cache_*) verifies
 	 * the content before use. So it's safe to use RCU slab here.
 	 */
-	if (!SWP_TABLE_USE_PAGE)
+	if (!swap_table_use_page)
 		swap_table_cachep = kmem_cache_create("swap_table",
-				    sizeof(struct swap_table),
+				    struct_size_t(struct swap_table, entries,
+					    SWAPFILE_CLUSTER),
 				    0, SLAB_PANIC | SLAB_TYPESAFE_BY_RCU, NULL);
 
 #ifdef CONFIG_MIGRATION
-- 
2.39.5


