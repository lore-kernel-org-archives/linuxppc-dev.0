Return-Path: <linuxppc-dev+bounces-18643-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30399F483F1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 20:03:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffkcl6QyMz2xGF;
	Tue, 24 Mar 2026 07:03:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774296199;
	cv=none; b=Wcf8Vy14m2jc6fHw6QTKWViabh6aKU62MfoOfF5YC04+zZ3IUT4Jb7Hgq6M2oytbXIYA9r0qoQfYb6BSU8zwwyl2b9t37PPNPavpx602g2ddfWSe8PlRGAYtydK1ejeOsfM/zbyMYkOz5EZNVPw0DNx6yE+yW4ThXCTxyeAnhCfkuQJuI4lTdXLofmGRhoGpZVdlgKbDoJpwYCmNm67efBcGBSSb+giRBVJfGH3xOjtGqYcYYaIPNY6xlpdkOOrRJ0PKQt79WgewfLU+EJ0O5lOJ6fLFCNla1Cke0/W9wRA6qIuOGGndnjlFJA3jSMrjTx0rGaNO+1Wh5Du4kvWMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774296199; c=relaxed/relaxed;
	bh=LMiD7aGBWRNBc8rw8Ru2feX03FfkuHXnCvx9PhfP2jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgJDm9kYAJzapID+4k9a2yUXbKcSgVVytnCk3MVnOvVbyfJHtjL9+04wTJf1GK5UzAUYR2tZeRbJxZUboeh9zaNlst3cxOVU2tRXTDpFlT8gs+GDtm/DDteVw5+OSzh/QH2hO2qkk1I/gJF9lR8h70lYlroa9JnJF9uR1dhREWvtQ2JKeoNhDw+0mrZbAyBfuheW3SUMlhtMSX9agfB+ibEFZMNwdvG8Q71DeE/itXm2Z5MC/5t7aFsgd7dEERIoKcQHVD5LXo9SwgjTht7kHFb85QPKMm7ebZSOGh/m2aD/ho7UoZyKJ/xNOIywCPl1BJx8oUltzMGOuqnHnBgW7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V3bPvp4W; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V3bPvp4W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffkck6x4Cz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 07:03:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 223E0600AC;
	Mon, 23 Mar 2026 20:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E24C4CEF7;
	Mon, 23 Mar 2026 20:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774296195;
	bh=Ry9/ThWWm3NaJS9J3iVFhUufSXRZider2VTGGVSZX4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V3bPvp4Wdw1HLhSEqO/pabWccNaY498YACGXN3O+FZpo9FjukTwWbpqvcmE2F/XmD
	 QZL5OhTizu5WvdlI7OG0seoyzZnigqpECWskMbvqRy/y9M1XvKD8CVpPFfRAXqSgIl
	 wJpSamxOoYYM2ZKor2b6GB3b1TGRpLT+zL4ApYg01UJVYUzPW2xL6nZSjhiXQAAR8q
	 zmNnMhkLR9hRfdtYqtFizqt3jKTWaNYjU3zTRL4SU+tfgV3N6lW+hTKnChBljDrKTF
	 SKtLZpYwbKPUYVGUAD2OFdab3ZuEmW2XCoCjxgABgbTr1TBT6CmU3SD4Br23pu5BNl
	 fwmW91a7puHAw==
Message-ID: <ad64f739-4cbd-42df-8dfb-2e5f89a96f2a@kernel.org>
Date: Mon, 23 Mar 2026 21:03:09 +0100
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
Subject: Re: [PATCH v6 05/13] mm/page_vma_mapped: Add flag to
 page_vma_mapped_walk::flags to track device private pages
To: Alistair Popple <apopple@nvidia.com>
Cc: Jordan Niethe <jniethe@nvidia.com>, linux-mm@kvack.org,
 balbirs@nvidia.com, matthew.brost@intel.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ziy@nvidia.com, lorenzo.stoakes@oracle.com, lyude@redhat.com,
 dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch, rcampbell@nvidia.com,
 mpenttil@redhat.com, jgg@nvidia.com, willy@infradead.org,
 linuxppc-dev@lists.ozlabs.org, intel-xe@lists.freedesktop.org, jgg@ziepe.ca,
 Felix.Kuehling@amd.com, jhubbard@nvidia.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, ying.huang@linux.alibaba.com
References: <20260202113642.59295-1-jniethe@nvidia.com>
 <20260202113642.59295-6-jniethe@nvidia.com>
 <81e7bd1c-54d5-4f88-969a-685177447c51@kernel.org>
 <abzSSHQUnDs_AFoz@nvdebian.thelocal>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <abzSSHQUnDs_AFoz@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>>  #define DEFINE_FOLIO_VMA_WALK(name, _folio, _vma, _address, _flags)	\
>>>  	struct page_vma_mapped_walk name = {				\
>>> -		.pfn = folio_pfn(_folio),				\
>>> +		.pfn = folio_page_vma_walk_pfn(_folio),			\
>>>  		.nr_pages = folio_nr_pages(_folio),			\
>>>  		.pgoff = folio_pgoff(_folio),				\
>>>  		.vma = _vma,						\
>>>  		.address = _address,					\
>>> -		.flags = _flags,					\
>>> +		.flags = page_vma_walk_flags(_folio, _flags),		\
>>>  	}
>>
>> That's all rather horrible ...
>>
>>
>> I was asking myself recently, why something that is called
>> "page_vma_mapped_walk" consume a pfn. It's just a horrible interface.
> 
> I don't disagree, and in fact it used to consume a page until 2aff7a4755be ("mm:
> Convert page_vma_mapped_walk to work on PFNs"). If this was a page it would
> basically resolve all the hackiness of this patch because we would no longer
> have to pass PFN context around. So I wonder if there would be any opposition to
> changing this back to taking a page?

Are there cases where we pass a struct-page-less PFN?

The offenders are pfn_mkclean_range() and mapping_wrprotect_range().

pfn_mkclean_range() is only used by fs/dax.c

At least the caller immediately does a

	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);

Afterwards where, apparently, a page for the PFN exists? :)


mapping_wrprotect_range() is only used by drivers/video/fbdev/core/fb_defio.c

fb_deferred_io_work() just calls page_to_pfn(page). Huh?

Best to explore the history what's going on there.


My best guess is that they don't want to modify page state. But that can
be expressed by the helper functions and doesn't require us to have such
a weird implementation.

> 
>>
>>
>> * DEFINE_FOLIO_VMA_WALK() users obviously receive a folio.
>> * mm/migrate_device.c just abuses page_vma_mapped_walk() to make
>>   set_pmd_migration_entry() work. But we have a folio.
>> * page_mapped_in_vma() has a page/folio.
>>
>> mapping_wrprotect_range_one() and pfn_mkclean_range() are the real
>> issues. They all end up calling page_vma_mkclean_one(), which does not
>> operate on pages/folios.
>>
>> Ideally, the odd pfn case would use it's own simplified infrastructure.
>>
>>
>> So, could we simply add a folio+page pointer in case we have one, and
>> use that one if set, leaving leaving the pfn unset?
>>
>> Then, the pfn would only be set for the
>> mapping_wrprotect_range_one/pfn_mkclean_range case. I don't think
>> device-private folios would ever have to mess with that.
>>
>>
>> Then, you just always have a folio+page and don't even have to worry
>> about the pfn?
> 
> That sounds reasonable to me. We were hesitant to add a page back to the
> interface given it had been removed previously but lets try implementing this to
> see what it looks like.

Thanks!

-- 
Cheers,

David

