Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2983EC282E2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 23:10:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6497A21736
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 23:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6497A21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44mBXv4Sn0zDqW5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 09:10:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.160.193; helo=mail-qt1-f193.google.com;
 envelope-from=mst@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mBW66bBgzDqVZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 09:09:21 +1000 (AEST)
Received: by mail-qt1-f193.google.com with SMTP id i14so6802694qtr.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 16:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eiIG7Pb3xDPcfV7jEiMiHEtsXa/Lg5s5QjuoOEMCk98=;
 b=O56PaJ2dLazZpLpIY1pglx81QJXzpjKBrnavNqEbfMyKxHEMbmX+3P0z37F7Z6l9gd
 zx3XuM7hWl63M8LMBBq+yToraZUQmzIT4F6YKiEzOnYcg8whAX/a41rmYHn4uuhIOWT0
 GnkGBAno0HHvSjuku0frkNvjT+Ajxa82fu6FA8rU97+Fc9DUMIuj0/+VQQWDWuEgNoEG
 CKYI3OuHX3MudOi3Lll+QWzRxJafeyUMaD5etSDVo9wdZ4pWW2w3bamQ13HZsKzNk9fK
 0xV+go/RHgDkSv7lIJZ4CXVMfxPh0hRdrqZzTy/Om43+M+RAMw3rkRqRV7SgaZ/65HYe
 7lLA==
X-Gm-Message-State: APjAAAVy/GV0XSQ4oRVaoPpVPelb6NLRE5EQ81oJu4v6rC1NbPK6VGr3
 fuVBxZ9igW2rsA7F05dEL0ZG7A==
X-Google-Smtp-Source: APXvYqzc+Oknvzn5/bfow/gVNDiuxgawFCmjDhR4so8tN2tHXw8P82DLmcdD4cOgfhPRh23gLYZ3MA==
X-Received: by 2002:ac8:5298:: with SMTP id s24mr3022746qtn.263.1555715358471; 
 Fri, 19 Apr 2019 16:09:18 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
 [173.76.246.42])
 by smtp.gmail.com with ESMTPSA id f129sm2699616qkj.47.2019.04.19.16.09.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 19 Apr 2019 16:09:17 -0700 (PDT)
Date: Fri, 19 Apr 2019 19:09:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190419190258-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <877eefxvyb.fsf@morokweng.localdomain>
 <20190204144048-mutt-send-email-mst@kernel.org>
 <87ef71seve.fsf@morokweng.localdomain>
 <20190320171027-mutt-send-email-mst@kernel.org>
 <87tvfvbwpb.fsf@morokweng.localdomain>
 <20190323165456-mutt-send-email-mst@kernel.org>
 <87a7go71hz.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7go71hz.fsf@morokweng.localdomain>
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

On Wed, Apr 17, 2019 at 06:42:00PM -0300, Thiago Jung Bauermann wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Thu, Mar 21, 2019 at 09:05:04PM -0300, Thiago Jung Bauermann wrote:
> >>
> >> Michael S. Tsirkin <mst@redhat.com> writes:
> >>
> >> > On Wed, Mar 20, 2019 at 01:13:41PM -0300, Thiago Jung Bauermann wrote:
> >> >> >From what I understand of the ACCESS_PLATFORM definition, the host will
> >> >> only ever try to access memory addresses that are supplied to it by the
> >> >> guest, so all of the secure guest memory that the host cares about is
> >> >> accessible:
> >> >>
> >> >>     If this feature bit is set to 0, then the device has same access to
> >> >>     memory addresses supplied to it as the driver has. In particular,
> >> >>     the device will always use physical addresses matching addresses
> >> >>     used by the driver (typically meaning physical addresses used by the
> >> >>     CPU) and not translated further, and can access any address supplied
> >> >>     to it by the driver. When clear, this overrides any
> >> >>     platform-specific description of whether device access is limited or
> >> >>     translated in any way, e.g. whether an IOMMU may be present.
> >> >>
> >> >> All of the above is true for POWER guests, whether they are secure
> >> >> guests or not.
> >> >>
> >> >> Or are you saying that a virtio device may want to access memory
> >> >> addresses that weren't supplied to it by the driver?
> >> >
> >> > Your logic would apply to IOMMUs as well.  For your mode, there are
> >> > specific encrypted memory regions that driver has access to but device
> >> > does not. that seems to violate the constraint.
> >>
> >> Right, if there's a pre-configured 1:1 mapping in the IOMMU such that
> >> the device can ignore the IOMMU for all practical purposes I would
> >> indeed say that the logic would apply to IOMMUs as well. :-)
> >>
> >> I guess I'm still struggling with the purpose of signalling to the
> >> driver that the host may not have access to memory addresses that it
> >> will never try to access.
> >
> > For example, one of the benefits is to signal to host that driver does
> > not expect ability to access all memory. If it does, host can
> > fail initialization gracefully.
> 
> But why would the ability to access all memory be necessary or even
> useful? When would the host access memory that the driver didn't tell it
> to access?

When I say all memory I mean even memory not allowed by the IOMMU.


> >> >> >> > But the name "sev_active" makes me scared because at least AMD guys who
> >> >> >> > were doing the sensible thing and setting ACCESS_PLATFORM
> >> >> >>
> >> >> >> My understanding is, AMD guest-platform knows in advance that their
> >> >> >> guest will run in secure mode and hence sets the flag at the time of VM
> >> >> >> instantiation. Unfortunately we dont have that luxury on our platforms.
> >> >> >
> >> >> > Well you do have that luxury. It looks like that there are existing
> >> >> > guests that already acknowledge ACCESS_PLATFORM and you are not happy
> >> >> > with how that path is slow. So you are trying to optimize for
> >> >> > them by clearing ACCESS_PLATFORM and then you have lost ability
> >> >> > to invoke DMA API.
> >> >> >
> >> >> > For example if there was another flag just like ACCESS_PLATFORM
> >> >> > just not yet used by anyone, you would be all fine using that right?
> >> >>
> >> >> Yes, a new flag sounds like a great idea. What about the definition
> >> >> below?
> >> >>
> >> >> VIRTIO_F_ACCESS_PLATFORM_NO_IOMMU This feature has the same meaning as
> >> >>     VIRTIO_F_ACCESS_PLATFORM both when set and when not set, with the
> >> >>     exception that the IOMMU is explicitly defined to be off or bypassed
> >> >>     when accessing memory addresses supplied to the device by the
> >> >>     driver. This flag should be set by the guest if offered, but to
> >> >>     allow for backward-compatibility device implementations allow for it
> >> >>     to be left unset by the guest. It is an error to set both this flag
> >> >>     and VIRTIO_F_ACCESS_PLATFORM.
> >> >
> >> > It looks kind of narrow but it's an option.
> >>
> >> Great!
> >>
> >> > I wonder how we'll define what's an iommu though.
> >>
> >> Hm, it didn't occur to me it could be an issue. I'll try.
> 
> I rephrased it in terms of address translation. What do you think of
> this version? The flag name is slightly different too:
> 
> 
> VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION This feature has the same
>     meaning as VIRTIO_F_ACCESS_PLATFORM both when set and when not set,
>     with the exception that address translation is guaranteed to be
>     unnecessary when accessing memory addresses supplied to the device
>     by the driver. Which is to say, the device will always use physical
>     addresses matching addresses used by the driver (typically meaning
>     physical addresses used by the CPU) and not translated further. This
>     flag should be set by the guest if offered, but to allow for
>     backward-compatibility device implementations allow for it to be
>     left unset by the guest. It is an error to set both this flag and
>     VIRTIO_F_ACCESS_PLATFORM.

Thanks, I'll think about this approach. Will respond next week.

> >> > Another idea is maybe something like virtio-iommu?
> >>
> >> You mean, have legacy guests use virtio-iommu to request an IOMMU
> >> bypass? If so, it's an interesting idea for new guests but it doesn't
> >> help with guests that are out today in the field, which don't have A
> >> virtio-iommu driver.
> >
> > I presume legacy guests don't use encrypted memory so why do we
> > worry about them at all?
> 
> They don't use encrypted memory, but a host machine will run a mix of
> secure and legacy guests. And since the hypervisor doesn't know whether
> a guest will be secure or not at the time it is launched, legacy guests
> will have to be launched with the same configuration as secure guests.

OK and so I think the issue is that hosts generally fail if they set
ACCESS_PLATFORM and guests do not negotiate it.
So you can not just set ACCESS_PLATFORM for everyone.
Is that the issue here?


> >> >> > Is there any justification to doing that beyond someone putting
> >> >> > out slow code in the past?
> >> >>
> >> >> The definition of the ACCESS_PLATFORM flag is generic and captures the
> >> >> notion of memory access restrictions for the device. Unfortunately, on
> >> >> powerpc pSeries guests it also implies that the IOMMU is turned on
> >> >
> >> > IIUC that's really because on pSeries IOMMU is *always* turned on.
> >> > Platform has no way to say what you want it to say
> >> > which is bypass the iommu for the specific device.
> >>
> >> Yes, that's correct. pSeries guests running on KVM are in a gray area
> >> where theoretically they use an IOMMU but in practice KVM ignores it.
> >> It's unfortunate but it's the reality on the ground today. :-/
> >
> > Well it's not just the reality, virt setups need something that
> > emulated IOMMUs don't provide. That is not uncommon, e.g.
> > intel's VTD has a "cache mode" field which AFAIK is only used for virt.
> 
> That's good to know. Thanks for this example.
> 
> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
