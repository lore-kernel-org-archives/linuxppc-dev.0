Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E0CC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 04:04:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62D520854
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 04:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="eU7vf8X9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62D520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KZpB6ZpSzDqL9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 15:04:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="eU7vf8X9"; 
 dkim-atps=neutral
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KZmT3jgXzDqKS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 15:02:26 +1100 (AEDT)
Received: by mail-ot1-x342.google.com with SMTP id i12so3866453otp.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 21:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qs7tp1/zBqGtB73b9T3ZkeYLG/1DJ1WgPchIkfxvgMI=;
 b=eU7vf8X9XCVloH4yFRSwPMJOtpSR/fMmFkniq4uHcPXAlIReWXJh0Z+q64meRuGP3M
 skI5X4A5JF/zw1rhA6o7JcFS6QQUIjOyw87HiIPJuTeV3ZFCWkuVzjiunjbGmnKIH8PP
 d0GUJS45X4BfE3LGcOkOgmFPbVoD1RlmOP/s4Iba+KMHCV7RQOG8tt5WRNcYCxFV8yGB
 uQgbxTR+iAgUImDt6CTAyz2+XDvw6vYu7YGLKi1XurFi/KZX9rHUjIia18cI51xDn6FC
 vI2KT31oSMg20EO444p+DGxfHVR1APWOjIF4q0elCkXZ/5bHEVX7dTtHnmLFxCnjmC/E
 9rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qs7tp1/zBqGtB73b9T3ZkeYLG/1DJ1WgPchIkfxvgMI=;
 b=Tjzs4UWl1AO2CLlSJoPU/X2I2vjTILV6jOl8+Zd7JoodSpFGy8wWGlKkCcXOf1R7y1
 UF0ZcnEpxz//ngxZR+8iAN69+W/iRDA3Yg38qur5G6HTY3Tvg8tAXyQNZm8hOBFYrsfC
 C1YQ1S1BeTi9t2t1O7FUiMLzO5VKb42ghqPM75pqbA+4FKwTslwuPTEbNJ4S09Hl3zf/
 9/plzvDvaDf4xTTQpTngC1JsLkn+Iy8j91Ytv5vkjH/HqpEQw35uJUUXjm1vXq9K2O6+
 c52PHqZzLu/+PmFc6hCQTXZfi/P55ogRdRglpSiNCIAyO/eI/50250mna9gZzUNF97qD
 CLsQ==
X-Gm-Message-State: APjAAAXGsoEqj8ayrhyckrUX0VUHbRPVFW44zwem9/3mUVxaGy4RpUPW
 JmtNdSRSbvjURO/GsrPWr2paP8vnU3fYM9BkvozS0A==
X-Google-Smtp-Source: APXvYqzxaRxDED7CM3oENetDG2md4WXlntPbG0NSGcR0/oaZGUe6x6pBOyPAF61pD1lSSIn/hEMAOHQHBo57G6q1bYU=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr28800858otl.353.1552536143794; 
 Wed, 13 Mar 2019 21:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
 <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
 <87k1hc8iqa.fsf@linux.ibm.com>
 <CAPcyv4ir4irASBQrZD_a6kMkEUt=XPUCuKajF75O7wDCgeG=7Q@mail.gmail.com>
 <871s3aqfup.fsf@linux.ibm.com>
In-Reply-To: <871s3aqfup.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 13 Mar 2019 21:02:11 -0700
Message-ID: <CAPcyv4i0SahDP=_ZQV3RG_b5pMkjn-9Cjy7OpY2sm1PxLdO8jA@mail.gmail.com>
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

On Wed, Mar 13, 2019 at 8:45 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
[..]
> >> Now w.r.t to failures, can device-dax do an opportunistic huge page
> >> usage?
> >
> > device-dax explicitly disclaims the ability to do opportunistic mappings.
> >
> >> I haven't looked at the device-dax details fully yet. Do we make the
> >> assumption of the mapping page size as a format w.r.t device-dax? Is that
> >> derived from nd_pfn->align value?
> >
> > Correct.
> >
> >>
> >> Here is what I am working on:
> >> 1) If the platform doesn't support huge page and if the device superblock
> >> indicated that it was created with huge page support, we fail the device
> >> init.
> >
> > Ok.
> >
> >> 2) Now if we are creating a new namespace without huge page support in
> >> the platform, then we force the align details to PAGE_SIZE. In such a
> >> configuration when handling dax fault even with THP enabled during
> >> the build, we should not try to use hugepage. This I think we can
> >> achieve by using TRANSPARENT_HUGEPAEG_DAX_FLAG.
> >
> > How is this dynamic property communicated to the guest?
>
> via device tree on powerpc. We have a device tree node indicating
> supported page sizes.

Ah, ok, yeah let's plumb that straight to the device-dax driver and
leave out the interaction / interpretation of the thp-enabled flags.

>
> >
> >>
> >> Also even if the user decided to not use THP, by
> >> echo "never" > transparent_hugepage/enabled , we should continue to map
> >> dax fault using huge page on platforms that can support huge pages.
> >>
> >> This still doesn't cover the details of a device-dax created with
> >> PAGE_SIZE align later booted with a kernel that can do hugepage dax.How
> >> should we handle that? That makes me think, this should be a VMA flag
> >> which got derived from device config? May be use VM_HUGEPAGE to indicate
> >> if device should use a hugepage mapping or not?
> >
> > device-dax configured with PAGE_SIZE always gets PAGE_SIZE mappings.
>
> Now what will be page size used for mapping vmemmap?

That's up to the architecture's vmemmap_populate() implementation.

> Architectures
> possibly will use PMD_SIZE mapping if supported for vmemmap. Now a
> device-dax with struct page in the device will have pfn reserve area aligned
> to PAGE_SIZE with the above example? We can't map that using
> PMD_SIZE page size?

IIUC, that's a different alignment. Currently that's handled by
padding the reservation area up to a section (128MB on x86) boundary,
but I'm working on patches to allow sub-section sized ranges to be
mapped.

Now, that said, I expect there may be bugs lurking in the
implementation if PAGE_SIZE changes from one boot to the next simply
because I've never tested that.

I think this also indicates that the section padding logic can't be
removed until all arch vmemmap_populate() implementations understand
the sub-section case.
