Message-ID: <39E26AD6.1933322F@mvista.com>
Date: Mon, 09 Oct 2000 18:03:18 -0700
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
MIME-Version: 1.0
To: clark@esteem.com
CC: Wolfgang Denk <wd@denx.de>, ppcboot-users@lists.sourceforge.net,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet Trouble
References: <1.5.4.32.20001010000239.006b54d8@pop.esteem.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>         Right now I think that it can't talk to the console or init uses a
> function in ld.so.1 to spit a message to the console and is failing to load
> the library correctly. Does PPCBOOT tell the kernel to use its console or do
> I need to do that somehow? I have tried to stick "console=/dev/ttyS00" in
> the bootargs but then I don't get any messages after the uncompresssing
> kernel message.
Unless its a typo, try "console=/dev/ttyS0" (1 zero, not 2).

Also, if its just a console print problem, you should still be able to
telnet into the box and do things like "cat <file> > /dev/ttyS0" and
"od -x /dev/ttyS0", just to show that the serial device is good and
the problem is with the console device attached to the serial port.

Your console,tty should look something like this:

> ls -l console ttyS0
crw-------   1 root     root       5,   1 Aug  4 10:34 console
crw-------   1 root     tty        4,  64 Aug  4 10:34 ttyS0

I also like to use the following inttab file, instead of
default we ship.   It means there are more places for problems
to exist, but I've seen direct bash drop errors that getty
picks up, like "serial input buffer overrun".

> cat etc/inittab
id:3:initdefault:

# System initialization.
si::sysinit:/etc/rc.sysinit

# Single user shell
1:2345:respawn:/sbin/getty console DT9600 linux

l0:0:wait:/sbin/halt -dip
l1:1:wait:/etc/rc.d/rc 1
l2:2:wait:/etc/rc.d/rc 2
l3:3:wait:/etc/rc.d/rc 3
l4:4:wait:/etc/rc.d/rc 4
l5:5:wait:/etc/rc.d/rc 5
l6:6:wait:/sbin/reboot -dip

> cat etc/default/getty
CLEAR=NO


--
Michael Pruznick, michael_pruznick@mvista.com, 408-328-9215
MontaVista Software, 490 Potrero Ave, Sunnyvale, CA 94085
http://www.hardhatlinux.com, V:408-328-9200, F:408-328-9204

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
