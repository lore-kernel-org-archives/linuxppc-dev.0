Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 986DA67A79
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Mar 2005 21:42:07 +1100 (EST)
Message-ID: <422C30CF.5010906@anagramm.de>
Date: Mon, 07 Mar 2005 11:45:35 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <58ddcf3f9fe35315256e2fa3d7361081@freescale.com>
In-Reply-To: <58ddcf3f9fe35315256e2fa3d7361081@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcembed Mailing List <linuxppc-embedded@ozlabs.org>
Subject: Re: gcc-3.3.3 from YDL4 problems?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Kumar!

> Has anyone else had any issues with building kernels (2.6.11) with 
> gcc-3.3.3 from YDL4.  Ran into a problem today were a 2.6.11 build for 
> MPC8540 ADS breaks with gcc-3.3.3 but works ok with a 3.4.3.

You know that I build the mpc8540_ads also.
I use the Denx ELDK 3.1 with gcc 3.3.3 and it breaks due to an unknown
rfci instruction:

$ make
   CHK     include/linux/version.h
   CC      scripts/mod/empty.o
   MKELF   scripts/mod/elfconfig.h
   HOSTCC  scripts/mod/file2alias.o
   HOSTCC  scripts/mod/modpost.o
   HOSTCC  scripts/mod/sumversion.o
   HOSTLD  scripts/mod/modpost
   CC      arch/ppc/kernel/asm-offsets.s
   CHK     include/asm-ppc/offsets.h
   CC      init/main.o
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   CC      init/do_mounts.o
   CC      init/do_mounts_devfs.o
   CC      init/do_mounts_rd.o
   CC      init/do_mounts_initrd.o
   LD      init/mounts.o
   CC      init/initramfs.o
   CC      init/calibrate.o
   LD      init/built-in.o
   CHK     usr/initramfs_list
   AS      usr/initramfs_data.o
   LD      usr/built-in.o
   AS      arch/ppc/kernel/entry.o
arch/ppc/kernel/entry.S: Assembler messages:
arch/ppc/kernel/entry.S:800: Error: Unrecognized opcode: `rfci'
make[1]: *** [arch/ppc/kernel/entry.o] Error 1
make: *** [arch/ppc/kernel] Error 2

But if I use your powerpc-linux-gnuspe-* (cross-)toolchain it
builds fine. Maybe some compile options for 3.3.3 might be sufficient
to fix that... my way is to use 3.4.3.

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
