Return-Path: <leigh@solinno.co.uk>
Received: from titan.server-plant.co.uk (titan.server-plant.co.uk [80.71.3.50])
	by ozlabs.org (Postfix) with ESMTP id 69F9A2BDB5
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 04:21:47 +1100 (EST)
Message-ID: <33304.82.10.231.190.1104771000.squirrel@82.10.231.190>
In-Reply-To: <200501031551.j03FpLAn009525@arbas.nms.ulrich-teichert.org>
References: <855e88d0050103053915c385ec@mail.gmail.com> from "Mike Martin" at
	Jan 03, 2005 08:39:43 AM
	<200501031551.j03FpLAn009525@arbas.nms.ulrich-teichert.org>
Date: Mon, 3 Jan 2005 16:50:00 -0000 (GMT)
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Ulrich Teichert" <krypton@ulrich-teichert.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	mikemartin@linux.ca, debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ulrich Teichert said:
>>[snip]
>>> There may be some problems with 2.6 kernels and pci irqs on prep. I
>>> will
>>> investigate this shortly.
>>
>>There is definitely something strange happening. The image I used to
>>do the (nearly) complete install will no longer configure the network.
>>Very inconsistent. I will try it (same image) again later today and
>>see if it "just works" next time - like it did last time.
>
> Yes, I've seen inconsistencies as well, like booting the default kernel
> from a sarge CD worked *once* and rebooting not. I found out why:
> during the first cold boot, the firmware asks if it should make my
> serial console the active console (which I acknowledged), but with a
> warm boot, this question is not asked again.

That's because the firmware will only ask that question if detects that
a mouse or keyboard is present/not present where it previously was/n't.

> This seems to result in a different setting and the kernel is not able
> to figure out that it is running on a serial console. According to Leigh
> Browns, it is not possible to give the kernel parameters on boot-up,
> unless you are using his patches, so this may be another issue.

I have a patch you can use to specify parameters on the *command line*
(e.g. boot floppy: root=/dev/sda3 ...).  However, you can always type
parameters on the serial console as it boots (see below).

> But this is how far the default kernel (which is all I can load from CD)
> boots:
>
> 0 > setenv load-base 1000000  ok
> 0 > setenv real-base c00000  ok
> 0 > boot cdrom:
>
> loaded at:     01000400 01492FF4
> relocated to:  00800000 00C92BF4
> zimage at:     0080A94C 0093E3DC
> initrd at:     0093F000 00C884AE
> avail ram:     00400000 00800000
>
> Linux/PPC load: console=ttyS0,9600 console=tty0

*** This is the point you get 5 seconds to start editing the parameters.
I guess if you specify root=/dev/ram0 or something then it will boot
from the ramdisk, rather than trying to boot from /dev/sda3.

> Uncompressing Linux...done.
> Now booting the kernel
> Total memory = 256MB; using 512kB for hash table (at c0300000)
> Linux version 2.6.8-powerpc (sven@pegasos2) (version gcc 3.3.5 (Debian
> 1:3.3.5-2)) #1 Thu Dec 9 10:27:54 CET 2004
> PReP architecture
[...]
> VFS: Cannot open root device "<NULL>" or unknown-block(8,3)
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on unknown-block(8,3)
>  <0>Rebooting in 180 seconds..

Other than that, it's a nice clean boot.

> [del]
>>> Then i suppose that copying the kernel is just a matter of :
>>>
>>>   dd if=/boot/vmlinuz-2.6.8-powerpc of=/dev/sdb1
>>>
>>> but you have to have a small prep partition as /dev/sdb1, or the above
>>> will
>>> erase whatever you have on /dev/sdb1.
>
> This is not enough. You need to set the kernel arguments with Leigh's
> preptool (which is a simple perl script), because of the problems
> mentioned before.

Well, you need to have my patch for that.  There are other ways to
manually change the boot arguments (like hexedit etc).

>>I' have the partition ready ...
>>
>>Unfortunately, until the network comes back up, I can't get far enough
>>in the install to access the SCSI drives (is there another way? Load
>>the modules by hand? Which ones?). Without this, I can't get at the
>>image I need to boot in order to get it onto the right partition. I
>>also can't get it to another machine to net boot it.
>
> All this initrd thing is a mess when it gets complicated, if you ask me.
> I really don't know why your floppy stops working after booting Leighs
> kernel. But on the other hand, I don't know why I can't netboot my box
> either - I can netboot anything else from DECstations to SGIs with the
> same setup, but my 7043-44 refuses to load the kernel. It contacts the
> server, figures out the name of the file, but does not request it.
>
> For your network trouble, try to disconnect power from the box completely
> for an hour or so. This was enough for my box to fall back to asking me
> for the active console, maybe this works for your flaky network as well?

It should never ask the console question again unless you change the
config (plug in a mouse for example), unless your nvram battery is a
bit flat of course!
