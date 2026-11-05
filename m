Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDFF606A336
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RbH1Y2Uq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLFw74b89z3c98;
	Fri, 06 Nov 2026 08:35:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793914519;
	cv=none; b=fKELBsebjcHcQO0GjNbqWBDlCkIRYmj2ZR8Uc/nBOqZx3EdXV0hyG6GbKwiEQIbjY/532RlYzWTPxSMzIoQCggpmvZJPKkRGOVOfDabHX6KICMnPP4TklBEBkNv2raiTNNN4IGmRbBC+DdB+fj5auzqWjJqEYehhGKKwIETO09saO5iPAIJVBbr2vbJ25+5+SQeYLJDtV/PJpgUU1tXXWLxXtYNlX/rcaY4B9nmTNWTgALX95ZKxl5mAkWHMaEGZOEekaAUwvIxOhP5gKIVENdGdOhPEghK4kmiwz4O1ZP5J30EZLAv91bkw0JDBDRsHG48DvSqJVlAsLjAPwiSuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793914519; c=relaxed/relaxed;
	bh=dEho4RcoGmrcEPSbrhOUHRtwiqikTbr6h0hQZafkpXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B9mjoKjWO29MOZxqsjIOQ/dF6Wm5j6PTYiKGl7z5lym5rir96xaI06YupYixyHa9uLGSPSCEVMsbN65d2OEyloomG2ZzQQJTypDlhWGI8Wxq5EGCYO8jAxDP0CZWLKgp446GBvKE4YYG2k512PoBv/uTJYxSQ0iubiLXHwv81YWe5Dma2PLEc+g4LilGgvaUquLD39Lr+9FTQYXZ+1ndbPEpc00ZAZxGcc3b2xQXhOvtWSQy3Mi+do62ox3rYKUoQOkSnPJf6XYsApwB5bnHUfmgIHWVgP4fXUt/+XmCPUZIC3ZlrnkAAD7/kisPsCwdpl8kI9V1th7A6xGbHBbUEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RbH1Y2Uq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RbH1Y2Uq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLFw668Ylz3c97
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 08:35:18 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B2ECA6061D;
	Thu,  5 Nov 2026 21:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68931F0089F;
	Thu,  5 Nov 2026 21:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914516;
	bh=dEho4RcoGmrcEPSbrhOUHRtwiqikTbr6h0hQZafkpXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RbH1Y2UqPya3J04+p+A9uU/aqwVnT5G4esOhtGUa6bluJ0GJwdjUxyWs6BB1/ltfV
	 0eZaoadmhZspy1QRqjHkCItM5f/a9tApUYvoX3yr/Kd64gO5EOM1gPjfHD1rYxxycz
	 g/a7zIQiEvxlgGAcbeWqatf0r7Ru+1fnkxc7U77RyfjxYEKlLfE9qICMVUWEGKYvZ8
	 /fZgia2nIf9DpQvAMsciLk3gVdKAEAO/wuC6RUAD7Lzxdzmyuwglycw0LqXEwDyHoS
	 OWSliHlLYhRVYisoim/KzkG2/nBh1qsnVsM4lfWmFaR5SIshmHPe+CPIzdNSAoLDKh
	 SNsAv21l96Nxw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:31:03 +0000
Subject: [PATCH 12/13] perf: convert VMA flag tests to use vma_flags_t
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-late-2026-vma-flags-v1-12-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
 David Rientjes <rientjes@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3978; i=ljs@kernel.org;
 h=from:subject:message-id; bh=SvCLNyI6uEKunT8kSOCWdMLbtUbF6342/9JMzd2q8+M=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLefF3eJevtH77x45N1EesXx31gqPvxQIubb63q1F1/W
 bZpqDibdpSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiyzgY/ucU3j7otX2+7X72
 0mdqp2/VbXosf5fDf1lDs8ZEt2q32XsZ/qeqfZf8WTj1rNpv8cIuKXmTgivfZ7dLzFpWnfXXK/d
 CCRMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
perf mmap and mmap event logic.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 kernel/events/core.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 457d75ea7142..6bc5dfacfa48 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7224,6 +7224,7 @@ static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
 		unsigned long va = vma->vm_start + PAGE_SIZE * pagenum;
 		struct page *page = perf_mmap_to_page(rb,
 				vma_start_pgoff(vma) + pagenum);
+		vma_flags_t vma_flags = vma->flags;
 
 		if (page == NULL) {
 			err = -EINVAL;
@@ -7231,8 +7232,9 @@ static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
 		}
 
 		/* Map readonly, perf_mmap_pfn_mkwrite() called on write fault. */
+		vma_flags_clear(&vma_flags, VMA_SHARED_BIT);
 		err = remap_pfn_range(vma, va, page_to_pfn(page), PAGE_SIZE,
-				      vm_get_page_prot(vma->vm_flags & ~VM_SHARED));
+				      vma_flags_to_page_prot(vma_flags));
 		if (err)
 			break;
 	}
@@ -7350,7 +7352,7 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 	if (!perf_mmap_calc_limits(vma, &user_extra, &extra))
 		return -EPERM;
 
-	if (vma->vm_flags & VM_WRITE)
+	if (vma_test(vma, VMA_WRITE_BIT))
 		rb_flags |= RING_BUFFER_WRITABLE;
 
 	rb = rb_alloc(nr_pages,
@@ -7431,7 +7433,7 @@ static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
 
 		WARN_ON(!rb && event->rb);
 
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_test(vma, VMA_WRITE_BIT))
 			rb_flags |= RING_BUFFER_WRITABLE;
 
 		ret = rb_alloc_aux(rb, event, pgoff_start, nr_pages,
@@ -7466,7 +7468,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (event->cpu == -1 && event->attr.inherit)
 		return -EINVAL;
 
-	if (!(vma->vm_flags & VM_SHARED))
+	if (!vma_test(vma, VMA_SHARED_BIT))
 		return -EINVAL;
 
 	ret = security_perf_event_read(event);
@@ -9829,7 +9831,7 @@ static int perf_event_mmap_match(struct perf_event *event,
 {
 	struct perf_mmap_event *mmap_event = data;
 	struct vm_area_struct *vma = mmap_event->vma;
-	int executable = vma->vm_flags & VM_EXEC;
+	bool executable = vma_test(vma, VMA_EXEC_BIT);
 
 	return (!executable && event->attr.mmap_data) ||
 	       (executable && (event->attr.mmap || event->attr.mmap2));
@@ -9862,7 +9864,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 		if (use_build_id)
 			misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
 	}
-	if (!(mmap_event->vma->vm_flags & VM_EXEC))
+	if (!vma_test(mmap_event->vma, VMA_EXEC_BIT))
 		misc |= PERF_RECORD_MISC_MMAP_DATA;
 
 	perf_event_header__init(&mmap_event->event_id.header, &sample,
@@ -9913,19 +9915,19 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	char *buf = NULL;
 	char *name = NULL;
 
-	if (vma->vm_flags & VM_READ)
+	if (vma_test(vma, VMA_READ_BIT))
 		prot |= PROT_READ;
-	if (vma->vm_flags & VM_WRITE)
+	if (vma_test(vma, VMA_WRITE_BIT))
 		prot |= PROT_WRITE;
-	if (vma->vm_flags & VM_EXEC)
+	if (vma_test(vma, VMA_EXEC_BIT))
 		prot |= PROT_EXEC;
 
-	if (vma->vm_flags & VM_MAYSHARE)
+	if (vma_test(vma, VMA_MAYSHARE_BIT))
 		flags = MAP_SHARED;
 	else
 		flags = MAP_PRIVATE;
 
-	if (vma->vm_flags & VM_LOCKED)
+	if (vma_test(vma, VMA_LOCKED_BIT))
 		flags |= MAP_LOCKED;
 	if (vma_is_hugetlb(vma))
 		flags |= MAP_HUGETLB;
@@ -10091,7 +10093,7 @@ static void perf_addr_filters_adjust(struct vm_area_struct *vma)
 	 * Data tracing isn't supported yet and as such there is no need
 	 * to keep track of anything that isn't related to executable code:
 	 */
-	if (!(vma->vm_flags & VM_EXEC))
+	if (!vma_test(vma, VMA_EXEC_BIT))
 		return;
 
 	rcu_read_lock();

-- 
2.56.0


