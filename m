From: "Georg Klug" <gklug@giga-stream.de>
To: <svacca@valcom.com>
Cc: "Ppc Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Thruput slow unless select() on stdin frequently
Date: Tue, 5 Nov 2002 10:00:32 +0100
Message-ID: <FFECLICFNBJAHONLGAKMAELNCGAA.gklug@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <01C28414.C30A9C20.svacca@valcom.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
