Date: Mon, 14 Jun 2004 20:29:22 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH][RFC] Make /proc/interrupts show the correct edge/level
  status for PReP machines
In-Reply-To: <1604.80.7.99.14.1087234184.squirrel@www.solinno.co.uk>
Message-ID: <Pine.GSO.4.58.0406142028330.1555@waterleaf.sonytel.be>
References: <1604.80.7.99.14.1087234184.squirrel@www.solinno.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 14 Jun 2004, Leigh Brown wrote:
> Although the edge/level status of the interrupts are set up correctly
> for PReP machines, we neglect to set the status in the irq_desc
> array.  This patch does that.
>
> Before:
>
>            CPU0
>   2:          0   i8259     Edge      82c59 secondary cascade
>   4:        876   i8259     Edge      serial
>  15:       1202   i8259     Edge      sym53c8xx, eth0
>
> Before:
>
>            CPU0
>   2:          0   i8259     Edge      82c59 secondary cascade
>   4:     171211   i8259     Edge      serial
>  15:    5153584   i8259     Level     sym53c8xx, eth0
>
>
> diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c
> linux-2.6.6/arch/ppc/platforms/prep_pci.c
> --- linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c	2004-06-12
> 10:26:18.000000000 +0100
> +++ linux-2.6.6/arch/ppc/platforms/prep_pci.c	2004-06-12
> 10:35:20.000000000 +0100
> @@ -1051,11 +1051,18 @@
>  		}
>  	} else if ( _prep_type == _PREP_IBM ) {
>  		unsigned char irq_edge_mask_lo, irq_edge_mask_hi;
> +		unsigned short irq_edge_mask;
> +		int i;
>
>  		setup_ibm_pci(&irq_edge_mask_lo, &irq_edge_mask_hi);
>
>  		outb(inb(0x04d0)|irq_edge_mask_lo, 0x4d0); /* primary 8259 */
>  		outb(inb(0x04d1)|irq_edge_mask_hi, 0x4d1); /* cascaded 8259 */
> +
> +		irq_edge_mask = (irq_edge_mask_hi << 8) | irq_edge_mask_lo;
> +		for (i = 0; i < 16; ++i, irq_edge_mask >> 1)
                                         ^^^^^^^^^^^^^^^^^^
Shouldn't that be `irq_edge_mask >>= 1'?

> +			if (irq_edge_mask & 1)
> +				irq_desc[i].status |= IRQ_LEVEL;
>  	} else {
>  		printk("No known machine pci routing!\n");
>  	 	return;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
