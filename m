Message-ID: <3C59B86A.E24F89A1@mvista.com>
Date: Thu, 31 Jan 2002 13:34:34 -0800
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: gopi@india.tejasnetworks.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: why is tty->pgrp set to -1 for console?
References: <Pine.LNX.4.21.0201312050570.1490-100000@tn100build.india.tejasnetworks.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


gopi@india.tejasnetworks.com wrote:
>   What is the correct procedure to follow to get around this problem
> and get ctrl-c working on console?

It looks like everyone is taking a swing at this one, so I think I'll
join in.  First off, the easiest way I've found to track down why
ctrl-c doesn't work is to just run "ps -j".  For ctrl-c to work, you
need a controlling terminal (the TTY column) and a process group.  If
you have a '?' in the TTY column, ctrl-c won't work.  In the past I
have seen this happen because of this code in drivers/char/tty_io.c:
        if (device == SYSCONS_DEV) {
                struct console *c = console_drivers;
                while(c && !c->device)
                        c = c->next;
                if (!c)
                        return -ENODEV;
                device = c->device(c);
                filp->f_flags |= O_NONBLOCK; /* Don't let /dev/console block */
                noctty = 1;
        }
Note that O_NOCTTY (no controlling terminal) is forced on whenever
/dev/console is opened (noctty = 1).  Possible workarounds:
  1) Run getty on something other than /dev/console.  For example,
     if you console is on the first serial port, run getty on /dev/ttyS0.
     I believe this is the "correct" answer.
  2) You could also change getty to do a TIOCSCTTY ioctl explicitly after
     it has opened the terminal.
  3) You could remove the forcing of noctty on from tty_io.c

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
