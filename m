Return-Path: <Joerg.Roedel@amd.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0B2DB6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 18:44:06 +1000 (EST)
Date: Wed, 24 Aug 2011 10:43:36 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110824084336.GA2079@amd.com>
References: <1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<20110822055509.GI30097@yookeroo.fritz.box>
	<1314027950.6866.242.camel@x201.home>
	<1314046904.7662.37.camel@pasglop>
	<1314127809.2859.121.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1314127809.2859.121.camel@bling.home>
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

On Tue, Aug 23, 2011 at 03:30:06PM -0400, Alex Williamson wrote:
> On Tue, 2011-08-23 at 07:01 +1000, Benjamin Herrenschmidt wrote:

> > Could be tho in what form ? returning sysfs pathes ?
> 
> I'm at a loss there, please suggest.  I think we need an ioctl that
> returns some kind of array of devices within the group and another that
> maybe takes an index from that array and returns an fd for that device.
> A sysfs path string might be a reasonable array element, but it sounds
> like a pain to work with.

Limiting to PCI we can just pass the BDF as the argument to optain the
device-fd. For a more generic solution we need a unique identifier in
some way which is unique across all 'struct device' instances in the
system. As far as I know we don't have that yet (besides the sysfs-path)
so we either add that or stick with bus-specific solutions.

> > 1:1 process has the advantage of linking to an -mm which makes the whole
> > mmu notifier business doable. How do you want to track down mappings and
> > do the second level translation in the case of explicit map/unmap (like
> > on power) if you are not tied to an mm_struct ?
> 
> Right, I threw away the mmu notifier code that was originally part of
> vfio because we can't do anything useful with it yet on x86.  I
> definitely don't want to prevent it where it makes sense though.  Maybe
> we just record current->mm on open and restrict subsequent opens to the
> same.

Hmm, I think we need io-page-fault support in the iommu-api then.

> > Another aspect I don't see discussed is how we represent these things to
> > the guest.
> > 
> > On Power for example, I have a requirement that a given iommu domain is
> > represented by a single dma window property in the device-tree. What
> > that means is that that property needs to be either in the node of the
> > device itself if there's only one device in the group or in a parent
> > node (ie a bridge or host bridge) if there are multiple devices.
> > 
> > Now I do -not- want to go down the path of simulating P2P bridges,
> > besides we'll quickly run out of bus numbers if we go there.
> > 
> > For us the most simple and logical approach (which is also what pHyp
> > uses and what Linux handles well) is really to expose a given PCI host
> > bridge per group to the guest. Believe it or not, it makes things
> > easier :-)
> 
> I'm all for easier.  Why does exposing the bridge use less bus numbers
> than emulating a bridge?
> 
> On x86, I want to maintain that our default assignment is at the device
> level.  A user should be able to pick single or multiple devices from
> across several groups and have them all show up as individual,
> hotpluggable devices on bus 0 in the guest.  Not surprisingly, we've
> also seen cases where users try to attach a bridge to the guest,
> assuming they'll get all the devices below the bridge, so I'd be in
> favor of making this "just work" if possible too, though we may have to
> prevent hotplug of those.

A side-note: Might it be better to expose assigned devices in a guest on
a seperate bus? This will make it easier to emulate an IOMMU for the
guest inside qemu.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
