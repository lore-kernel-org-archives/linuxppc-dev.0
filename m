Message-Id: <200103201258.NAA23409@scully.gams.co.at>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
cc: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: losing interrupts - printk is bad 
In-reply-to: Your message of "Mon, 19 Mar 2001 18:12:50 +0100."
             <3AB63E12.6D38973E@esd-electronics.com>
Reply-To: mike@gams.at
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Mar 2001 13:58:40 +0100
From: Mike Neuhauser <mike@gams.at>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3AB63E12.6D38973E@esd-electronics.com>, Matthias Fuchs writes:

  [stuff about losing interrupts during printk to serial console deleted]

> Second, could anybody explain t ome, what klogd is doing ? It would be
> glad to get klogd read all the debugging output from the kernel and
> output the data from user space (well buffered and not blocking the
> whole system). It seems that klogd cannot do that, am I right ?

klogd reads the kernel log messages (i.e. printk messages) either via syscall
or /proc interface and hands them over to syslogd.

Syslogd in turn writes them to a terminal, file, another host on
the network ...

So if you use klogd and syslogd together you can have kernel log message (also
on console if you like) and the other interrupts are not blocked by
printk.

Mike

--
Dr. Michael Neuhauser                        Phone: +43(1)8958499/17
g.a.m.s. edv-dienstleistungen gmbh           Fax:   +43(1)8958499/60
Stiegergasse 15-17/8                         Email: mike@gams.at
A-1150 Vienna/Austria/Europe


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
