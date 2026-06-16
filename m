Return-Path: <linuxppc-dev+bounces-22716-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B18CD98E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 13:23:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfnkM6Yqdz3bqh;
	Tue, 16 Jun 2026 23:23:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781616219;
	cv=none; b=TRpNGDLamq+hKpXVYG7aA2PmwT8Vj2xhBEolz0DIZL8qztCgA9191RTWCALHd0xcaYp0NiE9f9QnuEijEgPxU9gipH9dHxnGs05X/oWMpG4Uh9lXwd9SY0c4Irkbu9MoeD5NpXzpPtuO5N/NRDK0/nDhG39K1EpSpveIeZMsaviNHlbfjfYHtBu7jNBGXWsEZiOshd5/LfY3re6ycwGwv2TB37onJPszQiqQjFZdwkP+AtdFgFDHzC3jOmNdWLVyAXUB/IZpc3skx3gT7H8yZPTx4ht1T8usTpQ4vk+zKsNg6NDogwPfU7bcOYajEwf+qse4b0ySwhaCDaP3/8M1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781616219; c=relaxed/relaxed;
	bh=i2eQVWR69DVBll8DZTLTpPBD8LsUE2YsnnLAZbM4NLE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=UXGK/NHeI5ZiTQWUGKzEOuqRlcjn+6mCoXZMbT/zGFgoRkEEgf8JOFXqm3IL1Wislh/mozRpSgojrzTF+7yME3p26SMOp2BHyhamFUNeORSXuIuOXmsI1/R+fESVLo+1zsK6dUnKE6Cslod/TN86ywnnMP82x1td7XewknagCCKPVc8NYxw99fnjcuEmDS+AmEBjiebwPMOf6u5wKf/vxXUS2qfp1RfRTG1oMdelD5WUTqt3dDVfMjNQKl35xFVLAamkyfkcoDcYdxk4qQ6BmDdx5PugK90RBHg9hyJOGkMRayY/adiTmbKDtH0TOmvfIcFcBiHoeS3jl+5n0aMS9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aJGxl4kc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aJGxl4kc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfnkL5df1z3bqM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 23:23:38 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-36dd65b95f2so3259038a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 06:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781616216; x=1782221016; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i2eQVWR69DVBll8DZTLTpPBD8LsUE2YsnnLAZbM4NLE=;
        b=aJGxl4kcPMpReXOZw99mMvWdoYiDsDEFFjT6SbLUfs1UQFDUKwoER3TJ4+vlgYEK53
         5Q6+GwkkhZBTFWO9+y0/BmFduYl9AxPd2QVrz50wtGKVT1wck1mkYz18vM9wTyUUty46
         5xfnS38gIl+WveR3pXyr2O2e51mP48Bp63i3FIqrYONLk+a39CDmEv/HDDYKSgoDvvJS
         jU13k5RAAsqEOxKz6/w7XspTp8to83Y0rjIGmoU40biP58gFBVnUnYRU3t7CnERDJkZT
         OKV9i5MEAat5WIAJLRvmcYrx1Q1JT+oMcnff3mhfCX74wb/Url93jzYVj91VMUn68H2N
         wffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616216; x=1782221016;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2eQVWR69DVBll8DZTLTpPBD8LsUE2YsnnLAZbM4NLE=;
        b=jxPJqxgRsivn/jpAu3QZb3N+EvIYVVyjbCXoL8LLFz/4izKPmYaDRMtos1vtfcaLmr
         MXmYdlp1h1Gi8/NsvHfy3TcMiK9vsPB+4E2PIg8mqtHGGK+JiOHmUt5EqikJGwEzjaUl
         8G/5LsnwoHoeDH/zuY5Otv6EpDoXKOyICw55W9uw9PNHkmiN5mXD8SLBmhWNKJqdQEfa
         HCvnORgWEiDY2xILvmkzJAP7YBmKuprZNAbE/KMuXhpY+eBY5357cfbf7dJ1RgZC/qr8
         YoVgXgp2YFOZp/5HskPkq+1MKRVJG85eYYsoSiSyGNqBza9l3c4rvw1JlG06oXcBJyLN
         5c/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/SwepI0+ibpe78G+rRgLuv2Od0FawO89lXt8R/I21Mltv2n1smUAelY6rIDQbpEQhQIAEwUUDnPIuEKYU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywk9uEiFzpbfLSc88HjwjVrvqiQZIm9C4vjiuvCLpHrTVLRNnJO
	GXnmrgh5Keut5W0xcOGyrB3a2LNLpkyGIQGWZ6Ab1lM3qm86ul223288
X-Gm-Gg: Acq92OFFJItvqMYXVIiZ4P58Lf0EQQ4kdExyr61v43dEQ3EhceI8cUjV1Mgfff7eeay
	l2itYP4BjMC+OJWJo9u8mnW20C8oiVr2q+5kJsANNzAmuqz/lhnKM9t+jLn9g8cKVbv+A6+CdLB
	MJWOXDd636KVoODXoL+dEcwwWEI2/BF99dGbb5DI1371luy+8ie5WIgqLo0Pr0FNrcbtFpDpBYx
	NKwG3hF1ymdXcXY69aCfctDyahc9564kGytvqqTDIBmicALlvXOW7AY+5g411X3IrBDht/XMlfY
	XUSajGp7hqggQh41GCCvuItUC3mVRhvZQfDT+cLeyumH/TP4e5zq3VMazOAgkd7aYZF6aeQzdrh
	0FWNjflHsnFg0ETIl7p0WhwsWW6Icm9idxC5Tv6jdg+N9Pv3Sdco1zn/4Q2U80msWeb1RWwsHxM
	W1ec2C595eo/dkYXZHj/OdXi+JnQ==
X-Received: by 2002:a17:90b:1d51:b0:368:65d1:893 with SMTP id 98e67ed59e1d1-37c5235adeamr3228415a91.5.1781616215829;
        Tue, 16 Jun 2026 06:23:35 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866518677dsm11704475a12.19.2026.06.16.06.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:23:35 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260616182627.2ebf3cfc-3a-amachhiw@linux.ibm.com>
Date: Tue, 16 Jun 2026 18:39:11 +0530
Message-ID: <8q8eeio8.ritesh.list@gmail.com>
References: <20260609053327.61563-1-amachhiw@linux.ibm.com> <cxxqerzk.ritesh.list@gmail.com> <20260616161011.835c90f0-38-amachhiw@linux.ibm.com> <a4suelh6.ritesh.list@gmail.com> <20260616182627.2ebf3cfc-3a-amachhiw@linux.ibm.com>
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

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On 2026/06/16 05:38 PM, Ritesh Harjani wrote:
>> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
>> 
>> >> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> >> > index 3449dd2b577d..7472b9522f71 100644
>> >> > --- a/arch/powerpc/include/asm/reg.h
>> >> > +++ b/arch/powerpc/include/asm/reg.h
>> >> > @@ -1356,6 +1356,7 @@
>> >> >  #define PVR_ARCH_300	0x0f000005
>> >> >  #define PVR_ARCH_31	0x0f000006
>> >> >  #define PVR_ARCH_31_P11	0x0f000007
>> >> > +#define PVR_ARCH_INVALID	0xffffffff
>> >> 
>> >> Logical processor version is defined as part of the PAPR spec. We should
>> >> ensure that this invalid PVR is also documented in the PAPR spec.
>> >> 
>> >> If you have already taken care of that, then please confirm and feel free to add:
>> >
>> > Regarding the PAPR specification documentation: The PAPR spec documents
>> > the valid Processor Version Register (PVR) values for each processor
>> > generation (POWER8, POWER9, POWER10, POWER11, etc.). However, the
>> > PVR_ARCH_INVALID value (0xffffffff) introduced in this patch series is a
>> > KVM implementation detail used internally to mark invalid compatibility
>> > mode requests - it's not an architectural value that would be defined in
>> > PAPR itself.
>> >
>> > The validation logic and the use of PVR_ARCH_INVALID as a sentinel value
>> > are documented in the kernel code and commit message.
>> >
>> 
>> But that still worries me on what if PAPR wants to re-use this value for
>> some other purpose in future. 
>
> This is a valid concern about potential future conflicts with PAPR.
> However, I'd like to point out that PAPR explicitly specifies:
>
>   "The first byte of the logical processor version value shall be 0x0F."
>
> Since PVR_ARCH_INVALID (0xffffffff) has a first byte of 0xFF, it's
> explicitly outside the valid PAPR-defined range for logical PVR values.
> This means there shouldn't be any risk of future conflict with PAPR
> specifications.
>

aah ok.. That make sense. Thanks for confirming that.
Can we please update a small comment in the code and log this info,
maybe something like:

/*
 * PAPR specifies that the first byte of a valid logical PVR value is
 * 0x0f. 0xffffffff therefore lies permanently outside the PAPR-defined
 * range and is safe to repurpose as a kernel-internal sentinel. KVM
 * stores it in vc->arch_compat when userspace requests an unsupported
 * compatibility mode (e.g. Power11 on a Power10 compat host);
 * kvmppc_sanity_check() detects this and prevents the vCPU from running
 * until a valid arch_compat is set.
 */
#define PVR_ARCH_INVALID      0xffffffff


-ritesh


