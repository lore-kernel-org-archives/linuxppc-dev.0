Return-Path: <linuxppc-dev+bounces-28629-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C311CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 07:56:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwPNy2GRFz2yYf;
	Thu, 01 Oct 2026 17:56:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:31::11" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790841362;
	cv=pass; b=LH6rV4ArXe/ndp5Y1giYp02CYm40xqABMcgwiZG1ZnFI0Lzh+lwp4PRsPJX7skZ1x+e50ao6GKFj0SAkUIXz8TMNP+OVGlCral/hO1IQPwbBoo4y9rS58FEIopp0Ax3BpwHJSzlKKbbcwBWsRjeY+iAvwW7BfuZVp9fkhy38+CLuKTPrgatXIJG6shPdiqt4Y40aUtn/YrSl4Y0j+2WwNP8VBGufzp03fVIGy+9zHRQpH3pv9PTzeakh7ab3afQ7vy7Wd3vJeyHb1VCc4SZvzwUuX1utHCbMpyYemVKXfbcrYNHcRHaIZebrRYRxYvmcTUYrjsUkw8nn4mXiE+bC4Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790841362; c=relaxed/relaxed;
	bh=1AHrAL5m9r+wBvSCXVxM17eZGx8eAClbgj8DyTpgrNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/cHt9d/SXVFaVoi3X8R/k8amtYgI5dvnyZ2+nXnqQ1rWvQb99eT/KXuyRXktGpKArXMW0r/iidLFxoB4Ml7usGtv0ZMq8esTPzNJZzi/1aMGEycv6ybtj9Lgbb/BhHHvK/IeqwoYbgCnMqejmRQzT+bgwDxirrTcAUxeIa+oR+XrEGqYwJ+g1P9jMQCZE7MZQKNJLWtKnO8wFFdxKlR49c/ky8UyE7G5s1sKNjOptARnLr2AYBavWi8DQ7gngPAIhmjaGKM6QbtR5d/3Ly0EAG0nEP2UgYqt7K9e/FVqnu+skJtM2vjC+ijQHqnoWvCxwM9hr9W4JoyO/iryYMpxA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B2XHItAP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B2XHItAP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwPNw5my9z2y2Z
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 17:55:59 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49b912d391aso47469525e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790841356; cv=none;
        d=google.com; s=arc-20260327;
        b=QlL+vfONpxRyGQPpkCjonHPJTnsANol57bKhbM+xKaBneeFZrASvHFedYgOrAVsHeD
         /f07TBcLhlZiOtYIp3Lb6CbrzoDaK7B5MPQS9adGFrYhSGFYch8domawjd7CBuVmsLl6
         Ibidd/MiKea2dc0CR98XNgCig4zSe7RbwiuYcEwj+mheNthCIb5W0T+AKQmRnvnNehsl
         fVi+kvUaFJ96MuWh4z5zJ4saeESEs7YJOiHRXKMhxY06nq593rjMUY1I1NVL5X0zq0he
         meS3ZKLT6Bjx5nYrCxL6dodHxR/HyO1LXmR6pVGJe9MkZ84Vc+sgy0hXNDMDX4szBH7i
         KGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1AHrAL5m9r+wBvSCXVxM17eZGx8eAClbgj8DyTpgrNA=;
        fh=I8BLe4vvQJ+4y94H5JIq2IZ+vXGmqSjI/Bq+rRMadpw=;
        b=UIcTHvx7/HW4wthpCt1580qAybB80DymcbIFNmn1dKYlh2/QA2EMm42dE1KyHJh4za
         zcxB3clFzqniDUZu876eAq1UFbG1xjjWCy1r3UY6AomA+cUqkwvozMEs/CxfypYKr8h2
         bi5teQ2TRKEcuDv6dX05G1mORaZyoN0QRcC9ToumyI27lLmgRYtEi9RDxdRmn5jpnygj
         TbJOLS4R2DgrT1H/Q9pChOf7ZMKEBVkZtI1gxwMwZeLpnIspg1sN2eXdQEifdfQjvLOZ
         YNnI90YYvD3t4fSUwD6vg1uC1V6SNaQlS12AzL57T6EwuART6xP1lj5Am5xvVom8fmec
         vMYQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790841356; x=1791446156; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1AHrAL5m9r+wBvSCXVxM17eZGx8eAClbgj8DyTpgrNA=;
        b=B2XHItAPIe7QukC16tX/6OMRyrD5dubMGNb/3GPLPxyx0LfC5KncP0tQFPu8ogZoKP
         qMl8qqpgdLzKV4cOHtOQKxtcVIqHT1MZ+EC6BoIKoAYU0p9t6MxunCdHf4gxFDio1/PZ
         esBGksyZaY8xHrpqIRp0bMH/CaZonCO7IKeKyQl8V3V0pIYF/yeLludzoCd4KTSiaV+z
         WkgZRLUEAGVhqn091HJ2qHHBvlqi3sOpM3f/93iiLscM+xSF2NiaQZTWF/e+AoQvXnh8
         R8kR0o/R7J7KRTQh6rulboTFOA8553X5Roqf5m3Fl1ZOzgTekvWJ12v6HGz/oowBq1Do
         syjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790841356; x=1791446156;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1AHrAL5m9r+wBvSCXVxM17eZGx8eAClbgj8DyTpgrNA=;
        b=muQI719jTBoYbqrscjkWvWwgky+i4bpKnjHZK1zsK0otLemMdOOWrBCbsj6BLvyzrs
         oynWs2CWp+ZVlLpx0UEbN7i7YCS0Y97+rw2wf5of/VV2hCjlKECiloguKGNT/rqanccG
         L080dxC6AuKwgB4U8LzPLFNSyO/3xoj18NJaGinpSPffz/9En7yOP1XW6hjCzZ/ADUMf
         hFPbDFWobP4T/y5eKW1PcC2IohsJBPyrWb1W6cDtM/Dsw834M9dsUftrPJjl1x/DqMKp
         ewozs7CNDbBD9F7mqY7kS2Dwz5pusw/HoX2Oaoc3I/HS8BIk39GKphZlriszIM2mfjG4
         2SOA==
X-Forwarded-Encrypted: i=1; AKwUvBy/iMlpbk9EK/DXZOc2ZE3Z6p8ET1WZdf9DryeJ4SgtKQr3B6K3usvaKimt0VpivTBKYjgrXhKNOWGg5Do=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m589WLz8O3lrSSuSJn4qZOiml4aFscmrYBrCU+wPVZlrhDrT4p
	jKRRgn0DaAhd3buOlDgNqkwLoMfqo5hOAByDlqSwtTceDvQuL4h0om+BibYmjkVrkIVnWRD4n+m
	ebtOuc+evRIPwLTE5DsUZSh9DHCUUueY=
X-Gm-Gg: AYBFou3/JiwMsXtZuNsYtu5qu4UOaNwceC5U/+KVFK8SAjUL7LBau+CMH+tb3qPrpxD
	FWuG7EhyQgfuVxfY4cJ/uD6VZn3etxKHMOWQFVi+mhbOqoTFLVRUl5a8GdvgRKkhH3keVH7mTa8
	Wbsqhc0I3IC0ga3ATTnsy6hXUHUMqZoTYcpcKzYY21f4J3F72aZAQjntWaodNd7w3IqLr0UhPmY
	YpCOuqlc0qlT/qv894m9YEdtn1T58SvQt4mD7Jv7mtj7gaf1pV2QZIxVeSX6N6wyq0ZlT+wEH6q
	7wWUZg7YrZ/9nNENLfdOBTNhutPZ2HOwlF0gdJUuh9NB7E9wdfEu+jSHNg==
X-Received: by 2002:a05:600c:5020:b0:4a0:1efa:c746 with SMTP id
 5b1f17b1804b1-4a01efad733mr26833895e9.21.1790841355651; Thu, 01 Oct 2026
 00:55:55 -0700 (PDT)
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
References: <20260923062832.479455-1-jiangwen6@xiaomi.com> <20260923062832.479455-6-jiangwen6@xiaomi.com>
 <ar0s14p8KPgmDKmR@milan>
In-Reply-To: <ar0s14p8KPgmDKmR@milan>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Thu, 1 Oct 2026 15:55:44 +0800
X-Gm-Features: AclHuK_wExzN3hq35-9mtJ9Vi_bHjI_pv0wB1wZZplKSMEZ1VOjoAMFGpVzuuYY
Message-ID: <CAHKocdEF3RE5FA+LPRf_E0ns02a5akvUDKvSDvERoyTryV1X6Q@mail.gmail.com>
Subject: Re: [PATCH v9 05/10] arm64/vmalloc: allow arch_vmap_pte_range_map_size()
 to batch multiple CONT_PTE
To: Uladzislau Rezki <urezki@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org, 
	will@kernel.org, Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, 
	anshuman.khandual@arm.com, baohua@kernel.org, chleroy@kernel.org, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Sept 2026 at 23:38, Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Wed, Sep 23, 2026 at 02:28:27PM +0800, Wen Jiang wrote:
> > From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> >
> > Allow arch_vmap_pte_range_map_size to batch across multiple CONT_PTE
> > blocks, reducing both PTE setup and TLB flush iterations.
> >
> > For CONT_PTE_SIZE-aligned ranges, return a mapping size that may cover
> > multiple CONT_PTE blocks, capped below PMD_SIZE. These sizes are vmalloc
> > mapping spans, not HugeTLB hstate sizes.
> >
> > Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> > Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> > Tested-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  arch/arm64/include/asm/vmalloc.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> > index 4ec1acd3c1b34..4053b1ec1902e 100644
> > --- a/arch/arm64/include/asm/vmalloc.h
> > +++ b/arch/arm64/include/asm/vmalloc.h
> > @@ -23,10 +23,14 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
> >                                               unsigned long end, u64 pfn,
> >                                               unsigned int max_page_shift)
> >  {
> > +     unsigned long size;
> > +
> >       /*
> >        * If the block is at least CONT_PTE_SIZE in size, and is naturally
> >        * aligned in both virtual and physical space, then we can pte-map the
> >        * block using the PTE_CONT bit for more efficient use of the TLB.
> > +      * The returned mapping size may cover multiple CONT_PTE_SIZE blocks,
> > +      * capped below PMD_SIZE.
> >        */
> >       if (max_page_shift < CONT_PTE_SHIFT)
> >               return PAGE_SIZE;
> > @@ -40,7 +44,9 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
> >       if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
> >               return PAGE_SIZE;
> >
> > -     return CONT_PTE_SIZE;
> > +     size = min3(end - addr, 1UL << max_page_shift, PMD_SIZE >> 1);
> >
> Capped below PMD_SIZE? It is half of PMD_SIZE. Where is that limitation
> comes from? I think the commit message should be improved in that sense.
>

Hi Uladzislau,

You're right, and the "half" is a leftover that can be dropped entirely.

Before this series decoupled vmalloc from the HugeTLB, the value
returned here was fed into ilog2, which reconstructs pagesize as
1UL << shift. That forced the size to be a power of two, and PMD_SIZE >> 1
was then the largest power of two strictly below PMD_SIZE,

How that pte_set_huge() takes the size directly, the size only needs
CONT_PTE_SIZE alignment. And this function is only ever called for
a range that the caller has already confined to a single PMD via
pmd_addr_end(), so no explicit PMD cap is needed at all. I'll
simplify it to:

        size = min2(end -addr, 1UL << max_page_shift);

and update the commit message accordingly.

Thanks,
Wen

