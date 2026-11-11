Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA9606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 03:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cVaX30La
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPT4N4P7zz2xWR;
	Wed, 11 Nov 2026 14:08:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::32a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794366516;
	cv=pass; b=eH+8nng+IPELw97oO8lnkGOvAzj1W5XiTHq2BKSOyyuddI6x86k/IKt86dLCvwwaAg1CRKSNBeQyE2MFKBP/ZE0KA3s/fwKw8XavkegIgt22Z1acrPCsOS9guqFucoRwmLzIE6uWgrznClLMrRp0WsUqkcJItC8SccFYdj7KwmgPNdd/V1RkI4cPEj5oRCoQlOeZmFpo5TCY0cUYV/gjCxAKFOhiFTszDFSlbmWGP1Duaxk95f47jC91lztPWArw/XYhuQPwrxTIDhyEOPv9+uE4Lwcn5m1YLhQvgh22Fedp7PzWjUtbH60TLFI2TEPcpHZ4p7HbJwCbCBKJZa05GA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794366516; c=relaxed/relaxed;
	bh=UWUQRFbmRLGQnDyBGsNebPidDTP9HqGva0/1QMumkOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g16JhY4WNXbEx96z7jGxAP/bOhefC8LK1McGI5P6U0fXGmkKyY9pPCwMCMNdova8EG24PNdFzYcsU36Ao0/Mk1rjvcPY4QQsOdZKC64OzS2XnjZqjODCxPVzCrNkbEckY4VApkLTw3p9oT1DHyTRKuZAAMSkXYehGU8PHRjMIOg6AJOLx9eHRXSkE4cPrilzLgZ21BQDcrE2AHArTiFwDz3cC6+brA00y5SU31H/OJSQxDv5e0kZpyU00mafpIW84KgQH76HQZHJkd5GvZPxF7lZhcotps06x6fNLVtl8a3nQvdwlG4oMK2WFB0AngXeRykHCGT8H5DCGKAGOK2rzg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cVaX30La; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cVaX30La;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPT4L5F8Kz2xMQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 14:08:33 +1100 (AEDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so16235705e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 19:08:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794366509; cv=none;
        d=google.com; s=arc-20260327;
        b=rkXLQ/fdxADxyLDx75oK0Bjrhhs47FPrizrYTe1Hjk7kSqJcAF32rR9llCINdW4NcO
         EBdOOho5MuHuWxq/CFvcQJIYf54iT4X/Ejv37V/rbsQ4aH7S8QMo/w0a5FuriNpkp3RK
         Fg25ffaXFmqXpJLvs63XnYAiUvrd33ot+LCrDUilrevZn6orHk3GNQcotjMDfcQ9o27A
         4UAhxnP0Pzn2fFYxVxefCwAISWAEBLD6C/bw06mj44VVkntzDnj9yfaxP8v2xjM0m0lT
         jxEqQKLfHv3Nzlak9YWYusN9GJOI0vicPaOWIMtB5danURIzdfu5YL2Ya7ctM+jIacEg
         ecKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UWUQRFbmRLGQnDyBGsNebPidDTP9HqGva0/1QMumkOA=;
        fh=o2N7FZdchi5HTemadPAfipUT/d3yMLNZ30ZGt2zCzoc=;
        b=JHYNEXO38CL+6bNvEt7VW7SrfAtvE/ZPBwwrKdMCguuDEMVhistTOf7ptH2nQv75SJ
         TWFcQOPOhVRj3T283YeCbp+2tFqeiUa+MpaUmDweOEyVCtjH4AsxXL9dLdFpJYqPE0Ux
         jWZZW6/lnkK1D+56a9SYTqBL1Ade9X8i3oXt1tjjGvsUIXSjVPPJ0rq1ljOo7l0ncpZu
         8EGW5PP+89LwC7IbN8nUI40Dn7kmUv1ELNHXfpajshJmvAmvcU6yox6CRxHvgp56qTrf
         vD6YTdkRkm96P9yyU8zdLsnMUAg/lUX6tVpYS1gNxApTH4DAn6BgEG99CAmADwKogAg5
         rDhA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794366509; x=1794971309; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWUQRFbmRLGQnDyBGsNebPidDTP9HqGva0/1QMumkOA=;
        b=cVaX30LaY1nvLPJ/Ndc5IV3nrAqw4yXOtUxn5xxBEg5iqfhQN6wmOmfawFeYpmYP6S
         SEAgLFLD1l93hv7wgGQvIWdKuyXxw96TYw8E73TlkGq4gM+0tp1efsPB4FGJ3EX4NYEg
         jh9SP4txgFqKS7LhWJwGKkbQA1+vR0ulWa/F+W4I/od29VxKFcnODQJNMRNot4IWb1Hb
         ewR+L47dwDEMkaA3jbBFdXDX2CyluMBdKb+9yzj2xAVYO/0Bq1l2rm8DTPxEknJZHG7G
         12J8Abookub8UrLegaZcmrbAmbtaeoRCmtL9poUQhGNw/j8aIo28KbMRntacKY9GIFjL
         bUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794366509; x=1794971309;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UWUQRFbmRLGQnDyBGsNebPidDTP9HqGva0/1QMumkOA=;
        b=WbjLy0laC9vm+G/wEMykxnyk/n8aH7O31SyFJ6GPHbEUx/TyXm7YJtadxOOEG9CmtZ
         MnLP/DProY8fZrZdLQC/HuzCMcElx9Am0Td8scySNloPA3NpdgNeEu6WVGnardHMNb6l
         5zLjcgtaThva9gk9GxaZQNSGFuTfCvoe/Lt8Q1SJr0XNzXllk/SXU6Lkp7ZZ7Ji4I+AN
         e2kpnkunvXUShNXVcYRlauNfYex/nrTSHwtN6ck9mBzyE6hebvB1E/qIYDJO9YNP+d9Q
         LzhJSOiYV/T8Lj7NZZmaH10VxxPZUa8PY366ydKRxVO3n6n7NAcT196HcnQGxHjxX+/f
         S8vg==
X-Forwarded-Encrypted: i=1; AL+hErGi2QwhCygGUN/EkxeB7u6bsotEwbG/ZlK4YF043SjllUDoQrAYt8zXm6sSXcjhdInBKMHkc/ujmYnSRIc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/LaE9ze/ZMjjCLMQg/veNZbW1uHFEyM+7NYVC6MP9knL4aadEo
	ZltDoXSdZ3H7NpRxfrjMgHKI0tZB3HcgC4xoUVHFHh/tyxqi2zp1bYA5I6cafskwU2B3sq4iBcX
	tWJEHC3vwl3QC+uw235myf+wn7VF5YVY=
X-Gm-Gg: AYBFou0Yik4TQ40rc9Os/gu7/FJqlCIeUGDYauQc7byKuIKgTDjISlly48+ihLk18rC
	IDu7r4t3CgmfgkZC0Nbr7Q8XYUbov8XvJ+E11bmPiIS/Q5Gqa0i68fcBVm5g6WaHCDSgzuf7YFg
	MR0f0C+WJtg5NY9Pz02lBTGxp6b7x9WGMGzK4BMPYE6Ibg1TS+i/6Zhfmb/EQD3VTXQXnW80ITF
	f4EHO218nNCvHRS643QAEhhf+znEwjAIU9fEO3zzd0mXKFJeMbNzumI20PcQYzzjp6eg8bhWhG3
	ak8VTlePOB5UNoN0qyTY7CtKucpqd9B551vk2xgCwSXWbQnmki5g0lmFFPXJNm9RGi6q+xBnQCs
	xiKY17g2JXGTCUJnfyA1Mk15Z4Ovr5TgRLURz6A==
X-Received: by 2002:a05:600c:3f06:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4ba0931ef17mr14337115e9.2.1794366508821; Tue, 10 Nov 2026
 19:08:28 -0800 (PST)
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
References: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
 <20261108230842.3a77b9fe2d4bfc2a04b355a5@linux-foundation.org>
 <CAHKocdGWE9OVA5pJh33U-FYnNkUqRS0pzFt=rCwXWzY9w-QXyw@mail.gmail.com>
 <20261109140206.GY9176@e132581.arm.com> <20261109092404.5441d8bf9c4494ed008162fa@linux-foundation.org>
In-Reply-To: <20261109092404.5441d8bf9c4494ed008162fa@linux-foundation.org>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Wed, 11 Nov 2026 11:08:17 +0800
X-Gm-Features: AclHuK-m1Jv5Lpg8e2HNShd2BigzuuDvNRyTpoQSxJNGTZo8P3hgc34a2sG_LX0
Message-ID: <CAHKocdG1pvZfo=fxX9OJZxCOnZt6nBYwtRV7rAxPfdukDy6cCw@mail.gmail.com>
Subject: Re: [PATCH v12 00/10] mm/vmalloc: Speed up ioremap, vmalloc and vmap
 with contiguous memory
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Leo Yan <leo.yan@arm.com>, catalin.marinas@arm.com, will@kernel.org, 
	urezki@gmail.com, linux-mm@kvack.org, baohua@kernel.org, dev.jain@arm.com, 
	ryan.roberts@arm.com, anshuman.khandual@arm.com, david@kernel.org, 
	rppt@kernel.org, xueyuan.chen21@gmail.com, chleroy@kernel.org, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, ajd@linux.ibm.com, 
	jiangwen6@xiaomi.com, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 at 01:24, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 9 Nov 2026 14:02:06 +0000 Leo Yan <leo.yan@arm.com> wrote:
>
> > On Mon, Nov 09, 2026 at 07:07:23PM +0800, Wen Jiang wrote:
> >
> > [...]
> >
> > > > Do we have sufficient ARM review?
> > > >
> > >
> > > Thanks for picking this up.
> > >
> > > On ARM review: Dev reviewed the earlier revision in detail and
> > > his suggestions are folded in. Leo Yan tested the large vmap() path
> > > on TRBE/SPE. We'd welcome more ARM review from Ryan, Catalin
> > > and others.
> >
> > I confirmed that my Tested-by tag remains valid on the latest version.
> > The improvement is consistent with L2D TLB refill reduced from
> > ~16000+ to ~500+ across multiple runs.
>
> Thanks.  I added your t-b to every patch in the mm.git copy of this
> series.
>
>
> AI review found a couple of little things:
>
> : In [07/10], vmap_pages_range_noflush_walk() uses an int nr
> : index, now shared by the high-order mapping path. The previous
> : high-order path used unsigned int i, nr. Beyond INT_MAX base
> : pages the new index overflows and pages[*nr] can go out of
> : bounds. On x86-64/4K that means an allocation above 8 TiB,
> : within the vmalloc VA window but requiring a very large machine.
> : Please carry unsigned long or size_t through the direct walker.
>
> The vmap(8TB) limit is already well known, not sure that we plan to do
> anything about it(?).  But the patchset seems to drop that limit to 4TB
> for higher-order pages, which can't be a good thing.
>

Right. I've posted a fixup for [07/10] in reply to that patch, switching the
index to unsigned long.

> : In [09/10], nr_contig < 2 can be dropped: the loop guarantees
> : at least one page, and vm_shift(..., PAGE_SIZE) returns zero
> : for a single page. I withdraw my earlier NULL-page objection;
> : I could not establish a legitimate producer of that input.
>

The nr_contig < 2 check is redundant, as noted. It's just a cheap
early exit for the single-page case, so I'd lean towards keeping it,

Thanks,
Wen

