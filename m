Return-Path: <likunarmstrong@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.239])
	by ozlabs.org (Postfix) with ESMTP id 18925DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 23:13:06 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id e11so1016642qbe
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 06:13:05 -0700 (PDT)
Message-ID: <c46c91d0708100613m61d8a6d9gc4ca8b379e59fca6@mail.gmail.com>
Date: Fri, 10 Aug 2007 21:13:04 +0800
From: windstorm <likunarmstrong@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: some questions about XUP and the generation of ace file
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all:

I am trying to transfer the Linux onto XUP board. The kernel source I
used is from the git trees from andrei konovalov or grant likely. But
I encounter two questions now.

1 Generally, I should correct the kernel source file
arch/ppc/boot/common/ns16550.c, In that file, changing SERIAL_BAUD
from 9600 to 38400  makes the bootloader talk at 38400. I always do it
when I use standard kernel source. But this time I found out that the
ns16550.c's path is arch/ppc/boot/, not arch/ppc/boot/common/, and
there was no "SERIAL_BAUD" string any more. So, how can I control the
baud rate?

2 I have compiled the kernel and obtained a Image.elf whose size is
1.7MB, and then it's time for creating a system.ace file which I can
put onto a compact flash card.  I Changed the file xupGenace.opt like
the follow:

-jprog
-board user
-target ppc_hw
-hw ./implementation/download.bit
-elf zImage.elf
-configdevice devicenr 1 idcode 0x1127e093 irlength 14 partname xc2vp30
-debugdevice devicenr 1 cpunr 1
-ace system.ace

and executed the command: xmd -tcl genace.tcl -opt genace.opt

and the result I saw is:  Using GenACE option file : genace.opt
Error: Executable zImage.elf does not contain start address..

I examine the information by google, some said that it's the bug of
development tools without sp, but both my ISE and EDK was patched.
Others said that it's because of the "mb-objdump", we should chage it
into "powerpc-eaci-objdump", and actually I had done this correction.
BUT, the error still here.

Could anyone please to help me about this question? I will be very grateful.

BTW, could any kind person send any basic config file, which had been
proved that the kernel compiled based on it could work good on XUP
board?

Thanks again.
