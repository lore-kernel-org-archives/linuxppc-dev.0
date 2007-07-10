Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 850A6DDDFB
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 06:26:04 +1000 (EST)
In-Reply-To: <1184082728.20129.187.camel@localhost.localdomain>
References: <1184082728.20129.187.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <963D5B48-F1E5-4930-9F29-98D7F0E33C0A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/6] Add 8548 CDS PCI express controller node and PCI-X
	device node
Date: Tue, 10 Jul 2007 22:25:50 +0200
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  		pci1: pci@8000 {
>  			interrupt-map-mask = <1f800 0 0 7>;

Set the mask to <1800 0 0 7>, and you need only 16
entries to encode the swizzle.  Except...

> +				/* bus 1 , idsel 0x2 Tsi310 bridge secondary */

...interrupts on bus 1 should be swizzled on bus 1, not
at the PHB.  Really.  It is a horrible workaround for a
non-existing problem to do it here, and I promise you
it _will_ come back to hurt you later.  Not a threat,
just a promise :-)

> -			compatible = "85xx";
> +			compatible = "fsl,mpc85xx-pci","85xx";

No more "xx" please...

> +		pci@a000 {
> +			interrupt-map-mask = <f800 0 0 7>;
> +			interrupt-map = <
> +
> +				/* IDSEL 0x0 (PEX) */
> +				00000 0 0 1 &mpic 0 1
> +				00000 0 0 2 &mpic 1 0
> +				00000 0 0 3 &mpic 2 0
> +				00000 0 0 4 &mpic 3 0>;

Why sense 0 for all but the first entry in this map?

> +			compatible = "fsl,mpc86xx-pciex","86xx";

And "xx" again.  Aren't the 85- and 86- PCIe controllers
compatible, btw?


Segher
