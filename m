Return-Path: <linuxppc-dev+bounces-17411-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7BEFD9E3A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 20:10:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMzvY1QJCz3bkL;
	Sat, 28 Feb 2026 07:10:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772223001;
	cv=none; b=Py3oB2Wk1ikbUqhwBh9aWOsjDVNcbpER/g63uFK6wxE3hw1U8GVgCOAaW7LXKFQwWA51jcBzzILH0DwE7xobKRmZl9hkEg52pR81xvPPv6GmyC1VIwTq+PeZmCJvW1bdfx5SRhmo8JcW4tHRmAeRg8lF2qiNt7RH1FfaZHUk4u7AVLUH7zZt4Y8dG+zHpFRLf2uQnQyY8LFl4SYcv3+o2AI582VdW0ILsWMpImg/bvS6Z3BGmrH0s6dgKmIaakcGZ2yD6hwNdvSHFigzbxhrorKl3Y1LaOWrTR352L2cUXaHvoha7dttXM4r5Esg9rm6D+l5WCCPexl+TP42vKgkug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772223001; c=relaxed/relaxed;
	bh=DUhf1JuSB9OPze92qz/d6HbXdXDvs4qBvhHKIVZpPP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQK/mro2Ly9HaXWdRLFy+dB3Dv+ofF7Al4YaZr2GfodXV7jhCiGvjpg4mOTBeZliR+wiUa1bZcSSpgt5uKDwFOcq3Udqq/WScmCJRUDm7SWUy3ANBKb/jRbB0W5mU8FIUYVM1IggY0WAwBfoWLTbxaKbuGva9CwrxE/M56wzA+DAQviA9aHVYoWUgFIk8NMHCqDaI1eM8sLXDncvetNbc0W7qfFpA/AyaivSVs48tlemLV2Ap4G28OrKkgLTGr1x14N3Fw7MvfpnYsk72H9b2R6AcLTTodpIZrT/HeC6NlgYVp0D9ZiVTyYf62CC2ZKE7VeYasAsrqj0OX0hkgODqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SKSqFMwc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SKSqFMwc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMzvX3YZ7z2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 07:10:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 04D8A4417E;
	Fri, 27 Feb 2026 20:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E725CC2BC86;
	Fri, 27 Feb 2026 20:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772222998;
	bh=6LDS5+Vnu1htyspttVgh9zMYsh7tIZY4ma3ymZBtFxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKSqFMwcnc7VlfFpJ1YNAbm4Z+zF+/LGzUP4CQ7sh7kvhpYmsBKfiG+nk4e+qHYLY
	 +Cdf6OJiVUJQfBE1Be1Oajv2J5qqAr7rTEQSaKgth6pGitrG8Hc1wPVk2TOXaWSysY
	 5NZBg2/wRYlKWBg3m+g+8mhjmq7xDqKiE1UDk9cYXlckyJFxfD5ezJwIvK9pjt6B0f
	 +9uLN2/GF+QIAANdneeZojFKTbtzB83JiF1S8jiEQTloHhUkWPaWDcFKguB8BRteav
	 xs9wWSj8gILbDPly5WkEX4gjf8F5WAVfUBqcy1dk1YtENH/MRugbDFtWtjB0lCg6Ka
	 Iqb4hdLjMfU5A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "linux-mm @ kvack . org" <linux-mm@kvack.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v1 03/16] mm/memory: inline unmap_mapping_range_vma() into unmap_mapping_range_tree()
Date: Fri, 27 Feb 2026 21:08:34 +0100
Message-ID: <20260227200848.114019-4-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227200848.114019-1-david@kernel.org>
References: <20260227200848.114019-1-david@kernel.org>
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

Let's remove the number of unmap-related functions that cause confusion
by inlining unmap_mapping_range_vma() into its single caller. The end
result looks pretty readable.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 19f5f9a60995..5c47309331f5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4221,18 +4221,6 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	return wp_page_copy(vmf);
 }
 
-static void unmap_mapping_range_vma(struct vm_area_struct *vma,
-		unsigned long start_addr, unsigned long end_addr,
-		struct zap_details *details)
-{
-	struct mmu_gather tlb;
-
-	tlb_gather_mmu(&tlb, vma->vm_mm);
-	zap_page_range_single_batched(&tlb, vma, start_addr,
-				      end_addr - start_addr, details);
-	tlb_finish_mmu(&tlb);
-}
-
 static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
 					    pgoff_t first_index,
 					    pgoff_t last_index,
@@ -4240,17 +4228,20 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
 {
 	struct vm_area_struct *vma;
 	pgoff_t vba, vea, zba, zea;
+	unsigned long start, size;
+	struct mmu_gather tlb;
 
 	vma_interval_tree_foreach(vma, root, first_index, last_index) {
 		vba = vma->vm_pgoff;
 		vea = vba + vma_pages(vma) - 1;
 		zba = max(first_index, vba);
 		zea = min(last_index, vea);
+		start = ((zba - vba) << PAGE_SHIFT) + vma->vm_start;
+		size = (zea - zba + 1) << PAGE_SHIFT;
 
-		unmap_mapping_range_vma(vma,
-			((zba - vba) << PAGE_SHIFT) + vma->vm_start,
-			((zea - vba + 1) << PAGE_SHIFT) + vma->vm_start,
-				details);
+		tlb_gather_mmu(&tlb, vma->vm_mm);
+		zap_page_range_single_batched(&tlb, vma, start, size, details);
+		tlb_finish_mmu(&tlb);
 	}
 }
 
-- 
2.43.0


