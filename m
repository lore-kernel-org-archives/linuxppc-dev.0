Return-Path: <linuxppc-dev+bounces-20953-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEDDCD4F25
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 10:57:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGS2w6l15z2xy8;
	Thu, 14 May 2026 20:57:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778745997;
	cv=pass; b=Kgf8uMn6Sp/wWmVCCCFzf3ES14SmDnHyl6s6U6HR/v0BWKz8HywrpGipOj4IRmT1vtYKSyn8kyGa+8S9JmSt2A8btanyTRzgGMr5IF/UkrluCnl2proyP1QNTnSBqkHL0j/MHSt09Lyn+HYFMUm5sk/dacZNj4zUEPjtzDuMQAvMqXjnxQNSmXczSneUnWu2DucAjnIn3hgjNSUQsJuZSkDR1ou0yLDYK8KkRjYFMwSISH3f7gfhZp/nTnL9AaE4N5hPpSbA6s0p0HW1pbClbvlOwpY56OBVYdK0QjRlfx0Clzh74M6XTABxTUTgE/OSTPS+icbIDCjieSYGGoURuw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778745997; c=relaxed/relaxed;
	bh=QXdd7FnOAYRaLS7B63YJ6ysgGCzM3+RdD/s5lYMWf1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iW/Kzau3wfE8zI8lc5b1qzKQg3O7za/ImcRoATQ2pGemXxKFrJ/PJnOXElhruFuHvf9avvveiADg29Gpe/+i2BfbzQTMwj9obbD/0aVopgSrtYU/CoHW09i57GZSsE2wAFCTPC7FfivomrmJPATQWmMVxBt7JKJ9j9gfUtSCoobx8sFowYjqbduodywtfwysqiJRGthoF7txU2W4MDQttY/pjFJQz29dmKfcqeyCEmhupUQwSBM+w6iwX76E+uIBHxrBjSHy8Vki71oy3yWAtlqn/F2kHjo+ULZ7lHo3vovobAuRpN9TKjDAbSWN5AAqSuCCQ4uDd4+gYuBY0xtbLQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RUfv+YnY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RUfv+YnY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGNFm3Sf3z2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 18:06:36 +1000 (AEST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-50e61648f10so351461cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 01:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778745993; cv=none;
        d=google.com; s=arc-20240605;
        b=NpWG+aK9Rw4gAy+Hhkf+srWSQnW7GFp48TjS6PR44XtV58UX7LnTv/ma/TA4STH1E+
         5SUChnuW6bTEBt8hp5jtQnTIWd2NdNoABIaRDhVRBFpmNTwfip3KscQWrM+6HVdQWvXg
         t13WroG2dm2rDN/fxRmFSyXjM/dQiIYXG9CxaAgOBA0fdUkVVj3+nS9DlTp59KcmFGv1
         NgQPLjlVFg/MIptPXJh+UoIx+kugSNrFZerqbKY0q6A9gdPSufznUO72F3auNEJY1qx8
         UCvsrExad4S0VCBZhEoPJoJWQvhuW9gZYVpt4LamgzLVxP1uxNwqFs/pJhc00O9IWixY
         aeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QXdd7FnOAYRaLS7B63YJ6ysgGCzM3+RdD/s5lYMWf1I=;
        fh=hT7j1YMqERWij50+sr7P91fE1fsYXpmkuSfL6hrEXVs=;
        b=fpRUzcGHuZQ5xZGG4hZkxtGFs32ZjEr/OijLhhjlmNONVStuSMI/nvKZq4tWpKTpTs
         yf2U84PBGVUldjq0/9pRopgvNHXWXZqX889uJVw9+SehnMjmzTSquiReP9IOJAmkcbEY
         0pc2jotAd36kXol/OWyJQLFO/C6VI2rH6X/FABqY1aBYxEH61I/bxEgInB9yrs+Oyyac
         hYhermQzAV9ptODvd/qDAMUlROIKcDsSUWYROwqgBhnL1raPMlAzakCwUE1Cg9K6BMlO
         nV3JSHxpOYhJHbwFUReer4YQoKDs+mg/A13IlXJ53scE2U6MKAnU7n5Eg2+kpocgJjRc
         SSzQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778745993; x=1779350793; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXdd7FnOAYRaLS7B63YJ6ysgGCzM3+RdD/s5lYMWf1I=;
        b=RUfv+YnY33CdDhUDsJNwZ1C2o7BRKfIqFUD/TZxiOfWbjfRdfPyUDn6adfsIsx45U1
         2irz23UHcmAX2r0yfpxYCidI+xJZQy8BzOe0myknvZET+/VU/hB41tQ/PXAdo48NxZlY
         MMp2RLqVfr3fUrAktbc3kRCKOPsNVZpFUhuP2ArUsX27qTHI2pwStCNXfYmpmJgEzCDv
         mcK4mYmmwl7HIBze+PjqpAhhZOLtKy11RZqpQUkzuz5GpnN1Cj73PQ5MmZzNJwvfhNLp
         NxOCfSByDZwoWb6aH/YOQEKmBJTbmnxvZEmdQxNyitSR3t6108shom/2VIjYIWhmavSU
         cXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778745993; x=1779350793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXdd7FnOAYRaLS7B63YJ6ysgGCzM3+RdD/s5lYMWf1I=;
        b=N8AMiGMFqvFtFn1Ap/XZAh3QLjMYFO0T1Z0rlArYRsYznt1bcUBcY5dEUa921INjB7
         qgwUYi/qYTcm+URnMb7lBJX/9pDregk7h+a3pS2eK7whB2Y/I6W7HMFq/j/XuMR075NJ
         p68rxOCvITiIhlRBB04ABAH6695qVrSkxcH1XXJiQ6FSA3VTPSndp+NqubuM6cu04xFy
         atoPygljqAlDC0hK9sjNByzZwn+Qs9PxOgPwj5ORR8VWnvHYnuCy4ilpubb9MhyJYXq0
         IV37U9ROz3D0S7e7GXoL8Sgxv2hXWqhX6REYDQbGPgKnVoe7CX7HFMCsLf2GvRPokGXI
         T8gw==
X-Forwarded-Encrypted: i=1; AFNElJ8ZZbG0884e1jsdZWe5fp2z4kBeep9/nbiFZiXBdvgw+3MCFzgq//7Fx8glhaoucsirMemolRuI+3MVWQ0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzhyRyZFsBIMC+T6jTE+V1HzMsb7jcvtaF4yawzGP0pwNplgkMH
	mykWBhP47Cjw3H083m49xocDPMlXBI9637aGPKh+fw3jlHg0u6NE/ABSkGf7+kLLWko3uwjQZ+D
	uM8aTbel+dyWy0DFeJWklm5m4SqDMcffL1vazuFtO
X-Gm-Gg: Acq92OHhX5Sz8PTsvsNCXfjcHfUZ99TECfIyqKaWixYFj4d/QccNG7m2776N4SvM5iH
	efVsq9RxMidll9RMBR9+Dp67W4CLqaxRHMoBznZR0+QqA1xWr5io7QRQsuMcTSBaw76UR6R8HDG
	QIzNkUr9M3tFlD1VyuTRD4weZnAohbK/FGnwzuX+GVtMFbJHHaUP2TY0xU4teC7P0iVOOMeHo0J
	aikTCDPBPzYVS7lqYmSTPMD2MgyZe/E9wNvUmRT3o6rjwAgdS3a6jIlmJO3+FuHmL4gVASZptq9
	wMUQn48Zuo2C85GOx/7v9SRi0mUJRitX85lk3OCxrWJiDAqK
X-Received: by 2002:a05:622a:9007:b0:50e:6360:96e with SMTP id
 d75a77b69052e-516420a4ecdmr12032231cf.0.1778745992401; Thu, 14 May 2026
 01:06:32 -0700 (PDT)
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
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-4-aneesh.kumar@kernel.org> <agSED6BdSXBhbDYI@google.com>
 <yq5abjeia315.fsf@kernel.org>
In-Reply-To: <yq5abjeia315.fsf@kernel.org>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 14 May 2026 09:06:19 +0100
X-Gm-Features: AVHnY4KFUT_Q3ProEjcPRlzXFAyPmNH0RBADajCyGfb0sF72QbGsmq65dFwn1XU
Message-ID: <CAFgf54qB0msUdKakDvh7hp0r5kokPV0vohBxUjkOz7sR1FZNuw@mail.gmail.com>
Subject: Re: [PATCH v4 03/13] dma-pool: track decrypted atomic pools and
 select them via attrs
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, 
	Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>, Petr Tesarik <ptesarik@suse.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 8:01=E2=80=AFAM Aneesh Kumar K.V
<aneesh.kumar@kernel.org> wrote:
>
> Mostafa Saleh <smostafa@google.com> writes:
>
> ...
>
> >>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> >> -            void **cpu_addr, gfp_t gfp,
> >> +            void **cpu_addr, gfp_t gfp, unsigned long attrs,
> >>              bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t=
))
> >>  {
> >> -    struct gen_pool *pool =3D NULL;
> >> +    struct dma_gen_pool *dma_pool =3D NULL;
> >>      struct page *page;
> >>      bool pool_found =3D false;
> >>
> >> -    while ((pool =3D dma_guess_pool(pool, gfp))) {
> >> +    while ((dma_pool =3D dma_guess_pool(dma_pool, gfp))) {
> >> +
> >> +            if (dma_pool->unencrypted !=3D !!(attrs & DMA_ATTR_CC_SHA=
RED))
> >> +                    continue;
> >> +
> >
> > nit: If we fail to find a matching pool, a slightly misleading message
> > is printed as pool_found =3D false
> >
>
> The message printed is
>
>         WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
>
> That is correct, isn=E2=80=99t it? The kernel failed to find a pool with =
the
> correct encryption attribute. For example, the request was for an
> encrypted allocation from the pool, but no encrypted pool was available.
>

Sure, I=E2=80=99d prefer a clearer print in that case, especially since tha=
t=E2=80=99s new code:
=E2=80=9COnly {encrypted/decrypted} pool found for a {encrypted/decrypted} =
alloction=E2=80=9D

But no strong opinion.

Thanks,
Mostafa



> >
> >>              pool_found =3D true;
> >> -            page =3D __dma_alloc_from_pool(dev, size, pool, cpu_addr,
> >> +            page =3D __dma_alloc_from_pool(dev, size, dma_pool->pool,=
 cpu_addr,
> >>                                           phys_addr_ok);
> >>              if (page)
> >>                      return page;
> >> @@ -296,12 +345,14 @@ struct page *dma_alloc_from_pool(struct device *=
dev, size_t size,
>
> -aneesh

