Message-ID: <20011105100048.12491.qmail@dag.newtech.fi>
To: linuxppc-embedded@lists.linuxppc.org
Cc: dag@newtech.fi
Subject: OpenPIC interface rewrite
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-14643952120"
Date: Mon, 05 Nov 2001 12:00:48 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multipart MIME message.

--==_Exmh_-14643952120
Content-Type: text/plain; charset=us-ascii


OK,

here we go.
This is tested on my EPCI based board and I have attached the
setup file for that one as an example.
I have NOT touched the other ports AND the interface
is bacwards incompatible, so I hope all of you porting
people can do that yourself, shouldn't be too difficult.

All the chrp specials can now be implemented through the
new interface wo. any special stuff. Just make a one-line
function accessing the "special" ACK-address and point the
cascade entry to that, And the programming switch priority
can be set higher directly in the definition table.

In hope of good comments and thorough testing...
Special attention should be put at the stuff I could not
test here ie.
IPI-stuff and timers

BRGDS

Dag Nygren



--==_Exmh_-14643952120
Content-Type: text/plain ; name="vg4_setup.c"; charset=us-ascii
Content-Description: vg4_setup.c
Content-Disposition: attachment; filename="vg4_setup.c"

/*
 * arch/ppc/kernel/vg4_setup.c
 *
 * Board setup routines for SBS VG4
 *
 * Based on the K2 setup by:
 * Author: Matt Porter
 *         mporter@mvista.com
 *
 * Heavily modified for VG4:
 *					Dag Nygren
 *					Oy Espoon Newtech Ab
 *					dag@newtech.fi
 *
 * Copyright 2000 MontaVista Software Inc.
 * VG4 modifications: Copyright 2001 Oy Espoon Newtech Ab
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 *
 * THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR   IMPLIED
 * WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
 * NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,  INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
 * USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * You should have received a copy of the  GNU General Public License along
 * with this program; if not, write  to the Free Software Foundation, Inc.,
 * 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include <linux/config.h>
#include <linux/stddef.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/errno.h>
#include <linux/reboot.h>
#include <linux/pci.h>
#include <linux/kdev_t.h>
#include <linux/types.h>
#include <linux/major.h>
#include <linux/blk.h>
#include <linux/console.h>
#include <linux/delay.h>

#include <asm/system.h>
#include <asm/pgtable.h>
#include <asm/page.h>
#include <asm/dma.h>
#include <asm/io.h>
#include <asm/machdep.h>
#include <asm/processor.h>

#include <asm/time.h>
#include "vg4.h"
#include "i8259.h"
#include "open_pic.h"
#include "mpc10x.h"
#include "todc.h"

extern void vg4_find_bridges(void);

static void
inline vg4_cardfail_led(int state) {
	outb(VG4_LOCKR_UNLOCK, VG4_LOCKR);
	outb(state, VG4_FAIL_LED);
	outb(VG4_LOCKR_LOCK, VG4_LOCKR);
}

void
vg4_user_led(int state) { outb(state, VG4_USER_LED); }

static int
vg4_get_bus_speed(void)
{
	int bus_speed;

/* Is there a nice way to figure out this ? */
	bus_speed = 100000000;
	return bus_speed;
}

static int
vg4_get_cpu_speed(void)
{
	unsigned long hid1;
	int cpu_speed;
	unsigned int cpu_7xx[16] = {
		0, 15, 14, 0, 0, 13, 5, 9, 6, 11, 8, 10, 16, 12, 7, 0
	};
	unsigned int cpu_6xx[16] = {
		0, 0, 14, 0, 0, 13, 5, 9, 6, 11, 8, 10, 0, 12, 7, 0
	};

	hid1 = mfspr(HID1) >> 28;

	if ( (mfspr(PVR)>>16) == 8)
		hid1 = cpu_7xx[hid1];
	else
		hid1 = cpu_6xx[hid1];

	cpu_speed = vg4_get_bus_speed()*hid1/2;
	return cpu_speed;
}

static char *
vg4_get_l2_size(void)
{
/* Is there a nice way to figure out this ? */
	return ("1MB");
}

static int
vg4_get_cpuinfo(char *buffer)
{
	int len;

	len =  sprintf( buffer,     "vendor\t\t: SBS\n");
	len += sprintf( buffer+len, "machine\t\t: VG4\n");
	len += sprintf( buffer+len, "cpu speed\t: %dMhz\n",
		vg4_get_cpu_speed()/1000000);
	len += sprintf( buffer+len, "bus speed\t: %dMhz\n",
		vg4_get_bus_speed()/1000000);
	len += sprintf( buffer+len, "L2\t\t: %s\n", vg4_get_l2_size());
	len += sprintf( buffer+len, "memory type\t: SDRAM\n");
	len += sprintf( buffer+len, "\n");

	return len;
}

static void __init
		vg4_setup_arch(void)
{
	unsigned int cpu;
	extern char cmd_line[];

	/* init to some ~sane value until calibrate_delay() runs */
    loops_per_jiffy = 50000000/HZ;

	/* Lookup PCI host bridges */
	vg4_find_bridges();

#ifdef CONFIG_ROOT_NFS
	/* bootable from nfsroot */
	ROOT_DEV = to_kdev_t(0x00FF);	/* /dev/nfs pseudo device */
#else
	/* bootable from SCSI second partition */
	ROOT_DEV = to_kdev_t(0x0802);	/* /dev/sda2 */
#endif

	printk("Boot arguments: %s\n", cmd_line);

	/* Identify the system */
	printk("System Identification: SBS VG4 - PowerPC 750 @ %d Mhz\n", vg4_get_cpu_speed()/1000000);

	/* Identify the CPU manufacturer */
	cpu =  mfspr(PVR);
	printk("CPU manufacturer: %s [rev=%04x]\n", (cpu & (1<<15)) ? "IBM" :
	       "Motorola", (cpu & 0xffff));
}

static void
vg4_restart(char *cmd)
{
	__cli();
	vg4_cardfail_led(VG4_FLED_ON);
	/* SRR0 has system reset vector, SRR1 has default MSR value */
	/* rfi restores MSR from SRR1 and sets the PC to the SRR0 value */
	__asm__ __volatile__
	("\n\
	lis	3,0xfff0
	ori	3,3,0x0100
	mtspr	26,3
	li	3,0
	mtspr	27,3
	rfi
	");
	for(;;);
}

static void
vg4_power_off(void)
{
	for(;;);
}

static void
vg4_halt(void)
{
	__cli();
	while (1);
}

	/* Using MPC107(EPIC) means that the LinuxVector numbers start from 16
	 * as 0-15 is reserved for the possible cascade
	 * Remember that the LinuxVector of the first entry is used as an offset
	 * for the Timer and IPI vectors */

static openpic_irq_def vg4_openpic_irq_defs[] __initdata = {
	/* PICirq, LinuxVector, Priority, Level/Edge, Polarity, CascadeAck */
	{  16, 16, 8, OP_IRQ_LEVEL, OP_IRQ_POS, i8259_irq} , 	/* 8259 cascade */
	{  17, 17, 8, OP_IRQ_LEVEL, OP_IRQ_NEG, NULL      } , 	/* INT_PCI_INTA */
	{  18, 18, 8, OP_IRQ_LEVEL, OP_IRQ_NEG, NULL      } , 	/* INT_PCI_INTB */
	{  19, 19, 8, OP_IRQ_LEVEL, OP_IRQ_NEG, NULL      } , 	/* INT_PCI_INTC */
	{  20, 20, 8, OP_IRQ_LEVEL, OP_IRQ_NEG, NULL      } ,	/* INT_PCI_INTD */
	{ -1, -1, 8, OP_IRQ_LEVEL, OP_IRQ_NEG, NULL      }  	/* End of table marker */
};

ALLOC_OPENPIC_DEF(vg4_openpic_def);

static void __init
vg4_init_IRQ(void)
{
    int vec;

	vg4_openpic_def.IRQdef    = vg4_openpic_irq_defs;

    /* The int:s behind the OpenPIC in MPC107 */

    openpic_init(&vg4_openpic_def);

    /* These are the ints (0-15) behind the 8259 in the ALI chip */
    for ( vec = 0 ; vec < NUM_8259_INTERRUPTS  ; vec++ )
        irq_desc[vec].handler = &i8259_pic;

    i8259_init();
}


static void __init
vg4_init2(void)
{
	request_region(0x20,0x20,"pic1");
	request_region(0xa0,0x20,"pic2");
	request_region(0x00,0x20,"dma1");
	request_region(0x40,0x20,"timer");
	request_region(0x80,0x10,"dma page reg");
	request_region(0xc0,0x20,"dma2");
	request_region(0x160,0x10,"VG4 ext reg set");
	request_region(VG4_USER_LED,0x01,"User LED");
	vg4_user_led(VG4_ULED_BLINK_FAST);	/* Test only */
}

/*
 * Set BAT 3 to map 0xF0000000.
 */
#if 0
static __inline__ void
vg4_set_bat(void)
{
        unsigned long   bat3u, bat3l;
        static int      mapping_set = 0;

        if (!mapping_set)
        {

                /* wait for all outstanding memory accesses to complete */
                mb();

                /* setup DBATs */
                mtspr(DBAT3U, 0xf0001ffe);
                mtspr(DBAT3L, 0xf000002a);

                /* wait for updates */
                mb();

                mapping_set = 1;
        }
        return;
}
#else
static __inline__ void
vg4_set_bat(void)
{
        unsigned long bat3u, bat3l;
        static int mapping_set = 0;

        if (!mapping_set) {

                __asm__ __volatile__(
                " lis %0,0xf000\n \
                  ori %1,%0,0x002a\n \
                  ori %0,%0,0x1ffe\n \
                  mtspr 0x21e,%0\n \
                  mtspr 0x21f,%1\n \
                  isync\n \
                  sync "
                : "=r" (bat3u), "=r" (bat3l));

                mapping_set = 1;
        }

        return;
}
#endif

static unsigned long __init
vg4_find_end_of_memory(void)
{
	return (0x4000000);
	vg4_set_bat();
printk("Probed memsize = 0x%lx\n", mpc10x_get_mem_size(MPC10X_MEM_MAP_A));
	/* Cover I/O space with a BAT */
	/* yuck, better hope your ram size is a power of 2  -- paulus */
	vg4_set_bat();
	return mpc10x_get_mem_size(MPC10X_MEM_MAP_A);
}

static void __init
vg4_map_io(void)
{
	io_block_mapping(VG4_PCI_IO_BASE, VG4_PCI_PHY_IO_BASE, 0x10000000, _PAGE_IO);
	io_block_mapping(VG4_PCI_MEM_BASE, VG4_PCI_PHY_MEM_BASE, 0x10000000, _PAGE_IO);
	ioremap_base = VG4_PCI_MEM_BASE;
}

TODC_ALLOC();

void __init
			platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
			unsigned long r6, unsigned long r7)
{
	isa_io_base = MPC10X_MAPA_ISA_IO_BASE;
	isa_mem_base = MPC10X_MAPA_ISA_MEM_BASE;
 	pci_dram_offset = MPC10X_MAPA_DRAM_OFFSET;

#if 0
	ISA_DMA_THRESHOLD = 0x00ffffff;
	DMA_MODE_READ = 0x44;
	DMA_MODE_WRITE = 0x48;
#endif

#ifdef CONFIG_BLK_DEV_INITRD
	if ( r4 )
	{
		initrd_start = r4 + KERNELBASE;
		initrd_end = r5 + KERNELBASE;
	}
#endif

	/* take care of cmd line */
	if ( r6  && (((char *) r6) != '\0'))
	{
		*(char *)(r7+KERNELBASE) = 0;
		strcpy(cmd_line, (char *)(r6+KERNELBASE));
	}

#if 0
	/* Set up a default rootdevice (Temporary mod) */
	if (!strstr(cmd_line, "root="))
		strcat(cmd_line, " root=/dev/sda3");
#endif

	ppc_md.setup_arch = vg4_setup_arch;
	ppc_md.get_cpuinfo = vg4_get_cpuinfo;

	ppc_md.init_IRQ = vg4_init_IRQ;
	ppc_md.get_irq = openpic_get_irq;
	ppc_md.init = vg4_init2;

	ppc_md.find_end_of_memory = vg4_find_end_of_memory;
	ppc_md.setup_io_mappings = vg4_map_io;

	ppc_md.restart = vg4_restart;
	ppc_md.power_off = vg4_power_off;
	ppc_md.halt = vg4_halt;

	/* VG4 has an MC146818 RTC */
	TODC_INIT(TODC_TYPE_MC146818,
		VG4_NVRAM_RTC_ADDR,0,
		VG4_NVRAM_RTC_DATA,8);

	ppc_md.time_init = todc_time_init;
	ppc_md.set_rtc_time = todc_set_rtc_time;
	ppc_md.get_rtc_time = todc_get_rtc_time;
	ppc_md.nvram_read_val = todc_mc146818_read_val;
	ppc_md.nvram_write_val = todc_mc146818_write_val;
	ppc_md.calibrate_decr = todc_calibrate_decr;
}

--==_Exmh_-14643952120
Content-Type: text/plain ; name="open_pic.h"; charset=us-ascii
Content-Description: open_pic.h
Content-Disposition: attachment; filename="open_pic.h"

/*
 * BK Id: SCCS/s.open_pic.h 1.22 10/11/01 13:10:14 trini
 */
/*
 *  arch/ppc/kernel/open_pic.h -- OpenPIC Interrupt Handling
 *
 *  Copyright (C) 1997 Geert Uytterhoeven
 *
 *  This file is subject to the terms and conditions of the GNU General Public
 *  License.  See the file COPYING in the main directory of this archive
 *  for more details.
 *
 */

#ifndef _PPC_KERNEL_OPEN_PIC_H
#define _PPC_KERNEL_OPEN_PIC_H

#include <linux/config.h>

#define OPENPIC_SIZE	0x40000

/*
 *  Non-offset'ed vector numbers
 */

#define OPENPIC_VEC_TIMER	64	/* and up */
#define OPENPIC_VEC_IPI		72	/* and up */
#define OPENPIC_VEC_SPURIOUS	127

/* OpenPIC IRQ controller structure */
extern struct hw_interrupt_type open_pic;

/* OpenPIC IPI controller structure */
#ifdef CONFIG_SMP
extern struct hw_interrupt_type open_pic_ipi;
#endif /* CONFIG_SMP */

extern void* OpenPIC_Addr;
#if 0
extern u_int OpenPIC_NumInitSenses;
extern u_char *OpenPIC_InitSenses;
/* The following mainly for the MPC107, which has a "builtin" offset for the Source registers
	Setting this to 16 will make all the routines work for a MPC107
*/
extern u_int OpenPIC_RegOffset;
#endif


extern inline int openpic_to_irq(int irq)
{
	/* IRQ 0 usually means 'disabled'.. don't mess with it
	 * exceptions to this (sandpoint maybe?)
	 * shouldn't use openpic_to_irq
	 */
	if (irq != 0){
		return irq += NUM_8259_INTERRUPTS;
	} else {
		return 0;
	}
}
/*extern int open_pic_irq_offset;*/

typedef enum irq_polarity_en {
	OP_IRQ_POS = 1,
	OP_IRQ_NEG = 0
} irq_polarity_type;

typedef enum irq_sense_en {
	OP_IRQ_LEVEL = 1,
	OP_IRQ_EDGE  = 0
} irq_sense_type;

typedef struct openpic_irq_def_str {
	int					PICIrq;		/* Must be int (not u_int) to mark end of table */
	u_int				Vector;
	u_char				Priority;
	irq_sense_type		IrqSense;
	irq_polarity_type	IrqPolarity;
	/* This can be used for cascade, but should work well for the chrp specials too */
	int					(*CascadeAckHandler)(int);
} openpic_irq_def;

typedef struct openpic_def_str {
	volatile struct OpenPIC	*OpenPIC_Addr;
	int				slave_pic;
	openpic_irq_def	*IRQdef;	/* The lovest vector first in the table !!! */
} openpic_def;

#define ALLOC_OPENPIC_DEF(name) static openpic_def name __initdata = {NULL, 0, NULL}

/* Exported functions */
extern void openpic_oldinit(int, int, unsigned char *, int);
extern void openpic_init(openpic_def *);
extern u_int openpic_irq(void);
extern void openpic_eoi(void);
extern void openpic_request_IPIs(void);
extern void do_openpic_setup_cpu(void);
extern int openpic_get_irq(struct pt_regs *regs);
extern void openpic_reset_processor_phys(u_int cpumask);
extern void openpic_setup_ISU(int isu_num, unsigned long addr);
extern void openpic_cause_IPI(u_int ipi, u_int cpumask);
extern void smp_openpic_message_pass(int target, int msg, unsigned long data,
				     int wait);

#endif /* _PPC_KERNEL_OPEN_PIC_H */

--==_Exmh_-14643952120
Content-Type: text/plain ; name="open_pic.c"; charset=us-ascii
Content-Description: open_pic.c
Content-Disposition: attachment; filename="open_pic.c"

/*
 * BK Id: SCCS/s.open_pic.c 1.40 10/11/01 13:10:14 trini
 */
/*
 *  arch/ppc/kernel/open_pic.c -- OpenPIC Interrupt Handling
 *
 *  Copyright (C) 1997 Geert Uytterhoeven
 *
 *  Modified by Dag Nygren (dag@newtech.fi) 2001 for new init_pic() interface
 *
 *  This file is subject to the terms and conditions of the GNU General Public
 *  License.  See the file COPYING in the main directory of this archive
 *  for more details.
 */

#include <linux/config.h>
#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/init.h>
#include <linux/irq.h>
#include <linux/init.h>
#include <asm/ptrace.h>
#include <asm/signal.h>
#include <asm/io.h>
#include <asm/irq.h>
#include <asm/prom.h>
#include <asm/sections.h>

#include "local_irq.h"
#include "open_pic.h"
#include "open_pic_defs.h"

void* OpenPIC_Addr;
static volatile struct OpenPIC *OpenPIC = NULL;
#if 0
u_int OpenPIC_NumInitSenses __initdata = 0;

u_char *OpenPIC_InitSenses __initdata = NULL;
/* The following mainly for the MPC107, which has a "builtin" offset for the Source registers
	Setting this to 16 will make all the routines work for a MPC107
*/
u_int OpenPIC_RegOffset = 0;
#endif


/* We keep a table of cascaded Ack handlers to be */
/* as efficient as we can in the irq handling */
/* Attn, this is a tradeoff memory/speed */
/* But wo. it, we would have to make a lookup in the irq_def */
/* table on EVERY interrupt !! */
int	(*cascaded[NR_IRQS])(int) = { [0 ... NR_IRQS-1] = NULL};

extern int use_of_interrupt_tree;

void find_ISUs(void);

static u_int NumProcessors;
static u_int NumSources;
#ifdef CONFIG_POWER3
static int NumISUs;
#endif
static int open_pic_irq_offset;

OpenPIC_SourcePtr ISU[OPENPIC_MAX_ISU];

/* Global Operations */
static void openpic_disable_8259_pass_through(void);
static void openpic_set_priority(u_int pri);
static void openpic_set_spurious(u_int vector);
static void openpic_enable_sie(void);
static void openpic_eicr_set_clk(u_int clkval);
static void openpic_eicr_set_clk(u_int clkval);

#ifdef CONFIG_SMP
/* Interprocessor Interrupts */
static void openpic_initipi(u_int ipi, u_int pri, u_int vector);
static void openpic_ipi_action(int cpl, void *dev_id, struct pt_regs *regs);
#endif

/* Timer Interrupts */
static void openpic_inittimer(u_int timer, u_int pri, u_int vector);
static void openpic_maptimer(u_int timer, u_int cpumask);

/* Interrupt Sources */
static void openpic_enable_irq(u_int irq);
static void openpic_disable_irq(u_int irq);
static void openpic_initirq(u_int irq, u_int pri, u_int vector, irq_polarity_type polarity,
			    irq_sense_type is_level);
static void openpic_mapirq(u_int irq, u_int cpumask);

/*
 * These functions are not used but the code is kept here
 * for completeness and future reference.
 */
static void openpic_reset(void);
#ifdef notused
static void openpic_enable_8259_pass_through(void);
static u_int openpic_get_priority(void);
static u_int openpic_get_spurious(void);
static void openpic_set_sense(u_int irq, int sense);
#endif /* notused */

/*
 * Description of the openpic for the higher-level irq code
 */
static void openpic_end_irq(unsigned int irq_nr);
static void openpic_ack_irq(unsigned int irq_nr);
static void openpic_set_affinity(unsigned int irq_nr, unsigned long cpumask);

struct hw_interrupt_type open_pic = {
	" OpenPIC  ",
	NULL,
	NULL,
	openpic_enable_irq,
	openpic_disable_irq,
	openpic_ack_irq,
	openpic_end_irq,
	openpic_set_affinity
};

#ifdef CONFIG_SMP
static void openpic_end_ipi(unsigned int irq_nr);
static void openpic_ack_ipi(unsigned int irq_nr);
static void openpic_enable_ipi(unsigned int irq_nr);
static void openpic_disable_ipi(unsigned int irq_nr);

struct hw_interrupt_type open_pic_ipi = {
	" OpenPIC  ",
	NULL,
	NULL,
	openpic_enable_ipi,
	openpic_disable_ipi,
	openpic_ack_ipi,
	openpic_end_ipi,
	0
};
#endif /* CONFIG_SMP */

/*
 *  Accesses to the current processor's openpic registers
 */
#ifdef CONFIG_SMP
#define THIS_CPU		Processor[cpu]
#define DECL_THIS_CPU		int cpu = smp_hw_index[smp_processor_id()]
#define CHECK_THIS_CPU		check_arg_cpu(cpu)
#else
#define THIS_CPU		Processor[0]
#define DECL_THIS_CPU
#define CHECK_THIS_CPU
#endif /* CONFIG_SMP */

#if 1
#define check_arg_ipi(ipi) \
    if (ipi < 0 || ipi >= OPENPIC_NUM_IPI) \
	printk("open_pic.c:%d: illegal ipi %d\n", __LINE__, ipi);
#define check_arg_timer(timer) \
    if (timer < 0 || timer >= OPENPIC_NUM_TIMERS) \
	printk("open_pic.c:%d: illegal timer %d\n", __LINE__, timer);
#define check_arg_vec(vec) \
    if (vec < 0 || vec >= OPENPIC_NUM_VECTORS) \
	printk("open_pic.c:%d: illegal vector %d\n", __LINE__, vec);
#define check_arg_pri(pri) \
    if (pri < 0 || pri >= OPENPIC_NUM_PRI) \
	printk("open_pic.c:%d: illegal priority %d\n", __LINE__, pri);
/*
 * Print out a backtrace if it's out of range, since if it's larger than NR_IRQ's
 * data has probably been corrupted and we're going to panic or deadlock later
 * anyway --Troy
 */
extern unsigned long* _get_SP(void);
#define check_arg_irq(irq) \
    if (irq < open_pic_irq_offset || irq >= (NumSources+open_pic_irq_offset)){ \
      printk("open_pic.c:%d: illegal irq %d\n", __LINE__, irq); \
      print_backtrace(_get_SP()); }
#define check_arg_cpu(cpu) \
    if (cpu < 0 || cpu >= NumProcessors){ \
	printk("open_pic.c:%d: illegal cpu %d\n", __LINE__, cpu); \
	print_backtrace(_get_SP()); }
#else
#define check_arg_ipi(ipi)	do {} while (0)
#define check_arg_timer(timer)	do {} while (0)
#define check_arg_vec(vec)	do {} while (0)
#define check_arg_pri(pri)	do {} while (0)
#define check_arg_irq(irq)	do {} while (0)
#define check_arg_cpu(cpu)	do {} while (0)
#endif

#ifdef CONFIG_POWER3
	#define GET_ISU(source)	ISU[(source) >> 4][(source) & 0xf]
#else
	#define GET_ISU(source)	ISU[0][(source)]
#endif

u_int openpic_read(volatile u_int *addr)
{
	u_int val;

#ifdef CONFIG_PRPMC800
	val = in_be32(addr);
#else
	val = in_le32(addr);
#endif
	return val;
}

static inline void openpic_write(volatile u_int *addr, u_int val)
{
#ifdef CONFIG_PRPMC800
	out_be32(addr, val);
#else
	out_le32(addr, val);
#endif
}

static inline u_int openpic_readfield(volatile u_int *addr, u_int mask)
{
	u_int val = openpic_read(addr);
	return val & mask;
}

inline void openpic_writefield(volatile u_int *addr, u_int mask,
			       u_int field)
{
	u_int val = openpic_read(addr);
	openpic_write(addr, (val & ~mask) | (field & mask));
}

static inline void openpic_clearfield(volatile u_int *addr, u_int mask)
{
	openpic_writefield(addr, mask, 0);
}

static inline void openpic_setfield(volatile u_int *addr, u_int mask)
{
	openpic_writefield(addr, mask, mask);
}

static void openpic_safe_writefield(volatile u_int *addr, u_int mask,
				    u_int field)
{
	openpic_setfield(addr, OPENPIC_MASK);
	while (openpic_read(addr) & OPENPIC_ACTIVITY);
	openpic_writefield(addr, mask | OPENPIC_MASK, field | OPENPIC_MASK);
}

#ifdef CONFIG_SMP
/* yes this is right ... bug, feature, you decide! -- tgall */
u_int openpic_read_IPI(volatile u_int* addr)
{
         u_int val = 0;
#if defined(CONFIG_POWER3) || defined(CONFIG_PRPMC800)
        val = in_be32(addr);
#else
        val = in_le32(addr);
#endif
        return val;
}

/* because of the power3 be / le above, this is needed */
inline void openpic_writefield_IPI(volatile u_int* addr, u_int mask, u_int field)
{
        u_int  val = openpic_read_IPI(addr);
        openpic_write(addr, (val & ~mask) | (field & mask));
}

static inline void openpic_clearfield_IPI(volatile u_int *addr, u_int mask)
{
        openpic_writefield_IPI(addr, mask, 0);
}

static inline void openpic_setfield_IPI(volatile u_int *addr, u_int mask)
{
        openpic_writefield_IPI(addr, mask, mask);
}

static void openpic_safe_writefield_IPI(volatile u_int *addr, u_int mask, u_int field)
{
        openpic_setfield_IPI(addr, OPENPIC_MASK);

        /* wait until it's not in use */
        /* BenH: Is this code really enough ? I would rather check the result
         *       and eventually retry ...
         */
        while(openpic_read_IPI(addr) & OPENPIC_ACTIVITY);

        openpic_writefield_IPI(addr, mask | OPENPIC_MASK, field | OPENPIC_MASK);
}
#endif /* CONFIG_SMP */

/* Wrapper for the old variant of this call */
#if 0
void __init openpic_oldinit(int main_pic, int offset, unsigned char* chrp_ack,
			 int programmer_switch_irq)
{
}
#endif

void __init openpic_init(openpic_def *def)
{
	u_int t, i;
	u_int timerfreq;
	const char *version;
	openpic_irq_def *irq_def;

	/* Figure out where we have our PIC */

	if (def->OpenPIC_Addr) {			/* Set in the parameter block ? */
		OpenPIC = def->OpenPIC_Addr;	/* Use this one */
	} else {
		if (OpenPIC_Addr) {				/* Set ie. from MPC107 init ? */
			OpenPIC = OpenPIC_Addr;		/* Use that */
		} else {
			printk("No OpenPIC found !\n");
			return;
		}
	}

	/* Sanity check, will help the ports to new architectures */

	if (!def->IRQdef) {
		printk("No Interrupt definitions for this OpenPIC!\n");
		return;
	}

	/* First vector in the array should be the lowest !! */
	/* This will also be considered the offset for the Timers and IPI:s */

	open_pic_irq_offset = def->IRQdef->Vector;

#ifdef CONFIG_EPIC_SERIAL_MODE
	/* Have to start from ground zero.
	*/
	openpic_reset();
#endif

	if ( ppc_md.progress ) ppc_md.progress("openpic enter",0x122);

	t = openpic_read(&OpenPIC->Global.Feature_Reporting0);
	switch (t & OPENPIC_FEATURE_VERSION_MASK) {
	case 1:
		version = "1.0";
		break;
	case 2:
		version = "1.2";
		break;
	case 3:
		version = "1.3";
		break;
	default:
		version = "?";
		break;
	}
	NumProcessors = ((t & OPENPIC_FEATURE_LAST_PROCESSOR_MASK) >>
			 OPENPIC_FEATURE_LAST_PROCESSOR_SHIFT) + 1;
	NumSources = ((t & OPENPIC_FEATURE_LAST_SOURCE_MASK) >>
		      OPENPIC_FEATURE_LAST_SOURCE_SHIFT) + 1;

	printk("OpenPIC Version %s (%d CPUs and %d IRQ sources) at %p\n",
	       version, NumProcessors, NumSources, OpenPIC);

	timerfreq = openpic_read(&OpenPIC->Global.Timer_Frequency);
	if (timerfreq)
		printk("OpenPIC timer frequency is %d.%06d MHz\n",
		       timerfreq / 1000000, timerfreq % 1000000);

	if (def->slave_pic)
		return;

	/* Initialize timer interrupts */
	if ( ppc_md.progress ) ppc_md.progress("openpic timer",0x3ba);
	for (i = 0; i < OPENPIC_NUM_TIMERS; i++) {
		/* Disabled, Priority 0 */
		openpic_inittimer(i, 0, OPENPIC_VEC_TIMER+i+open_pic_irq_offset);
		/* No processor */
		openpic_maptimer(i, 0);
	}

#ifdef CONFIG_SMP
	/* Initialize IPI interrupts */
	if ( ppc_md.progress ) ppc_md.progress("openpic ipi",0x3bb);
	for (i = 0; i < OPENPIC_NUM_IPI; i++) {
		/* Disabled, Priority 10..13 */
		openpic_initipi(i, 10+i, OPENPIC_VEC_IPI+i+open_pic_irq_offset);
		/* IPIs are per-CPU */
		irq_desc[OPENPIC_VEC_IPI+i+open_pic_irq_offset].status |= IRQ_PER_CPU;
		irq_desc[OPENPIC_VEC_IPI+i+open_pic_irq_offset].handler = &open_pic_ipi;
	}
#endif

	find_ISUs();

	/* Initialize external interrupts */
	if (ppc_md.progress) ppc_md.progress("openpic ext",0x3bc);

	openpic_set_priority(0xf);

	/* Init all external sources */
	irq_def = def->IRQdef;

	while (irq_def->PICIrq >= 0) {

		/* the bootloader may have left it enabled (bad !) */
		openpic_disable_irq(irq_def->PICIrq);

		if (irq_def->IrqSense == OP_IRQ_LEVEL)
			irq_desc[irq_def->Vector].status = IRQ_LEVEL;

		/* Enabled */
		openpic_initirq(
			irq_def->PICIrq,
			irq_def->Priority,
			irq_def->Vector,
			irq_def->IrqPolarity,
			irq_def->IrqSense);
		/* Processor 0 */
		openpic_mapirq(irq_def->PICIrq, 1<<0);

		/* Init descriptor */
		irq_desc[irq_def->Vector].handler = &open_pic;

		/* Do the possible cascade stuff */
		if (irq_def->CascadeAckHandler) {
			cascaded[irq_def->Vector] = irq_def->CascadeAckHandler;
			if (request_irq(irq_def->Vector, no_action, SA_INTERRUPT,
					"cascaded", NULL))
				printk("Unable to get OpenPIC IRQ %d for cascade\n",
						irq_def->PICIrq);
		}
		/* Point to next */
		irq_def++;
	}

	/* Initialize the spurious interrupt */
	if (ppc_md.progress) ppc_md.progress("openpic spurious",0x3bd);
	openpic_set_spurious(OPENPIC_VEC_SPURIOUS+open_pic_irq_offset);

#ifdef CONFIG_EPIC_SERIAL_MODE
 	openpic_disable_8259_pass_through();
	openpic_eicr_set_clk(7);	/* Slowest value until we know better */
	openpic_enable_sie();
	openpic_set_priority(0);
#else
 	openpic_set_priority(0);
 	openpic_disable_8259_pass_through();
#endif

	if (ppc_md.progress) ppc_md.progress("openpic exit",0x222);
}

#ifdef CONFIG_POWER3
void openpic_setup_ISU(int isu_num, unsigned long addr)
{
	if (isu_num >= OPENPIC_MAX_ISU)
		return;
	ISU[isu_num] = (OpenPIC_SourcePtr) ioremap(addr, 0x400);
	if (isu_num >= NumISUs)
		NumISUs = isu_num + 1;
}
#endif

void find_ISUs(void)
{
#ifdef CONFIG_POWER3
        /* Use /interrupt-controller/reg and
         * /interrupt-controller/interrupt-ranges from OF device tree
	 * the ISU array is setup in chrp_pci.c in ibm_add_bridges
	 * as a result
	 * -- tgall
         */

	/* basically each ISU is a bus, and this assumes that
	 * open_pic_isu_count interrupts per bus are possible
	 * ISU == Interrupt Source
	 */
	NumSources = NumISUs * 0x10;

#else
	/* for non-distributed OpenPIC implementations it's in the IDU -- Cort */
	ISU[0] = (OpenPIC_Source *)OpenPIC->Source;
#endif
}

static void openpic_reset(void)
{
	openpic_setfield(&OpenPIC->Global.Global_Configuration0,
			 OPENPIC_CONFIG_RESET);
	while (openpic_readfield(&OpenPIC->Global.Global_Configuration0,
				 OPENPIC_CONFIG_RESET))
		mb();
}

static void openpic_enable_sie(void)
{
	openpic_setfield(&OpenPIC->Global.Global_Configuration1,
			 OPENPIC_EICR_SIE);
}

static void openpic_eicr_set_clk(u_int clkval)
{
	openpic_writefield(&OpenPIC->Global.Global_Configuration1,
			 OPENPIC_EICR_S_CLK_MASK, (clkval << 28));
}

#ifdef notused
static void openpic_enable_8259_pass_through(void)
{
	openpic_clearfield(&OpenPIC->Global.Global_Configuration0,
			   OPENPIC_CONFIG_8259_PASSTHROUGH_DISABLE);
}
#endif /* notused */

static void openpic_disable_8259_pass_through(void)
{
	openpic_setfield(&OpenPIC->Global.Global_Configuration0,
			 OPENPIC_CONFIG_8259_PASSTHROUGH_DISABLE);
}

/*
 *  Find out the current interrupt
 */
u_int openpic_irq(void)
{
	u_int vec;
	DECL_THIS_CPU;

	CHECK_THIS_CPU;
	vec = openpic_readfield(&OpenPIC->THIS_CPU.Interrupt_Acknowledge,
				OPENPIC_VECTOR_MASK);
	return vec;
}

void openpic_eoi(void)
{
	DECL_THIS_CPU;

	CHECK_THIS_CPU;
	openpic_write(&OpenPIC->THIS_CPU.EOI, 0);
	/* Handle PCI write posting */
	(void)openpic_read(&OpenPIC->THIS_CPU.EOI);
}

#ifdef notused
static u_int openpic_get_priority(void)
{
	DECL_THIS_CPU;

	CHECK_THIS_CPU;
	return openpic_readfield(&OpenPIC->THIS_CPU.Current_Task_Priority,
				 OPENPIC_CURRENT_TASK_PRIORITY_MASK);
}
#endif /* notused */

static void openpic_set_priority(u_int pri)
{
	DECL_THIS_CPU;

	CHECK_THIS_CPU;
	check_arg_pri(pri);
	openpic_writefield(&OpenPIC->THIS_CPU.Current_Task_Priority,
			   OPENPIC_CURRENT_TASK_PRIORITY_MASK, pri);
}

/*
 *  Get/set the spurious vector
 */
#ifdef notused
static u_int openpic_get_spurious(void)
{
	return openpic_readfield(&OpenPIC->Global.Spurious_Vector,
				 OPENPIC_VECTOR_MASK);
}
#endif /* notused */

static void openpic_set_spurious(u_int vec)
{
	check_arg_vec(vec);
	openpic_writefield(&OpenPIC->Global.Spurious_Vector, OPENPIC_VECTOR_MASK,
			   vec);
}

#ifdef CONFIG_SMP
/*
 * Convert a cpu mask from logical to physical cpu numbers.
 */
static inline u32 physmask(u32 cpumask)
{
	int i;
	u32 mask = 0;

	for (i = 0; i < smp_num_cpus; ++i, cpumask >>= 1)
		mask |= (cpumask & 1) << smp_hw_index[i];
	return mask;
}
#else
#define physmask(cpumask)	(cpumask)
#endif

void openpic_reset_processor_phys(u_int mask)
{
	openpic_write(&OpenPIC->Global.Processor_Initialization, mask);
}

static spinlock_t openpic_setup_lock = SPIN_LOCK_UNLOCKED;

#ifdef CONFIG_SMP
/*
 *  Initialize an interprocessor interrupt (and disable it)
 *
 *  ipi: OpenPIC interprocessor interrupt number
 *  pri: interrupt source priority
 *  vec: the vector it will produce
 */
static void __init openpic_initipi(u_int ipi, u_int pri, u_int vec)
{
	check_arg_ipi(ipi);
	check_arg_pri(pri);
	check_arg_vec(vec);
	openpic_safe_writefield_IPI(&OpenPIC->Global.IPI_Vector_Priority(ipi),
				OPENPIC_PRIORITY_MASK | OPENPIC_VECTOR_MASK,
				(pri << OPENPIC_PRIORITY_SHIFT) | vec);
}

/*
 *  Send an IPI to one or more CPUs
 *
 *  Externally called, however, it takes an IPI number (0...OPENPIC_NUM_IPI)
 *  and not a system-wide interrupt number
 */
void openpic_cause_IPI(u_int ipi, u_int cpumask)
{
	DECL_THIS_CPU;

	CHECK_THIS_CPU;
	check_arg_ipi(ipi);
	openpic_write(&OpenPIC->THIS_CPU.IPI_Dispatch(ipi),
		      physmask(cpumask));
}

void openpic_request_IPIs(void)
{
	int i;

	/*
	 * Make sure this matches what is defined in smp.c for
	 * smp_message_{pass|recv}() or what shows up in
	 * /proc/interrupts will be wrong!!! --Troy */

	if (OpenPIC == NULL)
		return;

	request_irq(OPENPIC_VEC_IPI+open_pic_irq_offset,
		    openpic_ipi_action, 0, "IPI0 (call function)", 0);
	request_irq(OPENPIC_VEC_IPI+open_pic_irq_offset+1,
		    openpic_ipi_action, 0, "IPI1 (reschedule)", 0);
	request_irq(OPENPIC_VEC_IPI+open_pic_irq_offset+2,
		    openpic_ipi_action, 0, "IPI2 (invalidate tlb)", 0);
	request_irq(OPENPIC_VEC_IPI+open_pic_irq_offset+3,
		    openpic_ipi_action, 0, "IPI3 (xmon break)", 0);

	for ( i = 0; i < OPENPIC_NUM_IPI ; i++ )
		openpic_enable_ipi(OPENPIC_VEC_IPI+open_pic_irq_offset+i);
}

/*
 * Do per-cpu setup for SMP systems.
 *
 * Get IPI's working and start taking interrupts.
 *   -- Cort
 */

void __init do_openpic_setup_cpu(void)
{
 	int i;
	u32 msk = 1 << smp_hw_index[smp_processor_id()];

	spin_lock(&openpic_setup_lock);

#ifdef CONFIG_IRQ_ALL_CPUS
 	/* let the openpic know we want intrs. default affinity
 	 * is 0xffffffff until changed via /proc
 	 * That's how it's done on x86. If we want it differently, then
 	 * we should make sure we also change the default values of irq_affinity
 	 * in irq.c.
 	 */
 	for (i = 0; i < NumSources ; i++)
		openpic_mapirq(i, openpic_read(&GET_ISU(i).Destination) | msk);
#endif /* CONFIG_IRQ_ALL_CPUS */
 	openpic_set_priority(0);

	spin_unlock(&openpic_setup_lock);
}
#endif /* CONFIG_SMP */

/*
 *  Initialize a timer interrupt (and disable it)
 *
 *  timer: OpenPIC timer number
 *  pri: interrupt source priority
 *  vec: the vector it will produce
 */
static void __init openpic_inittimer(u_int timer, u_int pri, u_int vec)
{
	check_arg_timer(timer);
	check_arg_pri(pri);
	check_arg_vec(vec);
	openpic_safe_writefield(&OpenPIC->Global.Timer[timer].Vector_Priority,
				OPENPIC_PRIORITY_MASK | OPENPIC_VECTOR_MASK,
				(pri << OPENPIC_PRIORITY_SHIFT) | vec);
}

/*
 *  Map a timer interrupt to one or more CPUs
 */
static void __init openpic_maptimer(u_int timer, u_int cpumask)
{
	check_arg_timer(timer);
	openpic_write(&OpenPIC->Global.Timer[timer].Destination,
		      physmask(cpumask));
}


/*
 *
 * All functions below take an offset'ed irq argument
 *
 */


/*
 *  Enable/disable an external interrupt source
 *
 *  Externally called, irq is an offseted system-wide interrupt number
 */
static void openpic_enable_irq(u_int irq)
{
	check_arg_irq(irq);
	openpic_clearfield(&GET_ISU(irq).Vector_Priority, OPENPIC_MASK);
	/* make sure mask gets to controller before we return to user */
	do {
		mb(); /* sync is probably useless here */
	} while(openpic_readfield(&GET_ISU(irq).Vector_Priority,
			OPENPIC_MASK));
}

static void openpic_disable_irq(u_int irq)
{
	u32 vp;

	check_arg_irq(irq);
	openpic_setfield(&GET_ISU(irq).Vector_Priority, OPENPIC_MASK);
	/* make sure mask gets to controller before we return to user */
	do {
		mb();  /* sync is probably useless here */
		vp = openpic_readfield(&GET_ISU(irq).Vector_Priority,
    			OPENPIC_MASK | OPENPIC_ACTIVITY);
	} while((vp & OPENPIC_ACTIVITY) && !(vp & OPENPIC_MASK));
}

#ifdef CONFIG_SMP
/*
 *  Enable/disable an IPI interrupt source
 *
 *  Externally called, irq is an offseted system-wide interrupt number
 */
void openpic_enable_ipi(u_int irq)
{
	irq -= (OPENPIC_VEC_IPI+open_pic_irq_offset);
	check_arg_ipi(irq);
	openpic_clearfield_IPI(&OpenPIC->Global.IPI_Vector_Priority(irq), OPENPIC_MASK);

}

void openpic_disable_ipi(u_int irq)
{
	irq -= (OPENPIC_VEC_IPI+open_pic_irq_offset);
	check_arg_ipi(irq);
	openpic_setfield_IPI(&OpenPIC->Global.IPI_Vector_Priority(irq), OPENPIC_MASK);
}
#endif

/*
 *  Initialize an interrupt source (and disable it!)
 *
 *  irq: OpenPIC interrupt number
 *  pri: interrupt source priority
 *  vec: the vector it will produce
 *  pol: polarity (1 for positive, 0 for negative)
 *  sense: 1 for level, 0 for edge
 */
static void openpic_initirq(u_int irq, u_int pri, u_int vec, irq_polarity_type pol, irq_sense_type sense)
{
	openpic_safe_writefield(&GET_ISU(irq).Vector_Priority,
				OPENPIC_PRIORITY_MASK | OPENPIC_VECTOR_MASK |
				OPENPIC_SENSE_MASK | OPENPIC_POLARITY_MASK,
				(pri << OPENPIC_PRIORITY_SHIFT) | vec |
				((pol == OP_IRQ_POS) ? OPENPIC_POLARITY_POSITIVE :
			    		OPENPIC_POLARITY_NEGATIVE) |
				((sense == OP_IRQ_LEVEL) ? OPENPIC_SENSE_LEVEL : OPENPIC_SENSE_EDGE));
}

/*
 *  Map an interrupt source to one or more CPUs
 */
static void openpic_mapirq(u_int irq, u_int physmask)
{
	openpic_write(&GET_ISU(irq).Destination, physmask);
}

#ifdef notused
/*
 *  Set the sense for an interrupt source (and disable it!)
 *
 *  sense: 1 for level, 0 for edge
 */
static void openpic_set_sense(u_int irq, int sense)
{
	openpic_safe_writefield(&GET_ISU(irq).Vector_Priority,
				OPENPIC_SENSE_LEVEL,
				(sense ? OPENPIC_SENSE_LEVEL : 0));
}
#endif /* notused */

/* No spinlocks, should not be necessary with the OpenPIC
 * (1 register = 1 interrupt and we have the desc lock).
 */
static void openpic_ack_irq(unsigned int irq_nr)
{
	openpic_disable_irq(irq_nr);
	openpic_eoi();
}

static void openpic_end_irq(unsigned int irq_nr)
{
	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
		openpic_enable_irq(irq_nr);
}

static void openpic_set_affinity(unsigned int irq_nr, unsigned long cpumask)
{
	openpic_mapirq(irq_nr - open_pic_irq_offset, physmask(cpumask));
}

#ifdef CONFIG_SMP
static void openpic_ack_ipi(unsigned int irq_nr)
{
	openpic_eoi();
}

static void openpic_end_ipi(unsigned int irq_nr)
{
}

static void openpic_ipi_action(int cpl, void *dev_id, struct pt_regs *regs)
{
	smp_message_recv(cpl-OPENPIC_VEC_IPI-open_pic_irq_offset, regs);
}

#endif /* CONFIG_SMP */

/* This one may be merged with PReP and CHRP */
int
openpic_get_irq(struct pt_regs *regs)
{
	int irq = openpic_irq();

    if (cascaded[irq])	/* Do we have special handling? */
    {
		irq = (cascaded[irq])( smp_processor_id() );
		openpic_eoi();
    }

	if (irq == OPENPIC_VEC_SPURIOUS + open_pic_irq_offset)
		irq = -1;
	return irq;
}

#ifdef CONFIG_SMP
void
smp_openpic_message_pass(int target, int msg, unsigned long data, int wait)
{
	/* make sure we're sending something that translates to an IPI */
	if (msg > 0x3) {
		printk("SMP %d: smp_message_pass: unknown msg %d\n",
		       smp_processor_id(), msg);
		return;
	}
	switch (target) {
	case MSG_ALL:
		openpic_cause_IPI(msg, 0xffffffff);
		break;
	case MSG_ALL_BUT_SELF:
		openpic_cause_IPI(msg,
				  0xffffffff & ~(1 << smp_processor_id()));
		break;
	default:
		openpic_cause_IPI(msg, 1<<target);
		break;
	}
}
#endif /* CONFIG_SMP */

#ifdef CONFIG_PMAC_PBOOK
static u32 save_ipi_vp[OPENPIC_NUM_IPI];
static u32 save_irq_src_vp[OPENPIC_MAX_SOURCES];
static u32 save_irq_src_dest[OPENPIC_MAX_SOURCES];
static u32 save_cpu_task_pri[OPENPIC_MAX_PROCESSORS];

void __pmac
openpic_sleep_save_intrs(void)
{
	int	i;
	unsigned long flags;

	spin_lock_irqsave(&openpic_setup_lock, flags);

	for (i=0; i<NumProcessors; i++) {
		save_cpu_task_pri[i] = openpic_read(&OpenPIC->Processor[i].Current_Task_Priority);
		openpic_writefield(&OpenPIC->Processor[i].Current_Task_Priority,
				   OPENPIC_CURRENT_TASK_PRIORITY_MASK, 0xf);
	}

	for (i=0; i<OPENPIC_NUM_IPI; i++)
		save_ipi_vp[i] = openpic_read(&OpenPIC->Global.IPI_Vector_Priority(i));
	for (i=0; i<NumSources; i++) {
		save_irq_src_vp[i] = openpic_read(&OpenPIC->Source[i].Vector_Priority)
			& ~OPENPIC_ACTIVITY;
		save_irq_src_dest[i] = openpic_read(&OpenPIC->Source[i].Destination);
	}
	spin_unlock_irqrestore(&openpic_setup_lock, flags);
}

void __pmac
openpic_sleep_restore_intrs(void)
{
	int		i;
	unsigned long	flags;

	spin_lock_irqsave(&openpic_setup_lock, flags);

	openpic_reset();

	for (i=0; i<OPENPIC_NUM_IPI; i++)
		openpic_write(&OpenPIC->Global.IPI_Vector_Priority(i), save_ipi_vp[i]);
	for (i=0; i<NumSources; i++) {
		openpic_write(&OpenPIC->Source[i].Vector_Priority, save_irq_src_vp[i]);
		openpic_write(&OpenPIC->Source[i].Destination, save_irq_src_dest[i]);
	}
	openpic_set_spurious(OPENPIC_VEC_SPURIOUS+open_pic_irq_offset);
	openpic_disable_8259_pass_through();
	for (i=0; i<NumProcessors; i++)
		openpic_write(&OpenPIC->Processor[i].Current_Task_Priority, save_cpu_task_pri[i]);

	spin_unlock_irqrestore(&openpic_setup_lock, flags);
}
#endif /* CONFIG_PMAC_PBOOK */

--==_Exmh_-14643952120--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
