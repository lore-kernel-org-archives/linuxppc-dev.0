Date: Mon, 17 Sep 2001 13:40:14 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Matt Porter <mporter@mvista.com>
Cc: Xavier Grave <grave@ipno.in2p3.fr>,
	embarque ppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: driver for the mvme5100
Message-ID: <20010917134014.A10747@ipnpcu5.in2p3.fr>
References: <20010914100154.A7161@ipnpcu5.in2p3.fr> <20010914055405.A12955@cx258813-a.chnd1.az.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <20010914055405.A12955@cx258813-a.chnd1.az.home.com>; from mporter@mvista.com on ven, sep 14, 2001 at 14:54:05 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> That's what you should expect to see.  In Linux a PCI mem resource
> is defined as an ioremapable token.  It may or may not be a PCI or
> processor bus address.  In the case of a PReP memory map, PCI bus
> addresses are translated in a non-1:1 fashion.  So an offset of
> 0xc0000000 is correct for the difference between the actual BAR
> value and the corresponding Linux resource value.  In the case
> of a CHRP memory map, PCI bus addresses are 1:1 with processor
> bus addresses (like most developers like to assume..x86).  In
> this case the mem resource start will be the same as the actual
> memory BAR value.

Hi,

With your informations I have found the problem and also a solution.

I had programmed the tundra chip SLSI image to map at 0x0 in pci address.
In the prep model, there isn't any problem with the dram memory. In the
CHRP
there is a ressource allocation conflict with the dram memory. Since my
mvme5100 board
have 64MB of memory I have changed the SLSI offset to 128MB and there is no
more conflict.

Thanks one more time, xavier

--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
