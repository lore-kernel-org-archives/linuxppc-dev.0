Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from hp3.statik.tu-cottbus.de (hp3.statik.TU-Cottbus.De
	[141.43.120.68]) by ozlabs.org (Postfix) with ESMTP id 802E667BDF
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 19:01:59 +1000 (EST)
Message-ID: <44EAC71A.9080109@s5r6.in-berlin.de>
Date: Tue, 22 Aug 2006 10:58:02 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Bill Fink <billfink@mindspring.com>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
References: <20060817230347.GC3440@localhost>	<20060818012824.22e70b0f.billfink@mindspring.com>	<44E6DAB9.50304@s5r6.in-berlin.de>
	<20060819201849.5e8d6e6c.billfink@mindspring.com>
In-Reply-To: <20060819201849.5e8d6e6c.billfink@mindspring.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux1394-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bill Fink wrote:
>> > on my desktop PowerMac systems, I need a "sleep 2"
>> > before the modprobe for sbp2, to get my Firewire disks to work
>> > properly.
[...]
> First of all this was on a somewhat older 2.6.11.8 kernel without
> any hotplug (I'll probably be trying this again soon with a newer
> 2.6.15-rc5 kernel).  And I was actually booting off this Firewire
> disk.  Without the pause I would get:
[...]
> Then it wouldn't be able to mount the root filesystem, which would
> be followed shortly by a kernel panic.
> 
> If I put the "sleep 2" before the "modprobe sbp2" then everything
> works.  There's a message about initializing SCSI emulation for SBP-2,
> followed by the discovery of the Firewire disk and the creation of
> the sda device, which then allows the successful mounting of the
> root filesystem.
> 
> Here's the full linuxrc nash script from the initrd for the working case:
> 
> #!/bin/nash
> 
> mount -t proc /proc /proc
> setquiet
> echo Mounted /proc filesystem
> echo Mounting sysfs
> mount -t sysfs none /sys
> echo "Loading ieee1394.ko module"
> insmod /lib/ieee1394.ko
> echo "Loading ohci1394.ko module"
> insmod /lib/ohci1394.ko
> sleep 2
> echo "Loading raw1394.ko module"
> insmod /lib/raw1394.ko
> echo "Loading sbp2.ko module"
> insmod /lib/sbp2.ko
> echo Creating block devices
> mkdevices /dev
> echo Creating root device
> mkrootdev /dev/root
> umount /sys
> echo 0x0100 > /proc/sys/kernel/real-root-dev
> echo Mounting root filesystem
> mount -o defaults --ro -t ext3 /dev/root /sysroot
> pivot_root /sysroot /sysroot/initrd
> umount /initrd/proc
> 
> The disk is an 80 GB LaCie Firewire disk, reported by the kernel as:
[...]

OK. Mounting the root FS from a FireWire disk is a somewhat different
matter from normal hotplug. I can see why you need the few seconds pause
between when ohci1394 is loaded and when sbp2 is loaded. With this
pause, it is very likely that ieee1394 was able to discover and scan the
disk's node before sbp2 is loaded. AFAIU, "insmod sbp2" will therefore
not only load the sbp2 code but will also execute sbp2's device probe
routine (i.e. SBP-2 login, creation of the SCSI device, SCSI inquiry,
and attachment of the sd driver to it) before "insmod sbp2" exits.

Another approach would be to put a basically complete hotplug userland
into the initrd and then wait for the disk with the root FS to appear.
(The disk is e.g. known by its FireWire GUID.) Then you wouldn't need
the hardcoded pause to wait until after the SBP-2 disk made its
configuration ROM available and ieee1394 scanned it.

BTW, a few improvements WRT device recognition went into nearly each of
the Linux releases since 2.6.11. I think they are not relevant to most
or all LaCie disks though.

Discovery of SBP-2 devices will always remain an asynchronous
non-deterministic process anyway. But this is true for all SCSI
transports and interconnects. It's just that most other SCSI
interconnect drivers' initialization routines hold off until they fully
scanned their bus --- which makes sense at least for SCSI interconnects
which are not hotplug capable.

Recently there were patches sent to the Linux SCSI mailinglist that add
optional asynchronous and parallelized bus scanning to all of these
traditional drivers too. Emphasis lies on parallelized since this is
primarily meant to speed up the boot process of systems with many SCSI
buses. There is also a callback to notify the system when all buses are
done with scanning in order to know when to proceed with mounting of
filesystems. I have not yet looked into if this can sensibly used in
sbp2. I also didn't watch the merge status of these SCSI patches.
-- 
Stefan Richter
-=====-=-==- =--- =-==-
http://arcgraph.de/sr/
