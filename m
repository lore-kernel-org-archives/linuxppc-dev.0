Message-ID: <3CC00515.4429E463@lvl7.com>
Date: Fri, 19 Apr 2002 07:52:53 -0400
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: "Kim, Kwansuk" <kskim@neowave.co.kr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: The maximum size of stack in linuxppc kernel
References: <OMENKEONFDLIGLHPFALBMELMCIAA.kskim@neowave.co.kr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello-
    The exact size of the stack is based on the size of the task_union structure
in sched.h.  Because of the way a union works in C the task_struct defined in
the union is aligned toward the low address end of the structure, which is
overall 8K in length, to satisfy the stack variable space requirements.  The
remainder of that space is used as kernel stack on behalf of whichever process
causes a trap into the kernel.  I think in the event of an interrupt, the kernel
stack used is whichever one the current variable points to.  So to summarize,
the total allocated kernel stack size for any given process is 8K minus the size
of the task structure defined in sched.h

hope that helps!
Neil

"Kim, Kwansuk" wrote:
>
> Hi, everyone,
>
> I'm writing a device driver on my PPC405GP custom board, and
>
> I wonder the maximum size of stack which is used for function call.
>
> I searched kernel_source/Documantation and found such a comment.
>
>      A rigid stack limit
>       The kernel stack is about 6K in 2.2 (for most
>       architectures: it's about 14K on the Alpha), and shared
>       with interrupts so you can't use it all.  Avoid deep
>       recursion and huge local arrays on the stack (allocate
>       them dynamically instead).
>
> But I wonder exact maximum size of the kernel I'm using (2.4.18-pre7)
>
> How can I find it in the kernel source?
>
> I wish you a nice weekend!
>
>  ==============================================
>      Just for fun...
>                                                   - Linus Torvalds
>  ==============================================
>   Kwansuk Kim
>   Engineer, NeoWave Inc.
>   Tel   +82-31-380-4927    Fax +82-31-380-4747
>   E-mail: kskim@neowave.co.kr
> ==============================================
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
