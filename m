Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 288DBDDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 14:25:56 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so246711anc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 19:25:55 -0800 (PST)
Date: Tue, 27 Nov 2007 21:25:48 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Unable to Read PPC440EPx Board ID thru Board Control and Status
	Registers (BCSR)
Message-ID: <20071127212548.3efd39e9@vader.jdub.homelinux.org>
In-Reply-To: <409454.53699.qm@web45615.mail.sp1.yahoo.com>
References: <409454.53699.qm@web45615.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 27 Nov 2007 02:47:45 -0800 (PST)
Dell Query <dell.query@yahoo.com> wrote:

> Hi,
> 
> I am creating a simple program which will try to read the board ID of the PPC440EPx thru BCSR but when I load it, it gives me "Data Read PLB Error". 
> 
> I am not sure if I missed out something.
> 
> I would really appreciate it if somebody could help me on this.
> 
> I have posted the source code below, as well as the complete message.
> 
> Many thanks!
> 
> SOURCE CODE:
> ----------------------------------------------------------------------
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/ioport.h>
> #include <linux/delay.h>
> #include <linux/init.h>
> #include <linux/interrupt.h>
> #include <linux/platform_device.h>
> #include <asm/irq.h>
> #include <asm/io.h>
> #include <linux/i2c.h>
> #include <linux/i2c-id.h>
> #include <asm/ocp.h>
> #include <asm/ibm4xx.h>
> 
> MODULE_LICENSE("GPL");
> 
> #define BCSR_BASE   0xC0002000

This is wrong.  It's 0x1C0002000.

> #define BCSR0       0
> #define BCSR1       1
> #define BCSR2       2
> 
> #define USER_LED    0x2
> #define SIZE_TO_MAP 10
> 
> #define LED_ON      0
> 
> uint __iomem *bcsrbase = NULL;
> 
> static int __init initFunction(void) {
>    uint tmp;
>    printk("<1> Calling init function.\n");
>    printk("<1> bcsrbase value %p...\n",bcsrbase);
>    printk("<1> Remapping %x...\n",BCSR_BASE);
>    /*map*/
>    bcsrbase = ioremap(BCSR_BASE, SIZE_TO_MAP);

Since this seems to be arch/ppc, use ioremap64.

josh
