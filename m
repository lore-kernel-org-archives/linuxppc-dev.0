Return-Path: <linuxppc-dev+bounces-27619-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274A4C982D9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:39:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm1gC68wzz30MY;
	Fri, 18 Sep 2026 02:39:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789663159;
	cv=none; b=QMqaTPDO+q+Zx2DuPxIi7tCb/b0jjlUe1Ink2KR3360OF/Mpqk4HKPyNwfOPeGalNVFXxn8heIw7rD9jgD9oLxy7ZtTcuawNJ7aD+mhVeZj0P9ijfxV2pW/Tgj/T6VVFYZohn2a+re5pW+j6qHyCo9e1Hls7KD7o9raRASItfFKXlmmrSBd2R3e55XZ+cPpH3p1XyjWFF9XDPZg3xLlUK73ZSSRbWvCJ3PEqLYHSnN2fOWltzYss8Hn6xbLh/JQHNR/pCyy6aX1UVJaXXami64VlwurWZCTL1YYxVbNaoKoMa1eFzYscLb9+FVt9YkLFdJntWePbPpPutCFQZGqgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789663159; c=relaxed/relaxed;
	bh=9WoUWUiccCZ5pmncdG/fVn1uDF622HEjGzqeAT5aHc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d27VtgrecNAouNUzeyD/bBzFPk2tO2H4o3dDOffuruhfITmlThikTO+O+3UxODxBDCTBnXO323+wW9z3ThJu6xZwVI4n/Z1ZHIzIS+xxa4ok9QASDHKmrwwuaQvCixBQ/dpyibxtkpONccYnk275VoUz8FfuKHmuqRwAjRJeMZqk17OfYv9D6N53BW0HAuChYRct2u/bDhS3cbTSjriU4Rl54pNNh5nL0T322LVEMSaMbWT+9td5uh2V7S5EOFH4vxODgDoRoIDt8mlOtsPRlF0d5lJbI9Vh9W1M6/I2ETxDSrGUVzyzIVS8h9tRoyOoRIyuneGlkfCtgn5eHa7Uwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JuzlckQR; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JuzlckQR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm1gC0Gtrz30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 02:39:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1839460230;
	Thu, 17 Sep 2026 16:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FFA1F00898;
	Thu, 17 Sep 2026 16:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663156;
	bh=9WoUWUiccCZ5pmncdG/fVn1uDF622HEjGzqeAT5aHc8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JuzlckQR6v/NzH0mtru1XZ7iqyxCxBjrCwCFsUHW609jPCf8U6sfhyPJkkpToF69f
	 siJ7N2NXwspDpQ5dJIIyLpRq7MwSgE3R3mqg5OrgAtBYXQZyoeaTTM2m6j28o+aBbX
	 I7FSiMwxg1YdjTyYq2YbYkTvH901cTdfYaUc365eMr8X4iPtaA7EQGoTbcu8Y7USWP
	 bzvY4XKh3JpReezKG88DwuCuMK1EFa2lyia7xTBCesd95C4tljlOVn0ygfLWln5b8m
	 HFBw3K+lt5pgVgVgyTxhxlY5CZ9zPDN2L69fXPf9G/mWuVci/9xx+4Tz25j31d67md
	 EUctPDbCJlXcw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 17 Sep 2026 17:22:41 +0100
Subject: [PATCH v3 32/40] mm/uffd: use predicates for userfaultfd checks
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
Message-Id: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-32-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289; i=ljs@kernel.org;
 h=from:subject:message-id; bh=RaKyg3GqRiVqHvw/UDaaHvGcpLhQwigi+RNlsL2zffs=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLWCB/OPPvVb8aRBlaPSTM6P2dc4rwuwDBzzqZoPX/27
 rSo12wRHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZjIn1ZGhu/b9ztfWa90el/9
 TetPvC5Nrbrrmvhtz33cqXTRuuHAHX9Ghi+axsy3Htr+lVOdM/mU0QoVzTe+TDpKZk8zz6fZScS
 KswIA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Rather than directly checking VMA flags, use the newly introduced
vma_is_kernel_owned() and vma_is_persistent() helpers in userfaultfd when
assessing VMA suitability for userfaultfd and UFFDIO_MOVE.

Update vma_move_compatible() so it's expressed in terms of VMA
characteristics rather than arbitrary flags.

Additionally, update the use of the deprecated VMA flag API when checking
VMA_SHADOW_STACK_BIT.

A VMA_IO_BIT check is no longer required but that is fine as a hard
invariant has been established that only kernel-owned mappings may set
VMA_IO_BIT so the check is now redundant.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/userfaultfd.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 949017e60608..ddf0a4a3d399 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1754,10 +1754,18 @@ static inline bool move_splits_huge_pmd(unsigned long dst_addr,
 }
 #endif
 
-static inline bool vma_move_compatible(struct vm_area_struct *vma)
+static inline bool vma_move_compatible(const struct vm_area_struct *vma)
 {
-	return !(vma->vm_flags & (VM_PFNMAP | VM_IO |  VM_HUGETLB |
-				  VM_MIXEDMAP | VM_SHADOW_STACK));
+	/* uffd is generally incompatible with kernel-owned mappings. */
+	if (vma_is_kernel_owned(vma))
+		return false;
+	/* The shadow stack should not be written to by userspace. */
+	if (vma_test_single_mask(vma, VMA_SHADOW_STACK))
+		return false;
+	/* hugetlb mappings cannot be safely moved. */
+	if (vma_is_hugetlb(vma))
+		return false;
+	return true;
 }
 
 static int validate_move_areas(struct userfaultfd_ctx *ctx,
@@ -2146,10 +2154,11 @@ static bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
 {
 	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
 
-	if (vma->vm_flags & (VM_DROPPABLE | VM_SHADOW_STACK))
+	/* Non-persistent memory is inherently not controllable by userspace. */
+	if (!vma_is_persistent(vma))
 		return false;
-
-	if (!vma_is_hugetlb(vma) && (vma->vm_flags & VM_SPECIAL))
+	/* The shadow stack should not be written to by userspace. */
+	if (vma_test_single_mask(vma, VMA_SHADOW_STACK))
 		return false;
 
 	vm_flags &= __VM_UFFD_FLAGS;

-- 
2.55.0


