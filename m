Message-ID: <3B8A96FD.49F70C62@mvista.com>
Date: Mon, 27 Aug 2001 14:52:45 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Linix PPC Emmbedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: support for only 255 processes on a 405
References: <3B8A3145.8F73BDA2@raleigh.ibm.com> <3B8A8E16.B26A9254@mvista.com> <3B8A8FEC.172413E5@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:

> Perhaps i dont understand.  It looks like from the code that process id
> and pids dont match.  Could you explain how this code works.

The "contexts" are associated with an MM context, not with a process ID.
Typically a process has one MM context, but there are cases (like
multithreaded address spaces) that will share an MM context and all
get the same TLB context.  A "process" is somewhat blurry in Linux,
but you can still think of it as an address space plus a processor
thread.  We are really concerned what happens to the address space
and how that affects the MMU, not what the thread actually does,
or how many share the address space.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
