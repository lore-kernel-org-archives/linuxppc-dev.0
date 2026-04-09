Return-Path: <linuxppc-dev+bounces-19526-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8486EA3C59
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2026 12:48:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fs09b1XR3z2ygf;
	Thu, 09 Apr 2026 22:48:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775738931;
	cv=none; b=d1sYKnSlERDmZr115bnXBzdSgdqFj//dnTcgFcX1/FQXqucy7Ny6X1H6tjBh8k5Rei5fpB8UlJX+o4EDEmjh5XeYnUGSUs65PoPGmV3zdbW0MXJOridGSmaHOcbo7Q1+6DXrOigARYiWM/+3wcyL8t9HF9oR2wa7z8uXv/nxrX9l/Cc5RbOOv31CAl48driJexLG/BVnbi/t2h3LwOnMUUfXd/gVwNodKCpNH4ZWO+QNyUx2kEReLxH87JFzOuCLzZonODgsmhdcXcbNBTeUHugxddJf+JHy7RlnlibZnL7WfZvCm3Q5cAVxj9e/WO49fLi3gTER36/uEy6gl7MIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775738931; c=relaxed/relaxed;
	bh=wsDQYaBb80vPizdMN7gGIHoZqJFZXjCQHHQTYzLrH8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ipobdb7WpRiMrsTMB1OsUTczE++1sAKfgJucHzzebqlLkfxjZU66qKI/YLZeaeMtQc8r2A7XrkhD/nii7tskO3jzUAaxOvZBamZ2/bluiGo3PuLiObOunxhGl02IuKLVzhr8I7ry1dprZC3zXRHgV7qiTnYpiy6QBmDspnkMnLjhIKEL2U/QJQ58TsIoO0nAFIWtdm5LFoLWQ+/hkSzKXW32wnwxijtnrv6pd4jTx2qJ287pPK4yP/3C/KMq7m/bE1KA9xVBRyMyIJgnRS3EBSR8HZ/0eZGpQP+tb9qkkBUt3UoWU2LvdlL0eAXcGVpmBLenSRCruHKgOQAzmuDDfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N58DRV0l; dkim-atps=neutral; spf=pass (client-ip=95.215.58.182; helo=out-182.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N58DRV0l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.182; helo=out-182.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fs09W6x0Lz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 22:48:46 +1000 (AEST)
Message-ID: <9fb076b5-ed33-458d-b39b-a2de3433a0da@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775738906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsDQYaBb80vPizdMN7gGIHoZqJFZXjCQHHQTYzLrH8c=;
	b=N58DRV0lqQMRB98jfQIHyX0PR1r8vfmdZbvQlX7bIk4RgD5Wfb1wM8xheil7ZLjaVplT/E
	s2RSV+kXmM2OV94QFp4bMptKc2N8nO7u3rlLIWbDicI7WEDlkv0GkdF4rWovVtYeXLB5UM
	OH8hilcKSz/LsY3bIUt2nX38zb3DXFc=
Date: Thu, 9 Apr 2026 13:48:14 +0100
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
Subject: Re: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split
 time
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, david@kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>, linux-mm@kvack.org, fvdl@google.com,
 hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org,
 Nhat Pham <nphamcs@gmail.com>
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <6869b7f0-84e1-fb93-03f1-9442cdfe476b@google.com>
 <3f9e8e12-2d51-4f2a-ada1-994ed24df284@linux.dev>
 <adaxWs8BjCJB1aan@casper.infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <adaxWs8BjCJB1aan@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 08/04/2026 20:49, Matthew Wilcox wrote:
> On Wed, Apr 08, 2026 at 04:06:29PM +0100, Usama Arif wrote:
>> On 06/04/2026 00:34, Hugh Dickins wrote:
>>> What would help a lot would be the implementation of swap entries
>>> at the PMD level.  Whether that would help enough, I'm sceptical:
>>> I do think it's foolish to depend upon the availability of huge
>>> contiguous swap extents, whatever the recent improvements there;
>>> but it would at least be an arguable justification.
>>>
>> Thanks for pointing this out. I should have thought of this as I
>> have been thinking about fork a lot for 1G THP and for this series.
>>
>> I am working on trying to make PMD level swap entires work. I hope
>> to have a RFC soon.
> 
> I think you may have missed Hugh's point a little bit.  If we do
> support PMD-level swap entries, that means we have to be able to find
> contiguous space in the swap space for 512 entries.  I don't know how
> hard that will be, but I can imagine it's not that easy.

Ah so my understanding is that with CONFIG_THP_SWAP enabled, the swap
allocator already tries to allocate 512 contiguous swap slots for a THP.
With CONFIG_THP_SWAP, each swap cluster is exactly SWAPFILE_CLUSTER (512)
entries in size, meaning 2M will fit perfectly. Clusters track their
allocation order (ci->order), and the swap allocator maintains per-order
free lists (nonfull_clusters[order]), so THP-order allocations are
directed to clusters already dedicated to that order rather than
competing with base-page allocations.
The per-CPU caching (percpu_swap_cluster.si[order] / offset[order])
should further ensure that consecutive THP swap-outs from the same CPU
reuse the same cluster efficiently.

With PMD swap entry we will change how the page table records it
(1 PMD entry vs 512 PTE entries). Hence we wont need to allocate
page tables and would help to address Hugh's valid concern
of have to allocate pagetables if there is no pagetable depost.



