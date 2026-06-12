Return-Path: <linuxppc-dev+bounces-22581-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1620CD98CF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 18:09:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcSGJ3ppQz3bsn;
	Sat, 13 Jun 2026 04:09:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781287784;
	cv=none; b=NtE1eOUAREM94DgpIr9L2FORAYli7OuK7dX+C6fFAnNbMjzx6IUSi2k/Xz2r8gfn4eNSwWihKDJWDgtE6BItnTuo+xa0j6d89rYKe2gGngRD8LmtWD9kwcVtBb+EJjgNKRAXol/YNTmW6eWXYa6F+PI6K5+ajl1CaXE5GSQVV5sBlD3mUPbsDbZKXR2tfF7YDrIuDxtpVm1NDCw5LMRNPYBOt3KlEEmiMLsajURxfjDIYRlyhfrdQJrJC2qmPcDcYTLrpQ5kgymti15TH+fz5eaRhXWLiPzadhHiS9F1Ay7+moP350obf2qyuAlAybQakZq+HmxWKpaxQ9rIxtI3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781287784; c=relaxed/relaxed;
	bh=sy5B4Hkkhz7VX1oSnZgSOogbp7pZpM+mVFfKtzTdJuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GIoCi/y+cKjSK2EoX4lC8/CjeWsxReh9ilt8pd9Pz8vJBsg730v/HPxgR8mQ1E2pvWxNG3LtAxywdRJz4idm4n0XHocGPakMxAWNCrEt2cTE0uAfUIOcMBdjOIipTUb7I+QqFiwKbIEwKOrCVI8C3ndbRPUp9/zDZ8V3MnpR/67SPxcuNDs9mc1CjD9J7d49+d1bLrYmoCF+8F4oYLwjM4rZ58j0fVbtp7uRWCj+SIGucymZ60wD1j9PBgTe+BeeFzdcoAeYTJcCD7SEFzoK+cHaFtieTEI+rR1OQG/XjpSakh4YJJmaeFpk5laPfeRiJZdaDRNXQ6T+grzqRmKlQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XykBRbCM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XykBRbCM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcSGH6QNqz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 04:09:43 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso12062675ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 11:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781287782; x=1781892582; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy5B4Hkkhz7VX1oSnZgSOogbp7pZpM+mVFfKtzTdJuA=;
        b=XykBRbCMoE6Rh2fzei9dXvq+5aY9EIrrabO6OLvMBYEIHuK7wV4vwhDO0CZdfGN7ox
         qHC21eNZOIbdZp1OVf64yBBXN/5OKABDoLWo3kRebN6LXiPqxziyDx+tKZxHDZGWgjso
         NzYbKnnB+0P7w6ZVDfZNwKQjKDv/SPgfIzU5fIjmnAHMpoKToYiFhHE3DoSsYuQdWDEV
         byYsduZVxzC7zzavD29mftAm5USdnNFuaHB799vYnawxu8Lu6AuV4InvB+7SgJ1nxeSy
         8HM9naqyathkMfJTUupikkYrYt0S4ib0W/jI7mxhDcuonLhFKhfxuGDTcwbQu33hRPmA
         gfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287782; x=1781892582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sy5B4Hkkhz7VX1oSnZgSOogbp7pZpM+mVFfKtzTdJuA=;
        b=kvlTVZ1aQ3HGgcjHsYej7X7thGwmwDhXmpNRyfNniuWM24xNJpKZJ+3ba62kP64TmP
         m1l4PehBzy8Wf4Jo8jV/hBjZIs0h5QMw18uYeiEkUcvu8jveE79xBqtKylgS3+Qr4Hxt
         pHk70wJGMlJaKVo3PFmYBiX7q8crzd1dFiUADCE2NqYrV43y1PrK3K3uaMExpRfMNfBo
         cIJG6a6gzXJNSLY/0tNUy3ww3qEfRP2zZQb0WJ0ryi9lgiRoRWc6x2WV4S3ofOU7+Cqh
         v/scCM7j3DeLBFx1CsVMHacHrPanWg3/Uu2UJ7zL8+nT7FNvneqTHF84zd5hAmjj+lvk
         U7AQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VBtFvXrQanLLeIsaZvk46Pv4PZA/Dm+DH//2lfzBSGCNDou4YFilokRJWKHSHUHhjdjghrQgvoTzINiI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxPDLyVqMwPDZReoGS9WHDjvaRgCyE2jDfgovHIny5iNI8EpzpJ
	hP0VFc3XJCDyvT0d5iCisTPT2KJbjqfg39q7SsEIH7xYStwYXCN6+97F
X-Gm-Gg: Acq92OFM+3d/4GwO4olyzzzbY7LhtkocROHK+gnv6F8dWwuj36pWcGEGGFTV9+2jFEw
	P1EhLnz5VMZcG5t/A4PXGTH1FVPaP1l22TSzFgRRF0oUf4+3V3g3Gyf0LAVweGw3xGc+cfWE7Zo
	n/caXiZJcfFXl0RAXCUDeCUjUPr6sEf/TFBFyOsLCeNVzUmjSrUpm4IxqtIp9vkmHIl6SUm4vSs
	rIOiqpKb5brWCVzsDgkAqu92tfkZXre6Fn/UJPaNLUtzEKbqp7psv8+eFlpdfpyODLLuJeHs2Qb
	U2xZmadVVGM1XpkwAigbdNQHacxnhURTV3o5+flww8canpzkyOt6xAYRhfSYNf5jbl2ny0HL74Q
	y/T29WzbevRWcYuSzXwBvrg6kh9WQp8sT+lqLIXbOAxkPNw/imMCm82u6pujrMKlDZ9YFIGmjGQ
	xknuqH7gcdBhynIWmkdhjgb8avuPLFakbnQV7sgNDmzQA=
X-Received: by 2002:a17:903:32c4:b0:2c0:b6c7:2271 with SMTP id d9443c01a7336-2c4109ed38amr47426415ad.4.1781287781888;
        Fri, 12 Jun 2026 11:09:41 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c70easm38956975ad.25.2026.06.12.11.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:09:41 -0700 (PDT)
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
Subject: [PATCH v3 1/3] mm, swap: make SWAPFILE_CLUSTER runtime
Date: Fri, 12 Jun 2026 23:39:15 +0530
Message-Id: <1e8d7e4d0bb1377277ae8b6561d89fa0e048e7de.1781287297.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1781287297.git.ritesh.list@gmail.com>
References: <cover.1781287297.git.ritesh.list@gmail.com>
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
index 78b49b0658ad..80846bfb5f76 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -129,6 +129,17 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
 	.lock = INIT_LOCAL_LOCK(),
 };

+unsigned int swap_slots_in_cluster __read_mostly;
+static bool swap_table_use_page __read_mostly;
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


