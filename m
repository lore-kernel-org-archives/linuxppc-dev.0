Return-Path: <linuxppc-dev+bounces-25369-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FE6C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 12:44:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDtXF1hxtz2yLY;
	Tue, 04 Aug 2026 22:44:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785847453;
	cv=none; b=iLIF+5Y9G2rmRxHI68cfAY2H+igGUPm7/IjqsLGdighROnEnn/2yKHejIuEoRQOndArS4WVGcxQmNmTvhGQJn6RKWWrgE5/OVZ3PdbmaER+l20cjWvvxJUAVNaUoq+YJnT2Mn/imFRpgbZvbo5OS68sfkeyiCOS7CdHIkLo1XNqyU8gd4/vQ9aQusPXSGfApCHgBO9X9bcHYWrvnsXTOonbCt81wCqGaWKUUjoja74st1joY0mTCk0V2OUnhWqQlEjbMaBSN0G3sZS15E8oT6r+Y+eTAhkPf7f4L1iOb2OW4V7LSfOFriIBih+BLrvnXX0FFs9mQ7csInmcYnnEXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785847453; c=relaxed/relaxed;
	bh=GKB4l2IZdbP/Q0kXwbUuYXowkK37syxnhhgXnRPRqN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozz+65Do+OLqy/3EGoTfDLAZ8VPdV30Oay1fnRpUKo3wnoq0a8NWWK6dnHttZ8I5bRnxma5k7dbEgrQWSpCy3AvX3CauRn0/SUP4ks8/xYkgZcLarDqqnoFEFJrGHuyv1kiOfrME9pLpRS1S6HY4lt5pGNGoVQhBKtJkDiPYCds+2EfoURmHLW5OFQuN1PWnnT1kb5enRG7bkTDESshz9S8Tb1iDOLy6m6VN7O4iB9iNhfp7Oc5Utizsynebdn4RShGtzjMe1FXLJlrjdyyzsITbNYJHiAlpTf2MCo2ykfDVyp1eB18Buug6uF/ymfZmlfnoMAZ51OyH9yRtNHKLMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+v+kmdg; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+v+kmdg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDtXC0w9bz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 22:44:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E3D9543A4A;
	Tue,  4 Aug 2026 12:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034D81F000E9;
	Tue,  4 Aug 2026 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785847447;
	bh=GKB4l2IZdbP/Q0kXwbUuYXowkK37syxnhhgXnRPRqN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T+v+kmdgCi3T4UxR1mhAPlH3L3GeQtz+35K3qNK/vTqxJ2yOhaKoAVspBfOMxLtsn
	 FIWPLNKujn5Olk6Z1+BnoEkDpCRSlRtCDxuydX1h9GeE6Eo2MOGwzDqGMneFaBwi/s
	 k1oHBA1ZQ6LyPgdPLKQitX4rEDVnEILfBvI9RX+oJ2Ihm42LEJmI4EzjPJ+9HlvHfA
	 kAMfGranFVW0VA+QEd5XUJV+yYuDvEayQq7xHv1OcCe6lMi7yMbcz8Nt00EWijb0Sc
	 z41BRatoKPG4RoVOTuLaS2r3qLW8wT6a0YEEg0Aik0zKahizkE1Pp51jHOmksup38v
	 HLAh1qHJ/KsIQ==
Date: Tue, 4 Aug 2026 13:43:45 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] mm/powerpc/8xx: constify ptep_get() argument
Message-ID: <anHeZx6Gg7waNWjL@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-4-pfalcato@suse.de>
 <anHI4B-lMu6AJJfA@lucifer>
 <anHc4aUbwxWx9YJF@pedro-suse>
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
In-Reply-To: <anHc4aUbwxWx9YJF@pedro-suse>

On Tue, Aug 04, 2026 at 01:38:52PM +0100, Pedro Falcato wrote:
> On Tue, Aug 04, 2026 at 12:13:13PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Aug 03, 2026 at 05:43:57PM +0100, Pedro Falcato wrote:
> > > There is no need for write access to the PTE.
> > >
> > > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> >
> > With below addressed LGTM so:
> >
> > Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > > ---
> > >  arch/powerpc/include/asm/nohash/32/pte-8xx.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> > > index e2ea8ba9f8ca..f2bab31040c7 100644
> > > --- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> > > +++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> > > @@ -226,7 +226,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
> > >
> > >  #ifdef CONFIG_PPC_16K_PAGES
> > >  #define ptep_get ptep_get
> > > -static inline pte_t ptep_get(pte_t *ptep)
> > > +static inline pte_t ptep_get(const pte_t *ptep)
> > >  {
> > >  	pte_basic_t val = READ_ONCE(ptep->pte);
> > >  	pte_t pte = {val, val, val, val};
> >
> > Worth making these const too (that {val, val, val, val} horrifies me btw :)?
>
> This is PPC code, so I don't know if they have any particular opinion here,
> but I could definitely do this.
>
> (FWIW, it seems we're more aggressive in MM in doing this than other places
> in the kernel?)

I mean I can't see why there'd be any objection given you're already const-ing
here :)

>
> --
> Pedro

--
Cheers, Lorenzo

