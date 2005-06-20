Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id B49CD67B1A
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jun 2005 23:12:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 20 Jun 2005 15:12:03 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B3B@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Disable task rescheduling
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody, as teh object of this mail tells, I'd like to know if =
there is an easy way
to disable task rescheduling in the kernel.
I explain: I'm writing a device driver and so, I use the ioctl.
In one of my ioctl's, I'd like to have a non-interruptible part =
processed.

int Hscx_ioctl(        struct inode *inode,
                       struct file *file,
                       unsigned int ioctl_num,     /* Number of the =
ioctl to call    */
                       unsigned long argP)         /* Paramater to pass =
to the ioctl */
{
   [...]
   switch(ioctl_num)
   {
         case GET_LIST:
        =20
             disable_task_rescheduling();  // what to use???
             disable_interrupt();          // spin_lock_irqsave should =
be enough isn't it?

             execute_critical_code();

             enable_task_rescheduling();   // what to use???
             enable_interrupt();           // spin_unlock_irqrestore =
should be enough isn't it?
             break;
   }
}

Could you give me a tip cause I've browsed the web and technical books =
and I can't find a solution.
Tks a lot
