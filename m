From: Brian Waite <waite@skycomputers.com>
To: Linux PPC <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch [5/5]: Platform support for db64360
Date: Wed, 6 Aug 2003 10:47:38 -0400
References: <200308061040.53477.waite@skycomputers.com>
In-Reply-To: <200308061040.53477.waite@skycomputers.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KURM/5Gz88PlwQe"
Message-Id: <200308061047.39010.waite@skycomputers.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Boundary-00=_KURM/5Gz88PlwQe
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline


Hi all,
        There have been a few threads about support for the db64360 Evaluation
board.
I have been using the _devel tree for a while now with a port from the
_galileo tree. I have also put together the MPSC driver and support for
u-boot. Here is a rundown of the known working things:
I've tried to break down the patches into logical order for readability. Let
me know if I can make it any better.

Dink32 bootloader (may need to move around CPU mappings in db64360.h)
uBoot bootloader
PCI/PCI-X
Gigabit Ethernet
Duart serial port
MPSC as uart
Internal SRAM
HW cache coherency
SW cache coherency
SMP (untested by me)

Thanks
Brian



--Boundary-00=_KURM/5Gz88PlwQe
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="db64360_config.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="db64360_config.patch"

--- ./arch/ppc/config.in	2003-08-05 15:19:26.000000000 -0400
+++ /home/waite/Merge/sky_export/./arch/ppc/config.in	2003-08-05 16:08:22.000000000 -0400
@@ -157,6 +157,7 @@
 	 Force-PowerPMC250	CONFIG_POWERPMC250	\
 	 Force-PowerPMC260      CONFIG_PPMC260		\
 	 Marvell-EV-64260-BP	CONFIG_EV64260		\
+	 Marvell-DB-64360-BP    CONFIG_DB64360          \
 	 IBM-Spruce		CONFIG_SPRUCE		\
 	 Momentum-Puma-A	CONFIG_PUMA_A		\
 	 Motorola-HXEB100	CONFIG_HXEB100		\
@@ -212,6 +214,53 @@
    endmenu
 fi

+if [ "$CONFIG_DB64360" = "y" ]; then
+  mainmenu_option next_comment
+  comment 'Marvell MV64360 Options'
+  define_bool CONFIG_MV64360 y
+  define_int CONFIG_SERIAL_CONSOLE_BAUD 115200
+  bool 'Disable Cache Coherency HW Assist in MV64360 DRAM Interface' CONFIG_NOT_COHERENT_CACHE
+  bool 'Consistent memory on SRAM' CONFIG_SPECIAL_CONSISTENT_MEMORY
+  if ["$CONFIG_SPECIAL_CONSISTENT_MEMORY" = "y" ]; then
+    bool 'Enable Cache Coherency HW Assist in MV64360 internal SRAM' CONFIG_MV64360_SRAM_CACHE_COHERENT
+    bool 'MV64360 internal SRAM Cacheable but no cache coherent' CONFIG_MV64360_SRAM_CACHEABLE
+  fi
+  hex 'Base Address assigned by Firmware' CONFIG_MV64360_ORIG_REG_BASE 0xf1000000
+  int 'System Tclk of DB-64360 (in Hz)' CONFIG_DB64360_TCLK 133000000
+
+  bool 'MV64360 Gigabit Ethernet Ports' CONFIG_MV64360_ETH
+  if [ "$CONFIG_MV64360_ETH" = "y" ]; then
+    bool ' MV64360 - Gigabit Ethernet Port 0' CONFIG_MV64360_ETH_0
+    bool ' MV64360 - Gigabit Ethernet Port 1' CONFIG_MV64360_ETH_1
+#    bool ' DB64360 - Gigabit Ethernet Port 2' CONFIG_MV64360_ETH_2
+    if [ "$CONFIG_MV64360_ETH_0" = "y" ]; then
+      bool ' MV64360 - Override Ethernet Port 0' CONFIG_MV64360_ETH_0_MACADDR_OVERRIDE
+      string 'GigBit Port 0 MAC Address' CONFIG_MV64360_ETH_0_MACADDR "643600000000"
+    fi
+    if [ "$CONFIG_MV64360_ETH_1" = "y" ]; then
+      string 'GigBit Port 1 MAC Address' CONFIG_MV64360_ETH_1_MACADDR "643600000001"
+    fi
+#    if [ "$CONFIG_MV64360_ETH_2" = "y" ]; then
+#    string 'GigBit Port 2 MAC Address' CONFIG_MV64360_ETH_2_MACADDR "643600000002"
+#    fi
+    int  'GigBit Ethernet TX Queue size' CONFIG_MV64360_ETH_TXQUEUE_SIZE 1000
+    int  'GigBit Ethernet RX Queue size' CONFIG_MV64360_ETH_RXQUEUE_SIZE 400
+    int  'GigBit Ethernet TX interrupt coalesing timeout' CONFIG_MV64360_ETH_TX_COAL 150
+    int  'GigBit Ethernet RX interrupt coalesing timeout' CONFIG_MV64360_ETH_RX_COAL 150
+  fi
+  bool 'MV64360 MPSC Serial Ports' CONFIG_MV64360_MPSC
+  if [ "$CONFIG_MV64360_MPSC" = "y" ]; then
+    bool ' MPSC Port 0' CONFIG_MV64360_MPSC_0
+    bool ' MPSC Port 1' CONFIG_MV64360_MPSC_1
+    bool ' MPSC Port 0 as system console' CONFIG_MV64360_CONSOLE
+  fi
+  if [ "$CONFIG_MV64360_CONSOLE" = "y" ]; then
+    define_bool CONFIG_SERIAL_CONSOLE y
+  fi
+  bool 'Board uses U-Boot' CONFIG_USE_PPCBOOT
+  endmenu
+fi
+
 if [ "$CONFIG_EV64260" = "y" ]; then
   define_bool CONFIG_GEN550 y
 fi
@@ -777,7 +831,11 @@
 if [ "$CONFIG_ALL_PPC" = "y" ]; then
   bool 'Support for early boot text console (BootX or OpenFirmware only)' CONFIG_BOOTX_TEXT
 fi
-if [ "$CONFIG_GEN550" = "y" -o "$CONFIG_GT64260" = "y" ]; then
+if [ "$CONFIG_MCPN765" = "y" -o "$CONFIG_SANDPOINT" = "y" \
+	-o "$CONFIG_ZX4500" = "y" -o "$CONFIG_PRPMC800" = "y" \
+	-o "$CONFIG_GT64260" = "y" \
+	-o "$CONFIG_DB64360" = "y" \
+	-o "$CONFIG_GEN550" = "y" -o "$CONFIG_PPLUS" = "y" ]; then
   bool 'Support for early boot texts over serial port' CONFIG_SERIAL_TEXT_DEBUG
 fi
 endmenu
diff -Nuar mvista_export/arch/ppc/configs/db64360_defconfig sky_export/arch/ppc/configs/db64360_defconfig
--- mvista_export/arch/ppc/configs/db64360_defconfig	1969-12-31 19:00:00.000000000 -0500
+++ sky_export/arch/ppc/configs/db64360_defconfig	2003-08-05 16:08:25.000000000 -0400
@@ -0,0 +1,571 @@
+#
+# Automatically generated make config: don't edit
+#
+# CONFIG_UID16 is not set
+# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_HAVE_DEC_LOCK=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODVERSIONS=y
+CONFIG_KMOD=y
+
+#
+# Platform support
+#
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_6xx=y
+# CONFIG_40x is not set
+# CONFIG_440 is not set
+# CONFIG_POWER3 is not set
+# CONFIG_8xx is not set
+# CONFIG_PPC_ISERIES is not set
+# CONFIG_8260 is not set
+CONFIG_PPC_STD_MMU=y
+# CONFIG_ALL_PPC is not set
+# CONFIG_APUS is not set
+# CONFIG_WILLOW is not set
+# CONFIG_PCORE is not set
+# CONFIG_POWERPMC250 is not set
+# CONFIG_EV64260 is not set
+CONFIG_DB64360=y
+# CONFIG_SPRUCE is not set
+# CONFIG_MENF1 is not set
+# CONFIG_LOPEC is not set
+# CONFIG_MCPN765 is not set
+# CONFIG_MVME5100 is not set
+# CONFIG_PPLUS is not set
+# CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
+# CONFIG_SANDPOINT is not set
+# CONFIG_MOT_MVP is not set
+# CONFIG_ADIR is not set
+# CONFIG_K2 is not set
+# CONFIG_GEMINI is not set
+# CONFIG_ZX4500 is not set
+# CONFIG_ZUMA_V1 is not set
+# CONFIG_ZUMA_V2 is not set
+
+#
+# Marvell MV64360 Options
+#
+CONFIG_MV64360=y
+CONFIG_SERIAL_CONSOLE_BAUD=115200
+CONFIG_NOT_COHERENT_CACHE=y
+CONFIG_SPECIAL_CONSISTENT_MEMORY=y
+CONFIG_MV64360_SRAM_CACHE_COHERENT=y
+# CONFIG_MV64360_SRAM_CACHEABLE is not set
+CONFIG_MV64360_ORIG_REG_BASE=f1000000
+CONFIG_DB64360_TCLK=133000000
+CONFIG_MV64360_ETH=y
+CONFIG_MV64360_ETH_0=y
+CONFIG_MV64360_ETH_1=y
+CONFIG_MV64360_ETH_0_MACADDR_OVERRIDE=y
+CONFIG_MV64360_ETH_0_MACADDR="643600000000"
+CONFIG_MV64360_ETH_1_MACADDR="643600000001"
+CONFIG_MV64360_ETH_TXQUEUE_SIZE=1000
+CONFIG_MV64360_ETH_RXQUEUE_SIZE=400
+CONFIG_MV64360_ETH_TX_COAL=64
+CONFIG_MV64360_ETH_RX_COAL=64
+# CONFIG_MV64360_MPSC is not set
+# CONFIG_SMP is not set
+CONFIG_ALTIVEC=y
+CONFIG_TAU=y
+# CONFIG_TAU_INT is not set
+# CONFIG_TAU_AVERAGE is not set
+
+#
+# General setup
+#
+# CONFIG_HIGHMEM is not set
+# CONFIG_ISA is not set
+# CONFIG_EISA is not set
+# CONFIG_SBUS is not set
+# CONFIG_MCA is not set
+CONFIG_PCI=y
+CONFIG_NET=y
+CONFIG_SYSCTL=y
+CONFIG_SYSVIPC=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_KCORE_ELF=y
+CONFIG_BINFMT_ELF=y
+CONFIG_KERNEL_ELF=y
+CONFIG_BINFMT_MISC=y
+CONFIG_PCI_NAMES=y
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+CONFIG_PPC_RTC=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs rw nfsroot=10.2.40.2:/mnt/yellow_dog ip=10.2.40.171:10.2.40.2:10.2.0.1:255.255.0.0:lion128.galileo.co.il:eth0:none"
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_PARTITIONS is not set
+# CONFIG_MTD_CONCAT is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_OBSOLETE_CHIPS is not set
+
+#
+# Mapping drivers for chip access
+#
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=fc000000
+CONFIG_MTD_PHYSMAP_LEN=02000000
+CONFIG_MTD_PHYSMAP_BUSWIDTH=4
+# CONFIG_MTD_RPXLITE is not set
+# CONFIG_MTD_DBOX2 is not set
+# CONFIG_MTD_CFI_FLAGADM is not set
+# CONFIG_MTD_REDWOOD is not set
+# CONFIG_MTD_PCI is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC1000 is not set
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOCPROBE is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
+
+#
+# Plug and Play configuration
+#
+# CONFIG_PNP is not set
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_INITRD=y
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+# CONFIG_NETLINK_DEV is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+# CONFIG_FILTER is not set
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_INET_ECN is not set
+CONFIG_SYN_COOKIES=y
+
+#
+#   IP: Netfilter Configuration
+#
+# CONFIG_IP_NF_CONNTRACK is not set
+# CONFIG_IP_NF_QUEUE is not set
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
+# CONFIG_IP_NF_COMPAT_IPFWADM is not set
+# CONFIG_IPV6 is not set
+# CONFIG_KHTTPD is not set
+# CONFIG_ATM is not set
+# CONFIG_VLAN_8021Q is not set
+
+#
+#
+#
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+
+#
+# Appletalk devices
+#
+# CONFIG_DECNET is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_LLC is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_FASTROUTE is not set
+# CONFIG_NET_HW_FLOWCONTROL is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+
+#
+# ATA/IDE/MFM/RLL support
+#
+# CONFIG_IDE is not set
+# CONFIG_BLK_DEV_IDE_MODES is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI support
+#
+# CONFIG_SCSI is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION_BOOT is not set
+# CONFIG_FUSION_ISENSE is not set
+# CONFIG_FUSION_CTL is not set
+# CONFIG_FUSION_LAN is not set
+
+#
+# IEEE 1394 (FireWire) support (EXPERIMENTAL)
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_ETHERTAP is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+# CONFIG_MACE_AAUI_PORT is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_VENDOR_SMC is not set
+# CONFIG_NET_VENDOR_RACAL is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_TULIP is not set
+# CONFIG_TC35815 is not set
+# CONFIG_DE4X5 is not set
+# CONFIG_DGRS is not set
+# CONFIG_DM9102 is not set
+CONFIG_EEPRO100=y
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+# CONFIG_WINBOND_840 is not set
+# CONFIG_NET_POCKET is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+# CONFIG_NET_FC is not set
+# CONFIG_RCPCI is not set
+# CONFIG_SHAPER is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+
+#
+# Amateur Radio support
+#
+# CONFIG_HAMRADIO is not set
+
+#
+# IrDA (infrared) support
+#
+# CONFIG_IRDA is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Old CD-ROM drivers (not SCSI, not IDE)
+#
+# CONFIG_CD_NO_IDESCSI is not set
+
+#
+# Console drivers
+#
+# CONFIG_VGA_CONSOLE is not set
+
+#
+# Frame-buffer support
+#
+# CONFIG_FB is not set
+
+#
+# Input core support
+#
+# CONFIG_INPUT is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+
+#
+# Macintosh device drivers
+#
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_SERIAL=y
+CONFIG_SERIAL_CONSOLE=y
+# CONFIG_SERIAL_EXTENDED is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_UNIX98_PTY_COUNT=256
+
+#
+# I2C support
+#
+CONFIG_I2C=m
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+CONFIG_I2C_CHARDEV=m
+CONFIG_I2C_PROC=m
+
+#
+# Mice
+#
+# CONFIG_BUSMOUSE is not set
+# CONFIG_MOUSE is not set
+
+#
+# Joysticks
+#
+# CONFIG_INPUT_GAMEPORT is not set
+
+#
+# Input core support is needed for gameports
+#
+
+#
+# Input core support is needed for joysticks
+#
+# CONFIG_QIC02_TAPE is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+# CONFIG_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_FTAPE is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# File systems
+#
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_FAT_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+# CONFIG_JFFS2_FS is not set
+# CONFIG_CRAMFS is not set
+CONFIG_TMPFS=y
+CONFIG_RAMFS=y
+# CONFIG_ISO9660_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_NTFS_FS is not set
+# CONFIG_HPFS_FS is not set
+CONFIG_PROC_FS=y
+CONFIG_DEVFS_FS=y
+# CONFIG_DEVFS_MOUNT is not set
+# CONFIG_DEVFS_DEBUG is not set
+CONFIG_DEVPTS_FS=y
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_EXT2_FS=y
+# CONFIG_SYSV_FS is not set
+# CONFIG_UDF_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+# CONFIG_CODA_FS is not set
+# CONFIG_INTERMEZZO_FS is not set
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
+CONFIG_SUNRPC=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+# CONFIG_SMB_FS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_ZISOFS_FS is not set
+# CONFIG_ZLIB_FS_INFLATE is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_SMB_NLS is not set
+# CONFIG_NLS is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+
+#
+# Bluetooth support
+#
+# CONFIG_BLUEZ is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_KGDB is not set
+# CONFIG_XMON is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_SERIAL_TEXT_DEBUG is not set


--Boundary-00=_KURM/5Gz88PlwQe--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
