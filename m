Return-Path: <linuxppc-dev+bounces-16847-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1CBEE36AC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Feb 2026 17:01:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBhRR6kCtz2yFm;
	Fri, 13 Feb 2026 04:01:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.178
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770910036;
	cv=none; b=LUrv/mo6N61kXHO+0Hh1za/dWFEGT37VlTX2G0M1a0D9TLhqVtg+u+WOJUCCmIN1M/84Vqsd1uOFGUBoOALTOzYIiKVuSbLg/8Wjf9KWWO6me5Vxyqh35z6q2XlgZ/s4vFku1sCi+R83vDaa0aMdBt8/K1ovjGl02+UuiXmX85ra/8BkbzPUcvBbHehH420VnnbFYn5k1WBC0R5HiMJ+dclGPVDmsLok9y2npXuF+f85S95kInsQ/NHhEGU+dT57ClJGeEy+lr8dzDegJiXd6pe8j1EjPoLru7HBSrR+2Ii+/yeOiReMIFFwLt8mTMo+OVS3C28c81Qfd60k9EEzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770910036; c=relaxed/relaxed;
	bh=3md81SdFS4TjjB0AXkEg5ItTPXkzpc4iibpel7Bvl6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvwtOoKO4G/6h0nEbJTfLfvXe4rr7YmeRyJDJaYzriDwdK2iZZXQyv1w6mJ1bPziHcFw8TOsgwbkWiGAuoLE6/nHj4Srg3e3LWkLAL6xNpzH+yeFcNYE/vkcOCa69rT6XxNVGV7Z8/kcploybafgGU56+zf2yFbwyXIigm4rfLmJDcILHT5Pw6s0uDbIJmZMNKOv4BXxD+KNoxfFNJRqarIm6oQfxx0u6bPiqV9S3/9aZ88jtoJJl7j9J47f3ncQ+1DCyHTAO/pA6xn8GyJ7r3cQ7J0WrQUM7vqtINKooJi0mfqnORpAR5aeUZQsylwLgbxp9OM7iVko4cWRzWGHPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hjkncimN; dkim-atps=neutral; spf=pass (client-ip=91.218.175.178; helo=out-178.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hjkncimN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.178; helo=out-178.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 72 seconds by postgrey-1.37 at boromir; Fri, 13 Feb 2026 02:27:12 AEDT
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBfL83HP5z2xdY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2026 02:27:12 +1100 (AEDT)
Message-ID: <93908945-e0a8-429c-b119-eff63ebb2479@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770909937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3md81SdFS4TjjB0AXkEg5ItTPXkzpc4iibpel7Bvl6Q=;
	b=hjkncimNaPPExvn/emeaq/h/AlfCnw+mVVCMpaG7jfK1AU3G5MNnceGQoxpZLRm+7s8TrG
	SMgyuBDmGiF9cfQ+M2rMahOUxsaiyqzUKf7jsPpmGt1bnR/CpoXyBRoS/SAaXyBEptiUA9
	w68x0WYS4Za0LU2R9RKu9ekkYbD3FhI=
Date: Thu, 12 Feb 2026 15:25:33 +0000
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
Subject: Re: [RFC 1/2] mm: thp: allocate PTE page tables lazily at split time
Content-Language: en-GB
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
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
 <13ab56cb-7fdb-4ee4-9170-f9f4fa4b6e37@kernel.org>
 <875x82ma6q.ritesh.list@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <875x82ma6q.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 12/02/2026 12:13, Ritesh Harjani (IBM) wrote:
> "David Hildenbrand (Arm)" <david@kernel.org> writes:
> 
>> CCing ppc folks
>>
> 
> Thanks David!
> 
>> On 2/11/26 13:49, Usama Arif wrote:
>>> When the kernel creates a PMD-level THP mapping for anonymous pages,
>>> it pre-allocates a PTE page table and deposits it via
>>> pgtable_trans_huge_deposit(). This deposited table is withdrawn during
>>> PMD split or zap. The rationale was that split must not fail—if the
>>> kernel decides to split a THP, it needs a PTE table to populate.
>>>
>>> However, every anon THP wastes 4KB (one page table page) that sits
>>> unused in the deposit list for the lifetime of the mapping. On systems
>>> with many THPs, this adds up to significant memory waste. The original
>>> rationale is also not an issue. It is ok for split to fail, and if the
>>> kernel can't find an order 0 allocation for split, there are much bigger
>>> problems. On large servers where you can easily have 100s of GBs of THPs,
>>> the memory usage for these tables is 200M per 100G. This memory could be
>>> used for any other usecase, which include allocating the pagetables
>>> required during split.
>>>
>>> This patch removes the pre-deposit for anonymous pages on architectures
>>> where arch_needs_pgtable_deposit() returns false (every arch apart from
>>> powerpc, and only when radix hash tables are not enabled) and allocates
>>> the PTE table lazily—only when a split actually occurs. The split path
>>> is modified to accept a caller-provided page table.
>>>
>>> PowerPC exception:
>>>
>>> It would have been great if we can completely remove the pagetable
>>> deposit code and this commit would mostly have been a code cleanup patch,
>>> unfortunately PowerPC has hash MMU, it stores hash slot information in
>>> the deposited page table and pre-deposit is necessary. All deposit/
>>> withdraw paths are guarded by arch_needs_pgtable_deposit(), so PowerPC
>>> behavior is unchanged with this patch. On a better note,
>>> arch_needs_pgtable_deposit will always evaluate to false at compile time
>>> on non PowerPC architectures and the pre-deposit code will not be
>>> compiled in.
>>
>> Is there a way to remove this? It's always been a confusing hack, now 
>> it's unpleasant to have around :)
>>
> 
> Hash MMU on PowerPC works fundamentally different than other MMUs
> (unlike Radix MMU on PowerPC). So yes, it requires few tricks to fit
> into the Linux's multi-level SW page table model. ;) 
> 
> 
>> In particular, seeing that radix__pgtable_trans_huge_deposit() just 1:1 
>> copied generic pgtable_trans_huge_deposit() hurts my belly.
>>
> 
> On PowerPC, pgtable_t can be a pte fragment. 
> 
> typedef pte_t *pgtable_t;
> 
> That means a single page can be shared among other PTE page tables. So, we
> cannot use page->lru which the generic implementation uses. I guess due
> to this, there is a slight change in implementation of
> radix__pgtable_trans_huge_deposit(). 
> 
> Doing a grep search, I think that's the same for sparc and s390 as well.
> 
>>
>> IIUC, hash is mostly used on legacy power systems, radix on newer ones.
>>
>> So one obvious solution: remove PMD THP support for hash MMUs along with 
>> all this hacky deposit code.
>>
> 
> Unfortunately, please no. There are real customers using Hash MMU on
> Power9 and even on older generations and this would mean breaking Hash
> PMD THP support for them. 
> 
> 

Thanks for confirming! I will keep the pagetable deposit for powerpc
in the next revision.
I will rename pgtable_trans_huge_deposit to arch_pgtable_trans_huge_deposit
and move it to arch/powerpc. It will an empty function for the rest of the
architectures.

>>
>> the "vma_is_anonymous(vma) && !arch_needs_pgtable_deposit()" and similar 
>> checks need to be wrapped in a reasonable helper and likely this all 
>> needs to get cleaned up further.
>>
>> The implementation if the generic pgtable_trans_huge_deposit and the 
>> radix handlers etc must be removed. If any code would trigger them it 
>> would be a bug.
>>
> 
> Sure, I think after this patch series, the radix__pgtable_trans_huge_deposit() 
> will mostly be a dead code anyways. I will spend some time going
> through this series and will also give it a test on powerpc HW (with
> both Hash and Radix MMU).
> 
> I guess, we should also look at removing pgtable_trans_huge_deposit() and
> pgtable_trans_huge_withdraw() implementations from s390 and sparc, since
> those too will be dead code after this.
> 
> 
>> If we have to keep this around, pgtable_trans_huge_deposit() should 
>> likely get renamed to arch_pgtable_trans_huge_deposit() etc, as there 
>> will not be generic support for it.
>>
> 
> Sure. That make sense since PowerPC Hash MMU will still need this.
> 
> -ritesh


