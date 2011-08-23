Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5886B6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 09:42:21 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
In-Reply-To: <1314116600.2859.28.camel@bling.home>
References: <20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<20110822055509.GI30097@yookeroo.fritz.box>
	<1314027950.6866.242.camel@x201.home>
	<20110823023822.GO30097@yookeroo.fritz.box>
	<1314116600.2859.28.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Aug 2011 09:41:32 +1000
Message-ID: <1314142892.30478.64.camel@pasglop>
Mime-Version: 1.0
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	David Gibson <dwg@au1.ibm.com>, aafabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
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

On Tue, 2011-08-23 at 10:23 -0600, Alex Williamson wrote:
> 
> Yeah.  Joerg's idea of binding groups internally (pass the fd of one
> group to another via ioctl) is one option.  The tricky part will be
> implementing it to support hot unplug of any group from the
> supergroup.
> I believe Ben had a suggestion that supergroups could be created in
> sysfs, but I don't know what the mechanism to do that looks like.  It
> would also be an extra management step to dynamically bind and unbind
> groups to the supergroup around hotplug.  Thanks, 

I don't really care that much what the method for creating them is, to
be honest, I just prefer this concept of "meta groups" or "super groups"
or "synthetic groups" (whatever you want to name them) to having a
separate uiommu file descriptor.

The one reason I have a slight preference for creating them "statically"
using some kind of separate interface (again, I don't care whether it's
sysfs, netlink, etc...) is that it means things like qemu don't have to
care about them.

In general, apps that want to use vfio can just get passed the path to
such a group or the /dev/ path or the group number (whatever we chose as
the way to identify a group), and don't need to know anything about
"super groups", how to manipulate them, create them, possible
constraints etc...

Now, libvirt might want to know about that other API in order to provide
control on the creation of these things, but that's a different issue.

By "static" I mean they persist, they aren't tied to the lifetime of an
fd.

Now that's purely a preference on my side because I believe it will make
life easier for actual programs wanting to use vfio to not have to care
about those super-groups, but as I said earlier, I don't actually care
that much :-)

Cheers,
Ben.
