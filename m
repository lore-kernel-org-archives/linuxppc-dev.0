Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026E2C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 20:25:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C442087C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 20:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C442087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tfNM1BLCzDqKt
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 07:25:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=mst@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tfLc2cVJzDqKt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 07:24:07 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B78DD8830E;
 Mon,  4 Feb 2019 20:24:04 +0000 (UTC)
Received: from redhat.com (ovpn-116-138.sin2.redhat.com [10.67.116.138])
 by smtp.corp.redhat.com (Postfix) with SMTP id C5C03165EE;
 Mon,  4 Feb 2019 20:23:56 +0000 (UTC)
Date: Mon, 4 Feb 2019 15:23:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190204144048-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <877eefxvyb.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877eefxvyb.fsf@morokweng.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 04 Feb 2019 20:24:05 +0000 (UTC)
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
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 04, 2019 at 04:14:20PM -0200, Thiago Jung Bauermann wrote:
> 
> Hello Michael,
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Tue, Jan 29, 2019 at 03:42:44PM -0200, Thiago Jung Bauermann wrote:
> >>
> >> Fixing address of powerpc mailing list.
> >>
> >> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> >>
> >> > Hello,
> >> >
> >> > With Christoph's rework of the DMA API that recently landed, the patch
> >> > below is the only change needed in virtio to make it work in a POWER
> >> > secure guest under the ultravisor.
> >> >
> >> > The other change we need (making sure the device's dma_map_ops is NULL
> >> > so that the dma-direct/swiotlb code is used) can be made in
> >> > powerpc-specific code.
> >> >
> >> > Of course, I also have patches (soon to be posted as RFC) which hook up
> >> > <linux/mem_encrypt.h> to the powerpc secure guest support code.
> >> >
> >> > What do you think?
> >> >
> >> > From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
> >> > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >> > Date: Thu, 24 Jan 2019 22:08:02 -0200
> >> > Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
> >> >
> >> > The host can't access the guest memory when it's encrypted, so using
> >> > regular memory pages for the ring isn't an option. Go through the DMA API.
> >> >
> >> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >
> > Well I think this will come back to bite us (witness xen which is now
> > reworking precisely this path - but at least they aren't to blame, xen
> > came before ACCESS_PLATFORM).
> >
> > I also still think the right thing would have been to set
> > ACCESS_PLATFORM for all systems where device can't access all memory.
> 
> I understand. The problem with that approach for us is that because we
> don't know which guests will become secure guests and which will remain
> regular guests, QEMU would need to offer ACCESS_PLATFORM to all guests.
> 
> And the problem with that is that for QEMU on POWER, having
> ACCESS_PLATFORM turned off means that it can bypass the IOMMU for the
> device (which makes sense considering that the name of the flag was
> IOMMU_PLATFORM). And we need that for regular guests to avoid
> performance degradation.

You don't really, ACCESS_PLATFORM means just that, platform decides.

> So while ACCESS_PLATFORM solves our problems for secure guests, we can't
> turn it on by default because we can't affect legacy systems. Doing so
> would penalize existing systems that can access all memory. They would
> all have to unnecessarily go through address translations, and take a
> performance hit.

So as step one, you just give hypervisor admin an option to run legacy
systems faster by blocking secure mode. I don't see why that is
so terrible.

But as step two, assuming you use above step one to make legacy
guests go fast - maybe there is a point in detecting
such a hypervisor and doing something smarter with it.
By all means let's have a discussion around this but that is no longer
"to make it work" as the commit log says it's more a performance
optimization.


> The semantics of ACCESS_PLATFORM assume that the hypervisor/QEMU knows
> in advance - right when the VM is instantiated - that it will not have
> access to all guest memory.

Not quite. It just means that hypervisor can live with not having
access to all memory. If platform wants to give it access
to all memory that is quite all right.


> Unfortunately that assumption is subtly
> broken on our secure-platform. The hypervisor/QEMU realizes that the
> platform is going secure only *after the VM is instantiated*. It's the
> kernel running in the VM that determines that it wants to switch the
> platform to secure-mode.

ACCESS_PLATFORM is there so guests can detect legacy hypervisors
which always assumed it's another CPU.

> Another way of looking at this issue which also explains our reluctance
> is that the only difference between a secure guest and a regular guest
> (at least regarding virtio) is that the former uses swiotlb while the
> latter doens't.

But swiotlb is just one implementation. It's a guest internal thing. The
issue is that memory isn't host accessible.  Yes linux does not use that
info too much right now but it already begins to seep out of the
abstraction.  For example as you are doing data copies you should maybe
calculate the packet checksum just as well.  Not something DMA API will
let you know right now, but that's because any bounce buffer users so
far weren't terribly fast anyway - it was all for 16 bit hardware and
such.


> And from the device's point of view they're
> indistinguishable. It can't tell one guest that is using swiotlb from
> one that isn't. And that implies that secure guest vs regular guest
> isn't a virtio interface issue, it's "guest internal affairs". So
> there's no reason to reflect that in the feature flags.

So don't. The way not to reflect that in the feature flags is
to set ACCESS_PLATFORM.  Then you say *I don't care let platform device*.


Without ACCESS_PLATFORM
virtio has a very specific opinion about the security of the
device, and that opinion is that device is part of the guest
supervisor security domain.




> That said, we still would like to arrive at a proper design for this
> rather than add yet another hack if we can avoid it. So here's another
> proposal: considering that the dma-direct code (in kernel/dma/direct.c)
> automatically uses swiotlb when necessary (thanks to Christoph's recent
> DMA work), would it be ok to replace virtio's own direct-memory code
> that is used in the !ACCESS_PLATFORM case with the dma-direct code? That
> way we'll get swiotlb even with !ACCESS_PLATFORM, and virtio will get a
> code cleanup (replace open-coded stuff with calls to existing
> infrastructure).

Let's say I have some doubts that there's an API that
matches what virtio with its bag of legacy compatibility exactly.

But taking a step back you seem to keep looking at it at the code level.
And I think that's not necessarily right. If ACCESS_PLATFORM isn't what you
are looking for then maybe you need another feature bit.
But you/we need to figure out what it means first.




> > But I also think I don't have the energy to argue about power secure
> > guest anymore.  So be it for power secure guest since the involved
> > engineers disagree with me.  Hey I've been wrong in the past ;).
> 
> Yeah, it's been a difficult discussion. Thanks for still engaging!
> I honestly thought that this patch was a good solution (if the guest has
> encrypted memory it means that the DMA API needs to be used), but I can
> see where you are coming from. As I said, we'd like to arrive at a good
> solution if possible.
> 
> > But the name "sev_active" makes me scared because at least AMD guys who
> > were doing the sensible thing and setting ACCESS_PLATFORM
> 
> My understanding is, AMD guest-platform knows in advance that their
> guest will run in secure mode and hence sets the flag at the time of VM
> instantiation. Unfortunately we dont have that luxury on our platforms.

Well you do have that luxury. It looks like that there are existing
guests that already acknowledge ACCESS_PLATFORM and you are not happy
with how that path is slow. So you are trying to optimize for
them by clearing ACCESS_PLATFORM and then you have lost ability
to invoke DMA API.

For example if there was another flag just like ACCESS_PLATFORM
just not yet used by anyone, you would be all fine using that right?

Is there any justification to doing that beyond someone putting
out slow code in the past?


> > (unless I'm
> > wrong? I reemember distinctly that's so) will likely be affected too.
> > We don't want that.
> >
> > So let's find a way to make sure it's just power secure guest for now
> > pls.
> 
> Yes, my understanding is that they turn ACCESS_PLATFORM on. And because
> of that, IIUC this patch wouldn't affect them because in their platform
> vring_use_dma_api() returns true earlier in the
> "if !virtio_has_iommu_quirk(vdev)" condition.

Let's just say I don't think we should assume how the specific hypervisor
behaves. It seems to follow the spec and so should Linux.

> > I also think we should add a dma_api near features under virtio_device
> > such that these hacks can move off data path.
> 
> Sorry, I don't understand this.

I mean we can set a flag within struct virtio_device instead
of poking at features checking xen etc etc.

> > By the way could you please respond about virtio-iommu and
> > why there's no support for ACCESS_PLATFORM on power?
> 
> There is support for ACCESS_PLATFORM on POWER. We don't enable it
> because it causes a performance hit.

For legacy guests.

> > I have Cc'd you on these discussions.
> 
> I'm having a look at the spec and the patches, but to be honest I'm not
> the best powerpc guy for this. I'll see if I can get others to have a
> look.
> 
> > Thanks!
> 
> Thanks as well!
> 
> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
