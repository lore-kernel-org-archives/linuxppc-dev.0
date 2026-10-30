Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41535606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L/z/9dLJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFq771Hcz2ySc;
	Fri, 30 Oct 2026 20:17:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793351827;
	cv=none; b=B41ZVgfFP1b55Uj1ldew6wA8DG1wIfiiIaBEhv9XGjmhAlmNGov35iBsK4MbRlkzKCmJDX6zG7rCZfk1ywHDyL/elNunCcO33TeNU12icKgiD8g8Ymd0kqc51wkcDRD8nNhilGxLV0BwxRb0tNDb9UkwLV9nifuB38NBFYqifkspmEdqL5QgqdANCFmbKKtLCKcuokjAuUDq0z90XgTQSwq8/oj40ZpVkFwQe8ov/9P89SsgJFWrh6p083/uTuuxbR/3lv0XnUGkb9FygsXSuFLltj4+ZVH6K5nJepU//o4GI+HUejbzenfRO126fdHRH6sBOnDaHBP3UduE8xljnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793351827; c=relaxed/relaxed;
	bh=cvtULt05CNENF+dcGaZHfj6dxMkQ2uk2IJDUbG8kU5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bk9PNOPD1Km5jj2eoWlBxjTTD/AbjQyit/MY4A1xmuD9iAg/gvrBE/S3855zzxPEaByB6mNVkfbnZluiVBOmgYLcZH4fPRxW3GdvToLtI+o+JDuKy75VzUvn6UrNLY6rXlRqXoJaNaAhItWkj65+8TdFnOr4+rxeRY+oNw9p88cymO5Ck1AgG7O8sIFhNCD7ePVmUOwZVEzX61THvoU3osp2HYWRqNK2ZYKT2pvv9JFoVbHfjUTsmAmJvMVkHHUXqk3g5gsEMusMAAub5f0YBqO8kr80JjMPJWJScTc4NCe/zpaicFmqoVb3PW3NGyabFGtA8EfmqGCuHJuWdwhFnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L/z/9dLJ; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::7; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L/z/9dLJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::7; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-7.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGFq41T7Vz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 20:17:03 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=OWKCARjtfy267o2XbXOnvCk2rMveSznO0EDjspP5kOc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793351804; v=1; x=1793956604;
 b=L/z/9dLJkBARi4jgTksj29qiWtnJSWqNvWmLXIJE/GU6yMRErXEYPJLIP+jGcOnyhpeOd9Pn
 UP6SnZ171jG0Vx525QTSlII7e3amdM4Jw3z8d3RdLgCh/X7hybmPiB4tFPV2ahcI6O8Yc7sPM24
 UltHTD0eFp37sJ7yP0Wfm2vA=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 339b1e922908af26;
	Fri, 30 Oct 2026 09:16:44 +0000
X-Mizu-Trace-ID: 339b1e922908af26
X-Migadu-Flow: FLOW_OUT
Message-ID: <5b0f90a4-c7d2-4f12-9d95-95c7149c49c7@linux.dev>
Date: Fri, 30 Oct 2026 17:18:01 +0800
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
Subject: Re: [PATCH v3 04/10] mm/vmalloc: propagate errors in
 vmap_pages_p*d_range()
To: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
References: <20261026080329.140244-1-hao.ge@linux.dev>
 <20261026080329.140244-5-hao.ge@linux.dev>
 <e1cfd568-8fdf-4aa1-a8c5-961bb8d7efba@arm.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <e1cfd568-8fdf-4aa1-a8c5-961bb8d7efba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dev

Thanks for your review.

On 2026/10/30 15:29, Dev Jain wrote:
> 
> 
> On 26/10/26 1:33 pm, Hao Ge wrote:
>> vmap_pages_pmd_range(), vmap_pages_pud_range() and
>> vmap_pages_p4d_range() return -ENOMEM whenever the level below them
>> fails.  But vmap_pages_pte_range() can also return -EINVAL for a
>> page without a valid pfn and -EBUSY for a pte that is already
>> mapped.  Pass the error up as-is instead, like the vmap_p*d_range()
>> helpers for vmap_page_range() do.
>>
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
> 
> Fixes?
>

Sorry, I missed that.

> Reviewed-by: Dev Jain <dev.jain@arm.com>

Thanks! If you have some time, I'd also appreciate a review of the
remaining patches in the series -- or Suren and Uladzislau, if they
get a chance. No rush, I know everyone is busy.

Thanks
Best Regards
Hao

> 
> 
>>  mm/vmalloc.c | 24 +++++++++++++++---------
>>  1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 7131f60d1a8e..d60b99b81ec9 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -600,16 +600,18 @@ static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
>>  {
>>  	pmd_t *pmd;
>>  	unsigned long next;
>> +	int err = 0;
>>  
>>  	pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
>>  	if (!pmd)
>>  		return -ENOMEM;
>>  	do {
>>  		next = pmd_addr_end(addr, end);
>> -		if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask))
>> -			return -ENOMEM;
>> +		err = vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask);
>> +		if (err)
>> +			break;
>>  	} while (pmd++, addr = next, addr != end);
>> -	return 0;
>> +	return err;
>>  }
>>  
>>  static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
>> @@ -618,16 +620,18 @@ static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
>>  {
>>  	pud_t *pud;
>>  	unsigned long next;
>> +	int err = 0;
>>  
>>  	pud = pud_alloc_track(&init_mm, p4d, addr, mask);
>>  	if (!pud)
>>  		return -ENOMEM;
>>  	do {
>>  		next = pud_addr_end(addr, end);
>> -		if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask))
>> -			return -ENOMEM;
>> +		err = vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask);
>> +		if (err)
>> +			break;
>>  	} while (pud++, addr = next, addr != end);
>> -	return 0;
>> +	return err;
>>  }
>>  
>>  static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
>> @@ -636,16 +640,18 @@ static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
>>  {
>>  	p4d_t *p4d;
>>  	unsigned long next;
>> +	int err = 0;
>>  
>>  	p4d = p4d_alloc_track(&init_mm, pgd, addr, mask);
>>  	if (!p4d)
>>  		return -ENOMEM;
>>  	do {
>>  		next = p4d_addr_end(addr, end);
>> -		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
>> -			return -ENOMEM;
>> +		err = vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask);
>> +		if (err)
>> +			break;
>>  	} while (p4d++, addr = next, addr != end);
>> -	return 0;
>> +	return err;
>>  }
>>  
>>  static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
> 

