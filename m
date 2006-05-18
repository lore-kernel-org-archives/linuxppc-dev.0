Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4CB17679FF
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 10:52:18 +1000 (EST)
Subject: Re: [PATCH/2.6.17-rc4 4/10]Powerpc:  Add tsi108 pic support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730626D61F@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD46730626D61F@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Thu, 18 May 2006 10:52:06 +1000
Message-Id: <1147913527.10703.55.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-17 at 18:14 +0800, Zang Roy-r61911 wrote:
> Add Tundra Semiconductor tsi108 host bridge interrupt controller support.

It looks a bit like an hacked up MPIC... Is it different enough to
justify a separate driver ? Or would it be possible to define a TSI108
flag to pass the current mpic driver and add the necessary bits to it ? 

> Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
> Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>
> 
> ---
> 
>  arch/powerpc/sysdev/tsi108_pic.c |  813 ++++++++++++++++++++++++++++++++++++++
>  include/asm-powerpc/tsi108_pic.h |  232 +++++++++++
>  2 files changed, 1045 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/tsi108_pic.c
>  create mode 100644 include/asm-powerpc/tsi108_pic.h
> 
> 7d23f6a0984cd54ca787f880a57067330900abe8
> diff --git a/arch/powerpc/sysdev/tsi108_pic.c b/arch/powerpc/sysdev/tsi108_pic.c
> new file mode 100644
> index 0000000..bbca587
> --- /dev/null
> +++ b/arch/powerpc/sysdev/tsi108_pic.c
> @@ -0,0 +1,813 @@
> +/*
> + * (C) Copyright 2005 Tundra Semiconductor Corp.
> + * Alex Bounine, <alexandreb@tundra.com).
> + *
> + * See file CREDITS for list of people who contributed to this
> + * project.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> + * MA 02111-1307 USA
> + */
> +
> +/*
> + * Tsi108 Interrupt Controller Handling
> + */
> +
> +#include <linux/config.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/sysdev.h>
> +#include <asm/ptrace.h>
> +#include <asm/signal.h>
> +#include <asm/io.h>
> +#include <asm/irq.h>
> +#include <asm/prom.h>
> +#include <asm/sections.h>
> +#include <asm/hardirq.h>
> +#include <asm/machdep.h>
> +
> +#include <asm/tsi108.h>
> +#include <asm/tsi108_irq.h>
> +#include <asm/tsi108_pic.h>
> +#undef DEBUG
> +
> +#ifdef DEBUG
> +#define DBG(fmt...) do { printk(fmt); } while(0)
> +#else
> +#define DBG(fmt...) do { } while(0)
> +#endif
> +
> +extern u32 get_vir_csrbase(void);
> +extern u32 tsi108_read_reg(u32 reg_offset);
> +extern void tsi108_write_reg(u32 reg_offset, u32 val);
> +
> +static phys_addr_t tsi108_pic_phy_addr;
> +static u32 tsi108_pic_vir_addr;
> +
> +static int tsi108_pic_cascade_irq = -1;
> +static int (*tsi108_pic_cascade_fn) (struct pt_regs *);
> +
> +/* Global Operations */
> +static void tsi108_pic_set_task_priority(u_int pri);
> +static void tsi108_pic_set_spurious(u_int vector);
> +void tsi108_pic_mask_all(void);
> +
> +/* Timer Interrupts */
> +static void tsi108_pic_inittimer(u_int timer, u_int pri, u_int vector);
> +static void tsi108_pic_maptimer(u_int timer, u_int cpumask);
> +
> +/* Interrupt Sources */
> +static void tsi108_pic_enable_irq(u_int irq);
> +static void tsi108_pic_disable_irq(u_int irq);
> +static void tsi108_pic_initirq(u_int irq, u_int pri, u_int vector, int polarity,
> +			       int is_level);
> +static void tsi108_pic_mapirq(u_int irq, u_int cpumask, u_int keepmask);
> +static void init_pci_source(void);
> +static inline int get_pci_source(int vector);
> +int tsi108_pic_set_irq_sense(int irq, int pol, int sense);
> +
> +/*
> + * tsi108_pic interface routines
> + */
> +static void tsi108_pic_end_irq(unsigned int irq_nr);
> +static void tsi108_pic_ack_irq(unsigned int irq_nr);
> +void tsi108_pic_set_affinity(unsigned int irq_nr, unsigned long cpumask);
> +
> +static struct hw_interrupt_type tsi108_pic_irq = {
> +	"tsi108_pic",
> +	NULL,
> +	NULL,
> +	tsi108_pic_enable_irq,
> +	tsi108_pic_disable_irq,
> +	tsi108_pic_ack_irq,
> +	tsi108_pic_end_irq,
> +	NULL
> +};
> +
> +static void tsi108_pci_irq_enable(u_int irq);
> +static void tsi108_pci_irq_disable(u_int irq);
> +static void tsi108_pci_irq_ack(u_int irq);
> +static void tsi108_pci_irq_end(u_int irq);
> +
> +static struct hw_interrupt_type tsi108_pci_irq = {
> +	"tsi108_PCI_int",
> +	NULL,
> +	NULL,
> +	tsi108_pci_irq_enable,
> +	tsi108_pci_irq_disable,
> +	tsi108_pci_irq_ack,
> +	tsi108_pci_irq_end,
> +	NULL
> +};
> +
> +#ifdef DBG_TSI108_INTERRUPT
> +#define ASSERT(expr)	if (!(expr)) { \
> +				printk("tsi108pic :" \
> +					"assertion failed! %s[%d]: %s\n", \
> +					__FUNCTION__, __LINE__, #expr); \
> +				dump_stack(); \
> +			}
> +#else
> +#define ASSERT(expr)	do {} while (0)
> +#endif
> +
> +static inline u_int get_vector_offset(u_int irq)
> +{
> +	u_int offset;
> +
> +	if (irq < TSI108_IRQ_BASE || irq >= IRQ_PCI_INTAD_BASE)
> +		return 0;
> +
> +	if (irq < IRQ_TSI108_MBOX0)
> +		offset = TSI108_INT_IVPR(irq - TSI108_IRQ_BASE);
> +	else if (irq < IRQ_TSI108_DBELL0)
> +		offset = TSI108_INT_MBVPR(irq - IRQ_TSI108_MBOX0);
> +	else if (irq < IRQ_TSI108_TIMER0)
> +		offset = TSI108_INT_DVPR(irq - IRQ_TSI108_DBELL0);
> +	else
> +		offset = TSI108_INT_GTVPR(irq - IRQ_TSI108_TIMER0);
> +
> +	return offset;
> +}
> +
> +static inline u_int tsi108_pic_read_reg(u_int reg_offset)
> +{
> +	return in_be32((volatile u32 *)(tsi108_pic_vir_addr + reg_offset));
> +}
> +
> +static inline void tsi108_pic_write_reg(u_int reg_offset, u_int val)
> +{
> +	out_be32((volatile u32 *)(tsi108_pic_vir_addr + reg_offset), val);
> +}
> +
> +void tsi108_pic_reset(void)
> +{
> +	tsi108_pic_write_reg(TSI108_INT_GCR, TSI108PIC_INT_GCR_R);
> +	while (tsi108_pic_read_reg(TSI108_INT_GCR) & TSI108PIC_INT_GCR_R)
> +		mb();
> +}
> +
> +void tsi108_pic_set_output(int dest_num, u32 sense, u32 polarity)
> +{
> +	u32 temp = 0;
> +	temp |= (IRQ_SENSE_LEVEL == sense) ?
> +	    (TSI108PIC_INT_CSR_S_LEVEL) : (TSI108PIC_INT_CSR_S_EDGE);
> +	temp |= (IRQ_POLARITY_POSITIVE == polarity) ?
> +	    (TSI108PIC_INT_CSR_P_HIGH) : (TSI108PIC_INT_CSR_P_LOW);
> +	tsi108_pic_write_reg(TSI108_INT_CSR(dest_num), temp);
> +	mb();
> +}
> +
> +int tsi108_pic_source_cfg(int src_num,	/* interrupt source number */
> +			  u32 sense,	/* interrupt source Sense */
> +			  u32 polarity,	/* interrupt source Polarity */
> +			  TSI108_IRQ_MODE mode	/* interrupt delivery Mode */
> +    )
> +{
> +	unsigned temp;
> +
> +	temp = tsi108_pic_read_reg(TSI108_INT_IVPR(src_num));
> +
> +	if (temp & TSI108PIC_ACTIVITY)	/* error if source is active */
> +		return -1;
> +
> +	if (0 == (temp & TSI108PIC_MASK)) {
> +		temp |= TSI108PIC_MASK;	/* mask IRQ prior making changes */
> +		tsi108_pic_write_reg(TSI108_INT_IVPR(src_num), temp);
> +	}
> +
> +	temp &= ~(TSI108PIC_INT_IVPR_MODE |
> +		  TSI108PIC_INT_IVPR_S | TSI108PIC_INT_IVPR_P);
> +
> +	temp |= (IRQ_SENSE_LEVEL == sense) ?
> +	    (TSI108PIC_INT_CSR_S_LEVEL) : (TSI108PIC_INT_CSR_S_EDGE);
> +	temp |= (IRQ_POLARITY_POSITIVE == polarity) ?
> +	    (TSI108PIC_INT_CSR_P_HIGH) : (TSI108PIC_INT_CSR_P_LOW);
> +
> +	tsi108_pic_write_reg(TSI108_INT_IVPR(src_num),
> +			     TSI108PIC_MASK | (mode << 29) | temp);
> +	return (0);
> +}
> +
> +int tsi108_pic_set_vector(int src_num,	/* source number */
> +			  int vect,	/* vector number */
> +			  int prio	/* interrupt source priority */
> +    )
> +{
> +	unsigned tmp;
> +
> +	tmp = tsi108_pic_read_reg(TSI108_INT_IVPR(src_num));
> +
> +	if (tmp & TSI108PIC_ACTIVITY)	/* error if source is active */
> +		return -1;
> +
> +	if (0 == (tmp & TSI108PIC_MASK)) {
> +		tmp |= TSI108PIC_MASK;	/* mask IRQ prior making changes */
> +		tsi108_pic_write_reg(TSI108_INT_IVPR(src_num), tmp);
> +	}
> +
> +	/* clear bits to be changed */
> +	tmp &= ~(TSI108PIC_VECTOR_MASK | TSI108PIC_PRIORITY_MASK);
> +
> +	tmp |= (prio << 16) | vect;
> +	tsi108_pic_write_reg(TSI108_INT_IVPR(src_num), tmp);
> +	return 0;
> +}
> +
> +void tsi108_pic_mask_all()
> +{
> +	int i;
> +	unsigned int vp;
> +
> +	/* Mask all external and internal interrupt sources */
> +	for (i = 0; i < TSI108PIC_MAX_SOURCES; i++) {
> +		vp = tsi108_pic_read_reg(TSI108_INT_IVPR(i));
> +		tsi108_pic_write_reg(TSI108_INT_IVPR(i), vp | TSI108PIC_MASK);
> +		mb();
> +
> +		/* Make sure that irq is masked */
> +		do {
> +			vp = tsi108_pic_read_reg(TSI108_INT_IVPR(i));
> +		} while ((vp & TSI108PIC_ACTIVITY) && !(vp & TSI108PIC_MASK));
> +	}
> +
> +	/* Mask all timer interrupts */
> +	for (i = 0; i < TSI108PIC_NUM_TIMERS; i++) {
> +		vp = tsi108_pic_read_reg(TSI108_INT_GTVPR(i));
> +		tsi108_pic_write_reg(TSI108_INT_GTVPR(i), vp | TSI108PIC_MASK);
> +		mb();
> +
> +		do {
> +			vp = tsi108_pic_read_reg(TSI108_INT_GTVPR(i));
> +		} while ((vp & TSI108PIC_ACTIVITY) && !(vp & TSI108PIC_MASK));
> +	}
> +
> +	/* Mask all doorbell interrupts */
> +	for (i = 0; i < TSI108PIC_NUM_DBELLS; i++) {
> +		vp = tsi108_pic_read_reg(TSI108_INT_DVPR(i));
> +		tsi108_pic_write_reg(TSI108_INT_IVPR(i), vp | TSI108PIC_MASK);
> +		mb();
> +
> +		do {
> +			vp = tsi108_pic_read_reg(TSI108_INT_DVPR(i));
> +		} while ((vp & TSI108PIC_ACTIVITY) && !(vp & TSI108PIC_MASK));
> +	}
> +
> +	/* Mask all mailbox interrupts */
> +	for (i = 0; i < 4; i++) {
> +		vp = tsi108_pic_read_reg(TSI108_INT_MBVPR(i));
> +		tsi108_pic_write_reg(TSI108_INT_MBVPR(i), vp | TSI108PIC_MASK);
> +		mb();
> +
> +		do {
> +			vp = tsi108_pic_read_reg(TSI108_INT_MBVPR(i));
> +		} while ((vp & TSI108PIC_ACTIVITY) && !(vp & TSI108PIC_MASK));
> +	}
> +}
> +
> +/*
> + * The Tsi108 PC initialization routine.
> + * A caller routine (usually from platform-specific code has to provide
> + * sense/polarity configuration information for four external interrupt
> + * sources INT0 - INT3. This should be done in form of four-byte array
> + * (one byte per source ) that contains combination of sensitivity/polarity
> + * flags defined in asm-ppc/irq.h.
> + *
> + * Example of PIC initialization call is shown below:
> + *
> + *   u_char your_board_pic_initsenses[] __initdata = {
> + *	    (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),  // INT[0] 
> + *	    (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),  // INT[1]
> + *	    (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),  // INT[2]
> + *	    (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE)   // INT[3]
> + *          };
> + *
> + * tsi108_pic_init(your_board_pic_initsenses);
> + */
> +
> +void __init tsi108_pic_init(u_char * board_init_senses)
> +{
> +	u_int i;
> +	u32 sense;
> +
> +	struct device_node *tsi_pic;
> +	tsi_pic = of_find_node_by_type(NULL, "open-pic");
> +	if (tsi_pic) {
> +		unsigned int size;
> +		void *prop = get_property(tsi_pic, "reg", &size);
> +		tsi108_pic_phy_addr = of_translate_address(tsi_pic, prop);
> +	}
> +
> +	DBG("%s: Tsi108 pic phy addr = 0x%x\n", __FUNCTION__,
> +	    (u32) tsi108_pic_phy_addr);
> +	if (tsi108_pic_phy_addr == 0) {
> +		printk("No tsi108 PIC found !\n");
> +		return;
> +	}
> +
> +	tsi108_pic_vir_addr = (u32) ioremap(tsi108_pic_phy_addr, 0x400);
> +
> +	tsi108_pic_reset();
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("tsi108_pic_init: enter", 0x122);
> +
> +	/* Initialize timer interrupts */
> +	for (i = 0; i < TSI108PIC_NUM_TIMERS; i++) {
> +		/* Disabled, Priority 0 */
> +		tsi108_pic_inittimer(i, 0, IRQ_TSI108_TIMER0 + i);
> +		/* No processor */
> +		tsi108_pic_maptimer(i, 0);
> +	}
> +
> +	/* Init board-specific external sources */
> +	for (i = 0; i < 4; i++) {
> +		sense = board_init_senses[i];
> +
> +		if (sense & IRQ_SENSE_MASK)
> +			irq_desc[TSI108_IRQ(i)].status |= IRQ_LEVEL;
> +
> +		/* Enabled, Priority 8 */
> +		tsi108_pic_initirq(i, 8, TSI108_IRQ(i),
> +				   (sense & IRQ_POLARITY_MASK),
> +				   (sense & IRQ_SENSE_MASK));
> +		/* Map to CPU #0 */
> +		tsi108_pic_mapirq(TSI108_IRQ(i), 1 << 0, 0);
> +	}
> +
> +	/* Init remaining internal sources. */
> +	for (; i < TSI108PIC_MAX_SOURCES; i++) {
> +		/* Disabled, Priority 8, by default - Positive Edge */
> +		tsi108_pic_initirq(i, 8, TSI108_IRQ(i),
> +				   IRQ_POLARITY_POSITIVE, IRQ_SENSE_EDGE);
> +		/* Map to CPU #0 */
> +		tsi108_pic_mapirq(TSI108_IRQ(i), (1 << 0), 0);
> +	}
> +
> +	/*
> +	 * Change sensitivity to level for sources that require it.
> +	 */
> +
> +	irq_desc[IRQ_TSI108_GIGE0].status |= IRQ_LEVEL;
> +	irq_desc[IRQ_TSI108_GIGE1].status |= IRQ_LEVEL;
> +	irq_desc[IRQ_TSI108_PCI].status |= IRQ_LEVEL;
> +
> +	/* Init descriptors */
> +	for (i = 0; i < TSI108PIC_MAX_SOURCES; i++)
> +		irq_desc[i + TSI108_IRQ_BASE].handler = &tsi108_pic_irq;
> +
> +	for (i = 0; i < NUM_PCI_IRQS; i++) {
> +		irq_desc[i + IRQ_PCI_INTAD_BASE].handler = &tsi108_pci_irq;
> +		irq_desc[i + IRQ_PCI_INTAD_BASE].status |= IRQ_LEVEL;
> +	}
> +
> +	/* Initialize the spurious interrupt */
> +	tsi108_pic_set_spurious(TSI108_IRQ_SPURIOUS);
> +	tsi108_pic_set_task_priority(0);
> +
> +	init_pci_source();
> +	tsi108_pic_enable_irq(IRQ_TSI108_PCI);
> +
> +	i = tsi108_pic_read_reg(TSI108_INT_VECTOR(0));
> +	tsi108_pic_write_reg(TSI108_INT_EOI(0), 0);
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("tsi108_pic_init: exit", 0x222);
> +}
> +
> +/*
> + *  Find out the current interrupt
> + */
> +static u_int tsi108_pic_get_vect(void)
> +{
> +	u_int vec;
> +
> +	vec = tsi108_pic_read_reg(TSI108_INT_VECTOR(0)) & TSI108PIC_VECTOR_MASK;
> +
> +#ifdef DBG_TSI108_INTERRUPT
> +	if (vec == TSI108_IRQ_SPURIOUS)
> +		printk("TSI108: SPURIOUS vec=0x%08x\n", vec);
> +	else
> +		printk("TSI108: read vec=0x%08x\n", vec);
> +#endif
> +	return (vec);
> +}
> +
> +static inline void tsi108_pic_eoi(void)
> +{
> +	tsi108_pic_write_reg(TSI108_INT_EOI(0), 0);
> +	mb();
> +}
> +
> +static void __init tsi108_pic_set_task_priority(u_int pri)
> +{
> +	ASSERT(pri >= 0 && pri < TSI108PIC_NUM_PRI);
> +
> +	tsi108_pic_write_reg(TSI108_INT_TASKP(0),
> +			     pri & TSI108PIC_INT_TASKP_TASKP);
> +	mb();
> +}
> +
> +static void tsi108_pic_set_spurious(u_int vec)
> +{
> +	ASSERT(vec == TSI108_IRQ_SPURIOUS);
> +	tsi108_pic_write_reg(TSI108_INT_SVR, vec);
> +	mb();
> +}
> +
> +#ifdef CONFIG_SMP
> +/*
> + * Convert a cpu mask from logical to physical cpu numbers.
> + */
> +static inline u32 physmask(u32 cpumask)
> +{
> +	int i;
> +	u32 mask = 0;
> +
> +	for (i = 0; i < NR_CPUS; ++i, cpumask >>= 1)
> +		if (cpu_online(i))
> +			mask |= (cpumask & 1) << smp_hw_index[i];
> +	return mask;
> +}
> +#else
> +#define physmask(cpumask)	(cpumask)
> +#endif
> +
> +/*
> + *  Initialize a timer interrupt (and disable it)
> + *
> + *  timer: timer number
> + *  pri:   interrupt source priority
> + *  vec:   the vector it will produce
> + */
> +static void __init tsi108_pic_inittimer(u_int timer, u_int pri, u_int vec)
> +{
> +	unsigned int gtvpr;
> +
> +	ASSERT(timer >= 0 && timer < TSI108PIC_NUM_TIMERS);
> +	ASSERT(pri >= 0 && pri < TSI108PIC_NUM_PRI);
> +	ASSERT(vec >= 0 && vec < TSI108PIC_NUM_VECTORS);
> +
> +	gtvpr = tsi108_pic_read_reg(TSI108_INT_GTVPR(timer));
> +	gtvpr &= ~(TSI108PIC_PRIORITY_MASK | TSI108PIC_VECTOR_MASK);
> +	gtvpr |= (pri << 16) | vec;
> +	tsi108_pic_write_reg(TSI108_INT_GTVPR(timer), gtvpr | TSI108PIC_MASK);
> +	mb();
> +}
> +
> +/*
> + *  Map a timer interrupt to one or more CPUs
> + */
> +static void __init tsi108_pic_maptimer(u_int timer, u_int cpumask)
> +{
> +	ASSERT(timer >= 0 && timer < TSI108PIC_NUM_TIMERS);
> +
> +	tsi108_pic_write_reg(TSI108_INT_GTDR(timer), physmask(cpumask));
> +	mb();
> +}
> +
> +/*
> + * Initalize the interrupt source which will generate an NMI.
> + * This raises the interrupt's priority from 8 to 9.
> + *
> + * irq: The logical IRQ which generates an NMI.
> + */
> +void __init tsi108_pic_init_nmi_irq(u_int irq)
> +{
> +	u_int offset = get_vector_offset(irq);
> +	u_int vpr = tsi108_pic_read_reg(offset);
> +	vpr &= ~TSI108PIC_PRIORITY_MASK;
> +	tsi108_pic_write_reg(offset, vpr | (9 << 16));
> +	mb();
> +}
> +
> +/*
> + *
> + * All functions below take an offset'ed irq argument
> + *
> + */
> +
> +/*
> + * Hookup a cascade to the tsi108 PIC.
> + */
> +void __init
> +tsi108_pic_hookup_cascade(u_int irq, char *name,
> +			  int (*cascade_fn) (struct pt_regs *))
> +{
> +	tsi108_pic_cascade_irq = irq;
> +	tsi108_pic_cascade_fn = cascade_fn;
> +	if (request_irq(irq, no_action, SA_INTERRUPT, name, NULL))
> +		printk("Unable to get Tsi108 PIC IRQ %d for cascade\n",
> +		       irq - TSI108_IRQ_BASE);
> +}
> +
> +/*
> + *  Enable/disable an external interrupt source
> + *
> + *  Externally called, irq is an offseted system-wide interrupt number
> + */
> +static void tsi108_pic_enable_irq(u_int irq)
> +{
> +	u32 offset = get_vector_offset(irq);
> +	u32 vpr = tsi108_pic_read_reg(offset);
> +
> +	/*
> +	 * Undo sensitivity change (see tsi108_pic_disable_irq()) 
> +	 */
> +	if (irq_desc[irq].status & IRQ_LEVEL)
> +		vpr |= TSI108PIC_INT_IVPR_S;
> +
> +	tsi108_pic_write_reg(offset, vpr & ~TSI108PIC_MASK);
> +	mb();
> +}
> +
> +static void tsi108_pic_disable_irq(u_int irq)
> +{
> +	u32 offset = get_vector_offset(irq);
> +	u32 vpr = tsi108_pic_read_reg(offset);
> +
> +	/*
> +	 * Switch level interrupt to edge sensitivity to avoid generation
> +	 * of spurious interrupt request. See design note in Tsi108 PIC 
> +	 * section of Tsi108 manual.
> +	 */
> +	if (irq_desc[irq].status & IRQ_LEVEL)
> +		vpr &= ~TSI108PIC_INT_IVPR_S;
> +
> +	tsi108_pic_write_reg(offset, vpr | TSI108PIC_MASK);
> +	mb();
> +	vpr = tsi108_pic_read_reg(offset);
> +	if (!(vpr & TSI108PIC_MASK))
> +		printk("TSI108_PIC: Error - Unable disable IRQ %d\n", irq);
> +}
> +
> +/*
> + *  Initialize an interrupt source (and disable it!)
> + *
> + *  irq: Tsi108 PIC interrupt source number
> + *  pri: interrupt source priority
> + *  vec: the vector it will produce
> + *  pol: polarity (1 for positive, 0 for negative)
> + *  sense: 1 for level, 0 for edge
> + */
> +static void __init
> +tsi108_pic_initirq(u_int irq, u_int pri, u_int vec, int pol, int sense)
> +{
> +	unsigned int ivpr;
> +
> +	ivpr = TSI108PIC_MASK | (pri << 16) | vec;
> +	ivpr |= (IRQ_SENSE_LEVEL == sense) ?
> +	    TSI108PIC_INT_IVPR_S_LEVEL : TSI108PIC_INT_IVPR_S_EDGE;
> +	ivpr |= (IRQ_POLARITY_POSITIVE == pol) ?
> +	    TSI108PIC_INT_IVPR_P_HIGH : TSI108PIC_INT_IVPR_P_LOW;
> +	tsi108_pic_write_reg(TSI108_INT_IVPR(irq), ivpr);
> +	mb();
> +}
> +
> +int tsi108_pic_set_irq_sense(int irq,	/* PIC source number */
> +			     int pol,	/* interrupt source polarity */
> +			     int sense	/* interrupt source sense */
> +    )
> +{
> +	unsigned int ivpr;
> +
> +	ivpr = tsi108_pic_read_reg(TSI108_INT_IVPR(irq));
> +
> +	if (ivpr & TSI108PIC_ACTIVITY)	/* error if source is active */
> +		return -1;
> +
> +	if (0 == (ivpr & TSI108PIC_MASK)) {
> +		ivpr |= TSI108PIC_MASK;	/* mask IRQ prior making changes */
> +		tsi108_pic_write_reg(TSI108_INT_IVPR(irq), ivpr);
> +	}
> +
> +	/* clear bits to be changed */
> +	ivpr &= ~(TSI108PIC_INT_IVPR_P | TSI108PIC_INT_IVPR_S);
> +
> +	ivpr |= (IRQ_SENSE_LEVEL == sense) ?
> +	    TSI108PIC_INT_IVPR_S_LEVEL : TSI108PIC_INT_IVPR_S_EDGE;
> +	ivpr |= (IRQ_POLARITY_POSITIVE == pol) ?
> +	    TSI108PIC_INT_IVPR_P_HIGH : TSI108PIC_INT_IVPR_P_LOW;
> +
> +	tsi108_pic_write_reg(TSI108_INT_IVPR(irq), ivpr);
> +	return 0;
> +}
> +
> +/*
> + *  Map an interrupt source to one or more CPUs
> + */
> +static void tsi108_pic_mapirq(u_int irq, u_int physmask, u_int keepmask)
> +{
> +	u_int offset = get_vector_offset(irq);
> +
> +	if (0 == offset)
> +		return;
> +	if (keepmask != 0)
> +		physmask |= tsi108_pic_read_reg(offset + 4);
> +	tsi108_pic_write_reg(offset + 4, physmask);
> +	mb();
> +}
> +
> +/* No spinlocks, should not be necessary with the Tsi108 PIC
> + * (1 register = 1 interrupt and we have the desc lock).
> + */
> +static void tsi108_pic_ack_irq(unsigned int irq_nr)
> +{
> +	if ((irq_desc[irq_nr].status & IRQ_LEVEL) == 0)
> +		tsi108_pic_eoi();
> +}
> +
> +static void tsi108_pic_end_irq(unsigned int irq_nr)
> +{
> +	if ((irq_desc[irq_nr].status & IRQ_LEVEL) != 0)
> +		tsi108_pic_eoi();
> +}
> +
> +void tsi108_pic_set_affinity(unsigned int irq_nr, unsigned long cpumask)
> +{
> +	tsi108_pic_mapirq(irq_nr, physmask(cpumask), 0);
> +}
> +
> +int tsi108_pic_get_irq(struct pt_regs *regs)
> +{
> +	int vector = tsi108_pic_get_vect();
> +
> +	if (vector == TSI108_IRQ_SPURIOUS) {
> +		vector = -1;
> +	}
> +
> +	if (vector == IRQ_TSI108_PCI) {
> +		vector = get_pci_source(vector);
> +	}
> +
> +	if (vector == -1) {
> +		tsi108_pic_write_reg(TSI108_INT_EOI(0), 0);
> +	}
> +
> +	return vector;
> +}
> +
> +static void tsi108_pci_int_mask(u_int irq)
> +{
> +	u_int irp_cfg;
> +	int int_line = (irq - IRQ_PCI_INTAD_BASE);
> +
> +	irp_cfg = tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL);
> +	mb();
> +	irp_cfg |= (1 << int_line);	/* INTx_DIR = output */
> +	irp_cfg &= ~(3 << (8 + (int_line * 2)));	/* INTx_TYPE = unused */
> +	tsi108_write_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL, irp_cfg);
> +	mb();
> +	irp_cfg = tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL);
> +}
> +
> +static void tsi108_pci_int_unmask(u_int irq)
> +{
> +	u_int irp_cfg;
> +	int int_line = (irq - IRQ_PCI_INTAD_BASE);
> +
> +	irp_cfg = tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL);
> +	mb();
> +	irp_cfg &= ~(1 << int_line);
> +	irp_cfg |= (3 << (8 + (int_line * 2)));
> +	tsi108_write_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL, irp_cfg);
> +	mb();
> +}
> +
> +static void tsi108_pci_irq_enable(u_int irq)
> +{
> +	tsi108_pci_int_unmask(irq);
> +}
> +
> +static void tsi108_pci_irq_disable(u_int irq)
> +{
> +	tsi108_pci_int_mask(irq);
> +}
> +
> +static void tsi108_pci_irq_ack(u_int irq)
> +{
> +	tsi108_pci_int_mask(irq);
> +}
> +
> +static void tsi108_pci_irq_end(u_int irq)
> +{
> +	tsi108_pic_eoi();	/* eoi IRQ_TSI108_PCI */
> +	tsi108_pci_int_unmask(irq);
> +}
> +
> +static inline int get_pci_source(int vector)
> +{
> +	u_int temp = 0;
> +	int irq = -1;
> +	int i;
> +	u_int pci_irp_stat;
> +	static int mask = 0;
> +
> +	/* Read PCI/X block interrupt status register */
> +	pci_irp_stat = tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_STAT);
> +	mb();
> +
> +	if (pci_irp_stat & TSI108_PCI_IRP_STAT_P_INT) {
> +		/* Process Interrupt from PCI bus INTA# - INTD# lines */
> +		temp =
> +		    tsi108_read_reg(TSI108_PCI_OFFSET +
> +				    TSI108_PCI_IRP_INTAD) & 0xf;
> +		mb();
> +		for (i = 0; i < 4; i++, mask++) {
> +			if (temp & (1 << mask % 4)) {
> +				irq = IRQ_PCI_INTA + mask % 4;
> +				mask++;
> +				break;
> +			}
> +		}
> +	}
> +#ifdef DBG_TSI108_INTERRUPT
> +	else {
> +		printk("TSI108_PIC: error in TSI108_PCI_IRP_STAT\n");
> +		pci_irp_stat =
> +		    tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_STAT);
> +		temp =
> +		    tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_INTAD);
> +		mb();
> +		printk(">> stat=0x%08x intad=0x%08x ", pci_irp_stat, temp);
> +		temp =
> +		    tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL);
> +		mb();
> +		printk("cfg_ctl=0x%08x ", temp);
> +		temp =
> +		    tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_ENABLE);
> +		mb();
> +		printk("irp_enable=0x%08x\n", temp);
> +	}
> +#endif				/* DBG_TSI108_INTERRUPT */
> +
> +	return irq;
> +}
> +
> +static void init_pci_source(void)
> +{
> +	tsi108_write_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL,
> +			0x0000ff00);
> +	tsi108_write_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_ENABLE, 
> +			0x00400000);
> +	mb();
> +}
> +
> +static struct sysdev_class tsi108_pic_sysclass = {
> +	set_kset_name("tsi108_pic"),
> +};
> +
> +static struct sys_device device_tsi108_pic = {
> +	.id = 0,
> +	.cls = &tsi108_pic_sysclass,
> +};
> +
> +static struct sysdev_driver driver_tsi108_pic = {
> +#ifdef CONFIG_PM		/* FIXME: placeholder for future development */
> +	.suspend = &tsi108_pic_suspend,
> +	.resume = &tsi108_pic_resume,
> +#endif				/* CONFIG_PM */
> +};
> +
> +static int __init init_tsi108_pic_sysfs(void)
> +{
> +	int rc;
> +
> +	if (!get_csrbase())
> +		return -ENODEV;
> +	printk(KERN_DEBUG "Registering tsi108_pic with sysfs...\n");
> +	rc = sysdev_class_register(&tsi108_pic_sysclass);
> +	if (rc) {
> +		printk(KERN_ERR "Failed registering tsi108_pic sys class\n");
> +		return -ENODEV;
> +	}
> +	rc = sysdev_register(&device_tsi108_pic);
> +	if (rc) {
> +		printk(KERN_ERR "Failed registering tsi108_pic sys device\n");
> +		return -ENODEV;
> +	}
> +	rc = sysdev_driver_register(&tsi108_pic_sysclass, &driver_tsi108_pic);
> +	if (rc) {
> +		printk(KERN_ERR "Failed registering tsi108_pic sys driver\n");
> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
> +subsys_initcall(init_tsi108_pic_sysfs);
> diff --git a/include/asm-powerpc/tsi108_pic.h b/include/asm-powerpc/tsi108_pic.h
> new file mode 100644
> index 0000000..7b23352
> --- /dev/null
> +++ b/include/asm-powerpc/tsi108_pic.h
> @@ -0,0 +1,232 @@
> +/*
> + * (C) Copyright 2005 Tundra Semiconductor Corp.
> + * Alex Bounine, <alexandreb@tundra.com).
> + *
> + * See file CREDITS for list of people who contributed to this
> + * project.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> + * MA 02111-1307 USA
> + */
> +
> +/*
> + *  arch/ppc/syslib/tsi108_pic.h - Tsi108 Interrupt Controller definitions
> + */
> +
> +#ifndef _LINUX_TSI108_PIC_H
> +#define _LINUX_TSI108_PIC_H
> +
> +#include <asm/tsi108_irq.h>
> +
> +#ifdef __KERNEL__
> +
> +/*
> + *  Tsi108 PIC supports up to 24 interrupt sources and up to 4 processors
> + */
> +
> +#define TSI108PIC_MAX_SOURCES		24
> +#define TSI108PIC_MAX_PROCESSORS	4
> +
> +#define TSI108PIC_NUM_TIMERS	4
> +#define TSI108PIC_NUM_DBELLS	4
> +#define TSI108PIC_NUM_PROC   	4
> +#define TSI108PIC_NUM_PRI	16
> +#define TSI108PIC_NUM_VECTORS	256
> +
> +/*
> + * Tsi108 PIC Register offsets within block.
> + */
> +
> +/* Registers controlling sources */
> +#define TSI108_INT_FRR		(0x000)
> +#define TSI108_INT_GCR		(0x004)
> +#define TSI108_INT_SVR		(0x010)
> +#define TSI108_INT_GTVPR(n)	(0x38 + 0x10*(n))
> +#define TSI108_INT_GTDR(n)	(0x3C + 0x10*(n))
> +#define TSI108_INT_IVPR(n)	(0x100 + 0x8*(n))
> +#define TSI108_INT_IDR(n)	(0x104 + 0x8*(n))
> +#define TSI108_INT_DVPR(n)	(0x204 + 0xC*(n))
> +#define TSI108_INT_DDR(n)	(0x208 + 0xC*(n))
> +#define TSI108_INT_MBVPR(n)	(0x284 + 0x10*(n))
> +#define TSI108_INT_MBDR(n)	(0x288 + 0x10*(n))
> +
> +/* Registers controlling destinations */
> +#define TSI108_INT_TASKP(n)	(0x300 + 0x40*(n))
> +#define TSI108_INT_VECTOR(n)	(0x304 + 0x40*(n))
> +#define TSI108_INT_EOI(n)	(0x308 + 0x40*(n))
> +#define TSI108_INT_CSR(n)	(0x30C + 0x40*(n))
> +
> +/*
> + * Generic definitions common for different types of interrupt
> + * sources.
> + */
> +
> +#define TSI108PIC_MASK		(0x80000000)
> +#define TSI108PIC_ACTIVITY	(0x40000000)
> +#define TSI108PIC_PRIORITY_MASK	(0x000f0000)
> +#define TSI108PIC_VECTOR_MASK	(0x000000ff)
> +
> +/**********************************************************
> + * Register Bit Masks definitions for every register
> + */
> +
> +/* TSI108PIC_INT_FRR : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_FRR_VID			(0x000000ff)
> +#define TSI108PIC_INT_FRR_NCPU			(0x00001f00)
> +#define TSI108PIC_INT_FRR_NITM			(0x0000e000)
> +#define TSI108PIC_INT_FRR_NIRQ			(0x07ff0000)
> +#define TSI108PIC_INT_FRR_NIDOOR		(0xe0000000)
> +#define TSI108PIC_INT_FRR_RESERVED		(0x18000000)
> +
> +/* TSI108PIC_INT_GCR : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_GCR_R			(0x80000000)
> +#define TSI108PIC_INT_GCR_RESERVED		(0x7fffffff)
> +
> +/* TSI108PIC_INT_ICR : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_ICR_R			(0x0000000f)
> +#define TSI108PIC_INT_ICR_RESERVED		(0xfffffff0)
> +
> +/* TSI108PIC_INT_MVI : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_MVI_VID			(0x000000ff)
> +#define TSI108PIC_INT_MVI_DID			(0x0000ff00)
> +#define TSI108PIC_INT_MVI_STEP			(0x00ff0000)
> +#define TSI108PIC_INT_MVI_RESERVED		(0xff000000)
> +
> +/* TSI108PIC_INT_SVR : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_SVR_VECTOR		(0x000000ff)
> +#define TSI108PIC_INT_SVR_RESERVED		(0xffffff00)
> +
> +/* TSI108PIC_INT_TFRR : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_TFRR_TIME_FREQ		(0xffffffff)
> +
> +/* TSI108PIC_INT_SOFT_SET : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_SOFT_SET_S		(0x00ffffff)
> +#define TSI108PIC_INT_SOFT_SET_RESERVED		(0xff000000)
> +
> +/* TSI108PIC_INT_SOFT_ENABLE : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_SOFT_ENABLE_EN		(0x00ffffff)
> +#define TSI108PIC_INT_SOFT_ENABLE_RESERVED	(0xff000000)
> +
> +/* TSI108PIC_INT_GTCCR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_GTCCR_COUNT		(0x7fffffff)
> +#define TSI108PIC_INT_GTCCR_T			(0x80000000)
> +
> +/* TSI108PIC_INT_GTBCR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_GTBCR_B_COUNT		(0x7fffffff)
> +#define TSI108PIC_INT_GTBCR_CI			(0x80000000)
> +
> +/* TSI108PIC_INT_GTVPR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_GTVPR_VECTOR		(0x000000ff)
> +#define TSI108PIC_INT_GTVPR_PRIORITY		(0x000f0000)
> +#define TSI108PIC_INT_GTVPR_PRESCALE		(0x00f00000)
> +#define TSI108PIC_INT_GTVPR_A			(0x40000000)
> +#define TSI108PIC_INT_GTVPR_M			(0x80000000)
> +#define TSI108PIC_INT_GTVPR_RESERVED		(0x3f00ff00)
> +
> +/* TSI108PIC_INT_GTDR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_GTDR_SEL_OUT		(0x0000000f)
> +#define TSI108PIC_INT_GTDR_RESERVED		(0xfffffff0)
> +
> +/* TSI108PIC_INT_IVPR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_IVPR_VECTOR		(0x000000ff)
> +#define TSI108PIC_INT_IVPR_PRIORITY		(0x000f0000)
> +
> +#define TSI108PIC_INT_IVPR_P			(0x01000000)
> +#define TSI108PIC_INT_IVPR_P_LOW		(0 << 24)
> +#define TSI108PIC_INT_IVPR_P_HIGH		(1 << 24)
> +
> +#define TSI108PIC_INT_IVPR_S			(0x02000000)
> +#define TSI108PIC_INT_IVPR_S_EDGE		(0 << 25)
> +#define TSI108PIC_INT_IVPR_S_LEVEL		(1 << 25)
> +
> +#define TSI108PIC_INT_IVPR_MODE			(0x20000000)
> +#define TSI108PIC_INT_IVPR_A			(0x40000000)
> +#define TSI108PIC_INT_IVPR_M			(0x80000000)
> +#define TSI108PIC_INT_IVPR_RESERVED		(0x1cf0ff00)
> +
> +/* TSI108PIC_INT_IDR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_IDR_SEL_OUT		(0x0000000f)
> +#define TSI108PIC_INT_IDR_RESERVED		(0xfffffff0)
> +
> +/* TSI108PIC_INT_DAR : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_DAR_A			(0x0000000f)
> +#define TSI108PIC_INT_DAR_RESERVED		(0xfffffff0)
> +
> +/* TSI108PIC_INT_DVPR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_DVPR_VECTOR		(0x000000ff)
> +#define TSI108PIC_INT_DVPR_PRIORITY		(0x000f0000)
> +#define TSI108PIC_INT_DVPR_A			(0x40000000)
> +#define TSI108PIC_INT_DVPR_M			(0x80000000)
> +#define TSI108PIC_INT_DVPR_RESERVED		(0x3ff0ff00)
> +
> +/* TSI108PIC_INT_DDR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_DDR_SEL_OUT		(0x0000000f)
> +#define TSI108PIC_INT_DDR_RESERVED		(0xfffffff0)
> +
> +/* TSI108PIC_INT_DMR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_DMR_M			(0xffffffff)
> +
> +/* TSI108PIC_INT_MBR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_MBR_M			(0xffffffff)
> +
> +/* TSI108PIC_INT_MBVPR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_MBVPR_VECTOR		(0x000000ff)
> +#define TSI108PIC_INT_MBVPR_PRIORITY		(0x000f0000)
> +#define TSI108PIC_INT_MBVPR_A			(0x40000000)
> +#define TSI108PIC_INT_MBVPR_M			(0x80000000)
> +#define TSI108PIC_INT_MBVPR_RESERVED		(0x3ff0ff00)
> +
> +/* TSI108PIC_INT_MBDR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_MBDR_SEL_OUT		(0x0000000f)
> +#define TSI108PIC_INT_MBDR_RESERVED		(0xfffffff0)
> +
> +/* TSI108PIC_INT_TASKP(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_TASKP_TASKP		(0x0000000f)
> +#define TSI108PIC_INT_TASKP_RESERVED		(0xfffffff0)
> +
> +/* TSI108PIC_INT_VECTOR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_VECTOR_VECTOR		(0x000000ff)
> +#define TSI108PIC_INT_VECTOR_LS_VECTOR		(0xff000000)
> +#define TSI108PIC_INT_VECTOR_RESERVED		(0x00ffff00)
> +
> +/* TSI108PIC_INT_EOI(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_EOI_EOI			(0x000000ff)
> +#define TSI108PIC_INT_EOI_RESERVED		(0xffffff00)
> +
> +/* TSI108PIC_INT_CSR(X) : Register Bits Masks Definitions */
> +#define TSI108PIC_INT_CSR_RESERVED		(0xfffffffc)
> +
> +#define TSI108PIC_INT_CSR_P			(1 << 0)
> +#define TSI108PIC_INT_CSR_P_LOW			(0 << 0)
> +#define TSI108PIC_INT_CSR_P_HIGH		(1 << 0)
> +
> +#define TSI108PIC_INT_CSR_S			(1 << 1)
> +#define TSI108PIC_INT_CSR_S_EDGE		(0 << 1)
> +#define TSI108PIC_INT_CSR_S_LEVEL		(1 << 1)
> +
> +extern void tsi108_pic_init(u_char * board_init_senses);
> +extern void tsi108_pic_reset(void);
> +extern void tsi108_pic_set_output(int dest_num, u32 sense, u32 polarity);
> +extern int tsi108_pic_source_cfg(int src_num, u32 sense,
> +				 u32 polarity, TSI108_IRQ_MODE mode);
> +extern int tsi108_pic_set_vector(int src_num, int vect, int prio);
> +extern void tsi108_pic_init_nmi_irq(u_int irq);
> +extern void tsi108_pic_hookup_cascade(u_int irq, char *name,
> +				      int (*cascade_fn) (struct pt_regs *));
> +extern int tsi108_pic_get_irq(struct pt_regs *regs);
> +
> +#endif				/* __KERNEL__ */
> +
> +#endif				/* _LINUX_TSI108_PIC_H */
