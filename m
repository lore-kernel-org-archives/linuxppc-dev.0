Date: Tue, 11 Feb 2003 19:07:54 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] 8xx_io/uart.c
In-reply-to: <3E491EE8.6070503@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Murray Jensen <Murray.Jensen@csiro.au>,
	linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLKECPFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > ..... Will KGDB/XMON write this early and/or
> > is KGDB/XMON guaranteed not to write a LF?
>
> Yes, yes.  Making these work, especially kgdb, was a real PITA.
> Both format their own packets/strings and expect behavior of
> reading/writing directly to a uart FIFO.  Like I said, if you really
> understand how xmon/kgdb work, you would understand why these functions
> are written exactly as they are.

I think I know why the are as they are now. KGDB/XMON stuff is messy and if you
are sure that XMON/KGDB never outputs a LF all is fine.

>
> The printk never calls a serial driver before it is fully initialized.
> Debugger serial interfaces, especially kgdb, expect a simple uart fifo
> immediately available within a few hundred lines of kernel code execution.

printk's will go out after serial_console_setup() has executed which I don't
consider "fully initialized" but it's initialized enough for printk's to get
out safely.

>
>
> > The buffer is kmalloc'ed and kmalloc always returns L1 cache aligned buffers.
> > Then  __dev_alloc_skb()/dev_alloc_skb() reserves 16 bytes in the beginning of the
> > buffer and since the L1 cache line is 16 bytes it is still L1 cache aligned.
>
> It's the data at the end of the buffer that's the problem.  The IP stack (used
> to) stores information in dynamically allocated memory that would get corrupted
> when buffers were invalidated.  There was lots of discussion about this on kernel
> and other mailing lists (like mips and arm).  After we found it, there was some
> discussion about how to fix it, but I didn't follow up on all of the details.
> To ensure this works, you have to configure a forwarding/routing multiple
> ethernet environment and get the 8xx to forward packets across the links.
> That was the failure condition, there are people using 8xx in these configurations,
> and we can't introduce a "solution" that has been known to be a problem in
> the past.
>
> > You think I just hacked this up and throwed it over the fence?
>
> No, but you could have saved yourself some time by reading the archives.
> You could have started with:
> 	http://lists.linuxppc.org/linuxppc-embedded/200008/msg00105.html
> and then:
> 	http://lists.linuxppc.org/linuxppc-embedded/200106/msg00078.html
>

Like I said, if you had given me a better hint then "the archives" we
could had resolved this long ago.

I have checked the links above it looks like it's solved. As far as I can
tell alternative:
  0. change alloc_skb()/skb_add_mtu() to force the allocated size to be a
     cache line multiple.
has been impl. in the kernel:
 - skb_add_mtu() does not exist anymore.
 - alloc_skb() does L1 cache align the size:
       size = requested_size + 16;
       size = SKB_DATA_ALIGN(size); /* this does L1 cache alignment */
       data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
   This makes the skb_shared_info to always start on a new cache line.
   There is no risk that it is invalidated by dma_cache_inv() call.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
