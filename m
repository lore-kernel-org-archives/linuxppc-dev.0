Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 23053B6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 06:54:07 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4E51F782.7060005@redhat.com>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>  <4E51F782.7060005@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Aug 2011 06:53:46 +1000
Message-ID: <1314046426.7662.30.camel@pasglop>
Mime-Version: 1.0
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	iommu <iommu@lists.linux-foundation.org>, aafabbri <aafabbri@cisco.com>,
	Alex Williamson <alex.williamson@redhat.com>,
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

On Mon, 2011-08-22 at 09:30 +0300, Avi Kivity wrote:
> On 08/20/2011 07:51 PM, Alex Williamson wrote:
> > We need to address both the description and enforcement of device
> > groups.  Groups are formed any time the iommu does not have resolution
> > between a set of devices.  On x86, this typically happens when a
> > PCI-to-PCI bridge exists between the set of devices and the iommu.  For
> > Power, partitionable endpoints define a group.  Grouping information
> > needs to be exposed for both userspace and kernel internal usage.  This
> > will be a sysfs attribute setup by the iommu drivers.  Perhaps:
> >
> > # cat /sys/devices/pci0000:00/0000:00:19.0/iommu_group
> > 42
> >
> 
> $ readlink /sys/devices/pci0000:00/0000:00:19.0/iommu_group
> ../../../path/to/device/which/represents/the/resource/constraint
> 
> (the pci-to-pci bridge on x86, or whatever node represents partitionable 
> endpoints on power)

The constraint might not necessarily be a device.

The PCI bridge is just an example. There are other possible constraints.
On POWER for example, it could be a limit in how far I can segment the
DMA address space, forcing me to arbitrarily put devices together, or it
could be a similar constraint related to how the MMIO space is broken
up.

So either that remains a path in which case we do have a separate set of
sysfs nodes representing the groups themselves which may or may not
itself contain a pointer to the "constraining" device, or we just make
that an arbitrary number (in my case the PE#)

Cheers,
Ben
