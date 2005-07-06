Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id B421167C3A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 19:12:38 +1000 (EST)
To: "Russell McGuire" <rmcguire@uwbt.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 05 Jul 2005 21:41:04 PDT."
	<20050706004122.GA42545@mail19d.g19.rapidsite.net>
Date: Wed, 06 Jul 2005 11:10:07 +0200
Sender: wd@denx.de
Message-Id: <20050706091007.E6CDF353A6A@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux 2.4.25 problems after initrd detected 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050706004122.GA42545@mail19d.g19.rapidsite.net> you wrote:
> 
> Two questions: 
> 1) Does the "Warning: Real time clock stuck" pose any problem to getting the
> initrd loaded? Or perhaps interrupts?

It should not affect thte opration of the ramdisk, but it's obviously
something you should fix.

> 2) Does the MTD physical mapping driver have to be enabled for the initrd to
> work, I haven't been able to get my driver to successfully complete a
> ioremap if I enable it. I am using AMD 32MB flash mapped physically at
> 0xE0000000 at least in Uboot.

Ramdisk and MTD have nothingin common. You don;t need MTD to use a ramdisk

> I know the kernel is still marginally alive as I can step into the kernel
> debugger over the serial port at this point, if I press control C, its in
> the interrupt routines waiting for UART interrupts.
> 
> I apologize in advance if I have not provided enough info, as its my first
> post.

Well, the most important thing you missed to tell us is what  exactly
your problem is.

> Here is the output, from Uboot.
....
> Kernel command line: root=/dev/ram rw
...
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 56k init
> 
> <-- No more output, unless control C is pressed and "sometimes" it will

So what? You did not pass any "console=ttyS0,$(baudrate)" or  somilar
boot argument, so where is your console expected to show up?

Can you ping the system? Our standard ramdisk images have telnet  and
FTP enabled. Can you telnet into the system?

Did you try booting with root file system mounted over NFS?  This  is
MUCH easier to debug.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I wish Captain Vimes were here. He wouldn't have  known  what  to  do
either, but he's got a much better vocabulary to be baffled in.
                                 - Terry Pratchett, _Guards! Guards!_
