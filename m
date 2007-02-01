Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id BA018DDE2C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 23:21:15 +1100 (EST)
Date: 1 Feb 2007 12:13:52 -0000
Message-ID: <20070201121352.28102.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: sb@thebackend.de, linuxppc-embedded@ozlabs.org
Subject: Re: MV64360 ethernet controller
In-Reply-To: <A0BE90C9-AC7B-40AC-ACD2-E303B15CAF1A@thebackend.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

sb@thebackend.de wrote:
> I recently got a few Force/Motorola PowerPMC-280 PMC modules  
> consisting mainly of a MPC7447 G4 an the Marvell MV64360 system  
> controller. Since this a hobbyist project only I don't have  
> Montavista Linux which seems to already support the board. Instead I  
> ported the stock Linux kernel. Works quite well so far. The only  
> thing I did not get to work is the integrated ethernet. The  
> mv64360_eth driver loads fine and sees both ports. It does not get  
> any interrupts for incoming packets (activity led blinks though).  
> Only unplugging the cable generates an interrupt.
> 
> Since I do not have any documentation on the Marvell chip and the  
> company does not answer my request I am quite lost.
> 
> The PHY interrupts are routed to one of the GPIO/interrupt pins. I  
> did not find any code in the ethernet driver that would be able to  
> use it though. Is it needed at all?
> 
> Any hint is appreciated!
> Sebastian

Hi Sebastian,

Yes, the driver needs receive and transmit interrupts.  However, the
same irq number is used for PHY status change as well as for packet
receive and transmit.  I don't see how you could see PHY status change
interrupts and not rx/tx interrupts.  mv643xx_eth_int_handler() should
be called for all ethernet-related interrupts*.  Are you certain that
you're not seeing rx and tx interrupts?

* You may not see an interrupt on every packet because of the
transmit irq coalescing mechanism and the use of NAPI on receive.

Mark Greer and I are starting on arch/powerpc support for the mv64x60
and ppmc280.  We will submit it as when we have something useful.
In the meantime, the arch/ppc code below may serve as a hint.
(Just to be clear, I didn't write this code and don't mean to take
credit for it.)

-Dale

/*
 * arch/ppc/platforms/ppmc280.h
 *
 * Definitions for Motorola  PPMC280 board
 *
 * Based on db64360.h, Written by Rabeeh Khoury - rabeeh@galileo.co.il
 * Based on code done by Mark A. Greer <mgreer@mvista.com>
 *
 * 2001-2002 (c) MontaVista, Software, Inc.  This file is licensed under
 * the terms of the GNU General Public License version 2.  This program
 * is licensed "as is" without any warranty of any kind, whether express
 * or implied.
 */

/*
 * The MV64x60 has 2 PCI buses each with 1 window from the CPU bus to
 * PCI I/O space and 4 windows from the CPU bus to PCI MEM space.
 * We'll only use one PCI MEM window on each PCI bus.
 *
 * This is the CPU physical memory map (windows must be at least 1MB and start
 * on a boundary that is a multiple of the window size):
 *
 *     0xf2040000-0xffffffff           - Unused
 *     0xf2000000-0xf203ffff           - Integrated SRAM
 *     0xf1010000-0xf1ffffff           - Unused
 *     0xf1000000-0xf100ffff           - MV64360 Registers
 *     0xc0800000-0xf0ffffff           - Unused
 *     0xc0000000-0xc07fffff           - Boot flash (BootCS#)
 *     0xb2000000-0xb2ffffff           - User flash 1 ( CS1)
 *     0xb0000000-0xb1ffffff           - User flash 0 ( CS0)
 *     0xa8000000-0x9fffffff           - Unused
 *     0xa8000000-0xa7ffffff           - PCI 1 I/O (defined in mv64360.h)
 *     0xa0000000-0xa7ffffff           - PCI 0 I/O (defined in mv64360.h)
 *     0x90000000-0x9fffffff           - PCI 1 MEM (defined in mv64360.h)
 *     0x80000000-0x8fffffff           - PCI 0 MEM (defined in mv64360.h)
 *     0x20000000-0x7fffffff           - Reserved for SDRAM expansion
 *     0x00000000-0x1fffffff           - On Board SDRAM ( CS0)
 */

#ifndef __PPC_PLATFORMS_PPMC280
#define __PPC_PLATFORMS_PPMC280

/* PCI mappings */
#define PPMC280_PCI0_IO_CPU_BASE        0xa0000000
#define PPMC280_PCI0_IO_PCI_BASE        0x00000000
#define PPMC280_PCI0_IO_SIZE            0x01000000

#define PPMC280_PCI0_MEM_CPU_BASE       0x80000000
#define PPMC280_PCI0_MEM_PCI_BASE       0x80000000
#define PPMC280_PCI0_MEM_SIZE           0x10000000

#define PPMC280_PCI1_IO_CPU_BASE        (PPMC280_PCI0_IO_CPU_BASE + \
                                                PPMC280_PCI0_IO_SIZE)
#define PPMC280_PCI1_IO_PCI_BASE        (PPMC280_PCI0_IO_PCI_BASE + \
                                                PPMC280_PCI0_IO_SIZE)
#define PPMC280_PCI1_IO_SIZE            0x01000000

#define PPMC280_PCI1_MEM_CPU_BASE       (PPMC280_PCI0_MEM_CPU_BASE + \
                                                PPMC280_PCI0_MEM_SIZE)
#define PPMC280_PCI1_MEM_PCI_BASE       (PPMC280_PCI0_MEM_PCI_BASE + \
                                                PPMC280_PCI0_MEM_SIZE)
#define PPMC280_PCI1_MEM_SIZE           0x10000000

/* CPU Physical Memory Map setup (other than PCI) */
#define PPMC280_EXT_FLASH_BASE_1	0xb0000000
#define PPMC280_EXT_FLASH_BASE_2	0xb2000000
#define PPMC280_BOOT_FLASH_BASE		0xc0000000  /* BOOT FLASH Base */
#define PPMC280_INTERNAL_SRAM_BASE      0xf2000000

#if defined(CONFIG_MTD_PPMC2800D_FLASH) || defined(CONFIG_MTD_PPMC2800D_FLASH_MODULE)
#define PPMC280_EXT_FLASH_SIZE_ACTUAL	0x04000000
#define PPMC280_BOOT_FLASH_SIZE_ACTUAL	0x01000000  /* =< 16M of Boot FLASH */
#else
#define PPMC280_EXT_FLASH_SIZE_ACTUAL	0x02000000
#define PPMC280_BOOT_FLASH_SIZE_ACTUAL	0x00800000  /* =< 8M of Boot FLASH */
#endif
#define	PPMC280_INTERNAL_SRAM_SIZE	0x00040000

#define	PPMC280_EXT_FLASH_SIZE		max(MV64360_WINDOW_SIZE_MIN,	\
						PPMC280_EXT_FLASH_SIZE_ACTUAL)
#define	PPMC280_BOOT_FLASH_SIZE		max(MV64360_WINDOW_SIZE_MIN, \
						PPMC280_BOOT_FLASH_SIZE_ACTUAL)
#define	PPMC280_EXT_SRAM_SIZE		max(MV64360_WINDOW_SIZE_MIN,	\
						PPMC280_EXT_SRAM_SIZE_ACTUAL)

/* Board-specific IRQ info */
#define PPMC280_PCI_0_IRQ_A             64+27
#define PPMC280_PCI_0_IRQ_B             64+29
#define PPMC280_PCI_0_IRQ_C             64+16
#define PPMC280_PCI_0_IRQ_D             64+17


/* Serial port setup */
#define	PPMC280_DEFAULT_BAUD		9600

#if defined(CONFIG_SERIAL_MPSC_CONSOLE)
#define	PPMC280_MPSC_CLK_SRC		8		/* TCLK */
#define	PPMC280_MPSC_CLK_FREQ		133000000
#endif
#endif /* __PPC_PLATFORMS_PPMC280 */

/*
 * arch/ppc/platforms/ppmc280.c
 *
 * Board setup routines for the Motorola PPMC280 Development Board.
 *
 * Author: <source@mvista.com>
 * Based on ppmc280.c Written by Rabeeh Khoury - rabeeh@galileo.co.il
 * Based on code done by - Mark A. Greer <mgreer@mvista.com>
 *
 * 2001-2003 (c) MontaVista, Software, Inc.  This file is licensed under
 * the terms of the GNU General Public License version 2.  This program
 * is licensed "as is" without any warranty of any kind, whether express
 * or implied.
 */

#include <linux/config.h>
#include <linux/delay.h>
#include <linux/pci.h>
#include <linux/ide.h>
#include <linux/irq.h>
#include <linux/fs.h>
#include <linux/seq_file.h>
#include <linux/console.h>
#include <linux/initrd.h>
#include <linux/root_dev.h>
#include <linux/mv643xx.h>
#include <asm/bootinfo.h>
#include <asm/machdep.h>
#include <asm/mv64x60.h>
#include <asm/time.h>
#include <platforms/ppmc280.h>

#define BOARD_VENDOR	"Motorola"
#define BOARD_MACHINE	"PPMC280"

static struct mv64x60_handle bh;

static const unsigned int cpu_7447[32] = {
	23, 34, 15, 30, 14, 36, 1, 40, 4, 42, 13, 26, 17, 48, 19, 18,
	 6, 21, 11, 22, 8, 20, 10, 24, 16, 28, 12, 32, 27, 56, 0, 25
};

static int ppmc280_get_bus_speed(void)
{
	return 133333333;
}
static int ppmc280_get_cpu_speed(void)
{
	unsigned long hid1;

	hid1 = (mfspr(SPRN_HID1) & 0x0001f000) >> 12;
	return ppmc280_get_bus_speed() * cpu_7447[hid1] / 2;
}

unsigned long __init ppmc280_find_end_of_memory(void)
{
	return mv64x60_get_mem_size(CONFIG_MV64X60_NEW_BASE,
			MV64x60_TYPE_MV64360);
}

/*
 * Motorola PPMC280 Board PCI interrupt routing.
 */
static int __init
ppmc280_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
{
	static char pci_irq_table[][4] = {
		/*
		 *      PCI IDSEL/INTPIN->INTLINE
		 *         A   B   C   D
		 */
		/* IDSEL 10 - PCI bus 0 */
		{ PPMC280_PCI_0_IRQ_C, PPMC280_PCI_0_IRQ_D,
		  PPMC280_PCI_0_IRQ_A, PPMC280_PCI_0_IRQ_B },
		/* IDSEL 11 - PCI bus 0 */
		{ PPMC280_PCI_0_IRQ_A, PPMC280_PCI_0_IRQ_B,
		  PPMC280_PCI_0_IRQ_C, PPMC280_PCI_0_IRQ_D },
		/* IDSEL 12 - PCI bus 0 */
		{ PPMC280_PCI_0_IRQ_A, PPMC280_PCI_0_IRQ_B,
		  PPMC280_PCI_0_IRQ_C, PPMC280_PCI_0_IRQ_D },
		/* IDSEL 13 - PCI bus 0 */
		{ PPMC280_PCI_0_IRQ_B, PPMC280_PCI_0_IRQ_C,
		  PPMC280_PCI_0_IRQ_D, PPMC280_PCI_0_IRQ_A },
	};
	const long min_idsel = 10, max_idsel = 13, irqs_per_slot = 4;
	return PCI_IRQ_TABLE_LOOKUP;
}

static void __init
ppmc280_setup_peripherals(void)
{

	u32 temp;

	mv64x60_set_32bit_window(&bh, MV64x60_CPU2BOOT_WIN,
		PPMC280_BOOT_FLASH_BASE, PPMC280_BOOT_FLASH_SIZE, 0);
	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2BOOT_WIN);

	mv64x60_set_32bit_window(&bh, MV64x60_CPU2SRAM_WIN,
		PPMC280_INTERNAL_SRAM_BASE, PPMC280_INTERNAL_SRAM_SIZE, 0);
	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2SRAM_WIN);

	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_0_WIN,
		PPMC280_EXT_FLASH_BASE_1, PPMC280_EXT_FLASH_SIZE, 0);
	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_0_WIN);

	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_1_WIN,
		PPMC280_EXT_FLASH_BASE_2, PPMC280_EXT_FLASH_SIZE, 0);
	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_1_WIN);

	mv64x60_clr_bits(&bh, MV64x60_CPU_CONFIG,
		((1 << 12) | (1 << 28) | (1 << 29)));
	mv64x60_set_bits(&bh, MV64x60_CPU_CONFIG, (1 << 27));

	if (ppmc280_get_bus_speed() > 100000000)
		mv64x60_set_bits(&bh, MV64x60_CPU_CONFIG, (1 << 23));

	mv64x60_set_bits(&bh, MV64x60_CPU_MASTER_CNTL, (1 << 9)); /* 1 cpu */

	/* Program WatchDog o/p MPP19:WDE# i.e. 0x4, MPP24:WDNMI# i.e. 0x4 */
	temp = mv64x60_read(&bh, MV64x60_MPP_CNTL_2);
	temp &= 0xFFFF0FFF;
	temp |= 0x00004000;
	mv64x60_write(&bh, MV64x60_MPP_CNTL_2, temp);

	temp = mv64x60_read(&bh, MV64x60_MPP_CNTL_3);
	temp &= 0xFFFFFFF0;
	temp |= 0x00000004;
	mv64x60_write(&bh, MV64x60_MPP_CNTL_3, temp);

	/* Make sure WatchDog is disabled */
	temp = mv64x60_read(&bh, MV64x60_WDT_WDC);
	if (temp & 0x80000000) {	/* Is the WD enabled ? */
		temp &= ~0x3000000;
		temp |= 0x1000000;
		mv64x60_write(&bh, MV64x60_WDT_WDC, temp);
		temp &= ~0x3000000;
		temp |= 0x2000000;
		mv64x60_write(&bh, MV64x60_WDT_WDC, temp);
	}

	/*
	 * Turn off timer/counters.  Not turning off watchdog timer because
	 * can't read its reg on the 64260A so don't know if we'll be enabling
	 * or disabling.
	 */
	mv64x60_clr_bits(&bh, MV64x60_TIMR_CNTR_0_3_CNTL,
		((1 << 0) | (1 << 8) | (1 << 16) | (1 << 24)));

	mv64x60_set_bits(&bh, MV64x60_GPP_LEVEL_CNTL, 0xfb50);
	mv64x60_set_bits(&bh, MV64x60_GPP_IO_CNTL, 0xfb50);

#if defined(CONFIG_NOT_COHERENT_CACHE)
	mv64x60_write(&bh, MV64360_SRAM_CONFIG, 0x00160000);
#else
	mv64x60_write(&bh, MV64360_SRAM_CONFIG, 0x001600b2);
#endif
	return;
}

static void __init
ppmc280_setup_bridge(void)
{
	struct mv64x60_setup_info si;
	int i;

	memset(&si, 0, sizeof(si));

	si.phys_reg_base = CONFIG_MV64X60_NEW_BASE;

	si.pci_0.enable_bus = 1;
	si.pci_0.pci_io.cpu_base = PPMC280_PCI0_IO_CPU_BASE;
	si.pci_0.pci_io.pci_base_hi = 0;
	si.pci_0.pci_io.pci_base_lo = PPMC280_PCI0_IO_PCI_BASE;
	si.pci_0.pci_io.size = PPMC280_PCI0_IO_SIZE;
	si.pci_0.pci_io.swap = MV64x60_CPU2PCI_SWAP_NONE;
	si.pci_0.pci_mem[0].cpu_base = PPMC280_PCI0_MEM_CPU_BASE;
	si.pci_0.pci_mem[0].pci_base_hi = 0;
	si.pci_0.pci_mem[0].pci_base_lo = PPMC280_PCI0_MEM_PCI_BASE;
	si.pci_0.pci_mem[0].size = PPMC280_PCI0_MEM_SIZE;
	si.pci_0.pci_mem[0].swap = MV64x60_CPU2PCI_SWAP_NONE;
	si.pci_0.pci_cmd_bits = 0;
	si.pci_0.latency_timer = 0x8;

	for (i = 0; i < MV64x60_CPU2MEM_WINDOWS; i++) {
#if defined(CONFIG_NOT_COHERENT_CACHE)
		si.cpu_prot_options[i] = 0;
		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_NONE;
		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE;
		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE;

		si.pci_0.acc_cntl_options[i] =
			MV64360_PCI_ACC_CNTL_SNOOP_NONE |
			MV64360_PCI_ACC_CNTL_SWAP_NONE |
			MV64360_PCI_ACC_CNTL_MBURST_128_BYTES |
			MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
#else
		si.cpu_prot_options[i] = 0;
		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_WB;
		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_WB;
		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_WB;

		si.pci_0.acc_cntl_options[i] =
			MV64360_PCI_ACC_CNTL_SNOOP_WB |
			MV64360_PCI_ACC_CNTL_SWAP_NONE |
			MV64360_PCI_ACC_CNTL_MBURST_32_BYTES |
			MV64360_PCI_ACC_CNTL_RDSIZE_32_BYTES;
#endif
	}

	if (ppc_md.progress)
		ppc_md.progress("ppmc280_setup_bridge: mv64x60_init", 0);

	/* Lookup PCI host bridges */
	if (mv64x60_init(&bh, &si))
		printk(KERN_ERR "Bridge initialization failed.\n");

	pci_dram_offset = 0;	/* System mem at same addr on PCI & cpu bus */
	ppc_md.pci_swizzle = common_swizzle;
	ppc_md.pci_map_irq = ppmc280_map_irq;
	ppc_md.pci_exclude_device = mv64x60_pci_exclude_device;

	mv64x60_set_bus(&bh, 0, 0);
	bh.hose_a->first_busno = 0;
	bh.hose_a->last_busno = 0xff;
	bh.hose_a->last_busno = pciauto_bus_scan(bh.hose_a, 0);

	if (ppc_md.progress)
		ppc_md.progress("ppmc280_setup_bridge: return", 0);
	return;
}

static void __init
ppmc280_setup_arch(void)
{
	if (ppc_md.progress)
		ppc_md.progress("ppmc280_setup_arch: enter", 0);

#ifdef CONFIG_BLK_DEV_INITRD
	if (initrd_start)
		ROOT_DEV = Root_RAM0;
	else
#endif
#ifdef	CONFIG_ROOT_NFS
		ROOT_DEV = Root_NFS;
#else
		ROOT_DEV = Root_SDA2;
#endif

	if (ppc_md.progress)
		ppc_md.progress("ppmc280_setup_arch: Enabling L2 cache", 0);

	/* Enable L2 cache but not L3 cache (if 744x/745x) */
	_set_L2CR(_get_L2CR() | L2CR_L2E);

	if (ppc_md.progress)
		ppc_md.progress("ppmc280_setup_arch: Initializing bridge", 0);

	ppmc280_setup_bridge();	/* set up PCI bridge(s) */
	ppmc280_setup_peripherals();	/* set up chip selects/GPP/MPP etc */

	if (ppc_md.progress)
		ppc_md.progress("ppmc280_setup_arch: bridge init complete", 0);

	printk(KERN_INFO "%s %s port (C) 2001 MontaVista Software, Inc."
		"(source@mvista.com)\n", BOARD_VENDOR, BOARD_MACHINE);

	if (ppc_md.progress)
		ppc_md.progress("ppmc280_setup_arch: exit", 0);

	return;
}

/* Platform device data fixup routines. */
#if defined(CONFIG_SERIAL_MPSC)
static void __init
ppmc280_fixup_mpsc_pdata(struct platform_device *pdev)
{
	struct mpsc_pdata *pdata;
	pdata = (struct mpsc_pdata *)pdev->dev.platform_data;

	pdata->max_idle = 40;
	pdata->default_baud = PPMC280_DEFAULT_BAUD;
	pdata->brg_clk_src = PPMC280_MPSC_CLK_SRC;
	pdata->brg_clk_freq = PPMC280_MPSC_CLK_FREQ;

	return;
}
static int
ppmc280_platform_notify(struct device *dev)
{
	static struct {
		char *bus_id;
		void ((*rtn) (struct platform_device * pdev));
	} dev_map[] = {
		{ MPSC_CTLR_NAME ".0", ppmc280_fixup_mpsc_pdata },
		{ MPSC_CTLR_NAME ".1", ppmc280_fixup_mpsc_pdata },
	};
	struct platform_device *pdev;
	int i;

	if (dev && dev->bus_id)
		for (i = 0; i < ARRAY_SIZE(dev_map); i++)
			if (!strncmp(dev->bus_id, dev_map[i].bus_id,
								BUS_ID_SIZE)) {
				pdev = container_of(dev, struct platform_device,
							dev);
				dev_map[i].rtn(pdev);
			}
	return 0;
}
#endif

static void
ppmc280_reset_board(void *addr)
{
	u32 temp;

	local_irq_disable();

	temp = mv64x60_read(&bh, MV64x60_MPP_CNTL_0);
	temp &= 0xFFFF0FFF;
	mv64x60_write(&bh, MV64x60_MPP_CNTL_0, temp);

	mv64x60_set_bits(&bh, MV64x60_GPP_LEVEL_CNTL, 0x0004);
	mv64x60_set_bits(&bh, MV64x60_GPP_IO_CNTL, 0x0004);

	temp = mv64x60_read(&bh, MV64x60_MPP_CNTL_2);
	temp &= 0xFFFF0FFF;
	mv64x60_write(&bh, MV64x60_MPP_CNTL_2, temp);

	mv64x60_set_bits(&bh, MV64x60_GPP_LEVEL_CNTL, 0x80000);
	mv64x60_set_bits(&bh, MV64x60_GPP_IO_CNTL, 0x80000);

	mv64x60_write(&bh, MV64x60_GPP_VALUE_SET, 0x80004);
	return;
}

static void
ppmc280_restart(char *cmd)
{
	volatile ulong i = 10000000;

	ppmc280_reset_board((void *)0xfff00100);

	while (i-- > 0);
	panic("restart failed\n");
}

static void
ppmc280_halt(void)
{
	local_irq_disable();
	while (1);
	/* NOTREACHED */
}

static void
ppmc280_power_off(void)
{
	ppmc280_halt();
	/* NOTREACHED */
}

static int
ppmc280_show_cpuinfo(struct seq_file *m)
{
	char *s;

	seq_printf(m, "cpu freq\t: %dMHz\n",
		(ppmc280_get_cpu_speed() + 500000) / 1000000);
	seq_printf(m, "bus freq\t: %dMHz\n",
		(ppmc280_get_bus_speed() + 500000) / 1000000);
	seq_printf(m, "vendor\t\t: " BOARD_VENDOR "\n");
	seq_printf(m, "machine\t\t: " BOARD_MACHINE "\n");

	switch (bh.type) {
	case MV64x60_TYPE_GT64260A:
		s = "gt64260a";
		break;
	case MV64x60_TYPE_GT64260B:
		s = "gt64260b";
		break;
	case MV64x60_TYPE_MV64360:
		s = "mv64360";
		break;
	case MV64x60_TYPE_MV64460:
		s = "mv64460";
		break;
	default:
		s = "Unknown";
	}
	seq_printf(m, "bridge type\t: %s\n", s);
	seq_printf(m, "bridge rev\t: 0x%x\n", bh.rev);
#if defined(CONFIG_NOT_COHERENT_CACHE)
	seq_printf(m, "coherency\t: %s\n", "off");
#else
	seq_printf(m, "coherency\t: %s\n", "on");
#endif

	return 0;
}

static void __init
ppmc280_calibrate_decr(void)
{
	ulong freq;

	freq = ppmc280_get_bus_speed() / 4;

	printk(KERN_INFO "time_init: decrementer frequency = %lu.%.6lu MHz\n",
		freq / 1000000, freq % 1000000);

	tb_ticks_per_jiffy = freq / HZ;
	tb_to_us = mulhwu_scale_factor(freq, 1000000);

	return;
}

#if defined(CONFIG_I2C_MV64XXX) && defined(CONFIG_SENSORS_MAX6900)
extern ulong max6900_get_rtc_time(void);
extern int max6900_set_rtc_time(ulong);

static int __init
ppmc280_rtc_hookup(void)
{
	struct timespec tv;

	if (ppc_md.progress)
		ppc_md.progress("ppmc280_rtc_hookup: ", 0);

	ppc_md.get_rtc_time = max6900_get_rtc_time;
	ppc_md.set_rtc_time = max6900_set_rtc_time;

	tv.tv_nsec = 0;
	if (ppc_md.progress)
		ppc_md.progress("ppmc280_rtc_hookup: call ppc_md.get_rtc_time",
				0);
	tv.tv_sec = (ppc_md.get_rtc_time)();
	do_settimeofday(&tv);

	return 0;
}

late_initcall(ppmc280_rtc_hookup);
#endif

/*
 * Set BAT 3 to map 0xf1000000 to end of physical memory space.
 */
static __inline__ void
ppmc280_set_bat(void)
{
	mb();
	mtspr(SPRN_DBAT1U, 0xf0001ffe);
	mtspr(SPRN_DBAT1L, 0xf000002a);
	mb();

	return;
}

#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
static void __init
ppmc280_map_io(void)
{
	io_block_mapping(0xf1000000, 0xf1000000, 0x00100000, _PAGE_IO);
	io_block_mapping(0xff800000, 0xff800000, 0x00800000, _PAGE_IO);
}
#endif

void __init
platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
	unsigned long r6, unsigned long r7)
{
#ifdef CONFIG_BLK_DEV_INITRD
	extern int initrd_below_start_ok;

	initrd_start = initrd_end = 0;
	initrd_below_start_ok = 0;
#endif				/* CONFIG_BLK_DEV_INITRD */

	parse_bootinfo(find_bootinfo());

	isa_mem_base = 0;
	isa_io_base = PPMC280_PCI0_IO_CPU_BASE;
	pci_dram_offset = PPMC280_PCI0_MEM_CPU_BASE;

	loops_per_jiffy = ppmc280_get_cpu_speed() / HZ;

	ppc_md.setup_arch = ppmc280_setup_arch;
	ppc_md.show_cpuinfo = ppmc280_show_cpuinfo;
	ppc_md.init_IRQ = mv64360_init_irq;
	ppc_md.get_irq = mv64360_get_irq;
	ppc_md.restart = ppmc280_restart;
	ppc_md.power_off = ppmc280_power_off;
	ppc_md.halt = ppmc280_halt;
	ppc_md.find_end_of_memory = ppmc280_find_end_of_memory;
	ppc_md.init = NULL;
	ppc_md.calibrate_decr = ppmc280_calibrate_decr;

	bh.p_base = CONFIG_MV64X60_NEW_BASE;

	ppmc280_set_bat();

#ifdef	CONFIG_SERIAL_TEXT_DEBUG
	ppc_md.setup_io_mappings = ppmc280_map_io;
	ppc_md.progress = mv64x60_mpsc_progress;
	mv64x60_progress_init(CONFIG_MV64X60_NEW_BASE);
#endif				/* CONFIG_SERIAL_TEXT_DEBUG */
#ifdef	CONFIG_KGDB
	ppc_md.setup_io_mappings = ppmc280_map_io;
#endif				/* CONFIG_KGDB */

#if defined(CONFIG_SERIAL_MPSC)
	platform_notify = ppmc280_platform_notify;
#endif

	return;
}
