Subject: Linux in Flash on MPC5200 (icecube)
From: Gerrit Van de Velde <gvd@denayer.wenk.be>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1077114566.4804.12.camel@nios>
Mime-Version: 1.0
Date: 18 Feb 2004 15:29:27 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm currently trying to get a linux in the flash of a MPC5200Lite board
in order to let it be self hosting. U-boot is in flash (lowboot config).
I've changed the linuxppc_2_4_20_mpc5200/drivers/mtd/maps/icecube.c file
to have a different flash partitioning in order to have U-boot in
/dev/mtd0 and a big empty mtd1 and then a mtd2 with Motorola firmware.

Currently I have a jffs2 image (4.4Mb) with the root filesystem (busybox
+ tinylogin) in the FLASH (/dev/mtd1 - /dev/mtdblock1) and I'm able to
mount it and boot from it. The kernel is still received via TFTP though.
But after the kernel has mounted the root (bootargs=root=/dev/mtdblock1
rw), a warning is displayed: "warning: unable to open initial console"
so I can't see anything from that point in time on my terminal screen.

I have 4 (simple?) questions for now:
1. I tried with bootargs console=ttyS0,115200 but i get the same
warning, why ? bootargs being root=/dev/nfs rw nfsroot=.... with no
console specified, does work.
2. Why does it take so long (+10 sec) to mount the /dev/mtdblock1 ?
3. Why isn't mk.jffs2 included in the eldk/ppc_82xx/ ? Is this for a
particular reason ? I'm unable to install them myself until now.
(getting al kinds of errors when building the mtd utils)
4. Why is CRAMFS not supported in the icecube_5200_defconfig ?

Kind regards,

Gerrit Van de Velde


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
