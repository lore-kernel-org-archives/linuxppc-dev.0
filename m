Date: Fri, 14 Sep 2001 05:54:05 -0700
From: Matt Porter <mporter@mvista.com>
To: Xavier Grave <grave@ipno.in2p3.fr>
Cc: embarque ppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: driver for the mvme5100
Message-ID: <20010914055405.A12955@cx258813-a.chnd1.az.home.com>
References: <20010914100154.A7161@ipnpcu5.in2p3.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010914100154.A7161@ipnpcu5.in2p3.fr>; from grave@ipno.in2p3.fr on Fri, Sep 14, 2001 at 10:01:54AM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Sep 14, 2001 at 10:01:54AM +0200, Xavier Grave wrote:
> in the driver there is two code lines :
> pci_read_config_dword(carte.pci,PCI_BASE_ADDRESS_0,&tmp);
> carte.bus_delta = carte.pci->resource[0].start - tmp;
> on the mvme2303 it gives 0xc000 0000 which is the prep offset.
> on the mvme5100 it gives 0. Since the mvme5100 is chrp-like I wait
> for a 0x4000000 value or something different from zero ?
>
> Does anybody have an idea ?

That's what you should expect to see.  In Linux a PCI mem resource
is defined as an ioremapable token.  It may or may not be a PCI or
processor bus address.  In the case of a PReP memory map, PCI bus
addresses are translated in a non-1:1 fashion.  So an offset of
0xc0000000 is correct for the difference between the actual BAR
value and the corresponding Linux resource value.  In the case
of a CHRP memory map, PCI bus addresses are 1:1 with processor
bus addresses (like most developers like to assume..x86).  In
this case the mem resource start will be the same as the actual
memory BAR value.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
