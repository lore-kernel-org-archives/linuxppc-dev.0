Return-Path: <linuxppc-dev+bounces-25373-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67875C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 12:59:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDtsy5dgwz2yLY;
	Tue, 04 Aug 2026 22:59:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785848374;
	cv=none; b=g38jyht274PRIP/ngSoAgokKgriSnRnrzybKJN49AETgnrPlq41IFVyZMJJ/w3g/fz0HJ+xUP/FG1n5ZnkpAudgvhztx4Y1h98b6cYmzfa/fAG6AWJD41VtsN1UxCd7OFPT/ZhZF4a4CmPu8clAMqlJbfl95GzA/Dm60uTUsCYPs6OmcGGIl4XmXZMgzGF1U0Kf8dlmQXZAxJXsK6A86AgHt6q89MWUmmtIahtgEFh9MMi+x/6r84wifOBYwWHZB4s91cpNBXiA97zZsMACNdNxBBm3xZOW/udB33pNNkF+AOD3OozIB6ceHZdOScYVRN42dVEWjtngYLfF3FMXxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785848374; c=relaxed/relaxed;
	bh=rkEir9uFm1qRBCXp0zpCOeuLTQKL4glDCYZRatT+50Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj9qa65RzPPzQbblhINRlvODi00OXeWD5YN9CNh9t2glfZSYYHRnwx7to4ZTPRUF7QWsES41sewQbiyqblimSBI59T//cZ88rGMOFN+HnrojESIMd/ly/Kh9HZGJraJWg16XUmtdfR9UbnpA12WrVPGKN0t0/WascmtGn4XGrnZaOOX3F3yFN0RbPumDERMyihIyfdUGJK1ShAz/e23JULpffLabhf7AMfCQ/kXd1hr0APTGODZdX9YRm7K4hymxWrBnWmNeiEyikM36oUbbqIle638FkXu/movHYbAayZY5gLeF8vDApPgL1r9Gm6jBK9E9wXX3ytfvzf4znuKkUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVucjhvr; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVucjhvr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDtsx4M7Wz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 22:59:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2551A41FC2;
	Tue,  4 Aug 2026 12:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B111F000E9;
	Tue,  4 Aug 2026 12:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785848370;
	bh=rkEir9uFm1qRBCXp0zpCOeuLTQKL4glDCYZRatT+50Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gVucjhvrdbhER92eS5xBHqYeZpRRPk+DMQSNxJPje3bAw5/f6Is/Nlxg+QiKYxfyL
	 pGQoOaMN++o0pL9N4wS88gUthxS0LEzYZKJZYvjbiDx/YUuiHmFTpl65FF4Q9xwM0s
	 a3HI42iOihbi5kLSp3FDAlBecuXQkaSEbziibdWB2HI43ExYZ5VxAwgNzL8NLKy4/V
	 BvJA7uaB+cbSx42oZRA6c8/ULe0tqE31ITKSKG8p1/ldAswRXodrmvS/+E0is3fQsS
	 w6b9GFu80tahoLmlwJ3y8g26YTuFV2gojiLnnLp6U02LXioHwZLgPZzUCMN88kobJv
	 U6M2c8qhm7r5g==
Date: Tue, 4 Aug 2026 13:59:08 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, 
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
Message-ID: <anHgw2Z-d-OQk9qs@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-4-pfalcato@suse.de>
 <anHI4B-lMu6AJJfA@lucifer>
 <dcdb8cab-c18c-4995-ad1d-2f2d4700e7c1@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcdb8cab-c18c-4995-ad1d-2f2d4700e7c1@kernel.org>

On Tue, Aug 04, 2026 at 02:50:19PM +0200, Christophe Leroy (CS GROUP) wrote:
> Hi Lorenzo,
>
> Le 04/08/2026 à 13:13, Lorenzo Stoakes (ARM) a écrit :
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
> > >   arch/powerpc/include/asm/nohash/32/pte-8xx.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> > > index e2ea8ba9f8ca..f2bab31040c7 100644
> > > --- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> > > +++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> > > @@ -226,7 +226,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
> > >
> > >   #ifdef CONFIG_PPC_16K_PAGES
> > >   #define ptep_get ptep_get
> > > -static inline pte_t ptep_get(pte_t *ptep)
> > > +static inline pte_t ptep_get(const pte_t *ptep)
> > >   {
> > >   	pte_basic_t val = READ_ONCE(ptep->pte);
> > >   	pte_t pte = {val, val, val, val};
> >
> > Worth making these const too (that {val, val, val, val} horrifies me btw :)?
>
> Any suggestion welcome.

I'm being super nitty, all I mean is:

-   	pte_basic_t val = READ_ONCE(ptep->pte);
-  	pte_t pte = {val, val, val, val};
+   	const pte_basic_t val = READ_ONCE(ptep->pte);
+  	const pte_t pte = {val, val, val, val};

:)

>
> powerpc 8xx page table is independant on page size. When you use 16k pages,
> depending on the address you hit the page for the first time, the HW assist
> page table walk will fetch one of four 4k cells in page table that need to
> be identical as they all four define the same 16k page. Not sure I'm clear.

No that's clear, thanks!

(I say 'horrifying' because I am looking into RCU page table freeing which this
may complicate, though perhaps not in practice, to be continued :)

>
> Christophe
>

--
Cheers, Lorenzo

