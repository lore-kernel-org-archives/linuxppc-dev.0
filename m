Return-Path: <oleks@arcturusnetworks.com>
Received: from mail.arcturusnetworks.com (mail.arcturusnetworks.com
 [66.11.68.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 94C841A0F61
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 05:29:22 +1000 (AEST)
Message-ID: <554BBD10.5050706@arcturusnetworks.com>
Date: Thu, 07 May 2015 15:29:20 -0400
From: Oleksandr G Zhadan <oleks@arcturusnetworks.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/1] powerpc: mpc85xx: Add board support for ucp1020
References: <1430841121-1997-1-git-send-email-oleks@arcturusnetworks.com>	
 <1430968950.16357.369.camel@freescale.com>	
 <554B934C.5090406@arcturusnetworks.com>
 <1431022714.16357.396.camel@freescale.com>
In-Reply-To: <1431022714.16357.396.camel@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Michael Durrant <mdurrant@arcturusnetworks.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/2015 02:18 PM, Scott Wood wrote:
> On Thu, 2015-05-07 at 12:31 -0400, Oleksandr G Zhadan wrote:
>> Hi Scott,
>>
>> Thanks for fast response, please see inline.
>>
>> On 05/06/2015 11:22 PM, Scott Wood wrote:
>>> On Tue, 2015-05-05 at 11:52 -0400, Oleksandr G Zhadan wrote:
>>>> +-------------------------------------------------
>>>> +
>>>> +P1020 SPI controller
>>>> +
>>>> +Properties:
>>>> +- compatible:		"spansion,s25fl008k", "winbond,w25q80bl"
>>>> +
>>>> +Example:
>>>> +	spi@7000 {
>>>> +		flash@0 {
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <1>;
>>>> +			compatible = "spansion,s25fl008k", "winbond,w25q80bl";
>>>> +			reg = <0>;
>>>> +			spi-max-frequency = <40000000>; /* input clock */
>>>> +			...
>>>> +		};
>>>
>>> This isn't describing the controller, but rather a SPI chip attached to
>>> the controller.  This also doesn't seem like the right place for random
>>> SPI chips.
>>>
>>> If all you're specifying is the compatible, maybe create a
>>> spi/trivial-devices.txt similar to i2c/trivial-devices.txt?  Or
>>> something specific to SPI flash chips to describe the partition
>>> specification, though I generally recommend against describing
>>> partitions in the device tree -- especially if this is a developer board
>>> rather than something fixed-purpose where the partitioning is not going
>>> to change based on user requirements.
>>>
>>>
>>
>> Mostly in all Documentation/devicetree/bindings/ I tried to satisfy
>> checkpatch script as simple as possible. And for me as well it looks
>> reasonable to create spi/trivial-devices.txt file and I will.
>
> Checkpatch is a tool, not a dictator.  Sometimes it gets things wrong.
>
> Also, please CC devicetree@vger.kernel.org when adding bindings or
> modifying dts files.
>

OK, got it.

>>>> +-------------------------------------------------
>>>> +
>>>> +Chipselect/Local Bus
>>>> +
>>>> +Properties:
>>>> +- #address-cells:	<2>.
>>>> +- #size-cells:		<1>.
>>>> +- compatible:		"fsl,p1020-elbc", "fsl,elbc", "simple-bus","fsl,p1020-immr"
>>>> +- interrupts:		interrupts to report localbus events.
>>>> +
>>>> +Example:
>>>> +
>>>> +&lbc {
>>>> +	#address-cells = <2>;
>>>> +	#size-cells = <1>;
>>>> +	compatible = "fsl,p1020-elbc", "fsl,elbc", "simple-bus";
>>>> +	interrupts = <19 2 0 0>;
>>>> +};
>>>
>>> There's already a binding for elbc -- and the elbc node certainly should
>>> not claim compatibility with "fsl,p1020-immr".
>>>
>>>
>>
>> to satisfy checkpatch script.
>
> Even if that were necessary, why do it by copy-and-paste, and why put
> the immr compatible in the binding for a different node?

Will fix.

>
>>>> diff --git a/arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi b/arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi
>>>> new file mode 100644
>>>> index 0000000..930a6e3
>>>> --- /dev/null
>>>> +++ b/arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi
>>>
>>> Why can't you use p1020si-post.dtsi?  The "si" means "silicon" -- it's
>>> meant to be included by all p1020 boards.
>>>
>>
>> Yes, silicon is the same, but p1020 boards using all 3 etsec ethernet
>> controllers. Our board using only 2: etsec1 and etsec3.
>
> So have your board write status = "disabled" into the etsec2 node after
> including the post file.

While ago I create ucp1020som-post.dtsi to make it work as we need. I 
did try some things, but I really don't remember what exactly and result 
always was eth0,eth1,eth2 or eth0,eth2 and newer eth0,eth1.

I'll retry status="disabled".

>
>>>> diff --git a/arch/powerpc/configs/ucp1020_defconfig b/arch/powerpc/configs/ucp1020_defconfig
>>>> new file mode 100644
>>>> index 0000000..62f99aa
>>>> --- /dev/null
>>>> +++ b/arch/powerpc/configs/ucp1020_defconfig
>>>
>>> Please explain why your board needs its own defconfig.
>>>
>>
>> Because, it's our own board and it has some specific to board
>> definitions like CONFIG_DEFAULT_HOSTNAME and some specific to product
>> definitions.
>>
>> If I can do it in some other way could you please give me some example
>> if it's possible.
>
> I don't think stuff like CONFIG_DEFAULT_HOSTNAME belongs upstream.
> Could you list what you need to be set that mpc85xx_smp_defconfig
> doesn't set?

I make diff "mpc85xx_smp_defconfig" vs "ucp1020_defconfig after make 
savedefconfig" and it's some differences like:

- mpc85xx_smp_defconfig has:
CONFIG_PHYS_64BIT=y
CONFIG_NR_CPUS=8

- it enabled almost all boards to build. What for ?

- it has MTD related differences (doesn't enabled spi flashes support we 
need):
-CONFIG_MTD_M25P80=y
-CONFIG_MTD_SST25L=y

- It includes some PHY support, but not phy we are using and we need 
include intel wifi support:
-CONFIG_MICREL_PHY=y
-CONFIG_IWLWIFI=y

- It doesn't enable EXT4 fs support.
Etc...

You can see it yourself below:
----------------------------------------
--- defconfig   2015-05-07 14:48:12.000000000 -0400
+++ mpc85xx_smp_defconfig       2015-05-01 18:45:03.000000000 -0400
@@ -1,51 +1,58 @@
  CONFIG_PPC_85xx=y
+CONFIG_PHYS_64BIT=y
  CONFIG_SMP=y
-CONFIG_NR_CPUS=2
-CONFIG_CROSS_COMPILE="powerpc-linux-"
-# CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_DEFAULT_HOSTNAME="uCP1020"
-# CONFIG_SWAP is not set
+CONFIG_NR_CPUS=8
  CONFIG_SYSVIPC=y
  CONFIG_POSIX_MQUEUE=y
  CONFIG_AUDIT=y
-CONFIG_NO_HZ_IDLE=y
+CONFIG_IRQ_DOMAIN_DEBUG=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
  CONFIG_BSD_PROCESS_ACCT=y
  CONFIG_IKCONFIG=y
  CONFIG_IKCONFIG_PROC=y
  CONFIG_LOG_BUF_SHIFT=14
-CONFIG_LOG_CPU_MAX_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED=y
  CONFIG_BLK_DEV_INITRD=y
-# CONFIG_RD_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
-# CONFIG_RD_XZ is not set
-# CONFIG_RD_LZO is not set
-# CONFIG_RD_LZ4 is not set
-CONFIG_SYSCTL_SYSCALL=y
-CONFIG_EMBEDDED=y
-# CONFIG_SLUB_DEBUG is not set
-# CONFIG_COMPAT_BRK is not set
-CONFIG_JUMP_LABEL=y
+CONFIG_EXPERT=y
+CONFIG_KALLSYMS_ALL=y
  CONFIG_MODULES=y
  CONFIG_MODULE_UNLOAD=y
  CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
  # CONFIG_BLK_DEV_BSG is not set
  CONFIG_PARTITION_ADVANCED=y
  CONFIG_MAC_PARTITION=y
-# CONFIG_EFI_PARTITION is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_UCP1020_SOM=y
+CONFIG_C293_PCIE=y
+CONFIG_MPC8540_ADS=y
+CONFIG_MPC8560_ADS=y
+CONFIG_MPC85xx_CDS=y
+CONFIG_MPC85xx_MDS=y
+CONFIG_MPC8536_DS=y
+CONFIG_MPC85xx_DS=y
+CONFIG_MPC85xx_RDB=y
+CONFIG_P1010_RDB=y
+CONFIG_P1022_DS=y
+CONFIG_P1022_RDK=y
+CONFIG_P1023_RDB=y
+CONFIG_SOCRATES=y
+CONFIG_KSI8560=y
+CONFIG_XES_MPC85xx=y
+CONFIG_STX_GP3=y
+CONFIG_TQM8540=y
+CONFIG_TQM8541=y
+CONFIG_TQM8548=y
+CONFIG_TQM8555=y
+CONFIG_TQM8560=y
+CONFIG_SBC8548=y
+CONFIG_QUICC_ENGINE=y
+CONFIG_QE_GPIO=y
  CONFIG_HIGHMEM=y
-CONFIG_PREEMPT=y
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_BINFMT_MISC=m
  CONFIG_MATH_EMULATION=y
-CONFIG_SWIOTLB=y
-# CONFIG_COMPACTION is not set
+CONFIG_FORCE_MAX_ZONEORDER=12
  CONFIG_PCI=y
-CONFIG_PCIEPORTBUS=y
-# CONFIG_PCIEAER is not set
-# CONFIG_PCIEASPM is not set
  CONFIG_PCI_MSI=y
+CONFIG_RAPIDIO=y
  CONFIG_NET=y
  CONFIG_PACKET=y
  CONFIG_UNIX=y
@@ -53,44 +60,26 @@
  CONFIG_NET_KEY=y
  CONFIG_INET=y
  CONFIG_IP_MULTICAST=y
-CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_NET_IPIP=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_INET_ESP=y
  # CONFIG_INET_XFRM_MODE_BEET is not set
  # CONFIG_INET_LRO is not set
-# CONFIG_IPV6 is not set
-CONFIG_NETFILTER=y
-CONFIG_BRIDGE_NETFILTER=y
-CONFIG_NF_CONNTRACK=y
-CONFIG_NF_CONNTRACK_FTP=y
-CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
-CONFIG_NETFILTER_XT_TARGET_MARK=y
-CONFIG_NETFILTER_XT_MATCH_COMMENT=y
-CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
-CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
-CONFIG_NETFILTER_XT_MATCH_HELPER=y
-CONFIG_NETFILTER_XT_MATCH_MARK=y
-CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
-CONFIG_NETFILTER_XT_MATCH_STATE=y
-CONFIG_NF_CONNTRACK_IPV4=y
-CONFIG_IP_NF_IPTABLES=y
-CONFIG_IP_NF_FILTER=y
-CONFIG_IP_NF_TARGET_REJECT=y
-CONFIG_IP_NF_NAT=y
-CONFIG_IP_NF_TARGET_MASQUERADE=y
-CONFIG_IP_NF_TARGET_NETMAP=y
-CONFIG_IP_NF_TARGET_REDIRECT=y
-CONFIG_IP_NF_MANGLE=y
-CONFIG_BRIDGE=y
-CONFIG_VLAN_8021Q=y
-CONFIG_NET_SCHED=y
-CONFIG_NET_SCH_HTB=y
-CONFIG_CFG80211=y
-# CONFIG_CFG80211_DEFAULT_PS is not set
-CONFIG_MAC80211=y
-# CONFIG_MAC80211_RC_MINSTREL is not set
-CONFIG_UEVENT_HELPER_PATH="/bin/hotplug"
-CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
+CONFIG_IPV6=y
+CONFIG_IP_SCTP=m
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
  CONFIG_MTD=y
  CONFIG_MTD_CMDLINE_PARTS=y
  CONFIG_MTD_BLOCK=y
@@ -99,77 +88,44 @@
  CONFIG_MTD_CFI_INTELEXT=y
  CONFIG_MTD_CFI_AMDSTD=y
  CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_M25P80=y
-CONFIG_MTD_SST25L=y
  CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_PLATFORM=y
  CONFIG_MTD_NAND_FSL_ELBC=y
-CONFIG_MTD_NAND_FSL_UPM=y
+CONFIG_MTD_NAND_FSL_IFC=y
  CONFIG_MTD_SPI_NOR=y
+CONFIG_MTD_UBI=y
  CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_NBD=y
  CONFIG_BLK_DEV_RAM=y
  CONFIG_BLK_DEV_RAM_SIZE=131072
-CONFIG_EEPROM_AT25=y
-CONFIG_SCSI=y
+CONFIG_EEPROM_AT24=y
+CONFIG_EEPROM_LEGACY=y
  CONFIG_BLK_DEV_SD=y
  CONFIG_CHR_DEV_ST=y
  CONFIG_BLK_DEV_SR=y
  CONFIG_CHR_DEV_SG=y
  CONFIG_SCSI_LOGGING=y
+CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+CONFIG_SATA_FSL=y
+CONFIG_SATA_SIL24=y
+CONFIG_PATA_ALI=y
  CONFIG_NETDEVICES=y
-# CONFIG_NET_VENDOR_3COM is not set
-# CONFIG_NET_VENDOR_ADAPTEC is not set
-# CONFIG_NET_VENDOR_AGERE is not set
-# CONFIG_NET_VENDOR_ALTEON is not set
-# CONFIG_NET_VENDOR_AMD is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_ATHEROS is not set
-# CONFIG_NET_CADENCE is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_BROCADE is not set
-# CONFIG_NET_VENDOR_CHELSIO is not set
-# CONFIG_NET_VENDOR_CISCO is not set
-# CONFIG_NET_VENDOR_DEC is not set
-# CONFIG_NET_VENDOR_DLINK is not set
-# CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_EXAR is not set
+CONFIG_DUMMY=y
+CONFIG_FS_ENET=y
+CONFIG_UCC_GETH=y
  CONFIG_GIANFAR=y
-# CONFIG_NET_VENDOR_HP is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MELLANOX is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MICROCHIP is not set
-# CONFIG_NET_VENDOR_MYRI is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_NVIDIA is not set
-# CONFIG_NET_VENDOR_OKI is not set
-# CONFIG_NET_PACKET_ENGINE is not set
-# CONFIG_NET_VENDOR_QLOGIC is not set
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_REALTEK is not set
-# CONFIG_NET_VENDOR_RDC is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SILAN is not set
-# CONFIG_NET_VENDOR_SIS is not set
-# CONFIG_NET_VENDOR_SMSC is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SUN is not set
-# CONFIG_NET_VENDOR_TEHUTI is not set
-# CONFIG_NET_VENDOR_TI is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
-# CONFIG_NET_VENDOR_XILINX is not set
-CONFIG_MICREL_PHY=y
-CONFIG_IWLWIFI=y
+CONFIG_E1000E=y
+CONFIG_AT803X_PHY=y
+CONFIG_MARVELL_PHY=y
+CONFIG_DAVICOM_PHY=y
+CONFIG_CICADA_PHY=y
+CONFIG_VITESSE_PHY=y
+CONFIG_FIXED_PHY=y
+CONFIG_INPUT_FF_MEMLESS=m
  # CONFIG_INPUT_MOUSEDEV is not set
  # CONFIG_INPUT_KEYBOARD is not set
  # CONFIG_INPUT_MOUSE is not set
  CONFIG_SERIO_LIBPS2=y
-CONFIG_LEGACY_PTY_COUNT=16
-CONFIG_NOZOMI=y
  CONFIG_SERIAL_8250=y
  CONFIG_SERIAL_8250_CONSOLE=y
  CONFIG_SERIAL_8250_NR_UARTS=2
@@ -177,79 +133,112 @@
  CONFIG_SERIAL_8250_MANY_PORTS=y
  CONFIG_SERIAL_8250_DETECT_IRQ=y
  CONFIG_SERIAL_8250_RSA=y
+CONFIG_SERIAL_QE=m
  CONFIG_NVRAM=y
  CONFIG_I2C=y
  CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_CPM=m
  CONFIG_I2C_MPC=y
  CONFIG_SPI=y
-CONFIG_SPI_BITBANG=y
+CONFIG_SPI_FSL_SPI=y
  CONFIG_SPI_FSL_ESPI=y
-CONFIG_SPI_SPIDEV=y
-CONFIG_GPIOLIB=y
  CONFIG_GPIO_MPC8XXX=y
  CONFIG_SENSORS_LM90=y
-CONFIG_THERMAL=y
-CONFIG_WATCHDOG=y
-CONFIG_BOOKE_WDT=y
-CONFIG_BOOKE_WDT_DEFAULT_TIMEOUT=36
-# CONFIG_HID is not set
-# CONFIG_USB_HID is not set
+CONFIG_FB=y
+CONFIG_FB_FSL_DIU=y
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
+# CONFIG_SND_DRIVERS is not set
+CONFIG_SND_INTEL8X0=y
+# CONFIG_SND_PPC is not set
+# CONFIG_SND_USB is not set
+CONFIG_SND_SOC=y
+CONFIG_SND_POWERPC_SOC=y
+CONFIG_HID_A4TECH=y
+CONFIG_HID_APPLE=y
+CONFIG_HID_BELKIN=y
+CONFIG_HID_CHERRY=y
+CONFIG_HID_CHICONY=y
+CONFIG_HID_CYPRESS=y
+CONFIG_HID_EZKEY=y
+CONFIG_HID_GYRATION=y
+CONFIG_HID_LOGITECH=y
+CONFIG_HID_MICROSOFT=y
+CONFIG_HID_MONTEREY=y
+CONFIG_HID_PANTHERLORD=y
+CONFIG_HID_PETALYNX=y
+CONFIG_HID_SAMSUNG=y
+CONFIG_HID_SUNPLUS=y
  CONFIG_USB=y
-CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-CONFIG_USB_DYNAMIC_MINORS=y
  CONFIG_USB_MON=y
  CONFIG_USB_EHCI_HCD=y
  CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_ACM=y
-CONFIG_USB_WDM=y
-CONFIG_USB_TMC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
+CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
  CONFIG_USB_STORAGE=y
-CONFIG_USB_STORAGE_DEBUG=y
  CONFIG_MMC=y
  CONFIG_MMC_SDHCI=y
  CONFIG_MMC_SDHCI_PLTFM=y
  CONFIG_MMC_SDHCI_OF_ESDHC=y
+CONFIG_EDAC=y
+CONFIG_EDAC_MM_EDAC=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_DS1374=y
+CONFIG_RTC_DRV_DS3232=y
+CONFIG_RTC_DRV_CMOS=y
  CONFIG_DMADEVICES=y
  CONFIG_FSL_DMA=y
-CONFIG_ASYNC_TX_DMA=y
-# CONFIG_IOMMU_SUPPORT is not set
  CONFIG_EXT2_FS=y
  CONFIG_EXT3_FS=y
  # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
-CONFIG_EXT4_FS=y
-CONFIG_XFS_FS=y
-CONFIG_MSDOS_FS=y
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=m
+CONFIG_MSDOS_FS=m
  CONFIG_VFAT_FS=y
  CONFIG_NTFS_FS=y
  CONFIG_PROC_KCORE=y
  CONFIG_TMPFS=y
+CONFIG_HUGETLBFS=y
+CONFIG_ADFS_FS=m
+CONFIG_AFFS_FS=m
+CONFIG_HFS_FS=m
+CONFIG_HFSPLUS_FS=m
+CONFIG_BEFS_FS=m
+CONFIG_BFS_FS=m
+CONFIG_EFS_FS=m
  CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_FS_WBUF_VERIFY=y
-CONFIG_JFFS2_SUMMARY=y
-CONFIG_JFFS2_FS_XATTR=y
-CONFIG_JFFS2_COMPRESSION_OPTIONS=y
-CONFIG_JFFS2_LZO=y
-CONFIG_JFFS2_RUBIN=y
+CONFIG_JFFS2_FS_DEBUG=1
+CONFIG_UBIFS_FS=y
  CONFIG_CRAMFS=y
+CONFIG_VXFS_FS=m
+CONFIG_HPFS_FS=m
+CONFIG_QNX4FS_FS=m
+CONFIG_SYSV_FS=m
+CONFIG_UFS_FS=m
  CONFIG_NFS_FS=y
  CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
  CONFIG_NFSD=y
-CONFIG_CIFS=y
  CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_850=y
  CONFIG_NLS_ISO8859_1=y
  CONFIG_CRC_T10DIF=y
-CONFIG_CRC_ITU_T=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_DEBUG_PREEMPT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_RCU_CPU_STALL_TIMEOUT=60
-# CONFIG_RCU_CPU_STALL_INFO is not set
-# CONFIG_FTRACE is not set
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_PCBC=y
-CONFIG_CRYPTO_SHA1=y
-CONFIG_CRYPTO_SHA1_PPC=y
-CONFIG_CRYPTO_DEFLATE=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_FS=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
  # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_DEV_FSL_CAAM=y
  CONFIG_CRYPTO_DEV_TALITOS=y
----------------------------------------

Oleks


>
> -Scott
>
>
>


-- 
Oleksandr Zhadan
Arcturus Networks
T 416 621-0125 x235
F 416 621-0190
