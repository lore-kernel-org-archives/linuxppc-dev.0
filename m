Return-Path: <dgibson@ozlabs.org>
Date: Thu, 18 Oct 2007 10:22:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 04/15] [POWERPC] CM5200 DTS
Message-ID: <20071018002256.GA24236@localhost.localdomain>
References: <47075FA7.3030108@semihalf.com> <4708C112.9020506@semihalf.com>
	<20071008015021.GA12499@localhost.localdomain>
	<4715FE6C.2070201@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4715FE6C.2070201@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 17, 2007 at 02:22:04PM +0200, Marian Balakowicz wrote:
> David Gibson wrote:
> > [snip]
> >> +		flash@c000000 {
> >> +			device_type = "rom";
> >> +			compatible = "direct-mapped";
> >> +			reg = <0c000000 02000000>;
> >> +			probe-type = "CFI";
> >> +			bank-width = <2>;
> >> +			partitions = <00000000 00060000
> >> +				00060000 00020000
> >> +				00080000 00020000
> >> +				000a0000 00020000
> >> +				000c0000 00200000
> >> +				002c0000 01b40000
> >> +				01e00000 00200000>;
> >> +			partition-names = "uboot\0env\0redund_env\0dtb\0kernel\0rootfs\0config";
> >> +		};
> > 
> > First, this is the old flash binding, please use the new one.
> 
> Ok.
> 
> > Second, is the flash really part of the SoC?
> 
> Not directly, it is attached to LocalPlus Bus Controller, which is
> part of the SoC. And the soc@ is currently the only recognized of bus
> for mpc5200, so if we want to move it to some other place new bindings
> will need to be defined for lpc (LocalPlus Controller) bus. But I am
> not quite sure where this should be attached. Bus is under LPC which
> is a part of the SoC, but on the other hand Soc address range covers
> only device control registers not the address space LPC may handle
> (that may be varied). Any ideas?

The bus bridge has to be there.  Is this something similar to the
"localbus" / "chipselect" bus controllers that a whole bunch of the
Freescale SoCs have?  Because the bridged addresses don't lie in the
IMMR, althoug the control registers do, the current convention is to
make the localbus node a sibling of /soc, even though it is really
part of the SoC (/soc would perhaps be better called /immr, but /soc
is established now).  This approach is imperfect, but so are most of
the other compromises we could make.

Incidentally LPC is a pretty bad abbreviation, since LPC more
frequently refers to the Low Pin Count connections that frequently
appear on south bridges or superIO chips.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
