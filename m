Message-ID: <01C2856C.A9D620E0.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Thruput slow unless select() on stdin frequently
Date: Wed, 6 Nov 2002 08:15:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The setup is an MPC860T, 50 MHz, Redhat linux 2.2.13.
The QMC channels do not interrupt on transmit and receive.
QMC is active on SCC2.  The console use SMC1 for serial
transmit and rec to an ASCII terminal.

I have a thread which continuously loops, doing 2 things:

  (1)  It executes a UDP recvfrom() for any of 12 UDP ports
       which may be active, and if a UDP pkt is recd, it queues
       it and the associated buffer descriptor in a circular Tx
       queue for subsequent transmit out 1 of 12 QMC channels
       to an external device.
  (2) It then checks the circular QMC Rx buffer descriptor queue
      for any pkts recd from a QMC SCC2 channel, from an
      external device, and sends them out using UDP sendto().

I need to check periodically for a serial key input through the
SMC1 serial port.  I use select(stdin) to check for it.  If I do this
select() check in its own thread, then the QMC circular transmit
queue grows and grows, and finally fills up (QMC not transmitting
queued buff decs fast enough), and the above thread doesn't empty
the circular rec queue fast enough.  I think the thread scheduler
is late switching to this thread, sometimes as long as 30ms or so.

If I move the select(stdin) inside the same continuously looping thread
mentioned above, executing it, say, every 20th execution of the
loop, then this speed things up.  If I increase this number for select(stdin)
execution to 50, then the xmt and rec circular queues start growing.
The longer duration between select() execution, the faster the queues fill up.
If the select is not executed at all, the queues fill up extremely fast and
the system is bogged down.

It's as though the stdin must be tested very frequently, even though no
serial keys are there to be getc()'d, or some part of the code blocks.
If I call select() too frquently, then that of course bogs things down, also.

I checked into the kernel, and if it appears that do_select(), in fs/select.c,
must be called from within sys_select().

The select(stdin) that works is:

      FD_ZERO(&read_file_descr);
      FD_SET(fileno(stdin),&read_file_descr);
      timeout_kbHit.tv_sec = 0;
      timeout_kbHit.tv_usec = 1;
      select(1,&read_file_descr,NULL,NULL,(struct timeval*) &timeout_kbHit);


Thanks,

Steven Vacca
Valcom, Inc.
Roanoke, Virginia






-----Original Message-----
From:	Georg Klug [SMTP:gklug@giga-stream.de]
Sent:	Tuesday, November 05, 2002 4:01 AM
To:	svacca@valcom.com
Cc:	Ppc Embedded
Subject:	RE: Thruput slow unless select() on stdin frequently

Hi Steven,

unfortunately, I don't know your board, but from the effect you are seeing,
I would say it is some sort of an interrupt problem. Do you have shared
IRQs? Was the interrupt service routine of the "QMC channel" driver
correctly installed? Does the interrupt really occur? Those would be the
things I would be searching next.

Kind regards,
Georg Klug

> --- stdin appears to block until a select() tests it, thus slowing
>    system code execution way down. ---
>
> My MPC860T app executes UDP recvfrom()'s and sendto()'s
> at regular intervals.  The recvfrom() UDP pkt data is queued with
> a buffer descriptor for transmission on a QMC channel to an
> external device.  The data read from the device on a QMC
> channel is queued with a buffer descriptor for subsequent sendto().
>
> But if I do not constantly execute a select() (timeout = 10us)
> on stdin (serial keyboard - not being used often) at a fast enough
> rate (i.e. if the select() is executed in it's own thread and doesn't
> get scheduled frequently enough) the code execution slows way
> down, and I find that the queued QMC channel data, residing
> in the circular queues doesn't get transmitted fast enough
> and the queues grow and grow.  Doing no select() on stdin
> basically shuts the QMC buff desc processing down.
>
> It's as though, even with no serial chars coming in, stdin
> blocks until the select() tests it.  I need to avoid this blocking, yet
> still periodically check for a serial key input on stdin.
>
> Any ideas out there in Linux Embedded-land?
>
> Thanks,
>
> Steven
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
