Message-ID: <39D21A61.445CC61F@mvista.com>
Date: Wed, 27 Sep 2000 12:03:45 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Rob Taylor <robt@flyingpig.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: switching linux kernels
References: <001801c02865$c71c1c10$b400a8c0@eventhorizon>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rob Taylor wrote:

> presumably this is due to int in/out macros adding _IO_BASE to the pointer?

Yes.

> ... So
> am I right in thinking that it makes sense to use in/out for ISA accesses (if
> _IO_BASE is set correctly for your platform) and readb/writeb/.. for the rest of
> your memory mapped registers?


Well, yes, today.  Some of us have been "fighting" about this lately.
I'm not a fan of address arithmetic in the inb/outb, so probably on
8xx and 82xx you will always have some "opaque" handle to in/out that
doesn't resemble any notion of x86 "ports".  The reason is that on
these 8xx and 82xx systems (and potentially others) we don't have very
flexible host bridges, or the processors are used in complex multiple
PCI bus configurations where the notion of "bus 0" may not exist.  You
can't assume using a hard coded (or legacy) port number will get you
anywhere but a bus fault.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
