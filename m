Message-ID: <3E43DA00.7030808@embeddededge.com>
Date: Fri, 07 Feb 2003 11:08:32 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] 8xx_io/uart.c
References: <IGEFJKJNHJDCBKALBJLLKEALFKAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> Found a bug in the serial driver. my_console_write() uses the wrong address in early console writes.
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
