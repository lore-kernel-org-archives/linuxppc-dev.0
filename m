Subject: MPC8250 + PCMCIA + airo_cs card + IO Port mapping problem?
From: Jim Rowe <rowejames@acmsystems.com>
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <1053557921.16972.149.camel@kneedragger>
Mime-Version: 1.0
Date: 21 May 2003 15:58:41 -0700
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm bringing up Linux on a custom board with an MPC8250 (integrated
PCI), a Ricoh Cardbus-PCI bridge and a Cisco 350 client card. The kernel
is 2.4.21-pre4 - the development tree from ppc.bkbits.net. I'm using the
kernel's socket driver and client card driver (airo_cs and
yenta_socket). I'm also using the cardmgr from pcmcia-cs 3.1.22, and
Dean Dayton's PCI patch.

After starting cardmgr, the driver errors out because it doesn't get a
response from the Cisco card. It loops and writes to a register, then
reads it back. Some mechanism is supposed to change the register value
after the write and before the read. I'm guessing that this is because
my IO Port mapping is not correct, so I am not actually writing to
memory on the Cisco card.

>From what I can see - and please correct me if I'm wrong, the way that
Linux translates the Port IO to the memory mapped IO is through the outb
and outw macros, which add an offset of _IO_BASE. How do I determine the
correct value of _IO_BASE? I looked in m8260_setup.c and found

m8260_map_io(void)
{
        io_block_mapping(0xf0000000, 0xf0000000, 0x10000000, _PAGE_IO);
        io_block_mapping(0xe0000000, 0xe0000000, 0x10000000, _PAGE_IO);
}

Judging by the way some other platforms determined IO_BASE, I used
0xf0000000 for the value of _IO_BASE. Could someone explain the
relationship between io_block_mapping and _IO_BASE?

Is this all I need to do to get Port IO working on the PowerPC?


Finally here is the output of some of my log and my IO resources:


# cardmgr[39]: starting, version is 3.1.22
cardmgr[39]: watching 2 sockets
cardmgr[39]: ** initializing socket 0
cardmgr[39]: ** About to valdate CISd
cs: memory probe 0xa0000000-0xa0ffffff: clean.
cardmgr[39]: ** Valdated CISd
cardmgr[39]: ** Has CIS = 1
cardmgr[39]: ** Carrd appears to have CIS
cardmgr[39]: ** Trying to read MANFID
cardmgr[39]: ** Read MANFID successfully
cardmgr[39]: socket 0: Cisco 350
cardmgr[39]: executing: 'modprobe airo'
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
cardmgr[39]: executing: 'modprobe airo_cs'
ds: Registering PC card driver.
airo_cs: Return code was 0
cardmgr[39]: Device is a airo_cs
cardmgr[39]: Card ->IDENT_TYPE 2
ds: Received DS_BIND_REQUEST
16-bit write: addr:f0000100 val:00000010
16-bit write: addr:f0000100 val:00000010
16-bit write: addr:f0000100 val:00000010
16-bit write: addr:f0000100 val:00000010
16-bit write: addr:f0000100 val:00000010
16-bit write: addr:f0000100 val:00000010
16-bit write: addr:f0000100 val:00000010
16-bit write: addr:f0000100 val:00000010
16-bit write: addr:f0000100 val:00000010
airo: Max tries exceeded when issueing command
Inside issuecommand if
airo: MAC could not be enabled


# cat /proc/ioports
b0000000-b00fffff : PCI host bridge
  b00f7fd0-b00fbfcf : PCI CardBus #02
  b00fbfd0-b00fffcf : PCI CardBus #01
  b00fffd0-b00fffdf : CMD Technology Inc PCI0680
  b00fffe4-b00fffe7 : CMD Technology Inc PCI0680
  b00fffe8-b00fffef : CMD Technology Inc PCI0680
  b00ffff4-b00ffff7 : CMD Technology Inc PCI0680
  b00ffff8-b00fffff : CMD Technology Inc PCI0680
# cat /proc/iomem
80000000-803fffff : PCI host bridge
  80000000-80000fff : Ricoh Co Ltd RL5c476 II (#2)
  80080000-800fffff : PCI CardBus #01
  80100000-8017ffff : PCI CardBus #01
  80180000-801fffff : PCI CardBus #02
  80200000-8027ffff : PCI CardBus #02
  803f6000-803f6fff : Ricoh Co Ltd RL5c476 II
  803f7f00-803f7fff : CMD Technology Inc PCI0680
  803f8000-803fbfff : Texas Instruments TSB12LV26 IEEE-1394 Controller
(Link)
  803ff800-803fffff : Texas Instruments TSB12LV26 IEEE-1394 Controller
(Link)
c9000f00-c9000f07 : ide0
c9000f08-c9000f0f : ide1
c9000f10-c9000f17 : ide0
c9000f18-c9000f1f : ide1
#


Thanks for any help.


Jim Rowe
Advanced CounterMeasure Systems
Phone: (916)669-4304
Email: jrowe@acmsystems.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
