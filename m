Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7B57B70FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 12:52:38 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
In-Reply-To: <1312932258.4524.55.camel@bling.home>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 09 Aug 2011 21:48:33 -0500
Message-ID: <1312944513.29273.28.camel@pasglop>
Mime-Version: 1.0
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, aafabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, benve@cisco.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Mostly correct, yes.  x86 isn't immune to the group problem, it shows up
> for us any time there's a PCIe-to-PCI bridge in the device hierarchy.
> We lose resolution of devices behind the bridge.  As you state though, I
> think of this as only a constraint on what we're able to do with those
> devices.
> 
> Perhaps part of the differences is that on x86 the constraints don't
> really effect how we expose devices to the guest.  We need to hold
> unused devices in the group hostage and use the same iommu domain for
> any devices assigned, but that's not visible to the guest.  AIUI, POWER
> probably needs to expose the bridge (or at least an emulated bridge) to
> the guest, any devices in the group need to show up behind that bridge,

Yes, pretty much, essentially because a group must have as shared iommu
domain and so due to the way our PV representation works, that means the
iommu DMA window is to be exposed by a bridge that covers all the
devices of that group.

> some kind of pvDMA needs to be associated with that group, there might
> be MMIO segments and IOVA windows, etc.  

The MMIO segments are mostly transparent to the guest, we just tell it
where the BARs are and it leaves them alone, at least that's how it
works under pHyp.

Currently on our qemu/vfio expriments, we do let the guest do the BAR
assignment via the emulated stuff using a hack to work around the guest
expectation that the BARs have been already setup (I can fill you on the
details if you really care but it's not very interesting). It works
because we only ever used that on setups where we had a device == a
group, but it's nasty. But in any case, because they are going to be
always in separate pages, it's not too hard for KVM to remap them
wherewver we want so MMIO is basically a non-issue.

> Effectively you want to
> transplant the entire group into the guest.  Is that right?  Thanks,

Well, at least we want to have a bridge for the group (it could and
probably should be a host bridge, ie, an entire PCI domain, that's a lot
easier than trying to mess around with virtual P2P bridges).

>From there, I don't care if we need to expose explicitly each device of
that group one by one. IE. It would be a nice "optimziation" to have the
ability to just specify the group and have qemu pick them all up but it
doesn't really matter in the grand scheme of things.

Currently, we do expose individual devices, but again, it's hacks and it
won't work on many setups etc... with horrid consequences :-) We need to
sort that before we can even think of merging that code on our side.

Cheers,
Ben.

> Alex
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
