Date: Mon, 5 Nov 2001 01:26:42 -0500 (EST)
Message-Id: <200111050626.fA56Qg5444874@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think it is important to allow for fast booting.
That means both full boot and unsuspend. There should
be a minimum of overhead on an embedded system.

As far as I'm concerned:

The kernel just appears in memory, MMU off, at address zero.
The hardware can handle this. (example: the motherboard chips
know to pull the kernel out of a serial EEPROM)

The kernel might be expected to start from address 0x100 after
a hard reset. There shouldn't be any need to create all sorts
of data structures in memory just to boot the kernel. When the
motherboard says "go", you're at 0x100 without a stack pointer.
You start with "nop ; nop ; isync ; nop" and load the MSR.

Memory might be cleared already, including BSS. It would be
bad to waste time clearing memory that is already cleared,
so memory clearing should be optional.

Uncompressing is bad. Even if I wish to use compression, I may
prefer to have a ROM or service processor handle the job.
Copying is bad too. It would be nice to get boot times down
to well under a second.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
