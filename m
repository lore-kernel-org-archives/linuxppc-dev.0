Return-Path: <linuxppc-dev+bounces-17415-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077D41039894
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 20:11:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMzwq4GjYz3bnL;
	Sat, 28 Feb 2026 07:11:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772223067;
	cv=none; b=k6OVOTblG3Yg2Pw4tkNOs7wls7kNAk0MVsEgpvz/adadA8nfFQHAO7574lGUBd0xi/YkWlRrhe86Z1+fB/1YBMdg7vAHEpJvNrNW3Iyr1BA6lidc5/uO3rubSX9Mft1nbXOYrgfTgMuZC4W68xXkSC4iqq+hUmU8sT2tbZKH8WDIKvm5BakPxSfUjAwUZKZNUAS2ptBG1pGJDjQ/TJCrj6cXGdFMftLQtDyj7JUSiwMrIM/oFQ+sC/uZykGr6rR0tAix+PNBFMih55uuGaXikkEJgykomsd70//3hf3vW/QS2PAvopIU5mZ/vZajofcikA+XuklsBQg+bgHsdBh6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772223067; c=relaxed/relaxed;
	bh=IR4UGUOMgNOxTtW/UDLDk9ruI161Ftbjj/3k3iE/RdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXA503FLWC1eEXKbraDvSDPFmb940Wd2Je7UP4H3DoJzmx1So7ZFOKrt+ei5b/4x0VZ+zb6u95iazlOEYyBzzsCggPku68Ezh/NXpzmjmIFirI4M4cZCxhF+ajEPLm8au5oJaFcRHDFbINADjqvN+mnFIw85C08jLxqSYVUHaSzZHqNmo75L1dNkcl6NG3z2avxM3SBn0BnQyCu0qoGNWeh6PJGW+y9qbpU0erdabHC8wpLZi26wWW+wmp/575EpjXDDSkEAeFV8YVDYyoV3CWEzRmRziI+kTSnw5ZeY8aoPlWvEG3G7A+fkkAzAA+0eyRoga3JM4K/CyIPSRIKuvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RtZuxKn3; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RtZuxKn3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMzwp5gdcz3bkL
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 07:11:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B518460126;
	Fri, 27 Feb 2026 20:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1D7C4AF0D;
	Fri, 27 Feb 2026 20:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772223064;
	bh=1+QuoW/elQeLApVDz9csX68UOgFLcRXKeXzvwiiZ4og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtZuxKn3Ziqokc8GpxUXMnZvP6x2/VNh0HcDRcORj7Jjg1pwi+muUt68y2oAPSSn7
	 oXm3RcX/NB5+rlaz1Axv1CYblxhdridhg0R2TC1bV4DMOIkHe0e+ljXOAu11x8YisK
	 3cKrd3jepyMfsg/8UQ9qaT5UFz7UcP0BvlO+Vb0tqIcwpCcAoN5ovlLJWFsERdCVR6
	 c+KzkQnQ8g6/c5BNYsVswZIxJhuTUYh3A1VIWKouIbNnLMzCE98PRU6kla3Ls2hHHn
	 Xnpogri0UwXahapxbF6VQB/VcdHdOn11slPbn6O6jernACtIFzDi0c0Un4gk9KL7uH
	 doaGGvuSkLX+w==
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
Subject: [PATCH v1 07/16] mm/memory: rename unmap_single_vma() to __zap_vma_range()
Date: Fri, 27 Feb 2026 21:08:38 +0100
Message-ID: <20260227200848.114019-8-david@kernel.org>
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

Let's rename it to better fit our new naming scheme.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 621f38ae1425..f0aaec57a66b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2074,7 +2074,7 @@ static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 }
 
 
-static void unmap_single_vma(struct mmu_gather *tlb,
+static void __zap_vma_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr, struct zap_details *details)
 {
@@ -2177,7 +2177,7 @@ void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
 		unsigned long start = unmap->vma_start;
 		unsigned long end = unmap->vma_end;
 		hugetlb_zap_begin(vma, &start, &end);
-		unmap_single_vma(tlb, vma, start, end, &details);
+		__zap_vma_range(tlb, vma, start, end, &details);
 		hugetlb_zap_end(vma, &details);
 		vma = mas_find(unmap->mas, unmap->tree_end - 1);
 	} while (vma);
@@ -2213,7 +2213,7 @@ void zap_page_range_single_batched(struct mmu_gather *tlb,
 	 * unmap 'address-end' not 'range.start-range.end' as range
 	 * could have been expanded for hugetlb pmd sharing.
 	 */
-	unmap_single_vma(tlb, vma, address, end, details);
+	__zap_vma_range(tlb, vma, address, end, details);
 	mmu_notifier_invalidate_range_end(&range);
 	if (is_vm_hugetlb_page(vma)) {
 		/*
-- 
2.43.0


