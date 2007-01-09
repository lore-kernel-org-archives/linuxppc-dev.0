Return-Path: <benh@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C4C6DDDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 09:42:31 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.6) with ESMTP id l0AAiCOk7041234
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 09:44:12 -0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l09MjuvN218360
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 09:45:56 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l09MgRx9005130
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 09:42:27 +1100
Subject: Re: EMAC OF binding....
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <c191ad29e827e1e26464cde281f88ef5@kernel.crashing.org>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1168288352.22458.198.camel@localhost.localdomain>
	<5f992368c65d3d53003b0e9f2955ae79@kernel.crashing.org>
	<1168296460.22458.232.camel@localhost.localdomain>
	<27d6554d600437ed39853784c0cf96fd@kernel.crashing.org>
	<1168302607.22458.242.camel@localhost.localdomain>
	<9a44c3bbc4ab67921f784f16991889bd@kernel.crashing.org>
	<1168379157.22458.307.camel@localhost.localdomain>
	<e4d627ebdd8e678a0441bc0649714de8@kernel.crashing.org>
	<1168380289.22458.313.camel@localhost.localdomain>
	<c191ad29e827e1e26464cde281f88ef5@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 09:42:23 +1100
Message-Id: <1168382543.22458.318.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>, Murali N Iyer <mniyer@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-09 at 23:17 +0100, Segher Boessenkool wrote:
> > I don't see the need of having some weird "soc" node that doesn't quite
> > mean anything (especially on axon) that has phandles to every sub 
> > device
> > in there :-)
> 
> Well simply, if I understood you correctly, you have some
> register where some bits control emac #0 and some control
> emac #1.  This register can't belong to either of those
> devices because it can't belong to both, so it has to
> belong to some "control" / "power management" / whatever
> device.
> 
> > On those ASICs, every device almost needs to know what is it's "cell
> > index" because of little details here or there.
> 
> Yes.
> 
> > I really see that as an
> > attribute of the device and thus should be a property of the node.
> 
> You still need to describe that register somewhere in the
> device tree.

I will not describe every single weird clock control or other magic DCRs
in the device-tree. That is simply over-bloat. We don't describe the U3
clock control or PM registers on js2x's for example, nor do we describe
the various individual registers controlling the HT link...

Ben.
