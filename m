Return-Path: <hollis@penguinppc.org>
Received: from smtpauth08.mail.atl.earthlink.net
	(smtpauth08.mail.atl.earthlink.net [209.86.89.68])
	by ozlabs.org (Postfix) with ESMTP id F04C667B28
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jun 2005 00:13:51 +1000 (EST)
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B31@exnet.3il.fr>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B31@exnet.3il.fr>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <7f012559fb003847b719c9156b80b713@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Thu, 9 Jun 2005 09:13:48 -0500
To: =?ISO-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PPC arch and spinlocks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jun 8, 2005, at 9:29 AM, Garcia J=E9r=E9mie wrote:
> I'm new to kernel device driver (linux newbie) and I'd like to control=20=

> concurrent access
> to our hardware resources. (I'm working on a ppc405EP platform=20
> uniprocessor)
> ...
> So, I decided to declare a spinlock in my module and offer, via ioctl,=20=

> the possibilty to user
> space programs to handle it with spin_trylock(), spin_lock() and=20
> spin_unlock().

I don't think this makes any sense. Kernel spinlocks are to protect=20
critical sections of kernel code from race conditions.

> I really need to have an equivalent of the spin_trylock() routine in=20=

> order not to have the processus waiting till the semaphore is=20
> available when tryin to get it. (ask and take if available, but not=20
> sleep).

It sounds like what you want is to enforce only a single user of your=20
device driver. If that's the case, you will need an atomic operation,=20
but if that fails then simply return an appropriate error code from=20
your open() routine.

You could use a spinlock like drivers/char/nvram.c:
static int
nvram_open(struct inode *inode, struct file *file)
{
     spin_lock(&nvram_state_lock);
     if ((nvram_open_cnt && (file->f_flags & O_EXCL)) || ...)
         spin_unlock(&nvram_state_lock);
         return -EBUSY;
     }

     ...
     nvram_open_cnt++;
     spin_unlock(&nvram_state_lock);
     return 0;
}

In this example, "nvram_open_cnt++" is one of the operations being=20
protected from race conditions, such as two processes on an SMP system=20=

both entering open() at literally the same time. Of course, since you=20
aren't building SMP, you know that there will not be two processes in=20
open() simultaneously, so the spinlocks will be compiled out, and you=20
will be left with a plain counter returning -EBUSY if the device is=20
already in use.

-Hollis=
