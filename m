Return-Path: <linuxppc-dev+bounces-22272-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E624CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:27:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYwsL4MjRz3bp7;
	Tue, 09 Jun 2026 01:27:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f30"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780932470;
	cv=none; b=aFZrpRJjaXT/fjXvjEKfj4xK36DbCWtVuWSqymSCPfcU0B/89nE8xsn4rDhxn4HmJAlUfTNB52iuKdnij3smCjxxtRLD0QW0ZOLB8bXxGykFohh9kwJNm4Kf75Idw/l777i8tr2dDt0m12Z76hQ6OhWGaLxv3S26nEt1siAensOOIooizqcSVRP8OxBdEMhyT4RaHbmRNSnd0jokm3mbXpku4fW1sa8KcF/LgLIaV29s9C5ai90PMqQDqKK5FIlZ8xx4zcqwzADq2/HodgBw9c+5SaKuX2NX/vlSce8amf0TPiuMzUdzwEuMiRBsPpk/vkKzfOA5TWYC34jI/gkV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780932470; c=relaxed/relaxed;
	bh=UocT/uaqPPxlXiS0ZwSI1AWXKBm8Im9MW3m9ZqlaaCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgNov6jEC+ejwaTvH7EPB4tDqNAEGMfGJO5GYAHGMbdqxgqQOtTd9AcJYfT1tYdd5gl8J1rO4zgpHWf/jt+mOQUJDSf95CjNzuU/6O3HoNPv0mTwBOh4zPwW/YnjM69zs2rrVnkfKHMycf7xVqPwrJpZvRwl2f/zKNqBnmFBNTnAW/Fg9HMGnmCgO2/fIetHbWzBqIcR+8/VtuB6W8Q836HlUwZrbVvUYhJysnmd4OrGtFuuVkBnd9ngOfDBFEGSzjXB2i5lUFWzZrosjJCzph0dOPELsO+dDCh9C+L0Y1CKeXr0FUtVwAtH6djLhKPRASg4sdc4FB5JrVYA6RFaoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=WVelutbp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=WVelutbp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYwsJ4cbjz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 01:27:47 +1000 (AEST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-8ce3876a50cso45856746d6.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780932465; x=1781537265; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UocT/uaqPPxlXiS0ZwSI1AWXKBm8Im9MW3m9ZqlaaCo=;
        b=WVelutbpoX9nYAR7BctlOF7toPjeHLdV3Kb30PuI7y/nzcZZVCuymM0BS7UuPqQUbV
         CJUy+tYa5/6fagcrS2tkzwJvGmIDI4heehl4DMrGXUp7s3tfK6gzeTYG5fidFiYeLTlE
         nYL/9cGMQhx7Hk6UjrvYKKiG685OfqIbAQjeJzpIOJsz+ghom03mpUqztZso20QyjnAG
         F2gavCAA1hm6urvwUpb7baxtP8y7uSCCXZy2hSw9CIRZvZxh40jtoreNQ3gJUDS4nKqj
         oCe+bilE8FmwAjcWmC8bW/2lrJgrUBfZStvv3cnSYCi2kQDkiHpgp3GY53SR4yfPgRvY
         EcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932465; x=1781537265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UocT/uaqPPxlXiS0ZwSI1AWXKBm8Im9MW3m9ZqlaaCo=;
        b=aAZ69jzSvtqghymN1VjDz/HMz69vg0WwG9izPZy/CHfbdjJIlaC7v0hXr79r89NsCN
         Ut+SzDtRTs+qHXc69x+Wxo7VA7VQ/IfBjjGNdnksNxJHtKupJHyZ3fkS9s4jnBcWolPt
         UJyO55KQBwPHGki6DOVdUcj1q97X5jWsnkWOCDQuSzDCgbMiF9eV8h06A6X7appHFU6e
         /9tThQ6EykpqzD5RD6IlQ3+rZ/NwniIQIR/6dpSZan/gNbtnock+iOuMMlunI67IJnXs
         7Y+RAvrPiYWUMonXhtP3A69nDPAWKIOEh+hbuoWtcxJ/Far3HWWN3G8G79AaLxuJWIAd
         w91Q==
X-Forwarded-Encrypted: i=1; AFNElJ9UetN0L/SaPPePX+zQ/01I1jErOSd4cDpu3o9O4bQpBf0wKYU5TQbblbh7GtWGoUqnCfowk+pqtuCp7iU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxkANjD7UHe42xEzF+oKP5Mk7lbL2k/dzzwdOEltySeH06Lbc8j
	9zJU9nFQXYCPkJO6+SzKFWGoAJ5lfeQJpcCAAVAX4FVii2Rqcx4mm3sjqd9Ky491JU4=
X-Gm-Gg: Acq92OHng0NfFekgp55XUCTtrK435+M+EPsP2Mjj3Fp8buydkMbSP3MT3PnFG3BtRyb
	TYjYGYgqURRH9w4Y/pHn3S8NexX+CigIceiIULBuxKNffFnIW7+zBDA7/UxNdSFsjsIEcj1v44a
	WreHUYGBsX/It9BAu9g6Xcz0rd6Qft/p4OKJLbiz8eVnsjxsK8h70MDPTTlKgd7V1H3F4GPLwlN
	u3t0M7NP5h8MnVCznOKm3c+XObTPq4fCp+HquyyKwpYvUvgEFBbq73YMjspbEj2zE1KfGV08zaW
	UaX/MMiqkc69htdGeC18V7p4H0CIv5LAUeSOnMfBLBS0ZuJgyxyngfT+U5kbvBW78/99WVTbNiF
	cGVzGKf/drHcNzO+UX/18EFCYdFC+9olFR+CTh+pED+fmHZeVcUE/KmIxvYCLOQsAsOso+FPMHG
	WcvAAVY4ewmuvyC6y7eXWe+/rwMMiRZlpM+qpxc9l/G3P+VMkTd1PtuMimMgyBjSBl/QQgpLfwm
	8Vnwxi1WrreuvCd
X-Received: by 2002:a05:6214:4e09:b0:8be:7779:d1b1 with SMTP id 6a1803df08f44-8cee6252853mr236200376d6.30.1780932464978;
        Mon, 08 Jun 2026 08:27:44 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccda0611sm170331636d6.1.2026.06.08.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:27:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWbt9-0000000HQjH-3xEo;
	Mon, 08 Jun 2026 12:27:43 -0300
Date: Mon, 8 Jun 2026 12:27:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sumit Semwal <sumit.semwal@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Christoph Hellwig <hch@infradead.org>,
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
	Arnd Bergmann <arnd@linaro.org>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260608152743.GD2764304@ziepe.ca>
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

On Mon, Jun 08, 2026 at 08:47:15PM +0530, Sumit Semwal wrote:
> Hi Jason,
> 
> On Thu, 4 Jun 2026 at 19:27, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:
> >
> > > Given that Christoph's objection is not really about the modules part,
> > > but that the set_memory_{encrypted,decrypted} should not be used here,
> > > one option is to revert 78b30c50a7ac until that issue is sorted out?
> >
> > Please no, we have stuff already using this so it would be a
> > functional regression. Revert making heaps into a module since that
> > doesn't have a functional regression.
> 
> Thanks for your comments.
> 
> To me, it looks like while system and system_cc_shared heaps share a
> lot of code, their user bases have different needs. It's apparent that
> system_cc_heap users don't care about it being a module while system
> heap users would very much like so.
> 
> I also discussed this with Arnd, and he suggested we could rearrange
> the code so that system_heap_cc_shared_priv depends on a new Kconfig
> symbol like
> 
> config DMABUF_HEAPS_CC_SYSTEM
>         bool "DMA-BUF System Heap for memory encryption"
>         depends on ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=y
> 
> This allows building both into the kernel or leave encryption choice
> up to the consumers of the system heap.
> 
> If this is agreeable to everyone, I can post Arnd's patch.

Yeah, that's fine for me for now

Jason

