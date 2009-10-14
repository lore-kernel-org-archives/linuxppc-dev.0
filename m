Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2639EB7063
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 07:12:18 +1100 (EST)
Message-ID: <4AD63099.406@embedded-sol.com>
Date: Wed, 14 Oct 2009 22:12:09 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: UBIFS problem on MPC8536DS
References: <4AD5ADC9.30503@embedded-sol.com>	<4AD5C5B4.3060303@nokia.com>	<4AD5D053.9000901@embedded-sol.com>	<4AD5FFE7.7080703@nokia.com>	<4AD60EF4.4080306@embedded-sol.com>
	<4AD614E4.6030005@freescale.com>
In-Reply-To: <4AD614E4.6030005@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Adrian Hunter <adrian.hunter@nokia.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Scott

Scott Wood wrote:
> Felix Radensky wrote:
>> Yes, NAND and NOR are on the same local bus controller.
>>
>> Maybe powerpc folks can provide some insight here.
>> Is it possible that simultaneous access to NOR and NAND
>> on MPC8536 can result in NAND timeouts ?
>
> I've heard other reports of such problems with eLBC, but was unable to 
> reproduce it myself last time I tried.  Could you reduce this down to 
> a minimal set of specific reproduction instructions (e.g. eliminate 
> UBI if possible, or else explain how to set up UBI)?
>
> -Scott
>
I use u-boot-2009.08 and linux-2.6.31 compiled with ELDK 4.2
UBI (under Device Drivers->MTD->UBI) and UBIFS
(under File Systems->Miscellaneous filesystems) should be enabled
in kernel configuration. I use the following configuration options 
(default ones):

CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_RESERVE=1
# CONFIG_MTD_UBI_GLUEBI is not set
# UBI debugging options
# CONFIG_MTD_UBI_DEBUG is not set
# CONFIG_JFFS2_RUBIN is not set
CONFIG_UBIFS_FS=y
# CONFIG_UBIFS_FS_XATTR is not set
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
# CONFIG_UBIFS_FS_DEBUG is not set

Root file system is mounted over NFS (also ELDK 4.2). udev is not used.
mtd-utils (which include ubi tools) are from latest 
git://git.infradead.org/mtd-utils.git

I've added the following eLBC node to mpc8536ds.dts

    localbus@ffe05000 {
        #address-cells = <2>;
        #size-cells = <1>;
        compatible = "fsl,mpc8536-elbc", "fsl,elbc", "simple-bus";
        reg = <0xffe05000 0x1000>;
        interrupts = <19 2>;
        interrupt-parent = <&mpic>;

        ranges = <0x0 0x0 0xe8000000 0x08000000
              0x1 0x0 0xe8000000 0x08000000
              0x2 0x0 0xffa00000 0x00040000
              0x3 0x0 0xffdf0000 0x00008000
              0x4 0x0 0xffa40000 0x00040000
              0x5 0x0 0xffa80000 0x00040000
              0x6 0x0 0xffac0000 0x00040000>;

        nor@0,0 {
            #address-cells = <1>;
            #size-cells = <1>;
            compatible = "cfi-flash";
            reg = <0x0 0x0 0x8000000>;
            bank-width = <2>;
            device-width = <1>;

            partition@0 {
                label = "ramdisk";
                reg = <0x0 0x03000000>;
                read-only;
            };

            partition@3000000 {
                label = "diagnostics";
                reg = <0x03000000 0x00e00000>;
                read-only;
            };

            partition@3e00000 {
                label = "dink";
                reg = <0x03e00000 0x00200000>;
                read-only;
            };

            partition@4000000 {
                label = "kernel";
                reg = <0x04000000 0x00400000>;
                read-only;
            };

            partition@4400000 {
                label = "jffs2";
                reg = <0x04400000 0x03b00000>;
            };

            partition@7f00000 {
                label = "dtb";
                reg = <0x07f00000 0x00080000>;
                read-only;
            };

            partition@7f80000 {
                label = "u-boot";
                reg = <0x07f80000 0x00080000>;
                read-only;
            };
        };

        nand@2,0 {
            compatible = "fsl,mpc8536-fcm-nand",
                     "fsl,elbc-fcm-nand";
            reg = <0x2 0x0 0x40000>;
        };

        nand@4,0 {
            compatible = "fsl,mpc8536-fcm-nand",
                     "fsl,elbc-fcm-nand";
            reg = <0x4 0x0 0x40000>;
        };

        nand@5,0 {
            compatible = "fsl,mpc8536-fcm-nand",
                     "fsl,elbc-fcm-nand";
            reg = <0x5 0x0 0x40000>;
        };

        nand@6,0 {
            compatible = "fsl,mpc8536-fcm-nand",
                     "fsl,elbc-fcm-nand";
            reg = <0x6 0x0 0x40000>;
        };

        board-control@3,0 {
            compatible = "fsl,mpc8536ds-fpga-pixis";
            reg = <0x3 0x0 0x8000>;
        };
    };

I use the script below to reproduce the problem. rfs.tar.bz2 is 350MiB.

nand_dev=mtd7
nand_num=7
nor_dev=mtd4

flash_eraseall /dev/$nand_dev || exit 1
ubiformat /dev/$nand_dev || exit 1
ubictrl_major=`cat /sys/class/misc/ubi_ctrl/dev | cut -d: -f1`
ubictrl_minor=`cat /sys/class/misc/ubi_ctrl/dev | cut -d: -f2`
rm -f /dev/ubi_ctrl
mknod /dev/ubi_ctrl c $ubictrl_major $ubictrl_minor
ubiattach /dev/ubi_ctrl -m $nand_num  || exit 1
ubi0_major=`cat /sys/class/ubi/ubi0/dev | cut -d: -f1`
ubi0_minor=`cat /sys/class/ubi/ubi0/dev | cut -d: -f2`
rm -f /dev/ubi0
mknod /dev/ubi0 c $ubi0_major $ubi0_minor
ubimkvol /dev/ubi0 -N rootfs -s 800MiB  || exit 1
mkdir /mnt/rfs
mount -t ubifs ubi0:rootfs /mnt/rfs  || exit 1
tar xf /root/rfs.tar.bz2 -C /mnt/rfs
flash_eraseall /dev/$nor_dev || exit 1

Felix.
