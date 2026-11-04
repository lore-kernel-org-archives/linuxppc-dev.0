Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20696082BC0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D1NitnrY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKlsR2Tj2z2y8W;
	Thu, 05 Nov 2026 13:01:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793833771;
	cv=none; b=QuqYrsd/v0I76EJto1pq3Ys8WWaChqBYj/TbIE0vU5+jP8BjnOE5gErIO4q5djeQW7l6UIjZhBquQQ4zMyrFS0e6eHuCN64/lFHV6QtH/7jb9hBZuwO+K8fu9ah+p8XAruJh2yvaAKr++nToF8M7owA34ChRZRVBUlrJC/p9m9VqbhR67/fuBLSxZ+YMAL3Q/eHdzgAbQ+27SnfQTUr6nweByAaMGQs728Ux9ZwMZ7k785AJntiSzfT2Xf+bngNbQo5AeBwi092v6MJwWkhHh+PQb/npdJCsa1UbMCYT6VfKwRGXxJreffuxSbZjTb2MwWXrFhXnUkMI+GFj1cka4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793833771; c=relaxed/relaxed;
	bh=QJ44xLdhQI1uBh7xxp/N2gaMNtMNeyLEDRfUNR/7E78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzeCUFnv/PxcVUTWQiq0b7Qvj5JIIBUOR8COihTnqULLLeVUmy4mdESuSPiNBWFflR1daf4JvDAUAx1XXCP0OnLw9yXp8Stlvb0srDvXkckAcpMUs6ylVoKe8GS/liu5rVV46Qdqg7lGgSBVdqWxhbo98exZ7HapjyBwd9FaIUR63gvkQ37S/Qb+vXNFSZVzAsEL/1PQ4r9CSvU/psv+bl0CRkl8r97pxBqqdgD2C18CoA/WMo1/ymZybjEHlxVCuMtw7sczLKdd3Jrd7T268/eMUo+hHp5a7rtBzBK0kBSxiHcp2P964SR6PHuJqLiVKFKeaCONTlzUfzb8gEquQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D1NitnrY; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=azpijr@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D1NitnrY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=azpijr@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKh3F6gDdz2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 10:09:29 +1100 (AEDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso8607265e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 15:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833766; x=1794438566; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJ44xLdhQI1uBh7xxp/N2gaMNtMNeyLEDRfUNR/7E78=;
        b=D1NitnrY0ilnBo24e+cYRRSKYlyYqHrL4XtRAbsijdRr+Xivv3YEp5uf0PMZb5agp1
         jNRHm/M/SrXVJlLXad+7BSI776HWP4zl7pwDg9ZBr6RqQQM54TBX6PSr+bWEBv9x2gZ5
         bVOFCB3KWH9ov7zQX/6qwktssYOD/ma6KLyeK5A36U4UydPf2yDYrtbNHBN1CjcDpqGL
         Y67t/XKAsWuK11rvZaAruW83GSjwfiC4PyNHw4o2JPdn13lXsLps74rcAhNUudIqCz0i
         vEnMuwtujX8eJuqqkCogFaVCbxUt7q7lpdI7LfL7ZxkD0Qlm37yhS1wrWtj14RDhlaTm
         iC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833766; x=1794438566;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJ44xLdhQI1uBh7xxp/N2gaMNtMNeyLEDRfUNR/7E78=;
        b=jpOZfG+CiOmJ1tHr/hy9q9QOJL91KAHOXc03kyhcq9Uy3EZlG5z3B9BVh5R82POJsP
         YWfYW/LcLB4AYv+KGpwR9Tt1Qu1ejhFO/NNI5C2nwJaIoB1dQQdo4/LxrCVUWJYDBDAq
         2W80ncyGL+gHatICQJbvel6VwqOLGQxOPHqZ3vlYGvq8bHZRG/jwyBDcuqXeMDkaIQch
         hAofbDQT+WFBzAT9gwvCk5nQq1pGYvioS5KqntjXHvr9ZMBkdQM34HmRXxtpTBWWCxxD
         fLVpvhiIBERO/adAKyH/qWc4KyoBh9cRAFQHR+uOYiUhOrfwvDFKxw74JEsAF2+2w2MK
         63eA==
X-Forwarded-Encrypted: i=1; AKwUvByZXIxQHCYrxoQz4YEJS4V6JctO1yQiPotdb0Ca/TrSlAVstKFx94w8jOrTx9TBIOMdtEq8xRVBwVHXYnU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8jY3HjnLsxuHc7oxXHTaUcSFjM7JUIiUwSa+vU4E1RoVxA/Rq1
	jxZLGnobJGw+JbsY/y50utU7TJYIJ2dVMcJOJck6pQnKMKmD4CIH1yGk
X-Gm-Gg: AYBFou1cBAHpPoXh83qNvN8NY5PapatMYfg/0/HMAthHBIEfBhjVAJkOTm/Anlo3QmC
	PTlhJtVMEBfBNHW9nppF4T9sVxM8xbmvOyAYI/C6DUL55BRbeqtTlPCDWII287HLLADqlZOWite
	6mC+FlScyvBjdsZDcQFTezvpDtUD5mbkyxrb8Stbml8X0Sj2ejfrfv2BOkCAoz1yKqTr1wDxjby
	/LGjrzHiZntkeJUln+b5PqOLakX6IqtJ5mJ4yQfxjUYaen94jdh1yQZ7L73ewDUqFyB56cM+ISs
	+NDQRgyoI1tkHEuWKjrD4yKuHRkkr3qJvTVCYb0uSDLDdCdYKjibALMlSKU8pcHK4sOZWosdIWR
	m43rtcWMbOpg56T4CEmqMH92BZbaMeLgIdqD0sT7Joe5PxhiM0xbU7Ugv9rS1J1uqsTpDjiDP18
	PojFTb6H+6A2RFNgYyGkhsWAa2aM69HJBk5iocj6+has95XDm+7u+KbRruEQIWW5yiCLvNBrUI/
	/Z6hTeXVrkEw9prx3A83kq69DDVDFBFwMzm63meORDwwVQm8S8ydCKYLxHKSRKP1taoJXYYc+nN
	iPg4P8qxF+brTbz7Fp3vAsY=
X-Received: by 2002:a05:600c:3b88:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4ac187a6ffcmr414345865e9.29.1793833766131;
        Wed, 04 Nov 2026 15:09:26 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae73csm18115315e9.1.2026.11.04.15.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:09:25 -0800 (PST)
Message-ID: <a9ed4146-691d-4a35-9b82-e60329688277@gmail.com>
Date: Thu, 5 Nov 2026 00:09:22 +0100
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
Subject: Re: [PATCH v5 3/4] mm/huge_memory: read a special PMD under the lock
 in copy_huge_pmd()
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 9:40 PM, Konstantin Khorenko wrote:
> copy_huge_pmd() reads a special PMD without the page table lock and
> copies that value to the child. The mmap write lock held by fork does
> not stop unmap_mapping_range(): it zaps under i_mmap_rwsem and the PMD
> lock.
> 
> The zap visits the parent VMA before the child's, as dup_mmap() links
> the child right after the parent in i_mmap. If it clears the parent PMD
> after fork has read it, and passes the child before fork copies it, the
> child keeps a mapping the driver has revoked, for example:
> 
> - vfio-pci: the child reaches the BAR after the device memory was
>   disabled or the device was reset, instead of getting SIGBUS;
> - panthor: the child maps the pages of an evicted buffer object after
>   the driver has released them.
> 
> The same branch deposits no page table under the copy. ppc64 in hash
> mode keeps the hash slot array of every huge PMD in that table, so the
> child dereferences a NULL table on the first hash fault, in
> __hash_page_thp(), and on the zap, in hash__pmdp_huge_get_and_clear().
> 
> Take the locks first and let vm_normal_page_pmd() tell a PFN mapping
> from a folio under them, as copy_present_ptes() does with
> vm_normal_page(). The zap clears the parent PMD under the same lock, so
> either fork finds it none and skips it, or the copy is in place before
> the zap reaches the child.
> 
> The copy of a PFN mapping then goes through the same tail as a folio:
> 
> - it gets a page table where the architecture needs one;
> - in a shared mapping it is marked clean in the child, as a PTE is;
> - in a CoW mapping, which only VM_MIXEDMAP allows, both sides are write
>   protected instead of a warning being printed.
> 
> Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
> Fixes: d1503aa9ab80 ("powerpc/64s: Add support for huge pfnmaps")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a

