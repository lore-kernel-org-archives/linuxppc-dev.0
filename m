Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 92343DDE98
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 04:07:29 +1000 (EST)
Message-ID: <49EF5CDC.4000702@grandegger.com>
Date: Wed, 22 Apr 2009 20:07:24 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Eddie Dawydiuk <eddie@embeddedarm.com>
Subject: Re: FPGA IRQ design question
References: <49EF2E82.9080905@embeddedarm.com>	<fa686aa40904220757u1bcf1693oc2329c67209249ac@mail.gmail.com>
	<49EF5C4D.6040402@embeddedarm.com>
In-Reply-To: <49EF5C4D.6040402@embeddedarm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eddie Dawydiuk wrote:
> Grant,
> 
>> However, if you're writing one-off custom drivers and there is no
>> common coded needed for acking irqs, then I would probably just use
>> the external IRQ.
> 
> Thanks for the suggestions I think going to just use the external IRQ.
> As a result I've been reading through a few different dts files to try
> to understand how/where to specify this in the dts file. I see in the
> Yosemite dts file the PCI bus device node has an interrupt-map-mask and
> an interrupt-map.
> 
> e.g.
> 
> PCI0: pci@ec000000 {
>       device_type = "pci";
> ...
>       /* Bamboo has all 4 IRQ pins tied together per slot */
>       interrupt-map-mask = <0xf800 0x0 0x0 0x0>;
>       interrupt-map = <
>            /* IDSEL 1 */
>            0x800 0x0 0x0 0x0 &UIC0 0x1c 0x8
> ...
> };
> 
> As far as I can tell this appears to be the proper location to specify
> that the PCI device(FPGA) connects an the IRQ to an external IRQ on the
> AMCC 440EP. I see where the interrupt controller(e.g. &UIC0), the
> interrupt number(0x1C), and the sense(0x8) of the external interrupt is
> specified. But I'm a bit puzzled by some of the other information.
> 
> Is this the proper place in the dts file to specify that the FPGA
> connects and external interrupt to the SoC? Can you point me to a
> document explaining the interrupt-map-mask and interrupt-map arguments?

Yes, have a look to
http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf.

Wolfgang.
