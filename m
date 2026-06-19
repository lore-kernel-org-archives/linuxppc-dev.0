Return-Path: <linuxppc-dev+bounces-22780-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29687CD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 04:41:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghQ0S4ZHyz3brN;
	Fri, 19 Jun 2026 14:41:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781844088;
	cv=none; b=dUtTNkCYrqWkXVQ0nXn91l4YKtK7uOUB6Brox++Sj1ZiXptDSisfGle+VwMZ52FssekiH48sWRcCss/EK6SNu3yzc8dOrpWz9G5DHDxVpxXOxrxJDUR/hDBwW9f026PKGEgToKea1YpoCDwLF8D9sNZ6DGS/MvWI3rz5ieGkH3o3+lRaT0pr+AzQZRf3Oz97fViqmIA4HZgsb5UHN/uR7i3CkbrazXzI09aURbbHC2BkUc6a/C2Ou/gI73dYYcUmsI/81Vxyp4tktIfHIkV6AMhTGM9CApzuqn4hYm+rYajQrKFDH6OKeSYRwgm7Qv+xZa6Ay3NmK8wlRtLDeaQCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781844088; c=relaxed/relaxed;
	bh=nDwlvER6qvScgrv7Fk/iPlt0cLfE/eSLJgReW67yP/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P3Xw0Af4LZN1RcNh6CmwTTfKPylAcA8OgjEnefVSywSYyWvLp3gFhNr7ApJ+GAqrwfXjUula4GSUPb+C4a6rqZo88yTFAxPsh0aMTKTTEDvWB8/ZA27PC6tM5Qdt3jW+qp4qacRZnat5MQVRslDoydmgwQPzCSadWlKXpSe4M4XiJEZTRak+l/dEwIcdT75HmmsageOq/AFRMXk1w/CReuNa9friaxTpG2VhHSuubkA39mrijRc9eOoUnoHGvmQpk4RmR7rz5xOBxfi7N5Fc7BM60lB5NWFvqGWjdE5W/PKmlHTxfMcYDNPmzth6NZ2yo0Ty9nkzfEf1aJ27mBGAhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TOjr14Cw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TOjr14Cw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghQ0R6PcMz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 14:41:27 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2c6c57c5c07so12217815ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 21:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781844086; x=1782448886; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDwlvER6qvScgrv7Fk/iPlt0cLfE/eSLJgReW67yP/A=;
        b=TOjr14Cwbv8w5Tjk5Gtc3SdNIlEhjLgEvD+8sBYaV/wcm4a2sVjAZY4lWtohsvOQyL
         uwuicDrx74G7fAuy53q7vAbs0cE2v7PjiCVyWzQXRm752O5DrJe11MjA1Mj1WvhQP9YU
         MwGKAIyQZD9aqXEW1Uw1D41MsK1DC0XS1KCRUi1ssQkg8MmkneS5Fn7sT4rfRmkQPOc4
         qUXMuMVUtJfvG+bHgyyBklQZsdrAet+jHPYWnMrXyeaOYTo1wiykO1tjJFIHzUDyFasB
         c4u0xyYp8m1QqFx8a5bUmvduyY4V8OoVkpe1pEsUy8Lf+ivqPpNpy1dTGiE9d0Xmlxk2
         oj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781844086; x=1782448886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nDwlvER6qvScgrv7Fk/iPlt0cLfE/eSLJgReW67yP/A=;
        b=bJ88p+9bD/nm0yayTDLApiLv/Y3eSqQRCKx5YaGG5DU6Jrn4ug4khooSU69I62j5LB
         DFqg6eMbZg1vmP9IDhQXO/5Gcx6tl+Xcn2Q3d3sLget2HTM9syj580fwFVzlVI6HSv4M
         0zvLhOAzgcp/Lzv8oZ8L9yrabpDLZz9eyk0zuETc5l04g9s/4v1jlnhU4bK03H2/aHqu
         SM1xQfamSmAzWr6UCXWgT4xAWkC3gX8F9rXyeMgkQTa3Io20jwluXwsVAQljGVwE0Qmc
         u5Tp8XWq0K9Pspu0dO2v5+xuM2QEh2xnpvXrMjEtwp62eQoFPJCHwsOTNFYWAQfzrI47
         vUDA==
X-Forwarded-Encrypted: i=1; AFNElJ+JaZjIbU9KrQVa21AFUC86x3X4vyVsbwFhYgqeXt281N6V2Q13So6wmpxCRh1/YzWd81yNRUZllbD1cI4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyoeU9BJIFy1sqkNo3ZA0/o4nmhDb9r6s/u26wi6x1lpdBTFRJn
	h+LhtiJrKbAzXa8bOnnXpwfBiqGHS3u2uCfx0tb03OuGlTL/A0tq2BpQ
X-Gm-Gg: AfdE7cn3DyaIvuZz0il6cZCZvcEKTgd67GeFYkFMEd6lf65ocRMfF50FIhD2JBz9jL7
	9wV8QNFauTObn/zJU8761qtdGpS20O5siSCGQH8wdog0vdiWpYqhwfdkVBBfVcT2LK1csdC8++p
	t1ZIj9h45AARDs+Mi71+ieInIdomKvlEkrt2cfPysrdn7VXW0QrC6D58q7gScm+jKmKGnrUsK4s
	ZJJaUJVPMmoptF6nq9mrkZLgkfVftzsS5kDOfDfKxGmhja97WObFJflDgs5rzwhtxbtVZ8+x4fe
	sVDag4dd2314DELsKDTiFlALyVpuW2/ReVUZ+Ea+KKph14gWYlFo9zeXRuBI00Nf05PB1PByjqK
	ekGiQd6zgtqrZNWcWuIZsfkJhwpvlWjiynu1VwOnq9CeTiN3uTqEdHw+722o06DGqdSGkaAX2oJ
	KRb0QDtEzRb2ximrHd+mM1kQ==
X-Received: by 2002:a17:903:1c1:b0:2ba:4e84:966 with SMTP id d9443c01a7336-2c718fcc7a6mr23166285ad.36.1781844085879;
        Thu, 18 Jun 2026 21:41:25 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7208e5760sm8293735ad.36.2026.06.18.21.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:41:24 -0700 (PDT)
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
Subject: [PATCH v4 1/3] mm, swap: make SWAPFILE_CLUSTER runtime
Date: Fri, 19 Jun 2026 10:10:57 +0530
Message-Id: <e519e98f51be2d310367e39df0935da79001e535.1781843449.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1781843449.git.ritesh.list@gmail.com>
References: <cover.1781843449.git.ritesh.list@gmail.com>
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
Hence this patch makes the users of SWAPFILE_CLUSTER to use this macro value at
runtime and also modifies swap_table and swap_memcg_table which were earlier
using this macro for defining the number of table entries.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 mm/swap_table.h |  6 ++----
 mm/swapfile.c   | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 9 deletions(-)

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
index 78b49b0658ad..4bf11c5b87eb 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -129,6 +129,8 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
 	.lock = INIT_LOCAL_LOCK(),
 };

+static bool swap_table_use_page __ro_after_init;
+
 /* May return NULL on invalid type, caller must check for NULL return */
 static struct swap_info_struct *swap_type_to_info(int type)
 {
@@ -437,7 +439,7 @@ static void swap_cluster_free_table(struct swap_cluster_info *ci)
 		return;

 	rcu_assign_pointer(ci->table, NULL);
-	if (!SWP_TABLE_USE_PAGE) {
+	if (!swap_table_use_page) {
 		kmem_cache_free(swap_table_cachep, table);
 		return;
 	}
@@ -456,7 +458,7 @@ static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
 	if (rcu_access_pointer(ci->table))
 		return 0;

-	if (SWP_TABLE_USE_PAGE) {
+	if (swap_table_use_page) {
 		folio = folio_alloc(gfp | __GFP_ZERO, 0);
 		if (folio)
 			table = folio_address(folio);
@@ -471,7 +473,8 @@ static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
 #ifdef CONFIG_MEMCG
 	if (!mem_cgroup_disabled()) {
 		VM_WARN_ON_ONCE(ci->memcg_table);
-		ci->memcg_table = kzalloc_obj(*ci->memcg_table, gfp);
+		ci->memcg_table = kzalloc_flex(*ci->memcg_table, id,
+					       SWAPFILE_CLUSTER, gfp);
 		if (!ci->memcg_table) {
 			swap_cluster_free_table(ci);
 			return -ENOMEM;
@@ -3912,14 +3915,18 @@ static int __init swapfile_init(void)
 {
 	swapfile_maximum_size = arch_max_swapfile_size();

+	swap_table_use_page =
+		(SWAPFILE_CLUSTER * sizeof(atomic_long_t) == PAGE_SIZE);
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


