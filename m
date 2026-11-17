Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15220606A333
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dtQ3W2NP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTDkQ2Cy9z2xqL;
	Tue, 17 Nov 2026 17:06:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794895566;
	cv=none; b=mFCVrcDWXznyjbFzqYf9yN22hHiyVU9i8AE2MyW8hpN+dcJEfdmppDG0t0I5xH1sXqPrNjFW+YDzPSOkrOWU/4oDM44mZqlSf5pzryKGjP4W7FINM63iXyN0qkkQctbNWoFqkgFpsGv7/QD3jx/cUg30QAJQxBDSUeYBJc1PYpcCflzfTHdx9XiX/ozDAsVgNiV0b3qBYbN/qQU6KB+lcvbfhBhDAnVqlpJFWSiaNvvdjsDxrufljee3WPkrQJ3jvLloPY6Kop0BG/t0KG7XUfeWdj3OCXsN0D1ajfgaSn/8J5wQCV1+lklofm/kOtffvipF+f/lYS79niFK4cCJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794895566; c=relaxed/relaxed;
	bh=5KFUwb7S38PDGJnYKL636C5VeONl95jXTsgqB82LNu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUZHLqahdaKDYBvlPH3QwFmhNow0xirAxWyV2SS7WkHQ81g9msksrkCW1VYLe/0orELk7VhdTst3ppfdEYJYPKwLgx4WLQByMu/zditAMEs/KJxPJIPWK2pMtuM0+HL62SjwXfjqfJS19TROIai3s/ZTYpdIXz+To3Hxy0WgfmfyoxUhwubi55QS23479aQPG6dUDxtdB4Ykh2SusVt04+Zirq6cMCt9alz5C3CxDsZX259aCuj91ARoEVkishwP0i2FVXKi4E/+q/Bxe1aTxFG7da3XHqYJQT1YrQWheIlrXLTpuc5KWmm6hEwau3oVC5R0CTxOvvPM0hmXAv6suA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dtQ3W2NP; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dtQ3W2NP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTDkP5DV3z2xly
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 17:06:05 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FA551682;
	Mon, 16 Nov 2026 22:05:31 -0800 (PST)
Received: from [10.163.156.60] (unknown [10.163.156.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 949E13F763;
	Mon, 16 Nov 2026 22:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794895534; bh=9u1GHEq8hMnaJQY05Ky1xgqDtbgYPoZC4iyaip7LWL0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dtQ3W2NP24PUe63hKoX4bbI8JEiTSsSWWQu9D7DyMy/pHZNUmqrIFmfAnGaZ8kXON
	 89dH4GviqDm13Qaqsx+/h2/y6OdcvX3TjsDcl8TDib3gTh9PbrGtda/fRVDobnGWO/
	 /vF0mbRpZFiOxKGkNycP1YCeYW4+Xb8SRDAd2Wqw=
Message-ID: <4c233641-15ad-4e5a-a106-423bc31f357c@arm.com>
Date: Tue, 17 Nov 2026 11:35:24 +0530
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
Subject: Re: [PATCH v5 04/11] mm/vmalloc: reject an unaligned range in
 __vunmap_range_noflush()
To: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-5-hao.ge@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261116071325.263682-5-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 16/11/26 12:43 pm, Hao Ge wrote:
> The PTE loop stops only at addr == end. An unaligned end is never
> reached, so the loop keeps clearing past the range. An unaligned
> start clears the page below the range first. Both are caller bugs,
> and the damage is hard to attribute afterwards.
> 
> vmap only installs page aligned mappings, so an unaligned unmap
> request is never a legitimate teardown. Warn and bail out at the
> entry of __vunmap_range_noflush(), before any PTE is cleared.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-178439@kernel.org/
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a168f6f20f4f..e2b63cb1592b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -523,6 +523,9 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end,
>  	pgtbl_mod_mask mask = 0;
>  
>  	BUG_ON(addr >= end);

Nit: It is usually a practice to change the existing BUG_ON's to
WARN_ON's too, if you are changing around that part.


> +	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end)))
> +		return;

Reviewed-by: Dev Jain <dev.jain@arm.com>

> +
>  	pgd = pgd_offset_k(addr);
>  	do {
>  		next = pgd_addr_end(addr, end);


