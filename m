Date: Fri, 6 Jul 2001 14:39:27 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200107062139.OAA14875@krakatoa.gigabitnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu
Subject: ppc-linux EPIC (OpenPIC) and Interrupts on MPC8240
Cc: cort@cs.nmt.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am porting a custom designed MPC8240 board to linuxpcc,
have spent about a month or so getting ppcboot running
on it, and am now in the low-level details of getting
linux setup and running. Here's the details of my hardware
configuration:

200Mhz MPC8240 (Embedded MPC107, EPIC, I2C, I2O) + 64MB SDRAM
512K PLCC (Bootrom)
4MB FLASH mapped via PLD to PortX I/O Bus in range:
NS16550  mapped via PLD to PortX I/O bus starting at 0xffe08080
DEC 21143 Ethernet on MPC107 PCI Bus
ALI 1535 Southbridge
PCI Connector

The board is essentially a Motorola Sandpoint design variant, so
I have started with the MontaVista Sandpoint port of linux-2.3.1
and have had gotten into the sandpoint_setup code. I believe the
interrupt controller driver and serial port are currently broken
however.

IRQ mapping on this system is different then the standard PPC/Linux
configurations I have seen so far as it uses the internal OpenPIC
interrupt controller for all interrupts and does not use the 8259
serial port cascade (Winbond and others).

Vector(s)	Assignment
---------	-------------------
0-15		External (and unused serial interrupts)
16-19		Global timers
20		I2C
21-22		DMA
23		I2O message


Also, the MPC8240 EPIC (OpenPIC) has two modes: serial and discrete
interrupt mode. I need to use Discrete interrupt mode, which allows
for my hardwired interrupt mapping :

#define IRQ_ENET	1	/* Hardwired external EPIC Vector 1*/
#define IRQ_PCI		3	/* Hardwired external EPIC Vector 3*/
#define IRQ_UART	4	/* Hardwired external EPIC Vector 4*/

I have several questions:

1) How do the internal linux IRQ numbers map to EPIC interrupts?
2) What is the procedure by which the interrupt controller will invoke
   a linux interrupt? I know doIRQ is called and ppc_md.cannonicalize_irq()
   will re-number interrupts if need be, but I am not sure what interrupt
   numbers these should map to on the EPIC.
3) How should I handle the serial port? The drivers/char/serial.c
   allows for :

	static struct serial_state rs_table[] = {
		{ 0, 9600, 0xffe08080, 4, STD_COM_FLAGS }, /* ttyS0 */
	};

   however I am not sure this will work since I get no console output
   but I do know that my PIO version of the serial driver works (since
   I have written a ppc_md.progress routine and it spits out text indicating
   where I am)

4) Should I add a new interrupt controller driver? I am sure the open_pic.c
   driver works since it works for sandpoint, however, it only handles routing
   the interrupt to the 8259 cascade (which does the SIO interrupt) which is
   not what I am using (I need the 8240 EPIC in discrete mode EXT4 = COM1).

Here is where I am at bootup:

Initializing...
  CPU:   MPC8240 Revision 1.1 at 302 MHz: 16 kB I-Cache 16 kB D-Cache
  Board:   VOOHA MOUSSE MPC8240/KAHLUA - CHRP (MAP B)
  PLD Revision 1
  Local Bus at 2105 MHz
  DRAM:  64 MB
  FLASH: 16 MB
  Scanning function 0 of each PCI device on bus 0
  bus dev fn venID devID class  rev MBAR0    MBAR1    IPIN ILINE
  00  00  00 1057  0003  060000 11  00000008 00000000 01   00
  00  0d  00 1011  0019  020000 41  00810001 00010000 01   01
  In:    serial
  Out:   serial
  Err:   serial

mousse>boot
DC21143 Ethernet adapter(bus=0, device=13, func=0)
DEC Ethernet iobase=0x80000000 eth0: online
ARP broadcast 1
TFTP from server 192.168.1.133; our IP address is 192.168.1.138
Filename 'vmlinux.img'.
Load address: 0x100000
Loading:
################################################################################
#################
done
Bytes transferred = 492694 (78496 hex)
eth_halt
## Booting image at 00100000 ...
   Image Name:   vmlinux.bin.gz
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    492630 Bytes = 481 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
arch: exitinit IRQ
openpic enterOpenPIC v1.2
openpic timeropenpic ipisandpoint irq
openpic spuriousopenpic exitdo_IRQ:irq:00000063

 irq_cannon:00000004
                    irq_cannon:00000000
                                       irq_cannon:00000001
                                                          irq_cannon:00000002

irq_cannon:00000003
                irq_cannon:00000004
                                   irq_cannon:00000003
                                                      irq_cannon:00000004

irq_cannon:00000003


I am pretty sure it is mapping the OpenPIC correctly (I get 1.2 in my VxWorks
driver so that looks good). I am not sure why do_IRQ() is called with IRQ=0x63
though, perhaps this is in need of re-mapping? I wrote the irq_cannonicalize
routine to return the IRQ number, and in a desperate hack attempt to get the
serial port to work, I added the same rs_table entry for IRQ 0-4


I am sure someone out there has had to deal with this issue before, so any
pointers in the right direction would be greatly appreciated.

Many thanks in advance.

					-James
James Dougherty
jfd@gigabitnetworks.com
408-776-6634

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
