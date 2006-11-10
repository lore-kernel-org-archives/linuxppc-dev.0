Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by ozlabs.org (Postfix) with ESMTP id E4D4E67E40
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Nov 2006 02:50:24 +1100 (EST)
Received: from [192.168.0.2] (sou45-1-82-229-118-71.fbx.proxad.net
	[82.229.118.71])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7624A4A1F2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Nov 2006 16:50:22 +0100 (CET)
Subject: Modules Problem on ML403
From: alayrac christophe <christophe.alayrac@cresitt.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 10 Nov 2006 17:50:22 +0100
Message-Id: <1163177422.8091.15.camel@localhost.localdomain>
Mime-Version: 1.0
Reply-To: christophe.alayrac@cresitt.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

We succeed to port linux2-4.26 on ML403 board with Montavista RFS on CF
or NFS.

Problems arise when we try to use modules.
We have include gpio modules in the kernel and build follow

make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- dep uImage
make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- modules
the modules_install fail during depmod process because it no supports
cross compiling

I've then think to use the Klingauf scripts (make_modules_install.sh,
depmod.pl) but I was afraid that the command 
make modules_install copy modules in the host lib/modules directory.

SO I manually proceed as follow from the kernel root :
make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- modules_install
INSTALL_MOD_PATH=/home/alayrac/

and then 
./depmod.pl -k ./vmlinux -F ./System.map -b /home/alayrac/lib/modules -n
> /home/alayrac/lib/modules/2.4.26/modules.dep 

Modules seems to be created properly but after board and linux start up
I receive the following error message:

insmod xilinx_gpio
Using /lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o
/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o:
couldn't find the kernel version the module was compiled for

modprobe xilinx_gpio
/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o:
couldn't find the kernel version the module was compiled
r/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o:
insmod /lib/modules/2.4.26/kernel/drivers/char/xilinx_gpid/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio.o: couldn't find the kernel version the module was compiled for
/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio.o:
insmod /lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio.o failed
/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio.o: insmod
xilinx_gpio failed

Further more the date of files in /lib/modules/2.4.26 are to a very hold
date during the boot process. Thus the modules.conf is declared as more
recent than modules.dep.

Any help would be appreciated .

Kinds regards

Chris
