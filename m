Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 0193E685EC
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2005 01:15:59 +1000 (EST)
In-Reply-To: <20051022220612.7F2F3353D84@atlas.denx.de>
References: <20051022220612.7F2F3353D84@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <989A4B75-70FA-43BE-AAA7-379D42AFEA49@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 24 Oct 2005 10:16:21 -0500
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [Patch] Add support for TQM834x Boards
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang,

Will you or Marian being maintaining this board family going forward?

Also, you need to split out the MTD portion and submit that to the  
MTD maintainer separately.

The only other comment is that tqm834x_show_cpuinfo() might want to  
be updated the vendor info.

Otherwise, once the I2C DS1337 patch is ack'd I'll push this upstream.

- kumar

On Oct 22, 2005, at 5:06 PM, Wolfgang Denk wrote:

> The following patch (against latest 2.6 tree) adds support for the TQ
> Systems TQM834x Boards. Verified on TQM8349L.
>
> Note: for TQM834x board support actually to  compile  and  work,  two
> previously submitted patches are required. See postings:
>
> Sat, 22 Oct 2005   [PATCH 2.6] Add generic support for DS1377 RTC
> Sat, 22 Oct 2005   [PATCH] Cleanup mpc83xx_restart() code
>
>
> ---
> Add support for TQM834x boards.
>
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
>
> ---
>
>  arch/ppc/Kconfig                   |   11
>  arch/ppc/configs/TQM834x_defconfig |  819 +++++++++++++++++++++++++ 
> +++++++++++
>  arch/ppc/platforms/83xx/Makefile   |    1
>  arch/ppc/platforms/83xx/tqm834x.c  |  336 +++++++++++++++
>  arch/ppc/platforms/83xx/tqm834x.h  |   40 ++
>  drivers/mtd/maps/Kconfig           |    8
>  drivers/mtd/maps/Makefile          |    1
>  drivers/mtd/maps/tqm834x.c         |  298 +++++++++++++
>  include/asm-ppc/mpc83xx.h          |    4
>  9 files changed, 1516 insertions(+), 2 deletions(-)
>
> diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
> --- a/arch/ppc/Kconfig
> +++ b/arch/ppc/Kconfig
> @@ -690,6 +690,12 @@ config EV64360
>      help
>        Select EV64360 if configuring a Marvell EV64360BP Evaluation
>        platform.
> +
> +config TQM834x
> +    bool "TQM834x"
> +    help
> +      This option enables support for the TQM834x boards from TQ
> +      Components.
>  endchoice
>
>  config PQ2ADS
> @@ -730,11 +736,11 @@ config 8272
>
>  config 83xx
>      bool
> -    default y if MPC834x_SYS
> +    default y if MPC834x_SYS || TQM834x
>
>  config MPC834x
>      bool
> -    default y if MPC834x_SYS
> +    default y if MPC834x_SYS || TQM834x
>
>  config CPM2
>      bool
> @@ -1170,6 +1176,7 @@ config PCI_DOMAINS
>  config MPC83xx_PCI2
>      bool "  Supprt for 2nd PCI host controller"
>      depends on PCI && MPC834x
> +    depends on !TQM834x
>      default y if MPC834x_SYS
>
>  config PCI_QSPAN
> diff --git a/arch/ppc/configs/TQM834x_defconfig b/arch/ppc/configs/ 
> TQM834x_defconfig
> new file mode 100644
> --- /dev/null
> +++ b/arch/ppc/configs/TQM834x_defconfig
> @@ -0,0 +1,819 @@
> +#
> +# Automatically generated make config: don't edit
> +# Linux kernel version: 2.6.14-rc4
> +# Mon Oct 17 17:22:19 2005
> +#
> +CONFIG_MMU=y
> +CONFIG_GENERIC_HARDIRQS=y
> +CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> +CONFIG_GENERIC_CALIBRATE_DELAY=y
> +CONFIG_PPC=y
> +CONFIG_PPC32=y
> +CONFIG_GENERIC_NVRAM=y
> +CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
> +CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> +
> +#
> +# Code maturity level options
> +#
> +CONFIG_EXPERIMENTAL=y
> +CONFIG_CLEAN_COMPILE=y
> +CONFIG_BROKEN_ON_SMP=y
> +CONFIG_INIT_ENV_ARG_LIMIT=32
> +
> +#
> +# General setup
> +#
> +CONFIG_LOCALVERSION=""
> +CONFIG_LOCALVERSION_AUTO=y
> +CONFIG_SWAP=y
> +CONFIG_SYSVIPC=y
> +# CONFIG_POSIX_MQUEUE is not set
> +# CONFIG_BSD_PROCESS_ACCT is not set
> +CONFIG_SYSCTL=y
> +# CONFIG_AUDIT is not set
> +# CONFIG_HOTPLUG is not set
> +CONFIG_KOBJECT_UEVENT=y
> +# CONFIG_IKCONFIG is not set
> +CONFIG_INITRAMFS_SOURCE=""
> +CONFIG_EMBEDDED=y
> +# CONFIG_KALLSYMS is not set
> +CONFIG_PRINTK=y
> +CONFIG_BUG=y
> +CONFIG_BASE_FULL=y
> +CONFIG_FUTEX=y
> +# CONFIG_EPOLL is not set
> +# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> +CONFIG_SHMEM=y
> +CONFIG_CC_ALIGN_FUNCTIONS=0
> +CONFIG_CC_ALIGN_LABELS=0
> +CONFIG_CC_ALIGN_LOOPS=0
> +CONFIG_CC_ALIGN_JUMPS=0
> +# CONFIG_TINY_SHMEM is not set
> +CONFIG_BASE_SMALL=0
> +
> +#
> +# Loadable module support
> +#
> +# CONFIG_MODULES is not set
> +
> +#
> +# Processor
> +#
> +CONFIG_6xx=y
> +# CONFIG_40x is not set
> +# CONFIG_44x is not set
> +# CONFIG_POWER3 is not set
> +# CONFIG_POWER4 is not set
> +# CONFIG_8xx is not set
> +# CONFIG_E200 is not set
> +# CONFIG_E500 is not set
> +CONFIG_PPC_FPU=y
> +# CONFIG_KEXEC is not set
> +# CONFIG_CPU_FREQ is not set
> +# CONFIG_WANT_EARLY_SERIAL is not set
> +CONFIG_PPC_GEN550=y
> +CONFIG_PPC_STD_MMU=y
> +
> +#
> +# Platform options
> +#
> +# CONFIG_PPC_MULTIPLATFORM is not set
> +# CONFIG_APUS is not set
> +# CONFIG_KATANA is not set
> +# CONFIG_WILLOW is not set
> +# CONFIG_CPCI690 is not set
> +# CONFIG_POWERPMC250 is not set
> +# CONFIG_CHESTNUT is not set
> +# CONFIG_SPRUCE is not set
> +# CONFIG_HDPU is not set
> +# CONFIG_EV64260 is not set
> +# CONFIG_LOPEC is not set
> +# CONFIG_MVME5100 is not set
> +# CONFIG_PPLUS is not set
> +# CONFIG_PRPMC750 is not set
> +# CONFIG_PRPMC800 is not set
> +# CONFIG_SANDPOINT is not set
> +# CONFIG_RADSTONE_PPC7D is not set
> +# CONFIG_PAL4 is not set
> +# CONFIG_GEMINI is not set
> +# CONFIG_EST8260 is not set
> +# CONFIG_SBC82xx is not set
> +# CONFIG_SBS8260 is not set
> +# CONFIG_RPX8260 is not set
> +# CONFIG_TQM8260 is not set
> +# CONFIG_ADS8272 is not set
> +# CONFIG_PQ2FADS is not set
> +# CONFIG_LITE5200 is not set
> +# CONFIG_MPC834x_SYS is not set
> +# CONFIG_EV64360 is not set
> +CONFIG_TQM834x=y
> +CONFIG_83xx=y
> +CONFIG_MPC834x=y
> +# CONFIG_SMP is not set
> +# CONFIG_HIGHMEM is not set
> +# CONFIG_HZ_100 is not set
> +CONFIG_HZ_250=y
> +# CONFIG_HZ_1000 is not set
> +CONFIG_HZ=250
> +CONFIG_PREEMPT_NONE=y
> +# CONFIG_PREEMPT_VOLUNTARY is not set
> +# CONFIG_PREEMPT is not set
> +CONFIG_SELECT_MEMORY_MODEL=y
> +CONFIG_FLATMEM_MANUAL=y
> +# CONFIG_DISCONTIGMEM_MANUAL is not set
> +# CONFIG_SPARSEMEM_MANUAL is not set
> +CONFIG_FLATMEM=y
> +CONFIG_FLAT_NODE_MEM_MAP=y
> +# CONFIG_SPARSEMEM_STATIC is not set
> +CONFIG_BINFMT_ELF=y
> +# CONFIG_BINFMT_MISC is not set
> +# CONFIG_CMDLINE_BOOL is not set
> +# CONFIG_PM is not set
> +# CONFIG_SOFTWARE_SUSPEND is not set
> +CONFIG_SECCOMP=y
> +CONFIG_ISA_DMA_API=y
> +
> +#
> +# Bus options
> +#
> +CONFIG_GENERIC_ISA_DMA=y
> +# CONFIG_PCI is not set
> +# CONFIG_PCI_DOMAINS is not set
> +
> +#
> +# PCCARD (PCMCIA/CardBus) support
> +#
> +# CONFIG_PCCARD is not set
> +
> +#
> +# Advanced setup
> +#
> +# CONFIG_ADVANCED_OPTIONS is not set
> +
> +#
> +# Default settings for advanced configuration options are used
> +#
> +CONFIG_HIGHMEM_START=0xfe000000
> +CONFIG_LOWMEM_SIZE=0x30000000
> +CONFIG_KERNEL_START=0xc0000000
> +CONFIG_TASK_SIZE=0x80000000
> +CONFIG_BOOT_LOAD=0x00800000
> +
> +#
> +# Networking
> +#
> +CONFIG_NET=y
> +
> +#
> +# Networking options
> +#
> +CONFIG_PACKET=y
> +# CONFIG_PACKET_MMAP is not set
> +CONFIG_UNIX=y
> +# CONFIG_NET_KEY is not set
> +CONFIG_INET=y
> +CONFIG_IP_MULTICAST=y
> +# CONFIG_IP_ADVANCED_ROUTER is not set
> +CONFIG_IP_FIB_HASH=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +CONFIG_IP_PNP_BOOTP=y
> +# CONFIG_IP_PNP_RARP is not set
> +# CONFIG_NET_IPIP is not set
> +# CONFIG_NET_IPGRE is not set
> +# CONFIG_IP_MROUTE is not set
> +# CONFIG_ARPD is not set
> +CONFIG_SYN_COOKIES=y
> +# CONFIG_INET_AH is not set
> +# CONFIG_INET_ESP is not set
> +# CONFIG_INET_IPCOMP is not set
> +# CONFIG_INET_TUNNEL is not set
> +CONFIG_INET_DIAG=y
> +CONFIG_INET_TCP_DIAG=y
> +# CONFIG_TCP_CONG_ADVANCED is not set
> +CONFIG_TCP_CONG_BIC=y
> +# CONFIG_IPV6 is not set
> +# CONFIG_NETFILTER is not set
> +
> +#
> +# DCCP Configuration (EXPERIMENTAL)
> +#
> +# CONFIG_IP_DCCP is not set
> +
> +#
> +# SCTP Configuration (EXPERIMENTAL)
> +#
> +# CONFIG_IP_SCTP is not set
> +# CONFIG_ATM is not set
> +# CONFIG_BRIDGE is not set
> +# CONFIG_VLAN_8021Q is not set
> +# CONFIG_DECNET is not set
> +# CONFIG_LLC2 is not set
> +# CONFIG_IPX is not set
> +# CONFIG_ATALK is not set
> +# CONFIG_X25 is not set
> +# CONFIG_LAPB is not set
> +# CONFIG_NET_DIVERT is not set
> +# CONFIG_ECONET is not set
> +# CONFIG_WAN_ROUTER is not set
> +# CONFIG_NET_SCHED is not set
> +# CONFIG_NET_CLS_ROUTE is not set
> +
> +#
> +# Network testing
> +#
> +# CONFIG_NET_PKTGEN is not set
> +# CONFIG_HAMRADIO is not set
> +# CONFIG_IRDA is not set
> +# CONFIG_BT is not set
> +# CONFIG_IEEE80211 is not set
> +
> +#
> +# Device Drivers
> +#
> +
> +#
> +# Generic Driver Options
> +#
> +CONFIG_STANDALONE=y
> +CONFIG_PREVENT_FIRMWARE_BUILD=y
> +# CONFIG_FW_LOADER is not set
> +
> +#
> +# Connector - unified userspace <-> kernelspace linker
> +#
> +# CONFIG_CONNECTOR is not set
> +
> +#
> +# Memory Technology Devices (MTD)
> +#
> +CONFIG_MTD=y
> +# CONFIG_MTD_DEBUG is not set
> +# CONFIG_MTD_CONCAT is not set
> +CONFIG_MTD_PARTITIONS=y
> +# CONFIG_MTD_REDBOOT_PARTS is not set
> +CONFIG_MTD_CMDLINE_PARTS=y
> +
> +#
> +# User Modules And Translation Layers
> +#
> +CONFIG_MTD_CHAR=y
> +CONFIG_MTD_BLOCK=y
> +# CONFIG_FTL is not set
> +# CONFIG_NFTL is not set
> +# CONFIG_INFTL is not set
> +
> +#
> +# RAM/ROM/Flash chip drivers
> +#
> +CONFIG_MTD_CFI=y
> +# CONFIG_MTD_JEDECPROBE is not set
> +CONFIG_MTD_GEN_PROBE=y
> +CONFIG_MTD_CFI_ADV_OPTIONS=y
> +CONFIG_MTD_CFI_NOSWAP=y
> +# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
> +# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
> +CONFIG_MTD_CFI_GEOMETRY=y
> +# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
> +# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
> +CONFIG_MTD_MAP_BANK_WIDTH_4=y
> +# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> +# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> +# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> +# CONFIG_MTD_CFI_I1 is not set
> +CONFIG_MTD_CFI_I2=y
> +# CONFIG_MTD_CFI_I4 is not set
> +# CONFIG_MTD_CFI_I8 is not set
> +# CONFIG_MTD_OTP is not set
> +# CONFIG_MTD_CFI_INTELEXT is not set
> +CONFIG_MTD_CFI_AMDSTD=y
> +CONFIG_MTD_CFI_AMDSTD_RETRY=0
> +# CONFIG_MTD_CFI_STAA is not set
> +CONFIG_MTD_CFI_UTIL=y
> +# CONFIG_MTD_RAM is not set
> +# CONFIG_MTD_ROM is not set
> +# CONFIG_MTD_ABSENT is not set
> +
> +#
> +# Mapping drivers for chip access
> +#
> +# CONFIG_MTD_COMPLEX_MAPPINGS is not set
> +# CONFIG_MTD_PHYSMAP is not set
> +CONFIG_MTD_TQM834x=y
> +# CONFIG_MTD_PLATRAM is not set
> +
> +#
> +# Self-contained MTD device drivers
> +#
> +# CONFIG_MTD_SLRAM is not set
> +# CONFIG_MTD_PHRAM is not set
> +# CONFIG_MTD_MTDRAM is not set
> +# CONFIG_MTD_BLKMTD is not set
> +# CONFIG_MTD_BLOCK2MTD is not set
> +
> +#
> +# Disk-On-Chip Device Drivers
> +#
> +# CONFIG_MTD_DOC2000 is not set
> +# CONFIG_MTD_DOC2001 is not set
> +# CONFIG_MTD_DOC2001PLUS is not set
> +
> +#
> +# NAND Flash Device Drivers
> +#
> +# CONFIG_MTD_NAND is not set
> +
> +#
> +# Parallel port support
> +#
> +# CONFIG_PARPORT is not set
> +
> +#
> +# Plug and Play support
> +#
> +
> +#
> +# Block devices
> +#
> +# CONFIG_BLK_DEV_FD is not set
> +# CONFIG_BLK_DEV_COW_COMMON is not set
> +CONFIG_BLK_DEV_LOOP=y
> +# CONFIG_BLK_DEV_CRYPTOLOOP is not set
> +# CONFIG_BLK_DEV_NBD is not set
> +CONFIG_BLK_DEV_RAM=y
> +CONFIG_BLK_DEV_RAM_COUNT=16
> +CONFIG_BLK_DEV_RAM_SIZE=32768
> +CONFIG_BLK_DEV_INITRD=y
> +# CONFIG_LBD is not set
> +# CONFIG_CDROM_PKTCDVD is not set
> +
> +#
> +# IO Schedulers
> +#
> +CONFIG_IOSCHED_NOOP=y
> +CONFIG_IOSCHED_AS=y
> +CONFIG_IOSCHED_DEADLINE=y
> +CONFIG_IOSCHED_CFQ=y
> +# CONFIG_ATA_OVER_ETH is not set
> +
> +#
> +# ATA/ATAPI/MFM/RLL support
> +#
> +# CONFIG_IDE is not set
> +
> +#
> +# SCSI device support
> +#
> +# CONFIG_RAID_ATTRS is not set
> +# CONFIG_SCSI is not set
> +
> +#
> +# Multi-device support (RAID and LVM)
> +#
> +# CONFIG_MD is not set
> +
> +#
> +# Fusion MPT device support
> +#
> +# CONFIG_FUSION is not set
> +
> +#
> +# IEEE 1394 (FireWire) support
> +#
> +
> +#
> +# I2O device support
> +#
> +
> +#
> +# Macintosh device drivers
> +#
> +
> +#
> +# Network device support
> +#
> +CONFIG_NETDEVICES=y
> +# CONFIG_DUMMY is not set
> +# CONFIG_BONDING is not set
> +# CONFIG_EQUALIZER is not set
> +# CONFIG_TUN is not set
> +
> +#
> +# PHY device support
> +#
> +# CONFIG_PHYLIB is not set
> +
> +#
> +# Ethernet (10 or 100Mbit)
> +#
> +CONFIG_NET_ETHERNET=y
> +CONFIG_MII=y
> +
> +#
> +# Ethernet (1000 Mbit)
> +#
> +CONFIG_GIANFAR=y
> +# CONFIG_GFAR_NAPI is not set
> +
> +#
> +# Ethernet (10000 Mbit)
> +#
> +
> +#
> +# Token Ring devices
> +#
> +
> +#
> +# Wireless LAN (non-hamradio)
> +#
> +# CONFIG_NET_RADIO is not set
> +
> +#
> +# Wan interfaces
> +#
> +# CONFIG_WAN is not set
> +# CONFIG_PPP is not set
> +# CONFIG_SLIP is not set
> +# CONFIG_SHAPER is not set
> +# CONFIG_NETCONSOLE is not set
> +# CONFIG_NETPOLL is not set
> +# CONFIG_NET_POLL_CONTROLLER is not set
> +
> +#
> +# ISDN subsystem
> +#
> +# CONFIG_ISDN is not set
> +
> +#
> +# Telephony Support
> +#
> +# CONFIG_PHONE is not set
> +
> +#
> +# Input device support
> +#
> +CONFIG_INPUT=y
> +
> +#
> +# Userland interfaces
> +#
> +# CONFIG_INPUT_MOUSEDEV is not set
> +# CONFIG_INPUT_JOYDEV is not set
> +# CONFIG_INPUT_TSDEV is not set
> +# CONFIG_INPUT_EVDEV is not set
> +# CONFIG_INPUT_EVBUG is not set
> +
> +#
> +# Input Device Drivers
> +#
> +# CONFIG_INPUT_KEYBOARD is not set
> +# CONFIG_INPUT_MOUSE is not set
> +# CONFIG_INPUT_JOYSTICK is not set
> +# CONFIG_INPUT_TOUCHSCREEN is not set
> +# CONFIG_INPUT_MISC is not set
> +
> +#
> +# Hardware I/O ports
> +#
> +# CONFIG_SERIO is not set
> +# CONFIG_GAMEPORT is not set
> +
> +#
> +# Character devices
> +#
> +# CONFIG_VT is not set
> +# CONFIG_SERIAL_NONSTANDARD is not set
> +
> +#
> +# Serial drivers
> +#
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_NR_UARTS=4
> +# CONFIG_SERIAL_8250_EXTENDED is not set
> +
> +#
> +# Non-8250 serial port support
> +#
> +CONFIG_SERIAL_CORE=y
> +CONFIG_SERIAL_CORE_CONSOLE=y
> +CONFIG_UNIX98_PTYS=y
> +CONFIG_LEGACY_PTYS=y
> +CONFIG_LEGACY_PTY_COUNT=256
> +
> +#
> +# IPMI
> +#
> +# CONFIG_IPMI_HANDLER is not set
> +
> +#
> +# Watchdog Cards
> +#
> +# CONFIG_WATCHDOG is not set
> +# CONFIG_NVRAM is not set
> +CONFIG_GEN_RTC=y
> +# CONFIG_GEN_RTC_X is not set
> +# CONFIG_DTLK is not set
> +# CONFIG_R3964 is not set
> +
> +#
> +# Ftape, the floppy tape device driver
> +#
> +# CONFIG_AGP is not set
> +# CONFIG_RAW_DRIVER is not set
> +
> +#
> +# TPM devices
> +#
> +
> +#
> +# I2C support
> +#
> +CONFIG_I2C=y
> +CONFIG_I2C_CHARDEV=y
> +
> +#
> +# I2C Algorithms
> +#
> +# CONFIG_I2C_ALGOBIT is not set
> +# CONFIG_I2C_ALGOPCF is not set
> +# CONFIG_I2C_ALGOPCA is not set
> +
> +#
> +# I2C Hardware Bus support
> +#
> +CONFIG_I2C_MPC=y
> +# CONFIG_I2C_PARPORT_LIGHT is not set
> +# CONFIG_I2C_PCA_ISA is not set
> +
> +#
> +# Miscellaneous I2C Chip support
> +#
> +CONFIG_SENSORS_DS1337=y
> +# CONFIG_SENSORS_DS1374 is not set
> +# CONFIG_SENSORS_EEPROM is not set
> +# CONFIG_SENSORS_PCF8574 is not set
> +# CONFIG_SENSORS_PCA9539 is not set
> +# CONFIG_SENSORS_PCF8591 is not set
> +# CONFIG_SENSORS_RTC8564 is not set
> +# CONFIG_SENSORS_M41T00 is not set
> +# CONFIG_SENSORS_MAX6875 is not set
> +# CONFIG_I2C_DEBUG_CORE is not set
> +# CONFIG_I2C_DEBUG_ALGO is not set
> +# CONFIG_I2C_DEBUG_BUS is not set
> +# CONFIG_I2C_DEBUG_CHIP is not set
> +
> +#
> +# Dallas's 1-wire bus
> +#
> +# CONFIG_W1 is not set
> +
> +#
> +# Hardware Monitoring support
> +#
> +CONFIG_HWMON=y
> +# CONFIG_HWMON_VID is not set
> +# CONFIG_SENSORS_ADM1021 is not set
> +# CONFIG_SENSORS_ADM1025 is not set
> +# CONFIG_SENSORS_ADM1026 is not set
> +# CONFIG_SENSORS_ADM1031 is not set
> +# CONFIG_SENSORS_ADM9240 is not set
> +# CONFIG_SENSORS_ASB100 is not set
> +# CONFIG_SENSORS_ATXP1 is not set
> +# CONFIG_SENSORS_DS1621 is not set
> +# CONFIG_SENSORS_FSCHER is not set
> +# CONFIG_SENSORS_FSCPOS is not set
> +# CONFIG_SENSORS_GL518SM is not set
> +# CONFIG_SENSORS_GL520SM is not set
> +# CONFIG_SENSORS_IT87 is not set
> +# CONFIG_SENSORS_LM63 is not set
> +CONFIG_SENSORS_LM75=y
> +# CONFIG_SENSORS_LM77 is not set
> +# CONFIG_SENSORS_LM78 is not set
> +# CONFIG_SENSORS_LM80 is not set
> +# CONFIG_SENSORS_LM83 is not set
> +# CONFIG_SENSORS_LM85 is not set
> +# CONFIG_SENSORS_LM87 is not set
> +# CONFIG_SENSORS_LM90 is not set
> +# CONFIG_SENSORS_LM92 is not set
> +# CONFIG_SENSORS_MAX1619 is not set
> +# CONFIG_SENSORS_PC87360 is not set
> +# CONFIG_SENSORS_SMSC47M1 is not set
> +# CONFIG_SENSORS_SMSC47B397 is not set
> +# CONFIG_SENSORS_W83781D is not set
> +# CONFIG_SENSORS_W83792D is not set
> +# CONFIG_SENSORS_W83L785TS is not set
> +# CONFIG_SENSORS_W83627HF is not set
> +# CONFIG_SENSORS_W83627EHF is not set
> +# CONFIG_HWMON_DEBUG_CHIP is not set
> +
> +#
> +# Misc devices
> +#
> +
> +#
> +# Multimedia Capabilities Port drivers
> +#
> +
> +#
> +# Multimedia devices
> +#
> +# CONFIG_VIDEO_DEV is not set
> +
> +#
> +# Digital Video Broadcasting Devices
> +#
> +# CONFIG_DVB is not set
> +
> +#
> +# Graphics support
> +#
> +# CONFIG_FB is not set
> +
> +#
> +# Sound
> +#
> +# CONFIG_SOUND is not set
> +
> +#
> +# USB support
> +#
> +# CONFIG_USB_ARCH_HAS_HCD is not set
> +# CONFIG_USB_ARCH_HAS_OHCI is not set
> +
> +#
> +# USB Gadget Support
> +#
> +# CONFIG_USB_GADGET is not set
> +
> +#
> +# MMC/SD Card support
> +#
> +# CONFIG_MMC is not set
> +
> +#
> +# InfiniBand support
> +#
> +
> +#
> +# SN Devices
> +#
> +
> +#
> +# File systems
> +#
> +CONFIG_EXT2_FS=y
> +# CONFIG_EXT2_FS_XATTR is not set
> +# CONFIG_EXT2_FS_XIP is not set
> +CONFIG_EXT3_FS=y
> +CONFIG_EXT3_FS_XATTR=y
> +# CONFIG_EXT3_FS_POSIX_ACL is not set
> +# CONFIG_EXT3_FS_SECURITY is not set
> +CONFIG_JBD=y
> +# CONFIG_JBD_DEBUG is not set
> +CONFIG_FS_MBCACHE=y
> +# CONFIG_REISERFS_FS is not set
> +# CONFIG_JFS_FS is not set
> +# CONFIG_FS_POSIX_ACL is not set
> +# CONFIG_XFS_FS is not set
> +# CONFIG_MINIX_FS is not set
> +# CONFIG_ROMFS_FS is not set
> +CONFIG_INOTIFY=y
> +# CONFIG_QUOTA is not set
> +CONFIG_DNOTIFY=y
> +# CONFIG_AUTOFS_FS is not set
> +# CONFIG_AUTOFS4_FS is not set
> +# CONFIG_FUSE_FS is not set
> +
> +#
> +# CD-ROM/DVD Filesystems
> +#
> +# CONFIG_ISO9660_FS is not set
> +# CONFIG_UDF_FS is not set
> +
> +#
> +# DOS/FAT/NT Filesystems
> +#
> +# CONFIG_MSDOS_FS is not set
> +# CONFIG_VFAT_FS is not set
> +# CONFIG_NTFS_FS is not set
> +
> +#
> +# Pseudo filesystems
> +#
> +CONFIG_PROC_FS=y
> +CONFIG_PROC_KCORE=y
> +CONFIG_SYSFS=y
> +CONFIG_TMPFS=y
> +# CONFIG_HUGETLB_PAGE is not set
> +CONFIG_RAMFS=y
> +# CONFIG_RELAYFS_FS is not set
> +
> +#
> +# Miscellaneous filesystems
> +#
> +# CONFIG_ADFS_FS is not set
> +# CONFIG_AFFS_FS is not set
> +# CONFIG_HFS_FS is not set
> +# CONFIG_HFSPLUS_FS is not set
> +# CONFIG_BEFS_FS is not set
> +# CONFIG_BFS_FS is not set
> +# CONFIG_EFS_FS is not set
> +# CONFIG_JFFS_FS is not set
> +CONFIG_JFFS2_FS=y
> +CONFIG_JFFS2_FS_DEBUG=0
> +CONFIG_JFFS2_FS_WRITEBUFFER=y
> +CONFIG_JFFS2_COMPRESSION_OPTIONS=y
> +CONFIG_JFFS2_ZLIB=y
> +CONFIG_JFFS2_RTIME=y
> +CONFIG_JFFS2_RUBIN=y
> +# CONFIG_JFFS2_CMODE_NONE is not set
> +CONFIG_JFFS2_CMODE_PRIORITY=y
> +# CONFIG_JFFS2_CMODE_SIZE is not set
> +# CONFIG_CRAMFS is not set
> +# CONFIG_VXFS_FS is not set
> +# CONFIG_HPFS_FS is not set
> +# CONFIG_QNX4FS_FS is not set
> +# CONFIG_SYSV_FS is not set
> +# CONFIG_UFS_FS is not set
> +
> +#
> +# Network File Systems
> +#
> +CONFIG_NFS_FS=y
> +# CONFIG_NFS_V3 is not set
> +# CONFIG_NFS_V4 is not set
> +# CONFIG_NFS_DIRECTIO is not set
> +# CONFIG_NFSD is not set
> +CONFIG_ROOT_NFS=y
> +CONFIG_LOCKD=y
> +CONFIG_NFS_COMMON=y
> +CONFIG_SUNRPC=y
> +# CONFIG_RPCSEC_GSS_KRB5 is not set
> +# CONFIG_RPCSEC_GSS_SPKM3 is not set
> +# CONFIG_SMB_FS is not set
> +# CONFIG_CIFS is not set
> +# CONFIG_NCP_FS is not set
> +# CONFIG_CODA_FS is not set
> +# CONFIG_AFS_FS is not set
> +# CONFIG_9P_FS is not set
> +
> +#
> +# Partition Types
> +#
> +CONFIG_PARTITION_ADVANCED=y
> +# CONFIG_ACORN_PARTITION is not set
> +# CONFIG_OSF_PARTITION is not set
> +# CONFIG_AMIGA_PARTITION is not set
> +# CONFIG_ATARI_PARTITION is not set
> +# CONFIG_MAC_PARTITION is not set
> +# CONFIG_MSDOS_PARTITION is not set
> +# CONFIG_LDM_PARTITION is not set
> +# CONFIG_SGI_PARTITION is not set
> +# CONFIG_ULTRIX_PARTITION is not set
> +# CONFIG_SUN_PARTITION is not set
> +# CONFIG_EFI_PARTITION is not set
> +
> +#
> +# Native Language Support
> +#
> +# CONFIG_NLS is not set
> +
> +#
> +# Library routines
> +#
> +# CONFIG_CRC_CCITT is not set
> +# CONFIG_CRC16 is not set
> +CONFIG_CRC32=y
> +# CONFIG_LIBCRC32C is not set
> +CONFIG_ZLIB_INFLATE=y
> +CONFIG_ZLIB_DEFLATE=y
> +
> +#
> +# Profiling support
> +#
> +# CONFIG_PROFILING is not set
> +
> +#
> +# Kernel hacking
> +#
> +# CONFIG_PRINTK_TIME is not set
> +# CONFIG_DEBUG_KERNEL is not set
> +CONFIG_LOG_BUF_SHIFT=14
> +# CONFIG_SERIAL_TEXT_DEBUG is not set
> +
> +#
> +# Security options
> +#
> +# CONFIG_KEYS is not set
> +# CONFIG_SECURITY is not set
> +
> +#
> +# Cryptographic options
> +#
> +# CONFIG_CRYPTO is not set
> +
> +#
> +# Hardware crypto devices
> +#
> diff --git a/arch/ppc/platforms/83xx/Makefile b/arch/ppc/platforms/ 
> 83xx/Makefile
> --- a/arch/ppc/platforms/83xx/Makefile
> +++ b/arch/ppc/platforms/83xx/Makefile
> @@ -2,3 +2,4 @@
>  # Makefile for the PowerPC 83xx linux kernel.
>  #
>  obj-$(CONFIG_MPC834x_SYS)    += mpc834x_sys.o
> +obj-$(CONFIG_TQM834x)        += tqm834x.o
> diff --git a/arch/ppc/platforms/83xx/tqm834x.c b/arch/ppc/platforms/ 
> 83xx/tqm834x.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/ppc/platforms/83xx/tqm834x.c
> @@ -0,0 +1,336 @@
> +/*
> + * arch/ppc/platforms/83xx/tqm834x.c
> + *
> + * TQ Components TQM834x board routines
> + *
> + * Copyright 2005 DENX Software Engineering
> + * Derived from mpc834x_sys.c
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/reboot.h>
> +#include <linux/pci.h>
> +#include <linux/kdev_t.h>
> +#include <linux/major.h>
> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/seq_file.h>
> +#include <linux/root_dev.h>
> +#include <linux/serial.h>
> +#include <linux/tty.h>    /* for linux/serial_core.h */
> +#include <linux/serial_core.h>
> +#include <linux/initrd.h>
> +#include <linux/module.h>
> +#include <linux/fsl_devices.h>
> +
> +#include <asm/system.h>
> +#include <asm/pgtable.h>
> +#include <asm/page.h>
> +#include <asm/atomic.h>
> +#include <asm/time.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/ipic.h>
> +#include <asm/bootinfo.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/mpc83xx.h>
> +#include <asm/irq.h>
> +#include <asm/kgdb.h>
> +#include <asm/ppc_sys.h>
> +#include <mm/mmu_decl.h>
> +
> +#include <syslib/ppc83xx_setup.h>
> +
> +#ifndef CONFIG_PCI
> +unsigned long isa_io_base = 0;
> +unsigned long isa_mem_base = 0;
> +#endif
> +
> +extern unsigned long total_memory;    /* in mm/init */
> +
> +unsigned char __res[sizeof (bd_t)];
> +
> +#ifdef CONFIG_PCI
> +int
> +mpc83xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned  
> char pin)
> +{
> +    static char pci_irq_table[][4] =
> +        /*
> +         *      PCI IDSEL/INTPIN->INTLINE
> +         *       A      B      C      D
> +         */
> +    {
> +        {PIRQA, PIRQB,  PIRQC,  PIRQD}, /* idsel 0x11 */
> +        {PIRQC, PIRQD,  PIRQA,  PIRQB}, /* idsel 0x12 */
> +        {PIRQD, PIRQA,  PIRQB,  PIRQC}  /* idsel 0x13 */
> +    };
> +
> +    const long min_idsel = 0x11, max_idsel = 0x13, irqs_per_slot = 4;
> +    return PCI_IRQ_TABLE_LOOKUP;
> +}
> +
> +int
> +mpc83xx_exclude_device(u_char bus, u_char devfn)
> +{
> +    return PCIBIOS_SUCCESSFUL;
> +}
> +#endif /* CONFIG_PCI */
> +
> +/*  
> ********************************************************************** 
> **
> + *
> + * Setup the architecture
> + *
> + */
> +static void __init
> +tqm834x_setup_arch(void)
> +{
> +    bd_t *binfo = (bd_t *) __res;
> +    unsigned int freq;
> +    struct gianfar_platform_data *pdata;
> +
> +    /* get the core frequency */
> +    freq = binfo->bi_intfreq;
> +
> +    /* Set loops_per_jiffy to a half-way reasonable value,
> +       for use until calibrate_delay gets called. */
> +    loops_per_jiffy = freq / HZ;
> +
> +#ifdef CONFIG_PCI
> +    /* setup PCI host bridges */
> +    mpc83xx_setup_hose();
> +#endif
> +    mpc83xx_early_serial_map();
> +
> +    /* setup the board related information for the enet  
> controllers */
> +    pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata 
> (MPC83xx_TSEC1);
> +    if (pdata) {
> +        pdata->board_flags = FSL_GIANFAR_BRD_IS_REDUCED;
> +        pdata->interruptPHY = MPC83xx_IRQ_EXT1;
> +        pdata->phyid = 0;
> +        /* fixup phy address */
> +        pdata->phy_reg_addr += binfo->bi_immr_base;
> +        memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
> +    }
> +
> +    pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata 
> (MPC83xx_TSEC2);
> +    if (pdata) {
> +        pdata->board_flags = FSL_GIANFAR_BRD_IS_REDUCED;
> +        pdata->interruptPHY = MPC83xx_IRQ_EXT1;
> +        pdata->phyid = 1;
> +        /* fixup phy address */
> +        pdata->phy_reg_addr += binfo->bi_immr_base;
> +        memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
> +    }
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +    if (initrd_start)
> +        ROOT_DEV = Root_RAM0;
> +    else
> +#endif
> +#ifdef  CONFIG_ROOT_NFS
> +        ROOT_DEV = Root_NFS;
> +#else
> +        ROOT_DEV = Root_HDA1;
> +#endif
> +}
> +
> +static void __init
> +tqm834x_map_io(void)
> +{
> +    /* we steal the lowest ioremap addr for virt space */
> +    io_block_mapping(VIRT_IMMRBAR, immrbar, 1024*1024, _PAGE_IO);
> +}
> +
> +int
> +tqm834x_show_cpuinfo(struct seq_file *m)
> +{
> +    uint pvid, svid, phid1;
> +    bd_t *binfo = (bd_t *) __res;
> +    unsigned int freq;
> +
> +    /* get the core frequency */
> +    freq = binfo->bi_intfreq;
> +
> +    pvid = mfspr(SPRN_PVR);
> +    svid = mfspr(SPRN_SVR);
> +
> +    seq_printf(m, "Vendor\t\t: Freescale Inc.\n");
> +    seq_printf(m, "Machine\t\t: TQM%s\n", cur_ppc_sys_spec- 
> >ppc_sys_name);
> +    seq_printf(m, "core clock\t: %d MHz\n"
> +            "bus  clock\t: %d MHz\n",
> +            (int)(binfo->bi_intfreq / 1000000),
> +            (int)(binfo->bi_busfreq / 1000000));
> +    seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
> +    seq_printf(m, "SVR\t\t: 0x%x\n", svid);
> +
> +    /* Display cpu Pll setting */
> +    phid1 = mfspr(SPRN_HID1);
> +    seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
> +
> +    /* Display the amount of memory */
> +    seq_printf(m, "Memory\t\t: %d MB\n", (int)(binfo->bi_memsize /  
> (1024 * 1024)));
> +
> +    return 0;
> +}
> +
> +void __init
> +tqm834x_init_IRQ(void)
> +{
> +    bd_t *binfo = (bd_t *) __res;
> +
> +    u8 senses[8] = {
> +        0,            /* EXT 0 */
> +        0,            /* EXT 1 */
> +        0,            /* EXT 2 */
> +        0,            /* EXT 3 */
> +#ifdef CONFIG_PCI
> +        IRQ_SENSE_LEVEL,    /* EXT 4 */
> +        IRQ_SENSE_LEVEL,    /* EXT 5 */
> +        IRQ_SENSE_LEVEL,    /* EXT 6 */
> +        IRQ_SENSE_LEVEL,    /* EXT 7 */
> +#else
> +        0,            /* EXT 4 */
> +        0,            /* EXT 5 */
> +        0,            /* EXT 6 */
> +        0,            /* EXT 7 */
> +#endif
> +    };
> +
> +    ipic_init(binfo->bi_immr_base + 0x00700, 0,  
> MPC83xx_IPIC_IRQ_OFFSET, senses, 8);
> +
> +    /* Initialize the default interrupt mapping priorities,
> +     * in case the boot rom changed something on us.
> +     */
> +    ipic_set_default_priority();
> +}
> +
> +#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1337)
> +extern ulong ds1337_get_rtc_time(void);
> +extern int ds1337_set_rtc_time(unsigned long nowtime);
> +
> +static int __init
> +tqm834x_rtc_hookup(void)
> +{
> +    struct timespec    tv;
> +
> +        ppc_md.set_rtc_time = ds1337_set_rtc_time;
> +        ppc_md.get_rtc_time = ds1337_get_rtc_time;
> +
> +    tv.tv_nsec = 0;
> +    tv.tv_sec = (ppc_md.get_rtc_time)();
> +    do_settimeofday(&tv);
> +
> +    return 0;
> +}
> +late_initcall(tqm834x_rtc_hookup);
> +#endif
> +
> +static __inline__ void
> +tqm834x_set_bat(void)
> +{
> +    /* we steal the lowest ioremap addr for virt space */
> +    mb();
> +    mtspr(SPRN_DBAT1U, VIRT_IMMRBAR | 0x1e);
> +    mtspr(SPRN_DBAT1L, immrbar | 0x2a);
> +    mb();
> +}
> +
> +void __init
> +platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> +          unsigned long r6, unsigned long r7)
> +{
> +    bd_t *binfo = (bd_t *) __res;
> +
> +    /* parse_bootinfo must always be called first */
> +    parse_bootinfo(find_bootinfo());
> +
> +    /*
> +     * If we were passed in a board information, copy it into the
> +     * residual data area.
> +     */
> +    if (r3) {
> +        memcpy((void *) __res, (void *) (r3 + KERNELBASE),
> +               sizeof (bd_t));
> +    }
> +
> +#if defined(CONFIG_BLK_DEV_INITRD)
> +    /*
> +     * If the init RAM disk has been configured in, and there's a  
> valid
> +     * starting address for it, set it up.
> +     */
> +    if (r4) {
> +        initrd_start = r4 + KERNELBASE;
> +        initrd_end = r5 + KERNELBASE;
> +    }
> +#endif /* CONFIG_BLK_DEV_INITRD */
> +
> +    /* Copy the kernel command line arguments to a safe place. */
> +    if (r6) {
> +        *(char *) (r7 + KERNELBASE) = 0;
> +        strcpy(cmd_line, (char *) (r6 + KERNELBASE));
> +    }
> +
> +    immrbar = binfo->bi_immr_base;
> +
> +    tqm834x_set_bat();
> +
> +#if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
> +    {
> +        struct uart_port p;
> +
> +        memset(&p, 0, sizeof (p));
> +        p.iotype = SERIAL_IO_MEM;
> +        p.membase = (unsigned char __iomem *)(VIRT_IMMRBAR + 0x4500);
> +        p.uartclk = binfo->bi_busfreq;
> +
> +        gen550_init(0, &p);
> +
> +        memset(&p, 0, sizeof (p));
> +        p.iotype = SERIAL_IO_MEM;
> +        p.membase = (unsigned char __iomem *)(VIRT_IMMRBAR + 0x4600);
> +        p.uartclk = binfo->bi_busfreq;
> +
> +        gen550_init(1, &p);
> +    }
> +#endif
> +
> +    identify_ppc_sys_by_id(mfspr(SPRN_SVR));
> +
> +    /* setup the PowerPC module struct */
> +    ppc_md.setup_arch = tqm834x_setup_arch;
> +    ppc_md.show_cpuinfo = tqm834x_show_cpuinfo;
> +
> +    ppc_md.init_IRQ = tqm834x_init_IRQ;
> +    ppc_md.get_irq = ipic_get_irq;
> +
> +    ppc_md.restart = mpc83xx_restart;
> +    ppc_md.power_off = mpc83xx_power_off;
> +    ppc_md.halt = mpc83xx_halt;
> +
> +    ppc_md.find_end_of_memory = mpc83xx_find_end_of_memory;
> +    ppc_md.setup_io_mappings  = tqm834x_map_io;
> +
> +    ppc_md.time_init = mpc83xx_time_init;
> +    ppc_md.set_rtc_time = NULL;
> +    ppc_md.get_rtc_time = NULL;
> +    ppc_md.calibrate_decr = mpc83xx_calibrate_decr;
> +
> +    ppc_md.early_serial_map = mpc83xx_early_serial_map;
> +#if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
> +    ppc_md.progress = gen550_progress;
> +#endif    /* CONFIG_SERIAL_8250 && CONFIG_SERIAL_TEXT_DEBUG */
> +
> +    if (ppc_md.progress)
> +        ppc_md.progress("tqm834x_init(): exit", 0);
> +
> +    return;
> +}
> diff --git a/arch/ppc/platforms/83xx/tqm834x.h b/arch/ppc/platforms/ 
> 83xx/tqm834x.h
> new file mode 100644
> --- /dev/null
> +++ b/arch/ppc/platforms/83xx/tqm834x.h
> @@ -0,0 +1,40 @@
> +/*
> + * arch/ppc/platforms/83xx/tqm834x.h
> + *
> + * TQ Components TQM834x common board definitions
> + *
> + * Copyright 2005 DENX Software Engineering
> + * Derived from mpc834x_sys.h
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + *
> + */
> +
> +#ifndef __MACH_TQM834X_H__
> +#define __MACH_TQM834X_H__
> +
> +#include <linux/config.h>
> +#include <linux/init.h>
> +#include <linux/seq_file.h>
> +#include <syslib/ppc83xx_setup.h>
> +#include <asm/ppcboot.h>
> +
> +#define VIRT_IMMRBAR        ((uint)0xfe000000)
> +
> +#define PIRQA    MPC83xx_IRQ_EXT4
> +#define PIRQB    MPC83xx_IRQ_EXT5
> +#define PIRQC    MPC83xx_IRQ_EXT6
> +#define PIRQD    MPC83xx_IRQ_EXT7
> +
> +#define MPC83xx_PCI1_LOWER_IO    0x00000000
> +#define MPC83xx_PCI1_UPPER_IO    0x00ffffff
> +#define MPC83xx_PCI1_LOWER_MEM    0x80000000
> +#define MPC83xx_PCI1_UPPER_MEM    0x9fffffff
> +#define MPC83xx_PCI1_IO_BASE    0xe2000000
> +#define MPC83xx_PCI1_MEM_OFFSET    0x00000000
> +#define MPC83xx_PCI1_IO_SIZE    0x01000000
> +
> +#endif                /* __MACH_TQM834X_H__ */
> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -340,6 +340,14 @@ config MTD_REDWOOD
>        Redwood board. If you have one of these boards and would  
> like to
>        use the flash chips on it, say 'Y'.
>
> +config MTD_TQM834x
> +    tristate "Flash device mapped on TQ Components TQM834x Boards"
> +    depends on MTD_CFI && PPC32 && 83xx && TQM834x
> +    help
> +      This enables access routines for the flash chips on the
> +      TQ Components TQM834x boards. If you have one of these boards
> +      and would like to use the flash chips on it, say 'Y'.
> +
>  config MTD_CSTM_MIPS_IXX
>      tristate "Flash chip mapping on ITE QED-4N-S01B, Globespan IVR  
> or custom board"
>      depends on MIPS && MTD_CFI && MTD_JEDECPROBE && MTD_PARTITIONS
> diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
> --- a/drivers/mtd/maps/Makefile
> +++ b/drivers/mtd/maps/Makefile
> @@ -70,3 +70,4 @@ obj-$(CONFIG_MTD_DMV182)    += dmv182.o
>  obj-$(CONFIG_MTD_SHARP_SL)    += sharpsl-flash.o
>  obj-$(CONFIG_MTD_PLATRAM)    += plat-ram.o
>  obj-$(CONFIG_MTD_OMAP_NOR)    += omap_nor.o
> +obj-$(CONFIG_MTD_TQM834x)    += tqm834x.o
> diff --git a/drivers/mtd/maps/tqm834x.c b/drivers/mtd/maps/tqm834x.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/mtd/maps/tqm834x.c
> @@ -0,0 +1,298 @@
> +/*
> + * drivers/mtd/maps/tqm834x.c
> + *
> + * MTD mapping driver for TQM834x boards
> + *
> + * Copyright 2005 Wolfgang Denk, DENX Software Engineering,  
> <wd@denx.de>.
> + *
> + * This file is licensed under the terms of the GNU General Public  
> License
> + * version 2.  This program is licensed "as is" without any  
> warranty of any
> + * kind, whether express or implied.
> + *
> + */
> +
> +#include <linux/config.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <asm/io.h>
> +#include <asm/ppcboot.h>
> +
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/map.h>
> +#include <linux/mtd/partitions.h>
> +
> +#if 0    /* Debugging turned off */
> +# define debugk(fmt,args...)    printk(fmt ,##args)
> +#else
> +# define debugk(fmt,args...)
> +#endif
> +
> +#define FLASH_BANK_MAX    2
> +
> +extern unsigned char __res[];
> +
> +/* trivial struct to describe partition information */
> +struct mtd_part_def
> +{
> +    int nums;
> +    unsigned char *type;
> +    struct mtd_partition* mtd_part;
> +};
> +
> +static struct mtd_info* mtd_banks[FLASH_BANK_MAX];
> +static struct map_info* map_banks[FLASH_BANK_MAX];
> +static struct mtd_part_def part_banks[FLASH_BANK_MAX];
> +
> +static unsigned long num_banks;
> +static unsigned long start_scan_addr;
> +
> +#ifdef CONFIG_MTD_PARTITIONS
> +/*
> + * The following defines the partition layout of TQM834x boards.
> + *
> + * See include/linux/mtd/partitions.h for definition of the
> + * mtd_partition structure.
> + *
> + * Assume minimal initial size of 4 MiB per bank, will be updated
> + * later in init_tqm834x_mtd() routine.
> + */
> +
> +/* Partition definition for the first flash bank which is always  
> present. */
> +static struct mtd_partition tqm834x_partitions_bank1[] = {
> +    {
> +        name:    "u-boot",        /* u-boot firmware    */
> +        offset:    0x00000000,
> +        size:    0x00040000,        /* 256 KiB        */
> +        /*mask_flags: MTD_WRITEABLE,     * force read-only    */
> +    },
> +    {
> +        name:    "env",            /* u-boot environment    */
> +        offset:    0x00040000,
> +        size:    0x00020000,        /* 128 KiB        */
> +        /*mask_flags: MTD_WRITEABLE,     * force read-only    */
> +    },
> +    {
> +        name:    "kernel",        /* linux kernel image    */
> +        offset:    0x00060000,
> +        size:    0x00100000,        /* 1 MiB        */
> +        /*mask_flags: MTD_WRITEABLE,     * force read-only    */
> +    },
> +    {
> +        name:    "initrd",        /* ramdisk image    */
> +        offset:    0x00160000,
> +        size:    0x00200000,        /* 2 MiB        */
> +    },
> +    {
> +        name:    "user",            /* user data        */
> +        offset:    0x00360000,
> +        size:    0x000a0000,        /* remaining space    */
> +        /* NOTE: this parttion size is re-calcated in        */
> +        /* init_tqm834x_mtd() to cover actual remaining space.    */
> +    },
> +};
> +
> +/* Partition definition for the second flash bank which may be  
> present on some
> + * TQM834x boards.
> + */
> +static struct mtd_partition tqm834x_partitions_bank2[] = {
> +    {
> +        name:    "jffs2",        /* jffs2 filesystem    */
> +        offset:    0x00000000,
> +        size:    0x00400000,        /* whole device        */
> +        /* NOTE: this parttion size is re-calcated in        */
> +        /* init_tqm834x_mtd() to cover actual device size.    */
> +    },
> +};
> +
> +#endif    /* CONFIG_MTD_PARTITIONS */
> +
> +#define NB_OF(x)  (sizeof(x)/sizeof(x[0]))
> +
> +int __init init_tqm834x_mtd(void)
> +{
> +    int idx = 0, ret = 0;
> +    unsigned long flash_addr, flash_size, mtd_size = 0;
> +
> +    /* pointer to TQM834x board info data */
> +    bd_t *bd = (bd_t *)__res;
> +#ifdef CONFIG_MTD_CMDLINE_PARTS
> +    int n;
> +    char mtdid[4];
> +    const char *part_probes[] = { "cmdlinepart", NULL };
> +#endif
> +
> +    flash_addr = bd->bi_flashstart;
> +    flash_size = bd->bi_flashsize;
> +
> +    /* request maximum flash size address space */
> +    start_scan_addr = (unsigned long)ioremap(flash_addr, flash_size);
> +    if (!start_scan_addr) {
> +        printk("%s: Failed to ioremap address: 0x%lx\n",
> +            __FUNCTION__, flash_addr);
> +        return -EIO;
> +    }
> +
> +    for(idx = 0 ; idx < FLASH_BANK_MAX ; idx++) {
> +        if (mtd_size >= flash_size)
> +            break;
> +
> +        debugk ("%s: chip probing count %d\n", __FUNCTION__, idx);
> +
> +        map_banks[idx] = (struct map_info *)kmalloc(sizeof(struct  
> map_info),
> +                            GFP_KERNEL);
> +        if (map_banks[idx] == NULL) {
> +            ret = -ENOMEM;
> +            goto error_mem;
> +        }
> +        memset((void *)map_banks[idx], 0, sizeof(struct map_info));
> +        map_banks[idx]->name = (char *)kmalloc(16, GFP_KERNEL);
> +        if (map_banks[idx]->name == NULL) {
> +            ret = -ENOMEM;
> +            goto error_mem;
> +        }
> +        memset((void *)map_banks[idx]->name, 0, 16);
> +
> +        sprintf(map_banks[idx]->name, "TQM834x-%d", idx);
> +        map_banks[idx]->size = flash_size;
> +        map_banks[idx]->bankwidth = 4;
> +
> +        simple_map_init(map_banks[idx]);
> +
> +        map_banks[idx]->virt = (void __iomem *)
> +            (start_scan_addr + ((idx > 0) ?
> +            (mtd_banks[idx-1] ? mtd_banks[idx-1]->size : 0) : 0));
> +        map_banks[idx]->phys =
> +            flash_addr + ((idx > 0) ?
> +            (mtd_banks[idx-1] ? mtd_banks[idx-1]->size : 0) : 0);
> +
> +        /* start to probe flash chips */
> +        mtd_banks[idx] = do_map_probe("cfi_probe", map_banks[idx]);
> +        if (mtd_banks[idx]) {
> +            mtd_banks[idx]->owner = THIS_MODULE;
> +            mtd_size += mtd_banks[idx]->size;
> +            num_banks++;
> +            debugk ("%s: bank %ld, name: %s, size: %d bytes \n",
> +                __FUNCTION__, num_banks,
> +                mtd_banks[idx]->name, mtd_banks[idx]->size);
> +        }
> +    }
> +
> +    /* no supported flash chips found */
> +    if (!num_banks) {
> +        printk("TQM834x: No supported flash chips found!\n");
> +        ret = -ENXIO;
> +        goto error_mem;
> +    }
> +
> +#ifdef CONFIG_MTD_PARTITIONS
> +    /*
> +     * Select static partition definitions
> +     */
> +    n = NB_OF(tqm834x_partitions_bank1);
> +    part_banks[0].mtd_part    = tqm834x_partitions_bank1;
> +    part_banks[0].type    = "static image bank1";
> +    part_banks[0].nums    = n;
> +
> +    /* update last partition size to cover actual remaining space */
> +    tqm834x_partitions_bank1[n - 1].size =
> +        mtd_banks[0]->size -
> +        tqm834x_partitions_bank1[n - 1].offset;
> +
> +    /* check if we have second bank? */
> +    if (num_banks == 2) {
> +        n = NB_OF(tqm834x_partitions_bank2);
> +        part_banks[1].mtd_part    = tqm834x_partitions_bank2;
> +        part_banks[1].type    = "static image bank2";
> +        part_banks[1].nums    = n;
> +
> +        /* update last partition size to cover actual remaining  
> space */
> +        tqm834x_partitions_bank2[n - 1].size =
> +            mtd_banks[1]->size -
> +            tqm834x_partitions_bank2[n - 1].offset;
> +    }
> +
> +    for(idx = 0; idx < num_banks ; idx++) {
> +#ifdef CONFIG_MTD_CMDLINE_PARTS
> +        sprintf(mtdid, "%d", idx);
> +        n = parse_mtd_partitions(mtd_banks[idx],
> +                part_probes,
> +                &part_banks[idx].mtd_part,
> +                0);
> +        debugk ("%s: %d command line partitions on bank %s\n",
> +                __FUNCTION__, n, mtdid);
> +        if (n > 0) {
> +            part_banks[idx].type = "command line";
> +            part_banks[idx].nums = n;
> +        }
> +#endif    /* CONFIG_MTD_CMDLINE_PARTS */
> +        if (part_banks[idx].nums == 0) {
> +            printk (KERN_NOTICE
> +                "TQM834x flash bank %d: no partition info "
> +                "available, registering whole device\n", idx);
> +            add_mtd_device(mtd_banks[idx]);
> +        } else {
> +            printk (KERN_NOTICE
> +                "TQM834x flash bank %d: Using %s partition "
> +                "definition\n", idx, part_banks[idx].type);
> +            add_mtd_partitions (mtd_banks[idx],
> +                    part_banks[idx].mtd_part,
> +                    part_banks[idx].nums);
> +        }
> +    }
> +#else    /* ! CONFIG_MTD_PARTITIONS */
> +    printk (KERN_NOTICE "TQM834x flash: registering %d flash banks "
> +            "at once\n", num_banks);
> +
> +    for(idx = 0 ; idx < num_banks ; idx++) {
> +        add_mtd_device(mtd_banks[idx]);
> +    }
> +#endif    /* CONFIG_MTD_PARTITIONS */
> +
> +    return 0;
> +error_mem:
> +    for (idx = 0 ; idx < FLASH_BANK_MAX ; idx++) {
> +        if (map_banks[idx] != NULL) {
> +            if (map_banks[idx]->name != NULL) {
> +                kfree(map_banks[idx]->name);
> +                map_banks[idx]->name = NULL;
> +            }
> +            kfree(map_banks[idx]);
> +            map_banks[idx] = NULL;
> +        }
> +    }
> +
> +    iounmap((void *)start_scan_addr);
> +
> +    return ret;
> +}
> +
> +static void __exit cleanup_tqm834x_mtd(void)
> +{
> +    unsigned int idx = 0;
> +    for(idx = 0 ; idx < num_banks ; idx++) {
> +        /* destroy mtd_info previously allocated */
> +        if (mtd_banks[idx]) {
> +            del_mtd_partitions(mtd_banks[idx]);
> +            map_destroy(mtd_banks[idx]);
> +        }
> +
> +        /* release map_info not used anymore */
> +        kfree(map_banks[idx]->name);
> +        kfree(map_banks[idx]);
> +    }
> +
> +    if (start_scan_addr) {
> +        iounmap((void *)start_scan_addr);
> +        start_scan_addr = 0;
> +    }
> +}
> +
> +module_init(init_tqm834x_mtd);
> +module_exit(cleanup_tqm834x_mtd);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Wolfgang Denk <wd@denx.de>");
> +MODULE_DESCRIPTION("MTD map driver for TQM834x boards");
> diff --git a/include/asm-ppc/mpc83xx.h b/include/asm-ppc/mpc83xx.h
> --- a/include/asm-ppc/mpc83xx.h
> +++ b/include/asm-ppc/mpc83xx.h
> @@ -26,6 +26,10 @@
>  #include <platforms/83xx/mpc834x_sys.h>
>  #endif
>
> +#ifdef CONFIG_TQM834x
> +#include <platforms/83xx/tqm834x.h>
> +#endif
> +
>  #define _IO_BASE        isa_io_base
>  #define _ISA_MEM_BASE   isa_mem_base
>  #ifdef CONFIG_PCI
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
