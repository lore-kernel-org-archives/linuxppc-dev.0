Date: Mon, 27 Mar 2000 11:50:26 +0200 (MET DST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Gabriel Paubert <paubert@iram.es>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003271050560.31313-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.10.10003271148530.11532-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 27 Mar 2000, Michael Schmitz wrote:
> > The code I posted for the LongTrail does assign missing/conflicting resources.
> > Please adapt it for PowerMac.
>
> Applying Geerts patch (minus the PCIBIOS_MIN_MEM patch) plus the following
> one solves my PCI address conflict for the Mach64 by reallocating the MMIO

So it works without changing PCIBIOS_MIN_MEM? I'm wondering what address is
assigned to the secondary aperture? Can you please send me the output of
`lspci -vv'? Thx!

> aperture, and allows XFree86 4.0 to run on my Lombard.

Guess I have to try 4.0 as well...

> --- arch/ppc/kernel/pci.c.org	Sun Mar 26 14:08:53 2000
> +++ arch/ppc/kernel/pci.c	Sun Mar 26 14:09:16 2000
> @@ -231,7 +231,7 @@
>  				if (!pr || request_resource(pr, r) < 0) {
>  					printk(KERN_ERR "PCI: Cannot allocate resource region %d of device %s\n", idx, dev->slot_name);
>  					/* We'll assign a new address later */
> -					r->start -= r->end;
> +					r->end -= r->start;
>  					r->start = 0;
>  				}
>  			}

I copied this buglet from arch/i386/kernel/pci-i386.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
