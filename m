Return-Path: <SRS0=CEjL=R2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C992C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 21:03:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB303217D8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 21:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB303217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44RY0B6RK2zDqNV
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Mar 2019 08:03:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.160.193; helo=mail-qt1-f193.google.com;
 envelope-from=mst@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44RXyL3YwzzDqNV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2019 08:01:44 +1100 (AEDT)
Received: by mail-qt1-f193.google.com with SMTP id k14so6394797qtb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 14:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7Y/C6/J6hvHhGRPZPY/ty2xFGm7d+nEAkW6LEJpVPLE=;
 b=HXiFMqtFKmRMOOVwdSHnjHHBe2qZ4aUiSqKojgs7K14RLpK3ZJtIe3CE7+R3ewKS6k
 ahO4HndzcgaDxLSZYIzb/bWeDm7gaOsk73ZRvRRf34I8FwMDz0ZQYrDoVTt0vXOBiY88
 q4LFxT0RxM7ihweIKy0EQLBPgihGrxPgZkgjtJkls+U8+kWWx7OEiAAy/xq9i1SJGueE
 4+fgy1pPWu9kWeVa2ONg8GtOyLDupvLap+Q63eNC/7zasNWDkWihw1Gr5H6Mq6MZn7+U
 V0qyOlli43z8Ab440lsqh3MlwIbFCc3dTNnBWNzzkBqaT3u2naxL+oRjtbFhwhL4WFHO
 YgWg==
X-Gm-Message-State: APjAAAVtGmE1ZNwRYvqPsb2WjYjMSfaRktXKtqFONnJcKnpgiYT3C31m
 AYF9D6zD4NJVhtoJADDVp5NClg==
X-Google-Smtp-Source: APXvYqyPvN4NsVhkdWrG9MPXcrjtVKC6+Or/OUcqjEZeYjzRvDY4vPXN9sGnLdtpnzI7/6dYjl/3QA==
X-Received: by 2002:a0c:b0ea:: with SMTP id p39mr13958691qvc.132.1553374901511; 
 Sat, 23 Mar 2019 14:01:41 -0700 (PDT)
Received: from redhat.com ([195.39.71.253])
 by smtp.gmail.com with ESMTPSA id e2sm6955552qkd.7.2019.03.23.14.01.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 23 Mar 2019 14:01:40 -0700 (PDT)
Date: Sat, 23 Mar 2019 17:01:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190323165456-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <877eefxvyb.fsf@morokweng.localdomain>
 <20190204144048-mutt-send-email-mst@kernel.org>
 <87ef71seve.fsf@morokweng.localdomain>
 <20190320171027-mutt-send-email-mst@kernel.org>
 <87tvfvbwpb.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvfvbwpb.fsf@morokweng.localdomain>
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

On Thu, Mar 21, 2019 at 09:05:04PM -0300, Thiago Jung Bauermann wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Wed, Mar 20, 2019 at 01:13:41PM -0300, Thiago Jung Bauermann wrote:
> >> >> Another way of looking at this issue which also explains our reluctance
> >> >> is that the only difference between a secure guest and a regular guest
> >> >> (at least regarding virtio) is that the former uses swiotlb while the
> >> >> latter doens't.
> >> >
> >> > But swiotlb is just one implementation. It's a guest internal thing. The
> >> > issue is that memory isn't host accessible.
> >>
> >> >From what I understand of the ACCESS_PLATFORM definition, the host will
> >> only ever try to access memory addresses that are supplied to it by the
> >> guest, so all of the secure guest memory that the host cares about is
> >> accessible:
> >>
> >>     If this feature bit is set to 0, then the device has same access to
> >>     memory addresses supplied to it as the driver has. In particular,
> >>     the device will always use physical addresses matching addresses
> >>     used by the driver (typically meaning physical addresses used by the
> >>     CPU) and not translated further, and can access any address supplied
> >>     to it by the driver. When clear, this overrides any
> >>     platform-specific description of whether device access is limited or
> >>     translated in any way, e.g. whether an IOMMU may be present.
> >>
> >> All of the above is true for POWER guests, whether they are secure
> >> guests or not.
> >>
> >> Or are you saying that a virtio device may want to access memory
> >> addresses that weren't supplied to it by the driver?
> >
> > Your logic would apply to IOMMUs as well.  For your mode, there are
> > specific encrypted memory regions that driver has access to but device
> > does not. that seems to violate the constraint.
> 
> Right, if there's a pre-configured 1:1 mapping in the IOMMU such that
> the device can ignore the IOMMU for all practical purposes I would
> indeed say that the logic would apply to IOMMUs as well. :-)
> 
> I guess I'm still struggling with the purpose of signalling to the
> driver that the host may not have access to memory addresses that it
> will never try to access.

For example, one of the benefits is to signal to host that driver does
not expect ability to access all memory. If it does, host can
fail initialization gracefully.

> >> >> And from the device's point of view they're
> >> >> indistinguishable. It can't tell one guest that is using swiotlb from
> >> >> one that isn't. And that implies that secure guest vs regular guest
> >> >> isn't a virtio interface issue, it's "guest internal affairs". So
> >> >> there's no reason to reflect that in the feature flags.
> >> >
> >> > So don't. The way not to reflect that in the feature flags is
> >> > to set ACCESS_PLATFORM.  Then you say *I don't care let platform device*.
> >> >
> >> >
> >> > Without ACCESS_PLATFORM
> >> > virtio has a very specific opinion about the security of the
> >> > device, and that opinion is that device is part of the guest
> >> > supervisor security domain.
> >>
> >> Sorry for being a bit dense, but not sure what "the device is part of
> >> the guest supervisor security domain" means. In powerpc-speak,
> >> "supervisor" is the operating system so perhaps that explains my
> >> confusion. Are you saying that without ACCESS_PLATFORM, the guest
> >> considers the host to be part of the guest operating system's security
> >> domain?
> >
> > I think so. The spec says "device has same access as driver".
> 
> Ok, makes sense.
> 
> >> If so, does that have any other implication besides "the host
> >> can access any address supplied to it by the driver"? If that is the
> >> case, perhaps the definition of ACCESS_PLATFORM needs to be amended to
> >> include that information because it's not part of the current
> >> definition.
> >>
> >> >> > But the name "sev_active" makes me scared because at least AMD guys who
> >> >> > were doing the sensible thing and setting ACCESS_PLATFORM
> >> >>
> >> >> My understanding is, AMD guest-platform knows in advance that their
> >> >> guest will run in secure mode and hence sets the flag at the time of VM
> >> >> instantiation. Unfortunately we dont have that luxury on our platforms.
> >> >
> >> > Well you do have that luxury. It looks like that there are existing
> >> > guests that already acknowledge ACCESS_PLATFORM and you are not happy
> >> > with how that path is slow. So you are trying to optimize for
> >> > them by clearing ACCESS_PLATFORM and then you have lost ability
> >> > to invoke DMA API.
> >> >
> >> > For example if there was another flag just like ACCESS_PLATFORM
> >> > just not yet used by anyone, you would be all fine using that right?
> >>
> >> Yes, a new flag sounds like a great idea. What about the definition
> >> below?
> >>
> >> VIRTIO_F_ACCESS_PLATFORM_NO_IOMMU This feature has the same meaning as
> >>     VIRTIO_F_ACCESS_PLATFORM both when set and when not set, with the
> >>     exception that the IOMMU is explicitly defined to be off or bypassed
> >>     when accessing memory addresses supplied to the device by the
> >>     driver. This flag should be set by the guest if offered, but to
> >>     allow for backward-compatibility device implementations allow for it
> >>     to be left unset by the guest. It is an error to set both this flag
> >>     and VIRTIO_F_ACCESS_PLATFORM.
> >
> > It looks kind of narrow but it's an option.
> 
> Great!
> 
> > I wonder how we'll define what's an iommu though.
> 
> Hm, it didn't occur to me it could be an issue. I'll try.
> 
> > Another idea is maybe something like virtio-iommu?
> 
> You mean, have legacy guests use virtio-iommu to request an IOMMU
> bypass? If so, it's an interesting idea for new guests but it doesn't
> help with guests that are out today in the field, which don't have A
> virtio-iommu driver.

I presume legacy guests don't use encrypted memory so why do we
worry about them at all?

> >> > Is there any justification to doing that beyond someone putting
> >> > out slow code in the past?
> >>
> >> The definition of the ACCESS_PLATFORM flag is generic and captures the
> >> notion of memory access restrictions for the device. Unfortunately, on
> >> powerpc pSeries guests it also implies that the IOMMU is turned on
> >
> > IIUC that's really because on pSeries IOMMU is *always* turned on.
> > Platform has no way to say what you want it to say
> > which is bypass the iommu for the specific device.
> 
> Yes, that's correct. pSeries guests running on KVM are in a gray area
> where theoretically they use an IOMMU but in practice KVM ignores it.
> It's unfortunate but it's the reality on the ground today. :-/

Well it's not just the reality, virt setups need something that
emulated IOMMUs don't provide. That is not uncommon, e.g.
intel's VTD has a "cache mode" field which AFAIK is only used for virt.

> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
