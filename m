Return-Path: <benh@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2EB3ADDDF8
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 11:30:35 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.6) with ESMTP id l09CWALa1101918
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 11:32:14 -0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l090XaoV245692
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 11:33:41 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l090U7I4024570
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 11:30:08 +1100
Subject: Re: EMAC OF binding....
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <27d6554d600437ed39853784c0cf96fd@kernel.crashing.org>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1168288352.22458.198.camel@localhost.localdomain>
	<5f992368c65d3d53003b0e9f2955ae79@kernel.crashing.org>
	<1168296460.22458.232.camel@localhost.localdomain>
	<27d6554d600437ed39853784c0cf96fd@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 11:30:07 +1100
Message-Id: <1168302607.22458.242.camel@localhost.localdomain>
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


> Oh you misunderstand what I mean.  I'm just saying the
> registers that are shared are in some other node (having
> the same regs in two nodes can't happen).
> 
> Let's hope the hardware is sane enough that you can
> describe it in a sane way.
> 
> You would probably end up with properties in the SoC
> node like "emac-#0" containing the phandle of the first
> emac, or something like that -- the number of the emac
> on the SoC is not a property of the emac, but of the SoC
> itself.
> 
> I don't know the exact programming interface so I'm not
> completely sure of course, but please consider.

I'm not sure I follow you... for example, I may have some clock contro
register somewhere with one bit enabling EMAC 0 clock and one bit
enabling EMAC 1 clock...

Easier to call some platform clock management giving my device-node as
an argument and have that code extract the EMAC "index" from the DT from
my node.

> >> MTU is dynamic, max-frame-size isn't.  max-frame-size is just
> >> the maximum packet size you can tell the network controller to
> >> put on the wire, not counting protocol overhead etc.
> >
> > Ah ok.
> 
> It sounds like max-frame-size is exactly what you wanted
> this new max-mtu property for, right?  [Oh and btw, max-mtu
> is a really bad name -- "max-max-tu" heh].

Hehe, yes ok, I'll have a look at the spec to be sure.

Ben.
