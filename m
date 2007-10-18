Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id 9C639DDEC0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:37:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Building zImage
Date: Thu, 18 Oct 2007 16:22:36 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7D8D790@corpexc01.corp.networkrobots.com>
In-Reply-To: <mailman.1363.1192734606.3099.linuxppc-dev@ozlabs.org>
References: <mailman.1363.1192734606.3099.linuxppc-dev@ozlabs.org>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

When I tried to build zImage (make zImage V=3D1) based on the 2.6.19
kernel for 8641HPCN board, I got the following error...

make -f scripts/Makefile.build obj=3Dlib
make -f
/export/beavis/work/sprasad/2.6.19/linux-2.6.19/scripts/Makefile.modpost
vmlinux
  scripts/mod/modpost -m  -o
/export/beavis/work/sprasad/2.6.19/linux-2.6.19/Module.symvers
vmlinux=20
rm -f .old_version
make ARCH=3Dppc64 -f scripts/Makefile.build obj=3Darch/powerpc/boot
arch/powerpc/boot/zImage
ln: accessing `arch/powerpc/boot/zImage': No such file or directory
make[1]: *** [arch/powerpc/boot/zImage] Error 1
make: *** [zImage] Error 2

When I looked into the Makefile, "image-y" was having no value. So, "ln"
was failing. Do I have to select one of the below options of zImage. I
am not really sure which one to use for 8641 supported by FreeScale.

image-$(CONFIG_PPC_PSERIES)             +=3D zImage.pseries
image-$(CONFIG_PPC_MAPLE)               +=3D zImage.pseries
image-$(CONFIG_PPC_IBM_CELL_BLADE)      +=3D zImage.pseries
image-$(CONFIG_PPC_CHRP)                +=3D zImage.chrp
image-$(CONFIG_PPC_PMAC)                +=3D zImage.pmac
image-$(CONFIG_DEFAULT_UIMAGE)          +=3D uImage

Well!... we are not using U-Boot, so uImage is not an option, and that
builds fine.

Any way, I tried to make uImage, but I am not sure if it is including
the dts file in the final uImage built, as the wrapper was passed the
value of platform as "uboot". I am confused.

Thanks for your help in advance.

- siva
