Message-ID: <38133CB5.61A6433B@netx4.com>
Date: Sun, 24 Oct 1999 13:07:01 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: Dan Malek <dan@penguin.netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Console on SMC2 (was: Re: MPC823 Serial ports)
References: <38107697.9A2576F7@eng.uct.ac.za> <3810A961.FF50C5F8@netx4.com> <kfypuy4sz1p.fsf_-_@kieraypc01.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:


> Speaking of SMCs and CVS, attached is a diff adding support for
> having the boot console on SMC2. Currently I just set
> CONFIG_SERIAL_CONSOLE_PORT in asm/board.h, but maybe it should be
> a configuration option?

Yes, I am working on that.  It will appear in my next CVS update.
I have tried many different versions, and it appears the one
that works the best is just a simple ask the questions version.
I tried to make it smart about processor versions, what you
are using for Ethernet, etc., and in the end the only one that
seems to work is asking the individual questions about how you
want ports configured.

I also have code for consoles on the SCC ports, and it needs a
little more testing.  I have a board showing up this week that
should allow me to test that properly.


> In uart.c I also fixed the major device of the console.

The console (as in /dev/console) is currently a symbolic
link to the appropriate /dev/ttySx.  Should we change that to
be dynamically allocated?

> TTYAUX_MAJOR corresponds to the /dev/cua* devices, which are obsolete.

Yes, but be careful we need to change the device nodes in the
file systems......



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
