Return-Path: <bodonoghue@codehermit.ie>
Received: from lugano.hostireland.com (lugano.hostireland.com [67.192.77.34])
	by ozlabs.org (Postfix) with ESMTP id 76271DDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 01:53:17 +1100 (EST)
Subject: Re: [PATCH 1/3] 8xx: Analogue & Micro Adder875 board support.
From: Bryan O'Donoghue <bodonoghue@codehermit.ie>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080111200705.GA696@loki.buserror.net>
References: <20080111200705.GA696@loki.buserror.net>
Content-Type: text/plain
Date: Sun, 13 Jan 2008 14:26:12 +0000
Message-Id: <1200234372.3990.24.camel@neuromancer.mindspace>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Greetings Scott.

Using u-boot Adder_config 

U-Boot 1.3.1-g5c740711-dirty (Jan 13 2008 - 13:43:30) - using an ELDK
4.1 uclibc toolchain

I can't boot your board - port.

I've applied your code against Linus' git v2.6.26-rc7 as at today.
I have to apply 

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 31147a0..8c060ca 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -163,7 +163,7 @@ ps3)
     ksection=.kernel:vmlinux.bin
     isection=.kernel:initrd
     ;;
-ep88xc)
+ep88xc|ep405|redboot*)
     platformo="$object/fixed-head.o $object/$platform.o"
     binary=y
     ;;

and

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 18e3271..e426052 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -56,7 +56,7 @@ src-plat := of.c cuboot-52xx.c cuboot-83xx.c
cuboot-85xx.c holly.c \
                cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
                ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c
cuboot-8xx.c \
                cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c
cuboot-bamboo.c \
-               fixed-head.S ep88xc.c cuboot-hpc2.c
+               fixed-head.S ep88xc.c cuboot-hpc2.c redboot-8xx.c 
 src-boot := $(src-wlib) $(src-plat) empty.c

manually since those two fail to apply to Linus' tree - presumably
because they depend on other patches - should I be using -mm or some
other tree here instead ?

I then run

source /opt/eldk/eldk_init ppc_8xx

export ARCH=powerpc

make adder87x-uboot_defconfig

make uImage

cp arch/powerpc/boot/uImage /tftpboot - which is my tftpd root
directory.

In U-Boot then.

=> tftpboot 0x400000 uImage
=> bootm 0x400000

Which doesn't boot.

Attaching a BDI2000 to the target board I see that the kernel is
panicing somewhere around line 104 of arch/powerpc/kernel/prom.c in
of_scan_flat_dt - presumably because the kernel cannot find an
OpenFirmware tree..

I admit not understanding everything I should about where the output
of .dts & dtc "go" with respect to booting Linux.... but, didn't want to
ask on the list - lest I display a "lack of knowledge" ...

Seriously though, could you offer a pointer as to how I run this code on
the Adder875 here ?

My kernel command line is

root=/dev/nfs nfsroot=192.168.1.101:/tftpboot/root_fs rw
ip=192.168.1.202:::::eth0:off console=ttyCPM,115200

I've also tried - in ignorance of how OF works I admit to add the
following options to u-boot to no avail.


/* pass open firmware flat tree */
#define CONFIG_OF_LIBFDT      1
#undef  CONFIG_OF_FLAT_TREE
#define CONFIG_OF_BOARD_SETUP 1
#define CONFIG_OF_HAS_BD_T    1
#define CONFIG_OF_HAS_UBOOT_ENV       1

#define OF_CPU                        "PowerPC,875@0"
#define OF_SOC                        "soc875@ff000000"
#define OF_TBCLK              (bd->bi_busfreq / 4)

Have I missed a step with the .dts & dtc - and is this why
of_scan_flat_dt is failing - or - should the board port simply "just
work" with a 

make dder87x-uboot_defconfig && make uImage ?


I'm sure I've done something obscenely obvious with respect to not
getting the whole OF thing right.... but if you could point to what that
is... I'd be highly appreciative.


Regards,
Bryan
