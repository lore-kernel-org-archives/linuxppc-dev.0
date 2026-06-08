Return-Path: <linuxppc-dev+bounces-22274-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17A7CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:04:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYxh6759wz30FP;
	Tue, 09 Jun 2026 02:04:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::330" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780934694;
	cv=pass; b=T6c9gbNIa8PtUHfLxA/VD0DS35nq6otRDuZKs55noCZhsFiH5H//W8bspFvBkuukrCT+JxATWYrXIvdCERck3pD4Pb4jMiWf58FmHLyaOUdFH3KFlfPpMPjyZ7W9b87oOfzoHivdh/Xv7SUjbsKOmGIbDdtSNqjSawgHy4/Lu1tpHvLb6N/Q5+sPMJB2E3WZLtR2HJ3oQNRTxot7NXKYiv+pKKDNJuxagLNGZVehYoprpP+AFqYzap/Ix71SRO5PxUod1uudsa0Benw/ekxms2pyDJlTpWFRcE5B+H8aUWHDrY0cJu53kv2uVe1PjfrFfrB5NEBEBkFcQB/vY4+dGA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780934694; c=relaxed/relaxed;
	bh=CDdhbWCx9VsAlPpkbZ7T/pVekmt8/mWg3u3kSPoOV2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVPWCcjx1NagNblUMNwf/nZpzhguI7QVAundOW+0LnW2BUOC5RHnacvf/iBS3JDVG4iXL+C14c5xI/YyIb8tT4e2tKTh9+Cls1k5f7p+kscFif3RvTNcP3fXRPjQM7Afy1kis6EmD2NDUtjQjc6G2hwZRcQCDVBGFezO/HQgcUSV/GXEgv91TAWAOPcIbmkbKf5il1mlQiRR8alh5/iWmYd9/AZUt/u3i1CMSHMADRJLOwfoG8VzKEmI/GmpRp9M4uswaBObTtn3UH4b8xqloTMJyZk3FLZBi8uPG6LdWigT5/DJQpOdO3jubj3g9jWhxJuutQMRFXaiZjDmKskalA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ebv3X4j0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=tjmercier@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ebv3X4j0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=tjmercier@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYxh51bvsz2yv2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 02:04:52 +1000 (AEST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso227755e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 09:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934688; cv=none;
        d=google.com; s=arc-20240605;
        b=V400OKmlT1HOMHv44+npjxBKWIEYeFyey1WAbNANp9mOKQbpSPWTCelO27XcinwTbA
         52d/8UeiUnwIUNgZAYQMZiIph1AYupdDwkQwBN58T5zO7rXvGEAOSSD3qDnAbpPllkEK
         pp9x3S+pzhYvbwz5AApZMFCGW5uPFXiI+VR4ejN3yGfW9cwBQzTYXlZ4/4RsGRwr0FN3
         gJvrH8f/JDoaCNdoQQW4gV3oRmPnanvw5cyVDjNsNZIrdPqNiewZdjRFraKo7g50aq84
         FHoHsTnC+76lrNyd2giMQ2p+E5qR5tFuRoRgf4K81pMQklgEkgY8z3k6BuLl5PMPfoBT
         XLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CDdhbWCx9VsAlPpkbZ7T/pVekmt8/mWg3u3kSPoOV2c=;
        fh=WkI97jiQHL9xGIKlJh7xbKFtVz7m5FPtl5EbGWVePcU=;
        b=KdsMzXki6rqcq2b5PJJ1qX7fbFTOYkh4GoxWRjDF4397DY62BlKvnQu5oubtnsSNoM
         CyXZqAc9ekO+tUOIaUK4/d8yAhbzorAoxhnsV7f16HAphWwpv9GAP82IWM0MTEdSjiTV
         52W5gLHon3tObQAoXlq+CpCwQDjkE1SQcBqDC7hV24vpEEuLxua2c6WQy5nLknXua+0F
         mBxx4LL6jzqczI6ANEk0zvxOXBuTVEiOjK9u78l5wjNp4L/r8UQDuwSAYFKKWptBwx+a
         PFH4DDi/T2ovVLmYL9o0govpaKAXHOXC+gZXNK7Hw5jz0X9XRbggGmE/TVc3f49JbINm
         ndnQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780934688; x=1781539488; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDdhbWCx9VsAlPpkbZ7T/pVekmt8/mWg3u3kSPoOV2c=;
        b=Ebv3X4j0uVcUMx63xlNruNnbUEfxQzYr2LvKQbecHcSl4Ak8BqPq8XQ4U//s0w4B9L
         uwrgk0SfsflLz9pZQMxQrHd/m1izuk6VUs2QQAAzrkyMEBEEospw5mtYI1kSb5NCPT67
         3qRcmZyJP82PrnMq8qV8iVycIIrbIUhZr3ge4gyYOMMZie46FwU6X/v1AvUUhkUKELFx
         827c5BSBJfHGppiq2X+fHj7o3qraJcVb+uffga9NaORXhfNLm5JXRT3LrNLOH11Kei5W
         TIGYXQZm9cGakAH+oyWA84xZ5FQEKs1FvqWwOY5MpB0wGVNR4q2yHS8aVNXp5PxIeAU1
         5qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934688; x=1781539488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CDdhbWCx9VsAlPpkbZ7T/pVekmt8/mWg3u3kSPoOV2c=;
        b=FfPaBjE6+eDjouAwT0u/4uetqOsKKx9aANLx8OvX5LhV3b82gIHorq5WafXCTLj6Gi
         LbcMlmU4RHAw3jkLkrglDYUGodSFttU5MkoGzlvoEj2MAo8XYe1i1E15SCeihrTu5SRd
         WuAjTNYT67f2A0Z+0fjq1LQAFVyuSrTQe1HUJ6EC6JzUpdRR9hv1BxSwbsXvI3ADdkGL
         lEM+SAwk7BjEVt6BdCB3GidFDyIOcRXaDWkE+eabHLGadqo3TkeU/Yt3A6cuUo4RPYC/
         edaHyzMn6z2gYUE6n29bUI1gmwJhEMGY0AlkLPZu6ABdFeeBC22yHrgGJ8k26JM6wfgB
         khKQ==
X-Forwarded-Encrypted: i=1; AFNElJ97dAoSvgjJVJq20H3IiwDfwD7lqjpM1zO0+G2VGEok2iSLJ0Y0o9GTdQOSCINjRX8b89o7tQKwg4hq/vs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4VeKXD56k+bRAxIVTY1sfDItyY7fZfsx94hll88I+vEe07dMt
	2Jgfsr1qCviWIpdNwCdQuZ2PD2thP8V3WatQc3sTHxvP1NUPSZz6s7cTBTjah6QXpgRBeu8P+3r
	bapHspRO3YXJ2/5R21lY5TJO+uAn50smOgbfuSzLX
X-Gm-Gg: Acq92OEipN+Gm51ObHDApP63WrQDCFF4cswRedtRhejocpqYTVPWQxpILHlZj2sEbPF
	0Hmud7WcM8BypDGWQ0XtnACTcqfjQWSkRLDhreC1niO6oDppGs46E6mufWL5SFoPGMIdkgTUFSa
	MrsInWJG8OmiYXUYP3JatsGY7WT7x8D6YSz33ldpYZ5e6piuy1qu74kRr6C0kuwmnZrbXI+ns9C
	voDsbfn4H87pXR/JJYaj4ZAV2zAOvTstHFdofZX1bA7MSxGGKdT5E/iNxpQNhnOpRPLTd7zILKO
	ineg0pwHCgrxQgH91m4caP1Yy7O6b1TCBs80Np6EPHCJrri8
X-Received: by 2002:a05:600c:3495:b0:490:b0f1:3422 with SMTP id
 5b1f17b1804b1-490c2ca21f1mr5078185e9.10.1780934688036; Mon, 08 Jun 2026
 09:04:48 -0700 (PDT)
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
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
 <20260604135712.GV2487554@ziepe.ca> <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>
 <20260608152743.GD2764304@ziepe.ca>
In-Reply-To: <20260608152743.GD2764304@ziepe.ca>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 8 Jun 2026 09:04:35 -0700
X-Gm-Features: AVVi8CdkX2dlLd8iv_kbStMI93TXdDT01BqcU1-TGKHekXSJtH26ENHtm_IhVVA
Message-ID: <CABdmKX18EXsL48Cv1Kxrp0g6bVndZfU9b5pfeGgQyvMREk5PSA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and set_memory_decrypted
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Jiri Pirko <jiri@resnulli.us>, 
	Maxime Ripard <mripard@kernel.org>, Christoph Hellwig <hch@infradead.org>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-mm@kvack.org, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, 
	Dan Williams <djbw@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, 
	Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 8:27=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, Jun 08, 2026 at 08:47:15PM +0530, Sumit Semwal wrote:
> > Hi Jason,
> >
> > On Thu, 4 Jun 2026 at 19:27, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:
> > >
> > > > Given that Christoph's objection is not really about the modules pa=
rt,
> > > > but that the set_memory_{encrypted,decrypted} should not be used he=
re,
> > > > one option is to revert 78b30c50a7ac until that issue is sorted out=
?
> > >
> > > Please no, we have stuff already using this so it would be a
> > > functional regression. Revert making heaps into a module since that
> > > doesn't have a functional regression.
> >
> > Thanks for your comments.
> >
> > To me, it looks like while system and system_cc_shared heaps share a
> > lot of code, their user bases have different needs. It's apparent that
> > system_cc_heap users don't care about it being a module while system
> > heap users would very much like so.
> >
> > I also discussed this with Arnd, and he suggested we could rearrange
> > the code so that system_heap_cc_shared_priv depends on a new Kconfig
> > symbol like
> >
> > config DMABUF_HEAPS_CC_SYSTEM
> >         bool "DMA-BUF System Heap for memory encryption"
> >         depends on ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=3Dy
> >
> > This allows building both into the kernel or leave encryption choice
> > up to the consumers of the system heap.
> >
> > If this is agreeable to everyone, I can post Arnd's patch.
>
> Yeah, that's fine for me for now
>
> Jason

+1 SGTM

Thanks,
T.J.

