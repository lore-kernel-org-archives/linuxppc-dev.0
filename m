Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp5.wanadoo.fr (smtp5.wanadoo.fr [193.252.22.26])
	by ozlabs.org (Postfix) with ESMTP id 9CF1B2BDB5
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Jan 2005 17:57:47 +1100 (EST)
Date: Mon, 3 Jan 2005 08:05:35 +0100
To: mikemartin@linux.ca
Message-ID: <20050103070535.GA1644@pegasos>
References: <20050101150055.GA15400@pegasos>
	<200501011630.j01GUP1R007603@arbas.nms.ulrich-teichert.org>
	<20050101165758.GA18559@pegasos>
	<855e88d00501011715633922b2@mail.gmail.com>
	<855e88d0050102201540148511@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <855e88d0050102201540148511@mail.gmail.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 02, 2005 at 11:15:35PM -0500, Mike Martin wrote:
> Now I'm very confused .... on my next reboot ... the network wouldn't
> work. After much trial and error, I got the current unstable d-i image
> to work. It did it all right up to the reboot (where is warns you that
> it doesn't have a boot loader installed).

There may be some problems with 2.6 kernels and pci irqs on prep. I will
investigate this shortly.

There is indeed no prep boot-loader installer available. I hear there is a
partman-prep prepared, but not yet part of d-i. more to this below.

> Now what!
> 
> I have an installed system, but I can't figure out how to boot it! I
> have /boot/vmlinux on /dev/sdb1 and a root on /dev/sdb1. How do I
> write a boot sector or tell OpenFirmware to boot from this file? I
> tried to netboot and set root=/dev/sdb1 - but without the scsi modules
> loaded it fails to read the drives and panics.

You need to install mkvmlinuz, i think it is already, but not use
/boot/vmlinux-2.6.8-powerpc, but /boot/vmlinuz-2.6.8-powerpc, which is the
result of mkvmlinuz adding the initrd containing the modules onto the kernel,
and then adding the prep simple bootloader. Check if you have the
vmlinuz-2.6.8-powerpc, which should have been generated at install time, and
copy it to your netboot tftp server, and try again. It should even recognize
the root= partition automatically.

> I think I neet to create a type 41 PReP boot partition and get the
> kernel onto it. I've found this thread:
> http://lists.gnu.org/archive/html/bug-parted/2002-09/msg00016.html
> 
> and this:
> http://www.yellowdoglinux.com/support/solutions/champion_server/rs6k.shtml

Yep. Until partman-prep is ready, you should simply try to add the prep flag
to the a small partition. I think the normal scheme is to create /dev/sdb1 as
a small (8MB ?) prep partition, /dev/sdb2 as swap, and /dev/sdb3 as /. If
partman is not able to do it, jump to console 2, and launch parted directly,
and do a set 1 prep on.

Then i suppose that copying the kernel is just a matter of :

  dd if=/boot/vmlinuz-2.6.8-powerpc of=/dev/sdb1

but you have to have a small prep partition as /dev/sdb1, or the above will
erase whatever you have on /dev/sdb1.

> I tried booting up with the installer, going to a shell after the scsi
> was active and the installed system was mounted. I used sfdisk from
> /target/sbin to create a 10 Meg type 41 partition on the first HD
> (/dev/sdb0 eventually). I used dd to copy /target/boot/vmlinux to this
> partition. But it still won't boot.

Ah, no sure what is wrong. I don't think /dev/sdb0 exists. Not sure really.

> I'm very close. If I can get the system to boot (really it needs to
> boot itself - not netboot) I'd call this a success.

Friendly,

Sven Luther
