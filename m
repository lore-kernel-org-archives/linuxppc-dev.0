Return-Path: <SHorton@kodiaknetworks.com>
Received: from cowboy.inovate.inovate.com (planomail.kodiaknetworks.com
	[76.203.108.6]) by ozlabs.org (Postfix) with ESMTP id 224A5DDF77
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Aug 2008 11:38:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: mpc744x, Marvell mv6446x kernel guidance please
Date: Thu, 31 Jul 2008 20:38:30 -0500
Message-ID: <295C5089A56CE143B316E5F67CA99CB001D06B38@cowboy.inovate.inovate.com>
In-Reply-To: <20080730231046.GA26011@farnsworth.org>
References: <295C5089A56CE143B316E5F67CA99CB001C9E4BD@cowboy.inovate.inovate.com>
	<20080728165108.GA22621@mag.az.mvista.com>
	<295C5089A56CE143B316E5F67CA99CB001D06956@cowboy.inovate.inovate.com>
	<20080730231046.GA26011@farnsworth.org>
From: "Stephen Horton" <SHorton@kodiaknetworks.com>
To: "Dale Farnsworth" <dale@farnsworth.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Dale,

Thanks for the info; it was very informative. To follow-up on my
previous email:

1. I now have a working interrupt-map section in my .dts. PCI bus
initialization works with no visible errors.

2. I've deciphered the magic numbers in the cpu->pci window
configuration. The required information for disabling and re-enabling
BARS is located in the Marvell User's manual, Rev C, page 365, Table
141.

3. I'm a little smarter on the Ethernet configuration. I understand now
that Linux should actually just know about eth0 the RGMII connection
from Marvell to the Broadcom switch. Its upto me to configure the
additional Broadcom ports with whatever configuration (to meet my PICMG
2.16 requirements). I have all the Ethernet stuff initializing properly
(including eth0) with no errors; unfortunately, when I configure for
bootp and nfs boot over the network, there are no bootp requests coming
out of my board (verified with a sniffer, but link is up according to
Broadcom status bits and remote switch). So, I still have something
wrong here in my kernel code...

Thanks, again,
Stephen

-----Original Message-----
From: Dale Farnsworth [mailto:dale@farnsworth.org]=20
Sent: Wednesday, July 30, 2008 6:11 PM
To: Stephen Horton
Cc: Mark A. Greer; linuxppc-embedded@ozlabs.org
Subject: Re: mpc744x, Marvell mv6446x kernel guidance please

On Wed, Jul 30, 2008 at 08:56:18AM -0500, Stephen Horton wrote:
> Thanks for your kind encouragement. I now have a mostly booting
kernel.
> I have just a few remaining issues to resolve; perhaps you (or others)
> can give me some tips regarding these:
>=20
> 1. In your prpmc2800 .dts configuration, in the PCI bus configuration
> section, you lay-out the IRQ mappings like this:
> 	interrupt-map =3D <
>                 /* IDSEL 0x0a */
>                 5000 0 0 1 &/mv64x60/pic 50
>                 5000 0 0 2 &/mv64x60/pic 51
> I've read the Open Firmware document on Interrupt Mapping, but I still
> don't really understand the first 3 columns (5000 0 0), especially
where
> the first column comes from. Is this just some arbitrarily selected
> offset address for that device on the pci bus?

An address on the PCI bus is represented by 3 cells (96 bits).

Take a look at page 4 of http://www.openbios.org/data/docs/bus.pci.pdf

You'll see that the PCI device is contained in bits 15-11, selected by
the 0xf800 in interrupt-map-mask.  The 0x5000 corresponds to device 0xa.

-Dale
