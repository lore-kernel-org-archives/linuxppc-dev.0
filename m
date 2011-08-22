Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 551C9B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 07:04:46 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joerg Roedel <joerg.roedel@amd.com>
In-Reply-To: <20110822172508.GJ2079@amd.com>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home> <20110822172508.GJ2079@amd.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Aug 2011 07:03:53 +1000
Message-ID: <1314047033.7662.39.camel@pasglop>
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	iommu <iommu@lists.linux-foundation.org>, chrisw <chrisw@sous-sol.org>,
	Alex Williamson <alex.williamson@redhat.com>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
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


> I am in favour of /dev/vfio/$GROUP. If multiple devices should be
> assigned to a guest, there can also be an ioctl to bind a group to an
> address-space of another group (certainly needs some care to not allow
> that both groups belong to different processes).
> 
> Btw, a problem we havn't talked about yet entirely is
> driver-deassignment. User space can decide to de-assign the device from
> vfio while a fd is open on it. With PCI there is no way to let this fail
> (the .release function returns void last time i checked). Is this a
> problem, and yes, how we handle that?

We can treat it as a hard unplug (like a cardbus gone away).

IE. Dispose of the direct mappings (switch to MMIO emulation) and return
all ff's from reads (& ignore writes).

Then send an unplug event via whatever mechanism the platform provides
(ACPI hotplug controller on x86 for example, we haven't quite sorted out
what to do on power for hotplug yet).

Cheers,
Ben.
