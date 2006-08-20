Return-Path: <billfink@mindspring.com>
Received: from elasmtp-scoter.atl.sa.earthlink.net
	(elasmtp-scoter.atl.sa.earthlink.net [209.86.89.67])
	by ozlabs.org (Postfix) with ESMTP id C39FD67B7F
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Aug 2006 10:19:01 +1000 (EST)
Date: Sat, 19 Aug 2006 20:18:49 -0400
From: Bill Fink <billfink@mindspring.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
Message-Id: <20060819201849.5e8d6e6c.billfink@mindspring.com>
In-Reply-To: <44E6DAB9.50304@s5r6.in-berlin.de>
References: <20060817230347.GC3440@localhost>
	<20060818012824.22e70b0f.billfink@mindspring.com>
	<44E6DAB9.50304@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux1394-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 19 Aug 2006, Stefan Richter wrote:

> Bill Fink wrote:
> ...
> > on my desktop PowerMac systems, I need a "sleep 2"
> > before the modprobe for sbp2, to get my Firewire disks to work
> > properly.
> 
> What happens if you don't put the pause in there? What disks do you have 
> and what bridge chips are built in? (Please apologize if you reported 
> this before and we didn't come to a solution then.)

First of all this was on a somewhat older 2.6.11.8 kernel without
any hotplug (I'll probably be trying this again soon with a newer
2.6.15-rc5 kernel).  And I was actually booting off this Firewire
disk.  Without the pause I would get:

	Loading sb2.ko module
	sb2: $rev 1219 ...
	Creating block devices
	Creating root device
	Mkrootdev: label fw1-root not found

Then it wouldn't be able to mount the root filesystem, which would
be followed shortly by a kernel panic.

If I put the "sleep 2" before the "modprobe sbp2" then everything
works.  There's a message about initializing SCSI emulation for SBP-2,
followed by the discovery of the Firewire disk and the creation of
the sda device, which then allows the successful mounting of the
root filesystem.

Here's the full linuxrc nash script from the initrd for the working case:

#!/bin/nash

mount -t proc /proc /proc
setquiet
echo Mounted /proc filesystem
echo Mounting sysfs
mount -t sysfs none /sys
echo "Loading ieee1394.ko module"
insmod /lib/ieee1394.ko
echo "Loading ohci1394.ko module"
insmod /lib/ohci1394.ko
sleep 2
echo "Loading raw1394.ko module"
insmod /lib/raw1394.ko
echo "Loading sbp2.ko module"
insmod /lib/sbp2.ko
echo Creating block devices
mkdevices /dev
echo Creating root device
mkrootdev /dev/root
umount /sys
echo 0x0100 > /proc/sys/kernel/real-root-dev
echo Mounting root filesystem
mount -o defaults --ro -t ext3 /dev/root /sysroot
pivot_root /sysroot /sysroot/initrd
umount /initrd/proc

The disk is an 80 GB LaCie Firewire disk, reported by the kernel as:

Aug 19 19:48:01 gwiz kernel: ieee1394: sbp2: Logged into SBP-2 device
Aug 19 19:48:01 gwiz kernel:   Vendor: ST380021  Model: A                 Rev: 3.05
Aug 19 19:48:01 gwiz kernel:   Type:   Direct-Access-RBC                  ANSI SCSI revision: 04
Aug 19 19:48:01 gwiz kernel: SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Aug 19 19:48:01 gwiz kernel: sda: asking for cache data failed
Aug 19 19:48:01 gwiz kernel: sda: assuming drive cache: write through
Aug 19 19:48:01 gwiz kernel: SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Aug 19 19:48:01 gwiz kernel: sda: asking for cache data failed
Aug 19 19:48:01 gwiz kernel: sda: assuming drive cache: write through
Aug 19 19:48:01 gwiz kernel:  sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10 sda11
Aug 19 19:48:01 gwiz kernel: sd 1:0:0:0: Attached scsi disk sda
Aug 19 19:48:01 gwiz kernel: sd 1:0:0:0: Attached scsi generic sg0 type 14

The above messages are actually from booting (non-Firewire) the
newer 2.6.15-rc5 kernel.

						-Bill
