Message-Id: <200009282107.XAA00763@piglet.grunz.lu>
Date: Thu, 28 Sep 2000 23:07:30 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
To: gewrgiou@imbc.gr
cc: rshapiro@bbn.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.21.0009282015220.15193-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  28 Sep, this message from Kostas Gewrgiou echoed through cyberspace:
> PS> Any ideas why writing to a disabled pci device in ppc crashes
> the machine but not the x86 ones ? Is this something that can be fixed
> in the kernel or an arch thing ?

Accessing config registers or device resources?

Accessing config registers should work ok, if not, there's something
_really_ wrong somewhere.

Accessing resources that are not enabled, yes, you get a machine check,
because the device will not answer your accesses, so the bus will hit a
timeout, which will be signaled to the processor (was that a PCI master
abort?), in a way that the processor will throw a machine check
exception.

And that machine check exception is not recovered from (would that even
be possible?), hence a plain old kernel panic.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
