Content-Type: text/plain;
  charset="iso-8859-1"
From: David Given <dg@tao-group.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Strange FPU/threads problem
Date: Tue, 20 Nov 2001 18:16:35 +0000
MIME-Version: 1.0
Message-Id: <0111201816350A.15049@pearl>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Context: PowerMac 8200/120, 601 processor, stock kernel 2.4.12, libc 2.2.4,
gcc 2.95.4, Debian woodyish.

I'm finding something really weird is going on with my program. It works like
this:

I can compile the program either to use threads, or not to use threads. If I
compile it so it *doesn't* use threads, it works fine.

However, if I compile it so that it *does* use threads, it bails with a
SIGFPE the first time in encounters a floating point instruction. And I don't
know why.

What's happening is that my code is shuffling long longs around, and gcc is
using the FPU as a fast way of doing this. The exact code is:

    C81F0008 0FE24468 lfd f0, 8 (r31)
    D81F0028 0FE2446C stfd f0, 40 (r31)

I've determined that the code is being executed in the primary process; that
is, it hasn't spawned any threads yet. The memory that's being pointed to is
valid.

The FP bit in the MSR is unset, so the processor thinks I'm not using the
FPU. But this should be perfectly normal, as my understanding of the kernel
suggests that it uses lazy FP setting. The kernel should hook the trap and
silently enable the FPU for me. But it's not.

I suspect that this may be a kernel bug. Any ideas?

--
David Given
dg@tao-group.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
