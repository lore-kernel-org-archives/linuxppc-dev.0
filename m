Message-ID: <3B97B8B9.115B1569@mvista.com>
Date: Thu, 06 Sep 2001 13:56:09 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Mark Hatle <fray@mvista.com>
Cc: Navin Boppuri <navin.boppuri@newisys.com>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ctrl-C does not work
References: <3A494DE356A49A40B37442E1E0D9F3B506343E@ptah.ad.newisys.com> <3B97984C.CCE09FE7@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Hatle wrote:

> .....  There is a problem with the
> way the serial consoles are started on CDK 1.0 and 1.2, it was left up
> to the serial driver to turn on or off the control-c activation.

It actually has to do with the way tty process groups are created and
signals are managed.  If you boot _any_ Linux kernel using something
like 'init=/bin/sh', ctl-C doesn't work because the process in slot 1
(normally init) is treated with special signal handling by the kernel.

> .... login has a patch that ensures that the
> control-c stuff is enabled.

Huh?  All you need to do is properly start up an interactive
session from init to get process group signal handling.  This is
just standard Linux userland stuff documented in a variety of places.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
