Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (mail-ex.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C922567A86
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 19:29:53 +1100 (EST)
Date: Mon, 7 Feb 2005 09:29:48 +0100
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
	Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20050207082948.GB29823@suse.de>
References: <20050206124014.GA5880@suse.de>
	<20050206215131.GF7686@smtp.west.cox.net>
	<20050206225323.GA16821@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050206225323.GA16821@mars.ravnborg.org>
Subject: Re: make -j12 all fails in uImage target
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Feb 06, Sam Ravnborg wrote:

> Something like this may do the trick:
> 
> $(obj)/images: $(addprefix $(obj)/,$(subdir-y) $(bootdir-y))
> 	$(Q)$(MAKE) $(build)=$@
> 
> And then delete the assignment of images to subdir-y

That still doesnt work right, I touched one .c file which lead to a new
vmlinux, now zImage.rs6k is too small:

diff -purNx tags ../linux-2.6.11-rc3.orig/arch/ppc/boot/Makefile ./arch/ppc/boot/Makefile
--- ../linux-2.6.11-rc3.orig/arch/ppc/boot/Makefile     2005-02-03 02:56:10.000000000 +0100
+++ ./arch/ppc/boot/Makefile    2005-02-07 09:24:38.713179331 +0100
@@ -17,8 +17,10 @@ BOOT_TARGETS = zImage zImage.initrd znet
 
 bootdir-y                      := simple
 bootdir-$(CONFIG_PPC_OF)       += openfirmware
-subdir-y                       := lib common images
+subdir-y                       := lib common
 subdir-$(CONFIG_PPC_OF)                += of1275
+$(obj)/images: $(addprefix $(obj)/,$(subdir-y) $(bootdir-y))
+       $(Q)$(MAKE) $(build)=$@
 
 # for cleaning
 subdir-                                += simple openfirmware

  CHK     include/linux/version.h
make[2]: `arch/ppc/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-ppc/offsets.h
  CHK     usr/initramfs_list
  CHK     include/linux/compile.h
  CC      arch/ppc/platforms/chrp_nvram.o
  LD      arch/ppc/platforms/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  OBJCOPY arch/ppc/boot/images/vmlinux.bin
  GZIP    arch/ppc/boot/images/vmlinux.gz
  AS      arch/ppc/boot/simple/head.o
  AS      arch/ppc/boot/simple/relocate.o
  CC      arch/ppc/boot/simple/prepmap.o
  GEN     arch/ppc/boot/openfirmware/image.o
  CC      arch/ppc/boot/simple/misc.o
  GEN     arch/ppc/boot/images/miboot.image
  COFF    arch/ppc/boot/openfirmware/coffboot
  ELF     arch/ppc/boot/images/vmlinux.elf-pmac
  CHRP    arch/ppc/boot/images/zImage.chrp
  CC      arch/ppc/boot/simple/misc-prep.o
  CC      arch/ppc/boot/simple/mpc10x_memory.o
  COFF    arch/ppc/boot/images/vmlinux.coff
  ADDNOTE arch/ppc/boot/images/zImage.chrp-rs6k
  kernel: zImage is ready (arch/ppc/boot/images/vmlinux.coff)
...
../O-2.6.11-rc3-b50/arch/ppc/boot/images/:
total 6.2M
drwxr-xr-x  2 olaf users  496 2005-02-07 09:26 ./   
drwxr-xr-x  9 olaf users  224 2005-02-07 09:25 ../  
-rw-r--r--  1 olaf users  256 2005-02-07 09:26 .uImage.cmd
-rw-r--r--  1 olaf users  100 2005-02-07 09:26 .vmlinux.bin.cmd
-rw-r--r--  1 olaf users  119 2005-02-07 09:26 .vmlinux.gz.cmd
-rw-r--r--  1 olaf users  49K 2005-02-07 09:26 miboot.image
-rwxr-xr-x  1 olaf users 2.8M 2005-02-07 09:26 vmlinux.bin*
-rwxr-xr-x  1 olaf users  79K 2005-02-07 09:26 vmlinux.coff*
-rwxr-xr-x  1 olaf users 146K 2005-02-07 09:26 vmlinux.elf-pmac*
-rw-r--r--  1 olaf users 1.3M 2005-02-07 09:26 vmlinux.gz
-rwxr-xr-x  1 olaf users 575K 2005-02-07 09:26 zImage.bugboot*
-rwxr-xr-x  1 olaf users 146K 2005-02-07 09:26 zImage.chrp*
-rw-r--r--  1 olaf users 146K 2005-02-07 09:26 zImage.chrp-rs6k
-rwxr-xr-x  1 olaf users 639K 2005-02-07 09:26 zImage.elf*
lrwxrwxrwx  1 olaf users   12 2005-02-07 09:26 zImage.pmac -> vmlinux.coff*
-rwxr-xr-x  1 olaf users 576K 2005-02-07 09:26 zImage.prep*
