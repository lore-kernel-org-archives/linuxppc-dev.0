Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03A33B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 13:40:49 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1314143508.30478.72.camel@pasglop>
Date: Tue, 23 Aug 2011 22:40:39 -0500
Message-Id: <230DE86D-4CDF-45DD-8400-69A72B8A3B52@suse.de>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<20110822055509.GI30097@yookeroo.fritz.box>
	<1314027950.6866.242.camel@x201.home>
	<1314046904.7662.37.camel@pasglop>
	<1314127809.2859.121.camel@bling.home>
	<1314143508.30478.72.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: aafabbri <aafabbri@cisco.com>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org list" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, linux-pci@vger.kernel.org,
	qemu-devel Developers <qemu-devel@nongnu.org>,
	iommu <iommu@lists.linux-foundation.org>, David Gibson <dwg@au1.ibm.com>,
	chrisw Wright <chrisw@sous-sol.org>,
	Alex Williamson <alex.williamson@redhat.com>, Avi Kivity <avi@redhat.com>,
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


On 23.08.2011, at 18:51, Benjamin Herrenschmidt wrote:

>=20
>>> For us the most simple and logical approach (which is also what pHyp
>>> uses and what Linux handles well) is really to expose a given PCI =
host
>>> bridge per group to the guest. Believe it or not, it makes things
>>> easier :-)
>>=20
>> I'm all for easier.  Why does exposing the bridge use less bus =
numbers
>> than emulating a bridge?
>=20
> Because a host bridge doesn't look like a PCI to PCI bridge at all for
> us. It's an entire separate domain with it's own bus number space
> (unlike most x86 setups).
>=20
> In fact we have some problems afaik in qemu today with the concept of
> PCI domains, for example, I think qemu has assumptions about a single
> shared IO space domain which isn't true for us (each PCI host bridge
> provides a distinct IO space domain starting at 0). We'll have to fix
> that, but it's not a huge deal.
>=20
> So for each "group" we'd expose in the guest an entire separate PCI
> domain space with its own IO, MMIO etc... spaces, handed off from a
> single device-tree "host bridge" which doesn't itself appear in the
> config space, doesn't need any emulation of any config space etc...
>=20
>> On x86, I want to maintain that our default assignment is at the =
device
>> level.  A user should be able to pick single or multiple devices from
>> across several groups and have them all show up as individual,
>> hotpluggable devices on bus 0 in the guest.  Not surprisingly, we've
>> also seen cases where users try to attach a bridge to the guest,
>> assuming they'll get all the devices below the bridge, so I'd be in
>> favor of making this "just work" if possible too, though we may have =
to
>> prevent hotplug of those.
>>=20
>> Given the device requirement on x86 and since everything is a PCI =
device
>> on x86, I'd like to keep a qemu command line something like -device
>> vfio,host=3D00:19.0.  I assume that some of the iommu properties, =
such as
>> dma window size/address, will be query-able through an architecture
>> specific (or general if possible) ioctl on the vfio group fd.  I hope
>> that will help the specification, but I don't fully understand what =
all
>> remains.  Thanks,
>=20
> Well, for iommu there's a couple of different issues here but yes,
> basically on one side we'll have some kind of ioctl to know what =
segment
> of the device(s) DMA address space is assigned to the group and we'll
> need to represent that to the guest via a device-tree property in some
> kind of "parent" node of all the devices in that group.
>=20
> We -might- be able to implement some kind of hotplug of individual
> devices of a group under such a PHB (PCI Host Bridge), I don't know =
for
> sure yet, some of that PAPR stuff is pretty arcane, but basically, for
> all intend and purpose, we really want a group to be represented as a
> PHB in the guest.
>=20
> We cannot arbitrary have individual devices of separate groups be
> represented in the guest as siblings on a single simulated PCI bus.

So would it make sense for you to go the same route that we need to go =
on embedded power, with a separate VFIO style interface that simply =
exports memory ranges and irq bindings, but doesn't know anything about =
PCI? For e500, we'll be using something like that to pass through a full =
PCI bus into the system.


Alex
