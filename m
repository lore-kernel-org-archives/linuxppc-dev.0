Message-ID: <3D08AA25.9AF41113@icn.siemens.de>
Date: Thu, 13 Jun 2002 16:20:21 +0200
From: Steffen Rumler <Steffen.Rumler@icn.siemens.de>
MIME-Version: 1.0
To: Neil Horman <nhorman@lvl7.com>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Accessing the user stack inside system call service routine
References: <3D084D1F.95AFFCBB@icn.siemens.de> <3D087D95.5070206@lvl7.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>         Since the process virtual address which are used on the user space stack are not
> directly available from the context of the kernel, you will need to do some
> virtual address translation to access teh stack frames you are interested in.  I
> would suggest that you look at the source code for the copy_to_user and
> copy_from_user functions to see how they access a process address space from
> kernel space.  That will probably start you in the right direction.
> hope that helps!
> Neil :)
>

Thank you for the answer.

I have not accessed the user  space directly.
Instead I have just used copy_from_user():


int
sys_sigsuspend(old_sigset_t mask, int p2, int p3, int p4, int p6, int
p7,
	       struct pt_regs *regs)
{
  ...
  while (1) {

    current->state = TASK_INTERRUPTIBLE;

    current->in_suspend = 1;     /* XXX my stuff for debugging */
    current->user_regs  = regs;
    if(copy_from_user(current->user_stack_xxx, regs->gpr[1], 128)){

      printk("\n------------- copy_from_user failed: %d\n", ret);
    }

    schedule();

    current->in_suspend = 0;    /* XXX my stuff for debugging */
    current->user_regs  = NULL;
    ...
}

The copy_from_user() works fine. The printk() message does not
appear.

Later, when I inspect 'current->user_stack_xxx' (temporary
added to struct_task) for all processes with 'current->in_suspend'
set, all seems to be zero. I do this check within a kernel
module, I can load when the threads are hanging.

Steffen

--


--------------------------------------------------------------

Steffen Rumler
ICN ON PNE SB 4
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@icn.siemens.de
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
