Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7CFC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 16:47:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6998A2184A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 16:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sKjZahpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6998A2184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449JPh2HYFzDqRB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 03:47:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="sKjZahpq"; 
 dkim-atps=neutral
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449JMh3Lm2zDq8Y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 03:45:47 +1100 (AEDT)
Received: by mail-oi1-x241.google.com with SMTP id z14so17062315oid.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GvhxX4m4DDgRvunBUbdiOHoUSvWB/Hk337al+7FlQLk=;
 b=sKjZahpqLoNNijSf1ASjSZV8KHb1T2pBvfJ8ZXu7oVWb4/P10/h8rJerPiBktmGf/z
 7NfEcLHD3p4zXo1ZmYr7MImWVn17oPPpOlQMe5LErUC9EIoXIaD6FTjJG9UM2GfOXNM6
 vFmRb4RxT+LbMnU5VU60eP+/722YCg4aFyiYs2S7A5jngKXOVsjRxC/1KNPMaKM71nT+
 mfcvH8LyhTwrnmpC0N1p7puJbqW752XYw6l//tQW8kvsUZvrKsKBNgyLyLfx5OOWa61R
 /c9koXc2E95zIEqo1Rbs06GS9SjZecXBT62GCD3n2g4xiAbfmeAMn/h9gUzD/D/+BwdJ
 wirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GvhxX4m4DDgRvunBUbdiOHoUSvWB/Hk337al+7FlQLk=;
 b=ngLeCOQUJn6krsiuVEz8Inhh+W/aXLtcfhhMfLgKs0NfiAy6/Vw5MM60npN26gD7PS
 csGVAZ6QKjbP9WcmOFWVHiyolptd+JheKZplD2PQRVtZwwxhDsMDaT8+XT44wWIPumCJ
 XADz6gXabtjv+Jd/XEEyfUn2yOBoVFm8B2LA7zM5cq3mhbiBfgFj9+u16aAbzc7CPgeA
 9MIJ/OfNZ0K8RLFtRbBbkmhvtPwKODNPgNq88NRyz9BSnTLg5WuYWN6p6SxXj97yY1DL
 04LIR9amu6S6bbVJi5CrCH60MXxBOs42J4KzvGpvKprv86P4iMn1X6p2tENRVL27fI/T
 nGVQ==
X-Gm-Message-State: AHQUAuYl9zc84vcnaczhNsueMKHhaI4AgyVOGYvJYrqtDnjOK0zN6HLA
 urJDdBDSKynAtH91fEO3wysBt5EeA6LZSSL66mmcgg==
X-Google-Smtp-Source: AHgI3Ialxeei+TqZP4it7v2/IHqhibSwTNUvWajfoBg7rMbaO6RwmNOzFKIZGvWfOT0mpIi9Wh7jEeFSztTtzScKpmE=
X-Received: by 2002:aca:32c3:: with SMTP id y186mr388997oiy.118.1551372344134; 
 Thu, 28 Feb 2019 08:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
 <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
In-Reply-To: <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 28 Feb 2019 08:45:32 -0800
Message-ID: <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
To: Oliver <oohall@gmail.com>
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
Cc: Jan Kara <jack@suse.cz>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Ross Zwisler <zwisler@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 28, 2019 at 1:40 AM Oliver <oohall@gmail.com> wrote:
>
> On Thu, Feb 28, 2019 at 7:35 PM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
> >
> > Add a flag to indicate the ability to do huge page dax mapping. On architecture
> > like ppc64, the hypervisor can disable huge page support in the guest. In
> > such a case, we should not enable huge page dax mapping. This patch adds
> > a flag which the architecture code will update to indicate huge page
> > dax mapping support.
>
> *groan*
>
> > Architectures mostly do transparent_hugepage_flag = 0; if they can't
> > do hugepages. That also takes care of disabling dax hugepage mapping
> > with this change.
> >
> > Without this patch we get the below error with kvm on ppc64.
> >
> > [  118.849975] lpar: Failed hash pte insert with error -4
> >
> > NOTE: The patch also use
> >
> > echo never > /sys/kernel/mm/transparent_hugepage/enabled
> > to disable dax huge page mapping.
> >
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > ---
> > TODO:
> > * Add Fixes: tag
> >
> >  include/linux/huge_mm.h | 4 +++-
> >  mm/huge_memory.c        | 4 ++++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 381e872bfde0..01ad5258545e 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -53,6 +53,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
> >                         pud_t *pud, pfn_t pfn, bool write);
> >  enum transparent_hugepage_flag {
> >         TRANSPARENT_HUGEPAGE_FLAG,
> > +       TRANSPARENT_HUGEPAGE_DAX_FLAG,
> >         TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> >         TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
> >         TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
> > @@ -111,7 +112,8 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> >         if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
> >                 return true;
> >
> > -       if (vma_is_dax(vma))
> > +       if (vma_is_dax(vma) &&
> > +           (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_DAX_FLAG)))
> >                 return true;
>
> Forcing PTE sized faults should be fine for fsdax, but it'll break
> devdax. The devdax driver requires the fault size be >= the namespace
> alignment since devdax tries to guarantee hugepage mappings will be
> used and PMD alignment is the default. We can probably have devdax
> fall back to the largest size the hypervisor has made available, but
> it does run contrary to the design. Ah well, I suppose it's better off
> being degraded rather than unusable.

Given this is an explicit setting I think device-dax should explicitly
fail to enable in the presence of this flag to preserve the
application visible behavior.

I.e. if device-dax was enabled after this setting was made then I
think future faults should fail as well.
