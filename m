Message-ID: <3E491EE8.6070503@embeddededge.com>
Date: Tue, 11 Feb 2003 11:03:52 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Murray Jensen <Murray.Jensen@csiro.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] 8xx_io/uart.c
References: <IGEFJKJNHJDCBKALBJLLIECLFKAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> ..... Will KGDB/XMON write this early and/or
> is KGDB/XMON guaranteed not to write a LF?

Yes, yes.  Making these work, especially kgdb, was a real PITA.
Both format their own packets/strings and expect behavior of
reading/writing directly to a uart FIFO.  Like I said, if you really
understand how xmon/kgdb work, you would understand why these functions
are written exactly as they are.

The printk never calls a serial driver before it is fully initialized.
Debugger serial interfaces, especially kgdb, expect a simple uart fifo
immediately available within a few hundred lines of kernel code execution.


> The buffer is kmalloc'ed and kmalloc always returns L1 cache aligned buffers.
> Then  __dev_alloc_skb()/dev_alloc_skb() reserves 16 bytes in the beginning of the
> buffer and since the L1 cache line is 16 bytes it is still L1 cache aligned.

It's the data at the end of the buffer that's the problem.  The IP stack (used
to) stores information in dynamically allocated memory that would get corrupted
when buffers were invalidated.  There was lots of discussion about this on kernel
and other mailing lists (like mips and arm).  After we found it, there was some
discussion about how to fix it, but I didn't follow up on all of the details.
To ensure this works, you have to configure a forwarding/routing multiple
ethernet environment and get the 8xx to forward packets across the links.
That was the failure condition, there are people using 8xx in these configurations,
and we can't introduce a "solution" that has been known to be a problem in
the past.

> You think I just hacked this up and throwed it over the fence?

No, but you could have saved yourself some time by reading the archives.
You could have started with:
	http://lists.linuxppc.org/linuxppc-embedded/200008/msg00105.html
and then:
	http://lists.linuxppc.org/linuxppc-embedded/200106/msg00078.html

After the problems with the 405gp and tulip driver I started looking around
at the other lists and asking network folks for solutions. They didn't have
any and suggested non coherent processors not dma into skbuffers.  We are
fortunate on 8xx that the driver is only used on this processor, so if we
can find some solution it doesn't have to work generically for others.  The
networking folks suggested the only solution was to give skbuf allocators
knowledge of cache line sizes, but that was never pursued as far as I know.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
