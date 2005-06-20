Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9956B67B26
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2005 04:22:44 +1000 (EST)
Date: Mon, 20 Jun 2005 11:22:40 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Garcia J?r?mie <GARCIAJ@3il.fr>
Message-ID: <20050620182240.GB32412@gate.ebshome.net>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B3B@exnet.3il.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B3B@exnet.3il.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Disable task rescheduling
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 20, 2005 at 03:12:03PM +0200, Garcia J?r?mie wrote:
> Hi everybody, as teh object of this mail tells, I'd like to know if there is an easy way
> to disable task rescheduling in the kernel.
> I explain: I'm writing a device driver and so, I use the ioctl.
> In one of my ioctl's, I'd like to have a non-interruptible part processed.
> 
> int Hscx_ioctl(        struct inode *inode,
>                        struct file *file,
>                        unsigned int ioctl_num,     /* Number of the ioctl to call    */
>                        unsigned long argP)         /* Paramater to pass to the ioctl */
> {
>    [...]
>    switch(ioctl_num)
>    {
>          case GET_LIST:
>          
>              disable_task_rescheduling();  // what to use???
>              disable_interrupt();          // spin_lock_irqsave should be enough isn't it?
> 
>              execute_critical_code();
> 
>              enable_task_rescheduling();   // what to use???
>              enable_interrupt();           // spin_unlock_irqrestore should be enough isn't it?
>              break;
>    }
> }

Disabling interrupts (with spin_lock_irq) also disables kernel 
preemption (if enabled, if not - kernel won't preempt current task 
anyway when in the driver), so explicitly disable 
(disable_task_rescheduling) isn't needed.

-- 
Eugene
