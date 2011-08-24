Return-Path: <Joerg.Roedel@amd.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D995BB6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 18:55:42 +1000 (EST)
Date: Wed, 24 Aug 2011 10:53:21 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110824085321.GC2079@amd.com>
References: <1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<20110822172508.GJ2079@amd.com> <1314047033.7662.39.camel@pasglop>
	<20110823131819.GO2079@amd.com> <1314142537.30478.59.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1314142537.30478.59.camel@pasglop>
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

On Tue, Aug 23, 2011 at 07:35:37PM -0400, Benjamin Herrenschmidt wrote:
> On Tue, 2011-08-23 at 15:18 +0200, Roedel, Joerg wrote:

> > Hmm, good idea. But as far as I know the hotplug-event needs to be in
> > the guest _before_ the device is actually unplugged (so that the guest
> > can unbind its driver first). That somehow brings back the sleep-idea
> > and the timeout in the .release function.
> 
> That's for normal assisted hotplug, but don't we support hard hotplug ?
> I mean, things like cardbus, thunderbolt (if we ever support that)
> etc... will need it and some platforms do support hard hotplug of PCIe
> devices.
> 
> (That's why drivers should never spin on MMIO waiting for a 1 bit to
> clear without a timeout :-)

Right, thats probably the best semantic for this issue then. The worst
thing that happens is that the admin crashed the guest.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
