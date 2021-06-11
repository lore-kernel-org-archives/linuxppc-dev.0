Return-Path: <SRS0=pFgb=LF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D241C48BE0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 15:40:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71900613CD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 15:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71900613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G1lRH32QXz3c9G
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jun 2021 01:40:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UdgbVNlC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::82a;
 helo=mail-qt1-x82a.google.com; envelope-from=tientzu@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UdgbVNlC; dkim-atps=neutral
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G1lQd5KJZz3btQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jun 2021 01:39:51 +1000 (AEST)
Received: by mail-qt1-x82a.google.com with SMTP id g12so2906812qtb.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=89FDdm5otB6kfSIY1wN8GtI+ciQx5v+glSl+A+k1+x0=;
 b=UdgbVNlCM2Z2m4AZZMvHuq5iZqq6a6B1k1NgNWN8Vbr0FhlXEkOMcXQOmqkTt81W9l
 ZZvZ8qEfilw4IVJQmcyphxlOFoGk0yzalYprjSKjTm0i0iDciVsO4hDbAAQ2CGlI10y9
 ZbSgy3asVidQE8sG2vEkYEnh2JJM0V3DCy6O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=89FDdm5otB6kfSIY1wN8GtI+ciQx5v+glSl+A+k1+x0=;
 b=T0GVKT5kMKocTUAA8+cjLVDlpu1AZ7VtKJi0R4+Bm/0qLG0fxdPsuI0vXmGfPZQiDj
 c1/3xTfZvqglnRv5lYUQtx+f24hZJSIqr5LfJKffdBcLnQKtCm9DzaJZLI45/97LNHTp
 jNnM9o6VbJdnV24i7umUhFb4y3POrRRx3kS42Wg5/MNt+pzF6fRi7Ghk+NXQJPAAZOb1
 dOpkVsOV11O2qvBC3AqYB+9zdtgKDmpOe1goXDwD60DhWqpaAcfQlQoCX9PAoiT//OB9
 mFmg8590+639vkOU+1gP9/IcWKVQLzi+db8L/JNr/Vo171inN9UjnQdi3Hg0rPdd9fPL
 eW8g==
X-Gm-Message-State: AOAM533Apv3LhwtZpIVe8K8m8S+POVy4o1Dz7H3K61zcHxZdHrssDrgu
 Da3z92rVk5XAwMKWs+x0IqJJrc9kPq+EKA==
X-Google-Smtp-Source: ABdhPJztDODPqTvBTi5xbVzmZIYpQJfc2jvstxCrVta4ynlcYGgeZuPhy3YdB6FUcOQscT3brRPlLA==
X-Received: by 2002:ac8:46d1:: with SMTP id h17mr4362024qto.135.1623425986620; 
 Fri, 11 Jun 2021 08:39:46 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com.
 [209.85.160.182])
 by smtp.gmail.com with ESMTPSA id x66sm4620743qkc.100.2021.06.11.08.39.46
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jun 2021 08:39:46 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id z4so2896448qts.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 08:39:46 -0700 (PDT)
X-Received: by 2002:a05:6638:151:: with SMTP id
 y17mr4471864jao.128.1623425522838; 
 Fri, 11 Jun 2021 08:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210527125845.1852284-1-tientzu@chromium.org>
 <20210604174818.GC3703@willie-the-truck>
 <CALiNf29=z2uBM1ZA_GTu04iFS2dJwH0npdGvid1PL5KQM_HrxA@mail.gmail.com>
In-Reply-To: <CALiNf29=z2uBM1ZA_GTu04iFS2dJwH0npdGvid1PL5KQM_HrxA@mail.gmail.com>
From: Claire Chang <tientzu@chromium.org>
Date: Fri, 11 Jun 2021 23:31:52 +0800
X-Gmail-Original-Message-ID: <CALiNf29RGoFq7L+t_Bi6TsE-93-=m49DdV6QrVBV=pvoAjKsvw@mail.gmail.com>
Message-ID: <CALiNf29RGoFq7L+t_Bi6TsE-93-=m49DdV6QrVBV=pvoAjKsvw@mail.gmail.com>
Subject: Re: [PATCH v8 00/15] Restricted DMA
To: Will Deacon <will@kernel.org>
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
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, joonas.lahtinen@linux.intel.com,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 grant.likely@arm.com, paulus@samba.org, Frank Rowand <frowand.list@gmail.com>,
 mingo@kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 Joerg Roedel <joro@8bytes.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Jianxiong Gao <jxgao@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@chromium.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

v9 here: https://lore.kernel.org/patchwork/cover/1445081/

On Mon, Jun 7, 2021 at 11:28 AM Claire Chang <tientzu@chromium.org> wrote:
>
> On Sat, Jun 5, 2021 at 1:48 AM Will Deacon <will@kernel.org> wrote:
> >
> > Hi Claire,
> >
> > On Thu, May 27, 2021 at 08:58:30PM +0800, Claire Chang wrote:
> > > This series implements mitigations for lack of DMA access control on
> > > systems without an IOMMU, which could result in the DMA accessing the
> > > system memory at unexpected times and/or unexpected addresses, possibly
> > > leading to data leakage or corruption.
> > >
> > > For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
> > > not behind an IOMMU. As PCI-e, by design, gives the device full access to
> > > system memory, a vulnerability in the Wi-Fi firmware could easily escalate
> > > to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
> > > full chain of exploits; [2], [3]).
> > >
> > > To mitigate the security concerns, we introduce restricted DMA. Restricted
> > > DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
> > > specially allocated region and does memory allocation from the same region.
> > > The feature on its own provides a basic level of protection against the DMA
> > > overwriting buffer contents at unexpected times. However, to protect
> > > against general data leakage and system memory corruption, the system needs
> > > to provide a way to restrict the DMA to a predefined memory region (this is
> > > usually done at firmware level, e.g. MPU in ATF on some ARM platforms [4]).
> > >
> > > [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> > > [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> > > [2] https://blade.tencent.com/en/advisories/qualpwn/
> > > [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
> > > [4] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132
> > >
> > > v8:
> > > - Fix reserved-memory.txt and add the reg property in example.
> > > - Fix sizeof for of_property_count_elems_of_size in
> > >   drivers/of/address.c#of_dma_set_restricted_buffer.
> > > - Apply Will's suggestion to try the OF node having DMA configuration in
> > >   drivers/of/address.c#of_dma_set_restricted_buffer.
> > > - Fix typo in the comment of drivers/of/address.c#of_dma_set_restricted_buffer.
> > > - Add error message for PageHighMem in
> > >   kernel/dma/swiotlb.c#rmem_swiotlb_device_init and move it to
> > >   rmem_swiotlb_setup.
> > > - Fix the message string in rmem_swiotlb_setup.
> >
> > Thanks for the v8. It works for me out of the box on arm64 under KVM, so:
> >
> > Tested-by: Will Deacon <will@kernel.org>
> >
> > Note that something seems to have gone wrong with the mail threading, so
> > the last 5 patches ended up as a separate thread for me. Probably worth
> > posting again with all the patches in one place, if you can.
>
> Thanks for testing.
>
> Christoph also added some comments in v7, so I'll prepare v9.
>
> >
> > Cheers,
> >
> > Will
