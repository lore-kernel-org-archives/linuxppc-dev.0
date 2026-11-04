Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72880606EE95
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OXvKcHvV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKlsN6Gd7z2xNC;
	Thu, 05 Nov 2026 13:01:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793833547;
	cv=none; b=ZilcU/G/ansbZTbOQiTpzFVIk8GF0q1uJO3cf8sxQtXmK2o/Yz3fgZ0edeY16X+TAB2c9fKKoSUTPwRdGjBglmYtN9IWHMDMjZu1C3sw7Gjbv0IT833051HSWRsQuD+7Aj5na12UtHKXpEwfScHCUqZQKYDwBhBNaGw5QsxEGqB3nr4IH/cYY1s5FU+UdlAq/GY/sN0KsHIsPts40EsD3ChIKLiF46hX8o1bYx8S3W0cGcSDe5OjzOxuqJ85Hbb0c4gJjBhFSjZwtAr/hijxvu0u9j4mAYqCtalDJI4Val1n0PKqxspK2mkt5exTuTguaFz3yJ8z1V5gA+gkHVBtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793833547; c=relaxed/relaxed;
	bh=MOpStKtlaMBvTw82l7hk12nLoKUsFYT90GYDj+kAndo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yuh4HJgdcJJiX+pnuy1/KLOybsg/23dXV4ig1yPWWelSVS6dmdF3M2dkIF1WkRiqC/GDLuNuL+/9iRnxIKwR8Z/Cnoptcbyi8cQby9PvJKLqVVz4u1okAzUs2BNKOnIXRNMP+xNesMUPrEo7k2B49KbySysxacdZJCc0LRjkdQ0Ma7GzEkKgtV7Ftr8IDE72p4QXmJc3Fbjd4Ml2bf8jhVplpdfMF8MWeiVochRvXUebrKmK8CqV9vsBlL5rGkXJzeaDwpq+AR7AlASQ9tmco0xfFYN9to+qhuHrqHErguE0kLB85do8InnJ8qJnA6ujbphH5OISsQGJHQ/kkHEigg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OXvKcHvV; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=azpijr@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OXvKcHvV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=azpijr@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKgyy4rhnz2xSR
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 10:05:45 +1100 (AEDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so12635455e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 15:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833542; x=1794438342; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MOpStKtlaMBvTw82l7hk12nLoKUsFYT90GYDj+kAndo=;
        b=OXvKcHvVc609LEe4cyDEW/pIw5QnM3OUEBukTjr/ED6mdY4qbgjQjMsDwXNmlgiWC6
         3yCmJ0Lr+R3f+GdA8JzqTQOK1ejN4dYy/VvQC5Zx/TzQbbkGXSMcaRBB9j0V1/5Nmq/t
         ay9pMKoiixAAPtx8ZlWYHiKZ27yOS0wFGMeIDqz8qLDyFzvNfxlIOhgEnos5zB8eYR+T
         TnI6PTDcjgFVnAvWuZ+vh6PUAu8C4gdxt3HnwHiTcRGHVhHLbmkRN0RnMF1ySfggTJrY
         bd3ruSCeEXfuoj0IWoYz25PWg9qACFMSr3e3Ohykg7iKbe5DfYJ0anvUkzT+h+D4KxSG
         8RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833542; x=1794438342;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MOpStKtlaMBvTw82l7hk12nLoKUsFYT90GYDj+kAndo=;
        b=TtKC6N9JbPAtn9qsengj0SF7dqFhKn/SbkOQqbMBGK27/+K3FzvW/cS/sMoC1hkqZJ
         aVMwfRrZzPTS/F63kYB1vPwK9QSgW2zqnHpbeGPTZVw1Wrt/uFZoxMN/3ewL1rpw8C2G
         nev2s8lG2O4jL5MF/xkP+DQv+wCgdDH7kyvbPHlgnHj128c2Ny41V7iWFfsxgdaUvKWu
         vQVrZAhfrSbquPqqjg2/shxEYqbUI8npzDDqDX3OMFyGSxl5SBAP0OkWzAZZgFjTtcm4
         Wej+OEEmrzNnUaZuEICXGBVGDdXOYY2JP8J/SP+NDA3eSSBc4Ae4MTZijc+KjzIa7XaV
         uFaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUVBkHABEyVo6AN1yVXfKOyEgZn1pQ53GtpphYhtJMjKVUWXjXBj9+NVFuzZLQAj8ikVC7qhhqycn06mk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/3FrRdFnvIbCdHYu47jETs9m70RdE7etoam0kcU47O+Tw6NToq
	eKVJT94JBIaX6kNjf8AlaQnx4zB5sbm+5DfNkDpqcdsLrwtxarrHgVST
X-Gm-Gg: AYBFou1fZeCA3aqpKTWZLChJs70FBZms/sJ2SDCiRZ6hTPzqreZ8JCSYDmAkNsik2qN
	X6N9f0nyBq4O/pPiBMpu0R0chhKJvx7iTmJlFeB7WJWrCxq34arCv6iI1uxyFNsugJcjVAq4Xai
	T3bMYaVDfbL2qBzORZfOBYsmz3pWOQq+VfLCehLTk+73fzqFDyQMJwfxvTO5ekFElk6mDNwS9A9
	xjelOUrWW/Jj9D18ko923XK3MUsroJC+3f0t/SRnwjjhy6nsJExsADXkFZ/220XlWXg0jQ2NPWw
	Uh90yWOqEeh5NSki29Mdox9JA44hvf21wy6UqsQ3ggLkk1dFYxHCYjaHlZsZ12wbO9Ih7Csu+Ix
	h9+LPrNswLTM+LTOEBvfHFGYeOwU/GNRTzyxNlJnmmfFwGTqCJsD+UdyKh/BulEv5Eb7i8MFN0D
	yqNRFWVoHELzF5/tvMDwplN7LLTLQddZ5jNLBqWXhXRv3hAiWn/SCjOVj8wbsC5x7M73VyGv3+U
	yqeWd3tJvMvYZ7fL5udMU//pVzqw64xXbecG0djNPqO0BXGp3Lr1KbpFYgFInDfyDhsoWq3q7js
	CWI/gKtSH/v/pucUuDBrofs=
X-Received: by 2002:a05:600c:19d1:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4ac1970b9f7mr379985715e9.34.1793833541916;
        Wed, 04 Nov 2026 15:05:41 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed5538basm5998977f8f.44.2026.11.04.15.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:05:40 -0800 (PST)
Message-ID: <853a133d-f332-47dc-b7f3-eb57f34d9344@gmail.com>
Date: Thu, 5 Nov 2026 00:05:38 +0100
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
Subject: Re: [PATCH v5 2/4] mm/huge_memory: copy file THPs at fork like
 copy_present_ptes() does
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
 stable@vger.kernel.org
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-2-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-2-c56d0d26f970@virtuozzo.com>
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
> This fixes no bug: it makes fork copy a PMD the way copy_present_ptes()
> copies a PTE. Until now copy_huge_pmd() skipped every folio PMD of a
> non-anonymous VMA and left the child to fault them in again, while the
> PTEs of the same VMA are copied.
> 
> Treat file folios as the PTE path does: take a reference, duplicate the
> rmap and account them. fork then pays a reference and an rmap update
> per PMD, and saves the child a fault per PMD it touches. The next patch
> sends PFN mappings through the same tail.
> 
> That covers the VMAs vma_needs_copy() sends here:
> 
> - private file mappings with an anon_vma;
> - VM_COPY_ON_FORK ones: uffd-wp and uffd-rwp, VM_MIXEDMAP, and
>   VM_MAYBE_GUARD, which shared shmem, file and DAX mappings get from a
>   guard region.
> 
> The DAX huge zero PMD is copied too, with a reference taken by
> mm_get_huge_zero_folio() as for anonymous VMAs. A migration entry of a
> file folio is copied and accounted like copy_nonpresent_pte() does, and
> made read-only in both processes only in a CoW mapping. A device
> private entry gets the same CoW check, as in copy_nonpresent_pte().
> 
> The copy then gets the same tail as __copy_present_ptes(): write
> protect both sides in a CoW mapping, mark the child's copy clean in a
> shared one, and drop the uffd-wp bit where the child is not armed. An
> anonymous THP is now write protected only when its PMD is writable, as
> a PTE is.
> 
> A page table is deposited under the copy where the fault paths deposit
> one: in anonymous VMAs, and wherever the architecture needs one.
> 
> Cc: stable@vger.kernel.org # needed by the next patch
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a

