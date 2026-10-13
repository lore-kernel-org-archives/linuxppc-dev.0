Return-Path: <linuxppc-dev+bounces-29359-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB278CA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 11:24:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3sRP1jDQz3brc;
	Tue, 13 Oct 2026 22:24:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791890641;
	cv=pass; b=n+tMEqTvsdWK4cN0zHwBRtjJtJELij4HXtcbXZPUSxR2Md1x2ph6osHOOWZo3Lj0Nzl2t3lgNmxZFbhzyJZVBVokMNwNgJqzfCUlEjfJKUWxsFLF2ieQfm0YuypZA/FSFat2vNLu0sBt8xs6KMzQJXuA+O+cIk7A0/hbheLymgUXA1ASjQt8VM0bkxJUtN0u6Pquh8eaU41hDX3YtzokUx+jIAJclHFC0XY1MgssVPRp3/+gwIJk4tT2hHblIjh/urjimv4qMBpB5CgxrHtFUXDni8hEU2anI0exQ5ySiZyDLqSj+zLTppi95oTGU1FRzImcXMQ7AXIvHNArd9ospQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791890641; c=relaxed/relaxed;
	bh=Xzn08Xsc7kDwJ9WnURk+AQXsKYZTAAr7RKZN9XHYFSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxqR7tGxSIb83D2gOvtAWwVh2Ia9bAWPSTnkAx08OtfWn5lfDMTguCT45bAs8Cqjln7JGUQDTNf2445k+PUNOeT8V6m487o2/zjUSIpRmbnVoOppKNmrgBb7krPrtESCWa9T7KJxZAXIgCg+3A0hNc3wwBcanx6VcdTS2NbDFQd+qusTsZn7pf4Mkip6OVXTUjGvU57ALALPqTCzhkOXJwR8e63DQPykuSM8BOWB9/PRVr/HvXkwhiTn3BHdx6QimkcRVLP4u20fFXtyQCU5jS39K1y1ua4Tv+bEoY/qTit/qGGJWtW49B3Ifs27kw6nZIEpw1n0uhuiD2i6f/OkkA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oDfnVENq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oDfnVENq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3sRN27rgz3br2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 22:23:59 +1100 (AEDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-5337c7b9937so707311cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 04:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791890637; cv=none;
        d=google.com; s=arc-20260327;
        b=oPvW+ARd+d44RqaRDCDUVXmJf5BxLVHU2+T0Ghyw4omWJktO+l6+2V60lDSIx/pcKm
         zpvZAcn3hcaS+FMHbw2gjMZDyae6oz2ChFjV6lrsRYYLFDysZ1JB5RkjgX1YACiRMUuO
         VN0/qh4eidIoGJ6PPXuxu24uuc3IIwHpaD/ikse81OWYLqKfck2/2jBPBoXZxlC9yq64
         R4kHsctreEPHqkF41UPduSfMD6J29oGAfHJ8PGqQxdxiicaiHVf4wUYaZv7BFQ9SVB95
         DYvD7hdWLTukan/XEQ6AfS6S6CONXb0hh2ulmmyvHulNYdPE9irGwYbjOI9lXyVIuOqf
         xF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xzn08Xsc7kDwJ9WnURk+AQXsKYZTAAr7RKZN9XHYFSg=;
        fh=7j6/sfcy8N2/FIhJWsrr4+xANs5py1OdAbnLBQx9PI0=;
        b=l+UixcxddCiP3+lWIAUv33br9U1nAQi0lFxiQ7/qXtWfBcDoXMXVifCfZQuP93OnSB
         X7dZbtAP4MNvGcATcLfZMFjbWbiNbsPeM5LWszTxpL9k9nyskxXPzsZSJUB14kbIKFE4
         2WL6ZZd8/3YMVIHRrIcoPASLZKlX8OFY0UT2tGusfb+eT6YzvTKjP5LqwgnqfjzBdM1o
         rX1myCuClJpJ21XrZ/jN1jsRV0MWLQHGfWltpiyO4octKMgVejcafc50eMhu/7WxDJGk
         O/X+/1/TSMD4FjGMk79mpeafxCc7U4obqxZUbW6+XT2Op2gmmOfvCzDosv1o/LCTEwQC
         pHwg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791890637; x=1792495437; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xzn08Xsc7kDwJ9WnURk+AQXsKYZTAAr7RKZN9XHYFSg=;
        b=oDfnVENqqDWv49fk0ijJDfSzMIEwRMc4cPF1X8jwT/N4O7zfaZN0t2w2zmrvqoiHor
         RwyTsGoHvyEHay+pLEe0DzmEk0+koxv46da9NKDiYnLaZ9l75fxSlnD0ztJj7pd0NgJ4
         hJZUDV+fFWjfoyxaT0yQzg1vkmPavjqPQUEvq9GAWECAjkmh6EiSB5wrVvM9jvYTfVKd
         PGIq2MgGFXIk9yBzOl72qdCXYCWSIdhajzmQLqv3EZosyKtxjyXPkJHMbMOFDL+vRDnZ
         W8qJBOX3AvTFIkdmpIfHvKVh4s0QWVO4stEU9xejRdiB5jOyR1gcgNORlpNSZMWDqFrN
         Nz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791890637; x=1792495437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xzn08Xsc7kDwJ9WnURk+AQXsKYZTAAr7RKZN9XHYFSg=;
        b=sqoe2SE3rVgRnAef1bHCGnGOBlZ+dpIYsFLhaS73GkbXfGz48GfUVT9+eZY5Kb4uFU
         Dx7pKs3gqVj28t5NjMgJRGO3wWnHGN97jY36PMjjiXyFqa0Q4eFw308h/z/CC4b+nB6h
         LB0x9b4BRNgcGi171j3jmZYWZxO9Z6UHSqf2j2Fnb8hmEWcOY/KksMr70XU8YyFWRvw8
         mvi6Xzu4dEgX2g0pE2ZltWMuiZ+b+8DwzdNm+IWQWBfFZviDxvLd0lyiouM8jpNGE1r6
         zZmrREX+62Q8+a7Q1+Fc3KN7So4h5Wy+pCH1//zqatCN5tIvNblmS3w6eQIB0zDCfMCV
         H1Yg==
X-Forwarded-Encrypted: i=1; AKwUvBy5C1wncNJak+NUQ1uMGiRzR0aiphz7o+W157xvid544Q9EWdH0evfnui+CX2QF+My/m2U2fod3qihSIFo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIOLEIzADvORf3Q4G1aZpJvTUdfcWFhdP5heVOoy2nOKw3yn7BF
	DzpjCVAV9BVBmhuZ+6H5bj53e+mYJAq2BNSiTrZRK/cvqK3SxZ5CNKR0u0WZIxF8ykp+OH774fB
	SO/gM8lmG3OUE4HdOG6bkMhtsu4CCYAFcgC7lKunF
X-Gm-Gg: AYBFou22QjnQ+/thTYB+wQZhXud03bC1KP8wywBl3adv+CLlNHiBgSnmqRt0OYqWpC6
	MHNm1SwfsymGVKWT0Z8hHv45MKYr0R7PjO73G5Ng3LBJo79w9ghxw3fZzSeWkaadBd/EO42LAfE
	pikrpaImY3R6q8L+ln/1gh4drhpWj7tU3pa40oqnpn/nHHJ62ul3x7/4yhJ9MFPIdmLvcjWwKiO
	766eZ/IIBi9cgGKC1+YhrP1BMSswgLZXXrqSCbN+Z8Q7omd1OfsmChUyu7Qi25Ff3HnO0wsFI/Z
	osOVMi7Q9vfVGejlTmJT7Lpw35m/L8nnfXU8r0dY6nVYnXFTUavcMYlO6wN10jeX3/o=
X-Received: by 2002:ac8:6105:0:b0:531:475:4ce6 with SMTP id
 d75a77b69052e-535b4ed04b3mr47467571cf.9.1791890636806; Tue, 13 Oct 2026
 04:23:56 -0700 (PDT)
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
References: <20261009063619.112313-1-hao.ge@linux.dev> <20261009063619.112313-4-hao.ge@linux.dev>
In-Reply-To: <20261009063619.112313-4-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Oct 2026 15:23:41 +0400
X-Gm-Features: AclHuK-h0QSYINdnd37OoLMuJ9wy9b_aLEO1B1JVU8ue7bvUVrVwE_vPxVcZz8s
Message-ID: <CAJuCfpHjX+_AvwgqV3XB_QQuorvnegvd_YjQ85JZWfSk-ckUHA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] powerpc: drop redundant unmaps of failed vmap mappings
To: Hao Ge <hao.ge@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Uladzislau Rezki <urezki@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 10:36=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> vmap_page_range() and ioremap_page_range() clear the PTEs they
> installed when they fail, so the vunmap_range() in remap_isa_base()
> and ioremap_phb() has nothing left to remove.
>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  arch/powerpc/kernel/isa-bridge.c | 5 ++---
>  arch/powerpc/kernel/pci_64.c     | 4 +---
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-b=
ridge.c
> index 5c064485197a..93029d85e6ea 100644
> --- a/arch/powerpc/kernel/isa-bridge.c
> +++ b/arch/powerpc/kernel/isa-bridge.c
> @@ -46,9 +46,8 @@ static void remap_isa_base(phys_addr_t pa, unsigned lon=
g size)
>         WARN_ON_ONCE(size & ~PAGE_MASK);
>
>         if (slab_is_available()) {
> -               if (vmap_page_range(ISA_IO_BASE, ISA_IO_BASE + size, pa,
> -                                   pgprot_noncached(PAGE_KERNEL)))
> -                       vunmap_range(ISA_IO_BASE, ISA_IO_BASE + size);
> +               vmap_page_range(ISA_IO_BASE, ISA_IO_BASE + size, pa,
> +                               pgprot_noncached(PAGE_KERNEL));
>         } else {
>                 early_ioremap_range(ISA_IO_BASE, pa, size,
>                                 pgprot_noncached(PAGE_KERNEL));
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index e27342ef128b..f74269636d5e 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -139,10 +139,8 @@ void __iomem *ioremap_phb(phys_addr_t paddr, unsigne=
d long size)
>
>         addr =3D (unsigned long)area->addr;
>         if (ioremap_page_range(addr, addr + size, paddr,
> -                       pgprot_noncached(PAGE_KERNEL))) {
> -               vunmap_range(addr, addr + size);
> +                       pgprot_noncached(PAGE_KERNEL)))
>                 return NULL;
> -       }
>
>         return (void __iomem *)addr;
>  }
> --
> 2.25.1
>

