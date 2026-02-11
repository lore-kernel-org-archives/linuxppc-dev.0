Return-Path: <linuxppc-dev+bounces-16810-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECD5E9E30A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:25:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9zhH06RVz2xlk;
	Thu, 12 Feb 2026 00:25:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770816334;
	cv=none; b=gu7UHcXNi32tMcX6VnL3JQaOiHQXkIEuuublR2Q9AjGBjmlCbIlQf+NqGZD7bJj9XuwR0OB5eDJDZ1hBxTfr52Lko2gHub5EdnqVppR4fbaT6h4dgHtyBcIH5hBIKNDvPcj0vz3tjbq9zpC075OxgkL8gACGHszFC3qOHEvf3U+i9KkCpUw89LQ7Z7i7cEBl4tBpB1/zYtrughIn4jelXLJPltY/rz3KpQl6rV/+CiOjm/iUFXVLKCY9orpbPP99J/bnmHX1sy4CZ71fEqqodh2P5aqefspgLGXdylcQEEyrOHvE/r5YwwCrFhwzJDvMs0OmyCjkbsofMojIbfWWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770816334; c=relaxed/relaxed;
	bh=0PIwUSQnjigR7OzC+8/roaEtOWyhHvSG2Ks4ERE2LUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1dli0mpOfAkYTugIt1VlLkSlSZXDuvE1dsug8EADSKxcxuEKl+kxpNI6ibVx3pryVxR9mDvKo91RMSr/gda0M0ISOuJJzUhF1kOxXG+I4xLwpVAmR4jYkY7YuKP6h1q3kodsxq+rSfUoJG+Fs+1VOi43IbumMUCDAWkSlfxT/TCd6gWsEvJ+8tYDITTy0VxNqTpALyuP+bD9NocBfH5AZaSTCL9zJbuuMNBh4V+9oRItwNvb7u3MwBdYVVQcgCHKOSxOO6zxXgiC/ScX9xRWdXc5uFiISxZoPWP/hNIzHohZv/xYVYJTQAQZwkC+WbQhRtyGozSJeToYCOO884P8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IY1BLjfx; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IY1BLjfx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9zhF5Kt2z2xlM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2026 00:25:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CAC5E43842;
	Wed, 11 Feb 2026 13:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A817C4CEF7;
	Wed, 11 Feb 2026 13:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770816330;
	bh=8bP6jIC/KRpZ5dRqDOGx3ic6z30NOvMZ0jo3/v/qgNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IY1BLjfxsgjinT3MEUNF7AFOKffzITdIZjopxTyKR6rQR70TxHPeohVo/zmDu3S+D
	 jGJg75qVkd9JA5PGyzxeLus7oPrLKFJZ48dP8de+Z7ZEkhHmvqWpOMLsg45xAY/HV/
	 XLL2W56ya5+sAzctEcRROezBTxi9J8VOP/sMDUDhAQRFP5ZH3k1BnF6hXqk4XCYNeY
	 iy6qNPABWgwNnPUl7XiuZj70VWvAr0UWH0eXl0iDUWkybAzqBX529aglOS6iXAU3/V
	 w3HJztIob+TfOTWk4s4zPrNrvsdFd3O2hVTDRmpqwEtQI80foZrUxJRNPa0JuVahi5
	 E7kBwyvLbcfHA==
Message-ID: <13ab56cb-7fdb-4ee4-9170-f9f4fa4b6e37@kernel.org>
Date: Wed, 11 Feb 2026 14:25:21 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] mm: thp: allocate PTE page tables lazily at split time
To: Usama Arif <usama.arif@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, lorenzo.stoakes@oracle.com,
 willy@infradead.org, linux-mm@kvack.org
Cc: fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, lance.yang@linux.dev,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20260211125507.4175026-1-usama.arif@linux.dev>
 <20260211125507.4175026-2-usama.arif@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260211125507.4175026-2-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

CCing ppc folks

On 2/11/26 13:49, Usama Arif wrote:
> When the kernel creates a PMD-level THP mapping for anonymous pages,
> it pre-allocates a PTE page table and deposits it via
> pgtable_trans_huge_deposit(). This deposited table is withdrawn during
> PMD split or zap. The rationale was that split must not fail—if the
> kernel decides to split a THP, it needs a PTE table to populate.
> 
> However, every anon THP wastes 4KB (one page table page) that sits
> unused in the deposit list for the lifetime of the mapping. On systems
> with many THPs, this adds up to significant memory waste. The original
> rationale is also not an issue. It is ok for split to fail, and if the
> kernel can't find an order 0 allocation for split, there are much bigger
> problems. On large servers where you can easily have 100s of GBs of THPs,
> the memory usage for these tables is 200M per 100G. This memory could be
> used for any other usecase, which include allocating the pagetables
> required during split.
> 
> This patch removes the pre-deposit for anonymous pages on architectures
> where arch_needs_pgtable_deposit() returns false (every arch apart from
> powerpc, and only when radix hash tables are not enabled) and allocates
> the PTE table lazily—only when a split actually occurs. The split path
> is modified to accept a caller-provided page table.
> 
> PowerPC exception:
> 
> It would have been great if we can completely remove the pagetable
> deposit code and this commit would mostly have been a code cleanup patch,
> unfortunately PowerPC has hash MMU, it stores hash slot information in
> the deposited page table and pre-deposit is necessary. All deposit/
> withdraw paths are guarded by arch_needs_pgtable_deposit(), so PowerPC
> behavior is unchanged with this patch. On a better note,
> arch_needs_pgtable_deposit will always evaluate to false at compile time
> on non PowerPC architectures and the pre-deposit code will not be
> compiled in.

Is there a way to remove this? It's always been a confusing hack, now 
it's unpleasant to have around :)

In particular, seeing that radix__pgtable_trans_huge_deposit() just 1:1 
copied generic pgtable_trans_huge_deposit() hurts my belly.


IIUC, hash is mostly used on legacy power systems, radix on newer ones.

So one obvious solution: remove PMD THP support for hash MMUs along with 
all this hacky deposit code.


the "vma_is_anonymous(vma) && !arch_needs_pgtable_deposit()" and similar 
checks need to be wrapped in a reasonable helper and likely this all 
needs to get cleaned up further.

The implementation if the generic pgtable_trans_huge_deposit and the 
radix handlers etc must be removed. If any code would trigger them it 
would be a bug.

If we have to keep this around, pgtable_trans_huge_deposit() should 
likely get renamed to arch_pgtable_trans_huge_deposit() etc, as there 
will not be generic support for it.

-- 
Cheers,

David

