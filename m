Return-Path: <Joerg.Roedel@amd.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 01218B6F94
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 23:23:17 +1000 (EST)
Date: Tue, 23 Aug 2011 15:14:41 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110823131441.GN2079@amd.com>
References: <20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<20110822172508.GJ2079@amd.com>
	<1314040622.6866.268.camel@x201.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1314040622.6866.268.camel@x201.home>
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

On Mon, Aug 22, 2011 at 03:17:00PM -0400, Alex Williamson wrote:
> On Mon, 2011-08-22 at 19:25 +0200, Joerg Roedel wrote:

> > I am in favour of /dev/vfio/$GROUP. If multiple devices should be
> > assigned to a guest, there can also be an ioctl to bind a group to an
> > address-space of another group (certainly needs some care to not allow
> > that both groups belong to different processes).
> 
> That's an interesting idea.  Maybe an interface similar to the current
> uiommu interface, where you open() the 2nd group fd and pass the fd via
> ioctl to the primary group.  IOMMUs that don't support this would fail
> the attach device callback, which would fail the ioctl to bind them.  It
> will need to be designed so any group can be removed from the super-set
> and the remaining group(s) still works.  This feels like something that
> can be added after we get an initial implementation.

Handling it through fds is a good idea. This makes sure that everything
belongs to one process. I am not really sure yet if we go the way to
just bind plain groups together or if we create meta-groups. The
meta-groups thing seems somewhat cleaner, though.

> > Btw, a problem we havn't talked about yet entirely is
> > driver-deassignment. User space can decide to de-assign the device from
> > vfio while a fd is open on it. With PCI there is no way to let this fail
> > (the .release function returns void last time i checked). Is this a
> > problem, and yes, how we handle that?
> 
> The current vfio has the same problem, we can't unbind a device from
> vfio while it's attached to a guest.  I think we'd use the same solution
> too; send out a netlink packet for a device removal and have the .remove
> call sleep on a wait_event(, refcnt == 0).  We could also set a timeout
> and SIGBUS the PIDs holding the device if they don't return it
> willingly.  Thanks,

Putting the process to sleep (which would be uninterruptible) seems bad.
The process would sleep until the guest releases the device-group, which
can take days or months.
The best thing (and the most intrusive :-) ) is to change PCI core to
allow unbindings to fail, I think. But this probably further complicates
the way to upstream VFIO...

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
