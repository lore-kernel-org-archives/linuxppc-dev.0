Message-ID: <3B785392832ED71192AE00D0B7B0D75B1BFA67@aimail.aiinet.com>
From: "Dayton, Dean" <deand@aiinet.com>
To: "'Jean-Denis Boyer'" <jdboyer@mediatrix.com>,
	Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problem of concurrency in arch/ppc/8260_io/uart.c
Date: Fri, 7 Mar 2003 07:52:53 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes, I have seen this problem when I have a lot of printks from interrupt
context on my 8255 board using an SCC as the console. It's been on my list
for awhile but I haven't done anything about it yet. I think the easy
approach would be to disable interrupts when manipulating the buffer
descriptors (in fact, there are comments in the driver that make me suspect
this used to be the done). But there would be a performance hit for this.
Anyone got a more elegant suggestion?

Dean Dayton

> -----Original Message-----
> From: Jean-Denis Boyer [mailto:jdboyer@mediatrix.com]
> Sent: Thursday, March 06, 2003 4:39 PM
> To: Linux PPC embedded
> Subject: Problem of concurrency in arch/ppc/8260_io/uart.c
>
>
>
> I have a problem of concurrency on my 8250 based custom
> board. I'm using kernel 2.4.19, and the output on the serial
> port goes crappy.
>
> It seems to appear when printk is called from interrupt
> context, while a user mode process is writing to stdout.
>
> I wrote a user mode program + a kernel module to reproduce
> the problem. The kernel module starts a timer that calls
> printk (34 chars) each 100ms. The user mode program performs
> a while(1) printf(...); That combination almost immediatly
> mess the serial driver, that begins to output characters in
> an unpredictable order, until we reboot. It never crashes,
> however, but it is annoying.
>
> Has anyone encoutered that problem?
> or has any suggestion before I go further?
> or wish to have the test program to give it a try?
>
> Thanks,
> --------------------------------------------
>  Jean-Denis Boyer, B.Eng., Technical Leader
>  Mediatrix Telecom Inc.
>  4229 Garlock Street
>  Sherbrooke (Québec)
>  J1L 2C8  CANADA
>  (819)829-8749 x241
> --------------------------------------------
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
