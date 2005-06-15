Return-Path: <scarayol@assystembrime.com>
Received: from srv_courtaboeuf.brime.fr (unknown [81.255.87.178])
	by ozlabs.org (Postfix) with ESMTP id 8EE7A67B17
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 23:30:51 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Message-ID: <OFFFD217B5.B72FE03C-ONC1257021.0049BAE2@brime.fr>
From: scarayol@assystembrime.com
Date: Wed, 15 Jun 2005 15:32:21 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: Re: MPC885 interruptions : OK
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

I found the solution for my problem : i have to configure theSIU Interrupt
Edge/Level Register (SIEL)like that :

((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel |= 0x00020000;   // for IRQ7

The SIMASK register was right.

Sophie.


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
