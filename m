Return-Path: <linuxppc-dev+bounces-29187-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE253CA9EC1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 20:42:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2Fz96JZtz2yqT;
	Sun, 11 Oct 2026 07:42:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791664949;
	cv=none; b=YLUcLi7Y3EcyjooA/rEmR0ZkRHz7mN4kB9wUIdJwUc5Zq6PIvhGe+IsPDbxCT4oNnyLSDZTgjaFUthRoyTvvKF28nFoXSNicrFNyXcM3a8uSkHBuU6SRXnNH9dXD6FSVZ7DQMHE3p+cz4qhbNkWHXs1HNH0soak/MokRwa3BiXf4wQDCBCaC1cC0WGbxyBUd4j8ntaNzrhllWEZTdrKY/KH2h2bMhFl+AuE3Es0XBclUVjtRtw/ilLumE21Jn0hJMOyPDMuCfEBbaunhznBWayyixBmwdO5x77VZ0fomXAsc08ysLP9/hXLFCVo0/VCd7zxE66tjBUJxbQlFCm+LGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791664949; c=relaxed/relaxed;
	bh=KaeVwRqfGMljaxW8Ah6Cx9zT6uiRBSSC1dP0zE7Q/ko=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lmkBP2J1TrTHcc8UUng4WrfawpdR3cCHTJzvHEvcmAOriFV9/xypkkoS9sNT5HpY8Nz9CAcTd+ztN5JdRz3giSYUrXYzjs+0sEor4h0M6NeZJT9U2aMqy6n6ovX8bQtoElyAXEIuWN++HKrEjQU/DIZqNQHMSSyS8rBdnwEYcVUfITxAmKyg2J90FNoibDrlL4ro25AVPmFmwNg5wDDImg/nw92TXMz3OPwFIBT88iFrNNnJbfXQLj4Q929ym+Zl8MzihijI4f8vIBOFARLU5QDl9+8X9zQ5xxujgRCZQU0Z2D5MCEwV1EK25o3Lt1i/pQEWBhvuwkndu/r7ocxrqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=RmLqUv8s; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=RmLqUv8s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2Fz76vHvz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 07:42:27 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D5CDB602CC;
	Sat, 10 Oct 2026 20:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A691F000FF;
	Sat, 10 Oct 2026 20:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791664943;
	bh=KaeVwRqfGMljaxW8Ah6Cx9zT6uiRBSSC1dP0zE7Q/ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RmLqUv8syW5KCaLrBRHaqB+hdxZmebnLFbyFQcAzsE8K8GyM/v72kmzM2p52+uyUk
	 JY4X3rsdpU0z8m/Mytez5hAFfN73+lJQkTAJ2ZdwOIQwtDH7dUz67d2wNhBrUxR1xC
	 zb3jPxE5vNJ3UNmy+gKrU8kH2wFXF/E3KA17J4EE=
Date: Sat, 10 Oct 2026 13:42:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport
 <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <chleroy@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>, Shrikanth
 Hegde <sshegde@linux.ibm.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Qi Zheng <qi.zheng@linux.dev>, Lance Yang
 <lance.yang@linux.dev>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev
Subject: Re: [PATCH v4 0/6] mm: Unify device DAX and HugeTLB vmemmap
 population paths
Message-Id: <20261010134222.b6fdcb20d8fec5aaceab66ec@linux-foundation.org>
In-Reply-To: <20261010075755.83339-1-songmuchun@bytedance.com>
References: <20261010075755.83339-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 15:57:49 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> This v4 is based on mm-new commit d5207c6d152c, which contains v6 of
> "mm: Switch device DAX to section-based vmemmap optimization" [1].
> 
> This series is split out from the earlier, larger series "mm: Generalize
> HVO for HugeTLB and device DAX" [2]. While the parent series generalizes
> vmemmap optimization across HugeTLB and device DAX, this subset addresses
> a single, self-contained step: unifying their vmemmap population paths.
> 
> After the preceding Device DAX conversion, both HugeTLB and Device DAX
> describe optimized vmemmap mappings through memory-section metadata and
> use per-zone shared tail vmemmap pages. The generic code, however, still
> carries a Device DAX-specific population flag and compound-page population
> path, along with arguments and helpers needed only by that path.
> 
> This series first removes VMEMMAP_POPULATE_DAX and moves selection and
> reference handling for the shared tail page into the common vmemmap
> population path. It then removes the generic Device DAX-specific
> compound-page population path and routes section vmemmap population
> through vmemmap_populate(). The powerpc radix path continues to use its
> architecture-specific compound-page population implementation for
> optimizable sections.
> 
> The remaining patches remove the unused ptpfn argument, open-code
> vmemmap_populate_address() now that no caller needs its returned PTE, and
> add a warning for inconsistent zone initialization of shared tail vmemmap
> pages.
> 
> This is the fourth smaller step toward the broader HVO generalization.
> After this series, HugeTLB and Device DAX use the same population model
> instead of parallel generic paths, while powerpc keeps its
> architecture-specific implementation.

Thanks, I've updated mm-unstable to this version, including the -fix.

> v4:
> - Rebase onto mm-new commit d5207c6d152c, which contains v6 of the Device
>   DAX section-based vmemmap series.
> - Factor the zone mismatch check into a local helper as suggested by Mike
>   Rapoport.
> - Collect Reviewed-by tags from Lance Yang.

Here's how v4 altered mm.git:


 mm/mm_init.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/mm/mm_init.c~b
+++ a/mm/mm_init.c
@@ -593,6 +593,15 @@ out:
 	node_states[N_MEMORY] = saved_node_state;
 }
 
+static inline void vmemmap_optimization_verify_zone(struct page *page)
+{
+	const unsigned int order = pfn_to_section_compound_order(page_to_pfn(page));
+
+	VM_WARN_ON_ONCE(vmemmap_optimizable_order(order) &&
+			page_zone_id(page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=
+			page_zone_id(page));
+}
+
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid)
 {
@@ -609,9 +618,11 @@ void __meminit __init_single_page(struct
 	if (!is_highmem_idx(zone))
 		set_page_address(page, __va(pfn << PAGE_SHIFT));
 #endif
-	VM_WARN_ON_ONCE(vmemmap_optimizable_order(pfn_to_section_compound_order(pfn)) &&
-			page_zone_id(page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=
-			page_zone_id(page));
+	/*
+	 * Shared tail struct pages are initialized during vmemmap population,
+	 * before retained struct pages reach here.
+	 */
+	vmemmap_optimization_verify_zone(page);
 }
 
 #ifdef CONFIG_NUMA
_


