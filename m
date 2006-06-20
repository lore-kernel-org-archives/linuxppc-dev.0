Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E119A67B27
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 11:18:21 +1000 (EST)
Subject: Re: [RFC] Interrupt mapping documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <Becky.Bruce@freescale.com>
In-Reply-To: <40AABEB6-3467-4AFB-BC7B-08176EDD61E2@freescale.com>
References: <1150598731.23600.146.camel@localhost.localdomain>
	<EC61A880-9242-4BCE-B72D-8AFC038CD592@freescale.com>
	<3E324A7E-388E-4917-B380-B0831A5F9D19@kernel.crashing.org>
	<1150759075.23600.297.camel@localhost.localdomain>
	<40AABEB6-3467-4AFB-BC7B-08176EDD61E2@freescale.com>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 11:18:06 +1000
Message-Id: <1150766286.23600.316.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> If there's precedence for it, it's fine with me.  I was just curious  
> about why it changed.  Personally, I'd rather see it as "pic",  
> because that's more specific, and it's the actual device name, but  
> it's not keeping me up at night.....

I'll revert the example to "pic". I thing Segher is right, let's leave
some freedom there.

> That also works for me.  I'd rather have to specify more stuff in the  
> tree and have it be crystal clear how it's interpreted and used.  So,  
> is this true for just #address-cells, or does it affect #size-cells  
> as well?

Yes. The OF spec says that #size-cells defaults to 1 when absent but I'd
rather make it mandatory. It's not used for interrupt tree resolving
though thus it's not necessary in interrupt-controller nodes.

> Sounds good.  The dtc should probably throw an error (or at least a  
> warning) on this, so the trees get fixed.  I think I'd prefer to see  
> an error - that will keep this problem from propagating any further.

Yup.

> > In the case of interrupt controllers/nexus, #address-cells is not for
> > addressable sub-nodes though but for defining the format of unit
> > interrupt specifiers for interrupt-childs which aren't necessary sub
> > nodes... confusing heh ?
> 
> Um, yeah :)  I think with a little clarification it will be fine,  
> though.

Yeah, it's a bit complicated and I'm not that good at writing very clear
english :) I'll try to do a second pass on that part of the spec. In
fact, the only case where #address-cells is required in an interrupt
controller node (and that node is a leaf node, not also a bus), is when
an interrupt nexus points to it (that is an interrupt-map). I should
make that clear in the spec. If you don't use interrupt maps, you should
not need that #address-cells in the interrupt-controller.

Ben.
