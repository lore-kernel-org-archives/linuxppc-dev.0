Return-Path: <Joerg.Roedel@amd.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94A93B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Aug 2011 21:02:44 +1000 (EST)
Date: Thu, 25 Aug 2011 13:01:22 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110825110122.GC1923@amd.com>
References: <4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<20110822055509.GI30097@yookeroo.fritz.box>
	<1314027950.6866.242.camel@x201.home>
	<1314046904.7662.37.camel@pasglop>
	<1314127809.2859.121.camel@bling.home>
	<20110824084336.GA2079@amd.com>
	<1314197775.2859.182.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1314197775.2859.182.camel@bling.home>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	David Gibson <dwg@au1.ibm.com>, chrisw <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
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

On Wed, Aug 24, 2011 at 10:56:13AM -0400, Alex Williamson wrote:
> On Wed, 2011-08-24 at 10:43 +0200, Joerg Roedel wrote:
> > A side-note: Might it be better to expose assigned devices in a guest on
> > a seperate bus? This will make it easier to emulate an IOMMU for the
> > guest inside qemu.
> 
> I think we want that option, sure.  A lot of guests aren't going to
> support hotplugging buses though, so I think our default, map the entire
> guest model should still be using bus 0.  The ACPI gets a lot more
> complicated for that model too; dynamic SSDTs?  Thanks,

Ok, if only AMD-Vi should be emulated then it is not strictly
necessary. For this IOMMU we can specify that devices on the same bus
belong to different IOMMUs. So we can implement an IOMMU that handles
internal qemu-devices and one that handles pass-through devices.
Not sure if this is possible with VT-d too. Okay VT-d emulation would
also require that the devices emulation of a PCIe bridge, no?

Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
