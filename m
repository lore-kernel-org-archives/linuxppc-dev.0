Return-Path: <linuxppc-dev+bounces-17421-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88D31039893
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 20:12:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMzyk2Sxtz3bn8;
	Sat, 28 Feb 2026 07:12:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772223166;
	cv=none; b=QPSzh2VJICAzWdsNbigxkIUbhDQgBx95gyprJI1+9OHRKI9oYfJnpGTWGHSKS2dDGX33k+YpSSB6FuQVxKFaIj7JX66sjPcUvE+Sses6oFRcXecu6w2ed2dCvjW3IGN8zGtrFAIs8YEIIigEPw7KhLdPqz3mjgK6+gJNy7bIaq5/724dc/l6uczv2eyMLAkH+mT8j3bm/bzJjblEr93qE1l2xVb6F/WV0ctr36P6Zq1/DIZO/4Bb9vZP/SWySWsdk44UsDRfKlz/iksTVVxe2Cr9vrOlMPEH/+0YE4BlvfXsWZxKEc3JrLUUfylP8+PNUtIo2JJawzviP37S34fXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772223166; c=relaxed/relaxed;
	bh=xOAMwgzKb8EUHtWYRJDu3VoLceGWF1CqGbxvk9rxhzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRZ5+HBAmZj2ALgKIHDFxaLhfXvPBgigusDF/jX9xVCUTd+VzAjAcrUESG1XDRlrf0Sy9L5ucBpuzsVibJoE5IQAKsgUmI8HvSxqvldQSVgALkViKA5waeAZ5SoI2upXaWTkeZgTOMU4LknxVfV4iY1ovFcJFRrJfUkk2iXWHRGcw8K8ChZgO+CCGQesNYZAtjXYmHehnMrNmcS0gLA0+ldkkQFYATOpDkxnGQ+sVtHWeRoOAcw3O8Yoa5Q6ugqank43NjpLW30HR9n4jVBde05+9rk72f5WfA1Vq2yONywjrM9vsPKsaQkgINYLqaz7dOnpzJoVXVqR3YKO8GhMlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e5g0TPuA; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e5g0TPuA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMzyj3hknz3bn7
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 07:12:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D97E141843;
	Fri, 27 Feb 2026 20:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624A8C4AF0E;
	Fri, 27 Feb 2026 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772223163;
	bh=B1yXnc32tXbLcJ8NQGFc5Arvb5lyHtOMPl4AdrDajl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5g0TPuAG6gfesnF6qlduLlcGUBPnMhU3YENZOHkNsVPDgQhRnH1MFauWgeL7RMDC
	 ZDytxLL3/ocwf5PbRvFpVbk3pmvkdAD+XF1L6BzyancbBjD35yHtpfICb2QNxOw986
	 L5hI932ZW/hEh+Gw6fKcAGmpoqiF+z1NyH1tsVKuOA7DQSAhWxwkWr6RocVOmKV8XG
	 KFx3ANZlj2o1XSLVoqev/UhRxYfp7R7fG3oZ4hNen9Y8TdMB1iPdiGc3rcD8XmrotP
	 q4q3zeg0mjfjsk5BWqfRmyIBaT8twqj4E2sWv/18B/I98ZtV8ClTF3/ZnpUTnwGlob
	 z68EfQd2gz72g==
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
Subject: [PATCH v1 13/16] mm: rename zap_page_range_single_batched() to zap_vma_range_batched()
Date: Fri, 27 Feb 2026 21:08:44 +0100
Message-ID: <20260227200848.114019-14-david@kernel.org>
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

Let's make the naming more consistent with our new naming scheme.

While at it, polish the kerneldoc a bit.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/internal.h |  2 +-
 mm/madvise.c  |  5 ++---
 mm/memory.c   | 23 +++++++++++++----------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index df9190f7db0e..15a1b3f0a6d1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -536,7 +536,7 @@ static inline void sync_with_folio_pmd_zap(struct mm_struct *mm, pmd_t *pmdp)
 }
 
 struct zap_details;
-void zap_page_range_single_batched(struct mmu_gather *tlb,
+void zap_vma_range_batched(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long addr,
 		unsigned long size, struct zap_details *details);
 int zap_vma_for_reaping(struct vm_area_struct *vma);
diff --git a/mm/madvise.c b/mm/madvise.c
index b51f216934f3..fb5fcdff2b66 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -855,9 +855,8 @@ static long madvise_dontneed_single_vma(struct madvise_behavior *madv_behavior)
 		.reclaim_pt = true,
 	};
 
-	zap_page_range_single_batched(
-			madv_behavior->tlb, madv_behavior->vma, range->start,
-			range->end - range->start, &details);
+	zap_vma_range_batched(madv_behavior->tlb, madv_behavior->vma,
+			      range->start, range->end - range->start, &details);
 	return 0;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 1c0bcdfc73b7..e611e9af4e85 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2167,17 +2167,20 @@ void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
 }
 
 /**
- * zap_page_range_single_batched - remove user pages in a given range
+ * zap_vma_range_batched - zap page table entries in a vma range
  * @tlb: pointer to the caller's struct mmu_gather
- * @vma: vm_area_struct holding the applicable pages
- * @address: starting address of pages to remove
- * @size: number of bytes to remove
- * @details: details of shared cache invalidation
+ * @vma: the vma covering the range to zap
+ * @address: starting address of the range to zap
+ * @size: number of bytes to zap
+ * @details: details specifying zapping behavior
+ *
+ * @tlb must not be NULL. The provided address range must be fully
+ * contained within @vma. If @vma is for hugetlb, @tlb is flushed and
+ * re-initialized by this function.
  *
- * @tlb shouldn't be NULL.  The range must fit into one VMA.  If @vma is for
- * hugetlb, @tlb is flushed and re-initialized by this function.
+ * If @details is NULL, this function will zap all page table entries.
  */
-void zap_page_range_single_batched(struct mmu_gather *tlb,
+void zap_vma_range_batched(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long address,
 		unsigned long size, struct zap_details *details)
 {
@@ -2225,7 +2228,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
 	struct mmu_gather tlb;
 
 	tlb_gather_mmu(&tlb, vma->vm_mm);
-	zap_page_range_single_batched(&tlb, vma, address, size, NULL);
+	zap_vma_range_batched(&tlb, vma, address, size, NULL);
 	tlb_finish_mmu(&tlb);
 }
 
@@ -4251,7 +4254,7 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
 		size = (end_idx - start_idx) << PAGE_SHIFT;
 
 		tlb_gather_mmu(&tlb, vma->vm_mm);
-		zap_page_range_single_batched(&tlb, vma, start, size, details);
+		zap_vma_range_batched(&tlb, vma, start, size, details);
 		tlb_finish_mmu(&tlb);
 	}
 }
-- 
2.43.0


