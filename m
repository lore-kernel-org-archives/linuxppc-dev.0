Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02F51DDF37
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 08:26:49 +1100 (EST)
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Philippe De Muyter <phdm@macqel.be>
In-Reply-To: <20080303210532.GA20382@netgate.macqel>
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
	<20080303210532.GA20382@netgate.macqel>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 08:26:14 +1100
Message-Id: <1204579574.21545.19.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Maybe your PCI interrupt-map is wrong...
> 
> Is the PCI-interrupt map that part of the dts file :
> 
>                 interrupt-map = <
> 
>                         /* IDSEL 0x02 */
>                         1000 0 0 1 &mpic 1 1
>                         1000 0 0 2 &mpic 2 1
>                         1000 0 0 3 &mpic 3 1
>                         1000 0 0 4 &mpic 4 1
> 
>                         /* IDSEL 0x03 */
>                         1800 0 0 1 &mpic 4 1
>                         1800 0 0 2 &mpic 1 1
>                         1800 0 0 3 &mpic 2 1
>                         1800 0 0 4 &mpic 3 1
> 
> 			...
> 
> I do not understand anything there :(

It's documented in booting-without-of.txt afaik... The interrupt-map
goes along with the interrupt-map-mask. The later defines which bits of
the map are relevant.

The first part of the map is 3 cells containing a PCI address, followed
by a cell containing a PCI IRQ line (1=A....4=D). The next is the parent
interrupt controller, followed by the IRQ specification, which for MPIC
is the interrupt number on that controller, followed by an encoding of
the interrupt polarity & trigger type (1 for level-low).

The first part, the PCI address, has a special format, which should be
documented as well in the document I pointed out. For readability, we
ommited the top 16 bits of the first cell, which are the address type
and bus number, mostly irrelevant for interrupt mapping. The next bits
are the device/function. Usually only the device part is unmasked.

Ben.
