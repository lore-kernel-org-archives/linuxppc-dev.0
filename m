Date: Wed, 13 Jan 1999 10:32:49 +1100
Message-Id: <199901122332.KAA15373@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: linuxppc-dev@lists.linuxppc.org
CC: Hubert.Figuiere@solsoft.fr
In-reply-to: <Pine.LNX.3.96.990112141237.3746A-100000@globegate.utm.edu>
	(marsmail@globegate.utm.edu)
Subject: Re: Porting to NuBus PowerMacs
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.96.990112141237.3746A-100000@globegate.utm.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David A. Gatwood <marsmail@globegate.utm.edu> wrote:

> Beyond that, it will also require changes to irq.c to handle the interrupt
> controller and a lot of code for DMA, if that's desired (I don't think
> it's even remotely similar, AFAICT).  Of course, that stuff can be
> obtained from Mach, but it'll be a lot of work.  Oh, and the i/o base

I gather that DMA is not cache-coherent on the NuBus powermacs, which
opens a whole new can of worms... it means you have to do explicit
flush/invalidate requests, but it also means that you *have* to make
sure that the cpu isn't accessing any words in any of the cache lines
that the dma controller is accessing.  If the dma buffer isn't
cacheline-aligned, and is preceded or followed by unrelated stuff, you
are in trouble.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
