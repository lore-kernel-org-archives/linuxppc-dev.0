Message-ID: <3C8DCA26.9090708@embeddededge.com>
Date: Tue, 12 Mar 2002 04:28:06 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jeremy Rosen <Jeremy.Rosen@au.thalesgroup.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SPI driver for m8xx
References: <sc8e18c0.080@gw_tms_syd2.pty.tms.thomson-csf.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jeremy Rosen wrote:

> for the TX and RX buffer, they use memory they get for
> m8xx_cpm_hostalloc... why ?

It's convenient for small, uncached buffer space.  Don't be allocating
large (more than 32-64 bytes) out of this space, as there is only a
page or two shared among all CPM devices.  This is normally used for
things like SCC/SMC UART "FIFOs".

> Does it have something to do with the MMU ?

No, but with caches.

> I would like to avoid doing that, is their a way to use normal ( kernel
> space) memory ?

An alternate and proper approach is to use consistent_alloc().  This will
allocate page size memory, aligned on page boundaries, with cache disabled.
You must use the virtual/physical addresses returned from this function
and keep track of them in the driver.  The virt_to_* or __va/__pa() macros
won't work.

A third approach is to allocate kernel memory either with kmalloc() or
getpages().  This is not cache coherent with CPM DMA, so you need to
call the cache flush/invalidate functions to manage this space.

All of these have advantages and disadvantages you need to trade off in
your design.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
