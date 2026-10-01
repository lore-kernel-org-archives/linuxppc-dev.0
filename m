Return-Path: <linuxppc-dev+bounces-28665-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8649CCA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 15:56:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwc356zX2z30DY;
	Fri, 02 Oct 2026 01:56:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790870177;
	cv=none; b=mzxgDoafHwjs6FPyIIXVBI4st/DbVee/PJ/bHda8GeaOCBv8NFCKxerXdkvsIYKS33nFOhosHkWDXFEoOcRyzD6Kuu/WJsezFiP71+FXixIrDVNbfH2dFZwz8/+zyRoxsmXIDOYGU3/Tj2nOFhUtthoCM9pvgYyoS+yCAwpt0L/OVx8IWa/UiIuSHOheZORWZ2593yFkmp8NAXVwrKDTIkCaE+cqOnaB0vn1rUbueldnjqAa+VgM0XscaG1llA8P0VSU1A+jylPZFvJKYr3GLjHAcf9hjhEfvB72yKzhClkpQvL9bnEqloonQBzpw4B9kejqW7JQAjtZ3AnPDqghdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790870177; c=relaxed/relaxed;
	bh=mZXyBZOxPP9aVP1iLcONa2ADo5uyWcMjFEkbOU3Yh9w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9PO3TJIomu1z3tbbmjBTM+NqlKUy/oCpTmJRkH9GAw8Kp48KE8qnr0Y1hebWCttonyCy0ir9x1H0RYYqt/a6vGqdgZmwPydSolvDamvN/K0goOibF7mxPFzIuUgSV5SDuV4bJNcS8TVzmTpEKhi/Vn5nV98XJNSvPKacwN1m9A8QQDLrkyGZWCX3AzCLflt4OLfEGMaTwKXUZanqjymuDCeDIZT41XKZKh++/AzTE39dHvqfq3rzF6cEEcgQc2VwC4TUFXnAAEJ9uGOwhB8WRt3J0LAb3wURC6KNZXxJ2f0mBogi9YLCIoIiagkpfnyfYthT7PTTYqZWrpuk7vP/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GCIIjnfF; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:34::f; helo=mail-ej2-x0f.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GCIIjnfF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:34::f; helo=mail-ej2-x0f.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com [IPv6:2a00:1450:4864:34::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwc3509KRz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 01:56:16 +1000 (AEST)
Received: by mail-ej2-x0f.google.com with SMTP id a640c23a62f3a-c2e20bb4583so305324566b.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790870174; x=1791474974; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mZXyBZOxPP9aVP1iLcONa2ADo5uyWcMjFEkbOU3Yh9w=;
        b=GCIIjnfF8StmgVLR7NIgnjnaKbq7USmewZPMMsiUt9+dncUd3wpLTbVCffSulxECrR
         H3z0g8bleuUmh43aJA+MeF7lPqAEWbudGXF2S7Soj2MFKRNMHh8eeRkAVwXu7EBlRymk
         h0/c0B85lY3Zx8G7HmOqBjheTYDN5l3BISFdZVHZn8GXuTJlVMlixKog+z/TCZkkysqx
         dMOifjRSrtdJgGQP5/zPixXk73ZUYvyxkmROAcExc47wBbSLw/TakXERbKSRpEIExlpn
         so9M/VqXpBusx+UDLO56TORKsVKoUvYSD8BkJsGvP4yiPd1M3wuRW89TNzq7tmgXiZ90
         d7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790870174; x=1791474974;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mZXyBZOxPP9aVP1iLcONa2ADo5uyWcMjFEkbOU3Yh9w=;
        b=eO86bJA3QRFUft8RWvUYuSoQY9p52MZH12a1fZGR0ULenc8dHcKXeBXg7gZd77H5cl
         pdl18H0mgT6lguwpGElbCChx902KAs6JkYz2X6MVOpLPYVId1Ar0DxPH7XSKDmtrHKdI
         Ic6L+vY3OGQnEVXv5GLSbcVlrUsn8rJpSkp3z6UNnLAi8E6kGbp/c3h4LQZk9x5fkZPw
         73EKa72xLr7OE2B1XCQ3DClOdl9OWtz6ILsh8Bogyf0TCgx7O896N3e7usjv411ZHJYL
         VEfuLYz51+kdQNMShF3st5xCbv7QUjynV5h7akSt6QdiiAv+EOCfu5AsUZV9+F4fv1uA
         sh0g==
X-Forwarded-Encrypted: i=1; AKwUvBz+taLxAgTNWvJo2f3fCdi+rPxtDD8GPvEuhJyFKofmrVmjfs3xvwKXaoFBW3Ma1u2ejyeg8Ah4y8UzxH0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kMHdcbGKnWZTq5au4SCXcP0SWQMVNgIv6Sx3xTfkHWqZc82IpA
	j6iW0piwf6ur7L6eh7X7e1/fiktzjy4JoelMzyeFHlQjUa31dXQGVT1z
X-Gm-Gg: AYBFou3IzBtZNzl3un6O74BBq36Vdsw5qIiWZuCkG50HcQx1q8B3zG25XwCDEVcgAIA
	1B7HB51QldSQG8/rEeT0pgcR47WcAu8jwTMMwclYhmxtA/PFDB+qZUWwCvoHLxfJ51LlxEk5mwl
	MTrqeVhkF1RZB/5tr8GgHTGfBvvrVM3Hp0xnLsAqeZAXGs34ZOjvYau8HcPMDTbyfVT6Qa8PLnZ
	mEWWxcfoBpOGf3PnnJm4pelIJGFySoczkSKzwc5Hw5y/ckYy+QDTG1pNPrpG1FgOdHqlLhWswV7
	5/zfb+hZ5w/ii1aYXFEa/7hHkVFmSpkucaHgG3Vgsvr2rmMAahck7oiWeHjN8pgjtW7agDJf2bY
	T0RTHZYLSA4AibiMUga8iTGl9lZUdhnfJl6YlG8h4N1cYm37B8Gl9hvsKcqG0sg2y9izpOYqK5s
	Van0in12Npel3NqumR4vX154ISHcQPm1s0BrU=
X-Received: by 2002:a17:907:96a0:b0:c26:3566:5b47 with SMTP id a640c23a62f3a-c2e4ad55c07mr1700466b.12.1790870173588;
        Thu, 01 Oct 2026 08:56:13 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31d96628sm181851866b.62.2026.10.01.08.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:56:13 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 1 Oct 2026 17:56:10 +0200
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, akpm@linux-foundation.org,
	catalin.marinas@arm.com, linux-mm@kvack.org, will@kernel.org,
	Xueyuan.chen21@gmail.com, ajd@linux.ibm.com,
	anshuman.khandual@arm.com, baohua@kernel.org, chleroy@kernel.org,
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com,
	leo.yan@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	rppt@kernel.org, ryan.roberts@arm.com
Subject: Re: [PATCH v9 05/10] arm64/vmalloc: allow
 arch_vmap_pte_range_map_size() to batch multiple CONT_PTE
Message-ID: <ar6CmpPkwu1VgZ22@milan>
References: <20260923062832.479455-1-jiangwen6@xiaomi.com>
 <20260923062832.479455-6-jiangwen6@xiaomi.com>
 <ar0s14p8KPgmDKmR@milan>
 <CAHKocdEF3RE5FA+LPRf_E0ns02a5akvUDKvSDvERoyTryV1X6Q@mail.gmail.com>
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
In-Reply-To: <CAHKocdEF3RE5FA+LPRf_E0ns02a5akvUDKvSDvERoyTryV1X6Q@mail.gmail.com>

On Thu, Oct 01, 2026 at 03:55:44PM +0800, Wen Jiang wrote:
> On Wed, 30 Sept 2026 at 23:38, Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Wed, Sep 23, 2026 at 02:28:27PM +0800, Wen Jiang wrote:
> > > From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> > >
> > > Allow arch_vmap_pte_range_map_size to batch across multiple CONT_PTE
> > > blocks, reducing both PTE setup and TLB flush iterations.
> > >
> > > For CONT_PTE_SIZE-aligned ranges, return a mapping size that may cover
> > > multiple CONT_PTE blocks, capped below PMD_SIZE. These sizes are vmalloc
> > > mapping spans, not HugeTLB hstate sizes.
> > >
> > > Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> > > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> > > Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> > > Tested-by: Leo Yan <leo.yan@arm.com>
> > > ---
> > >  arch/arm64/include/asm/vmalloc.h | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> > > index 4ec1acd3c1b34..4053b1ec1902e 100644
> > > --- a/arch/arm64/include/asm/vmalloc.h
> > > +++ b/arch/arm64/include/asm/vmalloc.h
> > > @@ -23,10 +23,14 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
> > >                                               unsigned long end, u64 pfn,
> > >                                               unsigned int max_page_shift)
> > >  {
> > > +     unsigned long size;
> > > +
> > >       /*
> > >        * If the block is at least CONT_PTE_SIZE in size, and is naturally
> > >        * aligned in both virtual and physical space, then we can pte-map the
> > >        * block using the PTE_CONT bit for more efficient use of the TLB.
> > > +      * The returned mapping size may cover multiple CONT_PTE_SIZE blocks,
> > > +      * capped below PMD_SIZE.
> > >        */
> > >       if (max_page_shift < CONT_PTE_SHIFT)
> > >               return PAGE_SIZE;
> > > @@ -40,7 +44,9 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
> > >       if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
> > >               return PAGE_SIZE;
> > >
> > > -     return CONT_PTE_SIZE;
> > > +     size = min3(end - addr, 1UL << max_page_shift, PMD_SIZE >> 1);
> > >
> > Capped below PMD_SIZE? It is half of PMD_SIZE. Where is that limitation
> > comes from? I think the commit message should be improved in that sense.
> >
> 
> Hi Uladzislau,
> 
> You're right, and the "half" is a leftover that can be dropped entirely.
> 
> Before this series decoupled vmalloc from the HugeTLB, the value
> returned here was fed into ilog2, which reconstructs pagesize as
> 1UL << shift. That forced the size to be a power of two, and PMD_SIZE >> 1
> was then the largest power of two strictly below PMD_SIZE,
> 
> How that pte_set_huge() takes the size directly, the size only needs
> CONT_PTE_SIZE alignment. And this function is only ever called for
> a range that the caller has already confined to a single PMD via
> pmd_addr_end(), so no explicit PMD cap is needed at all. I'll
> simplify it to:
> 
>         size = min2(end -addr, 1UL << max_page_shift);
> 
> and update the commit message accordingly.
> 
Thank you!

--
Uladzislau Rezki

