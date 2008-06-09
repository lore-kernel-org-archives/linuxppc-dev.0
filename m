Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 6F2BFDDF5A
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 07:30:14 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1355063ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Jun 2008 14:30:11 -0700 (PDT)
Message-ID: <9e4733910806091430j56aeb06bpa090b0c8242e2041@mail.gmail.com>
Date: Mon, 9 Jun 2008 17:30:10 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Juergen Beisert" <jbe@pengutronix.de>
Subject: Re: Comments on device tree for pcm030
In-Reply-To: <200806091831.25200.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
	<200806091831.25200.jbe@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 6/9/08, Juergen Beisert <jbe@pengutronix.de> wrote:
> On Sunday 08 June 2008 21:08, Jon Smirl wrote:
>  > What about the flash on the local bus?  Could we use something like
>  > this, or the same without the partition data?
>  >
>  >       lpb@ff000000 {
>  >               compatible = "fsl,lpb";
>  >               ranges = <0 ff000000 01000000>;
>  >
>  >               flash@00000000 {
>  >                       compatible = "cfi-flash";
>  >                       reg = <00000000 01000000>;
>  >                       bank-width = <2>;
>  >                       #size-cells = <1>;
>  >                       #address-cells = <1>;
>  >                       partition@0 {
>  >                               label = "ubootl";
>  >                               reg = <00000000 00040000>;
>  >                       };
>  >                       partition@40000 {
>  >                               label = "kernel";
>  >                               reg = <00040000 001c0000>;
>  >                       };
>  >                       partition@200000 {
>  >                               label = "jffs2";
>  >                               reg = <00200000 00D00000>;
>  >                       };
>  >                       partition@f00000 {
>  >                               label = "uboot";
>  >                               reg = <00f00000 00040000>;
>  >                       };
>  >                       partition@f40000 {
>  >                               label = "oftree";
>  >                               reg = <00f40000 00040000>;
>  >                       };
>  >                       partition@f80000 {
>  >                               label = "space";
>  >                               reg = <00f80000 00080000>;
>  >                       };
>  >               };
>  >       };
>
>
> Hmm, I tried with these setting (and many others) to make the flash on my
>  board work again.
>  But the physmap_of.c driver always fails. It tries to request the region
>  0xfe000000 to 0x00000000 (my flash is 32MiB in size at 0xfe00000 to
>  0xffffffff) and fails badly. What are the correct settings in the OFTree to
>  make the physmap_of.c driver work?

This is my boot log:

ff000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
RedBoot partition parsing not available
Creating 6 MTD partitions on "ff000000.flash":
0x00000000-0x00040000 : "ubootl"
0x00040000-0x00200000 : "kernel"
0x00200000-0x00f00000 : "jffs2"
0x00f00000-0x00f40000 : "uboot"
0x00f40000-0x00f80000 : "oftree"
0x00f80000-0x01000000 : "space"

CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_CONCAT=y
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_MTD_OOPS is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_PHYSMAP_OF=y
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set







>
>
>  Regards,
>  Juergen
>
>  --
>  Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
>   Pengutronix - Linux Solutions for Science and Industry
>      Handelsregister: Amtsgericht Hildesheim, HRA 2686
>           Vertretung Sued/Muenchen, Germany
>    Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
>


-- 
Jon Smirl
jonsmirl@gmail.com
