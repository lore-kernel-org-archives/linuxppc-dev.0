Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav5.bay1.hotmail.com [65.54.244.109])
	by ozlabs.org (Postfix) with ESMTP id C7DE667A7F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jan 2005 00:58:02 +1100 (EST)
Message-ID: <BAY1-DAV565FDDF51898BE3F6E73D8B790@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
Date: Fri, 28 Jan 2005 19:28:13 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: problem executing simple app on ppc target running linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I have a doubt regarding execution of applications on Linux.

I am developing applications to execute on an MPC8260 (PowerPC) target. I
started off by building a toolchain for the target (using Kegel's
crosstool).

The compiler created for my target bears the name
'powerpc-603e-linux-gnu-gcc.'

Then I built the Linux 2.6.10 kernel with this cross-compiler and got the
executable image. I downloaded this image on the target and executed it
successfully. I have now obtained the Linux command prompt.

I am using U-Boot 1.1.1 as the bootloader and am loading the JFFS2 partition
on my Flash directly as the root drive, using the boot argument
'root=/dev/mtdblock3.'

The directory structure on my JFFS2 partition is as follows:

/bin (with Busybox)
/dev
/etc
/home (for my programs)
/lib (currently empty)
/proc (empty)
/sbin
/tmp
/usr - bin, sbin
/var

Now, I built a simple "Hello, World!" application with my cross-compiler
with the following command:

$ powerpc-603e-linux-gnu-gcc -o hello hello.c

When I try to execute the resulting file on my target from the Linux kernel
prompt, I get a message saying:

/home # ./hello
/bin/sh: hello: No such file or directory

When I compile the above file with my native gcc and execute on the target,
I get a message saying:

/home # ./hello
/bin/sh: hello: Line 1: Unexpected '(' in file (or something to that effect)

I know I can't execute apps built with gcc on the target. But why does it
not work even when built with the cross-compiler?

Another thing is, how do I compile applications with shared libraries? And
how do I know which specific shared library files I need to put in the /lib
and /usr/lib folders on my target JFFS2 partition for the program to execute
successfully?

Please give me some guidance. I'm a bit new to Linux.

Regards

Vijay Padiyar
