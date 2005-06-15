Return-Path: <scarayol@assystembrime.com>
Received: from srv_courtaboeuf.brime.fr (unknown [81.255.87.178])
	by ozlabs.org (Postfix) with ESMTP id 80AE1679E6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 21:34:48 +1000 (EST)
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Message-ID: <OFF7502093.7CED40CA-ONC1257021.003F0EB2@brime.fr>
From: scarayol@assystembrime.com
Date: Wed, 15 Jun 2005 13:36:19 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: =?iso-8859-1?q?R=E9f=2E_=3A_Re=3A_MPC885_interruptions_=3A_help_?=
	=?iso-8859-1?q?!?=
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thank you,

but on the MPC885 IRQ7 is the only one function for this pin. On the other
hand, we have a problem in the kernel that calibrate the delay loop because
it found 2.17 BogoMIPS (instead of 50 or 80 BogoMIPS).
Could it explain the problem for the interruption ? (even if the
application work fine).

Sophie CARAYOL

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
