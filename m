Date: Tue, 15 Jul 2003 11:43:37 -0400
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ptrace Problem
Message-ID: <20030715114337.A12505@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to get ptrace() working correctly so I can use gdbserver
so we can debug with more power than printf()'s.

The kernel is 2.4.21-rc1 with stuff done to it to support some
hardware that is under development (the chip has a 603-style core).

I can fire up gdbserver, I can attach to it with a gdb on my host.  I
can watch the little ptrace transactions go by and (after eliminating
some false leads) they all do seem to be doing sensible things.  But
when I try an "si", everything seems OK upto the _switch at which
point the kernel SIGSTOPs on a 0x0 instruction at the first
instruction of my application (or is it the second instruction?--I am
not sure, the address complained about is first+4, maybe one worked).

Once this happens my Abatron BDI-2000 is somehow hosed and can no
longer write to memory.  My next download takes all the time I would
expect, but the results are all 0x0 unless I first powercycle the
Abatron.

The kernel seems to otherwise be working quite well.  As this is new
hardware, I cannot state that it is certainly working correctly.

Obviously I suspect that something is wrong with how some memory
management data structure is set up when the ptrace calls are being
made by gdbserver, but I am not smart enough to have a clear idea of
what to look for.  (I don't want to get lost in walking page tables
and tracing TBL faulting and whatnot for another week--not if I don't
have to.)  I have tried changing from our previous gdb and gdbserver
to the Denx versions with same results.

Suggestions?


Thanks,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
