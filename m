Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1C1C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:19:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19D7218AE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19D7218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PjV93H2dzDqPW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 08:19:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.160.196; helo=mail-qt1-f196.google.com;
 envelope-from=mst@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PjSK3lDhzDqJQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 08:17:49 +1100 (AEDT)
Received: by mail-qt1-f196.google.com with SMTP id k2so4392593qtm.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 14:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a98UgajmDxWb2aF6oHX/423eYk98HBkiiFVGvMrbfx0=;
 b=GN5x6CBsFy++0B1z6X4h9lGY2s5r2UVW8T88sP9wk58Dj+85+VOONUH4sG6kLGHnWL
 pTUqA4aLgRrBiY+g+rfG5K75uAEd/lgz9bCxitArs7ov/xzN6vb1W89JdHDonqI7Ptyk
 GfAYJPxRbYq9wh7ZulR/wF6sVjp502xRrQ7xQN2N3LqeuOJfg588zrHr/qWtN+T7eAe1
 KO9YYAGo0g5WH4AzjVkBlz+Ggn/vpn7UftY/Y9ejFQHEoIHSgf5Io8NVsH7deXQYDXhV
 n4OR86wU82SSbt0VFQsdAVHfDrO+TTuvRIv0iTX/osJ5FPyLUV/o/uvahQy9Vh166ThD
 Kb/A==
X-Gm-Message-State: APjAAAUaDSQq8rmeDAxb/YqMyjn+Nu2jzeqdQYdohLrMSRKGzdzra/lW
 Ad5KOQnPupm8s4F1JUFpu3uMlg==
X-Google-Smtp-Source: APXvYqwp+twZXmJoGT/7WThOuIyE+MVFqipZNbV/eZrGUsOUY2I5CsWzMifw27nCVi1KI6OzJX5K4Q==
X-Received: by 2002:ac8:8ea:: with SMTP id y39mr13624qth.2.1553116666956;
 Wed, 20 Mar 2019 14:17:46 -0700 (PDT)
Received: from redhat.com ([195.39.71.253])
 by smtp.gmail.com with ESMTPSA id s78sm3215639qks.0.2019.03.20.14.17.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 20 Mar 2019 14:17:45 -0700 (PDT)
Date: Wed, 20 Mar 2019 17:17:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190320171027-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <877eefxvyb.fsf@morokweng.localdomain>
 <20190204144048-mutt-send-email-mst@kernel.org>
 <87ef71seve.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef71seve.fsf@morokweng.localdomain>
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
Cc: Mike Anderson <andmike@linux.ibm.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 20, 2019 at 01:13:41PM -0300, Thiago Jung Bauermann wrote:
> >> Another way of looking at this issue which also explains our reluctance
> >> is that the only difference between a secure guest and a regular guest
> >> (at least regarding virtio) is that the former uses swiotlb while the
> >> latter doens't.
> >
> > But swiotlb is just one implementation. It's a guest internal thing. The
> > issue is that memory isn't host accessible.
> 
> >From what I understand of the ACCESS_PLATFORM definition, the host will
> only ever try to access memory addresses that are supplied to it by the
> guest, so all of the secure guest memory that the host cares about is
> accessible:
> 
>     If this feature bit is set to 0, then the device has same access to
>     memory addresses supplied to it as the driver has. In particular,
>     the device will always use physical addresses matching addresses
>     used by the driver (typically meaning physical addresses used by the
>     CPU) and not translated further, and can access any address supplied
>     to it by the driver. When clear, this overrides any
>     platform-specific description of whether device access is limited or
>     translated in any way, e.g. whether an IOMMU may be present.
> 
> All of the above is true for POWER guests, whether they are secure
> guests or not.
> 
> Or are you saying that a virtio device may want to access memory
> addresses that weren't supplied to it by the driver?

Your logic would apply to IOMMUs as well.  For your mode, there are
specific encrypted memory regions that driver has access to but device
does not. that seems to violate the constraint.


> >> And from the device's point of view they're
> >> indistinguishable. It can't tell one guest that is using swiotlb from
> >> one that isn't. And that implies that secure guest vs regular guest
> >> isn't a virtio interface issue, it's "guest internal affairs". So
> >> there's no reason to reflect that in the feature flags.
> >
> > So don't. The way not to reflect that in the feature flags is
> > to set ACCESS_PLATFORM.  Then you say *I don't care let platform device*.
> >
> >
> > Without ACCESS_PLATFORM
> > virtio has a very specific opinion about the security of the
> > device, and that opinion is that device is part of the guest
> > supervisor security domain.
> 
> Sorry for being a bit dense, but not sure what "the device is part of
> the guest supervisor security domain" means. In powerpc-speak,
> "supervisor" is the operating system so perhaps that explains my
> confusion. Are you saying that without ACCESS_PLATFORM, the guest
> considers the host to be part of the guest operating system's security
> domain?

I think so. The spec says "device has same access as driver".

> If so, does that have any other implication besides "the host
> can access any address supplied to it by the driver"? If that is the
> case, perhaps the definition of ACCESS_PLATFORM needs to be amended to
> include that information because it's not part of the current
> definition.
> 
> >> That said, we still would like to arrive at a proper design for this
> >> rather than add yet another hack if we can avoid it. So here's another
> >> proposal: considering that the dma-direct code (in kernel/dma/direct.c)
> >> automatically uses swiotlb when necessary (thanks to Christoph's recent
> >> DMA work), would it be ok to replace virtio's own direct-memory code
> >> that is used in the !ACCESS_PLATFORM case with the dma-direct code? That
> >> way we'll get swiotlb even with !ACCESS_PLATFORM, and virtio will get a
> >> code cleanup (replace open-coded stuff with calls to existing
> >> infrastructure).
> >
> > Let's say I have some doubts that there's an API that
> > matches what virtio with its bag of legacy compatibility exactly.
> 
> Ok.
> 
> >> > But the name "sev_active" makes me scared because at least AMD guys who
> >> > were doing the sensible thing and setting ACCESS_PLATFORM
> >>
> >> My understanding is, AMD guest-platform knows in advance that their
> >> guest will run in secure mode and hence sets the flag at the time of VM
> >> instantiation. Unfortunately we dont have that luxury on our platforms.
> >
> > Well you do have that luxury. It looks like that there are existing
> > guests that already acknowledge ACCESS_PLATFORM and you are not happy
> > with how that path is slow. So you are trying to optimize for
> > them by clearing ACCESS_PLATFORM and then you have lost ability
> > to invoke DMA API.
> >
> > For example if there was another flag just like ACCESS_PLATFORM
> > just not yet used by anyone, you would be all fine using that right?
> 
> Yes, a new flag sounds like a great idea. What about the definition
> below?
> 
> VIRTIO_F_ACCESS_PLATFORM_NO_IOMMU This feature has the same meaning as
>     VIRTIO_F_ACCESS_PLATFORM both when set and when not set, with the
>     exception that the IOMMU is explicitly defined to be off or bypassed
>     when accessing memory addresses supplied to the device by the
>     driver. This flag should be set by the guest if offered, but to
>     allow for backward-compatibility device implementations allow for it
>     to be left unset by the guest. It is an error to set both this flag
>     and VIRTIO_F_ACCESS_PLATFORM.

It looks kind of narrow but it's an option.
I wonder how we'll define what's an iommu though.

Another idea is maybe something like virtio-iommu?

> > Is there any justification to doing that beyond someone putting
> > out slow code in the past?
> 
> The definition of the ACCESS_PLATFORM flag is generic and captures the
> notion of memory access restrictions for the device. Unfortunately, on
> powerpc pSeries guests it also implies that the IOMMU is turned on

IIUC that's really because on pSeries IOMMU is *always* turned on.
Platform has no way to say what you want it to say
which is bypass the iommu for the specific device.

> even
> though pSeries guests have never used IOMMU for virtio devices. Combined
> with the lack of a way to turn off or bypass the IOMMU for virtio
> devices, this means that existing guests in the field are compelled to
> use the IOMMU even though that never was the case before, and said
> guests having no mechanism to turn it off.
> 
> Therefore, we need a new flag to signal the memory access restriction
> present in secure guests which doesn't also imply turning on the IOMMU.
> 
> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
