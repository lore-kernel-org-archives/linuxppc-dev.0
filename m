MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: 8260 FCC buffer underrun
Date: Tue, 17 Aug 2004 06:48:36 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB0922DA@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: "LinuxPPC Embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Jeff
> Angielski
> Sent: Tuesday, August 17, 2004 8:24 AM
> To: LinuxPPC Embedded
> Subject: 8260 FCC buffer underrun
>
>
>
> Does anybody know what conditions would cause the FCC to
> report a buffer
> underrun transmit error when we are transmitting small ethernet
> packets?  Especially since the packets are so small they only use 1
> buffer descriptor.
>
> The wierd thing is that ARP packets gets transmitted fine.  Anything
> larger than that, however, generate the underrun errors.
>
> The receive side appears to work fine.  Pings come in, get processed,
> and then we attempt to transmit the reply.
>
> This is on an EP8260 H2, a couple weeks old u-boot cvs, and bk pull of
> linuxppc-2.4.27.
>
> The hardware works because PlanetCore with bk pull of linuxppc-2.4.27
> works fine [although PlanetCore has it's own configuration issues...].
>
>
> Jeff Angielski

Hi Jeff,

This sounds like (in order of likelyhood) a memory access, CPM too busy, or a FCC prioritization problem.  The FCC has a 192 byte FIFO.  If your packet has fewer than 192 bytes, it will probably go out OK (witness ARP replies).  If it is larger than 192 bytes, the CPM DMA engine has to go fetch more data.  Apparently it is not getting its data soon enough, which causes the underrun.

Some questions...
* I don't understand your note above "The hardware works because PlanetCore with bk pull of linuxppc-2.4.27 works fine...".  If it works fine, what is broken?  What is different from the "works fine" load and the broken load?  The root of the problem will lie there.

* Where are your buffers?  Local memory or 60x memory?  What is competing for that memory?

* Which FCC are you using?  IIRC, FCC3 has errata wrt DMA engine priority.

* What else is the CPM doing while you are trying to Tx?

* If you do a minimum packet size ping, does it work?  If so, increase the size of the ping packet, when does it break?

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
