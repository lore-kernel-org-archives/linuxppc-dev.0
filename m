Subject: Re: WindRiver PowerQUICC III SBC8560 support.
From: David Woodhouse <dwmw2@infradead.org>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <205EB944-C12D-11D8-ACD7-000393DBC2E8@freescale.com>
References: <1087563278.19489.3156.camel@hades.cambridge.redhat.com>
	 <205EB944-C12D-11D8-ACD7-000393DBC2E8@freescale.com>
Content-Type: text/plain
Message-Id: <1087827285.18627.66.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Mon, 21 Jun 2004 15:14:46 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-06-18 at 08:40 -0500, Kumar Gala wrote:
> A few comments (they are inline with the patch):

Thanks for the feedback.

> Remove FEC, does not exist on 8560
> Remove ref for ENET3/FEC does not exist on 8560
> Fix file name comments

Done.

> Do you use the pci_config_addr define?

No; removed.

> Can you use mpc85xx_calibrate_decr instead of creating your own?

Actually I think I already was. So I removed the sbc82xx one :)

> Can you use the mpc85xx_find_end_of_memory

Yes; done.

> I've moved to not using _map_io at all.  This has to due with eating up
> large parts of virtual addr space, you may want to think about it.

Er, on closer inspection I wasn't using it either. Killed.

> Can you use mpc85xx_restart, mpc85xx_halt, mpc85xx_power_off?

Yes; done.

> Is map_irq correct for your board?

No, it was a pile of crap. There was a 'sbc85xx_map_irq' but we weren't
using that. Fixed (albeit untested because I still haven't installed a
u-boot which actually manages to start up when there's a 33MHz PCI card
present and hence the clocks are halved.

> Fixup file comments

Done.

> IMAP_ADDR?  should this be CPM_MAP_ADDR? or is this just old?

Just old. Gone.

> Remove if you use mpc85xx_ versions

Done.

> PCI1... should be in syslib/ppc85xx_setup.h

And indeed they are. Removed.

> > --- a/arch/ppc/syslib/ppc85xx_setup.c	2004-06-18 13:49:42 +01:00
> > +++ b/arch/ppc/syslib/ppc85xx_setup.c	2004-06-18 13:49:42 +01:00

> Was this needed?

> > +#include <syslib/ppc85xx_setup.h>

Yes. Without it we don't get PCIX_COMMAND defined. On MPC85xx the file
gets pulled in via platforms/85xx/mpc8540_ads.h, but we don't need it in
platforms/85xx/sbc8560.h so we don't include it there. ppc85xx_setup.c
should be including it directly if it needs it.

Actually PCIX_COMMAND should probably be in include/linux/pci.h.

> Was this necessary?  I havent looked into it, but this seems to work ok
> on ADS boards?
> > -#define BASE_BAUD 0
> > +#ifndef BASE_BAUD
> > +#define BASE_BAUD 115200
> > +#endif

On the ADS boards, mpc85xx_early_serial_map() sets serial_req.uartclk to
binfo->bi_busfreq; the BASE_BAUD #define isn't actually relevant so it
doesn't matter that it's broken.

On SBC8560 we use external 16550s, and it matters.

Actually, I think we should leave SERIAL_PORT_DFNS empty and use
early_serial_setup() exclusively. I'd have done that but gen550_dbg.c
doesn't use baud_base when gen550_init() is called; it uses whatever's
in its own copy of rs_table.

I'll continue my campaign to abolish rs_table _completely_ on all
architectures another day :)

> No, we are moving the block # to be start on 1, fixup any code that
> needs MPC85xx_IIC0_OFFSET to use MPC85xx_IIC1_OFFSET
> > +#define MPC85xx_IIC0_OFFSET	(0x05000)
> > +#define MPC85xx_IIC0_SIZE	(0x01000)
> >  #define MPC85xx_IIC1_OFFSET	(0x03000)
> >  #define MPC85xx_IIC1_SIZE	(0x01000)

Er, actually on closer inspection the 8260 I2C is at 0x3000 too; I don't
know where I got the address 0x5000 from, but I had assumed it was
_meant_ to be different from the 8540 version. Fixed.

> Make these changes and resend, I'll take a look and then push up to
> akpm.

bk://linux-mtd.bkbits.net/sbc85xx-2.6 and in particular
http://linux-mtd.bkbits.net:8080/sbc85xx-2.6/gnupatch@40d6ea31zS1PDbPn2x0iwemApPGBBA

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
