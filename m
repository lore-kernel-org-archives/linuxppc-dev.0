Return-Path: <Joerg.Roedel@amd.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FE08B6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Aug 2011 20:49:36 +1000 (EST)
Date: Mon, 22 Aug 2011 12:46:35 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
To: Avi Kivity <avi@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110822104635.GC2079@amd.com>
References: <1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home> <4E51F782.7060005@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4E51F782.7060005@redhat.com>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
	iommu <iommu@lists.linux-foundation.org>, chrisw <chrisw@sous-sol.org>,
	Alex Williamson <alex.williamson@redhat.com>,
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

On Mon, Aug 22, 2011 at 02:30:26AM -0400, Avi Kivity wrote:
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

That does not work. The bridge in question may not even be visible as a
PCI device, so you can't link to it. This is the case on a few PCIe
cards which only have a PCIx chip and a PCIe-2-PCIx bridge to implement
the PCIe interface (yes, I have seen those cards).

Regards,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
