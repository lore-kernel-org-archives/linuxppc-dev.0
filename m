Date: Wed, 19 Feb 2003 09:43:47 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] 8xx_io/uart.c
In-reply-to: <3E43DA00.7030808@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLOEGFFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Dan Malek
> Joakim Tjernlund wrote:
> > Please can you change TX_NUM_FIFO to 8 and TX_BUF_SIZE to 96,
> > since chars are lost when pasting text into the console otherwise.
>
> What makes 96 a big enough number?  If you want to do this locally,
> that's fine, but only flow control can guarantee you won't overflow
> a serial port of any fifo depth.

The fix I posted for drivers/char/n_tty.c is buggy w.r.t looking and
noone wants to play with the tty layer since it is a mess.

So I have been looking into what can be done in the uart.c.
opost_block(in n_tty.c) will never write more that 80 chars in
one go so it makes sense if we can match that size(TX_BUF_SIZE >= 80).
That should not be a problem since this memory is allocated with
m8xx_cpm_hostalloc()and the only user that function is uart.c

Increasing TX_NUM_FIFO to 8 is not big deal either IMHO.
Possibly one could let serial_console_setup allocate all the
BDs that is needed and make rs_8xx_init() reuse them. That
will save 24 bytes(3 BDs) from dp memory. This may be tricky though.

Another thing that will help is to make rs_8xx_put_char() build
a transmit queue and impl. rs_8xx_flush_chars() to actually write
them. I have tested this and it helps but it won't solve all cases.

What do you think?

> I don't want to arbitrarily make
> this fifo so large as there are other processing/latency/memory
> tradeoffs.  The SMC is not a high performance interface and it
> consumes lots of CPM cycles.

  I can't see the processing and latency implications.

   Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
