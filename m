To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Console on SMC2 (was: Re: MPC823 Serial ports)
References: <38107697.9A2576F7@eng.uct.ac.za> <3810A961.FF50C5F8@netx4.com> <kfypuy4sz1p.fsf_-_@kieraypc01.p.y.ki.era.ericsson.se> <38133CB5.61A6433B@netx4.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 25 Oct 1999 15:57:08 +0200
In-Reply-To: Dan Malek's message of "Sun, 24 Oct 1999 13:07:01 -0400"
Message-ID: <kfyr9ijr1aj.fsf@kieraypc01.p.y.ki.era.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@netx4.com> writes:

> Marcus Sundberg wrote:
> 
> > Speaking of SMCs and CVS, attached is a diff adding support for
> > having the boot console on SMC2. Currently I just set
> > CONFIG_SERIAL_CONSOLE_PORT in asm/board.h, but maybe it should be
> > a configuration option?
> 
> Yes, I am working on that.  It will appear in my next CVS update.
> I have tried many different versions, and it appears the one
> that works the best is just a simple ask the questions version.
> I tried to make it smart about processor versions, what you
> are using for Ethernet, etc., and in the end the only one that
> seems to work is asking the individual questions about how you
> want ports configured.

It would be nice if we had "Board default" as an option for
the boot console (or as an alternative - make Config.in set
the correct default device when you change boards).

> I also have code for consoles on the SCC ports, and it needs a
> little more testing.  I have a board showing up this week that
> should allow me to test that properly.

I hope you will include an option to completely disable serial
ports on SCCs without changing uart.c too?

> > In uart.c I also fixed the major device of the console.
> 
> The console (as in /dev/console) is currently a symbolic
> link to the appropriate /dev/ttySx.

Well, not on any correct system running 2.1.71 or later. ;)

> Should we change that to be dynamically allocated?

I'm already running with /dev/console == char (5,1) as should be.
It works fine with 8xx kernels regardless of whether TTYAUX_MAJOR
or TTY_MAJOR is used for the console, except that I get the
	"tty_io.c: process %d (%s) used obsolete /dev/%s - "
	"update software to use /dev/ttyS%d\n"
warning when my init script starts if it uses TTYAUX_MAJOR.

> > TTYAUX_MAJOR corresponds to the /dev/cua* devices, which are obsolete.
> 
> Yes, but be careful we need to change the device nodes in the
> file systems......

That should be done anyway, but is it really mandatory?
Would anything break for people who have /dev/console as a symlink
if the console used TTY_MAJOR instead?

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
