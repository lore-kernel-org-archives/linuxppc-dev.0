Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833B7C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 19:00:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F239820835
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 19:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="jydYgmEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F239820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q8lM6HbwzDqT9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 05:00:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="jydYgmEc"; 
 dkim-atps=neutral
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7k43437zDqGJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 04:14:02 +1000 (AEST)
Received: by mail-oi1-x244.google.com with SMTP id k6so1346453oic.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 11:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BhVsIoAU0KmMQwQooFIbVLABg6RqRAt0bXCVdPk8wQg=;
 b=jydYgmEcLg5IMUxEQPjYpc4DgbIaXE24fhOcITjx0qkXUHk//riuR0/LhemjcKcSWP
 RP4GtyjPGwp9EuPB5qNyFUVayVB4P9BiMkogYrUvmsoydY+ojeDF/VVh/Q/DKJOBflVi
 T31b0QzpIuB4I+iapiWeXld/gFrM22Nl9lTAPBwohGpDQz2Jly6tCAfI0ncKMwrK36VQ
 9bE8rrq4w/wPkzhIaBkY3t08nM3VlvUDYfP2BcAGGPuuBLy6nGWigDas69mhU3FzJbjg
 0KFRWfoDP7SOk6RkLZJppbZYEdvO2izZTiRoZEGJ2ADyq3lPGpHdXTbEvR74ESSr8DIX
 dBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BhVsIoAU0KmMQwQooFIbVLABg6RqRAt0bXCVdPk8wQg=;
 b=EvgRBA0cuXB7byrrz9mfU+w6VilGpsNR1beAGEvdPet2elnqnyq4nZreTMqn6FsXN8
 92h6ERFPuS9n1Qje7Pw2+VSSsXxxIiy4osOem0aICccr/8H1LLPW7HBISWNUxrCx2fhb
 wU6soyRTuhDhHCxehnprRqy+V+QV9o3uz41egifsCbV781b25vICo+i0JIrh5mVKiS3E
 nZbTmfhmnkcHKaUGmqFUTslu5Asi8Qp9PmzFWVT/FXxJ6vroEZ4vdLXizFtx1LVs6tPS
 d6LtUwYk0gVwo+96IzlYXysB0f6BLWL9FEbQRGzO7/Uym0Ydrq1myHGH4gHPIMug+XWI
 w/Pw==
X-Gm-Message-State: APjAAAVAcA9blAAif+qVcqbMhmdszWlKX33y5ehXaYQwYXZGei2MUkVs
 RPLggOf8oG6sNvqVfjkyDOqI35hwddKMzR3r1Tkg+Q==
X-Google-Smtp-Source: APXvYqwN3H2piW0geeJm1fy7MdumeKyfzQXRx8tCi9JDjwMK7cOgh+Mt7+7fybL28IH9qG0F0B+c8mreTuoq/TY1uPQ=
X-Received: by 2002:aca:de57:: with SMTP id v84mr272169oig.149.1556129638917; 
 Wed, 24 Apr 2019 11:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190402115125.18803-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hzRj5yxVJ5-7AZgzzBxEL02xf2xwhDv-U9_osWFm9kiA@mail.gmail.com>
 <20190424173833.GE19031@bombadil.infradead.org>
In-Reply-To: <20190424173833.GE19031@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 24 Apr 2019 11:13:48 -0700
Message-ID: <CAPcyv4gLGUa69svQnwjvruALZ0ChqUJZHQJ1Mt_Cjr1Jh_6vbQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix modifying of page protection by
 insert_pfn_pmd()
To: Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
 Chandan Rajendra <chandan@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 24, 2019 at 10:38 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Apr 24, 2019 at 10:13:15AM -0700, Dan Williams wrote:
> > I think unaligned addresses have always been passed to
> > vmf_insert_pfn_pmd(), but nothing cared until this patch. I *think*
> > the only change needed is the following, thoughts?
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index ca0671d55aa6..82aee9a87efa 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1560,7 +1560,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct
> > vm_fault *vmf, pfn_t *pfnp,
> >                 }
> >
> >                 trace_dax_pmd_insert_mapping(inode, vmf, PMD_SIZE, pfn, entry);
> > -               result = vmf_insert_pfn_pmd(vma, vmf->address, vmf->pmd, pfn,
> > +               result = vmf_insert_pfn_pmd(vma, pmd_addr, vmf->pmd, pfn,
> >                                             write);
>
> We also call vmf_insert_pfn_pmd() in dax_insert_pfn_mkwrite() -- does
> that need to change too?

It wasn't clear to me that it was a problem. I think that one already
happens to be pmd-aligned.
