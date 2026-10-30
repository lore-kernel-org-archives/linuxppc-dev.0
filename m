Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8E606A31E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=P+jtgdTX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGC6V5VPjz30RN;
	Fri, 30 Oct 2026 18:15:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793344514;
	cv=none; b=h0Sd+Zr7+k0sXvfPVcQK+KGb50DOUZ03qdT1eegUjM5s+K4dczbrNKovCjdyjglnNWmBZRq9a7w3XhEosERtCFYT72R5oYq5qwG7MVVpPRSRhchnRbmqSRV2XZxEbuAd/36o03L3D4hu9GBdtBQUIVTp5jtWzbv84vN4h4dAjZmLUs38Aiznn0LA/jjSCFK0YHBEuG8PE/ysqzHpygZ6R4L/p/AXJ3gy3hUrCdjwsY6lNz+BpgbD34ZJTScqfpwTjUBROCl+DZ8n8GWPJWp5/B1WvqepbQRqYt8I7DFYBafDUHftyJiuBEz+XERXnRBW2weHpHlnWUheiLLeHY8C8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793344514; c=relaxed/relaxed;
	bh=X2nwqEX6uVZ+D8u1+rxu1eIxt49K0H72sg6V9JucXvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnOKIHU1HAnmkLSOyhYYOKg5m8A76f8oA95hYl/ZUxx9AOZahljq1/1Ox3G52BcLGkEr2oGge5K2Wn4UdbmbWm/kJShhVIoEdvdDSwD1q5/0GjMf3ekGCvqH8L90UmgyVcn+zDM/pYW5oKzdYjMrDSCyfFt/nWJJuG+vGkrz1Qr0z3ABJX7TI7Ynnklr3D41hsODmRVVQWgBRQlIGNbR3FXQgosxbwTD4MmRp9PC/wHcAV7GzFEH7HhORWDwe9SC53eOEufSStSgcVGX7egv4/vLjfF9HhU5m/Vpo+va3Ue850UpWs7AYgAw5s5zC1HV8k0enFEQraGy12a4VU00EQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=P+jtgdTX; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=P+jtgdTX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGC6R4qcBz30C6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 18:15:09 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1101615A1;
	Fri, 30 Oct 2026 00:14:33 -0700 (PDT)
Received: from [10.163.152.232] (unknown [10.163.152.232])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D0273F7B4;
	Fri, 30 Oct 2026 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793344476; bh=Jp/eodRxYkJLNGQk8olzS9xG6qObIMTBg1q6BMVZmBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P+jtgdTX69sEy90NVnhYUwff1Df/OdYgDe+/Oll2oU0iv4SgMtAerOkfvpkn4fqBX
	 bHrTkw2g7dShto71IFHPDpjzFhRFcDPHxQhkGP7LbYYciMVEjNypabXr9lGoDG0b9P
	 Dl6AC3L9oAHxYeXPdZCnniBAcCySVpa1QB2Dy4po=
Message-ID: <99f529e8-06f7-4a20-a60b-0330c5d3d91c@arm.com>
Date: Fri, 30 Oct 2026 12:44:26 +0530
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
Subject: Re: [PATCH v3 03/10] mm/vmalloc: clamp an unaligned range in
 vunmap_pte_range()
To: Hao Ge <hao.ge@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Uladzislau Rezki <urezki@gmail.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20261026080329.140244-1-hao.ge@linux.dev>
 <20261026080329.140244-4-hao.ge@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261026080329.140244-4-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 26/10/26 1:33 pm, Hao Ge wrote:
> commit a739e6b557af ("mm: vmalloc: WARN_ON if mapping size is not
> PAGE_SIZE aligned") made vmap_pte_range() warn and bail out when the
> size is not a multiple of PAGE_SIZE. That loop steps in page

Why are we checking the alignment so late into vmap_pte_range? Why not
simply do

if (!IS_ALIGNED(addr, PAGE_SIZE) || !IS_ALIGNED(end, PAGE_SIZE))
	return; (or return -EINVAL);

at the start of vmap_range_noflush and vunmap_range_noflush?


> multiples and stops only at addr == end; with an unaligned size addr
> never lands on end, so the loop cannot terminate and walks off the
> end of the page table.
> 
> vunmap_pte_range() has the same loop without any guard, so an
> unaligned range would clear PTEs past end without ever stopping,
> walking off the end of the page table.
> 
> Add the check there too. The range is clamped down to the last full
> page rather than dropped, and the loop is skipped when nothing is
> left, so a buggy caller still gets its PTEs cleared as far as they
> go.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 44e0eb32708f..7131f60d1a8e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -393,6 +393,11 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	pte_t ptent;
>  	unsigned long size = PAGE_SIZE;
>  
> +	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
> +		end = addr + PAGE_ALIGN_DOWN(end - addr);
> +	if (end == addr)
> +		return;
> +
>  	pte = pte_offset_kernel(pmd, addr);
>  	lazy_mmu_mode_enable();
>  


