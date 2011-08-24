Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68012B6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 13:37:19 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1314142892.30478.64.camel@pasglop>
Date: Tue, 23 Aug 2011 22:36:59 -0500
Message-Id: <71A184B8-BF29-46AD-A0C1-70941FD36C5F@suse.de>
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
	<1314142892.30478.64.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	iommu <iommu@lists.linux-foundation.org>,
	David Gibson <dwg@au1.ibm.com>, aafabbri <aafabbri@cisco.com>,
	Alex Williamson <alex.williamson@redhat.com>, Avi Kivity <avi@redhat.com>,
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


On 23.08.2011, at 18:41, Benjamin Herrenschmidt wrote:

> On Tue, 2011-08-23 at 10:23 -0600, Alex Williamson wrote:
>>=20
>> Yeah.  Joerg's idea of binding groups internally (pass the fd of one
>> group to another via ioctl) is one option.  The tricky part will be
>> implementing it to support hot unplug of any group from the
>> supergroup.
>> I believe Ben had a suggestion that supergroups could be created in
>> sysfs, but I don't know what the mechanism to do that looks like.  It
>> would also be an extra management step to dynamically bind and unbind
>> groups to the supergroup around hotplug.  Thanks,=20
>=20
> I don't really care that much what the method for creating them is, to
> be honest, I just prefer this concept of "meta groups" or "super =
groups"
> or "synthetic groups" (whatever you want to name them) to having a
> separate uiommu file descriptor.
>=20
> The one reason I have a slight preference for creating them =
"statically"
> using some kind of separate interface (again, I don't care whether =
it's
> sysfs, netlink, etc...) is that it means things like qemu don't have =
to
> care about them.
>=20
> In general, apps that want to use vfio can just get passed the path to
> such a group or the /dev/ path or the group number (whatever we chose =
as
> the way to identify a group), and don't need to know anything about
> "super groups", how to manipulate them, create them, possible
> constraints etc...
>=20
> Now, libvirt might want to know about that other API in order to =
provide
> control on the creation of these things, but that's a different issue.
>=20
> By "static" I mean they persist, they aren't tied to the lifetime of =
an
> fd.
>=20
> Now that's purely a preference on my side because I believe it will =
make
> life easier for actual programs wanting to use vfio to not have to =
care
> about those super-groups, but as I said earlier, I don't actually care
> that much :-)

Oh I think it's one of the building blocks we need for a sane user space =
device exposure API. If I want to pass user X a few devices that are all =
behind a single IOMMU, I just chown that device node to user X and be =
done with it.

The user space tool actually using the VFIO interface wouldn't be in =
configuration business then - and it really shouldn't. That's what =
system configuration is there for :).

But I'm fairly sure we managed to persuade Alex that this is the right =
path on the BOF :)


Alex
