Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp1.wanadoo.fr (unknown [193.252.22.30])
	by ozlabs.org (Postfix) with ESMTP id 146172BF16
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jan 2005 17:25:26 +1100 (EST)
Date: Mon, 10 Jan 2005 07:34:59 +0100
To: Sebastian Heutling <sheutlin@gmx.de>
Message-ID: <20050110063459.GA22078@pegasos>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200501051733.06350.marvin24@gmx.de>
	<20050105165551.GA29287@pegasos>
	<200501052157.25302.marvin24@gmx.de> <41E1BBA2.30008@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <41E1BBA2.30008@gmx.de>
From: Sven Luther <sven.luther@wanadoo.fr>
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

On Mon, Jan 10, 2005 at 12:17:54AM +0100, Sebastian Heutling wrote:
> Marc Dietrich wrote:
> 
> >Hi all,
> >
> >I didn't recognise that the kernel from Sebastian - which was working fine 
> >here - was build from the debian sources (no hint in the kernel version). 
> >So I build everything again from debian source and fixed the irq's in 
> >prep_pci.c.
> > 
> >
> Erm ... well ... yes - it's a debian kernel ;).

Notice that 2.6.8-9, currently in unstable, has this patch, as well as the d-i
image which will be built in a few hours. The same goes for 2.6.9-4, which i
am uploading and should be in unstable tomorrow evening. For d-i, we have to
wait for the 2.6.8-9 kernel to enter testing so it is fully operational. In
the meantime, you have to :

1) when you reach partman, you have to switch to console 2, or go back unto
the main menu and chose shell console if on serial console, and run parted by
hand and create the prep-boot partition (set 1 prep on). An 8MB prep partition
would be ideal.

2) you *have* to use /dev/hda3 as /. The debian kernel is configured for that,
and there is not yet a way to modify this.

3) after base-install, you will get the no bootloader message, telling you the
root path, there you have to go into a shell again, chroot to /target, and
wget the unstable 2.6.8-9 kernel (or othrwise apt-get it, but this needs
modifying the /etc/apt/sources.list to include unstable).

4) once the kernel is installed, you exit the chroot, and simply need to dd
the kernel to the prep partition with :

  # dd if=/target/boot/vmlinuz-2.6.8-powerpc of=/dev/scsi/host3/bus0/target0/lun0/part1

(or whatever your disk is, in devfs paths).

You have to use the daily-builds d-i images, not RC2 obviously. All these
steps will be made unnecessary once the 2.6.8-9 kernel makes it to testing (in
2-3 days), and i upload both partman-prep (which allow to set the prep
partition in partman), and prep-installer (which takes care of dd-ing the
kernel).

2.6.10 powerpc kernels will follow, but they may be some time in the NEW
queue.

> >I can confirm now, that this debian+irq_fix kernel 2.6.8 runs fine and 
> >produces no scsi timeouts!
> >
> >Something happend in kernels >= 2.6.9 which makes the scsi unusable. Also 
> >it seems, that even in 2.6.8 kernels and with ide hard disks (Sebastians 
> >setup) the scsi controller timeouts, but continues to operate - correct?
> > 
> >
> 
> Yep correct.
> I also tried the 2.6.10 and found out that it doesn't work here as well. 
> First I get a lot of lost interrupts from the IDE driver and after that 
> I also get the SCSI timeouts. It must have something to do with the prep 
> changes in 2.6.9. One difference in IRQ setup I noticed is in 
> prep_pcibios_fixup(). If I remember correctly before 2.6.9 at least on 
> this Utah machine the IRQs are assigned from Motherboard_routes[] 
> without doing anything else. Now additionally the IRQ is also written 
> into the devices pci config space which might not work on the 
> PowerstackII Utah.
> It's only a guess and I haven't had the time yet to test it.

Can you try the debian kernels i upload and fill bugreports against them ?

Friendly,

Sven Luther
