Date: 23 Sep 2002 18:42:21 -0000
Message-ID: <20020923184221.24338.qmail@webmail22.rediffmail.com>
MIME-Version: 1.0
From: "Rajendra Prasad Mishra" <r_p_m@rediffmail.com>
Reply-To: "Rajendra Prasad Mishra" <r_p_m@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: IDE interrupts on Winbond W83C553 !
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all !
     I am working on linux driver for a winbond W83C553 isa
bridge/ide controller. The winbond chip is on a ibm 405gp based
board. I am not able to get the ide interrupts. I configured the
base address registers of the ide controller and i am able to
access the status/control registers. But when i tried to configure
the interrupt i found that the 8259 PCI will also have to be
programmed ....so i disabled the LEGIRQ mode in the IDE
control/status register... then initialised the i8259 .
But i am not getting any interrupts ! here is the output of the
bootup sequence :



******************************************************
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
W82C105: IDE controller on PCI bus 00 dev 49
W82C105: chipset revision 5
W82C105: 100% native mode on irq 46
     ide0: BM-DMA at 0xffd0-0xffd7, BIOS settings: hda:pio,
hdb:pio
SL82C105 command word: 5
IDE control/status register: 00ff0091
     ide1: BM-DMA at 0xffd8-0xffdf, BIOS settings: hdc:pio,
hdd:pio
SL82C105 command word: 5
IDE control/status register: 00ff0091
hdb: ST340810A, ATA DISK drive
ide0 at 0xfff8-0xffff,0xfff6 on irq 46
hdb: 16514064 sectors (8455 MB) w/2048KiB Cache, CHS=16383/16/63
Partition check:
  /dev/ide/host0/bus0/target1/lun0:hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
hdb: set_multmode: status=0x51 { DriveReady SeekComplete Error }
hdb: set_multmode: error=0x04 { DriveStatusError }
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
  unknown partition table
*************************************************

ide has been assigned interrupt 46 i.e 32 ( UIC interrupts ) + 2
serial port interrupts + 14th ide interrupt !

the 8259 PIC is connected to the IRQ0 ( external interrupt) , i
have put a printk  in do_IRQ() just to insure that i am not
missing anything ! but still there is no interrupt on IRQ0 !

if anyone has any idea/solution .... i would be deeply thankfull
!

PS: Please cc me as i am not subscribed to the list !

thanks,
raj

__________________________________________________________


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
