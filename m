Date: Wed, 11 Jun 2003 02:22:15 -0400
From: Bill Fink <billfink@mindspring.com>
To: Robert Schwebel <robert@schwebel.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: init does not run on 405GP system
Message-Id: <20030611022215.572055d2.billfink@mindspring.com>
In-Reply-To: <20030611045351.GA20132@pengutronix.de>
References: <20030610232157.2f012435.billfink@mindspring.com>
	<20030611045351.GA20132@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 11 Jun 2003, Robert Schwebel wrote:

> On Tue, Jun 10, 2003 at 11:21:57PM -0400, Bill Fink wrote:
> > This is probably not the issue, but you do have CONFIG_BINFMT_ELF
> > enabled in the kernel, don't you (although I would assume you would
> > get some kind of kernel error message when you tried to exec /sbin/init
> > if CONFIG_BINFMT_ELF wasn't enabled).
>
> The option is always defined y for PowerPC, you cannot deselect it. But
> I've checked it anyway ;)

One other simple thing to try if you haven't already is the kernel
boot parameter init=/bin/bash.  Also make sure any necessary shared
libraries are available at boot time.  On my system:

gwiz% ldd /sbin/init
        libc.so.6 => /lib/libc.so.6 (0x0fea0000)
        /lib/ld.so.1 => /lib/ld.so.1 (0x30000000)

Also on my system:

gwiz% strings - /sbin/init | grep '^/'
/lib/ld.so.1
/e=
/sbin/init
/dev/console
/dev/tty0
/dev/null
/etc/ioctl.save
/etc/initscript
/bin/sh
/etc/inittab
/etc/initrunlvl
/var/log/initrunlvl
/dev/initctl
/etc/powerstatus
/var/run/utmp
/var/log/wtmp
/var/run/utmp
/sbin/sulogin

Your system may be slightly different.  Perhaps the absence of one of
these may cause init to die (although not all of them exist even on my
system).

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
