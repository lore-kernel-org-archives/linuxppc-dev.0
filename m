Date: Mon, 15 Feb 1999 16:55:18 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>
Subject: Re: Problem with iMacs and kernel entry
In-Reply-To: <19990215134104.006599@mail.mipsys.com>
Message-ID: <Pine.HPP.3.96.990215164341.5352k-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 15 Feb 1999, Benjamin Herrenschmidt wrote:

> I've just thought about another problem:
> 
> Since the new bootx will enter the kernel with MMU disabled, no-one is
> allowed to perform any kind of i/o until the MMU is re-enabled. At least
> that's my understanding, since cache and speculative pre-fetching are
> enabled for the whole address range, including devices.

Indeed, unless you disable the d-cache, but this creeates another series
of problems for 601 processors for which the cache can't be controlled
(you can work around with special direct-store segments but let's keep
things simple and processor independant in a bootloader).

> That means that the iMac "hack" in prom.c that disables the USB
> controller will get into trouble, won't it ?

Very likely. 

> I want to avoid enabling the MMU in the bootstrap to avoid the problem of
> TLB misses on 603 (the boostrap has no exception handler) and I don't
> like the fact that the kernel entry plays with BATs with MMU enabled.

Well, in prepboot the MMU is enabled for a lot of reasons. This requires
the installation of 603 TLB miss handlers (which are well tested since I
only have 603), then I play with a lot of I/O (including complete
reconfiguration of PCI I/O and memory spaces to work around braindead PreP
firmware: I don't want to sacrifice 256 Mb to PCI I/O) and disable the MMU
before passing control to the kernel.  So it's doable. There are also some
documents about how to perform a smooth transition of MMU management
between OF and client program.  I wanted to implement this but am lacking
time right now.

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
