Message-ID: <3C1FBADD.FF66E2A7@aquilagroup.com>
Date: Tue, 18 Dec 2001 14:53:33 -0700
From: Jeff Studer <jstuder@aquilagroup.com>
MIME-Version: 1.0
To: Peter Desnoyers <pdesnoyers@chinook.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCI QSPAN2 resource conflicts
References: <3C1F9452.AB979826@aquilagroup.com> <3C1F8DE8.9FA7CECE@chinook.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I downloaded lspci and ran it on my embedded system,
here is the results:

# lspci -vv
00:03.0 Class 0000: 16b2:5100 (prog-if 02)
        Control: I/O- Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 6
        Region 0: I/O ports at <ignored> [disabled]
[size=65]
        Region 1: I/O ports at <ignored> [disabled]
[size=129]

00:04.0 Class 0200: 10b7:9055 (rev 30)
        Subsystem: 10b7:9055
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0 (2500ns min, 2500ns max)
        Interrupt: pin A routed to IRQ 8
        Region 0: I/O ports at f4000000 [size=129]
        Region 1: Memory at f5ffff80 (32-bit,
non-prefetchable) [size=129]
        Expansion ROM at <unassigned> [disabled]
[size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot
+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

# lspci -xxx
00:03.0 Class 0000: 16b2:5100
00: b2 16 00 51 00 00 00 00 00 02 00 00 00 40 00 00
10: 41 ff ff f5 81 ff ff f5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 06 01 0a 0a
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

00:04.0 Class 0200: 10b7:9055 (rev 30)
00: b7 10 55 90 07 00 10 02 30 00 00 02 00 00 00 00
10: 01 00 00 f4 80 ff ff f5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
30: 00 00 00 00 dc 00 00 00 00 00 00 00 08 01 0a 0a
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 76
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

The arch/ppc/kernel/qspan_pci.c file doesn't have a
debug macro, and its basically totally rewritten anyway,
so I can't provide any information that way.  I'll gladly
add any printks for various pieces of data in whatever
functions needed to provide any information that would
help.

The backplane has 2 PCI slots. In the first slot is our
PCI card, in the 2nd slot is the 3c905B-TXNM 3COM
card.  If I can provide any more information that could
help, please let me know.


Peter Desnoyers wrote:

> Two pieces of information that would be useful for anyone to debug this:
>
> 1. lspci -vv and lspci -xx output
> 2. console output of boot with DEBUG turned on in the qspan file.  (not
> the bootloader one, but kernel/qspan_pci.c or whatever)
>
> Send them to the list and a few of us might have some ideas.
>
> If all else fails, do what I did - call the Tundra people for help.
> (although in my case it was a hardware issue. They were pretty helpful,
> though.)
>
> Jeff Studer wrote:
> >
> > I am working with a linux 2.4.2 kernel in an MPC860 custom board using a
> > Tundra QSPAN2 PCI controller.  I have set up configuration space and can
> > successfully probe for PCI cards. When I load PCI drivers, I get into
> > trouble.
> >
> > When I insmod the 3c59x.o module, I can access I/O space, but my MAC
> > address is read as 00:00:00:00:00:00.  I can't find manuals for this
> > card to verify what is going wrong, but I can see data in the I/O space
> > when I use our ADS board and the mpc8bug program.
> >
> > When I load another driver specific to this project, therefore the need
> > for PCI at all, I get resource conflicts.  The 3c59x.o driver actually
> > uses the value I set bus->resource->start to,  whereas the other PCI
> > driver uses 0.
> >
> > I've tried various setups for the resource.  I have set
> > bus->resource->start to the address in the QSPAN2's Slave0 address
> > setting. And I also tried do this and using the arch/ppc/mbxboot/pci.c's
> > functions: probe_addresses and map_pci_addrs.
> >
> > I really wish there was a detailed HOWTO for all this, but in the
> > meantime, does anyone have any idea what are the proper steps to
> > complete this PCI support and/or what I may be doing wrong?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
