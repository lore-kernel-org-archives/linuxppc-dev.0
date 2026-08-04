Return-Path: <linuxppc-dev+bounces-25375-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD1EC55822
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 13:04:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDtzK3X9nz2yLY;
	Tue, 04 Aug 2026 23:04:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785848653;
	cv=none; b=IK3RAKruSgIoYtYCfexg23EMSD0xaCQ3hDn+khu3a9XTXb/g1OPSGJKbmydSs5ez2fG/wCOCro/hpRsyx04NuhmycrZk8PBJAJ8fLBKdRUpx4qMldEmyWSt8oCcdf3jCSEO/NXIaXUH0EeK7fK4OWOBg0x8I8y5tryRX1+S2t76qJHE6wEkHblU4kSDYeRFfDGtCdYATFW8XU4OLp+SY/lHweiYmakDgSNaQGF1Uzk4LRx0VGXaE7uw4DpH80P0JGKXHiE61GH556lGMZO3tp5qpHL1fJIGBEudY/oaeVm2XsCig/0liGFajTOMio3PmwiTHMTvNUY53xjMoBRMylw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785848653; c=relaxed/relaxed;
	bh=7WVi0zd6LcUoDLabZYLULWttoR4Wlz1WJNokp6HKtFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBY3ha16Fb7WPxEaQGVpWy4NbNVkbg4c1+3SYyb4Av4or3zQZ1MuT17Gqwe6l0HX1EsLrdqvk3byPVorIsvaOIFooPsXVhtRQa3j3GpVKHJ2tQs+RgYfcCcD85LgEzp2v1ANRdyyHHQAmN9YQuhmFNmC3vvLi4z8b8u6G3g9b+Yz4M1/mtGfBkUSiyHHNFdNNLZ7YVeW6CEfd/PUrDzrrMFonQQtN0eoCYenjPRwYnelQLefDEC4W16nqHuVyFmNvLs5k8oGXNDj7JULNuBZOwebvRaEfNbLmf009z+rjUvZtmZPk3HjYelTQezLC2yrRuyf3vUJJuIEYwYXvmH0Jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZ8xZk5P; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZ8xZk5P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDtzH5xQMz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 23:04:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8BD1460A7E;
	Tue,  4 Aug 2026 13:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DAB1F00A3D;
	Tue,  4 Aug 2026 13:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785848649;
	bh=7WVi0zd6LcUoDLabZYLULWttoR4Wlz1WJNokp6HKtFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aZ8xZk5PzuGz/b2moWBb4VVtz0n3Ung2XSO7gIhRagGOIZjNIMkuzHy6jFMeVHTWF
	 nA1BvJi/iE2VrsC4XD17lCgxplfi63Afoif31Yj2W0EGlxUQiKtKFRwnI+14Z77Zm/
	 wyREeQLepUuHknwIHKHs5MtSxkyB6+MmQecXZ+aqfDSvp48OtiFS+A/zUg63hoVMix
	 vyCQNYITywtcPJ3HpjO2neSJHyvnHkv687QC8xcOOIa/gki5DxBEwggQe/7XGb0akN
	 nzWsq0j8rO5RTc990ehdmT0keE1zCMZ4cmTlxK1aOc4jA6KVyjsh2uKeL8OyzltUDm
	 Jyzl0tvAyFYNw==
Date: Tue, 4 Aug 2026 14:03:47 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	John David Anglin <dave.anglin@bell.net>
Subject: Re: [PATCH v2 2/6] parisc: Drop own implementations for ptep_get()
 and ptep_test_and_clear_young()
Message-ID: <anHi9n3_8bLjAsxy@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-3-pfalcato@suse.de>
 <anHHyiHqYf3yLf2K@lucifer>
 <anHcJZYyz9Zrshdm@pedro-suse>
 <anHd7ho3daZFZ-4r@lucifer>
 <e7ac6f83-72ff-43c0-b67b-6b17caed995e@gmx.de>
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
In-Reply-To: <e7ac6f83-72ff-43c0-b67b-6b17caed995e@gmx.de>

On Tue, Aug 04, 2026 at 03:00:43PM +0200, Helge Deller wrote:
> On 8/4/26 14:42, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Aug 04, 2026 at 01:34:41PM +0100, Pedro Falcato wrote:
> > > On Tue, Aug 04, 2026 at 12:11:08PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > > On Mon, Aug 03, 2026 at 05:43:56PM +0100, Pedro Falcato wrote:
> > > > > From: Helge Deller <deller@gmx.de>
> > > > >
> > > > > Switch to the generic implementations, which are identical.
> > > >
> > > > You sure do like succinct commit messages :)
> > >
> > > I didn't even write this one! See the From: :))
> >
> > Lol well then feedback addressed to Helge ;)
>
> Noted :-)
>
> > > > Maybe worth saying by dropping the __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG and
> > > > ptep_get defines you get the generic versions from include/pgtable.h which are
> > > > functionally identical.
>
> Isn't that basically the same as:
> "Switch to the generic implementations, which are identical."
> ;-)

I am being _exceedingly_, possibly outrageously pedantic here :>)

>
> > > I can touch it up though, if you insist.
> >
> > Yeah, I'm being pedantic here it's not vital to have this change :) but be nice
> > if you could, I'm sure Helge probably wouldn't mind too much? :)
>
> Yes, I'm fine with any cleanup/rephrasing of the commit message.

Thanks :)

> Thanks!
> Helge
>
> > > > (Being pedantic, they're not quite strictly identical as the
> > > > ptep_test_and_clear_young() generic function does some weird unnecessary
> > > > indirection with a local variable and the single {} is dropped etc.)

--
Cheers, Lorenzo

