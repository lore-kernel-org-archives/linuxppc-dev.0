Message-Id: <199902282049.VAA06261@piglet.cpu.lu>
Date: Sun, 28 Feb 1999 21:49:19 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2.2.2 compilation errors
To: costabel@wanadoo.fr
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <36D685FD.1E07A1DE@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On  26 Feb, this message from Martin Costabel echoed through cyberspace:
[concerning compile poblems with 2.2.2 re semaphores]
> 1) Downgrade. Take the 2 files kernel/ksyms.c and kernel/sched.c from a
> previous version. For your convenience, I have put them on my site
> http://www.maths.univ-rennes1.fr/~costabel/linux/boot/
> 
> 2) Upgrade. Take the 2 files include/asm-ppc/semaphore.h and
> include/asm-ppc/semaphore-helper.h from the cvs tree at samba.anu.edu.au
> (or take the whole tree; it contains many other bug fixes). On my Web
> site, I have a file kernel222-samba.diff that patches these 2 files. It
> is only 5kB, so this is the simplest way to go.

Hmmm... for me, this is not enough.

I get errors in drivers/scsi/scsi_error.c like this:

scsi_error.c: In function `scsi_error_handler':
scsi_error.c:1975: structure has no member named `owner'

The structure it complains about is struct semaphore, as defined in
include/asm/semaphore.h

Now, for PPC, we have a different (simpler) definition of struct
semaphore, lacking some of the members that i386 has. Obviously, these
members are referenced in drivers/scsi/scsi_error.c.

Any hints?

A quick look at your patch file will show it contains the same simpler
definition of struct semaphore.

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
