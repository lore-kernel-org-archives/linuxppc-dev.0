Date: Fri, 17 Sep 1999 10:36:58 +1000
Message-Id: <199909170036.KAA13072@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: linuxppc-dev@lists.linuxppc.org
In-reply-to: <199909160722.JAA00359@piglet.cpu.lu> (message from Michel
	Lanners on Thu, 16 Sep 1999 09:22:41 +0200 (CEST))
Subject: Re: stty < /dev/modem blocks???
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199909160722.JAA00359@piglet.cpu.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners <mlan@cpu.lu> wrote:

> OK, this sounds right, but how do you explain that I can get at the tty
> settings with
> 
> stty -a < /dev/ttySx
> 
> for both of my serial ports, with absolutely nothing connected to them?

It depends on the state of the CLOCAL flag.  If it's set, which is
the default on boot, you can open it without waiting.  If it's clear,
an open will normally block until the CD (carrier detect) input is
asserted.  (To open it without waiting when CLOCAL is clear, you put
O_NONBLOCK in the flags on the open system call.)

When you run pppd, it will normally clear the CLOCAL flag (unless you
give it the `local' option), so that it can tell when the modem hangs
up.  It tries to restore the settings on exit, but this can fail if
the modem has already hung up, since after a hangup, the linux tty
driver won't let you do anything at all with the fd you had open to
the tty except close it.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
