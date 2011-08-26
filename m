Return-Path: <Joerg.Roedel@amd.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 937FDB6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 19:34:10 +1000 (EST)
Date: Fri, 26 Aug 2011 11:33:56 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: aafabbri <aafabbri@cisco.com>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Mackerras
	<pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, chrisw <chrisw@sous-sol.org>, iommu
	<iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>, Anthony
	Liguori <anthony@codemonkey.ws>, linuxppc-dev
	<linuxppc-dev@lists.ozlabs.org>, "benve@cisco.com" <benve@cisco.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110826093356.GP1923@amd.com>
References: <20110823110431.GK2079@amd.com> <CA792953.FB87%aafabbri@cisco.com>
	<20110824091425.GE2079@amd.com>
	<20110824093300.GI30097@yookeroo.fritz.box>
	<20110824110332.GH2079@amd.com>
	<20110826042000.GE2308@yookeroo.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110826042000.GE2308@yookeroo.fritz.box>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 26, 2011 at 12:20:00AM -0400, David Gibson wrote:
> On Wed, Aug 24, 2011 at 01:03:32PM +0200, Roedel, Joerg wrote:
> > On Wed, Aug 24, 2011 at 05:33:00AM -0400, David Gibson wrote:
> > > On Wed, Aug 24, 2011 at 11:14:26AM +0200, Roedel, Joerg wrote:
> > 
> > > > I don't see a reason to make this meta-grouping static. It would harm
> > > > flexibility on x86. I think it makes things easier on power but there
> > > > are options on that platform to get the dynamic solution too.
> > > 
> > > I think several people are misreading what Ben means by "static".  I
> > > would prefer to say 'persistent', in that the meta-groups lifetime is
> > > not tied to an fd, but they can be freely created, altered and removed
> > > during runtime.
> > 
> > Even if it can be altered at runtime, from a usability perspective it is
> > certainly the best to handle these groups directly in qemu. Or are there
> > strong reasons to do it somewhere else?
> 
> Funny, Ben and I think usability demands it be the other way around.

The reason is that you mean the usability for the programmer and I mean
it for the actual user of qemu :)

> If the meta-groups are transient - that is lifetime tied to an fd -
> then any program that wants to use meta-groups *must* know the
> interfaces for creating one, whatever they are.
> 
> But if they're persistent, the admin can use other tools to create the
> meta-group then just hand it to a program to use, since the interfaces
> for _using_ a meta-group are identical to those for an atomic group.
> 
> This doesn't preclude a program from being meta-group aware, and
> creating its own if it wants to, of course.  My guess is that qemu
> would not want to build its own meta-groups, but libvirt probably
> would.

Doing it in libvirt makes it really hard for a plain user of qemu to
assign more than one device to a guest. What I want it that a user just
types

	qemu -device vfio,host=00:01.0 -device vfio,host=00:02.0 ...

and it just works. Qemu creates the meta-groups and they are
automatically destroyed when qemu exits. That the programs are not aware
of meta-groups is not a big problem because all software using vfio
needs still to be written :)

Btw, with this concept the programmer can still decide to not use
meta-groups and just multiplex the mappings to all open device-fds it
uses.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
