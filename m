Message-ID: <A60FFE6CA339C742BE11C311EA8BFF540164DD@mdsms2.inside.mdsroc.com>
From: "Ruhland, Paul" <PRuhland@microwavedata.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [PATCH] 8xx_io/uart.c
Date: Fri, 7 Feb 2003 11:54:11 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The pasting into the console bug is actually caused in
'drivers/char/n_tty.c' (standard tty line discipline) by not handling a
failed call to 'opost(...)' (if returns -1 if tx buffer is full and char
must be retried) in 'echo_char()'.  The pasted data is received fine....just
the echo fails.

>From 'drivers/char/n_tty.c':
================================================
/* Must be called only when L_ECHO(tty) is true. */

static void echo_char(unsigned char c, struct tty_struct *tty)
{
	if (L_ECHOCTL(tty) && iscntrl(c) && c != '\t') {
		put_char('^', tty);
		put_char(c ^ 0100, tty);
		tty->column += 2;
	} else
		opost(c, tty);
}
===============================================



-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com]
Sent: Friday, February 07, 2003 11:09 AM
To: joakim.tjernlund@lumentis.se
Cc: Linuxppc-Embedded@Lists. Linuxppc. Org
Subject: Re: [PATCH] 8xx_io/uart.c



Joakim Tjernlund wrote:

> Found a bug in the serial driver. my_console_write() uses the wrong
address in early console writes.
> Removed some warnings as well.

Well......console write doesn't get called this early.  The purpose
of these address modifications in other parts of the driver are for
kgdb using the serial port for early debugging.

I'd really like some supporting documentation (like a kernel panic
or other reproducable error) before you declare something a "bug",
along with showing the same test fixed the problem.

> Please can you change TX_NUM_FIFO to 8 and TX_BUF_SIZE to 96,
> since chars are lost when pasting text into the console otherwise.

What makes 96 a big enough number?  If you want to do this locally,
that's fine, but only flow control can guarantee you won't overflow
a serial port of any fifo depth.  I don't want to arbitrarily make
this fifo so large as there are other processing/latency/memory
tradeoffs.  The SMC is not a high performance interface and it
consumes lots of CPM cycles.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
