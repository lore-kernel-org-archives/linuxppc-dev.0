Date: Tue, 30 Nov 1999 14:43:07 -0500 (EST)
From: "Mark S. Mathews" <mark@absoval.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RPXLite 823 PCMCIA troubles
Message-ID: <Pine.LNX.3.96.991130133128.22618B-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Howdy Folks,

We've been working with the embedded 2.2.13 kernel on an RPX-Lite CW with
a XPC823ZT66A processor running at the 50MHz/8MHz setting.  We have a
pcmcia wireless lan card that we're trying to get working, but our
accesses to the common memory regions of the card are twitchy.  We can run
with the card briefly, but eventually we wind up with a machine-check.

Over the past week or so we've tried just about every variation of
settings we can think of with only slightly varying results.  No matter
what we try, it always ends in a machine check.  The wireless driver code
runs well on the x86, our PowerBook, and on a different 860 based platform
(non-Linux, no MMU) so we're fairly confident it isn't the code.

I've attached an outline of our initialization procedure at the end of
this mail.  Are we missing something?

Here are some of the things we've varied:

- Address space allocations (region and size)
- Bus timings
- Adding/removing delays between accesses
- Using readb/writeb vs. direct access

Most of the time the failure occurs on a read.

One specific question...when setting up the PCMCIA bus timings, the 823
book lists the settings in units of "clock cycles".  Which clock?  We've
been assuming GCLKx or GCLKx_50 which are both 50MHz (hence 20ns cycle).

Many Thanks,
-Mark

-----------------------------------------------------------------
Here's the outline of our initialization procedure:

- Clear the pcmcia registers
	PORx = 0
	PBRx = 0
	PER = 0
	PSCR = 0
	PGCRA = 0
	PGCRB = 0

- Test PIPR for card presence, if found assume it's our card

- Turn on power
	PGCR[OE] = 1			; deassert Output Enable
	RPX_BSCR[PCVLTCTLx] = 0000	; Vcc=Vpp=GND
	(delay for settle)
	RPX_BSCR[PCVLTCTLx] = 0110	; Vcc=Vpp=5v
	(delay for settle)
	PGCR[RESET] = 1			; Assert reset pin
	(delay for 500 usec)
	PGCR[RESET] = 0			; deassert reset pin
	(delay for 500 usec)
	PGCR[OE] = 0			; assert Output Enable
	(delay for 300 usec)

- Map card Attribute memory
	PBR1 = 0xe4000000
	POR1[BSIZE] = 01000		; 32K bank size
	POR1[PSLOT] = 1			; slot B
	remap_base = ioremap(PBR1)	; returns 0xc4000000
	POR1[PRS] = 010			; Attribute mem
	POR1[PSL] = 01001		; 9 clock cycles
	POR1[PSST] = 0100		; 4 clock cycles
	POR1[PSHT] = 0010		; 2 clock cycles
	POR1[PV] = 1			; this bank is valid

- Set pcmcia config index in option register at Attrib+0x800
	remap_base[0x800] = 01000001	; index 1 and level mode interrupts
					; enables card for mem+io

- Map card IO memory
	PBR0 = 0xe0000000
	POR0[BSIZE] = 01101		; 512 bytes bank size
	POR0[PSLOT] = 1			; slot B
	remap_base = ioremap(PBR0)	; returns 0xc4009000
	POR0[PRS] = 011			; IO space
	POR0[PSL] = 01001		; 9 clock cycles
	POR0[PSST] = 0100		; 4 clock cycles
	POR0[PSHT] = 0010		; 2 clock cycles
	POR0[PV] = 1			; this bank is valid

- Map card Common memory
	PBR2 = 0xe8000000
	POR2[BSIZE] = 01000		; 32K bank size
	POR2[PSLOT] = 1			; slot B
	remap_base = ioremap(PBR2)	; returns 0xc400b000
	POR2[PRS] = 000			; Common memory space
	POR2[PSL] = 01001		; 9 clock cycles
	POR2[PSST] = 0100		; 4 clock cycles
	POR2[PSHT] = 0010		; 2 clock cycles
	POR2[PV] = 1			; this bank is valid

- Setup interrupt
	(card specific)
	clear on-card interrupt status
	disable card generated interrupts
	(8xx specific)
	PER |= BIT24			; enable RDY/IRQ#
	PSCR = 0xffffffffff		; clear any pending
	PGCR |= BIT6			; set 8xx interrupt level 

	request_8xxirq( 13, &func, 0, "am930", NULL);
					; This func sets up SIMASK and SIPEND,
					;  right?

- Driver now waits for something to do....


Mark S. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
