Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D21CE2BF07
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Jan 2005 23:34:22 +1100 (EST)
From: Marc Dietrich <marvin24@gmx.de>
To: sheutlin@gmx.de
Date: Mon, 3 Jan 2005 13:26:34 +0100
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200412272237.57241.marc.dietrich@ap.physik.uni-giessen.de>
	<1104625860.10369.34.camel@weizen.left.earth>
In-Reply-To: <1104625860.10369.34.camel@weizen.left.earth>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200501031326.34477.marvin24@gmx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Christian,

Am Sonntag, 2. Januar 2005 01:31 schrieb Sebastian Heutling:
> Hi Marc,
>
> On Mon, 2004-12-27 at 22:37 +0100, Marc Dietrich wrote:
> > Hallo Christian,
> >
> > maybe this helps:
> >
> > I used the config file you sent me (and added serial console).
> >
> > when booting a working 2.4.24-pre1 I get:
> >
> > [...]
> > PCI: Probing PCI hardware
> > Setting PCI interrupts for a "Utah (Powerstack II Pro4000)"
> > PCI: moved device 00:0b.1 resource 4 (101) to 1480
> > PCI: moved device 00:0b.1 resource 5 (101) to 1490
> > PCI: moved device 00:11.0 resource 0 (1208) to 0
> > [...]
> > SCSI subsystem driver Revision: 1.00
> > new devtbl    [4096] @c049e000.
> > PCI: Enabling device 00:0c.0 (0000 -> 0003)
> > sym53c8xx: at PCI bus 0, device 12, function 0
> > sym53c8xx: setting PCI_COMMAND_MASTER PCI_COMMAND_PARITY...(fix-up)
> > sym53c8xx: changing PCI_LATENCY_TIMER from 0 to 80.
> > sym53c8xx: 53c825a detected
> > sym53c825a-0: rev 0x13 on pci bus 0 device 12 function 0 irq 15
> > new MPOOL     [ 188] @c049f000.
> > new VTOB      [  12] @c049f100.
> > new NCB       [2408] @c049c000.
> > new SQUEUE    [2336] @c049d000.
> > new VTOB      [  12] @c049f110.
> > new DQUEUE    [2336] @c049a000.
> > new TARGTBL   [ 256] @c049b000.
> > new VTOB      [  12] @c049f120.
> > new SCRIPT    [3504] @c0498000.
> > new SCRIPTH   [1504] @c049b800.
> > new CCB       [1300] @c0499000.
> > sym53c825a-0: ID 7, Fast-10, Parity Checking
> >
> > I already changed the irq of slot 12 to 15 and slot 14 to irq 11.
>
> You don't really need to change any IRQ above slot 9 on a 2.6.? kernel
> because the slot is 2 (while it was on 12 in 2.4 kernels).

ah yes, now I understand. You just copied all numbers from top to down. 

> > [...]
> > PCI: Probing PCI hardware
> > Setting PCI interrupts for a "Utah (Powerstack II Pro4000)"
> > PCI: Cannot allocate resource region 5 of device 0000:00:01.1
>
> This is the IDE chip which gets IRQ 0 and therefore results in an error.
> Try changing the value of Slot 1 from 0 to 4 (which is IRQ 14). I don't
> really think it changes the SCSI timeouts maybe it helps - no one knows
> for sure ;).

Ok - did that also.

> > SCSI subsystem initialized
> > [...]
> > PCI: Enabling device 0000:00:02.0 (0000 -> 0003)
> > sym0: <825a> rev 0x13 at pci 0000:00:02.0 irq 15

so I guess 0000:00:02.0 is right as oposed to 0000:00:0C.0 with 2.4 kernels.

> > [...]
> > new BADLUNTBL [ 256] @c7d9aa00.
> > sym0: SCSI BUS has been reset.
> > scsi0 : sym-2.1.18m
> > elevator: using anticipatory as default io scheduler
> > sym0:0:0:ccb @c7d9ac00 using tag 256.
> > sym0: queuepos=2.
> > sym0:0:0: ABORT operation started.
> > sym0:0:0: ABORT operation timed-out.
> > sym0:0:0: DEVICE RESET operation started.
> > sym0:0:0: DEVICE RESET operation timed-out.
> > sym0:0:0: BUS RESET operation started.
> > sym0:0:0: BUS RESET operation timed-out.
> > sym0:0:0: HOST RESET operation started.
> > sym0:0:0:ccb @c7d9ac00 freeing tag 256.
> > sym0: SCSI BUS has been reset.
> > [ hangs here ]
>
> Hmmm strange ... is there anything attached on scsi?

Yes - a hard disk and a cdrom. Both are working under 2.4 kernels (see the 
boot.log of the 2.4.24-pre1 kernel). I don't use net boot. My system (debian 
sarge) is installed on sda3. Anyway - also on a netboot system, the kernel 
should hang when trying to initialize the scsi controler.

> ... wait a second ... looking at the lspci output ... you use a USB PCI
> card? The IRQ-sharing doesn't work well and the USB PCI card is on the
> same slot as the SCSI controller resulting in both using the same IRQ.
> Remove the USB card and check wether it changes anything. If it does
> work now: Did it ever work with USB using another kernel? If so maybe
> there is something else wrong, if not it's a HW Problem.
> I also attached a config file from my powerstack (which I use as a
> router and runs a 2.6 kernel since june last year or so)

I didn't checked if the usb card is working under a 2.4 kernel, but it boots 
without problems. I removed it now, just to eleminate possible trouble.

I setup a kernel using your config file and added vga console and offb and 
removed the nfs drivers to get an image smaller then 1.44 Mb (I'm using 
XFree86-3.3.6 with the cirrus 5664 card). This has the same effect than 
before: scsi not working. 

It seems, that this config is not for a 2.6.10 kernel. What kernel version are 
you using? Maybe some bad things happened in newer kernels.
Can you put a working zImage.prep somewhere on the web (<1.44 MB, so I can 
write it to a floppy disk)? 
How does your boot.log looks like?

Greetings

Marc
