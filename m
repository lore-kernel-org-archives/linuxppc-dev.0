Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 6BCB7DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Nov 2008 19:19:03 +1100 (EST)
Subject: Re: USB Flash rootfs prep!
From: Joachim Foerster <mls.JOFT@gmx.de>
To: Cristian Axenie <cristian.axenie@gmail.com>
In-Reply-To: <9c789a000811141705k245e4447k8a9be8e4f180c3f8@mail.gmail.com>
References: <9c789a000811141705k245e4447k8a9be8e4f180c3f8@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 15 Nov 2008 09:18:59 +0100
Message-Id: <1226737139.17218.14.camel@md40100b.ft>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Cristian,

On Sat, 2008-11-15 at 03:05 +0200, Cristian Axenie wrote:
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 156k init
> Warning: unable to open an initial console.

Device file /dev/console doesn't seem to exist in your rootfs. 

> Failed to execute /bin/busybox.  Attempting defaults...
> Kernel panic - not syncing: No init found.  Try passing init= option
> to kernel.

It seems that you don't have an executable called /bin/busybox in your
rootfs. Your kernel command line seems to have "init=/bin/busybox"
included?

But, hmmm, it is very strange, at least in your uboot bootargs there is
no such string. Is it because of some default kernel command line (set
before compiling the kernel)?

> Rebooting in 180 seconds..
> 
> Shall I explicitly give the init ? What should be ... init=/sbin/init,
> init=/bin/busybox ????

The rootfs which comes with ELDK "starts" with /sbin/init - it does not
use busybox, right (as far as I can remember)? So you need to specify
"init=/sbin/init" on your kernel command line.

 Joachim
