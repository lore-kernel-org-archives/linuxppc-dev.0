Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F1CF679E6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 20:27:08 +1000 (EST)
Date: Wed, 15 Jun 2005 11:26:56 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: scarayol@assystembrime.com
Message-Id: <20050615112656.562f8209.ajz@cambridgebroadband.com>
In-Reply-To: <OF5286B922.38B1A4B5-ONC1257020.002FEFD0@brime.fr>
References: <OF5286B922.38B1A4B5-ONC1257020.002FEFD0@brime.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC885 interruptions  : help !
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Pins on the 8xx are highly configurable.  I recommend that you check
that the pin has not been configured for another  function.  For example
on the 862 the SIU_IRQ7 pin doubles as the MII tx clock.

Alex

On Wed, 15 Jun 2005 10:35:41 +0200
scarayol@assystembrime.com wrote:

> Hi all,
> 
> I wrote a module driver to manage interruptions. I have an
> interruption on MPC885 IRQ7 activated by a push button that provides a
> negative pulse of 200 ns width.
> When the device is open, i call request_irq() to install the interrupt
> handler:
> 
> int ret = request_irq(SIU_IRQ7, fpgadriver_irq_save_handler,
> SA_INTERRUPT, FPGA_ID, NULL);
> 
> void fpgadriver_irq_save_handler(int irq, void *dev_id, struct pt_regs
> *regs)
> {
>   fpga_it_source=FPGA_IRQ_SAVE;
>   printk( "fpgadriver: fpgadriver_irq_save_handler for device \n");
>   /* Prepare a task */
>   PREPARE_TQUEUE(&fpgadriver_bh_task, fpgadriver_bh_handler, dev_id);
>   /* Add a task to the immediate bottom half and mark it for schedule
>   */ queue_task(&fpgadriver_bh_task, &tq_immediate);
>    mark_bh(IMMEDIATE_BH);
> }
> 
> my read() is like that :
> 
> static ssize_t fpgadriver_read(struct file *file, char *buf, size_t
> count, loff_t *ppos)
> {
>   //mise a jour de l'indicateur d'etat d'endormissement
>   wakeups++;
>   interruptible_sleep_on(&readq);
>   buf[0]=fpga_it_source;
>   printk("fpgadriver_read  \n");
>   return 0;
> }
> 
> I have the wake_up_interruptible(&reaq) in fpgadriver_bh_handler(). My
> problem is that fpgadriver_irq_save_handler() is never called as if
> there is no interruption.
> Is there something else to modify to validate the interruption ? Is
> SIU_IRQ7 the right value for my interruption ? What have i to check ?
> 
> Thanks for your reply.
> 
> Sophie CARAYOL
> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
