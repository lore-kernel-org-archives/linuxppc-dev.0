Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79D40DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Mar 2007 04:42:27 +1000 (EST)
In-Reply-To: <175002.60794.qm@web15611.mail.cnb.yahoo.com>
References: <175002.60794.qm@web15611.mail.cnb.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <38067FD3-F201-4373-A067-CFED1589D6C3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Try to Disable PPC Interrupt
Date: Thu, 29 Mar 2007 13:41:30 -0500
To: Zhou Rui <vancasperz@yahoo.com.cn>
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


On Mar 28, 2007, at 11:20 PM, Zhou Rui wrote:

> Hi
> Sorry for my silly mistake, and I modify it like this:
> #ifndef MODULE
> #define MODULE
> #endif
>
> #ifndef __KERNEL__
> #define __KERNEL__
> #endif
>
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/types.h>
> #include <linux/errno.h>
>
> void hw_disable_irq (void) {
>         int c;
>         __asm__ __volatile__(
>                 "mfmsr %%r0; \
>                 wrteei 0; \
>                 mfmsr %0;":"=r"(c) : );
>
Why don't use use local_irq_disable() ?


>         printk("%x\n",c);
> }
>
> int init_module(void)
> {
>           hw_disable_irq();
> }
>
> void cleanup_module(void)
> {
> }
>
> MODULE_LICENSE("GPL");
>
>
> I can get the output is 0x21030. But I also use BDI2000 here and  
> when I halt the board from BDI2000, I get
> 405EP>halt
>     Core number            : 0
>     Core state                 : debug mode
>     Debug entry cause : JTAG stop request
>     Current PC               : 0xc00042d8
>     Current CR               : 0x22004082
>     Current MSR           : 0x00029030
>     Current LR               : 0xc00042d8
> Hope my understanding for big endian is right. It seems 0x00029030  
> in MSR is
> 00000000 00000010 10010000 00110000, but 0x21030 is
> 00000000 00000010 00010000 00110000.
> It seems the 16th bit (EE) has been set to 0, but what should I do  
> to make sure whether the external interrupt is disabled or not?  
> Thank you very much.

What exactly are you asking?  If MSR[EE] = 0, interrupts are disabled.

- k
