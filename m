Return-Path: <linuxppc-dev+bounces-21910-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE19DCD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 15:41:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVFSK1RwXz3brB;
	Wed, 03 Jun 2026 01:41:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780414913;
	cv=none; b=ivKyYOc45KjUNcKf2xJ/k9seelIm7Xim3PsNG6GvvLYknqBP1AH3BmjVoB28m7lEh/PGhb1qzP8mtGLgmwPHFfym+dER941BT3BiJn5mfRbKZd2joRF1LcgsXfQZylQgOZpY3OZkE9wBM0/nQ0hPT+xhd+5DHtpQG63LShjc+DYXefeZd96mK38k5+G8MX9/hLFIwVz89wb4znncMtUSAUKIkg2nNSCNJH+LHx0bwFqdeQCc/FiG3WrLFhUIrRW5/rs4FY+E/b/J4EBze4i1R6DQAsJMzthKKwV0LHWFRxF87xyjQMT5OZB60bvz4IbWHLr1VKxvvyZCl/h/L1+zIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780414913; c=relaxed/relaxed;
	bh=zQZZGZ6EMTnUv6b/A0cJocwVFTUpYX1eLweF/8Sul1Y=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Dx8onzPLy/HSsCXuQmYxVTO/GWW9gFWqWdlFNfhtRNzq6HFgTP0V0s5iqbHTRpRYa8RjGFsOEMi4e7mIDOwsffXrAf5UcxqR6O1QD8D1NbVh+DrxvyqOF8IGZHYvk78u4o/Oc0QWSWPWKBIFtR5tkvxcbtMd5Wh/NP6Ubqd6YI90PLgFKvJKAgPq3rGRNEksktrc6BB0am8LS4SuA7q08VEDGvyoJQfdjM840OwbRROzRlpqLm4T8Xo+xwqm3X+BrcY00hFnclqQdxcim2GxyXKp2q7HfdTDlA145naH19trDm7WapfLxI+MUGTjsUN+YyzI+w59OZcRKyl42SVFiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dq/fgWqG; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dq/fgWqG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVFSJ4Y3xz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 01:41:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 02FED40627;
	Tue,  2 Jun 2026 15:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD131F00899;
	Tue,  2 Jun 2026 15:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780414910;
	bh=zQZZGZ6EMTnUv6b/A0cJocwVFTUpYX1eLweF/8Sul1Y=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Dq/fgWqGarmZFFHRBdUyYH3SxTuACE5PWIOGXebWLtT+Jz3aNaHvvhPQNEzTtnZJv
	 YrZsqEb75xpMlIzGphpk7jNqD4E9qqNpKg1Z3UmvtmoG03S2x0sU6Iz5XoSYHb+LLS
	 eJf4R7DRfm1x5KdKR9k7pR+nuGxrAcNh17oF29hvI1BTUyL3TDXk3neZ+W39hxQcMy
	 ZtKdKMaxoKjJsiWyVhCuvc+A3zLMciVDFXKQ5ZUAip9ohOeIRSyQRqIAHpaKhkRnDU
	 BgMmV5JJ5eWXsRdDQrMe+lkcjxzMNP/G3U/1sV9IVcJvnP/vmp7GEpoNyxqmBN71B8
	 LcV0HPDXsFjHw==
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
Subject: Re: [PATCH v3 16/19] mm/hugetlb: Remove obsolete bootmem
 cross-zone checks
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org, Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20260602101039.1867613-17-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-17-songmuchun@bytedance.com>
Date: Tue, 02 Jun 2026 18:41:33 +0300
Message-Id: <178041489398.457517.8355446246116786091.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 02 Jun 2026 18:10:36 +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> Bootmem gigantic HugeTLB pages used to be validated again during
> gather_bootmem_prealloc_node() and any cross-zone pages were discarded
> there.
> 
> That validation is no longer needed. Cross-zone bootmem gigantic pages
> are now detected during allocation and freed before they reach the later
> bootmem gathering path, so the remaining pages are already zone-valid.
> 
> [...]

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


