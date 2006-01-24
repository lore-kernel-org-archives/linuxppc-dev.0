Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 291BE6891D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jan 2006 06:07:57 +1100 (EST)
Received: from ovro.ovro.caltech.edu
	(IDENT:U2FsdGVkX18FDgeFKjtbUs1NRGX+Ggq+2FjYsr5e/zw@ovro.ovro.caltech.edu
	[192.100.16.2])
	by ovro.ovro.caltech.edu (8.13.1/8.13.1) with SMTP id k0OJ7r6a002521
	for <linuxppc-embedded@ozlabs.org>; Tue, 24 Jan 2006 11:07:53 -0800
Message-ID: <43D67AF6.6070403@ovro.caltech.edu>
Date: Tue, 24 Jan 2006 11:07:34 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Yosemite/440EP is there a global interrupt enable mask?
References: <43CC3E37.4040707@softadvances.com>
	<43D66D06.9090904@ovro.caltech.edu>
In-Reply-To: <43D66D06.9090904@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm writing a simple driver to test IRQ handling on the
AMCC Yosemite board. The board has an 8x2 header with several
GPIO pins, a number of which can be configured as IRQ inputs.

I have setup GPIO46 as output, and GPIO47 as input, and
selected IRQ8 on that pin.

The simple driver sets up the IRQ handler, and then drops
into a loop where it pulses the GPIO47 output. The relevent
messages from this loop are:

  - Read some GPIO1 registers
  - GPIO1_OR    = 0x00020000
  - GPIO1_TCR   = 0xC2020000
  - GPIO1_ISR1L = 0x00000401
  - enable IRQ8
  - UIC1_SR = 0x00002800
  - UIC1_ER = 0xE0801008

IRQ8 is bit 19 in the enable register, i.e., 1 << (31-19) = 1000h
So, clearly its enabled here.

  - sleep for 1s
  - UIC1_SR = 0x00002800
  - UIC1_ER = 0xE0801008

And after a sleep for 1s its still enabled.

  ----- loop test -----
  - generate low on GPIO46
  - sleep for 10 ticks
  - generate high on GPIO46
  - UIC1_SR = 0x00003800
  - UIC1_ER = 0xE0800008
  - IRQ8 status is set, clearing it
  - UIC1_SR = 0x00002800
  - UIC1_ER = 0xE0800008
  - sleep for 10 ticks
  ... repeats ...

The low pulse on the GPIO46 pin definitely set the IRQ8 status
bit, but why on earth is the enable bit cleared!

(I added the check for the status bit being set, since my
IRQ handler was not getting called)

To enable the IRQ8 line, I simply accessed the UIC1_ER register
directly via

   reg = mfdcr(DCRN_UIC_ER(UIC1));
   reg |= 1 << (31-19);
   mtdcr(DCRN_UIC_ER(UIC1), reg);

So, is there a kernel wide interrupt enable mask that I really
should be using? Or, an interrupt enable API? I initially
thought that when I registered an interrupt using
request_irq() that the kernel would go off an enable the
requested IRQ, but this test shows that it did not.

Any ideas?

Cheers
Dave


--------------- driver code --------------------------

/* yosemite_irq.c */

#include <linux/module.h>   /* kernel modules                    */
#include <linux/interrupt.h>/* request_irq(), etc                */
#include <asm/io.h>         /* ioremap64(), iounmap(), readl()   */

static char *name = "yosemite_irq";
static unsigned long long base = 0x0EF600C00; // 36-bit address
static unsigned int size = 0x44;
static char *kernel;
static int irq = 8;

static irqreturn_t
simple_irq_handler(int irq, void *dev_id, struct pt_regs *regs)
{
	int *p = (int *)kernel;
	
	printk("<irq %d> received!\n", irq);

	/* Deassert the interrupt input; GPIO1_OR[14] = 1 */
//	writel(1<<(31-14), kernel);
	p[0] = 1 << (31-14);
	
	/* Clear IRQ8 status (UIC1_SR[19] = 1 to clear it) */
	mtdcr(DCRN_UIC_SR(UIC1), 1 << (31-19));
	
	return IRQ_HANDLED;
}


static int __init simple_init(void)
{
	int status;
	int reg;
	int *p;
	int i;

	printk("<init> called.\n");

	/* Get the GPIO control registers */
	printk(" - remap the GPIO registers\n");
	kernel = ioremap64(base, size);
	printk(" - remapped to address 0x%.8X\n", (int)kernel);
	p = (int *)kernel;
	
	/* Get the IRQ8 */
    	printk(" - request the IRQ\n");
  	status = request_irq(
		irq,
		simple_irq_handler,
		SA_INTERRUPT,
		name,
		0);
     if (status < 0) {
		printk(" - request for irq %d failed\n", irq);
		return status;
	}

	printk(" - Read some DCR registers\n");
	printk(" - UIC0_SR = 0x%.8X\n", mfdcr(DCRN_UIC_SR(UIC0)));
	printk(" - UIC0_ER = 0x%.8X\n", mfdcr(DCRN_UIC_ER(UIC0)));
	printk(" - UIC0_PR = 0x%.8X\n", mfdcr(DCRN_UIC_PR(UIC0)));
	printk(" - UIC0_TR = 0x%.8X\n", mfdcr(DCRN_UIC_TR(UIC0)));
	printk(" - UIC1_SR = 0x%.8X\n", mfdcr(DCRN_UIC_SR(UIC1)));
	printk(" - UIC1_ER = 0x%.8X\n", mfdcr(DCRN_UIC_ER(UIC1)));
	printk(" - UIC1_PR = 0x%.8X\n", mfdcr(DCRN_UIC_PR(UIC1)));
	printk(" - UIC1_TR = 0x%.8X\n", mfdcr(DCRN_UIC_TR(UIC1)));

	printk(" - Read some GPIO1 registers\n");
	printk(" - GPIO1_OR    = 0x%.8X\n", p[0]);
	printk(" - GPIO1_TCR   = 0x%.8X\n", p[1]);
	printk(" - GPIO1_ISR1L = 0x%.8X\n", p[12]);
	
    	/* Setup GPIO46 as output. GPIO46 drives GPIO47, and
	 * GPIO47 will be used as IRQ8. The default IRQ
	 * sensitivity is low and level sensitive.
	 */
	printk(" - set GPIO46 as output\n");
	
	/* GPIO1_OR[14] = 1 */
//	writel(readl(kernel)   | (1 << (31-14)), kernel);
	p[0] |= 1 << (31-14);
	
	/* GPIO1_TCR[14] = 1 */
//	writel(readl(kernel+0x04) | (1 << (31-14)), kernel+0x04);
	p[1] |= 1 << (31-14);
	
	/* Select GPIO47 IRQ8 input */
    	printk(" - set GPIO47 as IRQ8 input\n");
	/* GPIO1_ISR1L[30:31] = 01b */
//	writel(readl(kernel+0x30) | 1, kernel+0x30);
	p[12] |= 1;
	
	/* Clear IRQ8 status (write 1 to bit 19 to clear it) */
    	printk(" - clear IRQ8 status\n");
	mtdcr(DCRN_UIC_SR(UIC1), 1 << (31-19));

	printk(" - Read some GPIO1 registers\n");
	printk(" - GPIO1_OR    = 0x%.8X\n", p[0]);
	printk(" - GPIO1_TCR   = 0x%.8X\n", p[1]);
	printk(" - GPIO1_ISR1L = 0x%.8X\n", p[12]);
	
	/* Enable IRQ8 */
    	printk(" - enable IRQ8\n");
	reg = mfdcr(DCRN_UIC_ER(UIC1));
	reg |= 1 << (31-19);
	mtdcr(DCRN_UIC_ER(UIC1), reg);
	printk(" - UIC1_SR = 0x%.8X\n", mfdcr(DCRN_UIC_SR(UIC1)));
	printk(" - UIC1_ER = 0x%.8X\n", mfdcr(DCRN_UIC_ER(UIC1)));

	printk(" - sleep for 1s\n");
	set_current_state(TASK_INTERRUPTIBLE);
	schedule_timeout(HZ);
	printk(" - UIC1_SR = 0x%.8X\n", mfdcr(DCRN_UIC_SR(UIC1)));
	printk(" - UIC1_ER = 0x%.8X\n", mfdcr(DCRN_UIC_ER(UIC1)));
	reg = mfdcr(DCRN_UIC_ER(UIC1));
	if ((reg & (1 << (31-19))) == 0) {
		printk(" - hey something cleared my enable bit!\n");
		return 0;
	}
	
    	printk(" ----- loop test -----\n");
	for (i = 0; i < 5; i++) {
    		printk(" - generate low on GPIO46\n");
		p[0] = 0;
    		printk(" - sleep for 10 ticks\n");
		set_current_state(TASK_INTERRUPTIBLE);
		schedule_timeout(10);
   		printk(" - generate high on GPIO46\n");
		p[0] = 1 << (31-14);

		printk(" - UIC1_SR = 0x%.8X\n", mfdcr(DCRN_UIC_SR(UIC1)));
		printk(" - UIC1_ER = 0x%.8X\n", mfdcr(DCRN_UIC_ER(UIC1)));
  		reg = mfdcr(DCRN_UIC_SR(UIC1));
		if ((reg & (1 << (31-19))) == 0) {
			printk(" - IRQ8 status is not set\n");
		} else {
			printk(" - IRQ8 status is set, clearing it\n");
			mtdcr(DCRN_UIC_SR(UIC1), 1 << (31-19));	
		}
		printk(" - UIC1_SR = 0x%.8X\n", mfdcr(DCRN_UIC_SR(UIC1)));
		printk(" - UIC1_ER = 0x%.8X\n", mfdcr(DCRN_UIC_ER(UIC1)));

		printk(" - sleep for 10 ticks\n");
		set_current_state(TASK_INTERRUPTIBLE);
		schedule_timeout(10);
	}
	
	/* log load */
	printk("module loaded.\n");
	return 0;
	
}


void __exit simple_exit(void)
{
	int reg;
	printk("<exit> called.\n");

	/* Disable IRQ8 */
	reg = mfdcr(DCRN_UIC_ER(UIC1));
	reg &= ~(1 << (31-19));
	mtdcr(DCRN_UIC_ER(UIC1), reg);
	
	free_irq(irq, 0);
	iounmap(kernel);
	printk("module unloaded\n");
}

module_init(simple_init);
module_exit(simple_exit);
