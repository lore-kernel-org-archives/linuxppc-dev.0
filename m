Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32FF606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gYFZnEMf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8CWh2Cvvz2y2T;
	Wed, 21 Oct 2026 00:12:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::b5"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792501968;
	cv=none; b=briDU4bkwUq27jdbmlX/f8uKrrsli/9l1W6SJZPd8AYxnaPJnI2H4DedinhxVP7Fqm809jFSfRgcJw+XDd7dDs/GLG8/+w46VVBLn6H95gjOpy+5HjdwYUjBPzXCkPWleD4J8pgcexWkmKlgCAFGI1qmrV3XXaEm2LMTR51IGuRFJVE2bsJ0jKsrVmOUEMRSJp+z1YJox/PvdescYEAO00acJZBIgGmuXuWvGqDFrbagDUzCLia/7Ps1MqcOZYRARxsIgZ6J4aiYbSFP9PEaxAaBNlGmBMxH+YS+Xrd2VxtcZ/1msT/zBLRpSfsKMTglfzATCWhluN5Pr0F+G+PTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792501968; c=relaxed/relaxed;
	bh=COtPdQGJK7jNWqfgDfzbpfDSMkuuE3aMgNhGPl3y5n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpz8AtN670A7t5J1YleCRDp5OUYlb+W84RK8nkeSqYM3+QkMkN+h1Xccxxj7nWJP1IODkDitYcq6gYFzyLLPLsHg4VNEuUYQwhwIEz3SFclGbMOZhK5eFifb3fnIjiafA+pwNGgFmpO9jXI0WOyLEOxMZWXcn2k1CffYk5vRFdEBWISe9ctF0z5FkZI91wTo2rwlgBm3zcRHLvovTYAq3vRCfNXQ6UYkns0KtcorR6Bu+ouILnSjKmo0BnHCXM2kQy/FRlx9ilTzucKoJHynlM2UknVeSy+MOiweoPji4zKFrWktWBqOFOiFRwtbe1ix4+ZQcZv9vAyj3OEBJ0mhPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gYFZnEMf; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::b5; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gYFZnEMf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::b5; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-181.mta1.migadu.com [IPv6:2001:41d0:203:375::b5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8CWc5vf5z2xwL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 00:12:41 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=Wc1RWHwk8Xdv1pW2d6s7sF1ggFAVdoXSgDjlgBucV+Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792501937; v=1; x=1793106737;
 b=gYFZnEMfowCMjOFR93SUcUyQK/m2WGEFyHp+36K3Zf0iUSDDpUuEG32E604IF0tb+F8FHLXK
 U7Wc1b3HIMr0AD0aNsmDCuqihhlYSk6WNb0OpBsCxJBBmFDNgiZhrw2bsw0S7xaD/g1cUFqHJqE
 sjKpXCdajMdJGGTQramICtj8=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 41652e7101a74390;
	Tue, 20 Oct 2026 13:12:17 +0000
X-Mizu-Trace-ID: 41652e7101a74390
X-Migadu-Flow: FLOW_OUT
Message-ID: <aabae9f2-ceed-4254-a778-aefaea4df257@linux.dev>
Date: Tue, 20 Oct 2026 21:12:08 +0800
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm/vmalloc: undo partial mappings inside the
 mapping functions
To: Dev Jain <dev.jain@arm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Uladzislau Rezki <urezki@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Christoph Lameter <cl@gentwo.org>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
 Alexander Potapenko <glider@google.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261019054531.87652-1-hao.ge@linux.dev>
 <20261019054531.87652-4-hao.ge@linux.dev>
 <dcad793e-8814-4bbf-8b31-3ec9d0bb9ede@arm.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <dcad793e-8814-4bbf-8b31-3ec9d0bb9ede@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dev


On 10/20/26 13:46, Dev Jain wrote:
>
> On 19/10/26 11:15 am, Hao Ge wrote:
>> __vmap_pages_range_noflush() and friends can install some PTEs before
>> failing and leave them mapped, and the kernel callers do not agree on
>> who cleans them up. pcpu_map_pages() and kmsan_ioremap_page_range()
>> roll back what they mapped before the failure, while
>> vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
>> __vmalloc_area_node() rely on the mapping functions cleaning up and
>> do not call anything like vunmap_range() themselves. When the same
>> range is mapped again, the attempt hits the leftovers and fails, with
>> a BUG() in vmap_pte_range() for huge mappings and a warning on the
>> small-page path.
>>
>> After discussing with Suren and Ulad, we decided to put the rollback
>> into the entry points of the vmap API rather than into every low-level
>> helper. __vmap_pages_range_noflush() undoes the whole range it was
>> asked to map when it fails, and vmap_page_range() undoes its range
>> for the ioremap-style mappings.
>>
>> The rollback is __vunmap_range_noflush(), it only clears the PTEs,
>> no TLB flush, nothing has touched these mappings.
>> vmap_pages_range_noflush() drops the KMSAN metadata when the data
>> mapping fails, and an empty range bails out with -EINVAL now, which
>> used to BUG_ON() on the small-page path and map nothing at all on
>> the huge-page one.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Suggested-by: Uladyslau Rezki <urezki@gmail.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>   mm/vmalloc.c | 44 ++++++++++++++++++++++++++++++++------------
>>   1 file changed, 32 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 44e0eb32708f..75aa5acf5566 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -363,6 +363,9 @@ int vmap_page_range(unsigned long addr, unsigned long end,
>>   	if (!err)
>>   		err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
>>   					       ioremap_max_page_shift);
>> +	if (err)
>> +		__vunmap_range_noflush(addr, end);
>> +
>>   	return err;
>>   }
>>   
>> @@ -683,27 +686,35 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>>   		pgprot_t prot, struct page **pages, unsigned int page_shift)
>>   {
>>   	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
>> +	unsigned long start = addr;
>> +	int err = 0;
>> +
>> +	if (WARN_ON_ONCE(addr >= end))
>> +		return -EINVAL;
> IIUC this is a general change independent of this patch? Caller could pass
> addr >= end and if we take the huge mapping path, we lose the sanity check.
>
> So this could become a separate patch.


OK,  and Sashiko has flagged another case:

when 0 < end - addr < PAGE_SIZE, nr = (end - addr) >> PAGE_SHIFT 
evaluates to 0,

so the huge-page path still maps nothing and returns 0.

So this separate patch would cover this case as well.


Thanks

Best Regards

Hao


>
>
>>   
>>   	if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
>>   		return -EINVAL;
>>   
>>   	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
>> -			page_shift == PAGE_SHIFT)
>> -		return vmap_small_pages_range_noflush(addr, end, prot, pages);
>> -
>> -	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
>> -		int err;
>> -
>> -		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
>> +			page_shift == PAGE_SHIFT) {
>> +		err = vmap_small_pages_range_noflush(addr, end, prot, pages);
>> +	} else {
>> +		for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
>> +			err = vmap_range_noflush(addr, addr + (1UL << page_shift),
>>   					page_to_phys(pages[i]), prot,
>>   					page_shift);
>> -		if (err)
>> -			return err;
>> +			if (err)
>> +				break;
>>   
>> -		addr += 1UL << page_shift;
>> +			addr += 1UL << page_shift;
>> +		}
>>   	}
>>   
>> -	return 0;
>> +	/* Undo the PTEs installed before the failure. */
>> +	if (err)
>> +		__vunmap_range_noflush(start, end);
>> +
>> +	return err;
>>   }
>>   
>>   int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>> @@ -715,7 +726,16 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>>   
>>   	if (ret)
>>   		return ret;
>> -	return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
>> +
>> +	ret = __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
>> +	/*
>> +	 * The page tables undo themselves on failure. Tear down the
>> +	 * metadata that was fully set up before the mapping failed.
>> +	 */
>> +	if (ret)
>> +		kmsan_vunmap_range_noflush(addr, end);
>> +
>> +	return ret;
>>   }
>>   
>>   static int __vmap_pages_range(unsigned long addr, unsigned long end,

