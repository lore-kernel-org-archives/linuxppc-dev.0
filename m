Date: Thu, 1 Nov 2001 22:13:57 -0500 (EST)
From: <tahoward@ntrnet.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Kernel cannot allocate resource region
Message-ID: <Pine.LNX.4.33.0111012203120.971-100000@ranger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi.  I've been trying to get 2.4 series kernels to work, but they always
have hung very early in booting, and never printed anything on the screen.
It just occurred to me to try booting with the console on a serial port,
and I got the following message using 2.4.14-pre3 from source.mvista.com:

PCI: Probing PCI hardware
PCI:00:0e.0: Resource 0: 84000000-87ffffff (f=1208)
PCI:00:0e.0: Resource 2: 80804000-80807fff (f=200)
PCI:00:10.0: Resource 0: f3000000-f307ffff (f=200)
PCI:00:0d.0: Resource 0: 80801000-80801fff (f=1208)
PCI:00:0e.0: Resource 1: 00000400-000004ff (f=101)
PCI:00:11.0: Resource 0: 00000400-0000047f (f=101)
PCI: Cannot allocate resource region 0 of device 00:11.0
PCI:  parent is c041b030: 00000000-007fffff (f=100)
PCI:00:11.0: Resource 1: 80800000-8080007f (f=200)
Macinto

Nothing more ever appears.  Here is the output from lspci -v under 2.2.19:

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev
03)
        Flags: bus master, medium devsel, latency 32

00:0d.0 Multimedia video controller: Brooktree Corporation Bt848 TV with
DMA push (rev 12)
        Flags: bus master, medium devsel, latency 32, IRQ 23
        Memory at 80801000 (32-bit, prefetchable) [disabled]

00:0e.0 VGA compatible controller: ATI Technologies Inc Rage 128 RE
(prog-if 00 [VGA])
        Subsystem: Unknown device b530:0408
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 25
        Memory at 84000000 (32-bit, prefetchable)
        I/O ports at 0400
        Memory at 80804000 (32-bit, non-prefetchable)
        Expansion ROM at 80820000 [disabled]
        Capabilities: [5c] Power Management version 1

00:10.0 Class ff00: Apple Computer Inc. O'Hare I/O (rev 01)
        Flags: bus master, medium devsel, latency 32
        Memory at f3000000 (32-bit, non-prefetchable)

00:11.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 30)
        Subsystem: Standard Microsystems Corp [SMC]: Unknown device 2401
        Flags: bus master, medium devsel, latency 32, IRQ 22
        I/O ports at 0400
        Memory at 80800000 (32-bit, non-prefetchable) [disabled]
        Expansion ROM at 80840000 [disabled]

I'm guessing that there is a conflict between my ethernet and video cards,
but I don't know what to do to resolve it.  Any suggestions?  I don't know
if it matters, but I'm using BootX 1.2.2

Tony


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
