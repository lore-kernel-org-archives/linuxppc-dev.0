Return-Path: <linuxppc-dev+bounces-22334-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A20CCD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:20:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZTzb0xnqz2ytV;
	Tue, 09 Jun 2026 23:20:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781011211;
	cv=none; b=dpRLJTlOUKcVz8Z5R2RecIjzhefz+iSgAioHeGf18CU8jMoqtLLVqZDrK0pUDdpL8MPUQMaDTMsqF54klWrlw449ZkxqvCgMBj1hgqqnqjfCGKJo3gdkyJYLpgxSJi+ZFCkzvjmdNfYnUjpmL22jS20LJtC87tSkEorihLg+UP6HZkAt5yCSiTdm4xgKz1H8mR0zOvfNJnh+8WdUyeyAFSYGxnVzTXu8HAW7twBpTu5wyFGltPZMH9ucfjeRAJWOZZNR+W2fs951vzleQfXJAU2loF6xn+Y9D2Ch6olbBctS67Kdp3cofYD1BGLi7fIGmDXk6upItKCwhVTGLQp3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781011211; c=relaxed/relaxed;
	bh=rzZH85xAJ3bnOHXxZ2IlyON4zc70knGPmBexsKaQByk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3eQGql5ddZpcwVpHpNEQoA/vqLan+/1VnP6I6LivWJn0t5yNbXkiFHY41AaUf+Uz7rDZWDtJHb7epLNE0lP4hpNZnZ/XeymikAp6TG4EQhItbNcufUFxQRK7ekZLevBxdVdQYXZpNSIrRo8ypAnzIDp0hyPxOveUN01iv00pivwquO9GKxjM8/9Oz+lmHCxvVsLE7RPnTqegSZJ6d/odUkDN78CLcHTPi4KZIW7J/cHzyZluZp0LC1QyL3rqJWEMRab0yLg4f1kf95PvmBwBxT1gJLJwayqWK2iQpKgPA517OZblumXNhhWXFfVeBHSMzTcJDEzn3SITjUsFMKOiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qjl3/M6k; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qjl3/M6k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZTzZ3fK3z2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:20:10 +1000 (AEST)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-3078e0dcd67so3400226eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 06:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781011208; x=1781616008; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzZH85xAJ3bnOHXxZ2IlyON4zc70knGPmBexsKaQByk=;
        b=qjl3/M6ktOUieZgdLiP+pil52tGOJ+z6VuA9sz0PyigLuoH5J7F0bVqxp1YaZhwT5r
         PlKMSa+Smt/C3/+ufVjpJXXTB9g9dx+rz5fxr/Jp3ubrnRD7Dr2cSkXtPy//pUVHjcit
         Dz1M31S0pTZDarmyrZbmR0VyUKbVNaXDiOFDIH9J8Fa1HDWhnfZK6v3R5PaXgVhoje5c
         j/G+yYtMmM2PFleIqi1Pl1Qqm9E3Zlf6MQbDbm/2p+9n6YKUObOwQ2U//vfKCHKZbrmP
         jyUOLfF7X6Z1yDvBMJ9wotmn2GAbysP5X6wbrtU+G+X/kFAlEzTM8GUOkWPoRD5wFhKW
         mhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011208; x=1781616008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rzZH85xAJ3bnOHXxZ2IlyON4zc70knGPmBexsKaQByk=;
        b=P0E/BbAe4d5A+DX0E+ReabggsmAYgJFcFlvg+u8NuNpVRcghHone+ieCeHanE11ObF
         3U0P9DAkfac7NM+tIrinCvkjCnkWiFtAm+2sCiRBgeotrQrsa/BweIHRygqJoiZGKXZi
         5YAsl7YR7Hj5tLblzN7VO3a1rrtjLzBYW7aL3jXeI01IBMROEEQ9Mp1eDGMjjIzUatZu
         +S9kB1N5NWuAk2uls9IsrqUPb+zp/C5UofI/58xSgCvlnFaUcpNQ7sckTEabrV7v7fBa
         4eyjVHG6n3mDledJYq7m9k056jMnn7LCKeHBH+/txqF0d1eHk+7tDO0qkK8rQDOqGeZA
         J7CA==
X-Forwarded-Encrypted: i=1; AFNElJ8oQj31nKx32cHWtqFq56it445TqBw/rqh8d5u8O1syJkCjeVeElHGLouzSN277cA58AJoIgefOCOU23x0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzZqLyYEf8ev8WDhfZWs0Q/0UUseetZxHAHMDRD7pnKuBSf5Ft7
	qnu55x1Y91M8a85TVL8wOMZi+T/B+VOH54+1JOUxnvCPctJnpKY3DKTV
X-Gm-Gg: Acq92OF22t+V5ROpDN4/U1iXdieEthdhe/WI/k6ORllpiQ4oSZZmZFmWZqEnbnQ9Ove
	iCmpiSa81EyBDsAFkQ1our1VUS7+YsBZa9qxoeTg8cHxdjJZhAimwGMsFHPK1sVZqV+apHLvDgd
	lQB7RA3D6z2OWZ5dqEHvzWvCBZzmLhnI0AQYwvZ6t5o78jTEZytm42d6sA6Tv0uS9rGa2h3zQtt
	r7UloBCWYAay77DtpmmvzqD4fbih7nz1kFMlV+oLMGOCes0OhE7B1R00FvnBGepp5HtBAIXpg/Q
	GV1R+V2qdfQZ+X8kR6nF4QxhVqNm5wpO0WFzjfhQT8hN8KglSgIFNpZu2LFysxF7WJmDYCW6o3t
	ecfZH3WMUHuGeZIpIn5lnPw5+bgAXkAF8HTpmhzMm1XmdJ0GVD1ONv267Bc7+jxHyL+mUHJg+i1
	dY8cYSxklCt0+GMIqGdR57gfq5DlEzKArtd+ePonxVBB2J1YPsZESXS+jM3KhR
X-Received: by 2002:a05:693c:3945:b0:2ea:c085:44b1 with SMTP id 5a478bee46e88-3077b22a000mr11912732eec.19.1781011208262;
        Tue, 09 Jun 2026 06:20:08 -0700 (PDT)
Received: from localhost.localdomain ([129.41.58.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db55f60sm27162467eec.6.2026.06.09.06.20.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jun 2026 06:20:07 -0700 (PDT)
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
Subject: [RFC 2/4] mm, swap: make SWAPFILE_CLUSTER runtime
Date: Tue,  9 Jun 2026 18:49:32 +0530
Message-ID: <eda5b7a6c82abbebf590ef788b4ab6810c73675b.1781000840.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1781000840.git.ritesh.list@gmail.com>
References: <cover.1781000840.git.ritesh.list@gmail.com>
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

This makes SWAPFILE_CLUSTER as a runtime value. Architectures like powerpc
book3s64 has HPAGE_PMD_NR, which is derived at runtime depending upon which
chosen mmu.
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


