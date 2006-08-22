Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1F85F67C11
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 21:13:54 +1000 (EST)
Date: Tue, 22 Aug 2006 15:13:38 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 4/6] POWERPC: add support of mpc8560 eval board
Message-ID: <20060822151338.513895fc@localhost.localdomain>
In-Reply-To: <6A1F08CA-2FAE-4BE6-82BF-30F35053483C@freescale.com>
References: <20060812000655.6186.42738.stgit@localhost.localdomain>
	<20060812001017.6186.99359.stgit@localhost.localdomain>
	<6A1F08CA-2FAE-4BE6-82BF-30F35053483C@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Aug 2006 15:04:11 -0500
Andy Fleming wrote:

> 
> On Aug 11, 2006, at 19:10, Vitaly Bordug wrote:
> 
> 
> >
> > diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/ 
> > boot/dts/mpc8560ads.dts
> > new file mode 100644
> > index 0000000..f6ccb99
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/mpc8560ads.dts
> > @@ -0,0 +1,310 @@
> >
> > +
> > +		ethernet@24000 {
> > +			device_type = "network";
> > +			model = "TSEC";
> > +			compatible = "gianfar";
> > +			reg = <24000 1000>;
> > +			address = [ 00 00 0C 00 00 FD ];
> > +			interrupts = <d 0 e 0 12 0>;
> 
> Your sense values are wrong here.  Should be "2"
> ie - interrupts = <d 2 e 2 12 2>;
> 
Here and below: 
those were derived from the original dts's an since it worked "as it is" I didn't fairly care atm.

It is clear, that the spec itself is 100% non-contradictory and consistent, so my main concern was to make-it-work. And, those stuff seems not to be taken into account (may be wrong `tho, haven't really looked into,
Ben ?

) 

> 
> > +			interrupt-parent = <40000>;
> > +			phy-handle = <2452000>;
> > +		};
> > +
> > +		ethernet@25000 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			device_type = "network";
> > +			model = "TSEC";
> > +			compatible = "gianfar";
> > +			reg = <25000 1000>;
> > +			address = [ 00 00 0C 00 01 FD ];
> > +			interrupts = <13 0 14 0 18 0>;
> 
> 
> Here, too
>
ditto 
> > +		pic@40000 {
> > +			linux,phandle = <40000>;
> > +			interrupt-controller;
> > +			#address-cells = <0>;
> > +			#interrupt-cells = <2>;
> > +			reg = <40000 20100>;
> > +			built-in;
> > +			device_type = "mpic";
> 
> This is wrong.  It should be "open-pic";
> 
I am recalling nogo with open-pic here... I agree with Segher, we'll make this 100% clear and follow that 
further.
> > +		};
> > +		
> > +		cpm@e0000000 {
> 
> I'm going to leave this to others to discuss, since I'm not a CPM  
> expert.  But you may want to double-check your interrupt sense  
> values, and make sure the encodings are right.
> 
> 

I am completely open to the comments here..

And my guess is that the irq thing should be clarified and re-synced
with spec. All I can say currently - it works for me so may be used at least as reference 
for the stuff alike. If the cpm2 description got settle down, I'll update the spec in relevance 
and hope to make other inconsistencies (irq-related, obsoleted stuff etc. ) addressed.
> > diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/ 
> > platforms/85xx/Kconfig
> > index 454fc53..3d440de 100644
> > --- a/arch/powerpc/platforms/85xx/Kconfig
> > +++ b/arch/powerpc/platforms/85xx/Kconfig
> > @@ -11,6 +11,12 @@ config MPC8540_ADS
> >  	help
> >  	  This option enables support for the MPC 8540 ADS board
> >
> > +config MPC8560_ADS
> > +	bool "Freescale MPC8560 ADS"
> > +	select DEFAULT_UIMAGE
> > +	help
> > +	  This option enables support for the MPC 8560 ADS board
> > +
> 
> 
> If at all possible, I think that the 8560 shouldn't be a config  
> option.  It's just an 85xx ADS, and use the dts to distinguish.  But  
> keeping separate defconfigs seems like a good idea.
> 
> 
Agreed.
> 
> > diff --git a/arch/powerpc/platforms/85xx/mpc8540_ads.h b/arch/ 
> > powerpc/platforms/85xx/mpc8540_ads.h
> > index c0d56d2..670abaf 100644
> > --- a/arch/powerpc/platforms/85xx/mpc8540_ads.h
> > +++ b/arch/powerpc/platforms/85xx/mpc8540_ads.h
> > @@ -6,6 +6,10 @@
> >   * Maintainer: Kumar Gala <kumar.gala@freescale.com>
> >   *
> >   * Copyright 2004 Freescale Semiconductor Inc.
> > + *
> > + * 2006 (c) MontaVista Software, Inc.
> > + * Vitaly Bordug <vbordug@ru.mvista.com>
> > + *	Merged to arch/powerpc
> >   *
> >   * This program is free software; you can redistribute  it and/or  
> > modify it
> >   * under  the terms of  the GNU General  Public License as  
> > published by the
> > @@ -24,10 +28,10 @@ #define BCSR_ADDR
> > ((uint)0xf8000000) #define BCSR_SIZE		((uint)(32 *
> > 1024))
> >
> >  /* PCI interrupt controller */
> > -#define PIRQA		MPC85xx_IRQ_EXT1
> > -#define PIRQB		MPC85xx_IRQ_EXT2
> > -#define PIRQC		MPC85xx_IRQ_EXT3
> > -#define PIRQD		MPC85xx_IRQ_EXT4
> > +#define PIRQA		49
> > +#define PIRQB		50
> > +#define PIRQC		51
> > +#define PIRQD		52
> 
> 
> Wha?!  I can't imagine any reason this change would be acceptable.   
> Especially since your patch needs to apply against a tree with the  
> new irq code, which doesn't need such hard-coded values.  We get
> them from the dts.
> 
> 
Tend to be cleanup_miss, the same as note below.

> > diff --git a/arch/powerpc/platforms/85xx/mpc8560_ads.h b/arch/ 
> > powerpc/platforms/85xx/mpc8560_ads.h
> 
> This file should be able to go away, now, and get merged with  
> mpc8540_ads.h.  While we're at it, mpc8540_ads.h should become  
> mpc85xx_ads.h
> 
> 
> > diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/ 
> > platforms/85xx/mpc85xx.h
> > index b44db62..4fe613e 100644
> > --- a/arch/powerpc/platforms/85xx/mpc85xx.h
> > +++ b/arch/powerpc/platforms/85xx/mpc85xx.h
> > @@ -16,3 +16,4 @@
> >
> >  extern void mpc85xx_restart(char *);
> >  extern int add_bridge(struct device_node *dev);
> > +extern void mpc85xx_pcibios_fixup(void);
> 
> Why is this being "exported"?
>
To make it compile :) will be fixed in the reordering in the next respin. 
 
> > diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/ 
> > powerpc/platforms/85xx/mpc85xx_ads.c
> > index d0cfcdb..974e035 100644
> > --- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> > +++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> > @@ -4,6 +4,10 @@
> >   * Maintained by Kumar Gala (see MAINTAINERS for contact
> > information) *
> >   * Copyright 2005 Freescale Semiconductor Inc.
> > + *
> > + * 2006 (c) MontaVista Software, Inc.
> > + * Vitaly Bordug <vbordug@ru.mvista.com>
> > + * 	Merged to arch/powerpc
> 
> This comment is confusing.  This file was already "merged".   
> Regardless, I believe there's a general policy against putting
> change logs in the header.
> 
The last line is extra here - copy-paste thing. I added the upper line to make it clear that though I've created the file(s) in powerpc/, that is only "merge" thing, which is not quite right for this particular file, sorry about that. 

> 
> >
> > @@ -47,19 +59,19 @@ static u_char mpc85xx_ads_openpic_initse
> >  	MPC85XX_INTERNAL_IRQ_SENSES,
> >  	0x0,			/* External  0: */
> >  #if defined(CONFIG_PCI)
> > -	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext
> > 1: PCI slot 0 */
> > -	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext
> > 2: PCI slot 1 */
> > -	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext
> > 3: PCI slot 2 */
> > -	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext
> > 4: PCI slot 3 */
> > +	IRQ_TYPE_LEVEL_LOW, 	/* Ext 1: PCI slot 0 */
> > +	IRQ_TYPE_LEVEL_LOW, 	/* Ext 2: PCI slot 1 */
> > +	IRQ_TYPE_LEVEL_LOW, 	/* Ext 3: PCI slot 2 */
> > +	IRQ_TYPE_LEVEL_LOW, 	/* Ext 4: PCI slot 3 */
> >  #else
> >  	0x0,			/* External  1: */
> >  	0x0,			/* External  2: */
> >  	0x0,			/* External  3: */
> >  	0x0,			/* External  4: */
> >  #endif
> > -	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/*
> > External 5: PHY */
> > +	IRQ_TYPE_LEVEL_LOW,  	/* External  5: PHY */
> >  	0x0,			/* External  6: */
> > -	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/*
> > External 7: PHY */
> > +	IRQ_TYPE_LEVEL_LOW,  	/* External  7: PHY */
> >  	0x0,			/* External  8: */
> >  	0x0,			/* External  9: */
> >  	0x0,			/* External 10: */
> 
> 
> This isn't how interrupt senses are supposed to be done now.  They  
> should be gotten from the device tree.  This whole array can be
> deleted.
> 
>
Here and below about PCI irq stuff - OK. 
 
> > @@ -74,40 +86,109 @@ #ifdef CONFIG_PCI
> >  int
> >  mpc85xx_map_irq(struct pci_dev *dev, unsigned char idsel,
> > unsigned char pin)
> >  {
> 
> This whole function can be deleted.
> 
> > +	struct device_node * pci_OF;
> > +	struct irq_map_of_mask {
> > +		unsigned int idsel_msk;
> > +		unsigned int slot_msk;
> > +		unsigned int offset_irqs_msk;
> > +		unsigned int line_msk;
> > +	} *ip;
> > +	int i;
> > +	struct irq_of_table_s {
> > +		struct {
> > +			unsigned int idsel;
> > +			unsigned int slot;
> > +			unsigned int offset_irqs;
> > +			unsigned int line;
> > +			unsigned int parent;
> > +			unsigned int table_item;
> > +			unsigned int ext_irqs;
> > +		} idsel[1];
> > +	}* irq_of_table;
> > +
> > +
> > +	pci_OF = of_find_node_by_type(NULL, "pci");
> > +	if (pci_OF) {
> > +		unsigned long max_idsel = 0;
> > +		unsigned long min_idsel = 0xffffffff;
> > +		unsigned long irqs_per_slot = 0;
> > +		unsigned int idsel_ = 0;
> > +		unsigned int line;
> > +		unsigned int* irq;
> > +		unsigned int ip_len;
> > +		unsigned int irq_table_len;
> > +		unsigned int irq_len;
> > +
> > +		ip = (struct irq_map_of_mask*)get_property(pci_OF,
> > "interrupt- map-mask", &ip_len);
> > +
> > +		irq_of_table = (struct
> > irq_of_table_s*)get_property(pci_OF, "interrupt-map",
> > &irq_table_len); +
> > +		irq = (unsigned int*)get_property(pci_OF,
> > "interrupts", &irq_len); +
> > +		if (ip && irq_of_table && irq && ip_len &&
> > irq_table_len && irq_len ) {
> > +			for (i=0;
> > i<irq_table_len/sizeof(irq_of_table->idsel[0]); i++) {
> > +				line = irq_of_table->idsel[i].line
> > & ip->line_msk;
> > +				idsel_ =
> > (irq_of_table->idsel[i].idsel & ip->idsel_msk) >> 11; +
> > +				irqs_per_slot = (line >
> > irqs_per_slot) ? line : irqs_per_slot;
> > +				min_idsel =  (idsel_ <
> > min_idsel) ? idsel_ : min_idsel;
> > +				max_idsel =  (idsel_ >
> > max_idsel) ? idsel_ : max_idsel;
> > +			}
> > +
> > +			do {
> > +				char pci_irq_table[max_idsel -
> > min_idsel + 1][irqs_per_slot]; +
> > +				memset(&pci_irq_table[0][0], 0,
> > sizeof(pci_irq_table));
> > +				for (i =
> > irq_table_len/sizeof(irq_of_table->idsel[0]) - 1;  
> > i>=0;  i--) {
> > +					idsel_ =
> > (irq_of_table->idsel[i].idsel & ip->idsel_msk) >> 11; +
> > +					line =
> > irq_of_table->idsel[i].line & ip->line_msk;
> > +					pci_irq_table[idsel_ -
> > min_idsel][line-1] =
> > +
> > irq_of_table->idsel[i].table_item;
> > +				}
> > +
> > +				return PCI_IRQ_TABLE_LOOKUP;
> > +			} while(0);
> > +		} else {
> > +			printk(KERN_INFO "%s: device tree
> > ERROR\n",__func__);
> > +			return -1;
> > +		}
> > +	} else {
> > +		static char pci_irq_table[][4] =
> > +		    /*
> > +		     * This is little evil, but works around the
> > fact
> > +		     * that revA boards have IDSEL starting at 18
> > +		     * and others boards (older) start at 12
> > +		     *
> > +		     *      PCI IDSEL/INTPIN->INTLINE
> > +		     *       A      B      C      D
> > +		     */
> > +		{
> > +			{PIRQA, PIRQB, PIRQC, PIRQD},	/*
> > IDSEL 2 */
> > +			{PIRQD, PIRQA, PIRQB, PIRQC},
> > +			{PIRQC, PIRQD, PIRQA, PIRQB},
> > +			{PIRQB, PIRQC, PIRQD, PIRQA},	/*
> > IDSEL 5 */
> > +			{0, 0, 0, 0},	/* -- */
> > +			{0, 0, 0, 0},	/* -- */
> > +			{0, 0, 0, 0},	/* -- */
> > +			{0, 0, 0, 0},	/* -- */
> > +			{0, 0, 0, 0},	/* -- */
> > +			{0, 0, 0, 0},	/* -- */
> > +			{PIRQA, PIRQB, PIRQC, PIRQD},	/*
> > IDSEL 12 */
> > +			{PIRQD, PIRQA, PIRQB, PIRQC},
> > +			{PIRQC, PIRQD, PIRQA, PIRQB},
> > +			{PIRQB, PIRQC, PIRQD, PIRQA},	/*
> > IDSEL 15 */
> > +			{0, 0, 0, 0},	/* -- */
> > +			{0, 0, 0, 0},	/* -- */
> > +			{PIRQA, PIRQB, PIRQC, PIRQD},	/*
> > IDSEL 18 */
> > +			{PIRQD, PIRQA, PIRQB, PIRQC},
> > +			{PIRQC, PIRQD, PIRQA, PIRQB},
> > +			{PIRQB, PIRQC, PIRQD, PIRQA},	/*
> > IDSEL 21 */
> > +		};
> > +
> > +		const long min_idsel = 2, max_idsel = 21,
> > irqs_per_slot = 4;
> > +		return PCI_IRQ_TABLE_LOOKUP;
> > +	}
> 
> 
> Is there some reason you reimplemented code that already exists for  
> mapping PCI interrupts?  Delete this function, and instead add:
> 
> void __init
> mpc85xx_pcibios_fixup(void)
> {
>          struct pci_dev *dev = NULL;
> 
>          for_each_pci_dev(dev)
>                  pci_read_irq_line(dev);
> }
> 
> Hm.  I see you added that function to pci.c.  Anyway, you don't need  
> the map_irq function anymore
> 
> 
> 
> > +	mpic_set_default_senses(mpic1,
> > +				mpc85xx_ads_openpic_initsenses,
> > +
> > sizeof(mpc85xx_ads_openpic_initsenses)); +
> 
> No.  We have parse_and_map to handle this.
> 
> >  	mpic_init(mpic1);
> > +	of_node_put(np);
> 
> Are we definitely supposed to release the of nodes after we call  
> init?  Actually, it looks like you can put that after mpic_alloc().   
> mpic_alloc() grabs a reference, so we don't need it after that.
> 

Looks like true, but I'll double-check this anyway.
> 
> >
> >  /*
> >   * Setup the architecture
> >   */
> 
> There should probably be an #ifdef CONFIG_CPM2 here
> 
ok
> > +static void init_fcc_ioports(void)
> 
> ...
> 
> 
> 
> > diff --git a/include/asm-powerpc/mpc85xx.h b/include/asm-powerpc/ 
> > mpc85xx.h
> 
> This file really needs to be cleaned up.  Most of the stuff in here  
> can go.
> 
My guess to separate the "cleanup_obsolete" and "add_new_stuff" in some ways, it it does not prevent stuff from work. Note that there are still a lot of confusion with ppc/powerpc header mix. So "cleanup" patch should be carefully tested with both ppc and powerpc. I am aware that mpc85xx.h exist in both instances, these are just generic thoughts.


Thanks for the comments and review.

> Andy
> 
> 
