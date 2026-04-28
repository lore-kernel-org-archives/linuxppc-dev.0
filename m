Return-Path: <linuxppc-dev+bounces-20243-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F11EFF8875
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 13:48:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4hbs6rlVz2xYw;
	Tue, 28 Apr 2026 23:48:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777384121;
	cv=none; b=IYbPQxDbQ1Q0nTjYM59p7xkenX2zBRRZHvO1jq5YFFsUYNWiCVV15l0lzKfNxxtg8eJEB3yRSsSZZMcl/sWabYOx86z9LfxJQLQPiLvcsm41CnvRG/jGLyNJuekaCbwJUBANY10/qLOAliZTEJJ0ptKZWUg37LoGbECpno2KPREELDaJWtuYQGwkjln3SQUoWiG80pFin4bYcpreWAqpvq0s2Tol+9G4evK0PU5mY+keVivlicfZ2Y9zXQXu6+LOWv84L02op6iIPepb75e9vBmW3iOt4yC8SdxYD2hMRfsE7FlgfgvNzZHOSjPZ1GM0ZnjExheEYYRyDHQxSTx+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777384121; c=relaxed/relaxed;
	bh=ui9dawQgaW88tiF83WoODlMfyTi8xvygmTz+Qk/txN4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eo6fmh0h4WaZuuLy2U7yi4Yj27nMPIPIAuSolx+T4pXsj+CxQDdOO6tPkY7zTnlqbv1arPZebL1CbpVtGtwJ6ADMv6KHZpgindAcclruzqjXLSc8chORx/BzoxrNLd3efDhlAaFiHVqA6mYVgE6fA8VLo1WHSGAas7KA8E9pDUs+dGd7l+siu5nNrB7PZmOtiuHKynzacor+EvsP6w6ySQrhBHydjHYyignzhg2oMZO+hc/FYIg/XQxPIUBglgyRx/hIvtmR4p0DS1g/C6Qzd93tmGXYbXC/WCX1DXzNNxz9Me28M1twTymoJpSSbJ6G0Tq7GNMxMpQM6tp5uIoZUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ACWEQGe1; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ACWEQGe1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4hbr36X3z2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 23:48:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 186E643B2E;
	Tue, 28 Apr 2026 13:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9D4C2BCB8;
	Tue, 28 Apr 2026 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777384116;
	bh=pWqVblja9OGc3skZ+yvllMmHkjP/hNRclmroti3JSVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ACWEQGe15ZDmAHLKqymQl7JUn8RQ9bj3yWOUTYPDtHeZAt6nkRdRsQkAc+SXrNcuQ
	 /6lZNybiYr9WDBJz8beGhyGDpjP/TPWcBdVTWYebO1bt97+76zTmUDH2uqq15EVUtJ
	 6RfXpKC0OO8W44xq0qHMimYun1z3avl0XGu39Djw=
Date: Tue, 28 Apr 2026 06:48:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Michael
 Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] mm: Fix vmemmap optimization accounting and
 initialization
Message-Id: <20260428064835.5f0db4196ac3f1e6a96abadc@linux-foundation.org>
In-Reply-To: <20260428081855.1249045-1-songmuchun@bytedance.com>
References: <20260428081855.1249045-1-songmuchun@bytedance.com>
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

On Tue, 28 Apr 2026 16:18:49 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> The series fixes several bugs in vmemmap optimization, mainly around
> incorrect page accounting and memmap initialization in DAX and memory
> hotplug paths. It also fixes pageblock migratetype initialization and
> struct page initialization for ZONE_DEVICE compound pages.
> 
> Patches 1-4 fix vmemmap accounting issues. Patch 1 fixes an accounting
> underflow in the section activation failure path by moving vmemmap page
> accounting into the lower-level allocation and freeing helpers. Patch 2
> fixes incorrect altmap passing in the memory hotplug error path. Patch 3
> passes pgmap through memory deactivation paths so the teardown side can
> determine whether vmemmap optimization was in effect. Patch 4 uses that
> information to account the optimized DAX vmemmap size correctly.
> 
> Patches 5-6 fix initialization issues in mm/mm_init. One makes sure all
> pageblocks in ZONE_DEVICE compound pages get their migratetype
> initialized. The other fixes a case where DAX memory hotplug reuses an
> unoptimized early-section memmap while compound_nr_pages() still assumes
> vmemmap optimization, leaving tail struct pages uninitialized.

Thanks, I updated mm-new to this version.

> Changes in v8:
> - In patch 4, move VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION) to the
>   top of section_nr_vmemmap_pages().
> - In patch 4, add Acked-by from David Hildenbrand.

Here's how v8 altered mm.git:


--- a/mm/sparse-vmemmap.c~b
+++ a/mm/sparse-vmemmap.c
@@ -654,6 +654,7 @@ static int __meminit section_nr_vmemmap_
 	const unsigned long pages_per_compound = 1UL << order;
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
+	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
 
 	if (!vmemmap_can_optimize(altmap, pgmap))
 		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
@@ -664,7 +665,6 @@ static int __meminit section_nr_vmemmap_
 	}
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
-	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
 
 	if (IS_ALIGNED(pfn, pages_per_compound))
 		return VMEMMAP_RESERVE_NR;
_


