Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75659606A335
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w0a5j+QV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY1C0689Fz2y7p;
	Mon, 23 Nov 2026 20:40:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::a4"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795426828;
	cv=none; b=lJWDTa9Zn8ryHPMuTV0c95QBDepol5b5ERKsim/CWtV8pBpXkqpG8KjNYF2JKER04l0fOiCvcRjVBQtbLvF2MwgRDe88jRvUuOu5F3jlXIT2iwgBDg3fmRuzCoBrZ1iz7l9kJ5A7M8GyqnHeXPSXCEftyDtQsciuV7Jq82oHT2Dtoy+ADb5FN7AVgkGo7Gql28Q+ta4Ua1Kc9AS3PdUzASgrh4EkL/DhEGRq1fkmr+s+r3Kl3cRdKOYLoPDGycspWNex0/Ki9+iyxWQWopKOeczb0Tbd30aNtsxOexvkNpXVl+LMQn+PQ9Yv3Yhtwysr4oBaPaojXgBw1fasWm5w1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795426828; c=relaxed/relaxed;
	bh=i+eMkEpTzD81tZmWhd1BLHyxg3x1lR4H2TnpzoCNaEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCT5YUCQBaVyAFB1Lu+VzuAUyWC95UPbXEWWsiRotNblt11/cCLWflI9TAzEUFj99b2s83Q0WXX/CnSxbw0KpeNVqIB/DCuV1fzHbvIcx8Uppvr4fA+E/rvbMXqVw+sv0JLC5SdWJh7z+nxPHfGLF2+QubIqbZ6xZGc7wV5xHweNNvv/dm5CchL4ftZ41CggqhXgafcaAva3p9XETJmjSEmCFc59ziLzm2gvnOYl0q6MwCBRIjfjvtCfLjWa/u0XEW4r6UfiQCfy/PCmYCskkbGGmcd5L9rQr2tKVojVw8sIAtPbiBnKIFiH5ZCJ5U4UHPNJVT+XFSRq/d8jKJofkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w0a5j+QV; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::a4; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w0a5j+QV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::a4; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-164.mta1.migadu.com [IPv6:2001:41d0:203:375::a4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY1Bw6nZdz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 20:40:22 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=AKOZmr7uaBmqal/sCBWQH1DHrEHxf/qcqO9hy6TaXp0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795426800; v=1; x=1796031600;
 b=w0a5j+QVLgQnt8AxWCGmG4nvMdNOuSXGtXmaXT/ocu6Qjd/ZJuTwUYg1qEDsI1es1gLhmca9
 S8lcCBiFGeZu4872r6/YddxNKBz1WRpYliZwTU8bRG8Yekunbn5DKMXk5jzYOvPOhGMnXvj8dXl
 drW8MbgzJ5S5np45RfXwAtW0=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id f66f58c573959892;
	Mon, 23 Nov 2026 09:39:59 +0000
X-Mizu-Trace-ID: f66f58c573959892
X-Migadu-Flow: FLOW_OUT
Message-ID: <1d0e349a-9f9d-496b-8e86-9d4fccc14d72@linux.dev>
Date: Mon, 23 Nov 2026 17:39:54 +0800
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
Subject: Re: [PATCH v5 06/11] mm/vmalloc: undo what vmap_page_range() mapped
 on failure
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Dev Jain <dev.jain@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-7-hao.ge@linux.dev> <av4BbLb6SxEcRe-8@milan>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <av4BbLb6SxEcRe-8@milan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ulad

On 2026/11/19 03:50, Uladzislau Rezki wrote:
> On Mon, Nov 16, 2026 at 03:13:20PM +0800, Hao Ge wrote:
>> ioremap and arch setup code map their ranges with vmap_page_range().
>> When the walk fails half way, or the KMSAN metadata fails after the
>> walk, the ptes installed so far stay behind. The caller frees the
>> vm_area on the error path, so the next mapping that lands on the same
>> range trips the BUG() in vmap_pte_range().
>>
>> vmap_range_noflush() now takes a mapped_end argument that the walk
>> levels advance as they install, and vmap_pte_range() BUG()s before
>> it installs over a pte that is already set. The ptes below mapped_end
>> are therefore all ours, while a pte above it can only have been put
>> there by somebody else, for example when the caller's range overlaps
>> an existing mapping. On a walk failure the undo is limited to
>> [addr, mapped_end), going further would clear ptes that are not
>> ours. If the walk completed and only the KMSAN metadata failed, the
>> whole range was installed by this call and all of it is undone.
>>
>> All callers are sleepable, the teardown passes can_resched = true.
>>
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/vmalloc.c | 52 +++++++++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 39 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index d99d7710e1ba..5c1eacc2a0ac 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -117,7 +117,8 @@ static __always_inline unsigned long vmap_set_ptes(pte_t *ptep,
>>  
>>  static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>>  			phys_addr_t phys_addr, pgprot_t prot,
>> -			unsigned int max_page_shift, pgtbl_mod_mask *mask)
>> +			unsigned int max_page_shift, pgtbl_mod_mask *mask,
>> +			unsigned long *mapped_end)
>>  {
>>  	pte_t *pte;
>>  	u64 pfn;
>> @@ -143,6 +144,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>>  
>>  		size = vmap_set_ptes(pte, addr, end, pfn, prot, max_page_shift);
>>  		nr_pages = PFN_DOWN(size);
>> +		*mapped_end = addr + size;
>>  	} while (pte += nr_pages, pfn += nr_pages, addr += size, addr != end);
>>  
> vmap_pte_range() either s=install everything or nothing. At least if i
> do not miss anything.

Right, vmap_pte_range() either installs the whole range or nothing.

I will drop the mapped_end argument from it, and vmap_pmd_range() will
advance *mapped_end = next after the call succeeds.

Thanks
Best Regards
Hao

> 
> --
> Uladzislau Rezki
> 
> --
> Uladzislau Rezki

