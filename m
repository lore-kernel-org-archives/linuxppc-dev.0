Message-ID: <3A75C579.F3E637FD@mvista.com>
Date: Mon, 29 Jan 2001 14:33:13 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Roland Dreier <roland@topspincom.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Sandpoint 8240 or 7400
References: <524rylvl3d.fsf@love-boat.topspincom.com> <3A722CA1.3EAE82AF@mvista.com> <52u26iut9s.fsf@love-boat.topspincom.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Roland Dreier wrote:

> That would be great.  Let me know when you get a chance to do that.

I worked on it about 40 hours this past weekend, still no go.  The
problem for me still continues to be interrupt routing on this board.
The 8240 or 107 have the EPIC, which is like OpenPIC but not really.
This is further complicated by the 8259 cascade, which the OpenPIC
code assumes is configured a particular way, but doesn't work on
Sandpoint.  It is just a problem of using standard functions and
making the interrupts line up correctly.  Pain in the ass.  The whole
Linux interrupt management is just plain stupid (there is more to
the world than PCs with hardcoded 8259s).

> Out of curiousity, what is different about the Sandpoint that requires
> changes in the kernel?

Ummm, like it is a different board than anything else supported?  We
can use lots of the same code, you just may have to call functions
with slightly different parameters for set up.

I discovered the newer versions of DINK (I'm using 12.0) don't need
any special download program.  I just use 'cu', set the baud rate
to 38400, and just 'cat file_to_download > /dev/cua0'.  The processors
and code are fast enough to just suck it up and write it to memory (I
would hope so, too :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
