Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC7A606A324
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bbsz9qDk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDbYY2PBjz2y7p;
	Wed, 28 Oct 2026 03:29:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793118577;
	cv=none; b=h7GkKPQnmW6Osiltp13XwFhQDBR7OeaoYDeOROZBn0FwLbCeo1af9xJKNrXQNEwcTqX8pIeYMy3WX44QxumRIRm/59wrfiyOsNcfyG2D3GCnpGAAPsr1hfJGyvs0GehaKcXoxJc6j5dDnTCI115qSmvaZevorK/bY+g8dqossCKhpPYesJqi7xEHwIT3bjAg9Ng5Xetxx4h9r9ZOxTZFlupBtnoht7NZlj5nKDeGJVSPmBoDIwt3n+kevrTCqgsEJuzc77oQJ32M3n/EVWPc8cH9hQ4p+3/5FfA8oQr9uhplWQpYzFLUGqyVocB3mWWF+3CJK/rITI4y7Q41abjjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793118577; c=relaxed/relaxed;
	bh=kAcnFFHoGCaLIkdfu6vQlgxivqnlgRGe6B2VS1ojrEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiuOKrQRv8oYcma5oWLYQh0KmTPrHg4N0iCI6gFGMQprT3Uz+L0ffB/fx8tsMhM72ZhpJsnd0peDjgL8sdy63d88zYvof5gQlefrxnsNVY99k3IaxlXArrXUfOBRumNSoTHUYoo6KllsOEe0Lm4Xa/ZEKQvGI9pwE0/fTfzDerOFmc3wiGRtQEVxxJfv2V+z3GAQsbC/X2XQt/wcoOHT4MGZieUpQ/YDbbpvTz3l8jHK5K0zcbOKs2V5s/bXGiICJnCEBhKaoSXtsN5g+BjAPyUkAyJLTwxJiSWbQeOQ8N6MSLZFwUSmViaGlvpzn/AreE4ZwzumGFuFn5/aSsw/ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bbsz9qDk; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bbsz9qDk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDbYX3RG5z2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 03:29:36 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0E6824183F;
	Tue, 27 Oct 2026 16:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F061F01828;
	Tue, 27 Oct 2026 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118573;
	bh=kAcnFFHoGCaLIkdfu6vQlgxivqnlgRGe6B2VS1ojrEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bbsz9qDkyDs8H77dSEWFVVoSrMeEk+WXm5r3OPWiNyeYoBpxmsOCn5CmGtRqVetHo
	 mcFkRLPNplY4m3ig1H1ERqm+PaSGY5Qy91L8YocM14s/zdxHBU39CJJs+LR0NjqRUy
	 HYaZ+qVnsrkUB90AOxXitaTHRIDzbW2nZQKAt2axcvSGr90/Ecy4aiZxxfFFZPczPN
	 a6bkSOpR33GdMYXlejOZDAznosukKn1HJsw8fzq1fezE3Gnm3ptrKyXX0qKJZIsYvz
	 +AJX6Eljxg3TrZYEEkkyIT2+mZGLlRxnvv9SjcB2Q0e4+EvEqvROnMfyR4IutR6Tvb
	 hVXHbkO+pwc3A==
Date: Tue, 27 Oct 2026 16:29:21 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Barry Song <baohua@kernel.org>, Hongru Zhang <zhanghongru06@gmail.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	surenb@google.com, david@kernel.org, liam@infradead.org, mhocko@suse.com, 
	rppt@kernel.org, shakeel.butt@linux.dev, vbabka@kernel.org, zhaonanzhe@xiaomi.com, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	loongarch@lists.linux.dev, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, linux-s390@vger.kernel.org, dave.hansen@linux.intel.com, 
	luto@kernel.org, peterz@infradead.org, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	Hongru Zhang <zhanghongru@xiaomi.com>
Subject: Re: [PATCH v6] mm: retry page faults once under the per-VMA lock
Message-ID: <auDRAEofBdqZy36y@gremlin>
References: <20260911025613.1220845-1-zhanghongru@xiaomi.com>
 <arFYRAa-i7CIwmHL@gremlin>
 <arF-E3Nsw9ZliH0t@casper.infradead.org>
 <arI_w2wTfA00Mgy9@gremlin>
 <armexcXDiG8ryZd6@casper.infradead.org>
 <CAGsJ_4xuFi7K+crAcFQ998SxXS0xPM6QeA34JV+6+Sy005rXLg@mail.gmail.com>
 <ar7MsOb6IJLt4eLo@casper.infradead.org>
 <ar-o1TrOMGrrcxLX@gremlin>
 <ataDTEZIKOYtwhUF@casper.infradead.org>
 <auDGPs8jzC-90-_y@gremlin>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auDGPs8jzC-90-_y@gremlin>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 04:26:39PM +0000, Lorenzo Stoakes (ARM) wrote:
>
> Thread A (Parent)          | Thread B (Parent)       | Thread C (Parent)
> ---------------------------|-------------------------|----------------------
> < Fork >                   |                         | < has TLB entry >
> copy_present_ptes()        | < no TLB entry >        |
>   wrprotect parent page X  |                         |
>   -> 2 mappings, refs      | *ptr = x                |
>                            | < Page fault >          |
>                            | do_wp_page()            |
>                            |   < shared, so CoW >    |
>                            |   wp_page_copy()        |
>                            |     copy X -> new pg N  |
>                            |                         | *ptr = x;
>                            |                         | [ OOPS! stale TLB,
>                            |                         |   lands in X not N ]
>                            |     ptep_clear_flush()  |
>                            |       < TLB flush >     |
>                            |     parent PTE -> N     |
>                            |     [ X now child-only ]|
>                            |                         | ASSERT(*ptr == x);
> flush_tlb_mm(oldmm)        |                         | // fails! N lacks x
>   < far too late >         |                         |
>

Sigh, I drew this entirely manually, then had the LLM overlords 'correct' it,
but it also made it less clear :).

Thread C ends up writing to what-becomes-the-child-page X, whereas the parent
ends up with page N after CoW.

So a thread in the parent writes to a page of ordinary memory and then it
disappears under them, and the child ends up with corruption in their page.

--
Cheers, Lorenzo

