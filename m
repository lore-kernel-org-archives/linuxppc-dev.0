Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07D86B6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 14:24:32 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7Q4I87t028072
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2011 14:18:08 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7Q4N9nR880816
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2011 14:23:09 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7Q4OSJ6010386
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2011 14:24:29 +1000
Date: Fri, 26 Aug 2011 14:20:00 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110826042000.GE2308@yookeroo.fritz.box>
References: <20110823110431.GK2079@amd.com> <CA792953.FB87%aafabbri@cisco.com>
	<20110824091425.GE2079@amd.com>
	<20110824093300.GI30097@yookeroo.fritz.box>
	<20110824110332.GH2079@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110824110332.GH2079@amd.com>
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, aafabbri <aafabbri@cisco.com>,
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

On Wed, Aug 24, 2011 at 01:03:32PM +0200, Roedel, Joerg wrote:
> On Wed, Aug 24, 2011 at 05:33:00AM -0400, David Gibson wrote:
> > On Wed, Aug 24, 2011 at 11:14:26AM +0200, Roedel, Joerg wrote:
> 
> > > I don't see a reason to make this meta-grouping static. It would harm
> > > flexibility on x86. I think it makes things easier on power but there
> > > are options on that platform to get the dynamic solution too.
> > 
> > I think several people are misreading what Ben means by "static".  I
> > would prefer to say 'persistent', in that the meta-groups lifetime is
> > not tied to an fd, but they can be freely created, altered and removed
> > during runtime.
> 
> Even if it can be altered at runtime, from a usability perspective it is
> certainly the best to handle these groups directly in qemu. Or are there
> strong reasons to do it somewhere else?

Funny, Ben and I think usability demands it be the other way around.

If the meta-groups are transient - that is lifetime tied to an fd -
then any program that wants to use meta-groups *must* know the
interfaces for creating one, whatever they are.

But if they're persistent, the admin can use other tools to create the
meta-group then just hand it to a program to use, since the interfaces
for _using_ a meta-group are identical to those for an atomic group.

This doesn't preclude a program from being meta-group aware, and
creating its own if it wants to, of course.  My guess is that qemu
would not want to build its own meta-groups, but libvirt probably
would.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
