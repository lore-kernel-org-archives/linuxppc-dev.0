Date: Fri, 2 Nov 2001 09:34:46 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: <tahoward@ntrnet.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel cannot allocate resource region
In-Reply-To: <Pine.LNX.4.33.0111012203120.971-100000@ranger>
Message-ID: <Pine.LNX.4.33.0111020931250.1045-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> PCI: Cannot allocate resource region 0 of device 00:11.0
> 00:0e.0 VGA compatible controller: ATI Technologies Inc Rage 128 RE
> (prog-if 00 [VGA])
>         Subsystem: Unknown device b530:0408
>         Flags: bus master, stepping, medium devsel, latency 32, IRQ 25
>         Memory at 84000000 (32-bit, prefetchable)
>         I/O ports at 0400
>         Memory at 80804000 (32-bit, non-prefetchable)
>         Expansion ROM at 80820000 [disabled]
>         Capabilities: [5c] Power Management version 1
>
> 00:11.0 Ethernet controller: Digital Equipment Corporation DECchip
> 21142/43 (rev 30)
>         Subsystem: Standard Microsystems Corp [SMC]: Unknown device 2401
>         Flags: bus master, medium devsel, latency 32, IRQ 22
>         I/O ports at 0400
>         Memory at 80800000 (32-bit, non-prefetchable) [disabled]
>         Expansion ROM at 80840000 [disabled]
>
> I'm guessing that there is a conflict between my ethernet and video cards,

Yep, it seems like the MMIO aperture for the video card might overlap the
ethernet controller memory resource (depending on the size of that memory
resource).

It should never hang in that case though. And I thought the initial PCI
resource allocation takes care of resolving overlaps?

Can you boot some other way (i.e. no BootX)?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
