Return-Path: <Joerg.Roedel@amd.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BB0A6B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 23:18:57 +1000 (EST)
Date: Tue, 23 Aug 2011 15:18:19 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110823131819.GO2079@amd.com>
References: <20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<20110822172508.GJ2079@amd.com> <1314047033.7662.39.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1314047033.7662.39.camel@pasglop>
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

On Mon, Aug 22, 2011 at 05:03:53PM -0400, Benjamin Herrenschmidt wrote:
> 
> > I am in favour of /dev/vfio/$GROUP. If multiple devices should be
> > assigned to a guest, there can also be an ioctl to bind a group to an
> > address-space of another group (certainly needs some care to not allow
> > that both groups belong to different processes).
> > 
> > Btw, a problem we havn't talked about yet entirely is
> > driver-deassignment. User space can decide to de-assign the device from
> > vfio while a fd is open on it. With PCI there is no way to let this fail
> > (the .release function returns void last time i checked). Is this a
> > problem, and yes, how we handle that?
> 
> We can treat it as a hard unplug (like a cardbus gone away).
> 
> IE. Dispose of the direct mappings (switch to MMIO emulation) and return
> all ff's from reads (& ignore writes).
> 
> Then send an unplug event via whatever mechanism the platform provides
> (ACPI hotplug controller on x86 for example, we haven't quite sorted out
> what to do on power for hotplug yet).

Hmm, good idea. But as far as I know the hotplug-event needs to be in
the guest _before_ the device is actually unplugged (so that the guest
can unbind its driver first). That somehow brings back the sleep-idea
and the timeout in the .release function.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
