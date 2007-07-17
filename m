Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 8F089DDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 16:58:55 +1000 (EST)
Subject: Re: [PATCH 3/3] 82xx: SBCPQ2 board platform support
From: Mark Zhan <rongkai.zhan@windriver.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200707170327.41648.arnd@arndb.de>
References: <469B3401.9030602@windriver.com> <200707170327.41648.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 14:58:19 +0800
Message-Id: <1184655499.18501.17.camel@mark>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd,

On Tue, 2007-07-17 at 03:27 +0200, Arnd Bergmann wrote:
> > +static struct resource m48t59_resources[] = {
> > +	{
> > +		.start	= SBCPQ2_RTC_BASE,
> > +		.end	= SBCPQ2_RTC_BASE + SBCPQ2_RTC_SIZE - 1,
> > +		.flags	= IORESOURCE_MEM,
> > +	}, {
> > +		.start	= SBCPQ2_M48T59_IRQ,
> > +		.end	= SBCPQ2_M48T59_IRQ,
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +	{ },
> > +};
> 
> This is the kind of information that belongs into the device tree,
> not hardcoded into the board code.
> 

ok, I will move them into device tree.

> > +/**
> > + * sbcpq2_pdev_init - Register the platform device for sbcpq2 board
> > + */
> > +static int __init sbcpq2_platdev_init(void)
> > +{
> > +	struct irq_desc *desc = irq_desc + SBCPQ2_M48T59_IRQ;
> 
> same for the interrupt number. Worse, this looks broken
> because the descriptor array describes virtual interrupt
> numbers, while SBCPQ2_M48T59_IRQ must be a physical number.
> These are often the same, but there is no guarantee.
> 
> In order to get a virtual interrupt number for a given device,
> you need to call irq_of_parse_and_map().
> 
> > +	/* Install a dummy irq chip for M48T59 RTC irq */
> > +	if (desc->chip == &no_irq_chip)
> > +		set_irq_handler(SBCPQ2_M48T59_IRQ, desc->handle_irq);
> > +
> > +	/* Register all platform devices for sbcpq2 */
> > +	platform_add_devices(sbcpq2_devices, ARRAY_SIZE(sbcpq2_devices));
> > +	return 0;
> > +}
> > +arch_initcall(sbcpq2_platdev_init);
> 
> 
> > +/*
> > + * For SBCPQ2 board, the interrupt of M48T59 RTC chip
> > + * will generate a machine check exception. We use a
> > + * fake irq to give the platform machine_check_exception() hook
> > + * a chance to call the driver ISR. If IRQ_HANDLED is returned,
> > + * then we will survive from the machine check exception.
> > + */
> > +static int sbcpq2_mach_check(struct pt_regs *regs)
> > +{
> > +	int recover = 0;
> > +	struct irq_desc *desc = irq_desc + SBCPQ2_M48T59_IRQ;
> > +
> > +	struct irqaction *action = desc->action;
> > +
> > +	while (action && (action->dev_id != &m48t59_rtc))
> > +		action = action->next;
> > +
> > +	/* Try to call m48t59 RTC driver ISR */
> > +	if (action && action->handler)
> > +		recover = action->handler(SBCPQ2_M48T59_IRQ, &m48t59_rtc);
> > +
> > +	return recover;
> > +}
> 
> What you do here looks really scary, but maybe I'm just misunderstanding
> it completely. Why don't you just register your rtc handler function
> as the machine check handler instead of going through various indirections?
> 

The rtc M48T59 driver is not specific to my board, it is probably used
by other board. So I can't register the rtc intr handler as the mcheck
exception handler. And in the other side, there are also other machine
check sources, right?

So here I add a platform mcheck hook for rtc intr handler. Yeah, it is
really scary and confusing:-)

> > +static void __init sbcpq2_init_IRQ(void)
> > +{
> > +	struct device_node *np;
> > +	struct resource res;
> > +
> > +	np = of_find_compatible_node(NULL, "cpm-pic", "CPM2");
> > +	if (np == NULL) {
> > +		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
> > +		return;
> > +	}
> 
> This looks like your device tree is wrong. Shouldn't the interrupt
> controller have device_type="interrupt-controller" and a specific
> compatible property instead of having the name in the device_type?
> 

Here, I just copy the codes from mpc82xx_ads, is there anything wrong?

> > +static void __init sbcpq2_setup_arch(void)
> > +{
> > +	struct device_node *np;
> > +	volatile memctl_cpm2_t *mc;
> 
> not volatile, but __iomem!
> 

Fixed.

> > +	unsigned char * eeprom_base;
> > +	int i = 0;
> > +
> > +#ifdef CONFIG_CPM2
> > +	cpm2_reset();
> > +#endif
> > +
> > +	/*
> > +	 * Make sure that we have the right CS# setting
> > +	 */
> > +	mc = &cpm2_immr->im_memctl;
> > +
> > +	/* Boot Flash is the on-board flash */
> > +	mc->memc_br0 = (SBCPQ2_BOOT_FLASH_BASE & 0xFFFF8000) | 0x0801;
> > +	mc->memc_or0 = 0xFFE00896;
> 
> consequently, this needs to use out_be32 or similar.
> Where does SBCPQ2_BOOT_FLASH_BASE come from? Shouldn't that be set
> up by the boot loader to match the device tree?

Fixed. out_be32 is used. The reason why they are needed is because some
legacy u-boot for this board probably was setting up the wrong memory
map.

> 
> > +		model = (char *)of_get_property(np, "model", NULL);
> > +		if (!model)
> > +			continue;
> 
> The cast is not needed here.
> > +
> > +		id = of_get_property(np, "device-id", NULL);
> > +		if (!id)
> > +			continue;
> > +
> > +		macaddr = (unsigned char *)of_get_mac_address(np);
> > +		if (!macaddr)
> > +			continue;
> 
> or here.

Both cast are removed.

> 
> > +		if (strstr(model, "FCC"))
> > +			eeprom_ofs = SBCPQ2_FCC1_MACADDR_OFS;
> > +		else if (strstr(model, "SCC"))
> > +			eeprom_ofs = SBCPQ2_SCC1_MACADDR_OFS;
> > +		eeprom_ofs += ((*id) - 1) * 6;
> 
> of_device_is_compatible()
> 
> 
> > +		for (j = 0; j < 6; j++)
> > +			*(macaddr + j) = *(eeprom_base + eeprom_ofs + j);
> 
> in_8().

OK. in_8() will be used.

> 
> > +	}
> > +	iounmap(eeprom_base);
> > +}
> > +
> > +/*
> > + * Called very early, device-tree isn't unflattened
> > + */
> > +static int __init sbcpq2_probe(void)
> > +{
> > +	/* We always match for now, eventually we should look at
> > +	 * the flat dev tree to ensure this is the board we are
> > +	 * supposed to run on
> > +	 */
> > +	return 1;
> > +}
> 
> Don't write why the code is wrong -- just fix it.
> 
> > +/* For our show_cpuinfo hooks. */
> > +#define CPUINFO_VENDOR		"Wind River"
> > +#define CPUINFO_MACHINE		"SBC PowerQUICCII 82xx"
> 
> Not in a header file please.
> 
> > +/*
> > + * Wind River SBC PowerQUICCII 82xx Physical Memory Map (CS0 for OnBoard Flash)
> > + *
> > + *   0x00000000 - 0x07FFFFFF	CS2, 128 MB DIMM SDRAM
> > + *   0x08000000 - 0x0FFFFFFF	CS3, 128 MB DIMM SDRAM
> > + *   0x12000000 - 0x12100000	CS8, ATM
> > + *   0x20000000 - 0x20FFFFFF	CS4, 16 MB Local Bus SDRAM
> > + *   0x21000000 - 0x21001FFF	CS7, Control EPLD
> > + *   0x22000000 - 0x22001FFF	CS5, 8KB EEPROM
> > + *   0x22002000 - 0x22003FFF	CS5, visionPORT
> > + *   0x22004000 - 0x22005FFF	CS5, User Switches
> > + *   0x22006000 - 0x22007FFF	CS5, STATUS
> > + *   0x22008000 - 0x22009FFF	CS5, i8259 interrupt controller
> > + *   0x2200A000 - 0x2200BFFF	CS5, LED (Seven Segment Display)
> > + *   0x80000000 - 0x80001FFF	CS11, RTC
> > + *   0xE0000000 - 0xE3FFFFFF	CS6, 64 MB DIMM Flash
> > + *   0xE4000000 - 0xE7FFFFFF	CS1, 64 MB DIMM Flash
> > + *   0xFE000000 - 0xFFFFFFFF	CS0, 2 MB Boot Flash
> > + *   0xF0000000 - 0xF0020000	MPC82xx Internal Registers Space
> > + */
> > +#define SBCPQ2_SDRAM_BASE		0x00000000
> > +#define SBCPQ2_SDRAM_SIZE		0x10000000
> > +
> > +#define SBCPQ2_LOCAL_SDRAM_BASE		0x20000000
> > +#define SBCPQ2_LOCAL_SDRAM_SIZE		0x1000000
> > +
> > +#define SBCPQ2_EPLD_BASE		0x21000000
> > +#define SBCPQ2_EPLD_SIZE		0x2000
> > +
> > +#define SBCPQ2_EEPROM_BASE		0x22000000
> > +#define SBCPQ2_EEPROM_SIZE		0x2000
> > +
> > +/* User Switches SW5 */
> > +#define SBCPQ2_USER_SW_BASE		0x22004000
> > +#define SBCPQ2_USER_SW_SIZE		0x2000
> > +
> > +#define SBCPQ2_STATUS_BASE		0x22006000
> > +#define SBCPQ2_STATUS_SIZE		0x2000
> > +
> > +#define SBCPQ2_I8259_BASE		0x22008000
> > +#define SBCPQ2_I8259_SIZE		0x2000
> > +
> > +/* Seven Segment Display LED D46 */
> > +#define SBCPQ2_LED_BASE			0x2200A000
> > +#define SBCPQ2_LED_SIZE			0x2000
> > +
> > +#define SBCPQ2_RTC_BASE			0x80000000
> > +#define SBCPQ2_RTC_SIZE			0x2000
> > +
> > +#define SBCPQ2_BOOT_FLASH_BASE		0xFE000000
> > +#define SBCPQ2_BOOT_FLASH_SIZE		0x00200000
> > +
> > +#define SBCPQ2_DIMM_FLASH_BASE		0xE0000000
> > +#define SBCPQ2_DIMM_FLASH_SIZE		0x04000000
> > +
> > +#define CPM_MAP_ADDR			0xF0000000
> > +#define CPM_IRQ_OFFSET			0
> 
> All this is in the device tree already, so don't duplicate it here.
> 
> > +/*
> > + * The offset of ethernet MAC addr within EEPROM
> > + */
> > +#define SBCPQ2_FCC1_MACADDR_OFS		0x60
> > +#define SBCPQ2_FCC2_MACADDR_OFS		0x66
> > +#define SBCPQ2_FCC3_MACADDR_OFS		0x72
> > +#define SBCPQ2_SCC1_MACADDR_OFS		0x78
> 
> Likewise, the mac address is in the device tree, so no need
> to tell the kernel how to read it.
> 
> > +/*
> > + * The following IRQs are routed to i8259 PIC.
> > + *
> > + * NOTE: i8259 PIC is cascaded to SIU_INT_IRQ6 of CPM2 interrupt controller
> > + */
> > +#define SBCPQ2_PC_IRQA		(NR_SIU_INTS+0)
> > +#define SBCPQ2_PC_IRQB		(NR_SIU_INTS+1)
> > +#define SBCPQ2_MPC185_IRQ	(NR_SIU_INTS+2)
> > +#define SBCPQ2_ATM_IRQ		(NR_SIU_INTS+3)
> > +#define SBCPQ2_PIRQA		(NR_SIU_INTS+4)
> > +#define SBCPQ2_PIRQB		(NR_SIU_INTS+5)
> > +#define SBCPQ2_PIRQC		(NR_SIU_INTS+6)
> > +#define SBCPQ2_PIRQD		(NR_SIU_INTS+7)
> 
> Again, these are in the device tree, so don't put them here.
> 
> > +/* cpm serial driver works with constants below */
> > +#define SIU_INT_SMC1		((uint)0x04+CPM_IRQ_OFFSET)
> > +#define SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
> > +#define SIU_INT_SCC1		((uint)0x28+CPM_IRQ_OFFSET)
> > +#define SIU_INT_SCC2		((uint)0x29+CPM_IRQ_OFFSET)
> > +#define SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
> > +#define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
> 
> What are these for? If you need them in the device driver, just put
> them in there, not in a header file. Also, you should make
> sure not to pollute the global name space, so they should
> be named SBCPQ2_SIU_INT_* to make it clear that they are board
> specific.
> 
> > +#ifdef CONFIG_SBCPQ2
> > +#include <platforms/82xx/sbcpq2.h>
> > +#endif
> 
> Never put #ifdef around an #include.
> 
> > +
> >   #ifdef CONFIG_PCI_8260
> >   #include <platforms/82xx/m82xx_pci.h>
> >   #endif
> 
> Kill this #ifdef as well while you're there. If you get name space
> conflicts, just rename the symbols to make them unique.
> 
> > +/ {
> > +	model = "SBCPQ2";
> > +	compatible = "mpc82xx";
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	linux,phandle = <100>;
> 
> Don't put explicit phandles here. If you need a reference, do it
> symbolically.
> 
> 	Arnd <><
