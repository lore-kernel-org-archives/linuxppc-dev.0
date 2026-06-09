Return-Path: <linuxppc-dev+bounces-22335-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039CECD8C92
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:20:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZTzj3jkyz2yv2;
	Tue, 09 Jun 2026 23:20:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781011217;
	cv=none; b=RTP5Sb2RCERVF5I73TRRNRsMBeaoC3JXANxrNXhrX+zFXee+7rhF8qtfQPmFIZrNdugYIDdsmdlnaywd6G0m3M1nVEgsW9tGmj1UE4lokVuMOAOrK2jYrWMYcJcidooRlnP70CydKAsa8/VFr0WdaONPfDvBB0MXSxu+V5vGg0lXnFmNYyqE6whAD1bUrx8dCHPmwT7un2j9gGPa64/G6iB1z5P16FM7rR0laAjKTkhtEmJnxUKTZYtVWJHnYwjNR5UDhTNysJyD3uT59C4LDC5hI2K8KpXIcdfFxmD+STu/CADWg1QtY32v9iTPBsYFfGjkp1gOy84elbOmqbYx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781011217; c=relaxed/relaxed;
	bh=wSL5CmzTD1LjszwUA61HuGE+7rKiRm908LOwnsMCpzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8BImGetRVXCHP2I0kfhCbzMyY7je5qVF3aLxHoafUTCfVdBa67r/4OsZEhaG7w3iq1KIArDdVNbj9BQobdOVr2qjO3n49urhluvP2hq1pM53rXRaYq9L/RI0W0tm3QPlWBHhT+c2i9kcCRlUnmJM3oP//awDHZMGiCJgUsSBI2a9/j7I6RdRvMBrHLHW1v4ZSGjKu8Vp8dp3kvP51D8pkf2oCJPwEqSiO8gKgB1fs8z0lfK4xu8sC1UxqkR7+M+fRvej43fuJfTywJBzfto+liMjJUC/IPJDSSqTbC77PGtVab+ivVDm8wnk1DULM6ZakOVkf4vvNILgut9iCu8+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jnm7SXNs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jnm7SXNs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZTzh4PXFz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:20:16 +1000 (AEST)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-304e83724bfso6722885eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 06:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781011214; x=1781616014; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSL5CmzTD1LjszwUA61HuGE+7rKiRm908LOwnsMCpzw=;
        b=jnm7SXNsa4gSx+YoAB+wtwvbhrzrx+9RP+t6kbFbe2TU0W4YKZifgyeeYlJMYQLcuQ
         lgF2BRdx3emlM9wrsHuHEqm99v7PfBjVduqWwOQWv4QCsNE8P77m1InlaQ5oC0V7wOEC
         o1kW71LndFqsfcIT4kpak+HFK3Jle5Chtgoa90WPveme5c0/KXjubszrvv/bnRdGhKsN
         BNnUTQaVauGsUIyQtZJIiz6NDu73o0Iur0qtyIKdttyzg6AOj40sEIY51FfKlrm+UQfa
         CviO39ail4lexBNnI5dFsLULAaM0h3yVvEeTRg8k/F66PKbYM8bzmJBE9urwEIm5zH0V
         y0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011214; x=1781616014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wSL5CmzTD1LjszwUA61HuGE+7rKiRm908LOwnsMCpzw=;
        b=mSwtQmZPtDubQBwhLZt6e/jnvk2VeUFlwUIDRxlPQBZfO1sL6Iiy+DWsmLNMGLm5lR
         ZNCMfCtOSI5+D/OnIXxq/P9dvMD5YFr+h/G+Bcdco9kMEHMO6hZObsh3eE0vwleDGjKw
         EmZLaJm2FlIj8RdGg2hOq6Q0dvJFRBW5VPJkfBP5hRLMIU9ZiRelQoMS2iKfYmR3Djv5
         DGrCN5M5Q5JdNB4vjpxoUq2lxawfmwvpiAUdcVhbzR3Kk0OBYo7S5gWG7WcskOo5dzrB
         Lk5lADvOQ/kXl516Fu1TAG3wGhlszoU8WxhMSOLtkAjzRUl5Mca0GykURcaq5mWvIHm9
         focA==
X-Forwarded-Encrypted: i=1; AFNElJ95v4IEaPR38RQwfgiH925tjVjmB6dFy25EhYT+y5RP9wIJINABGkxFt6uPdYWPw28S1ipByNw9Ed91eew=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwHaM4g/rFuIWJtkNIQXOI2iIYKKwuvmUzwwRyvRnYDXoDM6POG
	I448q0yOIM7jGUV69lrV0T8jDk5r9ZOQ3zhRoUQVxge9bYSpQ35jjYUY
X-Gm-Gg: Acq92OFWyjsqfunWoM2JiEjffk4j3Uu+g84N4Hl48QEpfEM88U+BZffE83AeNPO+XJu
	wIE9vdVt40UOcV47IE4qfRJu02gLZcXi5ILdVYrp7edvgfaSTPtso7ojoTfTq5HppQ2yxR+a929
	w4X8DZGbE6v4vcAhhnm5igxr2qQvgheUr8aqp0TeQTl+TVBH4E8CL6ywpzTeMqR1TvDX76GlGgP
	Hi4YoxopAg8fR8qOQQvwt15+cG5rUO9jrqchvRrAKDfOLp7KmoxP14yzbQm4s967S9z54ymIBQh
	UGRlyugYMZTdQ2crEXvQmrgYOrsrGXXrmdTfxhpv/nSwxdjXxYNBQURosRRYRYiOblmXoy80kwk
	Vcnrfmqlb31vRki/1KCNzpyg77lGJGKuCy/NnZzmVaaKzu+aLXoqGwoQM3mdavR47awN97LtUph
	oNGrivFDA+uUwItziq6q63BcHsHzcv2RjNHvHBYqk1rp2gJ9OV1Upw4Q7/Pjw5
X-Received: by 2002:a05:7300:2311:b0:2f2:6dde:df66 with SMTP id 5a478bee46e88-3077b5a13cemr11222291eec.22.1781011214188;
        Tue, 09 Jun 2026 06:20:14 -0700 (PDT)
Received: from localhost.localdomain ([129.41.58.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db55f60sm27162467eec.6.2026.06.09.06.20.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jun 2026 06:20:13 -0700 (PDT)
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
Subject: [RFC 3/4] mm, swap: make SWAP_NR_ORDERS runtime
Date: Tue,  9 Jun 2026 18:49:33 +0530
Message-ID: <19688ab5ab8017467749e003cf630c76a4b2b198.1781000840.git.ritesh.list@gmail.com>
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

SWAP_NR_ORDERS is currently a compile-time constant defined as PMD_ORDER
+ 1 when CONFIG_THP_SWAP=y, else 1.
This patch converts SWAP_NR_ORDERS and all the relevant code paths to
make it runtime dependent. This is needed for architectures like powerpc
book3s64, where PMD_ORDER is decided at runtime depending upon which MMU
is chosen (Radix / Hash).

One thing to note here is, if any of the allocations required in
swapfile_init() call (which is a subsys_initcall) fails, then we have no
option but to panic. This is inline with how memory allocation failures
in other subsys_initcall() are handled.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 include/linux/swap.h |  10 ++---
 mm/swapfile.c        | 105 ++++++++++++++++++++++++++++++-------------
 2 files changed, 78 insertions(+), 37 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 46c25523d7b8..063ab7c4d4a5 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -224,9 +224,9 @@ enum {
 #define SWAP_ENTRY_INVALID	0

 #ifdef CONFIG_THP_SWAP
-#define SWAP_NR_ORDERS		(PMD_ORDER + 1)
+#define swap_nr_orders()	((unsigned int)(PMD_ORDER + 1))
 #else
-#define SWAP_NR_ORDERS		1
+#define swap_nr_orders()	(1U)
 #endif

 /*
@@ -234,7 +234,7 @@ enum {
  * The purpose is to optimize SWAP throughput on these device.
  */
 struct swap_sequential_cluster {
-	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
+	DECLARE_FLEX_ARRAY(unsigned int, next); /* Likely next allocation offset */
 };

 /*
@@ -250,9 +250,9 @@ struct swap_info_struct {
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct list_head free_clusters; /* free clusters list */
 	struct list_head full_clusters; /* full clusters list */
-	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
+	struct list_head *nonfull_clusters;
 					/* list of cluster that contains at least one free slot */
-	struct list_head frag_clusters[SWAP_NR_ORDERS];
+	struct list_head *frag_clusters;
 					/* list of cluster that are fragmented or contented */
 	unsigned int pages;		/* total of usable pages of swap */
 	atomic_long_t inuse_pages;	/* number of those currently in use */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 016a5aa0cb93..0a78802528cf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -118,16 +118,12 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
 atomic_t nr_rotate_swap = ATOMIC_INIT(0);

 struct percpu_swap_cluster {
-	struct swap_info_struct *si[SWAP_NR_ORDERS];
-	unsigned long offset[SWAP_NR_ORDERS];
+	struct swap_info_struct **si;
+	unsigned long *offset;
 	local_lock_t lock;
 };

-static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
-	.si = { NULL },
-	.offset = { SWAP_ENTRY_INVALID },
-	.lock = INIT_LOCAL_LOCK(),
-};
+static struct percpu_swap_cluster __percpu *percpu_swap_cluster;

 unsigned int swap_slots_in_cluster __read_mostly;
 bool swap_table_use_page __read_mostly;
@@ -545,7 +541,7 @@ swap_cluster_populate(struct swap_info_struct *si,
 	 * Only cluster isolation from the allocator does table allocation.
 	 * Swap allocator uses percpu clusters and holds the local lock.
 	 */
-	lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
+	lockdep_assert_held(&this_cpu_ptr(percpu_swap_cluster)->lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
 		lockdep_assert_held(&si->global_cluster_lock);
 	lockdep_assert_held(&ci->lock);
@@ -562,7 +558,7 @@ swap_cluster_populate(struct swap_info_struct *si,
 	spin_unlock(&ci->lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_unlock(&si->global_cluster_lock);
-	local_unlock(&percpu_swap_cluster.lock);
+	local_unlock(&percpu_swap_cluster->lock);

 	ret = swap_cluster_alloc_table(ci, __GFP_HIGH | __GFP_NOMEMALLOC |
 					   GFP_KERNEL);
@@ -575,7 +571,7 @@ swap_cluster_populate(struct swap_info_struct *si,
 	 * could happen with ignoring the percpu cluster is fragmentation,
 	 * which is acceptable since this fallback and race is rare.
 	 */
-	local_lock(&percpu_swap_cluster.lock);
+	local_lock(&percpu_swap_cluster->lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_lock(&si->global_cluster_lock);
 	spin_lock(&ci->lock);
@@ -1016,8 +1012,10 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 	relocate_cluster(si, ci);
 	swap_cluster_unlock(ci);
 	if (si->flags & SWP_SOLIDSTATE) {
-		this_cpu_write(percpu_swap_cluster.offset[order], next);
-		this_cpu_write(percpu_swap_cluster.si[order], si);
+		struct percpu_swap_cluster *pcp_sc = this_cpu_ptr(percpu_swap_cluster);
+
+		pcp_sc->offset[order] = next;
+		pcp_sc->si[order] = si;
 	} else {
 		si->global_cluster->next[order] = next;
 	}
@@ -1178,7 +1176,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 		goto done;

 	/* Order 0 stealing from higher order */
-	for (int o = 1; o < SWAP_NR_ORDERS; o++) {
+	for (int o = 1; o < swap_nr_orders(); o++) {
 		/*
 		 * Clusters here have at least one usable slots and can't fail order 0
 		 * allocation, but reclaim may drop si->lock and race with another user.
@@ -1376,13 +1374,14 @@ static bool swap_alloc_fast(struct folio *folio)
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
 	unsigned int offset;
+	struct percpu_swap_cluster *pcp_sc = this_cpu_ptr(percpu_swap_cluster);

 	/*
 	 * Once allocated, swap_info_struct will never be completely freed,
 	 * so checking it's liveness by get_swap_device_info is enough.
 	 */
-	si = this_cpu_read(percpu_swap_cluster.si[order]);
-	offset = this_cpu_read(percpu_swap_cluster.offset[order]);
+	si = pcp_sc->si[order];
+	offset = pcp_sc->offset[order];
 	if (!si || !offset || !get_swap_device_info(si))
 		return false;

@@ -1770,10 +1769,10 @@ int folio_alloc_swap(struct folio *folio)
 	}

 again:
-	local_lock(&percpu_swap_cluster.lock);
+	local_lock(&percpu_swap_cluster->lock);
 	if (!swap_alloc_fast(folio))
 		swap_alloc_slow(folio);
-	local_unlock(&percpu_swap_cluster.lock);
+	local_unlock(&percpu_swap_cluster->lock);

 	if (!order && unlikely(!folio_test_swapcache(folio))) {
 		if (swap_sync_discard())
@@ -2166,6 +2165,7 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 	unsigned long pcp_offset, offset = SWAP_ENTRY_INVALID;
 	struct swap_cluster_info *ci;
 	swp_entry_t entry = {0};
+	struct percpu_swap_cluster *pcp_sc;

 	if (!si)
 		goto fail;
@@ -2174,9 +2174,10 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 	 * Try the local cluster first if it matches the device. If
 	 * not, try grab a new cluster and override local cluster.
 	 */
-	local_lock(&percpu_swap_cluster.lock);
-	pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
-	pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
+	local_lock(&percpu_swap_cluster->lock);
+	pcp_sc = this_cpu_ptr(percpu_swap_cluster);
+	pcp_si = pcp_sc->si[0];
+	pcp_offset = pcp_sc->offset[0];
 	if (pcp_si == si && pcp_offset) {
 		ci = swap_cluster_lock(si, pcp_offset);
 		if (cluster_is_usable(ci, 0))
@@ -2186,7 +2187,7 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 	}
 	if (!offset)
 		offset = cluster_alloc_swap_entry(si, NULL);
-	local_unlock(&percpu_swap_cluster.lock);
+	local_unlock(&percpu_swap_cluster->lock);
 	if (offset)
 		entry = swp_entry(si->type, offset);

@@ -3029,6 +3030,16 @@ static void wait_for_allocation(struct swap_info_struct *si)
 	}
 }

+static void free_swap_info_arrays(struct swap_info_struct *si)
+{
+	kfree(si->global_cluster);
+	si->global_cluster = NULL;
+	kfree(si->nonfull_clusters);
+	si->nonfull_clusters = NULL;
+	kfree(si->frag_clusters);
+	si->frag_clusters = NULL;
+}
+
 static void free_swap_cluster_info(struct swap_cluster_info *cluster_info,
 				   unsigned long maxpages)
 {
@@ -3057,17 +3068,17 @@ static void free_swap_cluster_info(struct swap_cluster_info *cluster_info,
 static void flush_percpu_swap_cluster(struct swap_info_struct *si)
 {
 	int cpu, i;
-	struct swap_info_struct **pcp_si;
+	struct percpu_swap_cluster *pcp_sc;

 	for_each_possible_cpu(cpu) {
-		pcp_si = per_cpu_ptr(percpu_swap_cluster.si, cpu);
+		pcp_sc = per_cpu_ptr(percpu_swap_cluster, cpu);
 		/*
 		 * Invalidate the percpu swap cluster cache, si->users
 		 * is dead, so no new user will point to it, just flush
 		 * any existing user.
 		 */
-		for (i = 0; i < SWAP_NR_ORDERS; i++)
-			cmpxchg(&pcp_si[i], si, NULL);
+		for (i = 0; i < swap_nr_orders(); i++)
+			cmpxchg(&pcp_sc->si[i], si, NULL);
 	}
 }

@@ -3179,8 +3190,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	arch_swap_invalidate_area(p->type);
 	zswap_swapoff(p->type);
 	mutex_unlock(&swapon_mutex);
-	kfree(p->global_cluster);
-	p->global_cluster = NULL;
+	free_swap_info_arrays(p);
 	free_swap_cluster_info(cluster_info, maxpages);

 	inode = mapping->host;
@@ -3531,6 +3541,7 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
 	struct swap_cluster_info *cluster_info;
 	int err = -ENOMEM;
 	unsigned long i;
+	unsigned int nr_orders = swap_nr_orders();

 	cluster_info = kvzalloc_objs(*cluster_info, nr_clusters);
 	if (!cluster_info)
@@ -3539,11 +3550,19 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
 	for (i = 0; i < nr_clusters; i++)
 		spin_lock_init(&cluster_info[i].lock);

+	si->nonfull_clusters = kmalloc_objs(*si->nonfull_clusters, nr_orders);
+	if (!si->nonfull_clusters)
+		goto err;
+
+	si->frag_clusters = kmalloc_objs(*si->frag_clusters, nr_orders);
+	if (!si->frag_clusters)
+		goto err;
+
 	if (!(si->flags & SWP_SOLIDSTATE)) {
-		si->global_cluster = kmalloc_obj(*si->global_cluster);
+		si->global_cluster = kmalloc_flex(*si->global_cluster, next, nr_orders);
 		if (!si->global_cluster)
 			goto err;
-		for (i = 0; i < SWAP_NR_ORDERS; i++)
+		for (i = 0; i < nr_orders; i++)
 			si->global_cluster->next[i] = SWAP_ENTRY_INVALID;
 		spin_lock_init(&si->global_cluster_lock);
 	}
@@ -3579,7 +3598,7 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
 	INIT_LIST_HEAD(&si->full_clusters);
 	INIT_LIST_HEAD(&si->discard_clusters);

-	for (i = 0; i < SWAP_NR_ORDERS; i++) {
+	for (i = 0; i < nr_orders; i++) {
 		INIT_LIST_HEAD(&si->nonfull_clusters[i]);
 		INIT_LIST_HEAD(&si->frag_clusters[i]);
 	}
@@ -3599,6 +3618,7 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
 	si->cluster_info = cluster_info;
 	return 0;
 err:
+	free_swap_info_arrays(si);
 	free_swap_cluster_info(cluster_info, maxpages);
 	return err;
 }
@@ -3807,8 +3827,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 bad_swap_unlock_inode:
 	inode_unlock(inode);
 bad_swap:
-	kfree(si->global_cluster);
-	si->global_cluster = NULL;
+	free_swap_info_arrays(si);
 	inode = NULL;
 	destroy_swap_extents(si, swap_file);
 	free_swap_cluster_info(si->cluster_info, si->max);
@@ -3922,6 +3941,10 @@ void __folio_throttle_swaprate(struct folio *folio, gfp_t gfp)

 static int __init swapfile_init(void)
 {
+	unsigned int nr_orders = swap_nr_orders();
+	struct percpu_swap_cluster *pcp_sc;
+	int cpu;
+
 	swapfile_maximum_size = arch_max_swapfile_size();

 	swap_slots_in_cluster = generic_swap_slots_in_clusters();
@@ -3939,6 +3962,24 @@ static int __init swapfile_init(void)
 					    SWAPFILE_CLUSTER),
 				    0, SLAB_PANIC | SLAB_TYPESAFE_BY_RCU, NULL);

+	percpu_swap_cluster = alloc_percpu(struct percpu_swap_cluster);
+	if (!percpu_swap_cluster)
+		panic("%s: alloc_percpu failed for percpu_swap_cluster\n", __func__);
+
+	for_each_possible_cpu(cpu) {
+		int node = cpu_to_mem(cpu);
+
+		pcp_sc = per_cpu_ptr(percpu_swap_cluster, cpu);
+		local_lock_init(&pcp_sc->lock);
+		pcp_sc->si = kcalloc_node(nr_orders, sizeof(*pcp_sc->si),
+					GFP_KERNEL, node);
+		pcp_sc->offset = kcalloc_node(nr_orders, sizeof(*pcp_sc->offset),
+					    GFP_KERNEL, node);
+		if (!pcp_sc->si || !pcp_sc->offset)
+			panic("%s: per-CPU kcalloc failed for cpu:%d, node:%d\n",
+					__func__, cpu, node);
+	}
+
 #ifdef CONFIG_MIGRATION
 	if (swapfile_maximum_size >= (1UL << SWP_MIG_TOTAL_BITS))
 		swap_migration_ad_supported = true;
--
2.39.5


