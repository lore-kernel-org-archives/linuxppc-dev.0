Date: Mon, 15 Feb 1999 13:41:04 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Problem with iMacs and kernel entry
Message-Id: <19990215134104.006599@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've just thought about another problem:

Since the new bootx will enter the kernel with MMU disabled, no-one is
allowed to perform any kind of i/o until the MMU is re-enabled. At least
that's my understanding, since cache and speculative pre-fetching are
enabled for the whole address range, including devices.

That means that the iMac "hack" in prom.c that disables the USB
controller will get into trouble, won't it ?

I want to avoid enabling the MMU in the bootstrap to avoid the problem of
TLB misses on 603 (the boostrap has no exception handler) and I don't
like the fact that the kernel entry plays with BATs with MMU enabled.

Any comments ?

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
