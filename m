Date: Thu, 10 Jun 2004 09:00:30 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Mark Chambers <markc@mail.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: trying to debug my failure to start "init"
In-Reply-To: <004201c44ee6$0acb3270$0301a8c0@chuck2>
Message-ID: <Pine.LNX.4.58.0406100855330.11914@localhost.localdomain>
References: <Pine.LNX.4.58.0406091911340.3310@localhost.localdomain>
 <004201c44ee6$0acb3270$0301a8c0@chuck2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 10 Jun 2004, Mark Chambers wrote:

> >   for more feedback, i added a printk() call to the run_init_process()
> > function in init/main.c to see what it thought it was doing.
>
> Maybe you should add a printout of errno, which the execve() inside of
> run_init_process() will set - might give an important clue.

did that, here are the results:

Freeing unused kernel memory: 52k init
Trying run_init_process with /sbin/minit
Error code from execve: -1
Errno: 2
Trying run_init_process with /sbin/init
Error code from execve: -1
Errno: 14
Trying run_init_process with /etc/init
Error code from execve: -1
Errno: 14
Trying run_init_process with /bin/init
Error code from execve: -1
Errno: 14
Trying run_init_process with /bin/sh
Error code from execve: -1
Errno: 14
Kernel panic: No init found.  Try passing init= option to kernel.


  if i read the include files correctly (include/asm-generic/errno*.h), i
read this as:

#define ENOENT           2      /* No such file or directory */
#define EFAULT          14      /* Bad address */

note that the error for minit is different from all the busybox errors.
the man page for execve() tells me this:

ENOENT The file filename or a script or ELF interpreter does not exist,
or a shared library needed for file or interpreter cannot be found.

EFAULT filename points outside your accessible address space.

  so, i guess the next step is to compile minit statically and see what
happens.

rday


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
