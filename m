Return-Path: <linuxppc-dev+bounces-5667-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D823CC02192
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jan 2025 07:11:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjYGf1bxvz30Qk;
	Wed, 29 Jan 2025 18:11:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=150.107.74.76
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738134666;
	cv=none; b=nx2fW7EhdcBQC576EswRvvMfM5lbZozvCXrmFUA5EiPNth10fE76LvxgX5BSwJqhM1un6ti0xDYcobbWyYt9V0bvBwDMeRLtEuwkvntBc5e74fO5+wDDvSp171knEfmLu0t3duR1yKUhkIIQi7tbp+MikFCeVWtXrprn9HksJdvRoVBpTnPx94byqdKow93nlp83IsLkR+dvLXzVxKrIEB5eR61UC2Thnk88EpbGFv0qrNiZd9MUxN5SMQb6w4WfazhoNkuwXe2Z8RMlQ5bIpt+4Cnyn0orryJ+puvOHe9xtlRTJDCrJMKi21VEsI3b6daBCZpriu6Gr3PsN9IcMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738134666; c=relaxed/relaxed;
	bh=yQp8tzvJAvFI7oQUW9G1q/LtR49ML/hxaxjGeG0zqk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U839ynEm1EnbyGo4Z5/RK88jQVvz5LrvnZgTesdlEOJvuFRpGXHLJgqPvg8WIaEGHyT6banA7d9H2e7EgdefsvV1uBFHkKNvFtAxIw2iSWq9FuUb01U+x1T6fbbZMXXfKwKuwguZoxKDDjIufyDvsKvg4VkB28NNBnYcpIERwcJG6BbY5ra2BQ9govoDi8916f/Hfcmy3iGPoLav6IYS0CzJD/UvxvUH5krWymUq1WCWUq+/j0NrG6Rvd2fUxbeoEoI+oY9t9YX+u09IZ++eMenWLE05wvs26X33+suAK3boYWRzzfqJ7RnPb2/1Gkg0TEpL7I5kgmATYsBo5AplhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=WbWchTRp; dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=WbWchTRp;
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YjYGY1DVSz30LS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2025 18:11:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1738134651;
	bh=yQp8tzvJAvFI7oQUW9G1q/LtR49ML/hxaxjGeG0zqk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbWchTRpXfAXOXSh2r5vm0f3DbbJA82ywJEuA6v6kpEJ/4pRwVEYaO6Tzjz5zhgmS
	 4MhSWphctXTu2a+AG7oW5LERUsw2QB2VDyjwrm91OMyJKv0k4LP17eim2ts2sv+edl
	 U5VnbpLnz2PGcJsD/f4mWFaFr9DaNeLhVl0JkCxiczh1QMcBYNm8WHFqC4qRV2OC91
	 nwXJy2bm5Mm7I+/762Q6+3lU5GOiU0PNj6OTwZFoKQBrRHFcnTggHzESR9CPA7CxbS
	 TGtSe9BsZt7obCHY08Kg63V6awDrehxW+LS73RLWZobVfvVdAbxHL4rBhE9HfxxjAD
	 aiGOCkvpqc3TQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
	id 4YjYGM27Nnz4wgp; Wed, 29 Jan 2025 18:10:51 +1100 (AEDT)
Date: Wed, 29 Jan 2025 18:10:43 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/5] powerpc: Define config option for processors without
 broadcast TLBIE
Message-ID: <Z5nUc54yZDqGqr0P@thinks.paulus.ozlabs.org>
References: <Z5lfDb8wsLlmSLBZ@thinks.paulus.ozlabs.org>
 <Z5lf-OrrbRe5Q0O-@thinks.paulus.ozlabs.org>
 <D7EC3ZZ2E3YY.5ALSOA646CK4@gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7EC3ZZ2E3YY.5ALSOA646CK4@gmail.com>

On Wed, Jan 29, 2025 at 04:14:25PM +1000, Nicholas Piggin wrote:
> On Wed Jan 29, 2025 at 8:53 AM AEST, Paul Mackerras wrote:
> > Power ISA v3.1 implementations in the Linux Compliancy Subset and
> > lower are not required to implement broadcast TLBIE, and in fact
> > Microwatt doesn't.  To avoid the need to specify "disable_tlbie" on
> > the kernel command line on SMP Microwatt systems, this defines a
> > config option that asserts that broadcast TLBIE should never be used
> > (the kernel will instead use IPIs to trigger local TLBIEs on other
> > CPUs when required).
> >
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > ---
> >  arch/powerpc/mm/book3s64/pgtable.c       | 10 ++++++++--
> >  arch/powerpc/platforms/Kconfig.cputype   | 12 ++++++++++++
> >  arch/powerpc/platforms/microwatt/Kconfig |  1 +
> >  3 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> > index 374542528080..14ee96e2a581 100644
> > --- a/arch/powerpc/mm/book3s64/pgtable.c
> > +++ b/arch/powerpc/mm/book3s64/pgtable.c
> > @@ -588,10 +588,16 @@ int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
> >  }
> >  #endif
> >  
> > +#ifndef CONFIG_PPC_RADIX_NO_BROADCAST_TLBIE
> 
> Hate to bikeshed, but would it be annoying to make this an affirmative
> option?

I guess we'd have to make all the platforms that do have broadcast
tlbie (and a book3s-64 MMU with radix) select that option.  Which
would be powernv and pseries, I would think.  If that's correct then
it's probably not too annoying.  Should I do that in v2?

Paul.

