Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8D4C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 03:14:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B07620643
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 03:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="O8Sexf3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B07620643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PsMd45swzDqRB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 14:14:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="O8Sexf3a"; 
 dkim-atps=neutral
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PsKt2r9BzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 14:12:48 +1100 (AEDT)
Received: by mail-oi1-x244.google.com with SMTP id x188so2657435oia.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 20:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hNRCxCN0CPAwwEtkaOPrHmrtVKrkPJRIrqfUj9WvgyM=;
 b=O8Sexf3atM7lpmy9ftmXKY6Rq98VWw6kJJHp0jYrLWOxjKwD7nE0qEKAHLQw6tCuKX
 CM3Nvb9Wm0GwBB9S3f2lVuH2umS5O6KixZnJsQyPudc/BqA0kVTOWcwRgBy1XKC0eBiR
 7gsbJROskxVR1QLdM0WLyxbmhIJNcahTso9WIpLFOAEnIk9FmrLxfXAUzdcWujrcRaks
 NApVOGxVkBqnNBpIXs+AdbmuKY/PCohhzkgNnFYt893m1QMRVT0cf+FGjN/q9omQ7D0c
 lRSZuUG8JgbCDVde+5KpKNZ/v/wMiSE5W4hsCzH/hGCaCBNP6w/5MQyi1tNi/IJipRVH
 ysDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hNRCxCN0CPAwwEtkaOPrHmrtVKrkPJRIrqfUj9WvgyM=;
 b=rRYETwlErzQYiOdjjoVn4QDkxf5VDFSa1gXx5br00J1Cy7XVjxf+Fb09CH5kAqLYq8
 Ld6D+ZReumhApjNNNKjLPtnMJeqetrfojb/uyB4x3WcqayCdHGwCUf/srxKYSusGbnxL
 nP+PC5TflBxbL+TekBLr7u/Fl5psmVmXk5l+ydtwcosBJbATbZTentEHMpQNJqiXLpna
 SYSWCtAWEo6SrUHLAw55J+dDXZRMiJrfyHpldDlXzL8pSKfXU0L0KYV/yUrsADtYUia9
 mltNkepw4tf+PnpgAOHcDdr2FRgMpY9R1hxAvfXcqWRnTY8D+J2DHnPlJL3mr4HFaZJA
 qOIw==
X-Gm-Message-State: APjAAAWwcdRzJ+34Vuy0Q6uBp+fOVbmPCZFjk1w6PJY8Kah3l4+FDSya
 v8Ow1fE7TEu4s08FXG6RwubFOF56Lwfolh2/cknHLg==
X-Google-Smtp-Source: APXvYqylwiscCu6ZjtkuX8ZDMdHYFpCCnDQq/QDcOH9L7ss0xpeIBR+ZWTttEz8AazBy4cqY+C3YbuRNm+DG7x8rkms=
X-Received: by 2002:aca:ed88:: with SMTP id l130mr798985oih.70.1553137965862; 
 Wed, 20 Mar 2019 20:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
 <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
 <87k1hc8iqa.fsf@linux.ibm.com>
 <CAPcyv4ir4irASBQrZD_a6kMkEUt=XPUCuKajF75O7wDCgeG=7Q@mail.gmail.com>
 <871s3aqfup.fsf@linux.ibm.com>
 <CAPcyv4i0SahDP=_ZQV3RG_b5pMkjn-9Cjy7OpY2sm1PxLdO8jA@mail.gmail.com>
 <87bm267ywc.fsf@linux.ibm.com> <878sxa7ys5.fsf@linux.ibm.com>
 <CAPcyv4iuAPg3HWh5e8-Ud3oCrvp5AoFmjOzf4bbA+VLgR7NLFg@mail.gmail.com>
 <CAPcyv4hMzVuOYzy2tTq-my8Z1y+X6Ug-fyObpKTxVU44p5rBZw@mail.gmail.com>
 <CAOSf1CEZoLw5QqEMTKwiZ+d_qPLp_D9pJZUtnQWMXWpAXOQ2YA@mail.gmail.com>
In-Reply-To: <CAOSf1CEZoLw5QqEMTKwiZ+d_qPLp_D9pJZUtnQWMXWpAXOQ2YA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 20 Mar 2019 20:12:34 -0700
Message-ID: <CAPcyv4hiAE9Y3Jeudr=Ys=eu2gei088xGyTCJGOoz04iUExUfw@mail.gmail.com>
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Ross Zwisler <zwisler@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 20, 2019 at 8:09 PM Oliver <oohall@gmail.com> wrote:
>
> On Thu, Mar 21, 2019 at 7:57 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Wed, Mar 20, 2019 at 8:34 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Wed, Mar 20, 2019 at 1:09 AM Aneesh Kumar K.V
> > > <aneesh.kumar@linux.ibm.com> wrote:
> > > >
> > > > Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> writes:
> > > >
> > > > > Dan Williams <dan.j.williams@intel.com> writes:
> > > > >
> > > > >>
> > > > >>> Now what will be page size used for mapping vmemmap?
> > > > >>
> > > > >> That's up to the architecture's vmemmap_populate() implementation.
> > > > >>
> > > > >>> Architectures
> > > > >>> possibly will use PMD_SIZE mapping if supported for vmemmap. Now a
> > > > >>> device-dax with struct page in the device will have pfn reserve area aligned
> > > > >>> to PAGE_SIZE with the above example? We can't map that using
> > > > >>> PMD_SIZE page size?
> > > > >>
> > > > >> IIUC, that's a different alignment. Currently that's handled by
> > > > >> padding the reservation area up to a section (128MB on x86) boundary,
> > > > >> but I'm working on patches to allow sub-section sized ranges to be
> > > > >> mapped.
> > > > >
> > > > > I am missing something w.r.t code. The below code align that using nd_pfn->align
> > > > >
> > > > >       if (nd_pfn->mode == PFN_MODE_PMEM) {
> > > > >               unsigned long memmap_size;
> > > > >
> > > > >               /*
> > > > >                * vmemmap_populate_hugepages() allocates the memmap array in
> > > > >                * HPAGE_SIZE chunks.
> > > > >                */
> > > > >               memmap_size = ALIGN(64 * npfns, HPAGE_SIZE);
> > > > >               offset = ALIGN(start + SZ_8K + memmap_size + dax_label_reserve,
> > > > >                               nd_pfn->align) - start;
> > > > >       }
> > > > >
> > > > > IIUC that is finding the offset where to put vmemmap start. And that has
> > > > > to be aligned to the page size with which we may end up mapping vmemmap
> > > > > area right?
> > >
> > > Right, that's the physical offset of where the vmemmap ends, and the
> > > memory to be mapped begins.
> > >
> > > > > Yes we find the npfns by aligning up using PAGES_PER_SECTION. But that
> > > > > is to compute howmany pfns we should map for this pfn dev right?
> > > > >
> > > >
> > > > Also i guess those 4K assumptions there is wrong?
> > >
> > > Yes, I think to support non-4K-PAGE_SIZE systems the 'pfn' metadata
> > > needs to be revved and the PAGE_SIZE needs to be recorded in the
> > > info-block.
> >
> > How often does a system change page-size. Is it fixed or do
> > environment change it from one boot to the next? I'm thinking through
> > the behavior of what do when the recorded PAGE_SIZE in the info-block
> > does not match the current system page size. The simplest option is to
> > just fail the device and require it to be reconfigured. Is that
> > acceptable?
>
> The kernel page size is set at build time and as far as I know every
> distro configures their ppc64(le) kernel for 64K. I've used 4K kernels
> a few times in the past to debug PAGE_SIZE dependent problems, but I'd
> be surprised if anyone is using 4K in production.

Ah, ok.

> Anyway, my view is that using 4K here isn't really a problem since
> it's just the accounting unit of the pfn superblock format. The kernel
> reading form it should understand that and scale it to whatever
> accounting unit it wants to use internally. Currently we don't so that
> should probably be fixed, but that doesn't seem to cause any real
> issues. As far as I can tell the only user of npfns in
> __nvdimm_setup_pfn() whih prints the "number of pfns truncated"
> message.
>
> Am I missing something?

No, I don't think so. The only time it would break is if a system with
64K page size laid down an info-block with not enough reserved
capacity when the page-size is 4K (npfns too small). However, that
sounds like an exceptional case which is why no problems have been
reported to date.
