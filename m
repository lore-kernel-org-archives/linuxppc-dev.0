Message-ID: <3D087D95.5070206@lvl7.com>
Date: Thu, 13 Jun 2002 07:10:13 -0400
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: Steffen Rumler <Steffen.Rumler@icn.siemens.de>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Accessing the user stack inside system call service routine
References: <3D084D1F.95AFFCBB@icn.siemens.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Since the process virtual address which are used on the user space stack are not
directly available from the context of the kernel, you will need to do some
virtual address translation to access teh stack frames you are interested in.  I
would suggest that you look at the source code for the copy_to_user and
copy_from_user functions to see how they access a process address space from
kernel space.  That will probably start you in the right direction.
hope that helps!
Neil :)


Steffen Rumler wrote:

> Hello,
>
> I want to access/record the user stack within the system call
> service routine sys_sigsuspend() (arch/ppc/signal.c),
> in order to debug hanging threads.
>
> The user register context is passed to sys_sigsuspend() via
> the 'struct pt_regs *regs' argument.
>
> In this way I can obtain the stack pointer r1
> (via regs->gpr[1]) and catch the PPC EABI stack frames.
>
> But I see all zeros behind 'regs->gpr[1]' instead of proper
> stack frames. What is wrong ?
>
> How can I access the user stack within a
> system call service routine (sys_XXX) ?
>
> Thank you for help,
>
>
> Steffen
>
> --
>
>
> --------------------------------------------------------------
>
> Steffen Rumler
> ICN ON PNE SB 4
> Siemens AG
> Hofmannstr. 51                 Email: Steffen.Rumler@icn.siemens.de
> D-81359 Munich                 Phone: +49 89 722-44061
> Germany                        Fax  : +49 89 722-36703
>
> --------------------------------------------------------------
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
