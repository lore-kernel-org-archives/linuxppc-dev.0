Return-Path: <linuxppc-dev+bounces-26825-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BCAC79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 20:03:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfZcw1KNVz2y8p;
	Wed, 09 Sep 2026 06:03:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788897808;
	cv=none; b=Tpxk44ONLeGZiwhPg+BuQvhZJxUBqHfik8REKWaP90hXl2/TG79DUETIlBZ2v1xfaxE1k7KgjWSxiRn3lnpvzJqcxG3DNfJ3K0Atlna5NiAu0zuezmbcZjhw4qZau5xL5Chv7G9efEivTcNtjN00kBN/lg0L9oOq5334HD9eckQBeTD7sjUoQGpuC6BPd92xegzxO1vRnutnhFmL0sJLbjQbEjKvsRIWw83pgT9Nuz2iEFMUSijUG3TFx7R0XL1rIZb7mnWAELGJ1wt+KEpfdwL5G35TM07DR/bRfdH+/vmMLZmwX/bqr3FzDp1J/h25+FIhbuaGKlAIqtoGJ6Viyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788897808; c=relaxed/relaxed;
	bh=N/5irUa19/BDN2FcWAIdugpCz9h2TSbkek/eDpHMNwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbHC0Ow0AOaQoq1rLgaHdnV286oceEB9TAc652Alu0LMrg2shjuW82KVDw2we+g/2OttlYk1AiKfenPZTzx24wan2rFpYXCPBlA7YBEeR/KrqiDvIs5SGxyk3BYfeTOBAd9mqzhdj1oT/nD4KBU2LEqAqH0UIMcZnWW13sblC+eNY7bZ446DPyBQalQCP+QT/xtuvfthBrqsKyJwTh5rYkXUPp9N08IMDl6ILM71E/YncCjPFVU6KgracadU/KtxhG6COSDNbEYOdz3TNffNOhBmKWcrat4NYwKRtp32wrQ8WnNPQjS9EO80gNeEHupqTc9TS665ABvMKgJ4cfj4Mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ku2gwpBF; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ku2gwpBF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfZcv2p8Qz2y1F
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 06:03:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 780BF43862;
	Tue,  8 Sep 2026 20:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BCA1F00A3D;
	Tue,  8 Sep 2026 20:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788897805;
	bh=N/5irUa19/BDN2FcWAIdugpCz9h2TSbkek/eDpHMNwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ku2gwpBFwbzAQ9WpRHCfTbmHrqoxH1O79eE6GJgUgEmxCzV2zSbqhIvZn3z1K/LOW
	 jQtxKcljhwwX6BHLOw0jrP1qLbw9bq481GXnBDTftZNwaufIQ2FNDR4wdA7+QSL/+n
	 bOnrpLTwrkyLBdXeZokkp60zx/ExmXt6G3L40ulIFvnIVT8Ju5kOVZ9/vbmWVJIL8j
	 V+DXIhJB16u11Zkd92DE8Mm/4GX5O1l4UCk/gk8xTOuqXTcGQ655Gwv90CaCup9Eoi
	 Ml/J+p32Cy5gI6XpNafasUy7A7/vLiCxm1MjWPRev15TMj9H5pIh/hgmbhtufTj48M
	 Et/8nwZmluVdg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 08 Sep 2026 21:01:06 +0100
Subject: [PATCH 02/39] mm/vma: introduce and use vma_[flags_]can_merge()
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
Message-Id: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-2-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
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
 Wei Xu <weixugc@google.com>, Xu Xin <xu.xin16@zte.com.cn>, 
 Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
 Miklos Szeredi <miklos@szeredi.hu>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3665; i=ljs@kernel.org;
 h=from:subject:message-id; bh=0UU6lGSovOVzdqVhnWVD0ARbEiD8RROdurC1mTuwfD8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIWZG64vd1F9WqzdKTnan0Lh2BNLUnLtmu8U8UdzksrM
 Z+OE1zVUcrCIMbFICumyPL8i/j+IJGweZ0X/N1g5rAygQxh4OIUgIncn8zI8CNQ+Oi6+/Y7/5sd
 f1oxhWPnFNGGvybMWvt5247edb5wxYzhf37AUbvU9ayqj7YzrBEPP1yw45fFhkwVTbkIIT35+q1
 /2AE=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Replace the open-coded VMA_SPECIAL_FLAGS check in the VMA merge logic with
two new functions vma_flags_can_merge() and vma_can_merge() and update the
merge logic to use the former.

This abstracts the check and expresses it in terms of the desired behaviour
rather than an arbitrary and confusing VMA flag.

This also lays the groundwork for making further improvements in VMA flag
usage.

Also update the userland VMA tests to reflect the change.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h              | 21 +++++++++++++++++++++
 mm/vma.c                        | 19 +++++++++++--------
 tools/testing/vma/include/dup.h |  5 +++++
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c49ef99b4413..83979ec28f5c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1612,6 +1612,27 @@ static inline bool vma_is_shared_maywrite(const struct vm_area_struct *vma)
 	return is_shared_maywrite(&vma->flags);
 }
 
+/**
+ * vma_flags_can_merge() - Do the specified VMA flags permit the VMA to be
+ * merged with another?
+ * @flags: The VMA flags to test.
+ * Returns: true if the flags permit merging, false otherwise.
+ */
+static inline bool vma_flags_can_merge(const vma_flags_t *flags)
+{
+	return !vma_flags_test_any_mask(flags, VMA_SPECIAL_FLAGS);
+}
+
+/**
+ * vma_can_merge() - Do @vma's flags permit it to be merged with another VMA?
+ * @vma: The VMA to test.
+ * Returns: true if the flags permit merging, otherwise false.
+ */
+static inline bool vma_can_merge(const struct vm_area_struct *vma)
+{
+	return vma_flags_can_merge(&vma->flags);
+}
+
 /**
  * vma_kernel_pagesize - Default page size granularity for this VMA.
  * @vma: The user mapping.
diff --git a/mm/vma.c b/mm/vma.c
index 2a90c509bb31..0db2fc306993 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -924,13 +924,14 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 
 	vmg->state = VMA_MERGE_NOMERGE;
 
+	if (!vma_flags_can_merge(&vmg->vma_flags))
+		return NULL;
 	/*
-	 * If a special mapping or if the range being modified is neither at the
-	 * furthermost left or right side of the VMA, then we have no chance of
-	 * merging and should abort.
+	 * If the range being modified is neither at the furthermost left or
+	 * right side of the VMA, then we have no chance of merging and should
+	 * abort.
 	 */
-	if (vma_flags_test_any_mask(&vmg->vma_flags, VMA_SPECIAL_FLAGS) ||
-	    (!left_side && !right_side))
+	if (!left_side && !right_side)
 		return NULL;
 
 	if (left_side)
@@ -1152,9 +1153,11 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 
 	vmg->state = VMA_MERGE_NOMERGE;
 
-	/* Special VMAs are unmergeable, also if no prev/next. */
-	if (vma_flags_test_any_mask(&vmg->vma_flags, VMA_SPECIAL_FLAGS) ||
-	    (!prev && !next))
+	if (!vma_flags_can_merge(&vmg->vma_flags))
+		return NULL;
+
+	/* VMAs with no prev/next are unmergeable. */
+	if (!prev && !next)
 		return NULL;
 
 	can_merge_left = can_vma_merge_left(vmg);
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 16c09dac59d9..2fd422789717 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1647,3 +1647,8 @@ static inline bool file_is_dev_zero(const struct file *file)
 {
 	return file && file->f_op == &zero_fops;
 }
+
+static inline bool vma_flags_can_merge(const vma_flags_t *flags)
+{
+	return !vma_flags_test_any_mask(flags, VMA_SPECIAL_FLAGS);
+}

-- 
2.55.0


