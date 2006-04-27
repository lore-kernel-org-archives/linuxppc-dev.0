Return-Path: <tsawyer@broadcom.com>
Received: from sandmail.sandburst.com (sandmail.sandburst.com [216.57.132.42])
	by ozlabs.org (Postfix) with ESMTP id 25ECD679F3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Apr 2006 07:12:04 +1000 (EST)
Message-ID: <445133A1.1050202@broadcom.com>
Date: Thu, 27 Apr 2006 17:12:01 -0400
From: "Travis B. Sawyer" <tsawyer@broadcom.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: TI1520 Cardbus with CF troubles
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings:

I'm working on getting some cardbus support into a 8540 based platform.

We're using a TI1520 cardbus controller (pci<->cardbus bridge) and 
compact flash.

(Note:  this is using 2.4.30 kernel.org kernel + some patches from the 
vendor)

At first I was getting no interrupts when the yenta driver was starting 
up, but
I back ported some stuff from 2.6 and now the ti1520 is routing the 
interrupts
properly through pci:

[root@mbc80-4 01]$ cat /proc/interrupts
           CPU0
  8:          0   None      Edge      rtc
 83:      12106   OpenPIC   Edge      enet_tx
 84:      19011   OpenPIC   Edge      enet_rx
 88:          0   OpenPIC   Edge      enet_error
 90:       1805   OpenPIC   Edge      serial
 91:        137   OpenPIC   Level     MPC I2C
 98:          1   OpenPIC   Level     Texas Instruments PCI1250 PC card 
Cardbus Controller
 99:          1   OpenPIC   Level     Texas Instruments PCI1250 PC card 
Cardbus Controller (#2)
101:          0   OpenPIC   Level     sb/ife0
102:          0   OpenPIC   Level     sbqe0
104:          0   OpenPIC   Level     phy_interrupt
BAD:          0

I have a cf card in the second controller socket. I've strewn printk's 
all over and what I'm
finding is that pcmcia_request_io is called with base=0 numports=0x10, 
ioAddrLines=4, and
returns with a base of 0x8100.

Here's the pci dump of both functions of the TI device (note, the card 
is plugged into the
socket associated with func 1 not func 0):

[root@mbc80-4 01]$ lspci -v -s 01:01
01:01.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus 
Controller (rev 01)
        Flags: bus master, medium devsel, latency 168, IRQ 98
        Memory at eafff000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: ea600000-ea61f000 (prefetchable)
        Memory window 1: ea700000-ea7ff000
        I/O window 0: 00008000-000080ff
        I/O window 1: 00008400-000084ff
        16-bit legacy interface ports at 0001
 
01:01.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus 
Controller (rev 01)
        Flags: bus master, medium devsel, latency 168, IRQ 99
        Memory at eabfe000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=03, subordinate=03, sec-latency=176
        Memory window 0: ea620000-ea63f000 (prefetchable)
        Memory window 1: ea800000-ea8ff000
        I/O window 0: 00008800-000088ff
        I/O window 1: 00008c00-00008cff
        16-bit legacy interface ports at 0001
 

I added printks to the ide do_probe, and all hwif->INB() calls return 0.

My /etc/pcmcia/config.opts adds the following lines:
include port 0x0000-0xffff
include memory 0xe0000000-0xeaffffff
 

Any ideas?

-travis

more dumps below:
[root@mbc80-4 01]$ cardctl status
Socket 0:
  no card
Socket 1:
  3.3V 16-bit PC Card
  function 0: [ready]
[root@mbc80-4 01]$ cardctl config
Socket 0:
  not configured
Socket 1:
  Vcc 3.3V  Vpp1 3.3V  Vpp2 3.3V


ide_config linkio: nports: 0 baseport 0
pcmcia_request_io calling alloc io spaces BLP1 NP1 IOADDRLines:  0 10 4
alloc_io_space s->io BP NP Inuse: 8100 10 10
pcmcia_request_io called alloc io spaces BLP1 NP1 IOADDRLines:  8100 10 4
ide_config b4Config base 8100
ide_config AFConfig base 8100
SELECT_DRIVE sending a0 to 8106
SELECT_DRIVE sending b0 to 8106
SELECT_DRIVE sending a0 to 8106
probing for hda: present=0, media=32, probetype=ATA
[root@mbc80-4 01]$ SELECT_DRIVE sending a0 to 8106
do_probe after select inb= 0
do_probe error reg 0
do_probe nsect reg 0
do_probe sect  reg 0
do_probe lcyl  reg 0
do_probe hcyl  reg 0
do_probe selct reg 0
do_probe stats reg 0
do_probe cntrl reg 0

[root@mbc80-4 ~]$ dump_cis
Socket 0:
  no CIS present
 
Socket 1:
  dev_info
    fn_specific 120ns, 2kb
  common_jedec 0xdf 0x01
  manfid 0x0045, 0x0401
  vers_1 4.1, "SanDisk", "SDP", "5/3 0.6"
  funcid fixed_disk [post]
  disk_interface [ide]
  disk_features [silicon] [unique] [single]
    [sleep] [standby] [idle] [low power]
  config base 0x0200 mask 0x000f last_index 0x07
  cftable_entry 0x00 [default]
    [rdybsy] [mwait] [pwrdown]
    Vcc Vnom 5V Vmin 4500mV Vmax 5500mV Ipeak 80mA
    memory 0x0000-0x07ff @ 0x0000
  cftable_entry 0x00
    Vcc Vnom 3300mV Ipeak 45mA
  cftable_entry 0x01 [default]
    [rdybsy] [pwrdown]
    Vcc Vnom 5V Vmin 4500mV Vmax 5500mV Ipeak 80mA
    io 0x0000-0x000f [lines=4] [8bit] [16bit]
    irq mask 0xffff [level] [pulse] [shared]
  cftable_entry 0x01
    Vcc Vnom 3300mV Ipeak 45mA
  cftable_entry 0x02 [default]
    [rdybsy] [pwrdown]
    Vcc Vnom 5V Vmin 4500mV Vmax 5500mV Ipeak 80mA
    io 0x01f0-0x01f7, 0x03f6-0x03f7 [lines=10] [8bit] [16bit] [range]
    irq 14 [level] [pulse] [shared]
  cftable_entry 0x02
    Vcc Vnom 3300mV Ipeak 45mA
  cftable_entry 0x03 [default]
    [rdybsy] [pwrdown]
    Vcc Vnom 5V Vmin 4500mV Vmax 5500mV Ipeak 80mA
    io 0x0170-0x0177, 0x0376-0x0377 [lines=10] [8bit] [16bit] [range]
    irq 14 [level] [pulse] [shared]
  cftable_entry 0x03
    Vcc Vnom 3300mV Ipeak 45mA
  cftable_entry 0x07
