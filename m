Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 43BA867A06
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jun 2005 00:29:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 8 Jun 2005 16:29:38 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B31@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: PPC arch and spinlocks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody, I need your help one more time.
I'm new to kernel device driver (linux newbie) and I'd like to control =
concurrent access
to our hardware resources. (I'm working on a ppc405EP platform =
uniprocessor)
Reading the Allessandro Rubini book (Linux device drivers) and many =
lists and guides on the web,
I concluded that spinlocks were very adapted to my expectations.
So, I decided to declare a spinlock in my module and offer, via ioctl, =
the possibilty to user
space programs to handle it with spin_trylock(), spin_lock() and =
spin_unlock().
Unfortunately I saw that was not working properly and so, I wanted to =
debug the "spinlock-process"
printing the value of it after calling one of the above routine:=20

spinlock_t my_spinlock =3D SPIN_UNLOCKED;
[...]
spin_try_lock(&my_spinlock);
printk("value: %d\n",my_spinlock.lock);
[...]

At compile time, I had an error that told me no "lock" member for this =
type of structure.
And it was write, cause I investigated and noticed that the definition =
used for "spinlock_t"=20
structure was the following in <linux/spinlock.h>:

#if (__GNUC__ > 2 || __GNUC_MINOR__ > 95) =20
  typedef struct { } spinlock_t;
  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }   //  empty structure...
[...]

I don't understand cause I thought that spinlocks were recommended for =
SMP platforms but could be
safely used in uni-processor platforms too.=20
So did I miss something to be able to use them (in config?? is it =
specific to PPC arch??)?
If not, is there a way to get a similar behavior with others technics =
(mutex??). I saw Posix mutex? Are they
usable in kernel mode?
I really need to have an equivalent of the spin_trylock() routine in =
order not to have the processus waiting till
the semaphore is available when tryin to get it. (ask and take if =
available, but not sleep).

Please give me some tips.
Tks a lot for your precious help!!
Jeremie
