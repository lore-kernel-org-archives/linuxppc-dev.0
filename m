Return-Path: <linuxppc-dev+bounces-29379-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82685CC6B19
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:09:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3yRY6RyHz3brv;
	Wed, 14 Oct 2026 02:09:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791904169;
	cv=none; b=bLqRZPzl4m7MCH/Osggwpspua/V9V6gYMwYmIQWzHu43kTFa1ynyOMgAubF/BgjWL6c/n1xDykxHs0zrnK3P4IDF8Tnx0t0HzKk0EHKNjXgLyYTsBVSrWROes8mMfIpVYJBees9PpfE34KJCpr00da+YELKIMiN9eyJFaCyusrEgXClnsRwvVuvMeNdJqOe0WdWA2eZnyQqYmhcd7ERq1/XcH4NE+bTYK/tzrgYq+9meyQ6NcvIQiYwjMI8RkgE8spgIDrIIxrXsMpF4BHjvXcQ/R4LnlSHLSlrfKo4m3tNl11eB+BLLE0iDQ2aYg0WN4/YlUPHXnjuCdO8lUR3i4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791904169; c=relaxed/relaxed;
	bh=+lV50szqwhlOdZvvntvc8L71JtBIxPo0bLUpU4NKXmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDcs6T3HGEbvK3w4vbJTx5E8Aez3AvM3MPUlN/0J0znbroVmOYTWHW+LCPDc11LE3udQ63x6kkOUUs9bpkgQwrLZG27SK+dCypVnoCXrkrmZguw2ozeE04662mRrACsS7E/a8ZF1WcoS36mXkt1E+3lL5GQ2atjcSnWd+NR+ssCUZ/dI7e/QqYLPOfkjRgjdIXCbQIo1EiEBQO4HTgnjUYHzGQWoGcWEsQnm9AfdKxa1uPkx40wFRWF0cGnVJNCV+IHHTTsyMBqLw3XmdKwD2fsgsToUhCV0CXKR4XLZJrw72gt1otgXx9Nx3IypCeb2DDA/Yq7iD9AIVtHqy+PrFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktqeL2zX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktqeL2zX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3yRX4Hh3z3brm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 02:09:28 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0C480413D9;
	Tue, 13 Oct 2026 15:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A69E1F000FF;
	Tue, 13 Oct 2026 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904165;
	bh=+lV50szqwhlOdZvvntvc8L71JtBIxPo0bLUpU4NKXmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ktqeL2zXS70o90j0mLV87aoV59vXbCAA5RZbizjqijewnPcZxxXxcgaVuM/cJHeZD
	 +77tfbvmmOOOQzog02DPrCynPFoOSlQGvX65HJWvxXvL3oMYLxXPhSoVSa+3ff8mi8
	 87JKEIDRjPdM3T36BB+eyice44zILgmAzlQTVOqSI3Bo1nj6l5lq4S4VJC93zGxPJs
	 eoBsrTqZ1+SgldZldpqy8abg87G9p6tBnin/ovgydcju28x8wXmBn0l0e8wHty3bI7
	 KxAthEl6r5seQO0FEQzhLLhYkzrc37hYn3auAEejPtkuMirgsi05/hXcCmHwI0gDDI
	 DwHa0lmyqP51w==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 13 Oct 2026 16:04:46 +0100
Subject: [PATCH v6 06/39] mm/vma: tidy up map kernel pages enum values
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
Message-Id: <20261013-b4-mmap-prepare-vma-flag-sanify-v6-6-1aa3c9b139f9@kernel.org>
References: <20261013-b4-mmap-prepare-vma-flag-sanify-v6-0-1aa3c9b139f9@kernel.org>
In-Reply-To: <20261013-b4-mmap-prepare-vma-flag-sanify-v6-0-1aa3c9b139f9@kernel.org>
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
 "Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
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
 fuse-devel@lists.linux.dev, Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Bert Karwatzki <spasswolf@web.de>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4144; i=ljs@kernel.org;
 h=from:subject:message-id; bh=nvhkE4iVPWt6ZMbpDqr0VjZaPTTvkSGU9Bdm3A6LGuc=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLOeRz/czLo4Yv3x6sv1ycktzhI6BvPSbA3Vt26R7t6U
 9h3++r3HaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZjI3B0M/4s/fmjaVPJkAXMV
 SytPWMj7OHntZu7UVjF+U9MT1TKtsgz/4wuqT0tnfZ6X1lgsOuH1seNX+dQSXLKMpls+vxFZtci
 QBQA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

MMAP_MAP_KERNEL_PAGES is a mouthful, discard the MAP_ as that's implied by
MMAP.

Also while we're here delete useless comments for mmap actions whose names
clearly indicate what they are for.

Also update the userland VMA tests to reflect this change.

No functional change intended.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h              | 2 +-
 include/linux/mm_types.h        | 8 ++++----
 mm/util.c                       | 8 ++++----
 tools/testing/vma/include/dup.h | 8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0c17f0932b76..a1f2d375cf7d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4623,7 +4623,7 @@ static inline void mmap_action_map_kernel_pages(struct vm_area_desc *desc,
 {
 	struct mmap_action *action = &desc->action;
 
-	action->type = MMAP_MAP_KERNEL_PAGES;
+	action->type = MMAP_KERNEL_PAGES;
 	action->map_kernel.start = start;
 	action->map_kernel.pages = pages;
 	action->map_kernel.nr_pages = nr_pages;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5413bd10fff2..9ca2ea3664bc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -815,11 +815,11 @@ struct pfnmap_track_ctx {
 
 /* What action should be taken after an .mmap_prepare call is complete? */
 enum mmap_action_type {
-	MMAP_NOTHING,		/* Mapping is complete, no further action. */
-	MMAP_REMAP_PFN,		/* Remap PFN range. */
-	MMAP_IO_REMAP_PFN,	/* I/O remap PFN range. */
+	MMAP_NOTHING,
+	MMAP_REMAP_PFN,
+	MMAP_IO_REMAP_PFN,
 	MMAP_SIMPLE_IO_REMAP,	/* I/O remap with guardrails. */
-	MMAP_MAP_KERNEL_PAGES,	/* Map kernel page range from array. */
+	MMAP_KERNEL_PAGES,	/* Map kernel page range from array. */
 };
 
 /*
diff --git a/mm/util.c b/mm/util.c
index d809e08c7b4d..1660910e2a22 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1467,7 +1467,7 @@ int mmap_action_prepare(struct vm_area_desc *desc)
 		return io_remap_pfn_range_prepare(desc);
 	case MMAP_SIMPLE_IO_REMAP:
 		return simple_ioremap_prepare(desc);
-	case MMAP_MAP_KERNEL_PAGES:
+	case MMAP_KERNEL_PAGES:
 		return map_kernel_pages_prepare(desc);
 	}
 
@@ -1498,7 +1498,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
 	case MMAP_REMAP_PFN:
 		err = remap_pfn_range_complete(vma, action);
 		break;
-	case MMAP_MAP_KERNEL_PAGES:
+	case MMAP_KERNEL_PAGES:
 		err = map_kernel_pages_complete(vma, action);
 		break;
 	case MMAP_IO_REMAP_PFN:
@@ -1521,7 +1521,7 @@ int mmap_action_prepare(struct vm_area_desc *desc)
 	case MMAP_REMAP_PFN:
 	case MMAP_IO_REMAP_PFN:
 	case MMAP_SIMPLE_IO_REMAP:
-	case MMAP_MAP_KERNEL_PAGES:
+	case MMAP_KERNEL_PAGES:
 		WARN_ON_ONCE(1); /* nommu cannot handle these. */
 		break;
 	}
@@ -1542,7 +1542,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
 	case MMAP_REMAP_PFN:
 	case MMAP_IO_REMAP_PFN:
 	case MMAP_SIMPLE_IO_REMAP:
-	case MMAP_MAP_KERNEL_PAGES:
+	case MMAP_KERNEL_PAGES:
 		WARN_ON_ONCE(1); /* nommu cannot handle this. */
 
 		err = -EINVAL;
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 077df510a311..023ad6092e9c 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -454,11 +454,11 @@ static __always_inline bool vma_flags_empty(const vma_flags_t *flags)
 
 /* What action should be taken after an .mmap_prepare call is complete? */
 enum mmap_action_type {
-	MMAP_NOTHING,		/* Mapping is complete, no further action. */
-	MMAP_REMAP_PFN,		/* Remap PFN range. */
-	MMAP_IO_REMAP_PFN,	/* I/O remap PFN range. */
+	MMAP_NOTHING,
+	MMAP_REMAP_PFN,
+	MMAP_IO_REMAP_PFN,
 	MMAP_SIMPLE_IO_REMAP,	/* I/O remap with guardrails. */
-	MMAP_MAP_KERNEL_PAGES,	/* Map kernel page range from an array. */
+	MMAP_KERNEL_PAGES,	/* Map kernel page range from array. */
 };
 
 /*

-- 
2.55.0


