Return-Path: <linuxppc-dev+bounces-22270-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0B3CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:17:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYwdS6KRTz2yS4;
	Tue, 09 Jun 2026 01:17:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::631" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780931852;
	cv=pass; b=Hd1sN+/+q2OR+V3KecImkTLA+PbOjX/YLiB8JOxpZsFwpDSxsZHHF+TAVmEZ4v2oH5afacWgedu8Pv76G9CbyrTOsmu9dCsIZ636xmy9cC4ezhWLrPwaCwjBLgWNpaGtUnR2ZnkeaJ56Mqm+X8jJtDKx8WKElGXHsdVaRRqshp5VVfRN97/iUTVFFICLLH6w2Kc7fH9ZDLl6sTanh21BfoahjxugPglOijnJDdV8PlpRTJgiio64LPmwB25qH0JexFdjqUA8KrMPU67IDQawZP9HoB8Fy4e7qA5mKjq35WpIk98vSl32cTp+eA68uWzzl60FV98bWGO4kpyErWM30g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780931852; c=relaxed/relaxed;
	bh=yOZ7AW/TQxNVQJPSlsPWX5PMQzNffbEW+fgTz/Ammvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXBzIUG7gfHENI9QVcfAsQtepTG2WlawozYffQZHfdd8JDEsN3ixOyp7AZUPl4aCmcDrhJPQjBKy03x2whA1s4nc+DGOcBJi5YbTq4e8e6UmNi9eV734wiclwCTR7PLLdPbyTOTy3unqBZNX/N8HwLOeYG+vN6f0vRmsVUO7sAHY4lCSopPB2vbiLF3Rx2hzbsE0pGWHzkYzWaQog8EAw46+Jmxp/tcDi5nL7pgxYHAjYTYcTcCpAR18kEm0TYrxEwu6xxOxSYSPKDfVSsr5CEVtoM74KMcFTn/4g/OIKwfuUAqsE30WQKy+Zcb7nLcsb6KKRh8qfjr8jpWtBUDDqg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pVbAo7aT; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=sumit.semwal@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pVbAo7aT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=sumit.semwal@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYwdR1nJnz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 01:17:29 +1000 (AEST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-bf0170c80f7so732158066b.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 08:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780931847; cv=none;
        d=google.com; s=arc-20240605;
        b=k8wYwlXrZZRbA5tvRg7XZqtn9x5f0h/H3ZcrYL0fbVQ9N+mt91ZqgpU8EzqJ75JKCh
         iHmUNLIc3mwRKfVtndUgBLy2IVAgYgZBjXYOpOtXDKIlhl399m7jBIMbphhNKjTbkYCE
         MofNUp9UXC3z2u+bAa0K73BpNHnLmrbxpT+QzwSpBhK3aTBLMG4YfyGQNmKgv7FmoS7g
         jTZJpWYKYBKc8bZJNbkwfnExFcvsDsLNyC8Z2LfCZBBSKKl3V3USdO+m/Vcpw1nrisVl
         Hbmv3KJMDjhpWfuUtikTYc3tw1vXL1cN2Wi9R80aEG1lkdU+HDX0fs99nRpujWwnmejP
         uvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yOZ7AW/TQxNVQJPSlsPWX5PMQzNffbEW+fgTz/Ammvw=;
        fh=fZrWn1q5df4/gJCHNU9Qs8ifunqjnPJ6bku4hi+D4VU=;
        b=TdCujs/d/7DF2ueS5YJdjg5HoH1cIgyDxVVYczI8m9mIjZCMChhYwQSqJEFd4vanV/
         szg5OupiK5QkPuv+/Y7QmkJvy+DS0LoOS/8LfoutbewVaUzUp+i2eZAn7TI7iYWxJ7Zb
         WWOq8GjjrlaTHHCcNW3if0Q02eOAdQk8BhOhUK4PIel/RcDZwUEdU2ovFmC1FdZ6edJ4
         SVQb0gVbprjArkQ16HssEXnZx1Wn15bKWeepWaulXm7q/Hbbq8GSO9u/Pq+omaxKdC9E
         wTlKScDCtzWYsATEc9zBd3/iM3dtDikOO4XdZjPcKiYTUYpJ0FPGTisHyHpakAop8xK3
         /oLg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780931847; x=1781536647; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yOZ7AW/TQxNVQJPSlsPWX5PMQzNffbEW+fgTz/Ammvw=;
        b=pVbAo7aTPtsGbjQfuhFVcr3+lCg1Hom0vdpaDN70VK2IRwlCHut2OnMIkh/NQBQyiC
         MtYy4t/VFN//VmA88cp50XoLvL+H27X38wEvhoDIcNuetQazPYxmPs/ofFDoy47Ta8OC
         pOdAz+ap8lLbHqqFsk/Bwq7zcDzbBUBq+tClh5jjY4L9L93Cq6mCphdGqzd1pP/MQIxC
         TQPo/TfVbnvmIUEwYSy03PqTJa6njnoAzwmPxgoPtKcS6BqDMnqGHL9xCew8g903OyBR
         XAlKOscFsywqCYVjr+ZPZacZyaOJWIreh3CjHBrI+I2K2rhTN6++r+4FigMEFo8WtUtj
         zVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931847; x=1781536647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOZ7AW/TQxNVQJPSlsPWX5PMQzNffbEW+fgTz/Ammvw=;
        b=eL1Wy+pHqPVdeBa2WW0//e8roEM7rjnzqupMltpnafA+RRF0FLdYJ09Y0Qrdvd0fq/
         u4zonI90FAQOuPDhOGPrLce1KOvNYZ/SSQCiL+OkpTOpgcoNMpo7oABzXY7qFEiMnMiV
         vIWS0NrUw2NP1hBS6XFv/q5HztNSyYgdQwxldhsdQdSHMqJFUVBf6yJZsTLwm0FBeA+8
         bdK+9O+Rz2NpSILUPhRAFYOk3wzoi1VQvbbhFQlet76N+7jtlho8wGVNwrToy4ZMcZog
         5QL2fm3QWkZxdB66DTYl7X8qh2OLGCblhn20hqXio9tqswM5S/fcC7PCYYQPrNJL6NP2
         9M3w==
X-Forwarded-Encrypted: i=1; AFNElJ9n/ASn98eEp3c1kutTWGT2YjdoJ5tOA2hn5ZS90z6TFEZBJ6uQMOyCtybWAa3EvJ6FNT+gn5wyWkPKdY4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxjbq/ie1RUKNRfi+p8R38CGSLjCTSXqFxMWqWOBaSpWyMIZKWw
	lWKiGlvvrAgewLukytgiT/4sTp7/l6FpyRLY4jf2Z4Lw9BXO33X89CuKVet2c4VgAoF46bugq9s
	X5m8wN0Maf0HVbCZo9x45NFXTyEY3CqJDkI5SjyLs+g==
X-Gm-Gg: Acq92OFxKd3cb/5Euw6A/PeeETmWQV09iokI3ey0JD31NvCX3cpPbir21VNAAOnARzY
	0LeWIPE+7o2+Ucl/GpQ/JkV8AZf+2BFKpR3n2b9WFZX5bDHql0ilEx0hZ3buG/orJEcj50j429a
	Ogycf1PRU91211Y8WWDvqXl9AezmCXBC3uCbCi2bL+9Oq2+iUqIEIYGm38aIGqNMX4YqgnRKrSW
	TgyYfYzaPLweB9qDQApZMagvl6VZa/CAIYiDZoA0K7K87hpVTp8JT29eZ5ncK1j5fUivY6BnIhv
	iJQTdQpgpHDcE+diY6d2ejF77lVbtNEgz1Bbns7Rb2R742Sf7YwnO9hYASc=
X-Received: by 2002:a17:907:c22:b0:bec:d077:c4e1 with SMTP id
 a640c23a62f3a-bf373ff1dbdmr731904466b.47.1780931846675; Mon, 08 Jun 2026
 08:17:26 -0700 (PDT)
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
References: <20260522225853.878411-1-tjmercier@google.com> <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca> <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com> <20260604135712.GV2487554@ziepe.ca>
In-Reply-To: <20260604135712.GV2487554@ziepe.ca>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Mon, 8 Jun 2026 20:47:15 +0530
X-Gm-Features: AVVi8CdcrMng9NlewA5irjsXERkw9Ix0pSFdV0gf1_HiahCuxCNItaDbqkFH3sQ
Message-ID: <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and set_memory_decrypted
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Christoph Hellwig <hch@infradead.org>, "T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-mm@kvack.org, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, 
	Dan Williams <djbw@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, 
	Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

On Thu, 4 Jun 2026 at 19:27, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:
>
> > Given that Christoph's objection is not really about the modules part,
> > but that the set_memory_{encrypted,decrypted} should not be used here,
> > one option is to revert 78b30c50a7ac until that issue is sorted out?
>
> Please no, we have stuff already using this so it would be a
> functional regression. Revert making heaps into a module since that
> doesn't have a functional regression.

Thanks for your comments.

To me, it looks like while system and system_cc_shared heaps share a
lot of code, their user bases have different needs. It's apparent that
system_cc_heap users don't care about it being a module while system
heap users would very much like so.

I also discussed this with Arnd, and he suggested we could rearrange
the code so that system_heap_cc_shared_priv depends on a new Kconfig
symbol like

config DMABUF_HEAPS_CC_SYSTEM
        bool "DMA-BUF System Heap for memory encryption"
        depends on ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=y

This allows building both into the kernel or leave encryption choice
up to the consumers of the system heap.

If this is agreeable to everyone, I can post Arnd's patch.

>
> Jason


Best,
Sumit.

