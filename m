Message-Id: <v03010d00b336681cf21c@[209.96.179.223]>
In-Reply-To: <19990411150328.032219@mail.mipsys.com>
References: <370E71B0.577788B0@synxis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 11 Apr 1999 11:07:02 -0400
To: linux-pmac@samba.anu.edu.au, gdt@linuxppc.org,
        linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Subject: PPC Kernel Gurus Help?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have been trying to track down deadlocks in linuxthreads code when using
semaphores.  The semaphores are implemented using the lwarx and stwcx.
instructions to create both a testandset and compare_and_swap type of
intructions.

Unfortunately, things are not working very reliably.  I was looking in the
PPC Programmers Environment Manual found that in section 6.3 it specifies
that the operating system when process switching should do an stwcx.
instruction to a nonsense EA to clear any reservations held by the
processor before starting the new process.

Is this being done in Linux PPC kernels?

Does anything special have to be done for threads created with the clone
system call?

What about in signal handlers?  If a signal handler is invoked in the
middle of the lwarx/stwcx. instruction pairs, should the handler be
clearing the reservation bit?

Should we be clearing the reservation using an stwcx. instruction in the
sigsetjmp / longjmp calls because they are often used to longjmp out of
signal handlers which in turn might result in a mispaired ldwarx/stwcx. set
of instructions similar to a process switch?

Use of these instructions lwarx/stwcx. is not something I am up on.  I have
been trying to understand things from reading the PPC manuals from Motorola
and IBM but the answers to my questions above were not clear.

Any help here would be greatly appreciated?  Am I barking up the wrong tree?

Thanks,

Kevin





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
