Return-Path: <linuxppc-dev+bounces-19983-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F558F9B5F3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 22:19:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1DCr2vR7z2xls;
	Thu, 23 Apr 2026 08:19:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776896360;
	cv=none; b=jrte5VY22zqI2QZVPUlo92w1CbJDuRiNgSpiUC0zG9+ABPWX7cVeec6yqOfWeCj2SC+oz5DJRe1Kv37aFF1ISxoQAdosvjWESR4fowUasxFZ6QwGrajgTqDN+lHcXAM2QyT+akVgZhmV4cOQGSjMolWmt+12WinTYEjKqecdunwvWULXUUGEz+XG4HvmQQmAGW+9YnxbfFb/ZxE1abohr+8SgLwTAwK8G7GHufAYKLhxte9bDfgcMSYyra3ujgCeEC6JFtiQKz+1Re/P08R3M8fYfeDPArB9pNWnKFIly1QYeU2p0URoBh7t+Ljl2BM3LLDgYkUrSUVGtTMvmrpRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776896360; c=relaxed/relaxed;
	bh=2AHoV66EKkqE7Fw5nwOFrbncWQLlebSbyNeoUJ8s4a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUgzRxUctBW6ZulSCyLoVje+owKMUiQAF3Td2DCAcqKl8tBtjdLXznF/CuRQ31/SWygAsu4F7kblJVkZW8KzGUYtiW/X1wbQWClLro8/gwEVvLDTzEPj/LZmyOG5WYoeNEnpGPExqKEEPN/4NT0DlbUNobvPsBrRnkPQewMPDjOiLpGh+vvxlFt20ehYxAOytGcRf2IUTermmVCWvnn8PKm2QBhYJtgX2EU0kF00f7qKKq+61A08xu/A89+iHv8TKV7xHpUTmZ+4nPZ3cxG+NjyRVrhOKkgS1802/s3xjy7qK8pdrcadEWjXaHcu1QqnUrD/n070DldRppn86lh35A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VND6/Q0x; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VND6/Q0x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1DCq2G4Cz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 08:19:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E468A44748
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 22:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0BAC2BCB3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 22:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776896356;
	bh=3WTHeSeyj1uSyMyVXTGvKd+qQIkqa8yvnPyPSQt84wc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VND6/Q0x5gKtDizHyEGZN6xhd/qs7aeqPuPlogPFoQW+oqwpYwC81C4HSrPayJETm
	 +G+OvyiThNx/l1518orVbtouSCS0TCMDM6gER1FnKlvDmuNdQQLQRsZ5rohnWscRxH
	 /Z/yuZe51Y1eBp1BPbsR1Sy6LGxuq56DMZCE+MLWnQBjw4gtsTf5f8RL9IQ6y/ZcmN
	 SvuQW6zW4huZWKxrWcX783gSkWGxbQ0S3KzC0C5bwTkqjq3Lo1NgB8UAb3Zhs58+Xq
	 5O3Y3rF7odsO+uA8XcPs5u1cg/tWw2Jw9x929tGfzDbi7DYE2B9j0J2iC/L4BebKFn
	 504VnpOkIZGaw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ba922426c5cso579995766b.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 15:19:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+0d+SFaJRVOBWLS/Rtp/JO+gUMcJaSsf0/361hYHp3/Y161Cj4AGgWzQiH5jdKZdnLcqzF+w15l96m+yw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywpe0UUaYMWygJaOjeL35QRSxm1pbPuVsYhJ8aQNLoBO2VBvQR1
	cbpaKvaauLan6haFv0VnPTuY5urZ+iAx5IwRF+IeCUnqhwXUrOxL9tvGupQKSBq5z6qdJukx5J2
	nXS+uO6D9uJs1ehpn0giHHJFTU5MB4Ao=
X-Received: by 2002:a17:907:cd09:b0:b9d:94af:10fc with SMTP id
 a640c23a62f3a-ba41afe9d6fmr1546883966b.25.1776896355511; Wed, 22 Apr 2026
 15:19:15 -0700 (PDT)
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
 <aegV3ELp20DlC5Ge@google.com> <aekrJrSRoclZoBo9@google.com>
 <aekw1S5Gdkyx8teC@google.com> <CAO9r8zPhxn9dUKoXwM2JHF4TwG+PeTd8GhDO_kqG+kuwRW1g=g@mail.gmail.com>
 <aelI9_CAcZjGXj7v@google.com>
In-Reply-To: <aelI9_CAcZjGXj7v@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 22 Apr 2026 15:19:04 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO1p6tvT3BYaU+XvcqEBu-Dga=Ew_qvgzHk_q8P7fjyTQ@mail.gmail.com>
X-Gm-Features: AQROBzC0p0NpkLDMwb7vpD2dftYRsH_jFUFOETXLw6fnxs8RoojZv-m7XcDuopk
Message-ID: <CAO9r8zO1p6tvT3BYaU+XvcqEBu-Dga=Ew_qvgzHk_q8P7fjyTQ@mail.gmail.com>
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

On Wed, Apr 22, 2026 at 3:17=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Apr 22, 2026, Yosry Ahmed wrote:
> > On Wed, Apr 22, 2026 at 1:34=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Wed, Apr 22, 2026, Yosry Ahmed wrote:
> > > > > > Perhaps we just need to rename the functions (e.g.
> > > > > > kvm_vcpu_map_page()), or more intrusively pass in a size and do=
 bounds
> > > > > > checking.
> > > > >
> > > > > Definitely the latter.  Or both I guess, but probably just the la=
tter.
> > > >
> > > > I think both. I think renaming to kvm_vcpu_map_page() (and similar =
for
> > > > others) would further clarify things, especially with the introduct=
ion
> > > > of kvm_vcpu_map_ptr() below.
> > >
> > > I don't like "page" it's too easy to incorrectly assume "page" means =
"struct page".
> > > There are KVM APIs that do use "page" generically, e.g. kvm_read_gues=
t_page(),
> > > but for this particular case I'd like to stay away from "page; there'=
s a _lot_
> > > of ugly history around mapping "struct page" vs. "other" memory in KV=
M.
> >
> > Maybe kvm_vcpu_map_guest_page()? or if you reaaaally wanna be clear
> > about it kvm_vcpu_map_page_sized_chunk_of_guest_memory() :P
>
> And rename all the extensions to .java while we're at it.

Lovely.

> I can live with kvm_vcpu_map_guest_page().  kvm_vcpu_map_ptr() becomes a =
bit
> odd, but kvm_vcpu_map_guest_ptr() is even worse.

FWIW I still think kvm_vcpu_map_page() and kvm_vcpu_map_ptr() are the
best options. kvm_vcpu_map_guest_page() and kvm_vcpu_map_ptr() are
also fine imo.

