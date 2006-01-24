Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6E289681BD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jan 2006 05:08:20 +1100 (EST)
Received: from ovro.ovro.caltech.edu
	(IDENT:U2FsdGVkX18WW7hvIbKS3NlNAYi3Jsv2NxJzGi8ubcg@ovro.ovro.caltech.edu
	[192.100.16.2])
	by ovro.ovro.caltech.edu (8.13.1/8.13.1) with SMTP id k0OI8Hat000782
	for <linuxppc-embedded@ozlabs.org>; Tue, 24 Jan 2006 10:08:17 -0800
Message-ID: <43D66D06.9090904@ovro.caltech.edu>
Date: Tue, 24 Jan 2006 10:08:06 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Yosemite/440EP why are readl()/ioread32() setup to read little-endian?
References: <43CC3E37.4040707@softadvances.com>
In-Reply-To: <43CC3E37.4040707@softadvances.com>
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

I was writing a simple driver to test IRQ handling on the
AMCC Yosemite board. The board has an 8x2 header with several
GPIO pins, a number of which can be configured as IRQ inputs.

I plan to setup GPIO46 as output, and GPIO47 as input, and
select IRQ8 on that pin.

The GPIO46 and GPIO47 are configured via the GPIO1 registers
at 0xEF600C00. U-Boot can be used to read the register values:

=> md ef600c00 b
ef600c00: 00000000 c2000000 50080000 00000000    ........P.......
ef600c10: 00000000 00000000 00000000 3ffcfffd    ............?...
ef600c20: 00000000 00000000 00000000    ............

=> md ef600c30 6
ef600c30: 00000400 00000000 00010000 00000000    ................
ef600c40: 00000000 00000000    ........
=>

So

ef600c00  GPIO1_OR    = 00000000
ef600c04  GPIO1_TCR   = c2000000
ef600c30  GPIO1_ISR1L = 00000400

However, if I read those same registers back under Linux,
using the driver code pasted at the end of this message
I get:

# insmod yosemite_gpio.ko
- remap the GPIO registers
- remapped to address 0xD1008C00

- Read some GPIO1 registers using readl()
- GPIO1_OR    = 0x00000000
- GPIO1_TCR   = 0x000000C2
- GPIO1_ISR1L = 0x00040000

- Read some GPIO1 registers using ioread32()
- GPIO1_OR    = 0x00000000
- GPIO1_TCR   = 0x000000C2
- GPIO1_ISR1L = 0x00040000

- Read some GPIO1 registers using an integer pointer
- GPIO1_OR    = 0x00000000
- GPIO1_TCR   = 0xC2000000
- GPIO1_ISR1L = 0x00000400

readl() and ioread32() read the registers in little-endian format!

Looking at asm-ppc/io.h

  - ioread32() is just a readl()
  - line 180 (2.6.13) has readl() as in_le32()
    (the code is the same in the 2.6.15-denx kernel too)

So, this explains why the data is read in little-endian format,
but not why this was done.

If the processor was reading from the PCI bus, then sure, I
could understand why this might be used, but even then, that
should be up to the user, eg. by using cpu_to_le32 etc.

Should I just be using pointers for remapped processor
registers, and only use readl(), ioread32(), etc, on external
memory?

I know this is just a big-endian/little-endian issue, I'm
really just asking for the driver writing 'best practices'
in this regard.

Looking forward to enlightenment :)

Cheers
Dave





--------------------------driver code----------------------------

/* yosemite_gpio.c */

#include <linux/module.h>   /* kernel modules                    */
#include <asm/io.h>         /* ioremap64(), iounmap(), readl()   */

static unsigned long long base = 0x0EF600C00; // 36-bit address
static unsigned int size = 0x44;
static char *kernel;

static int __init simple_init(void)
{
	int *p;
	
	/* Get the GPIO control registers */
	printk(" - remap the GPIO registers\n");
	kernel = ioremap64(base, size);
	printk(" - remapped to address 0x%.8X\n", (int)kernel);

	printk(" - Read some GPIO1 registers using readl()\n");
	printk(" - GPIO1_OR    = 0x%.8X\n", readl(kernel));
	printk(" - GPIO1_TCR   = 0x%.8X\n", readl(kernel+0x04));
	printk(" - GPIO1_ISR1L = 0x%.8X\n", readl(kernel+0x30));

	printk(" - Read some GPIO1 registers using ioread32()\n");
	printk(" - GPIO1_OR    = 0x%.8X\n", ioread32(kernel));
	printk(" - GPIO1_TCR   = 0x%.8X\n", ioread32(kernel+0x04));
	printk(" - GPIO1_ISR1L = 0x%.8X\n", ioread32(kernel+0x30));
	
	p = (int *)kernel;
	printk(" - Read some GPIO1 registers using an integer pointer\n");
	printk(" - GPIO1_OR    = 0x%.8X\n", p[0]);
	printk(" - GPIO1_TCR   = 0x%.8X\n", p[1]);
	printk(" - GPIO1_ISR1L = 0x%.8X\n", p[12]);
	
	/* Don't load */
	iounmap(kernel);
	return -EINVAL;
	
}
module_init(simple_init);
MODULE_LICENSE("GPL");
