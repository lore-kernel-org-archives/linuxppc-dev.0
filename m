Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id E38B4DDF36
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 01:32:51 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so465022ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 08 May 2008 08:32:39 -0700 (PDT)
Message-ID: <fa686aa40805080832l2492c46l400986472e985d9a@mail.gmail.com>
Date: Thu, 8 May 2008 09:32:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Fabio Tosetto" <tosettofabio83@libero.it>
Subject: Re: MPC5200b MMC over SPI into PSC6
In-Reply-To: <482317E2.7000308@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <481F4DFD.1000702@libero.it>
	<fa686aa40805060836o519bff20yf2506676ff1c3e6@mail.gmail.com>
	<4821A551.3060205@libero.it>
	<fa686aa40805070934t77f8b2b0y2799814b4f131bc8@mail.gmail.com>
	<482317E2.7000308@libero.it>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 8, 2008 at 9:10 AM, Fabio Tosetto <tosettofabio83@libero.it> wrote:
> Ok, maybe it's better to start from the beginning.
>  Now I'm using a Lite5200b board, just to avoid problems with my hardware,
> and I'm trying to have a bootable kernel.
>
>  With kernel version 2.6.24.6 I do the following commands
>
>  $ make ARCH=powerpc lite5200_defconfig
>  $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- uImage
>
>  then I copy the arch/powerpc/boot/uImage and a rootfs.uimage on the board,
> but uBoot stops at the beginning:

Right; some concepts need to be explained now...  There is a major
difference between arch/ppc and arch/powerpc.  In arch/ppc, the kernel
is hard coded with the list of devices in the system.  In
arch/powerpc, the list of devices is captured in a data structure
called the Flattened Device Tree (FDT).  fdt data structures are
generated from the .dts (device tree source) files in
arch/powerpc/boot/dts/.

When you build a uImage with arch/ppc, you get a hard coded kernel
that works with u-boot:  "bootm <kernel_addr> <ramdisk_addr>"

When you build a uImage with arch/powerpc, you get a dynamic kernel
that needs to be passed the device tree blob on boot.  Newer u-boot
supports dts booting: "bootm <kernel_addr> <ramdisk_addr> <dt_addr>"
or "bootm <kernel_addr> - <dt_addr>" if you're not using a ramdisk.

However, if you've got an older u-boot version installed on your
board, you need to create an image that binds the device tree into the
kernel image.  This is called a "cuImage".  So, instead of doing "make
ARCH=powerpc uImage", you should do "make ARCH=powerpc
cuImage.<boardname>".  This 'wraps' the kernel with a boot wrapper
that includes the device tree blob but maintains compatibility with
the old style uImage format.

For example, use "make ARCH=powerpc cuImage.lite5200b" to build an
image for the lite5200b board.  The build scripts will use the
lite5200b.dts file in the dts directory for building the image.  If
you add "fabios-fantastic-board.dts" to arch/powerpc/boot/dts, then
you can build "cuImage.fabios-fantastic-board".  :-)

>  The only way I was able to get something working, even though it sounds a
> little strange to me, is loading the config from powerpc folder but
> compiling in ppc
>
>  $ make ARCH=powerpc lite5200_defconfig
>  $ make ARCH=ppc CROSS_COMPILE=powerpc-linux-gnu- uImage

ARCH=ppc and ARCH=powerpc are completely different beasts.  Forget
that you even know about ARCH=ppc for this entire exercise.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
