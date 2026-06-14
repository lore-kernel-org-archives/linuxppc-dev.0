Return-Path: <linuxppc-dev+bounces-22609-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9064CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2026 09:46:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gdT1C0D5kz2xtC;
	Sun, 14 Jun 2026 19:46:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781430414;
	cv=none; b=O/EDBtCBSloxVhYJxHPNAPxBi2bAc9c/ABHPNu5AW3yt6SPMLYJ2jmHGjye5VFWQed0KJgwCMWMCvTxiItT5F3g2SfDSEUNEyu6vFBjuVQVpFvJUvbqfn5c+bkGmU3Qi8/ZsCfVU81Q7ZMRKQPTVJbHadMhOIS24z1kaouvQ59Olw46b4zBnZLRy0QA2zQ3HgvHTkrcR/ElZvap3e6DifLlJcVbzNBaU4/IwVSF5TWT0Td7WcnainNL/3b/MOwRFe7zJdrT9yOq5q+R6w2k1N9Pax4HwnfHBg6fg7Z7LGx83Bg2bzKPraSWdZDi7sxPFXWRZZrSe7M8DKvVQ7xPpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781430414; c=relaxed/relaxed;
	bh=ch/CpHvya+lx1cR9vxabGOo27V2BdvD/1TKGk2c7iog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYpflE1ikdrAxL9hokpdLJxwLEmsGg1GSWtyWvYR625Ktp1wPKmUfv6Rgkw4Yrxp8o1DOfw/dW/dDM3+yRJbWXoOSKUyNBxxlLEZAOlcy2qtmwLrvk7pxsYd39so7/ectjXeV7SIpy/FHZkGbEPMgtQFwtoOByFOuVPdJAO5UDKPkQi15MWRVITt4Ks2Bl3mFg8Myau1fbjTt0tVpm+1eT32eb2SZfKYitpRrDhPluJS3V5A6e0bLrAFx+SYxa+q9PLTFYyG1pPLEiJHSJfiFvwsQrRGFTz3dE349g9N8PjvqmsYZYhTbAByX2exzJtjLdSfmLomMcbiJq7puygR9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNgHT95Q; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNgHT95Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gdT195KvJz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jun 2026 19:46:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 131206008A;
	Sun, 14 Jun 2026 09:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7CE1F000E9;
	Sun, 14 Jun 2026 09:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781430409;
	bh=ch/CpHvya+lx1cR9vxabGOo27V2BdvD/1TKGk2c7iog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KNgHT95QFrNdcW7kXu8SpsK/TzlVvtt1gCIIOnXjMZ8/IL3FZj1I3CrwYfsoutIgP
	 ezvgDaG/R127cAIpHzGSfltsz8/Tp/0PfIlgqfVs1sac/yxN+AhwJXzW43iOufqj3N
	 B1U8fzT5n/iT0rBYRXK5gAf+oCaBLx+1l8UQlVao2NcNob5cLRLK/7gT5tFSMAgbAu
	 Y4dEFiA5gThYLkiKhQBi1T9LLLLSqSfzOyUtLij608bEgiIYMJrcnvCVdyZnkhB9az
	 Pz/IUY6477nPvxa2soQp2RulQ5CEvn1xRddj8Qo/I0Ho6ZP9XaLXvUfvNzABlmoXD1
	 Gntrp3/2TlVlA==
Date: Sun, 14 Jun 2026 12:46:40 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v4 14/19] mm/hugetlb: Free cross-zone bootmem gigantic
 pages after allocation
Message-ID: <ai54gBQ0TiWKE080@kernel.org>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
 <20260612035903.2468601-15-songmuchun@bytedance.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612035903.2468601-15-songmuchun@bytedance.com>

On Fri, Jun 12, 2026 at 11:58:58AM +0800, Muchun Song wrote:
> Now that hugetlb reservation runs after zone initialization, bootmem
> gigantic page allocation can detect pages that span multiple zones.
> 
> Keep those cross-zone pages separate during allocation and free them
> after allocation completes, so later hugetlb initialization only sees
> zone-valid gigantic pages.
> 
> This chooses to free cross-zone gigantic pages directly instead of
> retrying allocation. In practice, such cross-zone cases are expected to
> be very rare, so adding retry logic does not seem justified at this
> point. Keeping the handling simple also preserves the previous behavior.
> If similar real-world reports show up later, retry support can be
> reconsidered then.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/hugetlb.c | 75 ++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 64 insertions(+), 11 deletions(-)

-- 
Sincerely yours,
Mike.

