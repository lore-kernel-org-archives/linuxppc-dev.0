Date: Wed, 8 Sep 1999 11:03:29 +1000
Message-Id: <199909080103.LAA02277@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: hozer@drgw.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.4.04.9909070126490.14821-100000@narn.drgw.net> (message
	from Troy Benjegerdes on Tue, 7 Sep 1999 01:44:38 -0500 (CDT))
Subject: Re: ioremap (still?) broken
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.04.9909070126490.14821-100000@narn.drgw.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes <hozer@drgw.net> wrote:

> The alteon driver does an 'ioremap' on the address provided by the kernel
> PCI services, and then expects to be able to access the PCI card's memory
> via accessing the memory returned using 'readl,writel'.

That should work.

> The first thing the driver does is check the card version by reading a
> particular register. By using appropriate printf's, I have found that the
> value returned is '0xffffffff'. (defininitely NOT the register it's
> looking for)

Possibly you may need to enable PCI memory or I/O space responses in
the PCI command register in the card's configuration space.

> Before I go on a wild chase again, could someone let me know whether the
> 2.2.12 kernel might have a better chance with this, or will I need to go

I just checked in a fix to ioremap in the vger 2.2 branch which fixes
the case where the mapping added by ioremap is the first in a 4MB
region.  You would be getting kernel DSI exceptions (page faults) if
you had hit that bug, though.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
