Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 8016DDDF50
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 06:52:29 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 06 May 2008 22:52:26 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20080506205226.210060@gmx.net>
MIME-Version: 1.0
Subject: Strange build error in boot/wrapper script
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I get a rather strange error here with kernel v2.6.26-rc1 and gcc version
4.1.2 20061115 (prerelease) (Debian 4.1.1-21) (cross compile version).
This is the output of the build process:

> $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- zImage
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
>   CALL    arch/powerpc/kernel/systbl_chk.sh
>   CALL    arch/powerpc/kernel/prom_init_check.sh
>   WRAP    arch/powerpc/boot/uImage
> Image Name:   Linux-2.6.26-rc1
> Created:      Tue May  6 22:43:54 2008
> Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> Data Size:    1780300 Bytes = 1738.57 kB = 1.70 MB
> Load Address: 0x00000000
> Entry Point:  0x00000000
> arch/powerpc/boot/dtc -O dtb -o arch/powerpc/boot/amigaone.dtb -b 0  /home/geri/AmigaOne/Linux/linux-2.6.26/arch/powerpc/boot/dts/amigaone.dts
> DTC: dts->dtb  on file "/home/geri/AmigaOne/Linux/linux-2.6.26/arch/powerpc/boot/dts/amigaone.dts"
>   WRAP    arch/powerpc/boot/cuImage.amigaone
> powerpc-linux-gnu-objcopy: Warning: could not locate './vmlinux.strip'. reason: The value is too big for the defined data type (translated to English)
> Image Name:   Linux-2.6.26-rc1
> Created:      Tue May  6 22:43:54 2008
> Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> Data Size:    21675 Bytes = 21.17 kB = 0.02 MB
> Load Address: 0x00400000
> Entry Point:  0x00400444
> rm arch/powerpc/boot/amigaone.dtb

As you can see, the wrapper script generates an incomplete cuImage. The
vmlinux.strip file is there, but I wonder why it is so big:

> -rw-r--r--  3225085348 2008-05-06 21:58 vmlinux.strip

Any ideas what is going wrong here? Broken compiler?

Thanks!

regards,

Gerhard

-- 
249 Spiele für nur 1 Preis. Die GMX Spieleflatrate schon ab 9,90 Euro.
Neu: Asterix bei den Olympischen Spielen: http://flat.games.gmx.de
