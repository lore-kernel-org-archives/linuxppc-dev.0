From: tom_gall@vnet.ibm.com
Message-ID: <3A6CAF58.FB1643F1@vnet.ibm.com>
Date: Mon, 22 Jan 2001 22:08:24 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: Tom Gall <tgall@rochcivictheatre.org>, Troy Benjegerdes <hozer@drgw.net>,
        linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <3A68F7A0.693639F1@mvista.com> <20010121222842.A27103@altus.drgw.net> <3A6BB971.7F128273@rochcivictheatre.org> <3A6C822F.7DB50A58@vnet.ibm.com> <3A6C9135.F542F0FA@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> tom_gall@vnet.ibm.com wrote:
>
> >   current->mm I believe is correct. active_mm for tasks in user space just point
> > back to mm. kernel space tasks will have an mm of NULL yet their active_mm will
> > point back to the last user space task they ran.
>
> Not exactly.  Every task running on a CPU must have an active_mm, and
> it represents the current context for the MMU.  This active_mm comes
> from a single threaded application's 'mm', or in the case of a
> thread without an 'mm' from the previous application that ran, or
> from somewhere else depending upon VM_CLONE games.

Hi Dan,

  Pat and I huddled around your note and gave this some more thought. Still not
convinced it's wrong tho.

> The point you are missing is 'active_mm' represents the current
> context for the MMU.  If you get a context overflow, you can't skip
> getting and setting a context for an active task just because it
> doesn't have a 'current->mm'.  Your modification to do this
> results in a task running on a CPU with a "NO CONTEXT" mm, and worse
> and incorrect VSID/ASID/PID/whatever for the task running on that MMU.

  active_mm represents the current context of USER space, not kernel space. I
think that's the important point here. If a task doesn't have a current->mm it's
a kernel task. It shouldn't be using the Segment Registers in the context.
Right? A kernel task should only be concerned with addresses in the range of
C0000000-FFFFFFFF which aren't in the context.

  If what you say is true that incorrect VSID/ASID etc could be handed out, I'm
wondering how my box has been up running and stable since last week. It's not
proof that it's right but I would think something would have melted down by
now....

> >   The reason for this patch is in the case where the idle task comes in on one
> > processor and on another processor it has encountered a context overflow.
>
> It's not just the idle task.  It could be any task that is supposed
> to get an active_mm from someone else.

  Since current->mm is NULL, it's a kernel task... granted it doesn't have to be
the idle task but it shouldn't matter. Or when you say any task, are you saying
that user tasks as well?

  Correct me if I'm wrong but from the code we were looking at the sched.c when
you pass through switch_mm from a kernel task to a user task, it catches it and
you go from state of NO CONTEXT to the correct context.

  Beat me over the head with a crowbar please if I'm missing something.

Regards,

Tom
--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
