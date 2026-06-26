Return-Path: <linuxppc-dev+bounces-23013-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61ECCD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:18:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gms7k2bfZz2yYd;
	Fri, 26 Jun 2026 20:18:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1332" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782469090;
	cv=pass; b=Mv+z38cat6FqUuHiFPxY7uIb6IvMwZH+05WFarOKEnaAsWFoNDzu2hyqCERjtS372g8eQBcNU+ClGf8d33vg5QmxtZOMDPTNfDn6dIZ/SH3H6LYzVOrHEYgTG181sFtdyfOSgwC1nx2IZasitH7x/q4vy4Osc5I2TPHtPtMKSMXqOXLdpxYXvAK6RO5uJw5DQuqju4mBHn6tNOzguY3NF4y+dpj6zDW53vJVQD86g+o9gbugB4GcXhxvN6Rg8BwrBHT5z2O6IztkatR+Ulmf3Ob9fKvf2iuUeSvTCX29JYsn8ANcfcfKH0L0CjUm1etFpQBKkTRn63vA/CR9Q0m7HA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782469090; c=relaxed/relaxed;
	bh=OwEemPqInwbSVk9dzdDs5pHQn5Viy4wnF3S49Fh17/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6zrAHSkAdT+P76qj138a9tpe/upVo9oCvStvNG/CluMaCTMbvwSKDpbIwWGnHKE6f0GXqxJEaDcK9jsVDrRzc+A5D/0PFgR3+/ndS8tREtcOyEZQA7WhvkiqEMnIyxLBHl+LmJksqjBexGXD7k7NrpPWW6DDdj6+oJlg0RagdYDcDsWB7jxi0Io5aTFEknHdEA91mHiEsS/QHvvvvc6VuN8r2xdpK3b9zbFKJp+1pZkGpYjJYoGhdDWv9XlcBfqa5PGpnHH7KvPFazI8L8SZLa/FsxF64k2ssDLh5e0213IUxsB0qZYGADz5pThmOBjgxwOE8gJ3aHJe7MPsTrZ4g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ou/S6YD3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ou/S6YD3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gms7h6CBfz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 20:18:07 +1000 (AEST)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-30bca8ef052so51054eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 03:18:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782469084; cv=none;
        d=google.com; s=arc-20260327;
        b=Q3A9zHJR0dxcCmNMPcu+Cmvw6W9K4exML45s+YOkGbLd94YE+hbhVUnpMnyf3CO2rY
         jMqMFtnRnYgcTb0E/xn10QsJnrTrd5UxSY95lTHbg92r9GQLngiLWKW4/UvRyeUCsL1n
         PQ+y1J7Pv3NUCfCq56DSVmd7dh+hMGVyCqD1hjw/SftoM6X3QHMkHNL0nJdsxjmndfTF
         0nUPNP03Qi8lpTd0cqEXit1oOzH5p6GN1+n+MoQWgzttYafEnY+qv/+8ahytHmzzfj29
         AdVItmIMolSDwPpW80Cvrp6MtKjd9b9kqyI4tveSwM5p9F9ZgGEZQD8jiNLB9/1JDqnS
         TTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OwEemPqInwbSVk9dzdDs5pHQn5Viy4wnF3S49Fh17/k=;
        fh=YFQCFHXy4odPUBqQTAa8hRn54AZbTghI3mQ2PJOG0co=;
        b=bzG9lLuaHLcQxC6A7yo5SLsDwR1wawIrFnDkw3X5deZXwx31RaT8MgeT/ILoo0Y9TL
         JYzyt5TTth6ezAUqYU4IzgwT4as2rZ+4gIrbXzQiGDN7j42cWsDSMZpD0ZWj03et5xJG
         gGAsnNLZRjNKN4s51d6Jb62OsD9qSll4Vel1hTxevEX46kORXj2vg/loZ+0ZR4TpFGxU
         vKGfod8oiz1NmDMn8TAhVfUU3ML2MEnWN0b/YESmeqf9W/hLKsPqoipAz6og/3LoiZs8
         9/H/PJgnjmEA7vfGTBekk3qMtSDiXLiCFQML2ji1LSbi8C9wI/mC5/ZshOXIDTC+UDd2
         wfWg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782469084; x=1783073884; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OwEemPqInwbSVk9dzdDs5pHQn5Viy4wnF3S49Fh17/k=;
        b=ou/S6YD31w6VpITtsjRGhtNxcUKqfkTlzX4CDdCEPxKlBcjoTzezkk02fM3qBxj995
         k5+kwaiB6V4r34oS/l3FCQenbUTnITsFMA4cFcpwgjVHlVyMxij468joguBJAe3dMysj
         ihwhxSqKD0oafE3KvV9GW0Td5KnEaT8lZ/SHiO/IPnGe3pvzr9mRzixlRvTiVmRbqgPh
         IVXgR2UeeIhFpQ14exWFOa4zvzok7HqGYoc5UdC7FMkaXWu0bKw49LjJeaoRHhlCEaaV
         5tMsKFCW3JC/PH0oxtJeaWIzuPj18UYgWg4k5OSTMDPNdQL163QKRScDr9ghStb3Pp46
         jNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782469084; x=1783073884;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OwEemPqInwbSVk9dzdDs5pHQn5Viy4wnF3S49Fh17/k=;
        b=gjQbWSrFcZRUJ9w7bPkmD4JGkT8sWg21mj6Mqgq/WTrimMkn09Yj2L93A5zcFUMYh2
         sLj1TpSIA1g2d7Kq+GeFKOY6qHgFW/XaGivAiTc7465YtmhLHZiPCW0rhd9DGC1jjWXG
         gW1zPfqZ8x3coJajcz0mjaIrTrWbUzShoNJPircIokVmdNKsE5SZrsyJE4HjCr26vfL9
         0dangvOgcefoNAdGuSmlN1lYihJPG6tP9W8WpmJdxrVcmCY4vGs2Nci0w3NoyJMH4rit
         Z2+IoKlclwIDoWzxtN7J5Yla1MpIuJXHXFLXOpayxT+LDmBefeOcThlr5iQ+J9X0swzn
         kyrw==
X-Forwarded-Encrypted: i=1; AHgh+RqGITXaujnywDE1+biK8xheggTwc2rv9jZLIyEHKZhKnQFVj3s5c1zlM1FGgHF5n4gr3oAp3v+gHL6A0+c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw/ST6ihQ3Kd3oAFnonXJnOiAQlySp+hLZDLhIdltKCpTCzTZiI
	KlD0zRyTEz70UxDGfcZf8tJU9K4U4+yxU15RFjCbbKZBtGqXvtdzatNfNB6URF7M0SU0SLX34tK
	jwKIlhxdoohrE92fgm/JAwdNrLT84QhU=
X-Gm-Gg: AfdE7ck1con6Qo0nfbnefEf56FmjLUsy7rHl4hwrY93a/EpVkBMRyz+Xi658rCA8Ue0
	V+ZOcHvfSXpYS4gQTY0z5v65uLthVU19JH03sCsSdJKR6tg3HlQZ57QkaMPO0grOpyQ6XSSRVr2
	rSYXyayX8vEFR/yQ7ecA7Oju19w9/1ioYydF5xFSG1QkfGdgJmK7nhdBKUTCXM0EPcao1YJuPOr
	lU30OCeZTsrJ2AtsGk971hcSZ2pfGbowJgtCLRdOmHiTNMKmxrfIiLG+Fz4KdVNetvsiawkHHmm
	CMFa19T45Fdl2cINzuSDpfliaM9D1Qm3+oh7XR2sPvslEWVz8zpCMYs11WaU5SeM/DYz12qpayR
	KEcFJEBkNZsQ9
X-Received: by 2002:a05:7300:e6c6:b0:2d5:9438:2a02 with SMTP id
 5a478bee46e88-30c84ad9f55mr3026758eec.1.1782469084327; Fri, 26 Jun 2026
 03:18:04 -0700 (PDT)
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
References: <20260520064630.1785283-1-mkchauras@gmail.com> <20260520064630.1785283-5-mkchauras@gmail.com>
 <CANiq72nPOMkZXpMpwTLFg4xjFfmyf_O_x2FN_nrNBsxeNu178Q@mail.gmail.com>
 <ahVb4k-2rC4EYZF9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com> <aj4gAdy2siBxONpo@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <aj4gAdy2siBxONpo@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 26 Jun 2026 12:17:50 +0200
X-Gm-Features: AVVi8Ccrx0kRQsHQymdfhdPBE1X5e4EB1kia4xesGjoItezYgW-_bvi72bKccEY
Message-ID: <CANiq72=EVsTFkQK3LWrT2Gs5UKKViemGkv1WuitY6NOEtvcsNg@mail.gmail.com>
Subject: Re: [PATCH V16 4/7] rust/powerpc: Set min rustc version for powerpc
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	daniel.almeida@collabora.com, acourbot@nvidia.com, fujita.tomonori@gmail.com, 
	gregkh@linuxfoundation.org, prafulrai522@gmail.com, tamird@kernel.org, 
	kees@kernel.org, lyude@redhat.com, airlied@gmail.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 8:50=E2=80=AFAM Mukesh Kumar Chaurasiya
<mkchauras@gmail.com> wrote:
>
> This corresponds to a floating point instruction. Although we have
> disabled fpu, vsx and altivec we are still generating these. Seems like
> we have some issue with the rustc here. I didn't dive deeper into this.
>
> Is it ok if we keep 1.95 as base for powerpc64le?

It may be that it is generated but unused (we have that issue
elsewhere -- see e.g. `rust/compiler_builtins.rs`).

Having said that, if 1.95 is fine for the powerpc arch maintainers,
then that is fine (s390 also used a higher minimum -- please see the
recent change in `scripts/min-tool-version.sh`).

But please try to bisect upstream Rust to see where the change
happened, i.e. what is the root cause? e.g. `core` changes, `rustc`
changes, built-in LLVM changes... It could be that it is not tied to
the `rustc` version but LLVM's.

Cheers,
Miguel

