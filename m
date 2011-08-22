Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 00FE0B6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Aug 2011 16:31:10 +1000 (EST)
Message-ID: <4E51F782.7060005@redhat.com>
Date: Mon, 22 Aug 2011 09:30:26 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
In-Reply-To: <1313859105.6866.192.camel@x201.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	qemu-devel <qemu-devel@nongnu.org>, aafabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, benve@cisco.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/20/2011 07:51 PM, Alex Williamson wrote:
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
>

$ readlink /sys/devices/pci0000:00/0000:00:19.0/iommu_group
../../../path/to/device/which/represents/the/resource/constraint

(the pci-to-pci bridge on x86, or whatever node represents partitionable 
endpoints on power)

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
