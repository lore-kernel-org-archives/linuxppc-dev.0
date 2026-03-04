Return-Path: <linuxppc-dev+bounces-17718-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979D9EB7EDA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 12:30:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQsT76b3lz3btf;
	Wed, 04 Mar 2026 23:30:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::b0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772625394;
	cv=none; b=HEMIwMXqrfHl1MyJ+K3GuMvqzg9FdVPG84w5P4TR883zN74/Dh+nLtQVDPGPQQeTvf8A/f+EjMjEjfMZYHrIGflsBLbeIC1nmmhsClqoGNLZh9QQOxF/aOsj/i8IfAWECUZe87shJkYGXnmzzEXTFMk3xRM3DXwiRfTpcSgOeozjiLiqR7+rFgMCiOr7vpEGK8WX3O58V7wfa/SO2X1AHNi5UY8cpomgHFn9ShIz/9wV6kX/Am6t2fSCMYI8hDUuigP/O8cw5PVBTdmqr43/q7wJa+YX9zAgqvuL5CPR+S0e6xTxCYzmGvNS9KUNK6KvHG3AR9IyGe379ee/Wo7C4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772625394; c=relaxed/relaxed;
	bh=0GSFW9HWutiyPhp3WzVGPO7yi4M3/V6mlTS86vxN+yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzzfRAVcaI7Fj+Bi8F3ZEDzEPVbq2kS6zL5Em52Ln9TDTv5HoVOEC0wL0pF7oqGsBjcuibjZ9xjjDIpjzzVsX3oyKNbc0dAhNYxy78xo+MkJcfzP+Ti/JpAG0ECvVATsUROKb+/tWW0XZ1DFNv6x8Qb+yCp/06hj5iHVUcfS85ILBEbHDwAoRDjYIeHFuWIDxYGz0eAHA1qNgULLMS/R1s6JeGdsKGtdExzBZm1kTFTEdffjz53Vn6/E/5s4M2CJ2t7OsMSoBi3IYmHQctYOqx30BCIHWiaJBVhey6Y/FZoGf+mj55Jm5W++rGtIBYmRiNCeZNQUFVdtt5sV+80w+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cKcOQ1qd; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::b0; helo=out-176.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cKcOQ1qd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::b0; helo=out-176.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQrjq010Mz2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 22:56:29 +1100 (AEDT)
Message-ID: <498e94a6-08e7-42dc-81e9-113265bf3cff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772625364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GSFW9HWutiyPhp3WzVGPO7yi4M3/V6mlTS86vxN+yo=;
	b=cKcOQ1qdVvdnQejcmemBI4Pq3qOY5VnVc9kwe4KNTg0wcqUPZFubgLA+UZ+vtrX4xkvo9N
	0LseiTbrMFJEX6nLoxhpStCE8IXpZXBTvgwWs/UtvTWYbzeBgnEsX6Hj6op/UWLNSEvgpZ
	/TOscOWi9uf7M4MNwUTzadtAmjmzgqo=
Date: Wed, 4 Mar 2026 14:55:55 +0300
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
Subject: Re: [RFC v2 12/21] mm: thp: handle split failure in device migration
Content-Language: en-GB
To: Nico Pache <npache@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 lorenzo.stoakes@oracle.com, willy@infradead.org, linux-mm@kvack.org,
 fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260226113233.3987674-1-usama.arif@linux.dev>
 <20260226113233.3987674-13-usama.arif@linux.dev>
 <CAA1CXcDyqPPwf_-W7B+PFQtL8HdoJGCEqVsVxq7DhOUB=L4PQA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <CAA1CXcDyqPPwf_-W7B+PFQtL8HdoJGCEqVsVxq7DhOUB=L4PQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 02/03/2026 21:20, Nico Pache wrote:
> On Thu, Feb 26, 2026 at 4:34 AM Usama Arif <usama.arif@linux.dev> wrote:
>>
>> Device memory migration has two call sites that split huge PMDs:
>>
>> migrate_vma_split_unmapped_folio():
>>   Called from migrate_vma_pages() when migrating a PMD-mapped THP to a
>>   destination that doesn't support compound pages.  It splits the PMD
>>   then splits the folio via folio_split_unmapped().
>>
>>   If the PMD split fails, folio_split_unmapped() would operate on an
>>   unsplit folio with inconsistent page table state.  Propagate -ENOMEM
>>   to skip this page's migration. This is safe as folio_split_unmapped
>>   failure would be propagated in a similar way.
>>
>> migrate_vma_insert_page():
>>   Called from migrate_vma_pages() when inserting a page into a VMA
>>   during migration back from device memory.  If a huge zero PMD exists
>>   at the target address, it must be split before PTE insertion.
>>
>>   If the split fails, the subsequent pte_alloc() and set_pte_at() would
>>   operate on a PMD slot still occupied by the huge zero entry.  Use
>>   goto abort, consistent with other allocation failures in this function.
>>
>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
>> ---
>>  mm/migrate_device.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index 78c7acf024615..bc53e06fd9735 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -909,7 +909,13 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
>>         int ret = 0;
>>
>>         folio_get(folio);
> 
> Should we be concerned about this folio_get? Are we incrementing a
> reference that was already held if we back out of the split?
> 

Good catch! I think this bug existed even before this patch, if
folio_split_unmapped fails, the reference is still there. Let me
send an independent fix for this.

> -- Nico
> 
>> -       split_huge_pmd_address(migrate->vma, addr, true);
>> +       /*
>> +        * If PMD split fails, folio_split_unmapped would operate on an
>> +        * unsplit folio with inconsistent page table state.
>> +        */
>> +       ret = split_huge_pmd_address(migrate->vma, addr, true);
>> +       if (ret)
>> +               return ret;
>>         ret = folio_split_unmapped(folio, 0);
>>         if (ret)
>>                 return ret;

