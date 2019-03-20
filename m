Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1541AC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 20:59:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF0F218CD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 20:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="hQHtw54b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF0F218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Pj2y1C7yzDqP9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 07:59:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="hQHtw54b"; 
 dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Pj155JWkzDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 07:57:38 +1100 (AEDT)
Received: by mail-ot1-x343.google.com with SMTP id o74so3509272ota.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ij6DJHAqfryzjiSG/jxMhd1XKTG9GJ9L0fy61wU1Z5Q=;
 b=hQHtw54bMsNq0UWUzqZi4Xepmmij8Jy+KDZGJeywwLNrPiqUxNyKDH9xKURLPj0fcE
 kgWIoCRrhrHXSjdOwmwJflndw0Hkzfn+dxWAhGaTjcdCUmKbGDvtLdps5Q5aNmZbyXWA
 3qpCDijWEutH+VhB1H3M03XG0EqvBDiHqQf8KpW7PktJ/3m/DRFeEcos1F+gSTr3sIrB
 Ad673In69dbKt/dX6+IzUFlmsJQdelglLg+znKplUjCEwy5y+QlPtMSJmrjZ01yzykjv
 KzrcWmFeOoSmQMh+oZa/9G1ooH7YeUyBLCBcskKekprWtQU1d7nwTXUeH25dBf7R+wDa
 oxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ij6DJHAqfryzjiSG/jxMhd1XKTG9GJ9L0fy61wU1Z5Q=;
 b=CL0mHpF+qu5xMtjl04C4PyVU6sOPoxDWAf4Vpg5kCp3up/A1P7F7dQoRx9IFWs9fiB
 4G7QW5TyC3Hino9ZYYdbxPKmCClbxPJ1ae5NVrBl3sVA1RvV0k+QJ/w0GKL7TmoM+29P
 aU5iJiHeL1J+WUirGoAj11/+6plVZzH2TkWMmTxiJ7/M7hkStPd1zAT5H1xuVXs/34Tg
 F27y0VoYmLXRudrON3hL/PYX8HoqN4WbiYHQoHhfR6/d/SLZz+uzAq0Shk1X4b3XQqMB
 z1KkFnYErSUgLIldusRCrX9KxkOPpc70K4kyO13PyfuyO1DSqAyiB06oO4IWCPfY7LxQ
 nlDQ==
X-Gm-Message-State: APjAAAVqb+6bBrSetrCXWPlpP1HmqYTN+NO5cpcB/8g27kx7BY8VHWfx
 7OmjMTyM/abytFdfPxYvlolWpa5+woZGERS/rNnX8A==
X-Google-Smtp-Source: APXvYqxcZXKMA+p2n96n1FFTaOSelIGH59iBkrJ6znV79aqILXhBWYIui9s4FGcIsTHT0hrIr2022s1bnFyAt264+ko=
X-Received: by 2002:a9d:4d0b:: with SMTP id n11mr63266otf.98.1553115455713;
 Wed, 20 Mar 2019 13:57:35 -0700 (PDT)
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
In-Reply-To: <CAPcyv4iuAPg3HWh5e8-Ud3oCrvp5AoFmjOzf4bbA+VLgR7NLFg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 20 Mar 2019 13:57:25 -0700
Message-ID: <CAPcyv4hMzVuOYzy2tTq-my8Z1y+X6Ug-fyObpKTxVU44p5rBZw@mail.gmail.com>
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
 Linux MM <linux-mm@kvack.org>, Ross Zwisler <zwisler@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 20, 2019 at 8:34 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Mar 20, 2019 at 1:09 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
> >
> > Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> writes:
> >
> > > Dan Williams <dan.j.williams@intel.com> writes:
> > >
> > >>
> > >>> Now what will be page size used for mapping vmemmap?
> > >>
> > >> That's up to the architecture's vmemmap_populate() implementation.
> > >>
> > >>> Architectures
> > >>> possibly will use PMD_SIZE mapping if supported for vmemmap. Now a
> > >>> device-dax with struct page in the device will have pfn reserve area aligned
> > >>> to PAGE_SIZE with the above example? We can't map that using
> > >>> PMD_SIZE page size?
> > >>
> > >> IIUC, that's a different alignment. Currently that's handled by
> > >> padding the reservation area up to a section (128MB on x86) boundary,
> > >> but I'm working on patches to allow sub-section sized ranges to be
> > >> mapped.
> > >
> > > I am missing something w.r.t code. The below code align that using nd_pfn->align
> > >
> > >       if (nd_pfn->mode == PFN_MODE_PMEM) {
> > >               unsigned long memmap_size;
> > >
> > >               /*
> > >                * vmemmap_populate_hugepages() allocates the memmap array in
> > >                * HPAGE_SIZE chunks.
> > >                */
> > >               memmap_size = ALIGN(64 * npfns, HPAGE_SIZE);
> > >               offset = ALIGN(start + SZ_8K + memmap_size + dax_label_reserve,
> > >                               nd_pfn->align) - start;
> > >       }
> > >
> > > IIUC that is finding the offset where to put vmemmap start. And that has
> > > to be aligned to the page size with which we may end up mapping vmemmap
> > > area right?
>
> Right, that's the physical offset of where the vmemmap ends, and the
> memory to be mapped begins.
>
> > > Yes we find the npfns by aligning up using PAGES_PER_SECTION. But that
> > > is to compute howmany pfns we should map for this pfn dev right?
> > >
> >
> > Also i guess those 4K assumptions there is wrong?
>
> Yes, I think to support non-4K-PAGE_SIZE systems the 'pfn' metadata
> needs to be revved and the PAGE_SIZE needs to be recorded in the
> info-block.

How often does a system change page-size. Is it fixed or do
environment change it from one boot to the next? I'm thinking through
the behavior of what do when the recorded PAGE_SIZE in the info-block
does not match the current system page size. The simplest option is to
just fail the device and require it to be reconfigured. Is that
acceptable?
