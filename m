Message-ID: <3D08B63B.4000901@lvl7.com>
Date: Thu, 13 Jun 2002 11:11:55 -0400
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: Steffen Rumler <Steffen.Rumler@icn.siemens.de>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Accessing the user stack inside system call service routine
References: <3D084D1F.95AFFCBB@icn.siemens.de> <3D087D95.5070206@lvl7.com> <3D08AA25.9AF41113@icn.siemens.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ahh, so you had already covered the addressing point.  sorry.  Well, the next
thing that would occur to me is that 128 bytes of all zero's may be ok.  I'm not
quite sure of the details of the inner workings of the standard C library for
this situation, but right before the code in the C library executes a trap
instruction to make the reuqested system call, it may append extra data to the
last user space stack frame.  I know this happens during signal handling.
Granted that call stack is transitioning the other way, but you see the same
sort of behavior, in which the first "stack frame" is not really a stack frame,
but rather a block of data which is removed before a return to the application
at the point where it called the library function.  I would suggest that you try
   copying more than 128 bytes to see if you start seeing valid stack frames, or
more directly, invistigate the C library code which wraps around the system call
in user space to see if it makes and strange manipulations to the stack frame
before executing a trap.  Good luck!
Neil

Steffen Rumler wrote:

>>        Since the process virtual address which are used on the user space stack are not
>>directly available from the context of the kernel, you will need to do some
>>virtual address translation to access teh stack frames you are interested in.  I
>>would suggest that you look at the source code for the copy_to_user and
>>copy_from_user functions to see how they access a process address space from
>>kernel space.  That will probably start you in the right direction.
>>hope that helps!
>>Neil :)
>>
>>
>
> Thank you for the answer.
>
> I have not accessed the user  space directly.
> Instead I have just used copy_from_user():
>
>
> int
> sys_sigsuspend(old_sigset_t mask, int p2, int p3, int p4, int p6, int
> p7,
> 	       struct pt_regs *regs)
> {
>   ...
>   while (1) {
>
>     current->state = TASK_INTERRUPTIBLE;
>
>     current->in_suspend = 1;     /* XXX my stuff for debugging */
>     current->user_regs  = regs;
>     if(copy_from_user(current->user_stack_xxx, regs->gpr[1], 128)){
>
>       printk("\n------------- copy_from_user failed: %d\n", ret);
>     }
>
>     schedule();
>
>     current->in_suspend = 0;    /* XXX my stuff for debugging */
>     current->user_regs  = NULL;
>     ...
> }
>
> The copy_from_user() works fine. The printk() message does not
> appear.
>
> Later, when I inspect 'current->user_stack_xxx' (temporary
> added to struct_task) for all processes with 'current->in_suspend'
> set, all seems to be zero. I do this check within a kernel
> module, I can load when the threads are hanging.
>
> Steffen
>
>


--
/******************************************************************
*Neil Horman
*Software Engineer
*LVL7 Systems
*13000 Weston Pkwy.
*Cary, NC 27513
*(919)-865-2915
*nhorman@lvl7.com
*PGP keyID 0xB5E1020A
*http://www.keyserver.net/en
*******************************************************************/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
