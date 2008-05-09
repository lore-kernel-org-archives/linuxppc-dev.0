Return-Path: <rider4ever@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.224])
	by ozlabs.org (Postfix) with ESMTP id D8FBDDDF4C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 23:40:46 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i30so1158060wxd.15
	for <linuxppc-dev@ozlabs.org>; Fri, 09 May 2008 06:40:44 -0700 (PDT)
Message-ID: <ed84ed090805090640w11dcfc57r1303ac4fceb482cb@mail.gmail.com>
Date: Fri, 9 May 2008 15:40:44 +0200
From: Fabri <rider4ever@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: MPC5200b MMC over SPI into PSC6
In-Reply-To: <fa686aa40805080832l2492c46l400986472e985d9a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <481F4DFD.1000702@libero.it>
	<fa686aa40805060836o519bff20yf2506676ff1c3e6@mail.gmail.com>
	<4821A551.3060205@libero.it>
	<fa686aa40805070934t77f8b2b0y2799814b4f131bc8@mail.gmail.com>
	<482317E2.7000308@libero.it>
	<fa686aa40805080832l2492c46l400986472e985d9a@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Fabio Tosetto <tosettofabio83@libero.it>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello!
I've seen you guys are playing with a Lite5200b board, so I've decided
to do another attempt with mine.

On Thu, May 8, 2008 at 5:32 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> For example, use "make ARCH=powerpc cuImage.lite5200b" to build an
> image for the lite5200b board.  The build scripts will use the
> lite5200b.dts file in the dts directory for building the image.

If I'm not wrong, the right sequence of commands should be the following:

$ make ARCH=powerpc mpc5200_defconfig
$ make ARCH=powerpc menuconfig
... [customizations]...
$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- cuImage.lite5200b

and this is the output:
...
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CALL    arch/powerpc/kernel/systbl_chk.sh
  WRAP    arch/powerpc/boot/cuImage.lite5200b
DTC: dts->dtb  on file
"/home/fgaretto/linux-2.6.25.2-lite5200/arch/powerpc/boot/dts/lite5200b.dts"
Image Name:   Linux-2.6.25.2
Created:      Fri May  9 14:46:22 2008
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    1518744 Bytes = 1483.15 kB = 1.45 MB
Load Address: 0x00400000
Entry Point:  0x00400550

At this point I've loaded the cuImage and rootfs.uimage on the board:
=> usb start
=> usb scan
=> fatload usb 0 0x03000000 cuImage.lite5200b
=> fatload usb 0 0x04000000 rootfs.uimage
=> bootm 0x03000000 0x04000000

but it still hangs after this:

## Booting image at 03000000 ...
   Image Name:   RadioNav-Linux 2.6.22.1
   Created:      2008-05-09  13:11:43 UTC
   Image Type:   PowerPC Linux Kernel Image (uncompressed)
   Data Size:    1518808 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
OK
## Loading RAMDisk Image at 04000000 ...
   Image Name:   RamDisk Image Lite5200b
   Created:      2008-03-04  11:28:40 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1135278 Bytes = 1109 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0fe68000, end 0ff7d2ae ... OK


I've looked at Load Address and Entry Point of the cuImage and it
sounds a little strange to me that these values are not zero, so I've
manually changed them both to  0x00000000 using mkimage, but the
result is always the same: no boot at all.
