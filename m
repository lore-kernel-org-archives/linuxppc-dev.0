Message-ID: <392D4B94.C2B771D2@switchboard.ericsson.se>
Date: Thu, 25 May 2000 17:49:40 +0200
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCMCIA trouble
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I've recently received some mail concerning my m8xx PCMCIA socket driver.
So, I thought of sorting some things out here:

Start by reading "Linux PCMCIA Programmer's Guide":
http://pcmcia.sourceforge.org/ftp/doc/PCMCIA-PROG.html

I will now try to make things a bit clearer:
Please correct me when I'm wrong.

-- I/O space --

If you have some kind of register in external hardware and
wants your CPU to access it in some way, you can choose from
two methods: Address space mapped I/O or I/O space mapped I/O.

Address space mapped I/O:
Your external hardware compares all accesses on the bus
with it's own address (or triggers on a CS) and if the
address matches it will perform a read or write.
The access will be performed via a standard memory access.

I/O space mapped I/O:
The external hardware will check if a special pin on the bus
tells that the access is a I/O access and also check the address,
and the perform the operation if it matches.
The registeraccess will be done through some special instruction.

Motorola has a history of Address mapped I/O.
A clean and simple way.

Intel and clones (and the zilog Z80) has always used the I/O space.
Maybe it was bacause they didn't want to waste the 1MByte address
space with I/O or maybe it was just for compability with the 8080.
Who knows.

The I/O space used on a PC has 64K addresses and each access takes 1us. (?)

Linux has special macros for I/O space operations.
inb() - outb(), insb() - outsb(), 8 bit access.
inw() - outw(), insw() - outsw(), 16 bit access.
inl() - outl(), insl() - outsl(), 32 bit access.

ins<x>() and outs<x>() are string operations and will read a string.
in<x>() and out<x>() are single access macros.

Check include/asm-ppc/io.h for more info.

On the PC these macros will be translated into special instructions (in / out).

These macros in Linux on the PowerPC will translate all I/O space operations
into standard memory accesses that starts at _IO_BASE.

64KByte should be ioremapped phys=virt at _IO_BASE.
I think the only way to do that is to do in in arch/ppc/mm/init.c,
but I would be glad to put it in m8xx_pcmcia.c if someone knows how.

Please note that even if 64KByte space at _IO_BASE is ioremapped
it doesn't mean that any access to that area is valid.
The generic PCMCIA code will tell me to open up a gap that is valid
at say I/O space address 0x1f0 that is 8 bytes long.
Only the addresses at _IO_BASE+0x1f0 -> _IO_BASE+0x1f7 will be valid.

The 8250/16550 driver (serial.c) probes at init-time which will cause
problems.

-- Endian --

The m8xx series of PowerPC processors are all big endian.
All I/O space accesses to done by any PCMCIA device driver should be
done with little endian accesses.
So, swapping should be performed.

include/asm-ppc/io.h:
All in<x>() / out<x>() are translated into in_le<x>() / out_le<x>(), ie they are swapped.
arch/ppc/kernel/m8xx_setup.c:
m8xx_ide_insw() / m8xx_ide_outsw() will call ide_insw() / ide_outsw()
arch/ppc/kernel/misc.S:
ide_insw() / ide_outsw() will do the same as _insw_ns() / _outsw_ns(), ie no swap.

So, all accesses except the ide are swapped. Don't ask me why.

-- Memory Windows --

Usually the PCMCIA code tells the socket driver that is should map in a memory
window at a certain address in the address space. This works fine if the PCMCIA
socket hardware (usually a ISA or PCI card) has offset register for their windows.
All (I think) PC hardware has that.

The m8xx series of processors does not have any offset register.
David Hinds and me made some kind of interface change to support this hardware.
So now the generic code asks me for an address where the window that has a certain
offset is. Get it? Probably no.

Anyhow what is important is that lots of physical address space is needed.
Read more about it in m8xx_pcmcia.c.

-- IRQ --

There are two kinds of IRQs - IRQs for my socket driver and IRQs for the
PCMCIA-card driver.
My socket driver's IRQ handles stuff like insertion and removal.
The socket driver also tells the generic code what interrupt it should use
for the PCMCIA-card driver.

-- Vcc and Vpp --

The voltage setting routines are very board specific.
Please double-check with your manual.
Don't blame me if your board will be fried.

The generic PCMCIA code will tell me what voltage to set.
I have nothing to do with it except doing what he says.

Some of my voltage-detection code should be rewritten,
I thought that I was supposed to report all values to the
generic code, but I should tell it the lowest possible value.
And that is board specific too.

-- Timing --

The socket driver tries to figure out how many waitstates
each windows should have depending on the MHz value of the CPU
and the nano second setting from the generic PCMCIA code.

If the driver gets wrong MHz value for some reason stuff will not work.
Double check that too.

You might run into trouble if you have your BMT enabled (check SYPCR).

-- Final words --

I've successfully used several differnet ATA cards and the xirc2ps.c driver.
serial_cs.c based modems and stuff also work.

No special configuration files are needed.

Please note that all of the PCMCIA-card drivers will work right out of the box.
There are usually some timing problems.

Now - what can go wrong?

peace /

magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
