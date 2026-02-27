Return-Path: <linuxppc-dev+bounces-17424-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5C61039894
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 20:13:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMzzf3qDXz3bnm;
	Sat, 28 Feb 2026 07:13:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772223214;
	cv=none; b=EWjlaUFdGWLheA2aNQzGd6KRUl9L2lNhoB/Vj2MR7J0PCMt3wEVfKk4QX1YUINZjX133qjZcFvJkf4yLrKQASZGZzjGpiudVVTnv85woQsY+ZznmCQoZrRGXtVpRN2lOWBSKORDLK3N8/33H3WENz9qoAyMSprEi5uopAbNn3OwKa6Xwx1znDeNqI2sHajcshUqZhgNEwrcilRrOI9hmaVxdLeaQhEoHqgsO8M4UIJ4pZWetJgMiOPjWk3KvrS/R0wiJHJDc1izZ/7uvFLnRI8IZbiqLgh0+nhhmQEVMHzJWkE32E/6rOvydkbhdIUru3vaRsdcwqA1dfxhYDdPtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772223214; c=relaxed/relaxed;
	bh=wRXSC4+iBXa4TW3ukLrtyEiHYn2JRmCbRPucTWT87Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciFV5gIQSab+76s1xdnM8wSmXN1T6hAYzLV6Houjtj6WlB9S/6xSkUfHJxunWfXad4GVrVOt9yfs3HJLdzjy0s+fODUZOyTR42e4CICRl09CXGA6jKcPPJxflPFTt0mp9BoG32ZUt2HUMlPTbo3Cg0+Rhe7We3+6TswJfa2GHdMrgo7TNMw61E8IO8g3vp8fG4z+B0+EigTBtpNs5YLfCZjh3cezBGoCZ8WztVWBDPfnAvAcInPi1U0Hu7j1CCRXCBXrMRROzjytVCya280V5GQHmTK1aEQ51byHZ5KG1+WUbzUIsWZjL0ASDFGsUdFG/xhICnJ3bch0LYnwJYx/uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BsV4ULrX; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BsV4ULrX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMzzd5k0Sz3bkL
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 07:13:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 36CC9401C0;
	Fri, 27 Feb 2026 20:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5BFC116C6;
	Fri, 27 Feb 2026 20:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772223212;
	bh=8DjODQ9JTo8rNPBCTFGX0cqEx7ur/z2XYX0+HQB8juc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BsV4ULrXcf69csyHSuGqVHkErg/TmBz0CXhzBZuPFMOJEd58YYsV9GY3LYfW2rxUB
	 B/Bd+jNerrYiWu/dHQ4j9aEcpp/k/BLY3TOUIcBEDZazpW4Qb1rlsg807wAQftoetu
	 oKHzBMSDxjv/CxuvG+QWIc4cPfrDOfwX0D5SZxDFnYn2LED/gYiKa1XwK/OgvUaDiQ
	 wgo5tEx/CUq90wHpk0NTCoqjaz2e0NS8iGFwY2Tc6jUxOCGeEWKQQpTGNJBMzS+gGd
	 d3N1RDyJOeuPtak0u7xYeGcKnNxHOOxKOC4LpkDRwUfoXIisyM7oV5jLZ/g+BGM9tD
	 tmtukJMtnncfA==
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
Subject: [PATCH v1 16/16] mm/memory: support VM_MIXEDMAP in zap_special_vma_range()
Date: Fri, 27 Feb 2026 21:08:47 +0100
Message-ID: <20260227200848.114019-17-david@kernel.org>
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

There is demand for also zapping page table entries by drivers in
VM_MIXEDMAP VMAs[1].

Nothing really speaks against supporting VM_MIXEDMAP for driver use. We
just don't want arbitrary drivers to zap in ordinary (non-special) VMAs.

[1] https://lore.kernel.org/r/aYSKyr7StGpGKNqW@google.com

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f3b7b7e16138..3fe30dc2f179 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2239,13 +2239,13 @@ void zap_vma_range(struct vm_area_struct *vma, unsigned long address,
  * @size: number of bytes to zap
  *
  * This function does nothing when the provided address range is not fully
- * contained in @vma, or when the @vma is not VM_PFNMAP.
+ * contained in @vma, or when the @vma is not VM_PFNMAP or VM_MIXEDMAP.
  */
 void zap_special_vma_range(struct vm_area_struct *vma, unsigned long address,
 		unsigned long size)
 {
 	if (!range_in_vma(vma, address, address + size) ||
-	    		!(vma->vm_flags & VM_PFNMAP))
+	   !(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)))
 		return;
 
 	zap_vma_range(vma, address, size);
-- 
2.43.0


