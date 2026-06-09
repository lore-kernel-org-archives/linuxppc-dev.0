Return-Path: <linuxppc-dev+bounces-22318-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE45CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 11:44:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZRrf4dnMz2xk7;
	Tue, 09 Jun 2026 21:44:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781005442;
	cv=none; b=kKRJB52L6QyAoUQnMbwtJCrti6BcrN31FF6m+fReJ3qHY8wOb5FypBXw0QrEi5ctgT43suM5XmTNjH49l50yUabJYFXpepKUz/XpYyH+6rpdYrcI9go5I/vVYYM2y63PaLiH3D9Pp03QSti2lCabd+C8d3RaVPsRdF7D8409kFmOURF7BQ4nhixc50hvFjERao8Mpix5wWzMa6ush0MXCQR/4GsTfPP76Qt0TTDneoMS0BC1X+m5F0ZNrzT1NrXK9YfK/lbju6Qkt5NSJ+R9klo+ckc5kz11GstBse9FAu1gqtQeXW3GWbYLJ4nYnx7BtNt602O9kGP9saiSegtzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781005442; c=relaxed/relaxed;
	bh=h2j6CzARsoMyv7N0DLitThZjZq+4w2DpaYqL8Xb2hr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTlf8kU2jwU7bp71PLwfDd0Kyk5nap+WI6scQw8C4q31VwY+All7qEGzvz7gKGxgA1SUBZ8B73PtqaoZRy/gB+1FWYRDCkRjuwy/ebgIbl+Qww2P5k9IitexuZOF0Qt/CThxTTfK9JZ0shli6FE8ik5hco5XGLZi4IVFb3mpCWpfFCN+z7ToPb9R5+Sp3SDyUyZy3fAdLniItjAan9QsWGoiVGN/KJK3cr4eh2f7rYy5p0caKdFZnG1NBERbz1mqbwwHyW5LwyF1K1J0+0bam1uE/Bt608frUhb9pVyLt3mmR0OSayAHs1ktqslQUMJHNz8iQv9mJvqRJ9syMA/xhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=resnulli.us; dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=d20PHj6O; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=jiri@resnulli.us; receiver=lists.ozlabs.org) smtp.mailfrom=resnulli.us
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=d20PHj6O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=resnulli.us (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=jiri@resnulli.us; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZRrZ6sB0z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 21:43:56 +1000 (AEST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-490abf12f0fso28411175e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781005434; x=1781610234; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2j6CzARsoMyv7N0DLitThZjZq+4w2DpaYqL8Xb2hr4=;
        b=d20PHj6OXBaZib4TJ4o3aOTN/7EZqIfnCotaNqG8jLgjdnzAhTYAXjX4MldakaxM57
         gIrmu4tnP1I2rALKu0n4Y0fqVu4Zh3ZAWyjheVFk0UU/RB7pWPD/6ZLtZ4CNh9DrpvlU
         eFDvB+PbCB/tHYya95WCsEBpFk066NOz8Q/xtnPoPKtvxgKP5A4+Pbem4roM3nO2s/XZ
         elGJT2iHV291JPztwkckvHQuTrZDO5zfGHgGhP2P8CXwig4FB2KF8jTzHqD36RRcVUc2
         AGEUtJPLV/w+lQIxW4p4WW9Tr8UfCU7bsJKGb45vIjVrtzxYgoM5xEs+1Ji8O5ieK8mb
         2l+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005434; x=1781610234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2j6CzARsoMyv7N0DLitThZjZq+4w2DpaYqL8Xb2hr4=;
        b=plt5NAdRfgC4p4rnb0yLjv0KWkS/eXy3zV1389PHysD4G6F/JFyi45q09BgaMbjb61
         e2hovpYytnCw6pE2hsLeKtKHr1KiAs8TFOQM14lV2Kjuh2hDMpPI0/A9nOYqy0sFUe6S
         0nnFtAaB0pQigS2A/qob5snxw9Gnzc5HAn3SqivKxO4urUFIMMmIyPseIV8tKdh2ANlY
         mx99I5V0oJuzEBuV/GIOT3OA3+86EvqO/iY/ZLylgz3YWUWjG61Nfq1O90MreZ94u0K2
         eUDf9/xeaClM2tyNf6CRg9pMx8/7WUBGBx0krZ1ICKKMAyrdmReczdBxnU1hGHbRWWdk
         OS+w==
X-Forwarded-Encrypted: i=1; AFNElJ957ZNcGB0N8y1Qx+CQWYiGHtHdQ/27Z7vSODurv4iN8o8t5gYlSuQuPdO131X/ARbJVUK+XjravRw+IDw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzOWp0sV3lUsXb7NoyJUXmO3iSVk8v8WJz0kDXriVR7x3XB01FW
	YkG3lZGXYYoQ+FIlOjOImgXHfdUaTxV2ZRay49n4wuLFKnqSsqlDFTzT+syZTuDP0Yk=
X-Gm-Gg: Acq92OGG5RgEj6twmXFGNiIzUii0giRewTPeGL1iJxAsnJp0gx1zlk/NelQPw+ixk7x
	QbgxUognxojlrmggNI3bWIDM7oNDS7Cyixd6XzYoGQNaUSOO8tWyKYXajYh1fEeHFrY4cfC8jiW
	h/KxRbb94dCspjFh4f1L77wVdpw2MF1YoNj0o8eqNh4JklJVQJ8sN9IU0+jpA/1ITx0DK3b6bfp
	vS1cHCn2A6++SOl3xZZFy9+vqkj/jOWiTQMMNUC75WN4wgIzHBYUzDC+L2rmOmIXgzeDQd97YZt
	TsH+nFmlI7Th+ndQratRibPCyFcZxhmRKVZUPdixzvPK/MyNbCGAKubsICRs86ic67RtXlzZsgD
	DcFsHGcyWlJzEC6XO7AAXj5SVMsUpxsRR8BF70jD3t3sf7jtATfyi3CY7oFXbPvZKNjp9YV37J2
	NfKgmZQOFqp4AmHQdyCV/KR4mEjuIYQcSyOJypxDDqiQAbbiS3BXmnYA==
X-Received: by 2002:a05:600c:4750:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490c2cb81fbmr232851615e9.2.1781005433488;
        Tue, 09 Jun 2026 04:43:53 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b06sm432012895e9.3.2026.06.09.04.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:43:53 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:43:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Maxime Ripard <mripard@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, "T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-mm@kvack.org, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, Arnd Bergmann <arnd@linaro.org>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <aif8V0kHzv5CYIox@FV6GYCPJ69>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
 <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
 <20260604135712.GV2487554@ziepe.ca>
 <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>

Mon, Jun 08, 2026 at 05:17:15PM +0200, sumit.semwal@linaro.org wrote:
>Hi Jason,
>
>On Thu, 4 Jun 2026 at 19:27, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:
>>
>> > Given that Christoph's objection is not really about the modules part,
>> > but that the set_memory_{encrypted,decrypted} should not be used here,
>> > one option is to revert 78b30c50a7ac until that issue is sorted out?
>>
>> Please no, we have stuff already using this so it would be a
>> functional regression. Revert making heaps into a module since that
>> doesn't have a functional regression.
>
>Thanks for your comments.
>
>To me, it looks like while system and system_cc_shared heaps share a
>lot of code, their user bases have different needs. It's apparent that
>system_cc_heap users don't care about it being a module while system
>heap users would very much like so.
>
>I also discussed this with Arnd, and he suggested we could rearrange
>the code so that system_heap_cc_shared_priv depends on a new Kconfig
>symbol like
>
>config DMABUF_HEAPS_CC_SYSTEM
>        bool "DMA-BUF System Heap for memory encryption"
>        depends on ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=y
>
>This allows building both into the kernel or leave encryption choice
>up to the consumers of the system heap.
>
>If this is agreeable to everyone, I can post Arnd's patch.

Sounds good to me. Thanks!

