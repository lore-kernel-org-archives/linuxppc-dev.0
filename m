Subject: Re: stack frame for interrupts/exceptions in PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tameen Khan <tameen@cisco.com>
Cc: "'linuxppc-dev list'" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <006001c42cbd$b07e12f0$273147ab@amer.cisco.com>
References: <006001c42cbd$b07e12f0$273147ab@amer.cisco.com>
Content-Type: text/plain
Message-Id: <1083118036.20092.30.camel@gaston>
Mime-Version: 1.0
Date: Wed, 28 Apr 2004 12:07:16 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-04-28 at 11:11, Tameen Khan wrote:
> I am tryting to implement kernel backtracing for PPC.

What do you mean ? There is already working backtrace code in the
kernel, both in the Oops code and in xmon.

> I need to understand how the process kernel stack/interrupt stack is managed
> for PPC in the event of interrupts and exceptions.
> ANY pointer to docs/code etc explaining above topic will be appreciated.

Look at xmon code :) You can find the docs for the ppc32 strackframe in
the SysV ABI or the LSB (Linux Standard Base). You can also look at
gcc's rs6000.{c,h}, there are some nice ascii art in there.

> What is STACK_FRAME_OVERHEAD_PPC used for??? Its defined to be 16 for PPC
> and 112 for PPC64.

It's the location of the pt_regs on the stack frame. When taking an
interrupt, we lower SP by the INT_FRAME_SIZE (that also accounts for
the redzone) and we store the registers at SP + STACK_FRAME_OVERHEAD,
this "overhead" is the size of a minimum caller stackframe, large enough
for the callee to store whatever it may store in the parent stackframe
without affecting the pt_regs values.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
