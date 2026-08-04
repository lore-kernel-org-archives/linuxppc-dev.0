Return-Path: <linuxppc-dev+bounces-25368-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AD9C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 12:43:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDtWD0B4Nz2yLY;
	Tue, 04 Aug 2026 22:43:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785847399;
	cv=none; b=eYmNfrRdkvcpIg2Q6NJeBkdMU3yXDYNGNUf1jpzfB9XHeaz8k/24rVs0SPAS0D3mOfbBgPjCQiacHCIU4OnR2DiaYCoo+5zOEWllO5aJDlqIi91QI0j2oLIBsDwxqFbhRaY8x+kdGr2lfjhhRTP6J+7SZCH8e7kqdAHIf/MaPlTFl22BunZgPxrh4jD2VQLi28Z55HWjuWVbQ42cmWuxbxFSFKToB9YCr2cuknBKT+XeDKFeCpOjByrOCr+oBXTNQekstUiox3OytkaPqpwnmtPh0fsvjCJrn5WAVckpuNx3Ri14aj0bdKEv4KPy+TWqu/5PmG645gtsmYTZ9mkEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785847399; c=relaxed/relaxed;
	bh=84QprRHwhrz+Nkiqha49/PA9CxYa6FBg6w6noEz86g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAZI4NDobGp4sd+XxNyYkYWh9mdC2ou6LgRHscAPoLh68goK+K57pI5t5INPEegCkLt6vh7IQ46vMUhgh2k56YTQ7cjwerkt3lAEgikY8AuXrJEBd+qjBGWa0LDq27FqIIF5OapI2TbXe02bFUpg9a9aVC2InQeHfjyBGwtD+HdnsDzuXtQsyn5/HrKWLUQj2vl907w6GEIam8kJKhV/XO9tWb1RQtBJPmGnhgevmYIcdxHpp2DOhKlv/CQiOmOs8CBP/gYFs60fifItReNx26LBTVUlxRHmErnDnFMg1e8i/E8/AzO6xQLV8IrH+jp2L8COihyuwfRJ5Xu9wTWANw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWOdWAkR; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWOdWAkR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDtWB3wLGz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 22:43:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B2F5441B35;
	Tue,  4 Aug 2026 12:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F3F1F000E9;
	Tue,  4 Aug 2026 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785847393;
	bh=84QprRHwhrz+Nkiqha49/PA9CxYa6FBg6w6noEz86g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UWOdWAkRkJHZkJxmRSHFZYlpGkORiS1kGH2fYisI2uada2AxRE+GeYyHciAVPQr30
	 MNZd6q6kuVhstTX1GSsaMMzewptHToT1kUH0WuveZ7i5IRR9AZFh985L1e0HOxs32H
	 wXbHaoX6vi/rrkSLGy0movwuGO/cWJNMbN6vwTmSwcxFllPwoOqPNM4CgVKNryMIWa
	 OEW9DeHljNMC9Hvnie84zgLGzjIjuFDoip29CmY7iUbIDxnCzqtPygXPJBrUyyRV78
	 YpoweashigOAa2jiQFa9l0ujqRtV9rDaln9png6xRNUr3jCjFaCfpjuh2tbsAOeuHv
	 zbwT/VJNUydlA==
Date: Tue, 4 Aug 2026 13:42:51 +0100
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
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	John David Anglin <dave.anglin@bell.net>
Subject: Re: [PATCH v2 2/6] parisc: Drop own implementations for ptep_get()
 and ptep_test_and_clear_young()
Message-ID: <anHd7ho3daZFZ-4r@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-3-pfalcato@suse.de>
 <anHHyiHqYf3yLf2K@lucifer>
 <anHcJZYyz9Zrshdm@pedro-suse>
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
In-Reply-To: <anHcJZYyz9Zrshdm@pedro-suse>

On Tue, Aug 04, 2026 at 01:34:41PM +0100, Pedro Falcato wrote:
> On Tue, Aug 04, 2026 at 12:11:08PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Aug 03, 2026 at 05:43:56PM +0100, Pedro Falcato wrote:
> > > From: Helge Deller <deller@gmx.de>
> > >
> > > Switch to the generic implementations, which are identical.
> >
> > You sure do like succinct commit messages :)
>
> I didn't even write this one! See the From: :))

Lol well then feedback addressed to Helge ;)

>
> >
> > Maybe worth saying by dropping the __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG and
> > ptep_get defines you get the generic versions from include/pgtable.h which are
> > functionally identical.
> >
>
> I can touch it up though, if you insist.

Yeah, I'm being pedantic here it's not vital to have this change :) but be nice
if you could, I'm sure Helge probably wouldn't mind too much? :)

>
> > (Being pedantic, they're not quite strictly identical as the
> > ptep_test_and_clear_young() generic function does some weird unnecessary
> > indirection with a local variable and the single {} is dropped etc.)
> >
> > >
> > > Suggested-by: Usama Arif <usama.arif@linux.dev>
> > > Suggested-by: John David Anglin <dave.anglin@bell.net>
> > > Signed-off-by: Helge Deller <deller@gmx.de>
> > > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> >
> > Nits above notwithstanding, LGTM so:
> >
> > Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Thanks!
>
> --
> Pedro

--
Cheers, Lorenzo

