Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69A8DDDE3B
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 19:28:13 +1100 (EST)
Subject: Re: Device Tree & PCI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03D9A381@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B03D9A381@ismail.innsys.innovsys.com>
Content-Type: text/plain
Date: Sat, 12 Jan 2008 19:27:39 +1100
Message-Id: <1200126459.6896.103.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>         pci_bridge@12 {
>     		interrupt-map-mask = <0f800 0 0 7>;
>     		interrupt-map = <
>     		                /* IDSEL 0x10 */
>     		                00008000 0 0 1 &PCI_INT 1
> 
>     		                /* IDSEL 0x11 */
>     		                00008800 0 0 1 &PCI_INT 2
>     		                
>     		                /* IDSEL 0x12 */
>     		                00009000 0 0 1 &PCI_INT 3
>     		                
>     		                /* IDSEL 0x13 */
>     		                00009800 0 0 1 &PCI_INT 4>;
>         };

Your PCI bridge node needs more than those 2 properties. At the very
least it needs device_type "pci" and name "pci" (rather than pci-bridge)
to make the kernel parser happier, it also needs a proper class code and
a "reg" property providing its configuration address (devfn) so that the
kernel can do the matching between what it finds on the PCI bus and that
node.

Basically, you need to make sure the function pci_device_to_OF_node()
works for your bridge or the interrupt resolution will not work. I'd
suggest you add debugging to that function to dump what it's doing so
you can get your tree in order.

Cheers,
Ben.
