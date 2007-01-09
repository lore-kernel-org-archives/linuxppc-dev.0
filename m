Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D033EDDDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 03:10:05 +1100 (EST)
In-Reply-To: <1168302607.22458.242.camel@localhost.localdomain>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1168288352.22458.198.camel@localhost.localdomain>
	<5f992368c65d3d53003b0e9f2955ae79@kernel.crashing.org>
	<1168296460.22458.232.camel@localhost.localdomain>
	<27d6554d600437ed39853784c0cf96fd@kernel.crashing.org>
	<1168302607.22458.242.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9a44c3bbc4ab67921f784f16991889bd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: EMAC OF binding....
Date: Tue, 9 Jan 2007 17:08:34 +0100
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
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

> I'm not sure I follow you... for example, I may have some clock contro
> register somewhere with one bit enabling EMAC 0 clock and one bit
> enabling EMAC 1 clock...
>
> Easier to call some platform clock management giving my device-node as
> an argument and have that code extract the EMAC "index" from the DT 
> from
> my node.

You give the phandle of your emac node as argument, that
works just fine with what I proposed too (the SoC PM node
knows the phandles of the emac's).  I think your way isn't
all that clean architecturally and can easily lead to
problems later on; the emac shouldn't have to know *anything*
about the structure of the SoC.

But feel free to do what you want, it's certainly not
a *huge* problem ;-)


Segher
