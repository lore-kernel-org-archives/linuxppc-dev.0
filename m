Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D214FDDE01
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 May 2007 00:19:11 +1000 (EST)
In-Reply-To: <200705082356.02334.repvik@kynisk.com>
References: <200705061446.05491.repvik@kynisk.com>
	<200705082356.02334.repvik@kynisk.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <FE88B5E3-697F-4F6B-8B76-5FF0574D07F9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] TurboStation support (Properly)
Date: Wed, 9 May 2007 09:18:18 -0500
To: =?ISO-8859-1?Q?=D8yvind_Repvik?= <repvik@kynisk.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 8, 2007, at 4:56 PM, =D8yvind Repvik wrote:

> On Sunday 06 May 2007 14:46:05 =D8yvind Repvik wrote:
>> Hi,
>>
>> 	This patch adds support for the QNAP TurboStation TS-101 and =20
>> TS-201 devices.
>
> Of course, it probably helps if my mail client doesn't break the =20
> patch completely.

Comments below.

Out of interesting, what's the difference between the TS-101 and TS-201?

>
>
> Signed-off-by: =D8yvind Repvik <nail@nslu2-linux.org>
> Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
>
> --- linux-2.6.21.1/arch/powerpc/boot/dts/qnap-ts101.dts	=
1970-01-01 =20
> 01:00:00.000000000 +0100
> +++ linux-2.6.21.1.ts/arch/powerpc/boot/dts/qnap-ts101.dts	=20
> 2007-05-03 22:44:59.000000000 +0200
> @@ -0,0 +1,166 @@
> +/*
> + * Device Tree Souce for QNAP Turbostation 101/201
> + *
> + * Choose CONFIG_TURBOSTATION to build a kernel for turbostation
> + *
> + *
> + * Based on kuroboxHD.dts by G. Liakhovetski
> + *
> + * 2007 (c) Oyvind Repvik <nail@nslu2-linux.org>
> + *
> + * This file is licensed under
> + * the terms of the GNU General Public License version 2.  This =20
> program
> + * is licensed "as is" without any warranty of any kind, whether =20
> express
> + * or implied.
> + *
> + * build with: "dtc -f -I dts -O dtb -o qnap-ts101.dtb -V 16 qnap-=20
> ts101.dts"
> + *
> + *
> + */
> +
> +/ {
> +	linux,phandle =3D <1000>;
> +	model =3D "TurboStation TSx01";
> +	compatible =3D "turbostation";
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +
> +	cpus {
> +		linux,phandle =3D <2000>;

Can you removal all linux,phandle's and use the new reference syntax.

> +		#cpus =3D <1>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		PowerPC,603e { /* Really 8241 */
> +			linux,phandle =3D <2100>;
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			clock-frequency =3D <fdad680>;	/* 266 MHz */
> +			timebase-frequency =3D <1fca055>;	/* =
33.3333333 MHz */
> +			bus-frequency =3D <0>;
> +			/* Following required by dtc but not used */
> +			i-cache-line-size =3D <0>;
> +			d-cache-line-size =3D <0>;

No reason not to set the line-size properly to <20>

> +			i-cache-size =3D <4000>;
> +			d-cache-size =3D <4000>;
> +		};
> +	};
> +
> +	/* 64MB @ 0x0 */
> +	memory {
> +		linux,phandle =3D <3000>;
> +		device_type =3D "memory";
> +		reg =3D <00000000 04000000>;
> +	};
> +
> +	flash@ff000000 {
> +		linux,phandle =3D <3100>;
> +		device_type =3D "rom";
> +		compatible =3D "direct-mapped";
> +		probe-type =3D "CFI";
> +		reg =3D <ff000000 01000000>;
> +		bank-width =3D <1>;
> +		partitions =3D <
> +				00000000 00200000
> +				00200000 00d00000
> +				00f00000 00040001
> +				00f40000 00020000
> +				00f60000 00040000
> +				00fa0000 00020000
> +				00fc0000 00040000
> +		>;
> +		partition-names =3D =
"kernel\0rootfs\0uboot1\0uboot1-env\0uboot2=20
> \0uboot2-env\0SysConf";
> +	};
> +
> +
> +	soc10x { /* AFAICT need to make soc for 8245's uarts to be =20
> defined */
> +		linux,phandle =3D <4000>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		#interrupt-cells =3D <2>;
> +		device_type =3D "soc";
> +		compatible =3D "mpc10x";
> +		store-gathering =3D <0>; /* 0 =3D=3D off, !0 =3D=3D on =
*/
> +		reg =3D <80000000 00100000>;
> +		ranges =3D <80000000 80000000 70000000	/* pci mem space =
*/
> +			  fc000000 fc000000 00100000	/* EUMB */
> +			  fe000000 fe000000 00c00000	/* pci i/o space =
*/
> +			  fec00000 fec00000 00300000	/* pci cfg regs =
*/
> +			  fef00000 fef00000 00100000>;	/* pci iack */
> +
> +		i2c@fc003000 {
> +			linux,phandle =3D <4300>;
> +			device_type =3D "i2c";
> +			compatible =3D "fsl-i2c";
> +			reg =3D <fc003000 1000>;
> +			interrupts =3D <5 2>;
> +			interrupt-parent =3D <4400>;
> +		};
> +
> +		serial@fc004500 {
> +			linux,phandle =3D <4511>;
> +			device_type =3D "serial";
> +			compatible =3D "ns16550";
> +			reg =3D <fc004500 8>;
> +			clock-frequency =3D <7ed6b40>;	/* 133 MHz */
> +			current-speed =3D <1c200>;	/* 115200 */
> +			interrupts =3D <9 2>;
> +			interrupt-parent =3D <4400>;
> +		};
> +
> +		serial@fc004600 {
> +			linux,phandle =3D <4512>;
> +			device_type =3D "serial";
> +			compatible =3D "ns16550";
> +			reg =3D <fc004600 8>;
> +			clock-frequency =3D <7ed6b40>;
> +			current-speed =3D <4b00>;		/* 19200 =
*/
> +			interrupts =3D <a 2>;
> +			interrupt-parent =3D <4400>;
> +		};
> +
> +		pic@fc040000 {
> +			linux,phandle =3D <4400>;
> +			#interrupt-cells =3D <2>;
> +			#address-cells =3D <0>;
> +			device_type =3D "open-pic";
> +			compatible =3D "chrp,open-pic";
> +			interrupt-controller;
> +			reg =3D <fc040000 40000>;
> +			built-in;
> +		};
> +
> +		pci@fe800000 {
> +			linux,phandle =3D <4500>;
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			#interrupt-cells =3D <1>;
> +			device_type =3D "pci";
> +			compatible =3D "mpc10x-pci";
> +			reg =3D <fc000000 400000>;
> +			ranges =3D <01000000 0        0 fe000000 0 =
00c00000
> +				  02000000 0 80000000 80000000 0 =
70000000>;
> +			bus-range =3D <0 ff>;
> +			clock-frequency =3D <7ed6b40>;	/* 133 MHz */
> +			interrupt-parent =3D <4400>;
> +			interrupt-map-mask =3D <f800 0 0 7>;
> +			interrupt-map =3D <
> +				/* IDSEL 0x13 - SATA*/
> +				6800 0 0 1 4400 0 1
> +				6800 0 0 2 4400 0 1
> +				6800 0 0 3 4400 0 1
> +				6800 0 0 4 4400 0 1
> +				/* IDSEL 0x14 - USB */
> +				7000 0 0 1 4400 1 1
> +				7000 0 0 2 4400 1 1
> +				7000 0 0 3 4400 1 1
> +				7000 0 0 4 4400 1 1
> +				/* IDSEL 0x15 - ETH */
> +				7800 0 0 1 4400 2 1
> +				7800 0 0 2 4400 2 1
> +				7800 0 0 3 4400 2 1
> +				7800 0 0 4 4400 2 1
> +			>;
> +		};
> +	};
> +};
> Binary files linux-2.6.21.1/arch/powerpc/boot/dts/storcenter.dtb =20
> and linux-2.6.21.1.ts/arch/powerpc/boot/dts/storcenter.dtb differ
> --- linux-2.6.21.1/arch/powerpc/platforms/embedded6xx/Kconfig	=20
> 2007-04-27 23:49:26.000000000 +0200
> +++ linux-2.6.21.1.ts/arch/powerpc/platforms/embedded6xx/Kconfig	=20=

> 2007-05-06 14:31:55.000000000 +0200
> @@ -87,6 +87,13 @@
>  	  Linkstation-I HD-HLAN and HD-HGLAN versions, and PPC-based
>  	  Terastation systems should be supported too.
>
> +config TURBOSTATION
> +	bool "QNap TS-101/TS-102 TurboStation"
> +	select MPIC
> +	select FSL_SOC
> +	select PPC_UDBG_16550 if SERIAL_8250
> +	select DEFAULT_UIMAGE
> +
>  config MPC7448HPC2
>  	bool "Freescale MPC7448HPC2(Taiga)"
>  	select TSI108_BRIDGE
> @@ -200,7 +207,7 @@
>  	depends on SANDPOINT || SPRUCE || PPLUS || \
>  		PRPMC750 || PRPMC800 || LOPEC || \
>  		(EV64260 && !SERIAL_MPSC) || CHESTNUT || RADSTONE_PPC7D =
|| \
> -		83xx || LINKSTATION
> +		83xx || LINKSTATION || TURBOSTATION
>  	default y
>
>  config FORCE
> @@ -274,13 +281,15 @@
>
>  config MPC10X_BRIDGE
>  	bool
> -	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION
> +	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION || \
> +	TURBOSTATION
>  	select PPC_INDIRECT_PCI
>  	default y
>
>  config MPC10X_OPENPIC
>  	bool
> -	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION
> +	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION || \
> +	TURBOSTATION
>  	default y
>
>  config MPC10X_STORE_GATHERING
> --- linux-2.6.21.1/arch/powerpc/platforms/embedded6xx/Makefile	=20=

> 2007-04-27 23:49:26.000000000 +0200
> +++ linux-2.6.21.1.ts/arch/powerpc/platforms/embedded6xx/Makefile	=20=

> 2007-05-06 14:30:58.000000000 +0200
> @@ -3,3 +3,4 @@
>  #
>  obj-$(CONFIG_MPC7448HPC2)	+=3D mpc7448_hpc2.o
>  obj-$(CONFIG_LINKSTATION)	+=3D linkstation.o ls_uart.o
> +obj-$(CONFIG_TURBOSTATION)	+=3D turbostation.o
> --- linux-2.6.21.1/arch/powerpc/platforms/embedded6xx/=20
> turbostation.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.21.1.ts/arch/powerpc/platforms/embedded6xx/=20
> turbostation.c	2007-05-03 22:45:03.000000000 +0200
> @@ -0,0 +1,141 @@
> +/*
> + * Board setup routines for the QNAP Turbostation platform (TS-101/=20=

> TS-201)
> + *
> + * Copyright (C) 2007 Oyvind Repvik (nail@nslu2-linux.org)
> + *
> + * Based on linkstation.c by G. Liakhovetski
> + *
> + * This file is licensed under the terms of the GNU General Public =20=

> License
> + * version 2.  This program is licensed "as is" without any =20
> warranty of
> + * any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/initrd.h>
> +#include <linux/mtd/physmap.h>
> +
> +#include <asm/time.h>
> +#include <asm/prom.h>
> +#include <asm/mpic.h>
> +#include <asm/mpc10x.h>
> +#include <asm/pci-bridge.h>
> +
> +static int __init add_bridge(struct device_node *dev)
> +{
> +	int len;
> +	struct pci_controller *hose;
> +	int *bus_range;
> +
> +	printk("Adding PCI host bridge %s\n", dev->full_name);
> +
> +	bus_range =3D (int *) get_property(dev, "bus-range", &len);
> +	if (bus_range =3D=3D NULL || len < 2 * sizeof(int))
> +		printk(KERN_WARNING "Can't get bus-range for %s, assume"
> +				" bus 0\n", dev->full_name);
> +
> +	hose =3D pcibios_alloc_controller();
> +	if (hose =3D=3D NULL)
> +		return -ENOMEM;
> +	hose->first_busno =3D bus_range ? bus_range[0] : 0;
> +	hose->last_busno =3D bus_range ? bus_range[1] : 0xff;
> +	hose->arch_data =3D dev;
> +	setup_indirect_pci(hose, 0xfec00000, 0xfee00000);
> +
> +	/* Interpret the "ranges" property */
> +	/* This also maps the I/O region and sets isa_io/mem_base */
> +	pci_process_bridge_OF_ranges(hose, dev, 1);
> +
> +	return 0;
> +}
> +
> +static void __init turbostation_setup_arch(void)
> +{
> +	struct device_node *np;
> +
> +	/* Lookup PCI host bridges */
> +	for (np =3D NULL; (np =3D of_find_node_by_type(np, "pci")) !=3D =
NULL;)
> +		add_bridge(np);
> +
> +	printk(KERN_INFO "QNAP Turbostation series\n");
> +}
> +
> +/*
> + * Interrupt setup and service.  Interrrupts on the turbostation come
> + * from the four PCI slots plus onboard 8241 devices: I2C, DUART.
> + */
> +static void __init turbostation_init_IRQ(void)
> +{
> +	struct mpic *mpic;
> +	struct device_node *dnp;
> +	void *prop;
> +	int size;
> +	phys_addr_t paddr;
> +
> +	dnp =3D of_find_node_by_type(NULL, "open-pic");
> +	if (dnp =3D=3D NULL)
> +		return;
> +
> +	prop =3D (struct device_node *)get_property(dnp, "reg", &size);
> +	paddr =3D (phys_addr_t)of_translate_address(dnp, prop);
> +
> +	mpic =3D mpic_alloc(dnp, paddr, MPIC_PRIMARY | MPIC_WANTS_RESET,
> +			4, 32, " EPIC     ");
> +	BUG_ON(mpic =3D=3D NULL);
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
> +static void turbostation_restart(char *cmd)
> +{
> +	/* Insert restart-stuff */
> +}
> +
> +static void turbostation_power_off(void)
> +{
> +	/* Insert powerdown-stuff */
> +}
> +
> +static void turbostation_halt(void)
> +{
> +	turbostation_power_off();
> +}
> +
> +static void turbostation_show_cpuinfo(struct seq_file *m)
> +{
> +	seq_printf(m, "vendor\t\t: QNAP Systems Inc.\n");
> +	seq_printf(m, "machine\t\t: Turbostation TS-101/TS-201\n");
> +}
> +
> +static int __init turbostation_probe(void)
> +{
> +	unsigned long root;
> +
> +	root =3D of_get_flat_dt_root();
> +
> +	if (!of_flat_dt_is_compatible(root, "turbostation"))
> +		return 0;
> +	return 1;
> +}
> +
> +define_machine(turbostation){
> +	.name 			=3D "QNAP Turbostation",
> +	.probe 			=3D turbostation_probe,
> +	.setup_arch 		=3D turbostation_setup_arch,
> +	.init_IRQ 		=3D turbostation_init_IRQ,
> +	.show_cpuinfo 		=3D turbostation_show_cpuinfo,
> +	.get_irq 		=3D mpic_get_irq,
> +	.restart 		=3D turbostation_restart,
> +	.power_off 		=3D turbostation_power_off,
> +	.halt	 		=3D turbostation_halt,
> +	.calibrate_decr 	=3D generic_calibrate_decr,
> +};
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
