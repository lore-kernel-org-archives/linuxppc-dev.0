Return-Path: <linuxppc-dev+bounces-21237-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E33CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 12:15:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL9VT3S0Mz2xqv;
	Wed, 20 May 2026 22:15:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b4"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779279345;
	cv=none; b=X6G7VeahEsacax/ZhjlRA0arEj4V2wEXJwY9/225/BgOPBmg449Q3YFx4zGyiw8/J9bhr3JC0/pHxCIxUCEpqJU+seG3ZDjtIjoAcJU5XHufJGoRk/42nXKlnZDCJ/HTOQxFKTQpDNIT+SPbxbRxM4TYxaUdDNTjIczKtammzb0tStJRkSt/HtESBbEuzu2+9+0itmubsceDfcmqGgVTMBVGg1Qs6/aUP2RkXdQZadQ1FrKGmU8jYF1soWQWKFj+n41A1cROhysCi1oebuqLR59t8/I0PFmGq3ndE+oiNiTyo/W5VraOhGtYjZ6JyRXAIbVahPuvKS8AEeqWEPtFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779279345; c=relaxed/relaxed;
	bh=lpVD7PvJ3yLAhhJddRj1iqDdwuhUY+Ubp+n7mSO2yuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INovSsdepukIF8gP201aX51wQgN2nmOqPu7sec2QOPEXhIK1JsKIpJb1WjASOu9gwawndy6LukZH7u6RA2kdndDoG/pZIOYaa0/urUFwDEPUbNkRSm+jE4elNNXYog8RrQ0g+gkYbed4bgnfn8qjlqUrIBJaC5wElOF9D+hBnHw2RXKkgz6dakPuCb/gh3mWbm/LKEtCT0BQqubQYeMjeItWw25Bmijpos8l4qh/4WPAEBX/U7Va+vu0iSgI3tLrPXLn28iy+rUL/OWs6wgkZgSNO0qXToKKhRzry3Y+XtMVAl9ip+S0zNFE74EGj44pPjL2wewUiGxcxIwEoyFB5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CxR4mGr/; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b4; helo=out-180.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CxR4mGr/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b4; helo=out-180.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL9VQ6wVxz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 22:15:41 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779279320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpVD7PvJ3yLAhhJddRj1iqDdwuhUY+Ubp+n7mSO2yuo=;
	b=CxR4mGr/kbCFb8VOKtUL9MJeH5OxsnTYvxgXmVOSe0Z9v82ZfRdNB3x4IjDWyCRj/mcar0
	2MlOZFVwz6UAb24nlbVSQvG8zVgEBTUcHXyjchJ9+S+e3On01dfRhOwahPNI2CzLOC+eU2
	2RM45/OVYi7NgcXDE3Ms3iA9ru4uu3M=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: osalvador@suse.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 4/8] mm/bootmem_info: remove call to kmemleak_free_part_phys()
Date: Wed, 20 May 2026 20:15:05 +0800
Message-Id: <20260520121505.60854-1-lance.yang@linux.dev>
In-Reply-To: <b2a8e918-7ed2-46b4-bf59-e65dc9359310@kernel.org>
References: <b2a8e918-7ed2-46b4-bf59-e65dc9359310@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Tue, May 12, 2026 at 10:45:03AM +0200, David Hildenbrand (Arm) wrote:
>On 5/12/26 10:34, Oscar Salvador wrote:
[...]
>>> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
>>> index 6e2aaab3dca9..74c1116626c8 100644
>>> --- a/mm/bootmem_info.c
>>> +++ b/mm/bootmem_info.c
>>> @@ -32,7 +32,6 @@ void put_page_bootmem(struct page *page)
>>>  
>>>  	if (page_ref_dec_return(page) == 1) {
>>>  		set_page_private(page, 0);
>>> -		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
>> 
>> A bit odd that kmemleak_free_part_phys() did not complain if we never
>> did kmemleak_alloc_phys() for these pages?
>
>delete_object_part() calls __find_and_remove_object() and essentially just skips
>if it didn't find anything.
>
>Maybe the kmemleak_warn() would trigger, but it's guarded by "#ifdef DEBUG" ...

Right! With kmemleak DEBUG enabled, kmemleak_free_part_phys() does warns
whenever delete_object_part() cannot find the corresponding physical
object ...

Before this patch, booting with:

"kmemleak=on hugetlb_free_vmemmap=on default_hugepagesz=2M hugepagesz=2M hugepages=512"

I got a lot of warnings, something like:

[   44.481883] kmemleak: Partially freeing unknown object at 0x2acc59000 (size 4096)
[   44.482754] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.1.0-rc3 #206 PREEMPT(full)
[   44.482758] Hardware name: Red Hat KVM, BIOS 1.11.0-2.el7 04/01/2014
[   44.482760] Call Trace:
[   44.482762]  <TASK>
[   44.482764]  dump_stack_lvl+0x60/0x90
[   44.482769]  dump_stack+0x14/0x1a
[   44.482774]  delete_object_part.cold+0x28/0x2d
[   44.482779]  kmemleak_free_part_phys+0x67/0x80
[   44.482783]  put_page_bootmem+0xc0/0x100
[   44.482787]  free_vmemmap_page_list+0x13e/0x230
[   44.482791]  __hugetlb_vmemmap_optimize_folios+0x351/0x430
[...]

So, yeah, looks like these calls are trying to free physical kmemleak
objects that are no longer tracked after memmap_alloc() started using
MEMBLOCK_ALLOC_NOLEAKTRACE :)

With this patch applied, those stale calls are gone, and so are the
warnings :P

Tested-by: Lance Yang <lance.yang@linux.dev>

