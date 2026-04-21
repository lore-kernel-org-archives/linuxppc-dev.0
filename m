Return-Path: <linuxppc-dev+bounces-19921-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1E1F94CB8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 23:41:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0f5R6l4Bz2xSG;
	Wed, 22 Apr 2026 09:41:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776814907;
	cv=none; b=hIIEIy0fqoeHMRwq0lqvNgCiGoTxvR6fB+IZpN0tUvD4AxjcicFbJ2eNuvFz0cv0ASA/qcSQlGVElp3aVDkBU5+YHm1vJCLn/1pZhSfB2UTZLNBAEWKwMcz35G1TlFY+oHvS5nsnyBx0IKoevsmTF0m7Vn6xr6rBnJpXBAWf4ldtLst0beQFtLrw4T8z5QM2NT4e6ThFRo+CZUL7AbJR4yfBC79aGCLdVc/2Ab9rRrBhBoKBpM46FLxz1OgXHwcgA57l9FoXtc4NO3zIJmD10LxhHM36p0aBeQ46LLRogEVU/hV6WanDeFNJeOyU+RGzZ0m93O5VGfBitufpAhZgog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776814907; c=relaxed/relaxed;
	bh=T8VZFCQkqCUfV/9MtyRCOWPoibtit4imxDGQVk5LknY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU5xNPvECdfXNaqBeDbtjAtF2Ld3tTwECeEWZhiC81/zLnc8yhJ8jaw5zxpIDM6GmTMHiOkcpRysj0uAC9+Lz7g5blC8aBv6xp0kmA5crsUFwWN2xCcg2c7HSBh0K6lVaZ1nAecnaFfyhYrFBLHLaA70WO7e8fJFbiDIrCC1h04nHLcbhTT8PPyCoWWfi8ye4zprdW9Qt7fmMumM1GYMRU1qEobgDFsCclA5gfpaym3ab4rupYwc//g3NGRiSibTa8i3LE1FnynKqEzO9Ai4SLFtzB+XPKT4xb7FxMMlQ4y8ZlwecHxACJTNwTrXwrSGoLtyJ+SbSRl2LiX+cxs2IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=chHtQVad; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=chHtQVad;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0f5R11J0z2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 09:41:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CEACB600CB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 23:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E94C2BCB9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776814904;
	bh=V8gY7U7FMdSdx1zKSaD45nVLoaT/83qo8hxPeKq/YSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=chHtQVad3EzPMgog7hxIzd+l2ieQEeEj1iJH0qjFpV3ivq6QjOBecoNhoPmYFtCgG
	 3h0bAawA5hpvrgjCrgL8LOvdMKxobNyKnOCYoaSgln6LF6k7KlBa5ybZ7sObJ8DsKt
	 6rra3i9koWqDODcYNlPOT2xkpdtAncqZvenepAHjg9OrhTKbTQSQhxCvq9LUo7GdPT
	 IZA57cE6CeD1B75s5lMPzRWtIFua2omZwXYiC/dssEfmI0L352LMlpLOlPBg/Q9r1T
	 eYBly1H6oMJvsEZBvwQwtcMK1/jjrgfC1KlKOJ8FZhdE7fGU667gHg8E2wpMXJjVnJ
	 f8RSdXplw/sSQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ba545100a13so168087366b.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 16:41:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+mKUUdHUh3uhguN4LuvxfESwC2M1vU0QzyoUyj2uNpUyNiBI0kXyJkl3+SA2D5FnE1pkf9f2zgVSq3UxM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwvZRkauL8/lAc4FU6U7doz0szaEySmFEDUqRXDJIpMA+zbAK6b
	0dSZYrptle20H8VKVHvRWsUHIVxgFAYzgNvNkOlZCd00zonhEd6B8fjyQXOGizWskPwbYRmu1d8
	oIvJC+pN0P1F2LDsYIadwGVmfMhbFJfY=
X-Received: by 2002:a17:907:3d8e:b0:ba7:4cd9:ca27 with SMTP id
 a640c23a62f3a-ba74cd9ef49mr592307866b.41.1776814903254; Tue, 21 Apr 2026
 16:41:43 -0700 (PDT)
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
In-Reply-To: <aegIPGYPH-nxGsua@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 21 Apr 2026 16:41:31 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
X-Gm-Features: AQROBzANd0h_q8XtUwKQrNkCW04xrdyRTc8bFj2qWgS95XTIw4zggBHJPj1Tje4
Message-ID: <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
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

On Tue, Apr 21, 2026 at 4:29=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Apr 21, 2026, Sean Christopherson wrote:
> > On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> > > On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> > > > Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() and
> > > > kvm_vcpu_map_readonly() so that they take a gpa_t directly, reducin=
g
> > > > boilerplate at call sites.
> > > >
> > > > __kvm_vcpu_map() still takes a gfn_t because guest page mapping is
> > > > fundamentally GFN-based.
> > > >
> > > > No functional change intended.
> > > >
> > > > Compile-tested on x86 and ppc, which are the current users of these
> > > > interfaces.
> > > >
> > > > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > > > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > > > ---
> > >
> > > I was going to suggest a WARN in kvm_vcpu_map() and
> > > kvm_vcpu_map_readonly() if the passed GPA is not page-aligned, but Se=
an
> > > usually hates my paranoid WARN suggestions.
> >
> > Heh, for good reason.  Adding such a WARN would be triggered by this co=
de:
> >
> >                 if (!kvm_vcpu_map(vcpu, vmcs12->posted_intr_desc_addr, =
map)) {
> >                         vmx->nested.pi_desc =3D
> >                                 (struct pi_desc *)(((void *)map->hva) +
> >                                 offset_in_page(vmcs12->posted_intr_desc=
_addr));
> >
> > The PI descriptor only needs to be 64-bit aligned, not page-aligned.
>
> To elaborate a bit, I'm all for adding WARNs in flows where something bad=
 is all
> but guaranteed to happen if an assumption is violated, or in APIs where t=
here's
> a history of goofs and/or subtlety in how the API behaves.
>
> What I'm against is adding WARNs because someone could write bad code in =
the
> future, or because KVM doesn't do XYZ at this time.  Such WARNs usualy ju=
st add
> noise, and can even be actively harmful.  E.g. in this case, ignoring the=
 PID
> usage, a reader might look at the WARN and think it's _wrong_ to map a pa=
ge in
> order to access a subset of the page, which is just not true.

Yeah I agree with most/all of your objections to my suggestions, it's
usually that I don't have enough context to understand how the WARN
could be harmful (like here), or am just being too paranoid or
defending against bad code as you mentioned. I was mentioning your
objections semi-sarcastically and intentionally bringing up the WARN
in case it's actually useful.

Taking a step back, what I really want to clarify and/or detect misuse
of, is that kvm_vcpu_map() will map exactly one page, the one that the
GPA lies in. For example, there's nothing protecting against the PID
address being the last byte of the page, in which case accessing all
of it would be wrong as it spans the mapped page boundary. This is
difficult to hit if you are passing in a GFN, as it's more obvious
that KVM is mapping one physical page.

Perhaps we just need to rename the functions (e.g.
kvm_vcpu_map_page()), or more intrusively pass in a size and do bounds
checking.

