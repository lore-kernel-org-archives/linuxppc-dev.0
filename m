Date: Mon, 12 Apr 1999 14:38:40 +1000
Message-Id: <199904120438.OAA20237@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: kbhend@business.wm.edu
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <v03010d00b336681cf21c@[209.96.179.223]> (kbhend@business.wm.edu)
Subject: Re: PPC Kernel Gurus Help?
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <370E71B0.577788B0@synxis.com> <v03010d00b336681cf21c@[209.96.179.223]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin B. Hendricks <kbhend@business.wm.edu> wrote:

> Unfortunately, things are not working very reliably.  I was looking in the
> PPC Programmers Environment Manual found that in section 6.3 it specifies
> that the operating system when process switching should do an stwcx.
> instruction to a nonsense EA to clear any reservations held by the
> processor before starting the new process.
> 
> Is this being done in Linux PPC kernels?

In fact, recent kernels do a dummy stwcx. on every entry to the
kernel, not just on context switches.  If you want to check the kernel
source you're using, look for a stwcx. in the transfer_to_handler
routine in arch/ppc/kernel/head.S.

> Does anything special have to be done for threads created with the clone
> system call?

Not AFAICS, since you have to enter the kernel to switch from one
thread to another.  If you have a user-level threads implementation,
it should do a dummy stwcx. in the context-switch code.

> What about in signal handlers?  If a signal handler is invoked in the
> middle of the lwarx/stwcx. instruction pairs, should the handler be
> clearing the reservation bit?

Yes.

> Should we be clearing the reservation using an stwcx. instruction in the
> sigsetjmp / longjmp calls because they are often used to longjmp out of
> signal handlers which in turn might result in a mispaired ldwarx/stwcx. set
> of instructions similar to a process switch?

It is maybe worth considering doing a dummy stwcx. in [sig]longjmp.
However, the reservation should have been cleared by the time you get
into a signal handler anyway, so the only time you should see a
problem is if you do an explicit longjmp between the lwarx and
stwcx. :-)

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
