Return-Path: <linuxppc-dev+bounces-19981-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD090F94CC1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 21:44:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1CS90h1Qz2yv1;
	Thu, 23 Apr 2026 07:44:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776894297;
	cv=none; b=Lq2cEfC0mfOHnPtTMTuUBghdJWTqYUvgJxSceaHphsoGffL5Ljkox4v8W7Zw+f0M06GSHXV4+0YIR0QStZ7P9dZBKWLY2/3tBGV8zNf7pILeBzFmD+YP3n8OyDWMrpeL0M6dyeI+lcm5LZiLkk8u9QEkyzvBWX1uH9tNK/6TcVN4eFAZcntTy5NkNwGD7UiGamnXVbWuejuek6Rmw39Ww424y8xy73IZ9O7BJc1ZR84So+EXExK4vCYJiWxtktnzRg03RrfylnSkiD8GzXFRRugaVrRP+AWqzVB7dQNJ/UP2UmSpEIpzO4Tq/E+u+Bwjn80V1tvbMXMwX6hK/ZUGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776894297; c=relaxed/relaxed;
	bh=IALx1m8qyqKrGikW0Tzjst8D14JkPu800L1K3GgQjRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDNux39swF27eCeSWuVtFUl9WwZvlNilW6FTH6KUY9LL1H591WmoZzO4erbuTfRmyuWDhHCDyiwVPYoAacJln6NNSbm5YWxM9mU0ocviJZYUl7VmFBBDOOvhP6KhaG0oWWCS3Tti3yb4PsAKeVv/xG79GWtaDGPScYUvkmx1xiwKez3u1VBt7BCmAB+ZIMHo3WQagNmUrOdEU0maKua0AWvjD2cIZsUEHLF/5OVjOC5EI8J2XTT0oqQMKSY9LSkdKJdy5mrJ/j48lk9wQyyZtrdcqnYVt12WL4xHsX2kpipFGrgYHVWreKMzYWfwiTvHOfJ8xMZ5zI08KAKWyQR0Bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AOP6RuAC; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AOP6RuAC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1CS81RVCz2ytV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 07:44:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8FC846186B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 21:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E593C4AF0C
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 21:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776894293;
	bh=tHYNhcrXG1XEwoPAwoxoq/s4pgG+IT1N0bFfoOKoqYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AOP6RuACIcZPxmkODQRmn51eVuQsVRiEJcut386x6NOsrYmiHyskQl7Jq0zUUVP07
	 06TVvhaDrdL3tQil/TDZ27cGazRldtqJSmPPRZtgM7Qng8r34cU4wDgxZTRcJqKgRs
	 9WIZi6IOsyL9WAPsPmRFVfQzx5PDX2the7vuheOaqgNahXmQgi1RAONrqWwbGeiV1H
	 1Mwr3R/hGjqWg/VbH8AceVNSSuekskl0bu8sWEPAM2IPh5uXeT2rMBF41cfArSOkQa
	 yV4MbHRy57U/hvGYhFxF+vyBZM6/R3teZaDh2zGTdixZLlDF19XlSwKqYdyVbIpYAb
	 +TieqYwxquvsQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9d9971d059so879204666b.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 14:44:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+NTW5Pz117v0kojdiJ7V6+54T606T+wFvEzqOGNgMwHWeKyXK+GOst5fIwfHqOuMgy9NrhIgGKHfSvLds=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwhC/t/T+76NCPUVSOzG9bBZwPt56+ZVu77jTNAmF3b/RL+bjOC
	pScgBV98D9TCPC3ZTObbqb+SCCB/t32GP+8sy9VLR+CVQBlUIKCnrmFwRTm0X8AcyjsTT4ePkKi
	oVxrOfasPHtgd5R+MxIYzNQ5YjtM5dX8=
X-Received: by 2002:a17:907:6091:b0:bab:7f2b:c5d1 with SMTP id
 a640c23a62f3a-bab7f2bc736mr177582266b.9.1776894291977; Wed, 22 Apr 2026
 14:44:51 -0700 (PDT)
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
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com> <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com> <aegIPGYPH-nxGsua@google.com>
 <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
 <aegV3ELp20DlC5Ge@google.com> <aekrJrSRoclZoBo9@google.com> <aekw1S5Gdkyx8teC@google.com>
In-Reply-To: <aekw1S5Gdkyx8teC@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 22 Apr 2026 14:44:38 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPhxn9dUKoXwM2JHF4TwG+PeTd8GhDO_kqG+kuwRW1g=g@mail.gmail.com>
X-Gm-Features: AQROBzCKceysO9ivAzqon0z-yXd-OerC3R6DcybrV6wprQiol2CvCARtsqKQBy4
Message-ID: <CAO9r8zPhxn9dUKoXwM2JHF4TwG+PeTd8GhDO_kqG+kuwRW1g=g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 1:34=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Apr 22, 2026, Yosry Ahmed wrote:
> > > > Perhaps we just need to rename the functions (e.g.
> > > > kvm_vcpu_map_page()), or more intrusively pass in a size and do bou=
nds
> > > > checking.
> > >
> > > Definitely the latter.  Or both I guess, but probably just the latter=
.
> >
> > I think both. I think renaming to kvm_vcpu_map_page() (and similar for
> > others) would further clarify things, especially with the introduction
> > of kvm_vcpu_map_ptr() below.
>
> I don't like "page" it's too easy to incorrectly assume "page" means "str=
uct page".
> There are KVM APIs that do use "page" generically, e.g. kvm_read_guest_pa=
ge(),
> but for this particular case I'd like to stay away from "page; there's a =
_lot_
> of ugly history around mapping "struct page" vs. "other" memory in KVM.

Maybe kvm_vcpu_map_guest_page()? or if you reaaaally wanna be clear
about it kvm_vcpu_map_page_sized_chunk_of_guest_memory() :P

I don't feel strongly but I prefer we put "page" in there somewhere,
up to you :)

