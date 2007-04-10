Return-Path: <gkenaley@echelon.com>
Received: from [205.229.50.10] (ntfw.echelon.com [205.229.50.10])
	by ozlabs.org (Postfix) with ESMTP id 0500ADDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 11:45:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Unable to Boot 2.6.19.2 from ELDK 4.1 on MPC8349E MDS
Date: Mon, 9 Apr 2007 18:33:30 -0700
Message-ID: <DDBD7B17DB2ECE48BCD94C593F7255B4046E9F23@monk.echelon.echcorp.com>
In-reply-to: <BAY115-W6F965CAAC5215961F494FB2590@phx.gbl>
References: <BAY115-W6F965CAAC5215961F494FB2590@phx.gbl>
From: "Gary Kenaley" <gkenaley@echelon.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have been evaluating Freescale 2.6.11, Wind River 2.6.14, and am now
attempting Denx 2.6.19 (from ELDK 4.1) - running on the Rev 1.0 MPC8349E
MDS (V1.1 CPU). I boot 2.6.19.2 using the factory u-boot 1.1.3 and the
kernel immediately hangs:
Uncompressing Kernel Image ... OK {hangs forever}

The following boot arguments work when I swap in a Wind or Freescale
uImage in /tftpboot, so I know that the ELDK filesystem and devnodes are
okay:

bootargs=3Droot=3D/dev/nfs rw
nfsroot=3D10.2.11.175:/home/gkenaley/ELDK4.1/ppc_6xx
ip=3D10.2.11.184:10.2.11.175:10.2.0.1:255.255.128.0:83493mds2:eth0:off
console=3DttyS0,115200

I installed the ELDK 4.1 as per the instructions (including running the
FIX scripts) on a Red Hat 4 U4(2.6.9-42) PC host. I then ran these
commands on the host:
export
PATH=3D/home/gkenaley/ELDK4.1/usr/bin:/home/gkenaley/ELDK4.1/bin:$PATH
export CROSS_COMPILE=3Dppc_6xx-
export ARCH=3Dpowerpc
cd /home/gkenaley/ELDK4.1/ppc_6xx/usr/src/linux-2.6.19.2
${CROSS_COMPILE}make clean
${CROSS_COMPILE}make V=3D1 mpc834x_mds_defconfig
${CROSS_COMPILE}make V=3D1 all

cp -p
/home/gkenaley/ELDK4.1/ppc_6xx/usr/src/linux-2.6.19.2/arch/powerpc/boot/
uImage /tftpboot/

${CROSS_COMPILE}make V=3D1 =
INSTALL_MOD_PATH=3D/home/gkenaley/ELDK4.1/ppc_6xx
modules_install

Since the host depmod is not a cross version and segfaults, and the ELDK
versions refuse to run, I also ran:
perl /home/gkenaley/ELDK4.1/usr/bin/depmod.pl -v -F System.map -b
/home/gkenaley/ELDK4.1/ppc_6xx/lib/modules/2.6.19.2

At that point I u-boot the target and it hangs forever as shown above.
I did a lot of comparisons to the Wind and Freescale .config files and
also tried turning off CONFIG_PCI (since I have only the MDS processor
board), but it did not help solve the problem. I also tried running
xconfig and producing a more complete configuration, but the boot
process fails exactly the same way with that larger uImage.

I also tried a "full source rebuild from scratch" for the ELDK 4.1, but
I found that these SRPMS were originally misnamed (could not be found in
CVS, rpmfind, or the ELDK source CD-ROM) in
/home/gkenaley/ELDK/V4.1/build/SRPMS.lst:

#rpm-4.4.1-22_4.src.rpm
#httpd-2.0.54-10.2_2.src.rpm
#libtool-1.5.16.multilib2-2_2.src.rpm
#module-init-tools-3.1-4_1.src.rpm
#nfs-utils-1.0.7-12_3.src.rpm
#pam-0.79-9.5_2.src.rpm
#procps-3.2.5-6.3_2.src.rpm
#tar-1.15.1-10_2.src.rpm
#util-linux-2.12p-9.12_3.src.rpm

After correcting (?) SRPMS.lst to contain the names shown above, the
build ran for about 1/2 hour and then failed in rpm-4.4.1-22_4 with
various undefined references to ELF parameters.

Questions, please:
------------------
1. Should I expect this kernel to boot on the MPC8349E MDS, or do I need
to find and apply a variety of patches?

2. Any idea why I have problems doing the "ELDK 4.1 full source rebuild
from scratch"?

3. Do you see anything else important that I should change in my
process?

Since I am a bit of a newbie, I'll be grateful to get a lot of specific
advice.

Thanks, Gary
