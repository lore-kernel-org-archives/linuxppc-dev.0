Date: Tue, 9 Oct 01 13:14:49 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0110092014.AA22503@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Proposed solution for interrupt mapping on CPCI and PPMC CPU ports
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

Anybody who has done a port of Linux/PPC, or any other OS/platform combo where
you have to have your own grip on the hardware rather than rely on a Wintel
BIOS or equivalent, to a CompactPCI or PPMC CPU will probably be familiar with
the problem to which I'm proposing my solution. In order to support various PCI
devices, you have to find them by scanning the PCI bus. This procedure is very
well standardised, the only thing that changes is where the host bridges are
and how to generate config cycles on them, but since the host bridges are on
the same board as the CPU, this can be hard-coded in the CPU port. That's all
fine and dandy. The next problem is that you also need to know how to field
interrupts from each PCI device. While the PCI spec prescribes the interrupt
behavior seen on the PCI or PMC connector, what happens to these interrupts
next and how they get to the CPU is up the CPU vendor. If your CPU board is a
motherboard with PCI slots or PMC sites on it, you know what interrupt
controller(s) do you have and how are the interrupts routed from the PCI/PMC
connectors, so you embed this knowledge in your port and assume that on the
peripheral side of the expansion connectors the PCI spec is adhered to.

The real trouble starts if your CPU is a PPMC or CompactPCI card. You have 4
interrupt lines coming in from the PPMC or CompactPCI connector, and you know
that each device out there has 4 interrupt outputs, at least conceptually, but
given a device number in the PCI configuration space, how do you know how are
its 4 interrupt outputs mapped to the 4 interrupt inputs to your PPMC or
CompactPCI CPU? Each device has its IDSEL line connected to one of the AD lines
and its interrupt outputs connected to your CPU's interrupt inputs in some way
by the PPMC carrier board or the CPCI backplane, but this "some way" is not
standardised and there are PPMC carrier boards and backplanes that do it in
every imaginable way.

In the current Linux/PPC there is no satisfactory solution to this problem. The
SBS K2 port (K2 is a CPCI CPU board) simply assumes a certain interrupt routing
for the CPCI backplane in its hard-coded table, and if one plugs a K2 with
Linux into a CPCI backplane with a different interrupt routing, none of the
CPCI peripherals will work. The same problem with the IBM Spruce port (Spruce
is a PPMC CPU): it assumes a certain carrier board and won't work on any
others. Same problem with all other CPCI and PPMC CPU ports.

Here then is the solution I propose for the world (I'm going to publish it as a
spec). It goes like this. Anybody who makes a PPMC carrier board or CPCI
backplane provides an INTMAP.TBL file (in the specified format) with it
describing its interrupt map. INTMAP.TBL is 84 bytes long, 4 bytes for each AD
line from 11 to 31. The first 4 bytes correspond to AD11, the next 4 to AD12,
and so on, the last 4 bytes correspond to AD31. Each such 4-byte record
describes the interrupt routing for the device whose IDSEL line is connected to
the corresponding AD line. The 4 bytes correspond to that device's INTA#,
INTB#, INTC#, and INTD# lines in this order. Each byte says how will this
interrupt be presented to the monarch PPMC or the plane in the system slot.
Values 01 through 04 correspond to the INTA-D# lines on the monarch PPMC or
CPCI system slot connector respectively, value 00 means no such interrupt, and
all other values are undefined.

Software for PPMC and CPCI CPUs can then be written with the requirement that
the user provides an INTMAP.TBL file in this standard format describing the
interrupt mapping of the carrier board or backplane he/she has put his/her PPMC
or CPCI CPU card on. ROM monitors on PPMC and CPCI CPU boards would provide
facilities for storing the user-supplied INTMAP.TBL in NVRAM, EEPROM, or flash
at system configuration time and then passing it to the OS on every normal
boot. A system integrator putting together a PPMC CPU and a carrier board or a
CPCI CPU and backplane would take the INTMAP.TBL supplied by the carrier board
or backplane manufacturer and store it in the NVRAM/EEPROM/flash/whatever of
the CPU board using the ROM monitor facilities. Any OS he/she wants to run will
take it from there. From this point everything sings and dances.

I propose that this scheme be adopted by Linux/PPC. We can add a bootinfo
record for INTMAP.TBL, have all CPCI and PPMC CPU ports use it, and have
bootloaders fetch this information from whatever facilities the firmware
provides. (On boards with non-existent or losing firmware INTMAP.TBL will have
to be smacked into the bootloader, but it's still better than hard-coding it in
the kernel port.)

I have implemented all these ideas in the SBS Palomar II/IV/V port I just wrote
(these are PPMC CPU cards) and posted to linuxppc-commit for review and
integration.

--
Michael Sokolov				5791 VAN ALLEN WAY
Software Engineer			CARLSBAD CA 92008-7321 USA
SBS Technologies, Inc.			Phone: +1-760-438-6900 x2347
Communications Products			    or  1-888-SBS-COMM x2347
					Fax:   +1-760-438-6985
					E-mail: msokolov@sbs.com
					     or msokolov@ivan.Harhan.ORG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
