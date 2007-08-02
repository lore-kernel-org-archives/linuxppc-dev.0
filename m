Return-Path: <dgibson@ozlabs.org>
Date: Thu, 2 Aug 2007 11:00:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070802010016.GA798@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<46B094F0.5010401@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46B094F0.5010401@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2007 at 06:13:04PM +0400, Valentine Barshak wrote:
> David Gibson wrote:
> > On Mon, Jul 30, 2007 at 07:06:48PM +0400, Valentine Barshak wrote:
[snip]
> >> +	SDR0: sdr {
> > 
> > What is the SDR?
> 
> SDR are System Device Control Registers (chip ID, pin function and stuff).
> They are accessed by using the configuration address and data (CFGADDR 
> and CFGDATA) registers.

Ok.

> >> +		compatible = "ibm,sdr-440ep";
> >> +		dcr-reg = <00e 002>;
> >> +	};
> >> +
> >> +	CPR0: cpr {
> > 
> > And the CPR?
> 
> CPR are Clock/Power-On Reset configuration registers.
> They are also accessed by using the configuration address and data 
> (CFGADDR and CFGDATA) registers.

Ok, so the rough equivalent of the 440GP's CPC registers (but with an
entirely different register layout).

[snip]
> >> +			EMAC0: ethernet@ef600e00 {
> >> +				linux,network-index = <0>;
> >> +				device_type = "network";
> >> +				compatible = "ibm,emac-440spe", "ibm,emac4", "ibm,emac-axon";
> > 
> > "ibm,emac-axon" is definitely wrong, since this isn't an Axon chip.
> 
> The chip uses EMACX_STACR_STAC_READ and EMACX_STACR_STAC_WRITE bits with 
> mdio_read/mdio_write commands. These are only enabled if the chip is 
> axon-compatible.
> ---
> 	if (device_is_compatible(np, "ibm,emac-axon"))
> 		dev->features |= EMAC_FTR_HAS_AXON_STACR
> ---

Then the driver needs fixing; I'll talk to Ben and look into it.
We'll need something in the device tree to indicate this, but it
shouldn't be "emac-axon" in compatible.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
