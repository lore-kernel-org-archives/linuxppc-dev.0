Content-Type: text/plain;
  charset="iso-8859-1"
From: David Given <dg@tao-group.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Strange FPU/threads problem
Date: Fri, 23 Nov 2001 17:08:47 +0000
References: <0111201816350A.15049@pearl>
In-Reply-To: <0111201816350A.15049@pearl>
MIME-Version: 1.0
Message-Id: <01112317084703.18383@pearl>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday 20 November 2001 18:16, David Given wrote:
[...]
> However, if I compile it so that it *does* use threads, it bails with a
> SIGFPE the first time in encounters a floating point instruction. And I
> don't know why.
[...]

I've done some more research. The thing that's causing the exception is
arch/ppc/kernel/traps.c+291 (for Linux version 2.4.15), claiming an IEEE FP
exception. The relevant code is:

        if (regs->msr & 0x100000) {
                /* IEEE FP exception */
                _exception(SIGFPE, regs);
        }

Now, my copy of the 601 manual claims that only bits 27 to 16 of the MSR are
defined, which translates to bits 5 to 15 in the real world, because the 601
manual numbers the bits the wrong way round throughout[1]. Which means that
bit 20, above, is undefined. MSR turns out to be:

	00010F930

What *is* that bit 20? According to the MSR, the FPU is enabled, FE0=FE1=1
(precise mode)... could the processor be generating the exception because the
thing being loading into the FPU isn't a valid double? In which case, how
come my code works when threads are disabled?

I could really use some help here.


[1] DIE DIE DIE

--
David Given
dg@tao-group.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
