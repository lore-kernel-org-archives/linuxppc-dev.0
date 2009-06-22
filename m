Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 9855FB7169
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 19:36:36 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: kilauea/405ex external interrupts
Date: Mon, 22 Jun 2009 11:23:11 +0200
References: <e35801cc0906190100i1a0429eahade975319b5246df@mail.gmail.com>
In-Reply-To: <e35801cc0906190100i1a0429eahade975319b5246df@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200906221123.11192.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 19 June 2009 10:00:52 Lada Podivin wrote:
> I'm writing a linux driver that uses an external interrupt (ppc 405ex). I'm
> using GPIO pin 30 (external IRQ 1) connected to UIC1. I'm aware of the
> virtual interrupt stuff, so I added a new node to my device tree in order
> to get proper virtual IRQ number. This node describes an external event and
> its connection to UIC via the mentioned ext. int. Here is a sample of the
> divce-tree:

<snip>

> EXTEVENT: external_event {
>         device_type = "external";
>         #address-cells = <0>;
>         #size-cells = <0>;
>         #interrupt-cells = <2>;
>         interrupts = <0x1e 0x1>;
>         interrupt-parent = <&UIC1>;
> };
> ...
>
> Then I use function "irq_of_parse_and_map()" which returns the virtual IRQ
> number 22. So, "request_irq()" seems to be satisfied with this number. I
> can see this interrupt in the /proc/interrupts. But! When I connect a
> signal source to the pin 30, nothing happens - the interrupt service
> routine isn't called.
>
> Am I suppose to configure anything else? (e. g. pin multiplexing, further
> device-tree tuning...) Thank you!

Yes, this could very well be a problem of pin multiplexing. From looking at 
the Kilauea GPIO/Pin mux configuration in U-Boot, GPIO30 is configured as GPIO 
input and not as IRQ1. So this can't work. The easiest way to change this is 
in U-Boot (include/configs/kilauea.h).

BTW: Are you using Kilauea or a custom 405EX board?

Best regards,
Stefan
