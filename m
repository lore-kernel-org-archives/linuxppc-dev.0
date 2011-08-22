Return-Path: <Joerg.Roedel@amd.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7D84B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 03:25:22 +1000 (EST)
Date: Mon, 22 Aug 2011 19:25:08 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110822172508.GJ2079@amd.com>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1313859105.6866.192.camel@x201.home>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>,
	qemu-devel <qemu-devel@nongnu.org>, chrisw <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"benve@cisco.com" <benve@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 20, 2011 at 12:51:39PM -0400, Alex Williamson wrote:
> We had an extremely productive VFIO BoF on Monday.  Here's my attempt to
> capture the plan that I think we agreed to:
> 
> We need to address both the description and enforcement of device
> groups.  Groups are formed any time the iommu does not have resolution
> between a set of devices.  On x86, this typically happens when a
> PCI-to-PCI bridge exists between the set of devices and the iommu.  For
> Power, partitionable endpoints define a group.  Grouping information
> needs to be exposed for both userspace and kernel internal usage.  This
> will be a sysfs attribute setup by the iommu drivers.  Perhaps:
> 
> # cat /sys/devices/pci0000:00/0000:00:19.0/iommu_group
> 42

Right, that is mainly for libvirt to provide that information to the
user in a meaningful way. So userspace is aware that other devices might
not work anymore when it assigns one to a guest.

> 
> (I use a PCI example here, but attribute should not be PCI specific)
> 
> From there we have a few options.  In the BoF we discussed a model where
> binding a device to vfio creates a /dev/vfio$GROUP character device
> file.  This "group" fd provides provides dma mapping ioctls as well as
> ioctls to enumerate and return a "device" fd for each attached member of
> the group (similar to KVM_CREATE_VCPU).  We enforce grouping by
> returning an error on open() of the group fd if there are members of the
> group not bound to the vfio driver.  Each device fd would then support a
> similar set of ioctls and mapping (mmio/pio/config) interface as current
> vfio, except for the obvious domain and dma ioctls superseded by the
> group fd.
> 
> Another valid model might be that /dev/vfio/$GROUP is created for all
> groups when the vfio module is loaded.  The group fd would allow open()
> and some set of iommu querying and device enumeration ioctls, but would
> error on dma mapping and retrieving device fds until all of the group
> devices are bound to the vfio driver.

I am in favour of /dev/vfio/$GROUP. If multiple devices should be
assigned to a guest, there can also be an ioctl to bind a group to an
address-space of another group (certainly needs some care to not allow
that both groups belong to different processes).

Btw, a problem we havn't talked about yet entirely is
driver-deassignment. User space can decide to de-assign the device from
vfio while a fd is open on it. With PCI there is no way to let this fail
(the .release function returns void last time i checked). Is this a
problem, and yes, how we handle that?


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
