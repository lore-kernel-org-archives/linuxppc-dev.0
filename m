Return-Path: <jchapman@katalix.com>
Message-ID: <42272372.6020908@katalix.com>
Date: Thu, 03 Mar 2005 14:47:14 +0000
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
To: T T <tath76@yahoo.com>
References: <20050303085616.34381.qmail@web51404.mail.yahoo.com>
In-Reply-To: <20050303085616.34381.qmail@web51404.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: linux on xc2vp4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

T T wrote:

> I would like to port linux kernel to a custom board that contains xc2vp4 
> (xilinx fpga) which it include powerpc 405 hard core, uartlite, spi 
> controller, sdram controller.  I don't how to start because I am new to 
> linux os.  Any help is welcome.

The best way to learn is to look at the code of a similar board. 
Directories that will contain interesting code are

arch/ppc/platforms
arch/ppc/boot/simple
arch/ppc/syslib

In the platforms directory, look for a board that is similar to one that
you are already familiar with and grep the source tree for its config
option (see the Kconfig files). Study the code that is covered by the
config option. Don't restrict your search to C files; even Makefiles
will contain conditional statements on config options.

The first place to start in writing new board support is creating
a new arch/ppc/platforms/xxx.c file. Study code to see how those
routines init the system and setup the ppc_md structure. For ppc,
arch/ppc/kernel/head*.S contains assembly startup code for each
supported CPU family. It's a good place to start when finding out how a
ppc system is initialized.

Code in arch/ppc/boot/simple implements a simple boot loader. A zImage
file contains the boot loader and a compressed kernel image. If your
board has u-boot support (unlikely) then you don't need anything in
arch/ppc/boot/simple for your board - u-boot can load plain vmlinux
kernel images. Depending on your bootloader, this might be the first
thing you need to implement.

In arch/ppc/syslib you'll find support for common chips found on ppc
boards. Typically platform code hooks up required files from this area.
For other devices like serial, i2c, flash etc that are used by more than
one CPU architecture, check other (non-ppc specific) parts of the kernel
tree. Before writing any new code for a chip, scan appropriate mail
archives to find if any patches are already available.

Work towards getting the kernel running to the point where it panics due
to no root filesystem being found. There will be a lot of work in
getting there though. Getting the serial port working is usually one
of the first things to do. Don't concern yourself yet with anything that
goes into the root filesystem; you can ask for help on that later when 
you get there.

I hope this was helpful. You might also find the following book useful.

http://www.oreilly.com/catalog/belinuxsys/

Good luck!

-- 
James Chapman
http://www.katalix.com/
