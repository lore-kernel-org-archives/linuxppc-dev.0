Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <4063D300.2060006@embeddededge.com>
Date: Fri, 26 Mar 2004 01:51:44 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Mode Software Emulation NIP: 00001FFC - cache coherency
 problem on m8xx processors
References: <20040325231357.GA22460@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcelo Tosatti wrote:

> We encountered a problem with our MPC855T based appliances under heavy
> load. The crashes looked like this:

> The kernel crashed trying to execute address "00001FFC". I have seen similar
> reports on linux PPC lists archives. The problem is that "bl transfer_to_handler"
> (transfer_to_handler is at "2000") was jumping to "1FFC" instead, in some rare ocasions
> (only under heavy network/memory activity).

Here is my standard answer to bad things happening under heavy network
activity.  Something is likely wrong with the SDRAM UPM Burst Mode programming.
The only way you can get back to back burst mode bus operations is with the
core very busy and the CPM or FEC performing DMA.  Neither one on their own
can generate this special case bus cycle.  I've seen this myself, and the
cause was always the same.  It's a PITA to debug, but I still suspect that is
the problem.

I don't remember the details of our IRC discusson, but one thing I would suggest
to test this is setting the Burst Inhibit (BI) flag in the memory controller
for the SDRAM chip select.

> After thinking for a while and talking to Dan Malek, it seems "isync" instructions before
> "bl transfer_to_handler" are required to avoid cache coherency problems.

I was actually thinking of a different interrupt controller problem.  I am
surprised this works.  This isn't a cache coherency problem.

> I'm not exactly sure why we were jumping to "1FFC" instead of "2000",
> but adding "isync" before "bl transfer_to_handler" in both DecrementTimer
> and HardwareInterrupt fixed the problem for us.

That's just too weird.  We need to understand why this happens.  Here is another
test.  At about line 652, change the:

	. = 0x2000

to:

	. = 0x1ffc
	nop

Let's see if it happens to jump to any other location or if this one is
special.

> On the following patch against 2.4.25 I also add "isync" .....

Let's put a big comment around this.  Indicate it was a problem for
one person with an 855T.  I don't have any 855T parts, if anyone else has
some and can do some heavy network testing, I'd appreciate knowing the
results.  Like I keep saying, I've seen similar problems on the 860T parts,
but it was clearly my fault programming the UPM.  Once that was fixed,
problem solved.


Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
