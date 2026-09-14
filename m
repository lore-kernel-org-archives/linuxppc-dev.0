Return-Path: <linuxppc-dev+bounces-27231-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602AAC88E75
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 15:03:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hk7gj0Xhyz30MZ;
	Tue, 15 Sep 2026 01:03:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789398193;
	cv=none; b=FZ5Un7iQMPW2RjpWE1S5WuGufO1PEePyT7c6wZsDSVGr68sNzu67Bgxv8HZ0pVcOYeJ885cXhkouW+uctvNf0LbHVbD69HF5lmerqhMp8KqC3AeGcscZD4lBbWIJkWJURZfKAbeYTn+gPyiBxua+aFK09C0UzwMQGemZe2oNlmwCl68mSGX2Ppps3n61Z0aL72ybwxnhMvbAjm9ZumROEwnVXTbbqp6/D4rlwTZPUA//f2lmr4DXbA+eMThTwQ8eRQDrnYhiSaBOVb8eePmXd0cUhuHlbLKZ9nKin+8TX5cfrBhb9fsqvuoScpA5PzWpiTwHbc7wkH4cEgNJ5s7IKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789398193; c=relaxed/relaxed;
	bh=dIglkKIN3/W3qByFkLNG0bBOvws5ewzjysWBscsc5Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMj6vUcPrp+hJsGGPj6VCnCQ5HdKokLFjZ84ZOx95IYz7BFEJTx1guAzMR1NtMgeQDe0ZudSVqmXueRQUYZ20mAYWttaosCBopniX7Nivw6b4cQmzrVbktl5Zz0k3vNp2zRP/dy+JrxpJY2aLArhmlcVhOOjDLLbibW3jjQqnVwpuv5pty+5vC1Z7eLpuozFe+WcSWVEv+xd3+B5/3C1sj4h/z0iTVGB6sYK5hoHe+/BCxW9yRwzH0ogxvcXglYD7i5Uc4QytHeaQ00nlII2CUovzaoO0xNwfTf2oNIMmH/lkb9L0+iHC3Pfp9mGjH1UiMIAe8Mtpy+DzqWRJtfzzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPD9gr6x; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPD9gr6x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hk7gh0MHMz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 01:03:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E4F0B60258;
	Mon, 14 Sep 2026 15:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936841F00893;
	Mon, 14 Sep 2026 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789398189;
	bh=dIglkKIN3/W3qByFkLNG0bBOvws5ewzjysWBscsc5Hk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lPD9gr6x3UMX0UN1vV291JL3OZaZshRC1NwUhZmw/mMNefV6y+atGM5mjggFSf5mO
	 sPHAAfn8fXkFUrLMBdHi3LxbDJX8VQrg8zLAeehpP3Noi3scH1mCNMq391jWrGhPNZ
	 4lFUyIMXKK1i2Ng7o4HG2+P9TSMlXGYFNUpgACzx1SshXx+0dl3dtlvtnAjAOu6Ony
	 1PNw/EpTBu9/DWr7T8qNne5LEJzkMvftVxRJ7W65WXDXlwaIvVwCHrwF78ZZicGH6d
	 xZArejpZ5SOtZBL+IYbTqkDEjNrmCsh5UhFhqpF+uQfhsFhnDy6KTh0MG6e7+Wsfqi
	 XflhGt9q+Rsfg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Mon, 14 Sep 2026 15:57:28 +0100
Subject: [PATCH v2 08/40] mm: add mmap action for discontiguous kernel page
 mapping
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-8-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, 
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
 Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Michal Hocko <mhocko@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Xu Xin <xu.xin@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
 linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
 fuse-devel@lists.linux.dev, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12992; i=ljs@kernel.org;
 h=from:subject:message-id; bh=KTopW2/sxfulwf59WpGpEZd8vJ7w9dPdvS81FaJO3IY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJWcK872izbIBZ4ZdJMQT5Vsb8PGZZLLMnh8zDsnmf4r
 Wqhg7RfRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACaSVcfwzypb7MreTUf6Yypu
 h6meXNKxeKrlnLmZEZrzwoSFsyxi3zMy7JH6lHItklfqycGCZbIMDGvtGj+3Gdyrc7ktXK/eEb2
 HFQA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The existing kernel page mapping mmap actions allow for partial and full
mapping of an array of struct page pointers.

However some drivers require the mapping of discontiguous ranges. Permit
this by providing discontig_kernel_page_ops which allows a driver to
specify how the operation should begin and how batches of pages should be
retrieved.

It uses the minimum exposed interface to do so, providing address, page
offset and both vm_private_data state and a local private state object.

ops->init can establish state for the operation, and ops->get outputs the
pages to map and their count. Should an error arise the core unmaps the
VMA, invoking vm_ops->close, which is therefore where any state established
by ops->init is released.

Batches may not exceed the VMA, but may map less than its full range in
case the driver wishes to allow the user to map an area larger than the
available data.

To use it, users invoke mmap_action_map_discontig_kernel_pages() with
initial local private state and a set of operations.

Users can then use one of the provided helper functions to perform an
action:

* discontig_kernel_map_abort() - Abort and leave the mapping as it has
  been accumulated so far.
* discontig_kernel_map_page() - Map a single page, or a compound page given
  its head page.
* discontig_kernel_map_page_range() - Maps a struct page ** array of a
  specified count.

The userland VMA tests are updated accordingly.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h              |  45 +++++++++++++++++
 include/linux/mm_types.h        |  44 +++++++++++++++-
 mm/internal.h                   |   3 ++
 mm/memory.c                     | 108 ++++++++++++++++++++++++++++++++++++++--
 mm/util.c                       |   7 +++
 tools/testing/vma/include/dup.h |  11 +++-
 6 files changed, 209 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a1f2d375cf7d..2a92193ac6a5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4647,10 +4647,55 @@ static inline void mmap_action_map_kernel_pages_full(struct vm_area_desc *desc,
 				     vma_desc_pages(desc));
 }
 
+static inline
+void mmap_action_map_discontig_kernel_pages(struct vm_area_desc *desc,
+		void *init_private, const struct discontig_kernel_page_ops *ops)
+{
+	struct mmap_action *action = &desc->action;
+
+	action->type = MMAP_DISCONTIG_KERNEL_PAGES;
+	action->map_kernel_discontig.init_private = init_private;
+	action->map_kernel_discontig.ops = ops;
+}
+
 int mmap_action_prepare(struct vm_area_desc *desc);
 int mmap_action_complete(struct vm_area_struct *vma,
 			 struct mmap_action *action, bool is_compat);
 
+static inline void
+discontig_kernel_map_abort(struct discontig_kernel_page_state *state)
+{
+	state->action = DISCONTIG_KERNEL_PAGE_ABORT;
+}
+
+static inline void
+discontig_kernel_map_page(struct discontig_kernel_page_state *state,
+			  struct page *page)
+{
+	struct folio *folio = page_folio(page);
+
+	if (folio_test_large(folio)) {
+		VM_WARN_ON_ONCE(page != folio_page(folio, 0));
+		state->action = DISCONTIG_KERNEL_PAGE_MAP_COMPOUND_PAGE;
+		state->__folio = folio;
+		state->__nr_pages = min(state->nr_pages_remain,
+					folio_nr_pages(folio));
+	} else {
+		state->action = DISCONTIG_KERNEL_PAGE_MAP_PAGE;
+		state->__page = page;
+		state->__nr_pages = 1;
+	}
+}
+
+static inline void
+discontig_kernel_map_page_range(struct discontig_kernel_page_state *state,
+				struct page **page_arr, unsigned long nr_pages)
+{
+	state->action = DISCONTIG_KERNEL_PAGE_MAP_PAGE_RANGE;
+	state->__page_arr = page_arr;
+	state->__nr_pages = nr_pages;
+}
+
 /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9ca2ea3664bc..0cb4f9603956 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -818,8 +818,44 @@ enum mmap_action_type {
 	MMAP_NOTHING,
 	MMAP_REMAP_PFN,
 	MMAP_IO_REMAP_PFN,
-	MMAP_SIMPLE_IO_REMAP,	/* I/O remap with guardrails. */
-	MMAP_KERNEL_PAGES,	/* Map kernel page range from array. */
+	MMAP_SIMPLE_IO_REMAP,		/* I/O remap with guardrails. */
+	MMAP_KERNEL_PAGES,		/* Map kernel page range from array. */
+	MMAP_DISCONTIG_KERNEL_PAGES,	/* Map kernel discontig page range. */
+};
+
+enum discontig_kernel_page_action {
+	DISCONTIG_KERNEL_PAGE_ABORT,
+	DISCONTIG_KERNEL_PAGE_MAP_PAGE,
+	DISCONTIG_KERNEL_PAGE_MAP_COMPOUND_PAGE,
+	DISCONTIG_KERNEL_PAGE_MAP_PAGE_RANGE,
+};
+
+struct discontig_kernel_page_state {
+	/* Map state. */
+	const unsigned long start;	/* Start address of VMA. */
+	const unsigned long end;	/* End address of VMA. */
+	unsigned long addr;		/* The current address to be mapped. */
+	pgoff_t pgoff;			/* The current pgoff to be mapped. */
+	unsigned long nr_pages_mapped;	/* The number of pages mapped. */
+	unsigned long nr_pages_remain;	/* The number of pages remaining. */
+
+	/* User-defined state. */
+	void *vm_private_data;		/* VMA private data. */
+	void *private;			/* Mapping private data. */
+
+	/* Users should not touch these, use discontig_kernel_map_*() helpers. */
+	enum discontig_kernel_page_action action;
+	union {
+		struct page *__page;
+		struct folio *__folio;
+		struct page **__page_arr;
+	};
+	unsigned long __nr_pages;
+};
+
+struct discontig_kernel_page_ops {
+	int (*init)(void *vm_private_data, void **private);
+	int (*get)(struct discontig_kernel_page_state *state);
 };
 
 /*
@@ -844,6 +880,10 @@ struct mmap_action {
 			unsigned long nr_pages;
 			pgoff_t pgoff;
 		} map_kernel;
+		struct {
+			void *init_private;
+			const struct discontig_kernel_page_ops *ops;
+		} map_kernel_discontig;
 	};
 	enum mmap_action_type type;
 
diff --git a/mm/internal.h b/mm/internal.h
index 0cd26277a4c8..3a395e8c224c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1514,6 +1514,9 @@ int simple_ioremap_prepare(struct vm_area_desc *desc);
 int map_kernel_pages_prepare(struct vm_area_desc *desc);
 int map_kernel_pages_complete(struct vm_area_struct *vma,
 			      struct mmap_action *action);
+int map_discontig_kernel_pages_prepare(struct vm_area_desc *desc);
+int map_discontig_kernel_pages_complete(struct vm_area_struct *vma,
+					struct mmap_action *action);
 
 static inline int io_remap_pfn_range_prepare(struct vm_area_desc *desc)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 448342883e9d..42f084517247 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2609,17 +2609,23 @@ int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_insert_pages);
 
+static void __map_kernel_pages_prepare(struct vm_area_desc *desc)
+{
+	if (vma_desc_test(desc, VMA_MIXEDMAP_BIT))
+		return;
+
+	VM_WARN_ON_ONCE(mmap_read_trylock(desc->mm));
+	VM_WARN_ON_ONCE(vma_desc_test(desc, VMA_PFNMAP_BIT));
+	vma_desc_set_flags(desc, VMA_MIXEDMAP_BIT);
+}
+
 int map_kernel_pages_prepare(struct vm_area_desc *desc)
 {
 	const struct mmap_action *action = &desc->action;
 	const unsigned long addr = action->map_kernel.start;
 	unsigned long nr_pages, end;
 
-	if (!vma_desc_test(desc, VMA_MIXEDMAP_BIT)) {
-		VM_WARN_ON_ONCE(mmap_read_trylock(desc->mm));
-		VM_WARN_ON_ONCE(vma_desc_test(desc, VMA_PFNMAP_BIT));
-		vma_desc_set_flags(desc, VMA_MIXEDMAP_BIT);
-	}
+	__map_kernel_pages_prepare(desc);
 
 	nr_pages = action->map_kernel.nr_pages;
 	end = addr + PAGE_SIZE * nr_pages;
@@ -2640,6 +2646,98 @@ int map_kernel_pages_complete(struct vm_area_struct *vma,
 			    &nr_pages, vma->vm_page_prot);
 }
 
+int map_discontig_kernel_pages_prepare(struct vm_area_desc *desc)
+{
+	const struct mmap_action *action = &desc->action;
+	const struct discontig_kernel_page_ops *ops =
+		action->map_kernel_discontig.ops;
+
+	/* At minimum need to be able to get pages. */
+	if (WARN_ON_ONCE(!ops->get))
+		return -EINVAL;
+
+	__map_kernel_pages_prepare(desc);
+	return 0;
+}
+
+static int apply_discontig_action(struct vm_area_struct *vma,
+				  struct discontig_kernel_page_state *state)
+{
+	unsigned long nr_pages = state->__nr_pages;
+	unsigned long addr = state->addr;
+	unsigned long i;
+
+	if (state->action == DISCONTIG_KERNEL_PAGE_MAP_PAGE)
+		return insert_page(vma, addr, state->__page,
+				   vma->vm_page_prot, /*mkwrite=*/false);
+	if (state->action == DISCONTIG_KERNEL_PAGE_MAP_PAGE_RANGE)
+		return insert_pages(vma, addr, state->__page_arr,
+				    &nr_pages, vma->vm_page_prot);
+
+	/* Compound folio - have to iterate through each page. */
+	for (i = 0; i < nr_pages; i++, addr += PAGE_SIZE) {
+		struct page *page = folio_page(state->__folio, i);
+		int err;
+
+		err = insert_page(vma, addr, page, vma->vm_page_prot,
+				  /*mkwrite=*/false);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+int map_discontig_kernel_pages_complete(struct vm_area_struct *vma,
+					struct mmap_action *action)
+{
+	const struct discontig_kernel_page_ops *ops =
+		action->map_kernel_discontig.ops;
+	struct discontig_kernel_page_state state = {
+		.start = vma->vm_start,
+		.end = vma->vm_end,
+		.addr = vma->vm_start,
+		.pgoff = vma->vm_pgoff,
+		.nr_pages_mapped = 0,
+		.nr_pages_remain = vma_pages(vma),
+		.vm_private_data = vma->vm_private_data,
+		.private = action->map_kernel_discontig.init_private,
+	};
+	int err = 0;
+
+	if (ops->init)
+		err = ops->init(vma->vm_private_data, &state.private);
+	if (err)
+		return err;
+
+	do {
+		unsigned long end, pgoff_end;
+		unsigned long nr_pages;
+
+		/* Default to abort. */
+		state.action = DISCONTIG_KERNEL_PAGE_ABORT;
+		err = ops->get(&state);
+		if (err || state.action == DISCONTIG_KERNEL_PAGE_ABORT)
+			return err;
+		nr_pages = state.__nr_pages;
+
+		if (!nr_pages || nr_pages > state.nr_pages_remain)
+			return -EINVAL;
+		end = state.addr + PAGE_SIZE * nr_pages;
+		pgoff_end = state.pgoff + nr_pages;
+
+		err = apply_discontig_action(vma, &state);
+		if (err)
+			return err;
+
+		state.addr = end;
+		state.pgoff = pgoff_end;
+		state.nr_pages_mapped += nr_pages;
+		state.nr_pages_remain -= nr_pages;
+	} while (state.addr < vma->vm_end);
+
+	return 0;
+}
+
 /**
  * vm_insert_page - insert single page into user vma
  * @vma: user vma to map to
diff --git a/mm/util.c b/mm/util.c
index 438170490e7f..c5ee52aede1e 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1469,6 +1469,8 @@ int mmap_action_prepare(struct vm_area_desc *desc)
 		return simple_ioremap_prepare(desc);
 	case MMAP_KERNEL_PAGES:
 		return map_kernel_pages_prepare(desc);
+	case MMAP_DISCONTIG_KERNEL_PAGES:
+		return map_discontig_kernel_pages_prepare(desc);
 	}
 
 	WARN_ON_ONCE(1);
@@ -1501,6 +1503,9 @@ int mmap_action_complete(struct vm_area_struct *vma,
 	case MMAP_KERNEL_PAGES:
 		err = map_kernel_pages_complete(vma, action);
 		break;
+	case MMAP_DISCONTIG_KERNEL_PAGES:
+		err = map_discontig_kernel_pages_complete(vma, action);
+		break;
 	case MMAP_IO_REMAP_PFN:
 	case MMAP_SIMPLE_IO_REMAP:
 		/* Should have been delegated. */
@@ -1522,6 +1527,7 @@ int mmap_action_prepare(struct vm_area_desc *desc)
 	case MMAP_IO_REMAP_PFN:
 	case MMAP_SIMPLE_IO_REMAP:
 	case MMAP_KERNEL_PAGES:
+	case MMAP_DISCONTIG_KERNEL_PAGES:
 		WARN_ON_ONCE(1); /* nommu cannot handle these. */
 		break;
 	}
@@ -1543,6 +1549,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
 	case MMAP_IO_REMAP_PFN:
 	case MMAP_SIMPLE_IO_REMAP:
 	case MMAP_KERNEL_PAGES:
+	case MMAP_DISCONTIG_KERNEL_PAGES:
 		WARN_ON_ONCE(1); /* nommu cannot handle this. */
 
 		err = -EINVAL;
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 1098655a5f4a..1d5f6b3cbd21 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -457,14 +457,17 @@ enum mmap_action_type {
 	MMAP_NOTHING,
 	MMAP_REMAP_PFN,
 	MMAP_IO_REMAP_PFN,
-	MMAP_SIMPLE_IO_REMAP,	/* I/O remap with guardrails. */
-	MMAP_KERNEL_PAGES,	/* Map kernel page range from array. */
+	MMAP_SIMPLE_IO_REMAP,		/* I/O remap with guardrails. */
+	MMAP_KERNEL_PAGES,		/* Map kernel page range from array. */
+	MMAP_DISCONTIG_KERNEL_PAGES,	/* Map kernel discontig page range. */
 };
 
 /*
  * Describes an action an mmap_prepare hook can instruct to be taken to complete
  * the mapping of a VMA. Specified in vm_area_desc.
  */
+struct discontig_kernel_page_ops;
+
 struct mmap_action {
 	union {
 		struct {
@@ -483,6 +486,10 @@ struct mmap_action {
 			unsigned long nr_pages;
 			pgoff_t pgoff;
 		} map_kernel;
+		struct {
+			void *init_private;
+			const struct discontig_kernel_page_ops *ops;
+		} map_kernel_discontig;
 	};
 	enum mmap_action_type type;
 

-- 
2.55.0


