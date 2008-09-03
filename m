Return-Path: <richard.whitlo@btconnect.com>
Message-ID: <48BE9A4F.2000903@btconnect.com>
Date: Wed, 03 Sep 2008 15:08:15 +0100
From: Richard Whitlock <richard.whitlo@btconnect.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: CF card access using promise pdc20275
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: richw@netcomuk.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm having a bit of bother with mounting a CF card using a promise 
pdc20275 with an 8347.
I've finally got my address mapping sorted out, and it all seems to work 
in principle.
I wait until a CF card is inserted, then load the pdc2027x.ko module, 
then mount the card.
The module load, however, takes approximately 2 minutes to complete. 
Mounting takes several seconds, and accesses to the card once mounted 
are similarly slow.
I've turned on debug output in the pdc2027x.ko module (and in a few 
other places as well) and 'insmod pata_pdc2027x.ko' gives the following 
output.
There is an exception at the end of each attempt, and each attempt takes 
several tens of seconds. The device seems to ignore everything until the 
speed is throttled right back.

pata_pdc2027x 0000:00:0b.0: version 1.0
pdc_detect_pll_input_clock: scr[140E00]
pdc_read_counter: bccrh [7FFF] bccrl [7FEB]
pdc_read_counter: bccrhv[7FFF] bccrlv[7FD7]
pdc_read_counter: bccrh [7FC1] bccrl [5B28]
pdc_read_counter: bccrhv[7FC1] bccrlv[5B14]
pdc_detect_pll_input_clock: scr[144E00]
pdc_detect_pll_input_clock: start[1073741803] end[1071700776]
pdc_detect_pll_input_clock: PLL input clock[16491280]Hz
pata_pdc2027x 0000:00:0b.0: PLL input clock 16491 kHz
pdc_adjust_pll: pout_required is 133333333
pdc_adjust_pll: pll_ctl[4D58]
pdc_adjust_pll: F[119] R[13] ratio*1000[8085]
pdc_adjust_pll: Writing pll_ctl[D77]
pdc_adjust_pll: pll_ctl[D77]
scsi0 : pata_pdc2027x
scsi1 : pata_pdc2027x
ata1: PATA max UDMA/133 mmio m16384@0xc0100000 cmd 0xc01017c0 irq 16
ata2: PATA max UDMA/133 mmio m16384@0xc0100000 cmd 0xc01015c0 irq 16
pdc2027x_set_piomode: adev->pio_mode[8]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[0]
pdc2027x_set_piomode: adev->pio_mode[8]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[0]
pdc2027x_cable_detect: No cable or 80-conductor cable on port 0
ata1.00: CFA: LEXAR ATA FLASH CARD, 20070228, max UDMA/100
ata1.00: 7831152 sectors, multi 0: LBA
pdc2027x_set_piomode: adev->pio_mode[C]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[4]
pdc2027x_set_dmamode: Set udma regs...
pdc2027x_set_dmamode: Set udma regs done
pdc2027x_set_dmamode: Set to udma mode[5]
ata1.00: configured for UDMA/100
pdc2027x_set_piomode: adev->pio_mode[C]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[4]
pdc2027x_set_dmamode: Set udma regs...
pdc2027x_set_dmamode: Set udma regs done
pdc2027x_set_dmamode: Set to udma mode[5]
pdc2027x_set_piomode: adev->pio_mode[8]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[0]
pdc2027x_set_piomode: adev->pio_mode[8]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[0]
pdc2027x_cable_detect: No cable or 80-conductor cable on port 1
scsi 0:0:0:0: Direct-Access     ATA      LEXAR ATA FLASH  2007 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 7831152 512-byte hardware sectors (4010 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 7831152 512-byte hardware sectors (4010 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DPO or FUA
 sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
pdc2027x_set_piomode: adev->pio_mode[8]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[0]
pdc2027x_set_piomode: adev->pio_mode[8]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[0]
ata1: soft resetting link
pdc2027x_cable_detect: No cable or 80-conductor cable on port 0
pdc2027x_set_piomode: adev->pio_mode[C]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[4]
pdc2027x_set_dmamode: Set udma regs...
pdc2027x_set_dmamode: Set udma regs done
pdc2027x_set_dmamode: Set to udma mode[5]
ata1.00: configured for UDMA/100
pdc2027x_set_piomode: adev->pio_mode[C]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[4]
pdc2027x_set_dmamode: Set udma regs...
pdc2027x_set_dmamode: Set udma regs done
pdc2027x_set_dmamode: Set to udma mode[5]
ata1: EH complete
ata1.00: limiting speed to UDMA/66:PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
pdc2027x_set_piomode: adev->pio_mode[8]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[0]
pdc2027x_set_piomode: adev->pio_mode[8]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[0]
ata1: soft resetting link
pdc2027x_cable_detect: No cable or 80-conductor cable on port 0
pdc2027x_set_piomode: adev->pio_mode[C]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[4]
pdc2027x_set_dmamode: Set udma regs...
pdc2027x_set_dmamode: Set udma regs done
pdc2027x_set_dmamode: Set to udma mode[4]
ata1.00: configured for UDMA/66
pdc2027x_set_piomode: adev->pio_mode[C]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[4]
pdc2027x_set_dmamode: Set udma regs...
pdc2027x_set_dmamode: Set udma regs done
pdc2027x_set_dmamode: Set to udma mode[4]
ata1: EH complete
ata1.00: limiting speed to UDMA/33:PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
pdc2027x_set_piomode: adev->pio_mode[8]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[0]
pdc2027x_set_piomode: adev->pio_mode[8]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[0]
ata1: soft resetting link
pdc2027x_cable_detect: No cable or 80-conductor cable on port 0
pdc2027x_set_piomode: adev->pio_mode[C]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[4]
pdc2027x_set_dmamode: Set udma regs...
pdc2027x_set_dmamode: Set udma regs done
pdc2027x_set_dmamode: Set to udma mode[2]
ata1.00: configured for UDMA/33
pdc2027x_set_piomode: adev->pio_mode[C]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[4]
pdc2027x_set_dmamode: Set udma regs...
pdc2027x_set_dmamode: Set udma regs done
pdc2027x_set_dmamode: Set to udma mode[2]
ata1: EH complete
ata1.00: limiting speed to PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
pdc2027x_set_piomode: adev->pio_mode[8]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[0]
pdc2027x_set_piomode: adev->pio_mode[8]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[0]
ata1: soft resetting link
pdc2027x_cable_detect: No cable or 80-conductor cable on port 0
pdc2027x_set_piomode: adev->pio_mode[C]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[4]
ata1.00: configured for PIO4
pdc2027x_set_piomode: adev->pio_mode[C]
pdc2027x_set_piomode: Set pio regs...
pdc2027x_set_piomode: Set pio regs done
pdc2027x_set_piomode: Set to pio mode[4]
pdc2027x_set_mode: Turn on prefetch
ata1: EH complete
 sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk


Can anyone shed any light on what is causing the exceptions?
