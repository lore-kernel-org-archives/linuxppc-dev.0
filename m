Message-ID: <3B97BC6C.D669726B@mvista.com>
Date: Thu, 06 Sep 2001 13:11:56 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: Navin Boppuri <navin.boppuri@newisys.com>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ctrl-C does not work
References: <3A494DE356A49A40B37442E1E0D9F3B506343E@ptah.ad.newisys.com> <3B97984C.CCE09FE7@mvista.com> <3B97B8B9.115B1569@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> Mark Hatle wrote:
>
> > .....  There is a problem with the
> > way the serial consoles are started on CDK 1.0 and 1.2, it was left up
> > to the serial driver to turn on or off the control-c activation.
>
> It actually has to do with the way tty process groups are created and
> signals are managed.  If you boot _any_ Linux kernel using something
> like 'init=/bin/sh', ctl-C doesn't work because the process in slot 1
> (normally init) is treated with special signal handling by the kernel.

Correct.  I should have been clearer before.

> > .... login has a patch that ensures that the
> > control-c stuff is enabled.
>
> Huh?  All you need to do is properly start up an interactive
> session from init to get process group signal handling.  This is
> just standard Linux userland stuff documented in a variety of places.

Depends on the device, the problem that was solved was /dev/console may
not be /dev/ttyS0.  It can be a number of things, which can change from
the kernel boot parameters.  So /dev/console has to be used in a generic
interface.  The patch specifically enables TIOCSCTTY on the device, this
ensures that /dev/console will in fact work as a TTY (including ctrl-c
support).  The exception to this if if you set /dev/console to be
something other then a serial device, then TIOCSCTTY will fail, and
control-c will still probably not work.  :)

So the _ACTUAL_ problem is that /dev/console does not have TIOCSCTTY
enabled by default, where as _MOST_ serial drivers do have it enabled by
default.  (Again we found a couple a while back that did not work
properly, but I don't think they were on PPC...)

So the problem in HHL Cross Dev Kit 1.0 and 1.2 was the way that the
shell was being invoked from the init program, and the device that was
being used.  This is no longer an issue w/ HHL 2.0, unless you do
init=/bin/sh, but that is a different problem!  <grin>

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
