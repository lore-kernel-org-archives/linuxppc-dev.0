Return-Path: <linuxppc-dev+bounces-28833-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6BDCA5FEF
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 16:34:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxrpm22Fnz2yTQ;
	Sun, 04 Oct 2026 03:34:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791045296;
	cv=none; b=JF4T1q2Ify8T5jV7lHBvRbp+D+W/Pa4ix5efYfsDrMWRUhBXYTdDNNEFIfdiN+aNmYI/ho5ux81beY4JuXYMBAwDwLdYuw/DBzvmhY0r79OFw29s212zNN6b0abK5HPE0kOS+gYYLBHc0OKbFbyr4Dzik+whSVINGxHQVE+LFTmvD4oDu82dvTSdvj580BH6LzHSvWrMwLOdiRUZ+Ykv3C/T32biwcBmNn+ABKWLjKuKstqeD/Vfp6D/tiBG0BJe4p1fyPk74tYBOIsvxDMybKEvA3yMzyelYe1AlrqY8R1p26CfHgrFC+2wjxi0rgLeFhB2mQHuP7OSQmaFlXNKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791045296; c=relaxed/relaxed;
	bh=SAzG9Wth1XJ2c0bU3DI60XqRT1mNgvn5WEld38uFlsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1HNaooUv8wki/PqwDUO2EG9MsmyYjT1rt/kaCUyt/PDg4Q8DiVjSZmMmxWj2eFlTIFTy4Xpls2b0qVWSVL+SDEpJTL5PgfOI51Y8EqSmz3xdqqJnQLJP/rVDzydNqe89UL7e+D1RbTLrvSGkABBIgLlSm81vdCi2qBTDgsm+klP0auHt0GUBfiIWpPK/tNPYmMF3Bul3/TI9cBC4on2tbUnXXyyn8TR3Uo+NSZ+NKpMMn7JwfLqus/MmPTjYwewUfAj5FdwRmtMpdLRAyknLyeEMYxm/7UbdCUyazHScQcgVG3zAwvFBa5HeqrZQOR6L6fXzD/byh6efJqA4VMKLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4CQZxo1; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4CQZxo1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxrpl38cHz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 03:34:55 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 27EA260D9B;
	Sat,  3 Oct 2026 16:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60471F008A0;
	Sat,  3 Oct 2026 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791045292;
	bh=SAzG9Wth1XJ2c0bU3DI60XqRT1mNgvn5WEld38uFlsY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Y4CQZxo1BtJ0+b+5nvGcdGcmA4mnH3w+KvJWcRsFOv5Qb1wcxR7CNb1bTkFS59HOZ
	 7HF0P8fPX9XBVqCA/3u6hoUPjBOYSJHeC7nDDJVAWKlTQQRWGCw9USsEx/zu35OKsR
	 PvvCt7RljPuNCNIC4Qo2mX2PY6J6fBGxt8L728+PUVxvb/hujYkxyUlK/F4mD7dX0S
	 P/AS0RConAL5znw1iR43LSCLAa57KlHUE7Twxzyf0SJSyY65jP2BKwWdxmDgJZbJ3q
	 8mKn8fZ0zJZpr/nvxlIQb3dy/paAsAPfyCwRmBZ7Aqq3eO9G1AhSk65RWyjGC4ZoUz
	 GtOYV9o+9tZKg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 03 Oct 2026 17:32:36 +0100
Subject: [PATCH v4 05/38] mm: make map_kernel_pages_[prepare,complete]
 internal and unexported
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
Message-Id: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-5-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
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
 fuse-devel@lists.linux.dev, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2708; i=ljs@kernel.org;
 h=from:subject:message-id; bh=W5EJA/cmsVT7jDTw6eYY8+j+S742rFhYZzwOfLirwec=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIO6qkrnTC6l3f3qMKHbUcOZHfes3wbtXo1R09VgSdbm
 /NFFpe7HaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZhI1R6GvxKLbxU+dbp/frmO
 6/N7PvnKOwI3bLssz/e560cDh2zxwmSG/x6dhz5Nkdfd1jbhavufGYESxrmBvgbpZQHhLSfb2R2
 nMQAA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

There's no reason to export the symbols for these functions which are only
called from internal mm logic, additionally there's no reason for them to
be declared in mm.h.

This patch therefore removes the exports and moves the declarations to
mm/internal.h.

No functional change intended.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h | 3 ---
 mm/internal.h      | 3 +++
 mm/memory.c        | 2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 68250ece4219..0c17f0932b76 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4768,9 +4768,6 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
 int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
 			struct page **pages, unsigned long *num);
-int map_kernel_pages_prepare(struct vm_area_desc *desc);
-int map_kernel_pages_complete(struct vm_area_struct *vma,
-			      struct mmap_action *action);
 int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
 int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
diff --git a/mm/internal.h b/mm/internal.h
index 061a87f9c3fb..fc4e249e2343 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1512,6 +1512,9 @@ int remap_pfn_range_prepare(struct vm_area_desc *desc);
 int remap_pfn_range_complete(struct vm_area_struct *vma,
 			     struct mmap_action *action);
 int simple_ioremap_prepare(struct vm_area_desc *desc);
+int map_kernel_pages_prepare(struct vm_area_desc *desc);
+int map_kernel_pages_complete(struct vm_area_struct *vma,
+			      struct mmap_action *action);
 
 static inline int io_remap_pfn_range_prepare(struct vm_area_desc *desc)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 926276d41920..448342883e9d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2628,7 +2628,6 @@ int map_kernel_pages_prepare(struct vm_area_desc *desc)
 
 	return 0;
 }
-EXPORT_SYMBOL(map_kernel_pages_prepare);
 
 int map_kernel_pages_complete(struct vm_area_struct *vma,
 			      struct mmap_action *action)
@@ -2640,7 +2639,6 @@ int map_kernel_pages_complete(struct vm_area_struct *vma,
 			    action->map_kernel.pages,
 			    &nr_pages, vma->vm_page_prot);
 }
-EXPORT_SYMBOL(map_kernel_pages_complete);
 
 /**
  * vm_insert_page - insert single page into user vma

-- 
2.55.0


