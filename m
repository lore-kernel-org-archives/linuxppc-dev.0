Date: Fri, 07 Feb 2003 18:21:32 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] 8xx_io/uart.c
In-reply-to: <3E43DA00.7030808@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLCEBAFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > Found a bug in the serial driver. my_console_write() uses the wrong address in early console writes.
> > Removed some warnings as well.
>
> Well......console write doesn't get called this early.  The purpose
> of these address modifications in other parts of the driver are for
> kgdb using the serial port for early debugging.

Early printk's will call it too.

>
> I'd really like some supporting documentation (like a kernel panic
> or other reproducable error) before you declare something a "bug",
> along with showing the same test fixed the problem.

I can not reproduce an error. 3-4 times I experienced a hang after "calibrating delay loop ..."
which I can't explain.

Now, why do you do the same thing just a few lines up if it wasn't needed?

How about checking your own facts and provide an accurate analysis before
bitching at me for trying to help out?

>
> > Please can you change TX_NUM_FIFO to 8 and TX_BUF_SIZE to 96,
> > since chars are lost when pasting text into the console otherwise.
>
> What makes 96 a big enough number?  If you want to do this locally,
> that's fine, but only flow control can guarantee you won't overflow
> a serial port of any fifo depth.  I don't want to arbitrarily make
> this fifo so large as there are other processing/latency/memory
> tradeoffs.  The SMC is not a high performance interface and it
> consumes lots of CPM cycles.

I tested my how much I had increase them until I didn't lose any chars.
I don't think this has anything to do with HW flow control. The
smc runs out of BD's when trying to echo back the chars.

I don't see how this would consume more CPM cycles. Yes, it will use
a little more dpram but there is room for it.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
