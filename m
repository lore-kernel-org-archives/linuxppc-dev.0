Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB463C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 16:04:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3168E20643
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 16:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="y7/X111I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3168E20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KGqQ3RdvzDqD4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 03:04:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="y7/X111I"; 
 dkim-atps=neutral
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KGnV71w5zDq67
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 03:02:17 +1100 (AEDT)
Received: by mail-oi1-x242.google.com with SMTP id m4so1848051oim.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CkHX/D6Gyspe7lRDGtgIrSuJ+M2kMCxh6Af+/gLSlLg=;
 b=y7/X111Ih0XlFvwsxv16a+Tjs391cVrRbIsUC3mnj+Mm0qUMtN51FaB5lxBiCc118x
 376jJgarhHQvsy/V3septwJqefqHhb0cQ23r3YOFQrmojJ9aUNMM2lS4jburK7G8+GG8
 gLX4nRQ0AcUV/EHv4PXGES90G+wP03J35zdNnVsfr9Sd8cDALnBGvmFcrlIdyd2oACC4
 6Vli7jf+MBtZb2zuBBWWNh60FRCFh3G++jIyEbSKMpRZYiW3U6H06nM+z0YT2rJezvdu
 kISuyXLhhLUwFgCv7cTZwNyZ9U44tWtZX4l53equtM5zVwtwX0jcTZfkF0XQfcpPj1Md
 xpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CkHX/D6Gyspe7lRDGtgIrSuJ+M2kMCxh6Af+/gLSlLg=;
 b=lO3ZC7WxKIc0cLcdJt5Y7gnGW2mc8zlcyzkf0m/6SbsydzGb+SBszGJjF/UILbaGVe
 uTQVwgby7Rt3wmAsWc1e/x+HwpyZMT3u/lMRl9WPMyppnt9+/Yjn9Kk4E1ZGyHmv5ivt
 FsBKlS+dTgBiJX+ua5LkzwL6l43ljZdSlz8HuKg1v1Bo2m/dh7Lc9emjNImh+BQi4mWd
 fNkWn+2V/nllEJJvZAkZ/YmhU9s+WBq0HNP8NORZ6Jjv3MPyjLQod+OIyV4zpEpaKQwn
 LWcWAiWssv2bQGVH4FRsv/B0HtTsnuHlbqkbvY2zzOO8xW6gV0vLICMFfzpZIXQBIuaP
 3wRQ==
X-Gm-Message-State: APjAAAVRI09hXYlVfSYVpV6sMEX0sF9fDSjiHzLtoSfVfNoCdcbNj4P1
 NpGjWp8rGlmVtfE6HNOimOsU6xT7Oa+MVYKv2lP3fA==
X-Google-Smtp-Source: APXvYqyPiA57rePYTQvH7o4E3jUa42PR2QtmxRflPF8xI9QygvSu8+9pFaw4Gvfpl6WMz1l8+jLwg2xYW8j6yUg7b3c=
X-Received: by 2002:aca:54d8:: with SMTP id i207mr2191334oib.0.1552492933977; 
 Wed, 13 Mar 2019 09:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
 <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
 <87k1hc8iqa.fsf@linux.ibm.com>
In-Reply-To: <87k1hc8iqa.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 13 Mar 2019 09:02:03 -0700
Message-ID: <CAPcyv4ir4irASBQrZD_a6kMkEUt=XPUCuKajF75O7wDCgeG=7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Oliver <oohall@gmail.com>,
 Ross Zwisler <zwisler@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 6, 2019 at 1:18 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Thu, Feb 28, 2019 at 1:40 AM Oliver <oohall@gmail.com> wrote:
> >>
> >> On Thu, Feb 28, 2019 at 7:35 PM Aneesh Kumar K.V
> >> <aneesh.kumar@linux.ibm.com> wrote:
> >> >
> >> > Add a flag to indicate the ability to do huge page dax mapping. On architecture
> >> > like ppc64, the hypervisor can disable huge page support in the guest. In
> >> > such a case, we should not enable huge page dax mapping. This patch adds
> >> > a flag which the architecture code will update to indicate huge page
> >> > dax mapping support.
> >>
> >> *groan*
> >>
> >> > Architectures mostly do transparent_hugepage_flag = 0; if they can't
> >> > do hugepages. That also takes care of disabling dax hugepage mapping
> >> > with this change.
> >> >
> >> > Without this patch we get the below error with kvm on ppc64.
> >> >
> >> > [  118.849975] lpar: Failed hash pte insert with error -4
> >> >
> >> > NOTE: The patch also use
> >> >
> >> > echo never > /sys/kernel/mm/transparent_hugepage/enabled
> >> > to disable dax huge page mapping.
> >> >
> >> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> > ---
> >> > TODO:
> >> > * Add Fixes: tag
> >> >
> >> >  include/linux/huge_mm.h | 4 +++-
> >> >  mm/huge_memory.c        | 4 ++++
> >> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> > index 381e872bfde0..01ad5258545e 100644
> >> > --- a/include/linux/huge_mm.h
> >> > +++ b/include/linux/huge_mm.h
> >> > @@ -53,6 +53,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
> >> >                         pud_t *pud, pfn_t pfn, bool write);
> >> >  enum transparent_hugepage_flag {
> >> >         TRANSPARENT_HUGEPAGE_FLAG,
> >> > +       TRANSPARENT_HUGEPAGE_DAX_FLAG,
> >> >         TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> >> >         TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
> >> >         TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
> >> > @@ -111,7 +112,8 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> >> >         if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
> >> >                 return true;
> >> >
> >> > -       if (vma_is_dax(vma))
> >> > +       if (vma_is_dax(vma) &&
> >> > +           (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_DAX_FLAG)))
> >> >                 return true;
> >>
> >> Forcing PTE sized faults should be fine for fsdax, but it'll break
> >> devdax. The devdax driver requires the fault size be >= the namespace
> >> alignment since devdax tries to guarantee hugepage mappings will be
> >> used and PMD alignment is the default. We can probably have devdax
> >> fall back to the largest size the hypervisor has made available, but
> >> it does run contrary to the design. Ah well, I suppose it's better off
> >> being degraded rather than unusable.
> >
> > Given this is an explicit setting I think device-dax should explicitly
> > fail to enable in the presence of this flag to preserve the
> > application visible behavior.
> >
> > I.e. if device-dax was enabled after this setting was made then I
> > think future faults should fail as well.
>
> Not sure I understood that. Now we are disabling the ability to map
> pages as huge pages. I am now considering that this should not be
> user configurable. Ie, this is something that platform can use to avoid
> dax forcing huge page mapping, but if the architecture can enable huge
> dax mapping, we should always default to using that.

No, that's an application visible behavior regression. The side effect
of this setting is that all huge-page configured device-dax instances
must be disabled.

> Now w.r.t to failures, can device-dax do an opportunistic huge page
> usage?

device-dax explicitly disclaims the ability to do opportunistic mappings.

> I haven't looked at the device-dax details fully yet. Do we make the
> assumption of the mapping page size as a format w.r.t device-dax? Is that
> derived from nd_pfn->align value?

Correct.

>
> Here is what I am working on:
> 1) If the platform doesn't support huge page and if the device superblock
> indicated that it was created with huge page support, we fail the device
> init.

Ok.

> 2) Now if we are creating a new namespace without huge page support in
> the platform, then we force the align details to PAGE_SIZE. In such a
> configuration when handling dax fault even with THP enabled during
> the build, we should not try to use hugepage. This I think we can
> achieve by using TRANSPARENT_HUGEPAEG_DAX_FLAG.

How is this dynamic property communicated to the guest?

>
> Also even if the user decided to not use THP, by
> echo "never" > transparent_hugepage/enabled , we should continue to map
> dax fault using huge page on platforms that can support huge pages.
>
> This still doesn't cover the details of a device-dax created with
> PAGE_SIZE align later booted with a kernel that can do hugepage dax.How
> should we handle that? That makes me think, this should be a VMA flag
> which got derived from device config? May be use VM_HUGEPAGE to indicate
> if device should use a hugepage mapping or not?

device-dax configured with PAGE_SIZE always gets PAGE_SIZE mappings.
