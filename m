Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68B1167C4C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 06:41:56 +1100 (EST)
In-Reply-To: <Pine.LNX.4.60.0611051526510.4214@poirot.grange>
References: <Pine.LNX.4.60.0611011844570.3736@poirot.grange>
	<Pine.LNX.4.60.0611051526510.4214@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4EC85F22-99A9-4B0F-987C-25B715235320@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/RFC (take 2)] linkstation / kurobox support under
	arch/powerpc
Date: Mon, 6 Nov 2006 13:41:48 -0600
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 5, 2006, at 9:22 AM, Guennadi Liakhovetski wrote:

> Here comes the 2nd version of the linkstation / kurobox patch. Changes
> since the last version:
>
> On Wed, 1 Nov 2006, Guennadi Liakhovetski wrote:
>
>> A couple things that I don't like that much in this patch:
>>
>> 1) hardcoded PCI IRQ map - I'll have to put it in dts too;
>
> Done. Taken from the fdt now.
>
> Some more cleanup, (seemingly) unneeded stuff removed.
>
> Even if it is not included so far due to variousother pending patches,
> please DO review.
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/ 
> boot/dts/kuroboxHG.dts
> new file mode 100644
> index 0000000..6c76ef6
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/kuroboxHG.dts
> @@ -0,0 +1,183 @@
> +/*
> + * Device Tree Souce for Buffalo KuroboxHG
> + *
> + * Based on sandpoint.dts
> + *
> + * 2006 (c) G. Liakhovetski <g.liakhovetski@gmx.de>
> + *
> + * This file is licensed under
> + * the terms of the GNU General Public License version 2.  This  
> program
> + * is licensed "as is" without any warranty of any kind, whether  
> express
> + * or implied.
> +
> +XXXX add flash parts, rtc, ??
> +
> +build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16  
> kuroboxHG.dts"
> +
> +
> + */
> +
> +/ {
> +	linux,phandle = <1000>;
> +	model = "KuroboxHG";
> +	compatible = "linkstation";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		linux,phandle = <2000>;
> +		#cpus = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,603e { /* Really 8241 */
> +			linux,phandle = <2100>;
> +			linux,boot-cpu;
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <fdad680>;	/* Fixed by bootwrapper */
> +			timebase-frequency = <1F04000>; /* Fixed by bootwrapper */
> +			bus-frequency = <0>;		/* From bootloader */
> +			/* Following required by dtc but not used */
> +			i-cache-line-size = <0>;
> +			d-cache-line-size = <0>;
> +			i-cache-size = <4000>;
> +			d-cache-size = <4000>;
> +		};
> +	};
> +
> +	memory {
> +		linux,phandle = <3000>;
> +		device_type = "memory";
> +		reg = <00000000 08000000>;
> +	};
> +
> +	soc10x { /* AFAICT need to make soc for 8245's uarts to be  
> defined */
> +		linux,phandle = <4000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;
> +		device_type = "soc";
> +		compatible = "mpc10x";
> +		store-gathering = <0>; /* 0 == off, !0 == on */
> +		reg = <80000000 00100000>;
> +		ranges = <80000000 80000000 70000000	/* pci mem space */
> +			  fc000000 fc000000 00100000	/* EUMB */
> +			  fe000000 fe000000 00c00000	/* pci i/o space */
> +			  fec00000 fec00000 00300000	/* pci cfg regs */
> +			  fef00000 fef00000 00100000>;	/* pci iack */
> +
> +		dma@80001100 {
> +			linux,phandle = <4100>;
> +			#interrupt-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			device_type = "dma";
> +			compatible = "fsl-dma";
> +			clock-frequency = <0>;
> +			reg = <80001100 24>;
> +			interrupts = <6 0>;
> +			interrupt-parent = <4400>;
> +		};
> +
> +		dma@80001200 {
> +			linux,phandle = <4200>;
> +			#interrupt-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			device_type = "dma";
> +			compatible = "fsl-dma";
> +			clock-frequency = <0>;
> +			reg = <80001200 24>;
> +			interrupts = <7 0>;
> +			interrupt-parent = <4400>;
> +		};
> +
> +		i2c@80003000 {
> +			linux,phandle = <4300>;
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			clock-frequency = <0>;
> +			reg = <80003000 1000>;
> +			interrupts = <5 2>;
> +			interrupt-parent = <4400>;
> +		};
> +
> +		serial@80004500 {
> +			linux,phandle = <4511>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <80004500 8>;
> +			clock-frequency = <7c044a8>;
> +			current-speed = <2580>;
> +			interrupts = <9 2>;
> +			interrupt-parent = <4400>;
> +		};
> +
> +		serial@80004600 {
> +			linux,phandle = <4512>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <80004600 8>;
> +			clock-frequency = <7c044a8>;
> +			current-speed = <e100>;
> +			interrupts = <a 0>;
> +			interrupt-parent = <4400>;
> +		};
> +
> +		pic@80040000 {
> +			linux,phandle = <4400>;
> +			#interrupt-cells = <2>;
> +			#address-cells = <0>;
> +			device_type = "open-pic";
> +			compatible = "chrp,open-pic";
> +			interrupt-controller;
> +			reg = <80040000 40000>;
> +			clock-frequency = <0>;		/* ??? */
> +			built-in;
> +		};
> +
> +		pci@fec00000 {
> +			linux,phandle = <4500>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <1>;
> +			device_type = "pci";
> +			compatible = "mpc10x-pci";
> +			reg = <fec00000 400000>;
> +			ranges = <01000000 0        0 fe000000 0 00c00000
> +				  02000000 0 80000000 80000000 0 70000000>;
> +			bus-range = <0 ff>;
> +			clock-frequency = <7f28155>;
> +			interrupt-parent = <4400>;
> +			interrupt-map-mask = <f800 0 0 7>;
> +			interrupt-map = <
> +				/* IDSEL 0x11 - IRQ0 ETH */
> +				5800 0 0 1 4400 0 1
> +				5800 0 0 2 4400 1 1
> +				5800 0 0 3 4400 2 1
> +				5800 0 0 4 4400 3 1
> +				/* IDSEL 0x12 - IRQ1 IDE0 */
> +				6000 0 0 1 4400 1 1
> +				6000 0 0 2 4400 2 1
> +				6000 0 0 3 4400 3 1
> +				6000 0 0 4 4400 0 1
> +				/* IDSEL 0x13 - IRQ4 IDE1 */
> +				6800 0 0 1 4400 3 1
> +				6800 0 0 2 4400 0 1
> +				6800 0 0 3 4400 1 1
> +				6800 0 0 4 4400 2 1
> +				/* IDSEL 0x14 - IRQ3 USB2.0 */
> +				7000 0 0 1 4400 3 1
> +				7000 0 0 2 4400 3 1
> +				7000 0 0 3 4400 3 1
> +				7000 0 0 4 4400 3 1
> +				/* IDSEL 0x15 - IRQ2 fan ctrl*/
> +				7800 0 0 1 4400 2 1
> +				7800 0 0 2 4400 3 1
> +				7800 0 0 3 4400 0 1
> +				7800 0 0 4 4400 1 1
> +			>;
> +		};
> +	};
> +};
>

[snip]

> diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/ 
> powerpc/platforms/embedded6xx/Kconfig
> index 234a861..c1c6748 100644
> --- a/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ b/arch/powerpc/platforms/embedded6xx/Kconfig
> @@ -76,6 +76,15 @@ config PRPMC800
>  	  Select SANDPOINT if configuring for a Motorola Sandpoint X3
>  	  (any flavor).
>
> +config LINKSTATION
> +	bool "Linkstation / Kurobox(HG) from Buffalo"
> +	select MPIC
> +	select FSL_SOC
> +	select PPC_UDBG_16550 if SERIAL_8250
> +	help
> +	  Select LINKSTATION if configuring for a PPC-based Linkstation
> +	  (LS-1) or Kurobox(HG) from Buffalo Technologies.
> +
>  config MPC7448HPC2
>  	bool "Freescale MPC7448HPC2(Taiga)"
>  	select TSI108_BRIDGE
> @@ -164,6 +173,19 @@ config EV64360
>  	  platform.
>  endchoice
>
> +choice
> +	prompt "Linkstation Type"
> +	depends on LINKSTATION
> +	default KUROBOXHG
> +
> +config  KUROBOX
> +	bool "Kurobox"
> +
> +config  KUROBOXHG
> +	bool "Kurobox HG"
> +

These two config options don't appear to be used anywhere

> +endchoice
> +
>  config PQ2ADS
>  	bool
>  	depends on ADS8272
> @@ -210,7 +232,7 @@ config PPC_GEN550
>  	depends on SANDPOINT || SPRUCE || PPLUS || \
>  		PRPMC750 || PRPMC800 || LOPEC || \
>  		(EV64260 && !SERIAL_MPSC) || CHESTNUT || RADSTONE_PPC7D || \
> -		83xx
> +		83xx || LINKSTATION
>  	default y
>
>  config FORCE
> @@ -284,13 +306,13 @@ config HARRIER
>
>  config MPC10X_BRIDGE
>  	bool
> -	depends on POWERPMC250 || LOPEC || SANDPOINT
> +	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION
>  	select PPC_INDIRECT_PCI
>  	default y
>
>  config MPC10X_OPENPIC
>  	bool
> -	depends on POWERPMC250 || LOPEC || SANDPOINT
> +	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION
>  	default y
>
>  config MPC10X_STORE_GATHERING
> diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/ 
> powerpc/platforms/embedded6xx/Makefile
> index fa499fe..1f3edc7 100644
> --- a/arch/powerpc/platforms/embedded6xx/Makefile
> +++ b/arch/powerpc/platforms/embedded6xx/Makefile
> @@ -3,3 +3,4 @@ #
>  #
>  obj-$(CONFIG_MPC7448HPC2)	+= mpc7448_hpc2.o
>  obj-$(CONFIG_SANDPOINT)		+= sandpoint.o
> +obj-$(CONFIG_LINKSTATION)	+= linkstation.o ls_uart.o
> diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/ 
> arch/powerpc/platforms/embedded6xx/linkstation.c
> new file mode 100644
> index 0000000..30bcb5b
> --- /dev/null
> +++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
> @@ -0,0 +1,254 @@
> +/*
> + * arch/powerpc/platforms/embedded6xx/linkstation.c
> + *
> + * Board setup routines for the Buffalo Linkstation / Kurobox  
> Platform.
> + *
> + * Author: Mark A. Greer
> + *	 mgreer@mvista.com
> + *
> + * 2000-2003 (c) MontaVista Software, Inc.  This file is licensed  
> under
> + * the terms of the GNU General Public License version 2.  This  
> program
> + * is licensed "as is" without any warranty of any kind, whether  
> express
> + * or implied.
> + */
> +
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/reboot.h>
> +#include <linux/pci.h>
> +#include <linux/kdev_t.h>
> +#include <linux/major.h>
> +#include <linux/initrd.h>
> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/ide.h>
> +#include <linux/seq_file.h>
> +#include <linux/root_dev.h>
> +#include <linux/serial.h>
> +#include <linux/tty.h>	/* for linux/serial_core.h */
> +#include <linux/serial_core.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_8250.h>
> +#include <linux/mtd/physmap.h>
> +
> +#include <asm/system.h>
> +#include <asm/pgtable.h>
> +#include <asm/page.h>
> +#include <asm/time.h>
> +#include <asm/dma.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/smp.h>
> +#include <asm/vga.h>
> +#include <asm/i8259.h>
> +#include <asm/mpic.h>
> +#include <asm/todc.h>
> +#include <asm/bootinfo.h>
> +#include <asm/mpc10x.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/ppc_sys.h>
> +
> +static struct mtd_partition linkstation_physmap_partitions[] = {
> +	{
> +		.name   = "mtd_firmimg",
> +		.offset = 0x000000,
> +		.size   = 0x300000,
> +	},
> +	{
> +		.name   = "mtd_bootcode",
> +		.offset = 0x300000,
> +		.size   =  0x70000,
> +	},
> +	{
> +		.name   = "mtd_status",
> +		.offset = 0x370000,
> +		.size   =  0x10000,
> +	},
> +	{
> +		.name   = "mtd_conf",
> +		.offset = 0x380000,
> +		.size   =  0x80000,
> +	},
> +	{
> +		.name   = "mtd_allflash",
> +		.offset = 0x000000,
> +		.size   = 0x400000,
> +	},
> +	{
> +		.name   = "mtd_data",
> +		.offset = 0x310000,
> +		.size   =  0xf0000,
> +	},
> +};
> +
> +/*
> + * Buffalo linkstation interrupt routing.
> + */
> +
> +void __init linkstation_pcibios_fixup(void)
> +{
> +	struct pci_dev *dev = NULL;
> +
> +	for_each_pci_dev(dev)
> +		pci_read_irq_line(dev);
> +}
> +

You don't need this fixup going forward.

> +static int __init add_bridge(struct device_node *dev)
> +{
> +	int len;
> +	struct pci_controller *hose;
> +	int *bus_range;
> +
> +	printk("Adding PCI host bridge %s\n", dev->full_name);
> +
> +	bus_range = (int *) get_property(dev, "bus-range", &len);
> +	if (bus_range == NULL || len < 2 * sizeof(int))
> +		printk(KERN_WARNING "Can't get bus-range for %s, assume"
> +				" bus 0\n", dev->full_name);
> +
> +	hose = pcibios_alloc_controller();
> +	if (hose == NULL)
> +		return -ENOMEM;
> +	hose->first_busno = bus_range ? bus_range[0] : 0;
> +	hose->last_busno = bus_range ? bus_range[1] : 0xff;
> +	hose->arch_data = dev;
> +	setup_indirect_pci(hose, 0xfec00000, 0xfee00000);
> +
> +	/* Interpret the "ranges" property */
> +	/* This also maps the I/O region and sets isa_io/mem_base */
> +	pci_process_bridge_OF_ranges(hose, dev, 1);
> +
> +	return 0;
> +}
> +
> +static void __init linkstation_setup_arch(void)
> +{
> +	struct device_node *np;
> +#ifdef CONFIG_MTD_PHYSMAP
> +	physmap_set_partitions(linkstation_physmap_partitions,
> +			       ARRAY_SIZE(linkstation_physmap_partitions));
> +#endif
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	if (initrd_start)
> +		ROOT_DEV = Root_RAM0;
> +	else
> +#endif
> +#ifdef	CONFIG_ROOT_NFS
> +		ROOT_DEV = Root_NFS;
> +#else
> +		ROOT_DEV = Root_HDA1;
> +#endif
> +
> +	/* Lookup PCI host bridges */
> +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> +		add_bridge(np);
> +
> +	ppc_md.pci_swizzle = common_swizzle;
> +
> +	printk(KERN_INFO "BUFFALO Network Attached Storage Series\n");
> +	printk(KERN_INFO "(C) 2002-2005 BUFFALO INC.\n");
> +}
> +
> +/*
> + * Interrupt setup and service.  Interrrupts on the linkstation come
> + * from the four PCI slots plus onboard 8241 devices: I2C, DUART.
> + */
> +static void __init linkstation_init_IRQ(void)
> +{
> +	struct mpic *mpic;
> +	struct device_node *dnp;
> +	void *prop;
> +	int size;
> +	phys_addr_t paddr;
> +
> +	dnp = of_find_node_by_type(NULL, "open-pic");
> +	if (dnp == NULL)
> +		return;
> +
> +	prop = (struct device_node *)get_property(dnp, "reg", &size);
> +	paddr = (phys_addr_t)of_translate_address(dnp, prop);
> +
> +	mpic = mpic_alloc(dnp, paddr, MPIC_PRIMARY | MPIC_WANTS_RESET, 4,  
> 32, " EPIC     ");
> +	BUG_ON(mpic == NULL);
> +
> +	/* PCI IRQs */
> +	mpic_assign_isu(mpic, 0, paddr + 0x10200);
> +
> +	/* I2C */
> +	mpic_assign_isu(mpic, 1, paddr + 0x11000);
> +
> +	/* ttyS0, ttyS1 */
> +	mpic_assign_isu(mpic, 2, paddr + 0x11100);
> +
> +	mpic_init(mpic);
> +}
> +
> +extern void avr_uart_configure(void);
> +extern void avr_uart_send(const char);
> +
> +static void linkstation_restart(char *cmd)
> +{
> +	local_irq_disable();
> +
> +	/* Reset system via AVR */
> +	avr_uart_configure();
> +	/* Send reboot command */
> +	avr_uart_send('C');
> +
> +	for(;;)  /* Spin until reset happens */
> +		avr_uart_send('G');	/* "kick" */
> +}
> +
> +static void linkstation_power_off(void)
> +{
> +	local_irq_disable();
> +
> +	avr_uart_configure();
> +	/* send shutdown command */
> +	avr_uart_send('E');
> +
> +	for(;;)  /* Spin until power-off happens */
> +		avr_uart_send('G');	/* "kick" */
> +	/* NOTREACHED */
> +}
> +
> +static void linkstation_halt(void)
> +{
> +	linkstation_power_off();
> +	/* NOTREACHED */
> +}
> +
> +static void linkstation_show_cpuinfo(struct seq_file *m)
> +{
> +	seq_printf(m, "vendor\t\t: Buffalo Technology\n");
> +	seq_printf(m, "machine\t\t: Linkstation I/Kurobox(HG)\n");
> +}
> +
> +static int __init linkstation_probe(void)
> +{
> +	unsigned long root;
> +
> +	root = of_get_flat_dt_root();
> +
> +	if (!of_flat_dt_is_compatible(root, "linkstation"))
> +		return 0;
> +	return 1;
> +}
> +
> +define_machine(linkstation){
> +	.name 			= "Buffalo Linkstation",
> +	.probe 			= linkstation_probe,
> +	.setup_arch 		= linkstation_setup_arch,
> +	.init_IRQ 		= linkstation_init_IRQ,
> +	.show_cpuinfo 		= linkstation_show_cpuinfo,
> +	.pcibios_fixup		= linkstation_pcibios_fixup,
> +	.get_irq 		= mpic_get_irq,
> +	.restart 		= linkstation_restart,
> +	.power_off 		= linkstation_power_off,
> +	.halt	 		= linkstation_halt,
> +	.calibrate_decr 	= generic_calibrate_decr,
> +};
> diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/ 
> powerpc/platforms/embedded6xx/ls_uart.c
> new file mode 100644
> index 0000000..b640115
> --- /dev/null
> +++ b/arch/powerpc/platforms/embedded6xx/ls_uart.c
> @@ -0,0 +1,131 @@
> +#include <linux/workqueue.h>
> +#include <linux/string.h>
> +#include <linux/delay.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_8250.h>
> +#include <asm/io.h>
> +#include <asm/mpc10x.h>
> +#include <asm/ppc_sys.h>
> +#include <asm/prom.h>
> +#include <asm/termbits.h>
> +

Can this code not be reworked to use the standard 8250 driver?

> +static void __iomem *avr_addr;
> +static unsigned long avr_clock;
> +
> +static struct work_struct wd_work;
> +
> +static void wd_stop(void *unused)
> +{
> +	const char string[] = "AAAAFFFFJJJJ>>>>VVVV>>>>ZZZZVVVVKKKK";
> +	int i = 0, rescue = 8;
> +	int len = strlen(string);
> +
> +	while (rescue--) {
> +		int j;
> +		char lsr = in_8(avr_addr + UART_LSR);
> +
> +		if (lsr & (UART_LSR_THRE | UART_LSR_TEMT)) {
> +			for (j = 0; j < 16 && i < len; j++, i++)
> +				out_8(avr_addr + UART_TX, string[i]);
> +			if (i == len) {
> +				/* Read "OK" back: 4ms for the last "KKKK"
> +				   plus a couple bytes back */
> +				msleep(7);
> +				printk("linkstation: disarming the AVR watchdog: ");
> +				while (in_8(avr_addr + UART_LSR) & UART_LSR_DR)
> +					printk("%c", in_8(avr_addr + UART_RX));
> +				break;
> +			}
> +		}
> +		msleep(17);
> +	}
> +	printk("\n");
> +}
> +
> +#define AVR_QUOT(clock) ((clock) + 8 * 9600) / (16 * 9600)
> +
> +void avr_uart_configure(void)
> +{
> +	unsigned char cval = UART_LCR_WLEN8;
> +	unsigned int quot = AVR_QUOT(avr_clock);
> +
> +	if (!avr_addr || !avr_clock)
> +		return;
> +
> +	out_8(avr_addr + UART_LCR, cval);			/* initialise UART */
> +	out_8(avr_addr + UART_MCR, 0);
> +	out_8(avr_addr + UART_IER, 0);
> +
> +	cval |= UART_LCR_STOP | UART_LCR_PARITY | UART_LCR_EPAR;
> +
> +	out_8(avr_addr + UART_LCR, cval);			/* Set character format */
> +
> +	out_8(avr_addr + UART_LCR, cval | UART_LCR_DLAB);	/* set DLAB */
> +	out_8(avr_addr + UART_DLL, quot & 0xff);		/* LS of divisor */
> +	out_8(avr_addr + UART_DLM, quot >> 8);			/* MS of divisor */
> +	out_8(avr_addr + UART_LCR, cval);			/* reset DLAB */
> +	out_8(avr_addr + UART_FCR, UART_FCR_ENABLE_FIFO);	/* enable FIFO */
> +}
> +
> +void avr_uart_send(const char c)
> +{
> +	if (!avr_addr || !avr_clock)
> +		return;
> +
> +	out_8(avr_addr + UART_TX, c);
> +	out_8(avr_addr + UART_TX, c);
> +	out_8(avr_addr + UART_TX, c);
> +	out_8(avr_addr + UART_TX, c);
> +}
> +
> +static void __init ls_uart_init(void)
> +{
> +	local_irq_disable();
> +
> +#ifndef CONFIG_SERIAL_8250
> +	out_8(avr_addr + UART_FCR, UART_FCR_ENABLE_FIFO);	/* enable FIFO */
> +	out_8(avr_addr + UART_FCR, UART_FCR_ENABLE_FIFO |
> +	      UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);	/* clear FIFOs */
> +	out_8(avr_addr + UART_FCR, 0);
> +	out_8(avr_addr + UART_IER, 0);
> +
> +	/* Clear up interrupts */
> +	(void) in_8(avr_addr + UART_LSR);
> +	(void) in_8(avr_addr + UART_RX);
> +	(void) in_8(avr_addr + UART_IIR);
> +	(void) in_8(avr_addr + UART_MSR);
> +#endif
> +	avr_uart_configure();
> +
> +	local_irq_enable();
> +}
> +
> +static int __init ls_uarts_init(void)
> +{
> +	struct device_node *avr;
> +	phys_addr_t phys_addr;
> +	int len;
> +
> +	avr = of_find_node_by_path("/soc10x/serial@80004500");
> +	if (!avr)
> +		return -EINVAL;
> +
> +	avr_clock = *(u32*)get_property(avr, "clock-frequency", &len);
> +	phys_addr = ((u32*)get_property(avr, "reg", &len))[0];
> +
> +	if (!avr_clock || !phys_addr)
> +		return -EINVAL;
> +
> +	avr_addr = ioremap(phys_addr, 32);
> +	if (!avr_addr)
> +		return -EFAULT;
> +
> +	ls_uart_init();
> +
> +	INIT_WORK(&wd_work, wd_stop, NULL);
> +	schedule_work(&wd_work);
> +
> +	return 0;
> +}
> +
> +late_initcall(ls_uarts_init);
> diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
> index f1c7575..25cd8de 100644
> --- a/drivers/net/r8169.c
> +++ b/drivers/net/r8169.c
> @@ -1396,41 +1396,6 @@ static void rtl8169_netpoll(struct net_d
>  }
>  #endif

Pull this into a separate patch since it effects a driver.  Also, any  
reason this code is being removed?

>
> -static void __rtl8169_set_mac_addr(struct net_device *dev, void  
> __iomem *ioaddr)
> -{
> -	unsigned int i, j;
> -
> -	RTL_W8(Cfg9346, Cfg9346_Unlock);
> -	for (i = 0; i < 2; i++) {
> -		__le32 l = 0;
> -
> -		for (j = 0; j < 4; j++) {
> -			l <<= 8;
> -			l |= dev->dev_addr[4*i + j];
> -		}
> -		RTL_W32(MAC0 + 4*i, cpu_to_be32(l));
> -	}
> -	RTL_W8(Cfg9346, Cfg9346_Lock);
> -}
> -
> -static int rtl8169_set_mac_addr(struct net_device *dev, void *p)
> -{
> -	struct rtl8169_private *tp = netdev_priv(dev);
> -	struct sockaddr *addr = p;
> -
> -	if (!is_valid_ether_addr(addr->sa_data))
> -		return -EINVAL;
> -
> -	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
> -
> -	if (netif_running(dev)) {
> -		spin_lock_irq(&tp->lock);
> -		__rtl8169_set_mac_addr(dev, tp->mmio_addr);
> -		spin_unlock_irq(&tp->lock);
> -	}
> -	return 0;
> -}
> -
>  static void rtl8169_release_board(struct pci_dev *pdev, struct  
> net_device *dev,
>  				  void __iomem *ioaddr)
>  {
> @@ -1680,7 +1645,6 @@ rtl8169_init_one(struct pci_dev *pdev, c
>  	dev->stop = rtl8169_close;
>  	dev->tx_timeout = rtl8169_tx_timeout;
>  	dev->set_multicast_list = rtl8169_set_rx_mode;
> -	dev->set_mac_address = rtl8169_set_mac_addr;
>  	dev->watchdog_timeo = RTL8169_TX_TIMEOUT;
>  	dev->irq = pdev->irq;
>  	dev->base_addr = (unsigned long) ioaddr;
> @@ -1928,8 +1892,6 @@ rtl8169_hw_start(struct net_device *dev)
>  	/* Enable all known interrupts by setting the interrupt mask. */
>  	RTL_W16(IntrMask, rtl8169_intr_mask);
>
> -	__rtl8169_set_mac_addr(dev, ioaddr);
> -
>  	netif_start_queue(dev);
>  }
