Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5A7C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 03:11:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03792175B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 03:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0DV7ewk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03792175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PsHz2y7YzDqRd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 14:11:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="O0DV7ewk"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PsFT38c9zDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 14:09:01 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id w15so2206896itc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 20:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=krQUPeEhUeWHXrLxX44ZwDfZs9HTeNysg+aRzRJo4mk=;
 b=O0DV7ewkSoAZ/rqPwD5L5473opI76dKFPGAiGF1OEwhywBkZXgX0LqbWbZqlvBGki1
 JUgZihhN+9Eegjweh1YadYSub4LnZEHgYfGo2pJo2VsZV4Ptx3MBkLMGs+FcNQwrWmVm
 oE4tFDGaihV8Ir9e01BOPMcWIBq87rX1NxpRuNSgEzO51deT3tCnYfJym9Z2j/sEClaU
 CCZWJQmwrlkuCDH9iW0k1J4Dge2iudMPauqmu3TpSqHCQjx8j/3TVNMoJZ/CcIkcKiuj
 A/NQ87nXc4Ko7AlFTxb/8AxRdB9GfQeszs1EvWxmc2R58s7HGmYeh+wQ0AJXoQnN7eDM
 0Rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=krQUPeEhUeWHXrLxX44ZwDfZs9HTeNysg+aRzRJo4mk=;
 b=aQoi9BEJREks2UEgiV/N1FC3e5AyGYE755O3HoAoKVSrK6YIslbr/ZO3MGbvqZ3cVl
 c8qBykAl0aPKM7Uocj7gBgUeh6SzOanOx0HKUn2zzHD88ltGL+zmjvMMnCeA1eiKtZFu
 C7+M99yRAGPPW9O+N7FRRSB14kkTEq1mNYrQRRx6tI8FSMh5YFlLBiqi1QCpsSiWv2PM
 MmYpkRnj5o369se0xdmCSEuAo3aVNqOprRhP8lnogG4z6sIpn1AJo/02jC+LgWzcPHAm
 5nhPS7IuhPm40rbGO5Zw7VnyGfKN/W/PCcBMRNmZ0d/i/5lST6QhA5HEDzFxOTIw061g
 LRZQ==
X-Gm-Message-State: APjAAAXg+LCsdrfFdsC5CpT+hcS7e7bxrPnWIGlV6QSeL5JpSAgayrmI
 zc/9HueTRENwZfWop2BEr2/5vkz1jAL3K6smuFo=
X-Google-Smtp-Source: APXvYqwRkBEj4osIJj129KBcDzogr3ZyjA2aRAcSNZSClpJrTRzqCvw6s6lxH3oEPU2CgdaZoAaEOubD8csvDUwrQ1A=
X-Received: by 2002:a24:eb0e:: with SMTP id h14mr1176796itj.100.1553137736931; 
 Wed, 20 Mar 2019 20:08:56 -0700 (PDT)
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
In-Reply-To: <CAPcyv4hMzVuOYzy2tTq-my8Z1y+X6Ug-fyObpKTxVU44p5rBZw@mail.gmail.com>
From: Oliver <oohall@gmail.com>
Date: Thu, 21 Mar 2019 14:08:45 +1100
Message-ID: <CAOSf1CEZoLw5QqEMTKwiZ+d_qPLp_D9pJZUtnQWMXWpAXOQ2YA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
To: Dan Williams <dan.j.williams@intel.com>
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

On Thu, Mar 21, 2019 at 7:57 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Mar 20, 2019 at 8:34 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Wed, Mar 20, 2019 at 1:09 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> > >
> > > Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> writes:
> > >
> > > > Dan Williams <dan.j.williams@intel.com> writes:
> > > >
> > > >>
> > > >>> Now what will be page size used for mapping vmemmap?
> > > >>
> > > >> That's up to the architecture's vmemmap_populate() implementation.
> > > >>
> > > >>> Architectures
> > > >>> possibly will use PMD_SIZE mapping if supported for vmemmap. Now a
> > > >>> device-dax with struct page in the device will have pfn reserve area aligned
> > > >>> to PAGE_SIZE with the above example? We can't map that using
> > > >>> PMD_SIZE page size?
> > > >>
> > > >> IIUC, that's a different alignment. Currently that's handled by
> > > >> padding the reservation area up to a section (128MB on x86) boundary,
> > > >> but I'm working on patches to allow sub-section sized ranges to be
> > > >> mapped.
> > > >
> > > > I am missing something w.r.t code. The below code align that using nd_pfn->align
> > > >
> > > >       if (nd_pfn->mode == PFN_MODE_PMEM) {
> > > >               unsigned long memmap_size;
> > > >
> > > >               /*
> > > >                * vmemmap_populate_hugepages() allocates the memmap array in
> > > >                * HPAGE_SIZE chunks.
> > > >                */
> > > >               memmap_size = ALIGN(64 * npfns, HPAGE_SIZE);
> > > >               offset = ALIGN(start + SZ_8K + memmap_size + dax_label_reserve,
> > > >                               nd_pfn->align) - start;
> > > >       }
> > > >
> > > > IIUC that is finding the offset where to put vmemmap start. And that has
> > > > to be aligned to the page size with which we may end up mapping vmemmap
> > > > area right?
> >
> > Right, that's the physical offset of where the vmemmap ends, and the
> > memory to be mapped begins.
> >
> > > > Yes we find the npfns by aligning up using PAGES_PER_SECTION. But that
> > > > is to compute howmany pfns we should map for this pfn dev right?
> > > >
> > >
> > > Also i guess those 4K assumptions there is wrong?
> >
> > Yes, I think to support non-4K-PAGE_SIZE systems the 'pfn' metadata
> > needs to be revved and the PAGE_SIZE needs to be recorded in the
> > info-block.
>
> How often does a system change page-size. Is it fixed or do
> environment change it from one boot to the next? I'm thinking through
> the behavior of what do when the recorded PAGE_SIZE in the info-block
> does not match the current system page size. The simplest option is to
> just fail the device and require it to be reconfigured. Is that
> acceptable?

The kernel page size is set at build time and as far as I know every
distro configures their ppc64(le) kernel for 64K. I've used 4K kernels
a few times in the past to debug PAGE_SIZE dependent problems, but I'd
be surprised if anyone is using 4K in production.

Anyway, my view is that using 4K here isn't really a problem since
it's just the accounting unit of the pfn superblock format. The kernel
reading form it should understand that and scale it to whatever
accounting unit it wants to use internally. Currently we don't so that
should probably be fixed, but that doesn't seem to cause any real
issues. As far as I can tell the only user of npfns in
__nvdimm_setup_pfn() whih prints the "number of pfns truncated"
message.

Am I missing something?

> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
