Message-ID: <3A6CDA97.A9C3FFE2@mvista.com>
Date: Mon, 22 Jan 2001 17:12:55 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <3A68F7A0.693639F1@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> I just heard about the bug Tom Gall fixed in "context_overflow"
> by testing for current->mm == NULL.
>
> I believe the proper solution is to use 'current->active_mm'
> instead of 'current->mm' (and you never get a null pointer).

OK, I've stayed on the side-lines, waiting till I had time to actually
read through the current linuxppc_2_5 source so I would understand
the way things are today.  So as I'm going through the messages, from
the beginning, I'm already confused.  The only "context_overflow" I
find is mmu_context_overflow() in arch/ppc/mm/init.c.  You obviously
aren't talking about the 8xx version of this function.  The other
version of the function contains:

        for_each_task(tsk) {
                if (tsk->mm)
                        tsk->mm->context = NO_CONTEXT;
        }

This is the code we are talking about, correct?  The reason I'm
confused is that I was being literal in my reading of "current->mm"
as opposed to "tsk->mm".

Thanks,

Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
