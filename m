Return-Path: <SRS0=qWQb=4B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA92AC2BA83
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Feb 2020 18:28:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A80321734
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Feb 2020 18:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="rXaw+VQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A80321734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48JQ4r3zLRzDqP1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Feb 2020 05:28:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::242;
 helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=rXaw+VQU; dkim-atps=neutral
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48JQ2y2qCvzDqSM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2020 05:27:03 +1100 (AEDT)
Received: by mail-oi1-x242.google.com with SMTP id c16so6779340oic.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2020 10:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HpDOVVwQMoKUWV1DWVonUPFvZBLp80J0wZPDxMAaRfY=;
 b=rXaw+VQU+BjuhG30DscKYH7MHhb9UTyRb7apt36HoQ8vdfEazZoV8TpMsYehOANm0i
 Ad49SZMMYnTxNsI7UYPu9i/7tKY+5XCh/fe8Z1IbV33TjJwh5imPo0ja1SnmDxIPKhfn
 q+yfBnL9eDiFLTnNzbTpbFj5XyBowu9DqukeqXcR2zJ2l+nDzbWibmPHahu0Rvx6B7gV
 LCizkUaCHYg1paEJYE6UMN3g7C1a9UI3LSbC0Pj+VY65RbvSvZZ46MAz9Lzu1ZR9HI0C
 k+JHaH7IVx36F/8pTOY+F3F7OSNAfYTrt+U8MtfhYkDEjbioFaldj1Q3VG7lIVd6c1/G
 sjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HpDOVVwQMoKUWV1DWVonUPFvZBLp80J0wZPDxMAaRfY=;
 b=COhIr1Gl/0H6ZlMrEwMQ201spVDaRL1Nv4Ya8/wA/W9LBAOX72EXpAFYdrgKQLSip/
 C5Ogq6poQoGv/KZRCbqHudzXBs4M6O7yoIhyMozETCfrtAALQ/6gzPWx+D+zSo4sN1rq
 PJ8U1YgUmIgtFXdSXH/deUgpOtB7BhYdPK9EekDTtIRci69/mocQpT9W9eKmi9bT+Uri
 xE1exI6ssqRrgcxUySHyPbfs2mPu1iCvftcLc36atzFditdgDRfs+bl5kSMRwIn05FBi
 +xuqh5rsg3gZIEMxDoToBH+8aWC0kJH968dBgb/Ks/YY8+hXt/bQACXAojMpHrd52cwt
 6x8A==
X-Gm-Message-State: APjAAAWqqoC16bWaduDmtFuJBv0Xiz+weBsK4BgQi6AGusx4nL4gB3Fe
 kgluT2awNApHRqVpU8E+Jek/WTQbWZdqlK/RxtYBfA==
X-Google-Smtp-Source: APXvYqxht5FHJenXXKFjAcL0FoNd3tudfWztDG42KiVuUkVg02EE/Iivz69tviiGm0uxN1GdKP8BzvtNR9xEopXkwfI=
X-Received: by 2002:aca:4c9:: with SMTP id 192mr4016542oie.105.1581618420229; 
 Thu, 13 Feb 2020 10:27:00 -0800 (PST)
MIME-Version: 1.0
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158155490379.3343782.10305190793306743949.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x498sl677cf.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x498sl677cf.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 13 Feb 2020 10:26:49 -0800
Message-ID: <CAPcyv4i8xNEsdX=8c2+ehf24U2AFcc-sKmAPS9UoVvm8z0aRng@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/memremap_pages: Introduce
 memremap_compat_align()
To: Jeff Moyer <jmoyer@redhat.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Vishal L Verma <vishal.l.verma@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 13, 2020 at 8:58 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > The "sub-section memory hotplug" facility allows memremap_pages() users
> > like libnvdimm to compensate for hardware platforms like x86 that have a
> > section size larger than their hardware memory mapping granularity.  The
> > compensation that sub-section support affords is being tolerant of
> > physical memory resources shifting by units smaller (64MiB on x86) than
> > the memory-hotplug section size (128 MiB). Where the platform
> > physical-memory mapping granularity is limited by the number and
> > capability of address-decode-registers in the memory controller.
> >
> > While the sub-section support allows memremap_pages() to operate on
> > sub-section (2MiB) granularity, the Power architecture may still
> > require 16MiB alignment on "!radix_enabled()" platforms.
> >
> > In order for libnvdimm to be able to detect and manage this per-arch
> > limitation, introduce memremap_compat_align() as a common minimum
> > alignment across all driver-facing memory-mapping interfaces, and let
> > Power override it to 16MiB in the "!radix_enabled()" case.
> >
> > The assumption / requirement for 16MiB to be a viable
> > memremap_compat_align() value is that Power does not have platforms
> > where its equivalent of address-decode-registers never hardware remaps a
> > persistent memory resource on smaller than 16MiB boundaries. Note that I
> > tried my best to not add a new Kconfig symbol, but header include
> > entanglements defeated the #ifndef memremap_compat_align design pattern
> > and the need to export it defeats the __weak design pattern for arch
> > overrides.
> >
> > Based on an initial patch by Aneesh.
>
> I have just a couple of questions.
>
> First, can you please add a comment above the generic implementation of
> memremap_compat_align describing its purpose, and why a platform might
> want to override it?

Sure, how about:

/*
 * The memremap() and memremap_pages() interfaces are alternately used
 * to map persistent memory namespaces. These interfaces place different
 * constraints on the alignment and size of the mapping (namespace).
 * memremap() can map individual PAGE_SIZE pages. memremap_pages() can
 * only map subsections (2MB), and at least one architecture (PowerPC)
 * the minimum mapping granularity of memremap_pages() is 16MB.
 *
 * The role of memremap_compat_align() is to communicate the minimum
 * arch supported alignment of a namespace such that it can freely
 * switch modes without violating the arch constraint. Namely, do not
 * allow a namespace to be PAGE_SIZE aligned since that namespace may be
 * reconfigured into a mode that requires SUBSECTION_SIZE alignment.
 */

> Second, I will take it at face value that the power architecture
> requires a 16MB alignment, but it's not clear to me why mmu_linear_psize
> was chosen to represent that.  What's the relationship, there, and can
> we please have a comment explaining it?

Aneesh, can you help here?
