Date: Sat, 10 Feb 2001 18:01:52 -0800 (PST)
From: "Michael K. Fleming" <mikef@praxis.etla.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: PCMCIA on a Pismo with pcmcia-cs-3.1.24
Message-ID: <Pine.LNX.4.21.0102101758020.20783-100000@praxis.etla.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi--

I'm trying to get PCMCIA working on my Mac Powerbook Pismo, with kernel
2.2.18pre4-ben1 and pcmcia-cs-3.1.24 (no patches applied--as far as I can
tell, none should be necessary...).  I'm primarily trying to get a
WaveLAN card to work.

I've carefully read the notes at:

http://www.mpifr-bonn.mpg.de/div/iri/Archiv/LinuxPPC/PCMCIA.html

and followed what seemed currently relevant.

The problem seems to be that the i82365 driver cannot properly allocate
the interrupt assigned to the device.  The problem I'm having seems to be
identical to one that Uwe Steinmann reported a few weeks ago on this
mailing list.  I've read the followups to that email, but did not find any
solutions.

The relevant portions of my kernel log, /etc/pcmcia/config.opts, and lspci
are attached below.

Any hints or pointers would be greatly appreciated.

Mike Fleming
mikef@praxis.etla.net

-------------------------
dmesg
-------------------------

Linux PCMCIA Card Services 3.1.24
  kernel build: 2.2.18pre4-ben1 #6 Sat Feb 10 13:56:41 PST 2001
  options:  [pci] [cardbus]
Intel PCIC probe:
  TI 1211 rev 00 PCI-to-CardBus at slot 00:1a, mem 0x80080000
    host opts [0]: [serial pci & irq] [pci irq 58] [lat 16/32] [bus 1/1]
    PCI irq 58 test failed
    *NO* card interrupts, polling interval = 1000 ms

When I insert a WaveLAN card:

wvlan_cs: WaveLAN/IEEE PCMCIA driver v1.0.6
wvlan_cs: (c) Andreas Neuhaus <andy@fasta.fh-dortmund.de>
wvlan_cs: RequestIRQ: Resource in use

-------------------------
/etc/pcmcia/config.opts:
-------------------------

include memory 0x90000000-0x9003ffff
include port 0x1000-0x1fff

-------------------------
Output of lspci:
-------------------------

00:1a.0 CardBus bridge: Texas Instruments PCI1211
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 16, cache line size 08
	Interrupt: pin A routed to IRQ 58
	Region 0: Memory at 80080000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
	16-bit legacy interface ports at 0001
-------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
