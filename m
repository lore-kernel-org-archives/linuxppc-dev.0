Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 19A8768A1E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Feb 2006 02:10:47 +1100 (EST)
Message-ID: <43E767DE.4060003@ru.mvista.com>
Date: Mon, 06 Feb 2006 18:14:38 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Eckart_G=F6hler?= <e.goehler@ifen.com>
Subject: Re: mv-linux: Problem to implement custom driver interrupt handling
References: <43E74FB2.6010603@ifen.com>
In-Reply-To: <43E74FB2.6010603@ifen.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi,

In the Linux driver you should not access the interrupt controller directly.
The relevant XIntc_* calls are done by arch/ppc/syslib/xilinx_pic.c code.
E.g. the particular interrupt is unmasked when one calls request_irq().

Few more comments below.


Thanks,
Andrei


Eckart Göhler wrote:
> Hi,
> 
> We try to run montavista Linux pro 3.1 on an ml300 like embedded system 
> on an Virtex V2-Pro system. The system works fine with UART, Xilinx enet
> driver (booting with Das U-Boot).
> Now we try to implement some custom GPIO driver that must be triggered 
> from outside interrupts. Polling for data works fine but the handler for 
> HW-timer interrupts does behaves strange.
> 
> The relevant Linux driver part that requests the interrupt and starts 
> the timer look like below.
> 
> Installing such a driver works but
> - No report of driver interrupt called is sent
> - installing the driver results in a system that almost gets stuck and 
> has poor response (~sec) till the driver is rmmodded.
> 
> Checking the implementation with native Xilinx example timer application 
> works fine, provided the Xilinx exception handling is implemented.
> 
> Its not clear for me whether on ppc environment something specific must 
> be done for custom interrupts, though implementation of 
> xilinx_enet/xilinx_uartlite does not hint for something specific.
> 
> 
> sincerely
> 
> eckart goehler
> 
> 
> -----------------------------------------------------------------(snip)
> 
> // driver snippet that reacts on timer interrupts:
> 
> // timer\interrupt base addresses, modified by ioremap:
> unsigned long timer_base, interrupt_base;
> 
> 
> /* interrupt handler: */
> static
> void drv_interrupt_handler(int irq, void *dev_id, struct pt_regs *regs)
> {
>    printk(KERN_INFO DEVICE_NAME "interrupt occurred\n");

Most probably you should clear the interrupt source here.
Otherwise you could get back into the interrupt handler as
soon as you return from it due to the interrupt request still
being active.

> }
> 
> 
> 
> static int __init drv_init_module(void)
> {
> 
>    interrupt_base = (unsigned long)
>    ioremap(XPAR_INTC_BASEADDR,XPAR_INTC_HIGHADDR-XPAR_INTC_BASEADDR);
>    timer_base = (unsigned long)
>    ioremap(XPAR_TIMER_BASEADDR,XPAR_TIMER_HIGHADDR-XPAR_TIMER_BASEADDR);
> 
>    // install interrupt handler:
>    if (request_irq(DRV_IRQ, commdrv_interrupt_handler,
> 		       0, DEVICE_NAME, NULL)
>        )

You call request_irq() (i.e. unmask this interrupt) too early.
Configure the timer first.

>      {
>        printk(KERN_INFO DEVICE_NAME ": can¢t get assigned irq %i\n",
> 	     COMM_IRQ	
> 	   );
>    }
>    else { /* enable interrupt */
> 
>      printk(KERN_INFO DEVICE_NAME ": interrupt installed\n");
> 
>      /* Start the interrupt controller */
>      XIntc_mMasterEnable(interrupt_base);

- must not be used in the driver

>      // here: enable timer interrupt:
>      /* Set the number of cycles the timer counts before interrupting */
>      XTmrCtr_mSetLoadReg(timer_base, 0, TIMER_VALUE * 80000000l);
> 
> 
>      printk(KERN_INFO DEVICE_NAME ": clear timer\n");
> 
>      /* Reset the timers, and clear interrupts */
>      XTmrCtr_mSetControlStatusReg(timer_base, 0, XTC_CSR_INT_OCCURED_MASK
> 	                        | XTC_CSR_LOAD_MASK );
> 
>      printk(KERN_INFO DEVICE_NAME ": enable interrupt\n");
> 
>      /* Enable timer interrupts in the interrupt controller */
> 
>      XIntc_mEnableIntr(interrupt_base, DRV_IRQ_MASK);

- must not be used in the driver. Unmasking the interrupt is done inside request_irq().

>      //printk(KERN_INFO DEVICE_NAME ": start timer\n");
>      /* Start the timers */
>      XTmrCtr_mSetControlStatusReg(timer_base, 0, XTC_CSR_ENABLE_TMR_MASK
> 	                         | XTC_CSR_ENABLE_INT_MASK
> 				 | XTC_CSR_AUTO_RELOAD_MASK |
> 				   XTC_CSR_DOWN_COUNT_MASK);
> 
>    }
> }
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
