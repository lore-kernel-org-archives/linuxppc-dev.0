Return-Path: <mark@glines.org>
Received: from squawk.glines.org (squawk.glines.org [72.36.206.66])
	by ozlabs.org (Postfix) with ESMTP id EAFAEDDE08
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Dec 2006 04:59:18 +1100 (EST)
Message-ID: <45955760.6020306@glines.org>
Date: Fri, 29 Dec 2006 09:58:56 -0800
From: Mark Glines <mark@glines.org>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: kurobox kernel
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>
	<fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>
	<45902A6F.4000100@glines.org>
	<Pine.LNX.4.60.0612252128530.3424@poirot.grange>
	<459046FE.9030008@glines.org>
	<Pine.LNX.4.60.0612252349040.3424@poirot.grange>
	<45905997.5080403@glines.org>
	<Pine.LNX.4.60.0612260019430.3424@poirot.grange>
	<45918294.3080303@glines.org>
	<Pine.LNX.4.60.0612262159180.3245@poirot.grange>
	<45942EBF.5060201@glines.org>
	<Pine.LNX.4.60.0612282206430.3942@poirot.grange>
	<45945324.20805@glines.org>
	<Pine.LNX.4.60.0612290127180.3942@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0612290127180.3942@poirot.grange>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:
> My config is in the kernel - arch/powerpc/configs/linkstation_defconfig.
> And I don't use IDE, I use PATA, and it works good, I also had problems 
> with IDE, although, not as bad as you describe. Also, you, certainly, need 
> root=/dev/sda1, not hda1, change it in your U-boot environment. As for 
> interrupt numbers - they are correct, and they are (pretty) arbitrary, 
> allocated dynamically. I have:
> 
> lyakh@KURO-BOX:~$ cat /proc/interrupts
>            CPU0
>  16:          0   EPIC      Level     serial
>  17:        230   EPIC      Edge      serial
>  18:       1747   EPIC      Level     i2c-mpc
>  19:     142193   EPIC      Level     eth0
>  20:       1764   EPIC      Level     libata
>  21:    1309856   EPIC      Level     ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
> BAD:         15
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski

Thanks, disabling IDE worked.  It took a couple tries due to a Makefile 
issue (or misunderstanding on my part)... see below.  Now I get to 
figure out why my Gentoo userspace won't boot, which I think is beyond 
the scope of this list :)

NET: Registered protocol family 1
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
linkstation: disarming the AVR watchdog:
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k init
Synchronizing SCSI cache for disk sda:
Restarting system.


One issue I ran into is that "make zImage" does not rebuild an existing 
image, but "make uImage" does... I think the Makefile is missing a 
dependency.  I'll send a patch if I debug this further.  I know the 
"zImage" rule is just there for convenience, but apparently zImage is a 
deeply ingrained habit for me.

paranoid@kuro-2 /usr/src/linux $ make zImage
   CHK     include/linux/version.h
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CHK     include/linux/utsrelease.h
   CC      init/main.o
   CC      init/version.o
   LD      init/built-in.o
   CC      fs/proc/proc_misc.o
   LD      fs/proc/proc.o
   LD      fs/proc/built-in.o
   LD      fs/built-in.o
   GEN     .version
   LD      .tmp_vmlinux1
   KSYM    .tmp_kallsyms1.S
   AS      .tmp_kallsyms1.o
   LD      .tmp_vmlinux2
   KSYM    .tmp_kallsyms2.S
   AS      .tmp_kallsyms2.o
   LD      vmlinux
   SYSMAP  System.map
   SYSMAP  .tmp_System.map
   MODPOST vmlinux
make[1]: `arch/powerpc/boot/zImage' is up to date.
paranoid@kuro-2 /usr/src/linux $ make uImage
   CHK     include/linux/version.h
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CHK     include/linux/utsrelease.h
   CC      init/main.o
   CC      init/version.o
   LD      init/built-in.o
   CC      fs/proc/proc_misc.o
   LD      fs/proc/proc.o
   LD      fs/proc/built-in.o
   LD      fs/built-in.o
   GEN     .version
   LD      .tmp_vmlinux1
   KSYM    .tmp_kallsyms1.S
   AS      .tmp_kallsyms1.o
   LD      .tmp_vmlinux2
   KSYM    .tmp_kallsyms2.S
   AS      .tmp_kallsyms2.o
   LD      vmlinux
   SYSMAP  System.map
   SYSMAP  .tmp_System.map
   MODPOST vmlinux
   WRAP    arch/powerpc/boot/uImage
Image Name:   Linux-2.6.20-rc2-kuroboxHG
Created:      Fri Dec 29 09:43:09 2006
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    1624545 Bytes = 1586.47 kB = 1.55 MB
Load Address: 0x00000000
Entry Point:  0x00000000

Mark
