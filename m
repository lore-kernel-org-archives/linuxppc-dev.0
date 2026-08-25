Return-Path: <linuxppc-dev+bounces-26075-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D8FC5DF81
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2026 02:27:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTWrx5LfHz2yDc;
	Tue, 25 Aug 2026 12:27:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787624849;
	cv=none; b=VjXZ6GcPW6Ke5+R0pfDY650AjHCffA5+rk21M3afSQ4RVGUQgDC6oRZmbToJDuRYH6wky6i7x3i+Ev069qvwz9TWbawgUQgcC4iERXyoLTDTSK0hF0zcJQXoAjAQmV3EEBkLPLY8/FivcC0qzQ0YvvE5HhtOmlByQw85IVCNlfGPaxk8FX5ZBSz5VGYqQnpOgLmBa6tGZl/AmtxmPllmyrOp3ZYw5iKujBCGQfhJx8VFbYr9vBA5n73Y+BxPIF2YQOazYWhoy8qrdTp7ouN0SIlp7oKK2BWgEqxOYF4yEc6hs/c9SRwJ9HRxZwV89IiCW4mOKv8TNPB2dcX1nnAr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787624849; c=relaxed/relaxed;
	bh=YEdJik5d7Qt4RJJH8YjwskAz6j1p5QH/xqQKb6YvaA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEuCN2NB9rZtSxq9htUlr0DL6nwU9V+1J+CuZbeNbznOImiAqCXmkH5los8MkRk2TG39oCDX/ukp8Mu8z//iyKQKQ8iCpWnLVA8R0OD9LL8vyvADFC71P5He68KIXnFm6phnYRvydperVDULWyUy4vgWDind9B/B69L/UvGLHgdehLamVMGluEJ1g8I6sYJywK9B92kOGTjP9WdRcIIA/DooNVvMjrpfH3Ug+NQ42Wm4lmr2yJ0/AaMeCeJwTlEBF6SV0oZwDF9LNyyq5CFAWNGaRS9eaq4sbB4hxkTi6bmOIAGAsurauR1Ijmbgc9edqcbXzihAYwBqlEmcfV1U8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S3b6k7fj; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S3b6k7fj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTWrw2yP7z2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 12:27:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624849; x=1819160849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mlXvc2rRoY2YlNiSOc7Za57w/VMQm4ZP5P9P9htgZBo=;
  b=S3b6k7fjy14Ugfr8lX1TBu9GHAayuRE/sP/hNVZ03LSePdB7TiXHuA+P
   ART5vUi1Y0k5IH7mZyFJt78k3bWG6LWuAUd8eHq3K1MivpPS9Rhm6wjHv
   iwlFpTFoVKE7feljQYzgHK4dqZZD6irqz4hu37AdppwAFPYK8WxSfm4Ns
   zrABdKb68U/ABenIKxm6SDeeQttkFdBqzh2zhODXJ5iTPKdjhk9T5hnWs
   N29SfPaoxMWgbSDwv+BrBzNyEOtiao9BByt78mmADs5LVPYS1naesFVvD
   bG1Pi47KnIYrTY35kXPsAg/iALYRQFVtj/eaZQBPGkZfmoJoTiW7Obvfq
   A==;
X-CSE-ConnectionGUID: BYRNND2wScetsMFLa4L8OA==
X-CSE-MsgGUID: 5+kZBGnJSqCCZwnRjwP1TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98761097"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98761097"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:25 -0700
X-CSE-ConnectionGUID: dBw0ZWZbTCKZ3Pil1roFLw==
X-CSE-MsgGUID: kbHXBOSMRlutXt3xqVFERg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390092"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:18 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v2 06/13] drivers/base/memory: Add cxl_offline_memory() to offline a physical range
Date: Tue, 25 Aug 2026 04:26:21 +0200
Message-ID: <20260825022628.3651434-7-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
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

A CXL region whose capacity is online as System RAM must be taken
offline before a Secondary Bus Reset of the CXL Downstream Port it is
reached through.

Add cxl_offline_memory() to offline the memory blocks spanning a
physical range, exported in the CXL_MHP namespace since the CXL core is
its only caller.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/base/memory.c  | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/memory.h |  5 +++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index bcfe2d9f4adb..ce89b251d34a 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -1018,6 +1018,42 @@ int walk_memory_blocks(unsigned long start, unsigned long size,
 	return ret;
 }
 
+static int cxl_offline_memory_block(struct memory_block *mem, void *arg)
+{
+	int rc = device_offline(&mem->dev);
+
+	/* device_offline() returns a positive value when already offline. */
+	if (rc > 0)
+		return 0;
+
+	return rc;
+}
+
+/**
+ * cxl_offline_memory - offline the memory blocks spanning a physical range
+ * @start: start of the range, memory-block aligned
+ * @size: size of the range, a multiple of the memory block size
+ *
+ * Offline every memory block in [start, start + size). The blocks are offlined
+ * but not removed, so the range can be brought back online afterward. The
+ * caller owns the range and this performs no validation on it.
+ *
+ * Return: 0 on success, negative errno if a block cannot be offlined.
+ *
+ * Context: process context. Sleeps and takes the memory hotplug lock.
+ */
+int cxl_offline_memory(u64 start, u64 size)
+{
+	int rc;
+
+	lock_device_hotplug();
+	rc = walk_memory_blocks(start, size, NULL, cxl_offline_memory_block);
+	unlock_device_hotplug();
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_offline_memory, "CXL_MHP");
+
 struct for_each_memory_block_cb_data {
 	walk_memory_blocks_func_t func;
 	void *arg;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 463dc02f6cff..5dc0b96fb004 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -149,6 +149,10 @@ static inline unsigned long memory_block_advised_max_size(void)
 {
 	return 0;
 }
+static inline int cxl_offline_memory(u64 start, u64 size)
+{
+	return 0;
+}
 #else /* CONFIG_MEMORY_HOTPLUG */
 extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
@@ -167,6 +171,7 @@ typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
 extern int walk_memory_blocks(unsigned long start, unsigned long size,
 			      void *arg, walk_memory_blocks_func_t func);
 extern int for_each_memory_block(void *arg, walk_memory_blocks_func_t func);
+int cxl_offline_memory(u64 start, u64 size);
 
 extern int memory_group_register_static(int nid, unsigned long max_pages);
 extern int memory_group_register_dynamic(int nid, unsigned long unit_pages);
-- 
2.55.0


