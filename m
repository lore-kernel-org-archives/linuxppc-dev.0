Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 27092DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Dec 2007 11:12:37 +1100 (EST)
Received: from edison2.selinc.com (edison2.selinc.com [12.110.71.57])
	by tesla.selinc.com (8.12.11.20060308/8.12.11) with ESMTP id
	lBDNSeGK010574
	for <linuxppc-embedded@ozlabs.org>; Thu, 13 Dec 2007 15:28:40 -0800
To: linuxppc-embedded@ozlabs.org
Subject: How is a device tree used to specifiy flash?
MIME-Version: 1.0
Message-ID: <OFE841AC61.3D44C925-ON882573B0.007FA29F-882573B0.0080F67D@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 13 Dec 2007 15:28:37 -0800
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Okay I just don't get it, but that's not a surprise.  I'm booting a 2.6.23 
kernel on an MPC8347 using u-boot 1.3.0.  I'm trying to use the device 
tree to spec my single Spansion/AMD NOR flash part and I can't get the 
kernel to recognize the part.  Or maybe I just don't know how to tell if 
the kernel is recognizing the part.  It's possible that everything is fine 
and I'm just to dumb to know it.

So I've got a Spansion S29GL128N flash part and the following entry in my 
device tree:

flash@ff000000 {
                compatible = "amd,s29g128n", "cfi-flash";
                reg = <ff000000 01000000>;
                bank-width = <2>;
                device-width = <1>;
                #address-cells = <1>;
                #size-cells = <1>;
                bit@200000 {
                        label = "bit";
                        reg = <200000 a0000>;
                };
                kernel@400000 {
                        label = "kernel";
                        reg = <400000 140000>;
                };
                blob@600000 {
                        label = "blob";
                        reg = <600000 20000>;
                };
                uboot@f00000 {
                        label = "uboot";
                        reg = <f00000 60000>;
                        read-only;
                };
        };

I've got the following in my .config for the kernel (I think this is all 
that's relavent but I'm not sure);


#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
CONFIG_MTD_DEBUG=y
CONFIG_MTD_DEBUG_VERBOSE=3
# CONFIG_MTD_CONCAT is not set
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
# CONFIG_MTD_BLKDEVS is not set
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set

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
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
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
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_ONENAND is not set

#
# UBI - Unsorted block images
#
# CONFIG_MTD_UBI is not set
CONFIG_OF_DEVICE=y
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_MISC_DEVICES is not set
# CONFIG_IDE is not set

With this device tree and this .config the kernel never probes the flash 
part and 'cat /dev/mtd1' says the device doesn't exist.  If I then use 
Kconfig to specify the start of flash, the size of flash, and the bank 
width, dmesg shows that the part has been probed and 'cat /dev/mtd' spews 
out all sorts of stuff.

What black magic is there that doesn't showup in booting-without-of.txt 
that I'm missing?

Thanks for any feedback.

Bruce
