Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp8.wanadoo.fr (smtp8.wanadoo.fr [193.252.22.23])
	by ozlabs.org (Postfix) with ESMTP id 7B24C2BDB5
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 04:20:03 +1100 (EST)
Date: Mon, 3 Jan 2005 18:28:03 +0100
To: Leigh Brown <leigh@solinno.co.uk>
Message-ID: <20050103172803.GA17181@pegasos>
References: <855e88d0050103053915c385ec@mail.gmail.com>
	<200501031551.j03FpLAn009525@arbas.nms.ulrich-teichert.org>
	<33304.82.10.231.190.1104771000.squirrel@82.10.231.190>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <33304.82.10.231.190.1104771000.squirrel@82.10.231.190>
From: Sven Luther <sven.luther@wanadoo.fr>
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

On Mon, Jan 03, 2005 at 04:50:00PM -0000, Leigh Brown wrote:
> Ulrich Teichert said:
> > This seems to result in a different setting and the kernel is not able
> > to figure out that it is running on a serial console. According to Leigh
> > Browns, it is not possible to give the kernel parameters on boot-up,
> > unless you are using his patches, so this may be another issue.
> 
> I have a patch you can use to specify parameters on the *command line*
> (e.g. boot floppy: root=/dev/sda3 ...).  However, you can always type
> parameters on the serial console as it boots (see below).

Mmm, is this one already present in the debian 2.6.8 kernel packages ? If not
we would probably want to include it. I am currently preparing a bunch of prep
patches, so it is a good idea to include this one too. How is it related to
the below command line prompt thingy ...

> > But this is how far the default kernel (which is all I can load from CD)
> > boots:
> >
> > 0 > setenv load-base 1000000  ok
> > 0 > setenv real-base c00000  ok
> > 0 > boot cdrom:
> >
> > loaded at:     01000400 01492FF4
> > relocated to:  00800000 00C92BF4
> > zimage at:     0080A94C 0093E3DC
> > initrd at:     0093F000 00C884AE
> > avail ram:     00400000 00800000
> >
> > Linux/PPC load: console=ttyS0,9600 console=tty0

... This one i mean.

> *** This is the point you get 5 seconds to start editing the parameters.
> I guess if you specify root=/dev/ram0 or something then it will boot
> from the ramdisk, rather than trying to boot from /dev/sda3.

d-i is perfectly happy to just boot without any argument.

> > Uncompressing Linux...done.
> > Now booting the kernel
> > Total memory = 256MB; using 512kB for hash table (at c0300000)
> > Linux version 2.6.8-powerpc (sven@pegasos2) (version gcc 3.3.5 (Debian
> > 1:3.3.5-2)) #1 Thu Dec 9 10:27:54 CET 2004
> > PReP architecture
> [...]
> > VFS: Cannot open root device "<NULL>" or unknown-block(8,3)
> > Please append a correct "root=" boot option
> > Kernel panic: VFS: Unable to mount root fs on unknown-block(8,3)
> >  <0>Rebooting in 180 seconds..
> 
> Other than that, it's a nice clean boot.

Indeed.

> > [del]
> >>> Then i suppose that copying the kernel is just a matter of :
> >>>
> >>>   dd if=/boot/vmlinuz-2.6.8-powerpc of=/dev/sdb1
> >>>
> >>> but you have to have a small prep partition as /dev/sdb1, or the above
> >>> will
> >>> erase whatever you have on /dev/sdb1.
> >
> > This is not enough. You need to set the kernel arguments with Leigh's
> > preptool (which is a simple perl script), because of the problems
> > mentioned before.
> 
> Well, you need to have my patch for that.  There are other ways to
> manually change the boot arguments (like hexedit etc).

Could you post it ? Anything else you are aware that we should add in our
2.6.8 powerpc kernels which is PReP related ? 

Friendly,

Sven Luther
