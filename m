Return-Path: <benh@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82AC5DDDF9
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 09:47:45 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id l08N1SwS316374
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 10:01:28 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l08MpC6e223134
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 09:51:12 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l08MlhCr022810
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 09:47:43 +1100
Subject: Re: EMAC OF binding....
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <5f992368c65d3d53003b0e9f2955ae79@kernel.crashing.org>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1168288352.22458.198.camel@localhost.localdomain>
	<5f992368c65d3d53003b0e9f2955ae79@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 09:47:40 +1100
Message-Id: <1168296460.22458.232.camel@localhost.localdomain>
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


> 
> So this is for accessing some shared SoC registers?  The emac
> node has no business with that, you should have a separate
> node for that (and you probably do already, you can use the
> parent bus node in most such cases).

If I needed a separate node for every shared SoC bit, I would have a
>2MB device-tree :-)

There are just a few places where I need to call some platform code and
tell it what EMAC in the chip it is so it can go tweak the right magic
bits, best is a property for that.

> >>>  - max-mtu           : 1 cell, maximum MTU supported in bytes
> >>
> >> See "max-frame-size", MTU is on a higher level than device
> >> level and as such shouldn't be here; the OF networking layer
> >> can set something like this if it wants.
> >
> > Except that I don't want OF to set anything dynamically here. This is a
> > way to prevent EMAC to do jumbo frames in fact.
> 
> MTU is dynamic, max-frame-size isn't.  max-frame-size is just
> the maximum packet size you can tell the network controller to
> put on the wire, not counting protocol overhead etc.

Ah ok.

Ben.
