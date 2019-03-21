Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D71C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 18:21:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B256721874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 18:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B256721874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QFVC5ZQQzDqV2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 05:21:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QFSB2mxfzDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 05:19:38 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 590A61E308;
 Thu, 21 Mar 2019 18:19:36 +0000 (UTC)
Received: from x1.home (ovpn-116-218.phx2.redhat.com [10.3.116.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5646560563;
 Thu, 21 Mar 2019 18:19:34 +0000 (UTC)
Date: Thu, 21 Mar 2019 12:19:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel RFC 2/2] vfio-pci-nvlink2: Implement interconnect
 isolation
Message-ID: <20190321121934.283cdc67@x1.home>
In-Reply-To: <20190320235600.GB2501@umbus.fritz.box>
References: <20190315081835.14083-1-aik@ozlabs.ru>
 <20190315081835.14083-3-aik@ozlabs.ru>
 <20190319103619.6534c7df@x1.home>
 <20190320043824.GG31018@umbus.fritz.box>
 <20190320130908.4f837995@x1.home>
 <20190320235600.GB2501@umbus.fritz.box>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 21 Mar 2019 18:19:36 +0000 (UTC)
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Leonardo Augusto =?UTF-8?B?R3VpbWFyw6Nlcw==?= Garcia <lagarcia@br.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 21 Mar 2019 10:56:00 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Mar 20, 2019 at 01:09:08PM -0600, Alex Williamson wrote:
> > On Wed, 20 Mar 2019 15:38:24 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >   
> > > On Tue, Mar 19, 2019 at 10:36:19AM -0600, Alex Williamson wrote:  
> > > > On Fri, 15 Mar 2019 19:18:35 +1100
> > > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > > >     
> > > > > The NVIDIA V100 SXM2 GPUs are connected to the CPU via PCIe links and
> > > > > (on POWER9) NVLinks. In addition to that, GPUs themselves have direct
> > > > > peer to peer NVLinks in groups of 2 to 4 GPUs. At the moment the POWERNV
> > > > > platform puts all interconnected GPUs to the same IOMMU group.
> > > > > 
> > > > > However the user may want to pass individual GPUs to the userspace so
> > > > > in order to do so we need to put them into separate IOMMU groups and
> > > > > cut off the interconnects.
> > > > > 
> > > > > Thankfully V100 GPUs implement an interface to do by programming link
> > > > > disabling mask to BAR0 of a GPU. Once a link is disabled in a GPU using
> > > > > this interface, it cannot be re-enabled until the secondary bus reset is
> > > > > issued to the GPU.
> > > > > 
> > > > > This defines a reset_done() handler for V100 NVlink2 device which
> > > > > determines what links need to be disabled. This relies on presence
> > > > > of the new "ibm,nvlink-peers" device tree property of a GPU telling which
> > > > > PCI peers it is connected to (which includes NVLink bridges or peer GPUs).
> > > > > 
> > > > > This does not change the existing behaviour and instead adds
> > > > > a new "isolate_nvlink" kernel parameter to allow such isolation.
> > > > > 
> > > > > The alternative approaches would be:
> > > > > 
> > > > > 1. do this in the system firmware (skiboot) but for that we would need
> > > > > to tell skiboot via an additional OPAL call whether or not we want this
> > > > > isolation - skiboot is unaware of IOMMU groups.
> > > > > 
> > > > > 2. do this in the secondary bus reset handler in the POWERNV platform -
> > > > > the problem with that is at that point the device is not enabled, i.e.
> > > > > config space is not restored so we need to enable the device (i.e. MMIO
> > > > > bit in CMD register + program valid address to BAR0) in order to disable
> > > > > links and then perhaps undo all this initialization to bring the device
> > > > > back to the state where pci_try_reset_function() expects it to be.    
> > > > 
> > > > The trouble seems to be that this approach only maintains the isolation
> > > > exposed by the IOMMU group when vfio-pci is the active driver for the
> > > > device.  IOMMU groups can be used by any driver and the IOMMU core is
> > > > incorporating groups in various ways.    
> > > 
> > > I don't think that reasoning is quite right.  An IOMMU group doesn't
> > > necessarily represent devices which *are* isolated, just devices which
> > > *can be* isolated.  There are plenty of instances when we don't need
> > > to isolate devices in different IOMMU groups: passing both groups to
> > > the same guest or userspace VFIO driver for example, or indeed when
> > > both groups are owned by regular host kernel drivers.
> > > 
> > > In at least some of those cases we also don't want to isolate the
> > > devices when we don't have to, usually for performance reasons.  
> > 
> > I see IOMMU groups as representing the current isolation of the device,
> > not just the possible isolation.  If there are ways to break down that
> > isolation then ideally the group would be updated to reflect it.  The
> > ACS disable patches seem to support this, at boot time we can choose to
> > disable ACS at certain points in the topology to favor peer-to-peer
> > performance over isolation.  This is then reflected in the group
> > composition, because even though ACS *can be* enabled at the given
> > isolation points, it's intentionally not with this option.  Whether or
> > not a given user who owns multiple devices needs that isolation is
> > really beside the point, the user can choose to connect groups via IOMMU
> > mappings or reconfigure the system to disable ACS and potentially more
> > direct routing.  The IOMMU groups are still accurately reflecting the
> > topology and IOMMU based isolation.  
> 
> Huh, ok, I think we need to straighten this out.  Thinking of iommu
> groups as possible rather than potential isolation was a conscious

possible ~= potential

> decision on my part when we were first coming up with them.  The
> rationale was that that way iommu groups could be static for the
> lifetime of boot, with more dynamic isolation state layered on top.
> 
> Now, that was based on analogy with PAPR's concept of "Partitionable
> Endpoints" which are decided by firmware before boot.  However, I
> think it makes sense in other contexts too: if iommu groups represent
> current isolation, then we need some other way to advertise possible
> isolation - otherwise how will the admin (and/or tools) know how it
> can configure the iommu groups.
> 
> VFIO already has the container, which represents explicitly a "group
> of groups" that we don't care to isolate from each other.  I don't
> actually know what other uses of the iommu group infrastructure we
> have at present and how they treat them.

s/that we don't care to isolate/that the user doesn't care to isolate/

Though even that is not necessarily accurate, the container represents
a shared IOMMU context, that context doesn't necessarily include
mappings between devices, so the device can still be isolated *from
each other*.

> So, if we now have dynamically reconfigurable groups which are a
> departure from that design, how can we go from here trying to bring
> things back to consistency.

We don't currently have dynamically reconfigurable groups, I think the
question is how do we introduce dynamically configurable groups within
the existing design, because whatever intentions were 7.5 years ago is
rather irrelevant now.

VFIO groups are mapped directly to IOMMU groups.  IOMMU groups are the
smallest set of devices which can be considered isolated from other
sets of devices (not potentially, but as configured).  VFIO groups are
the unit of ownership to userspace, therefore a VFIO group must be
(currently) isolated from other groups.  The user owns and manages the
IOMMU context for one or more groups via a container.  A container
allows efficiency in managing a shared IOVA space between groups.

> > > > So, if there's a device specific
> > > > way to configure the isolation reported in the group, which requires
> > > > some sort of active management against things like secondary bus
> > > > resets, then I think we need to manage it above the attached endpoint
> > > > driver.    
> > > 
> > > The problem is that above the endpoint driver, we don't actually have
> > > enough information about what should be isolated.  For VFIO we want to
> > > isolate things if they're in different containers, for most regular
> > > host kernel drivers we don't need to isolate at all (although we might
> > > as well when it doesn't have a cost).  
> > 
> > This idea that we only want to isolate things if they're in different
> > containers is bogus, imo.  There are performance reasons why we might
> > not want things isolated, but there are also address space reasons why
> > we do.  If there are direct routes between devices, the user needs to
> > be aware of the IOVA pollution, if we maintain singleton groups, they
> > don't.  Granted we don't really account for this well in most
> > userspaces and fumble through it by luck of the address space layout
> > and lack of devices really attempting peer to peer access.  
> 
> I don't really follow what you're saying here.

If the lack of isolation between devices includes peer-to-peer channels
then the MMIO of the devices within the group pollutes the IOVA space
of the container.
 
> > For in-kernel users, we're still theoretically trying to isolate
> > devices such that they have restricted access to only the resources
> > they need.  Disabling things like ACS in the topology reduces that
> > isolation.  AFAICT, most users don't really care about that degree of
> > isolation, so they run with iommu=pt for native driver performance
> > while still having the IOMMU available for isolation use cases running
> > in parallel.  We don't currently have support for on-demand enabling
> > isolation.  
> 
> Ok.
> 
> > > The host side nVidia GPGPU
> > > drivers also won't want to isolate the (host owned) NVLink devices
> > > from each other, since they'll want to use the fast interconnects  
> > 
> > This falls into the same mixed use case scenario above where we don't
> > really have a good solution today.  Things like ACS are dynamically
> > configurable, but we don't expose any interfaces to let drivers or
> > users change it (aside from setpci, which we don't account for
> > dynamically).  We assume a simplistic model where if you want IOMMU,
> > then you must also want the maximum configurable isolation.
> > Dynamically changing routing is not necessarily the most foolproof
> > thing either with potentially in-flight transactions and existing DMA
> > mappings, which is why I've suggested a couple times that perhaps we
> > could do a software hot-unplug of a sub-hierarchy, muck with isolation
> > at the remaining node, then re-discover the removed devices.  
> 
> Ok, so I feel like we need to go fully one way or the other.  Either:
> 
> 1) Groups represent current isolation status, in which case we
>    deprecate vfio containers in favour of fusing groups beforehand,
>    and we need some new concept ("isolation atoms"?) to represent what
>    isolation is possible

Nope, containers are owned by users and serve a purpose beyond what
you're assuming here.  Also, there's 7.5 years of userspace tooling
broken by this.  I do remember we had discussions about merging groups,
but what we have now is what we agreed on.
 
> or
> 
> 2) Groups represent potential isolation, with a higher level construct
>    representing current isolation.  This could involve making vfio
>    containers essentially a wrapper around some more generic concept
>    ("isolation clusters"?) of a group of groups.

Have fun.  Containers and groups are exposed to userspace, so you're
essentially suggesting to throw away all that support, for... I don't
really know what.  Groups are involved in IOMMU context, so dynamically
changing what a group defines is hard.  Thus my suggestions that mixed
or dynamic workloads could make use of soft remove and rediscovery for
sub-hierarchies, unbinding and rebinding drivers such that we have the
proper expectations of DMA context.   Thanks,

Alex
