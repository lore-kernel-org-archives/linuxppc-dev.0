From: Richard Drummond <lists@rcdrummond.net>
To: linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: Voodoo card and PCI I/O ports?
Date: Sat, 22 Mar 2003 03:15:59 -0500
MIME-Version: 1.0
Message-Id: <200303220311.29361.evilrich@rcdrummond.net>
Reply-To: lists@rcdrummond.net
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/uBf+flMHj3Pk68"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Boundary-00=_/uBf+flMHj3Pk68
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I'm trying to use a Voodoo3 card under Linux on a Mac 9500. The problem that I
have with this card is that when I boot from Open Firmware with Quik, the PCI
I/O space of the card is not enabled (and hence X and the tdfxfb driver won't
work). If, however, I boot via miBoot the I/O space is enabled and all is
fine. My guess is that the MacOS driver in the Voodoo's ROM is enabling the
I/O ports, but that the OF driver doesn't.

When booting from OF, I can enable the card's I/O ports with the command:

setpci -s 0:0e.0 COMMAND=3

However, this is not enough to get the card working. The card claims the range
0x0400-0x04ff (PCI addressing) for its I/O space, but this conflicts with my
ATA controller which also wants this space and is enabled by OF. If I then
manually set the Voodoo's I/O port address with, for example,

setpci -s 0.0e.0 BASE_ADDRESS_2=0500

then the conflict disappears and X will now start up fine.

What I want to know is is this behaviour what one would expect? I am just
beginning to get grips with how PCI configuration works with OF and the Mac.
But I doesn't see why the kernel can't enable the I/O ports on the Voodoo
card and sort out the address conflict itself.

Can anybody here comment on this and enlighten me?

BTW, this behaviour is the same on all the kernels I've tried on this machine
- 2.4.18 to 2.4.20 from kernel.org.

I've attached the outputs of lspci -v and lspci -vb after booting from OF and
before my twiddling of the PCI config.

Cheers,
Rich




--Boundary-00=_/uBf+flMHj3Pk68
Content-Type: text/plain;
  charset="us-ascii";
  name="pci.lst"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="pci.lst"

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 22

00:0e.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo 3
	Flags: fast devsel, IRQ 24
	Memory at 82000000 (32-bit, non-prefetchable) [size=32M]
	Memory at 90000000 (32-bit, prefetchable) [size=32M]
	I/O ports at 0400 [disabled] [size=256]
	Expansion ROM at 84000000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1

00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
	Flags: bus master, medium devsel, latency 32, IRQ 22
	Memory at f3000000 (32-bit, non-prefetchable) [size=128K]

01:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 26

01:0d.0 SCSI storage controller: Artop Electronic Corp ATP860 (rev 01)
	Subsystem: Artop Electronic Corp ATP860
	Flags: bus master, medium devsel, latency 32, IRQ 27
	I/O ports at ff7fe440 [size=8]
	I/O ports at ff7fe430 [size=4]
	I/O ports at ff7fe420 [size=8]
	I/O ports at ff7fe410 [size=4]
	I/O ports at ff7fe400 [size=16]
	Expansion ROM at a0000000 [disabled] [size=64K]
	Capabilities: [58] Power Management version 1


--Boundary-00=_/uBf+flMHj3Pk68
Content-Type: text/plain;
  charset="us-ascii";
  name="pcib.lst"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="pcib.lst"

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
	Flags: bus master, medium devsel, latency 32

00:0e.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo 3
	Flags: fast devsel, IRQ 24
	Memory at 82000000 (32-bit, non-prefetchable)
	Memory at 90000000 (32-bit, prefetchable)
	I/O ports at 0400 [disabled]
	Capabilities: [60] Power Management version 1

00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
	Flags: bus master, medium devsel, latency 32
	Memory at f3000000 (32-bit, non-prefetchable)

01:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
	Flags: bus master, medium devsel, latency 32

01:0d.0 SCSI storage controller: Artop Electronic Corp ATP860 (rev 01)
	Subsystem: Artop Electronic Corp ATP860
	Flags: bus master, medium devsel, latency 32, IRQ 27
	I/O ports at 0440
	I/O ports at 0430
	I/O ports at 0420
	I/O ports at 0410
	I/O ports at 0400
	Expansion ROM at a0000000
	Capabilities: [58] Power Management version 1


--Boundary-00=_/uBf+flMHj3Pk68--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
