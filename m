Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>,
	<sensors@stimpy.netroedge.com>
Subject: RE: 8xx i2c refers to unspecified chip errata
Date: Fri, 1 Nov 2002 12:01:45 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLIEIOFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <IGEFJKJNHJDCBKALBJLLMEFNFHAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Tom

Will you apply this patch? No problems reported so far.

 Jocke

> > >
> > > Here is a patch against the PPC 2.4 devel tree for the i2c-algo-8xx.c
> >
> > Can you please split this into logical chunks, or give me a list of each
> > fix in here?  Thanks.
>
> ohh, kind of hard to remember all that went into that patch. The path
> has evoled over many days, but I can try summarize. I have tested this code
> pretty well it does not fail for me. Speed has been between 10-150KHz. The
> old code fails as soon you start to stress it a little.
>
>  - replace invalidate_dcache_range with flush_dcache_range, since buffers are
>    NOT cache aligned. flush will write to memory AND invalidate the cache.
>
>  - move the chip errata stuff from irq routine into read/write routines. Made
>    it default off since it causes lock ups on my I2C device. I think it causes
>    a too short STOP condition. If enabled I2C will behave better than before, but
>    may still cause problems if the read/write is interrupted with a signal while
>    microcode is enabled.
>
>  - set default speed to 60 KHz instead.
>
>  - missing/faulty initialization of parameter ram when I2C micro patch is active.
>
>  - replaced assingments with mask operations with relevant bits. Example:
>       /* Shut down IIC. */
>       i2c->i2c_i2mod = 0;
> 	i2c->i2c_i2mod &= ~1;
>
>  - When reading from I2C device, let the receive BD generate interrupt instead of
>    the dummy trasmit. This is important since the TX interrupt will be too early sometimes, before
>    the RX BD has closed. There is one case where the RX irq is before the TX irq, if iic_mrblr is set
>    to match the number of bytes to read. Therefore must the iic_mrblr be one byte larger than
>    the expected number of bytes.
>
>  - busy wait for small transfers since it's faster.
>
>  - save_flags(flags); cli(); cleanups
>
>  - interruptible_sleep_on_timeout() instead of interruptible_sleep_on() so it won't hang forever if an
>    irq is lost.
>
>  Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
