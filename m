Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12B94DDE21
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 07:46:15 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l5LLfNg5007700
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 17:41:23 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5LLkBLb268504
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 15:46:12 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5LLbV6r021022
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 15:37:31 -0600
Subject: [PATCH] [POWERPC] update g5_defconfig
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 16:37:14 -0500
Message-Id: <1182461834.25426.38.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: will_schmidt <will_schmidt@vnet.ibm.com>, Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Update the g5_defconfig.    This is choosing all defaults via "make
oldconfig", then going back and enabling CONFIG_MACINTOSH_DRIVERS and
options underneath that.    Specifically this is to allow the windfarm
driver to be automatically configured when building a defconfig kernel. 


Signed-off-by Will Schmidt <will_schmidt@vnet.ibm.com>

---
 g5_defconfig |  354 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 185 insertions(+), 169 deletions(-)

diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 3ccf19d..a47a41d 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc5
-# Mon Jan 22 22:15:04 2007
+# Linux kernel version: 2.6.22-rc5
+# Thu Jun 21 15:53:16 2007
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -27,6 +27,7 @@ CONFIG_GENERIC_TBSYNC=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 # CONFIG_DEFAULT_UIMAGE is not set
+CONFIG_PPC64_SWSUSP=y
 
 #
 # Processor support
@@ -39,6 +40,7 @@ CONFIG_PPC_FPU=y
 # CONFIG_PPC_OF_PLATFORM_PCI is not set
 CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_MM_SLICES=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4
@@ -59,6 +61,7 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -66,9 +69,11 @@ CONFIG_POSIX_MQUEUE=y
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_CPUSETS is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
@@ -83,14 +88,19 @@ CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
 
 #
 # Loadable module support
@@ -131,15 +141,21 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_ISERIES is not set
 # CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_MPC5200 is not set
 CONFIG_PPC_PMAC=y
 CONFIG_PPC_PMAC64=y
 # CONFIG_PPC_MAPLE is not set
 # CONFIG_PPC_PASEMI is not set
+# CONFIG_PPC_CELLEB is not set
+# CONFIG_PPC_PS3 is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_IBM_CELL_BLADE is not set
-# CONFIG_PPC_PS3 is not set
+# CONFIG_PQ2ADS is not set
 CONFIG_PPC_NATIVE=y
+CONFIG_MPIC=y
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
 CONFIG_U3_DART=y
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
@@ -160,9 +176,12 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 # CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
 # CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
+
+#
+# CPU Frequency drivers
+#
 CONFIG_CPU_FREQ_PMAC64=y
-# CONFIG_WANT_EARLY_SERIAL is not set
-CONFIG_MPIC=y
+# CONFIG_CPM2 is not set
 
 #
 # Kernel options
@@ -199,34 +218,34 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
+CONFIG_ZONE_DMA_FLAG=1
+# CONFIG_PPC_HAS_HASH_64K is not set
 # CONFIG_PPC_64K_PAGES is not set
 # CONFIG_SCHED_SMT is not set
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 CONFIG_SECCOMP=y
+# CONFIG_WANT_DEVICE_TREE is not set
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
+CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
-# CONFIG_MPIC_WEIRD is not set
-# CONFIG_PPC_I8259 is not set
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
 # CONFIG_PCCARD is not set
-
-#
-# PCI Hotplug Support
-#
 # CONFIG_HOTPLUG_PCI is not set
 CONFIG_KERNEL_START=0xc000000000000000
 
@@ -238,14 +257,15 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=m
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 CONFIG_NET_KEY=m
+# CONFIG_NET_KEY_MIGRATE is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
@@ -270,10 +290,6 @@ CONFIG_INET_TCP_DIAG=y
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
-
-#
-# IP: Virtual Server Configuration
-#
 # CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
@@ -287,8 +303,6 @@ CONFIG_NETFILTER=y
 #
 # CONFIG_NETFILTER_NETLINK is not set
 CONFIG_NF_CONNTRACK_ENABLED=m
-CONFIG_NF_CONNTRACK_SUPPORT=y
-# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
 CONFIG_NF_CONNTRACK=m
 # CONFIG_NF_CT_ACCT is not set
 CONFIG_NF_CONNTRACK_MARK=y
@@ -300,6 +314,7 @@ CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_IRC=m
 # CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
 # CONFIG_NF_CONNTRACK_PPTP is not set
+# CONFIG_NF_CONNTRACK_SANE is not set
 # CONFIG_NF_CONNTRACK_SIP is not set
 CONFIG_NF_CONNTRACK_TFTP=m
 # CONFIG_NETFILTER_XTABLES is not set
@@ -310,20 +325,10 @@ CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 CONFIG_IP_NF_QUEUE=m
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
 # CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -350,7 +355,16 @@ CONFIG_LLC=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
 
 #
 # Device Drivers
@@ -363,16 +377,13 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
 # Connector - unified userspace <-> kernelspace linker
 #
 # CONFIG_CONNECTOR is not set
-
-#
-# Memory Technology Devices (MTD)
-#
 # CONFIG_MTD is not set
 
 #
@@ -383,6 +394,7 @@ CONFIG_FW_LOADER=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -402,7 +414,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_CDROM_PKTCDVD_BUFFERS=8
 # CONFIG_CDROM_PKTCDVD_WCACHE is not set
@@ -411,12 +422,10 @@ CONFIG_CDROM_PKTCDVD_BUFFERS=8
 #
 # Misc devices
 #
+# CONFIG_PHANTOM is not set
 # CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
+# CONFIG_BLINK is not set
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDE=y
 
@@ -431,6 +440,7 @@ CONFIG_BLK_DEV_IDECD=y
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_BLK_DEV_IDESCSI is not set
 # CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_PROC_FS=y
 
 #
 # IDE chipset support/bugfixes
@@ -438,12 +448,12 @@ CONFIG_BLK_DEV_IDECD=y
 CONFIG_IDE_GENERIC=y
 CONFIG_BLK_DEV_IDEPCI=y
 # CONFIG_IDEPCI_SHARE_IRQ is not set
+CONFIG_IDEPCI_PCIBUS_ORDER=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 # CONFIG_BLK_DEV_GENERIC is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
-CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
@@ -458,6 +468,7 @@ CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_IT8213 is not set
 # CONFIG_BLK_DEV_IT821X is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_PDC202XX_OLD is not set
@@ -468,13 +479,13 @@ CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_BLK_DEV_TC86C001 is not set
 CONFIG_BLK_DEV_IDE_PMAC=y
 CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST=y
 CONFIG_BLK_DEV_IDEDMA_PMAC=y
 # CONFIG_IDE_ARM is not set
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
-CONFIG_IDEDMA_AUTO=y
 # CONFIG_BLK_DEV_HD is not set
 
 #
@@ -504,6 +515,7 @@ CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -550,11 +562,8 @@ CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_DEBUG is not set
 # CONFIG_SCSI_SRP is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
 CONFIG_ATA=y
+# CONFIG_ATA_NONSTANDARD is not set
 # CONFIG_SATA_AHCI is not set
 CONFIG_SATA_SVW=y
 # CONFIG_ATA_PIIX is not set
@@ -570,10 +579,12 @@ CONFIG_SATA_SVW=y
 # CONFIG_SATA_ULI is not set
 # CONFIG_SATA_VIA is not set
 # CONFIG_SATA_VITESSE is not set
+# CONFIG_SATA_INIC162X is not set
 # CONFIG_PATA_ALI is not set
 # CONFIG_PATA_AMD is not set
 # CONFIG_PATA_ARTOP is not set
 # CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD640_PCI is not set
 # CONFIG_PATA_CMD64X is not set
 # CONFIG_PATA_CS5520 is not set
 # CONFIG_PATA_CS5530 is not set
@@ -585,6 +596,7 @@ CONFIG_SATA_SVW=y
 # CONFIG_PATA_HPT3X2N is not set
 # CONFIG_PATA_HPT3X3 is not set
 # CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_IT8213 is not set
 # CONFIG_PATA_JMICRON is not set
 # CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_MARVELL is not set
@@ -624,6 +636,7 @@ CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 # CONFIG_DM_MULTIPATH is not set
+# CONFIG_DM_DELAY is not set
 
 #
 # Fusion MPT device support
@@ -636,28 +649,26 @@ CONFIG_DM_ZERO=m
 #
 # IEEE 1394 (FireWire) support
 #
+# CONFIG_FIREWIRE is not set
 CONFIG_IEEE1394=y
 
 #
 # Subsystem Options
 #
 # CONFIG_IEEE1394_VERBOSEDEBUG is not set
-CONFIG_IEEE1394_OUI_DB=y
-CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
-CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
-# CONFIG_IEEE1394_EXPORT_FULL_API is not set
 
 #
-# Device Drivers
+# Controllers
 #
 # CONFIG_IEEE1394_PCILYNX is not set
 CONFIG_IEEE1394_OHCI1394=y
 
 #
-# Protocol Drivers
+# Protocols
 #
 CONFIG_IEEE1394_VIDEO1394=m
 CONFIG_IEEE1394_SBP2=m
+CONFIG_IEEE1394_ETH1394_ROM_ENTRY=y
 CONFIG_IEEE1394_ETH1394=m
 CONFIG_IEEE1394_DV1394=m
 CONFIG_IEEE1394_RAWIO=y
@@ -666,12 +677,10 @@ CONFIG_IEEE1394_RAWIO=y
 # I2O device support
 #
 # CONFIG_I2O is not set
-
-#
-# Macintosh device drivers
-#
+CONFIG_MACINTOSH_DRIVERS=y
 CONFIG_ADB_PMU=y
-# CONFIG_ADB_PMU_LED is not set
+CONFIG_ADB_PMU_LED=y
+CONFIG_ADB_PMU_LED_IDE=y
 CONFIG_PMAC_SMU=y
 CONFIG_MAC_EMUMOUSEBTN=y
 CONFIG_THERM_PM72=y
@@ -679,7 +688,7 @@ CONFIG_WINDFARM=y
 CONFIG_WINDFARM_PM81=y
 CONFIG_WINDFARM_PM91=y
 CONFIG_WINDFARM_PM112=y
-# CONFIG_PMAC_RACKMETER is not set
+CONFIG_PMAC_RACKMETER=y
 
 #
 # Network device support
@@ -689,15 +698,7 @@ CONFIG_DUMMY=m
 CONFIG_BONDING=m
 # CONFIG_EQUALIZER is not set
 CONFIG_TUN=m
-
-#
-# ARCnet devices
-#
 # CONFIG_ARCNET is not set
-
-#
-# PHY device support
-#
 # CONFIG_PHYLIB is not set
 
 #
@@ -716,10 +717,7 @@ CONFIG_SUNGEM=y
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
 # CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
+CONFIG_NETDEV_1000=y
 CONFIG_ACENIC=y
 CONFIG_ACENIC_OMIT_TIGON_I=y
 # CONFIG_DL2K is not set
@@ -734,35 +732,50 @@ CONFIG_E1000=y
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
 # CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
 CONFIG_TIGON3=y
 # CONFIG_BNX2 is not set
 # CONFIG_QLA3XXX is not set
-
-#
-# Ethernet (10000 Mbit)
-#
+# CONFIG_ATL1 is not set
+CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
 # CONFIG_NETXEN_NIC is not set
-
-#
-# Token Ring devices
-#
+# CONFIG_PASEMI_MAC is not set
+# CONFIG_MLX4_CORE is not set
 CONFIG_TR=y
 CONFIG_IBMOL=y
 # CONFIG_3C359 is not set
 # CONFIG_TMS380TR is not set
 
 #
-# Wireless LAN (non-hamradio)
+# Wireless LAN
 #
-# CONFIG_NET_RADIO is not set
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 
 #
-# Wan interfaces
+# USB Network Adapters
 #
+CONFIG_USB_CATC=m
+CONFIG_USB_KAWETH=m
+CONFIG_USB_PEGASUS=m
+CONFIG_USB_RTL8150=m
+# CONFIG_USB_USBNET_MII is not set
+CONFIG_USB_USBNET=m
+# CONFIG_USB_NET_AX8817X is not set
+CONFIG_USB_NET_CDCETHER=m
+# CONFIG_USB_NET_DM9601 is not set
+# CONFIG_USB_NET_GL620A is not set
+# CONFIG_USB_NET_NET1080 is not set
+# CONFIG_USB_NET_PLUSB is not set
+# CONFIG_USB_NET_MCS7830 is not set
+# CONFIG_USB_NET_RNDIS_HOST is not set
+# CONFIG_USB_NET_CDC_SUBSET is not set
+# CONFIG_USB_NET_ZAURUS is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -798,6 +811,7 @@ CONFIG_SLHC=m
 #
 CONFIG_INPUT=y
 CONFIG_INPUT_FF_MEMLESS=y
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -824,8 +838,10 @@ CONFIG_INPUT_KEYBOARD=y
 CONFIG_INPUT_MOUSE=y
 # CONFIG_MOUSE_PS2 is not set
 # CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_APPLETOUCH is not set
 # CONFIG_MOUSE_VSXXXAA is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -866,15 +882,10 @@ CONFIG_LEGACY_PTY_COUNT=256
 # IPMI
 #
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 # CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 CONFIG_AGP=m
@@ -888,11 +899,9 @@ CONFIG_MAX_RAW_DEVS=256
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
+CONFIG_DEVPORT=y
 CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_CHARDEV=y
 
 #
@@ -919,14 +928,15 @@ CONFIG_I2C_POWERMAC=y
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_I2C_SIMTEC is not set
 # CONFIG_I2C_SIS5595 is not set
 # CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
 # CONFIG_I2C_STUB is not set
+# CONFIG_I2C_TINY_USB is not set
 # CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
 # CONFIG_I2C_VOODOO3 is not set
-# CONFIG_I2C_PCA_ISA is not set
 
 #
 # Miscellaneous I2C Chip support
@@ -953,37 +963,53 @@ CONFIG_I2C_POWERMAC=y
 # Dallas's 1-wire bus
 #
 # CONFIG_W1 is not set
+# CONFIG_HWMON is not set
 
 #
-# Hardware Monitoring support
+# Multifunction device drivers
 #
-# CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+# CONFIG_MFD_SM501 is not set
 
 #
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=y
+# CONFIG_USB_DABUSB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Graphics support
 #
-# CONFIG_DVB is not set
-# CONFIG_USB_DABUSB is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_LCD_CLASS_DEVICE=m
 
 #
-# Graphics support
+# Display device support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_DISPLAY_SUPPORT is not set
+CONFIG_VGASTATE=y
 CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_DDC=y
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
+# CONFIG_FB_SVGALIB is not set
 CONFIG_FB_MACMODES=y
-# CONFIG_FB_BACKLIGHT is not set
+CONFIG_FB_BACKLIGHT=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
+
+#
+# Frame buffer hardware drivers
+#
 # CONFIG_FB_CIRRUS is not set
 # CONFIG_FB_PM2 is not set
 # CONFIG_FB_CYBER2000 is not set
@@ -994,20 +1020,27 @@ CONFIG_FB_OF=y
 # CONFIG_FB_S1D13XXX is not set
 CONFIG_FB_NVIDIA=y
 CONFIG_FB_NVIDIA_I2C=y
+# CONFIG_FB_NVIDIA_DEBUG is not set
+CONFIG_FB_NVIDIA_BACKLIGHT=y
 # CONFIG_FB_RIVA is not set
 # CONFIG_FB_MATROX is not set
 CONFIG_FB_RADEON=y
 CONFIG_FB_RADEON_I2C=y
+CONFIG_FB_RADEON_BACKLIGHT=y
 # CONFIG_FB_RADEON_DEBUG is not set
 # CONFIG_FB_ATY128 is not set
 # CONFIG_FB_ATY is not set
+# CONFIG_FB_S3 is not set
 # CONFIG_FB_SAVAGE is not set
 # CONFIG_FB_SIS is not set
 # CONFIG_FB_NEOMAGIC is not set
 # CONFIG_FB_KYRO is not set
 # CONFIG_FB_3DFX is not set
 # CONFIG_FB_VOODOO1 is not set
+# CONFIG_FB_VT8623 is not set
 # CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_ARK is not set
+# CONFIG_FB_PM3 is not set
 # CONFIG_FB_IBM_GXT4500 is not set
 # CONFIG_FB_VIRTUAL is not set
 
@@ -1021,19 +1054,10 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
-
-#
-# Logo configuration
-#
 CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
-CONFIG_BACKLIGHT_CLASS_DEVICE=m
-CONFIG_BACKLIGHT_DEVICE=y
-CONFIG_LCD_CLASS_DEVICE=m
-CONFIG_LCD_DEVICE=y
 
 #
 # Sound
@@ -1152,6 +1176,12 @@ CONFIG_SND_AOA_SOUNDBUS_I2S=m
 #
 CONFIG_SND_USB_AUDIO=m
 # CONFIG_SND_USB_USX2Y is not set
+# CONFIG_SND_USB_CAIAQ is not set
+
+#
+# System on Chip audio support
+#
+# CONFIG_SND_SOC is not set
 
 #
 # Open Sound System
@@ -1162,6 +1192,20 @@ CONFIG_SND_USB_AUDIO=m
 # HID Devices
 #
 CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+CONFIG_HID_FF=y
+CONFIG_HID_PID=y
+CONFIG_LOGITECH_FF=y
+# CONFIG_PANTHERLORD_FF is not set
+CONFIG_THRUSTMASTER_FF=y
+# CONFIG_ZEROPLUS_FF is not set
+CONFIG_USB_HIDDEV=y
 
 #
 # USB support
@@ -1176,9 +1220,8 @@ CONFIG_USB=y
 # Miscellaneous USB options
 #
 CONFIG_USB_DEVICEFS=y
-# CONFIG_USB_BANDWIDTH is not set
+CONFIG_USB_DEVICE_CLASS=y
 # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_MULTITHREAD_PROBE is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -1188,9 +1231,15 @@ CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_SPLIT_ISO is not set
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
+# CONFIG_USB_EHCI_BIG_ENDIAN_MMIO is not set
 # CONFIG_USB_ISP116X_HCD is not set
 CONFIG_USB_OHCI_HCD=y
-# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+CONFIG_USB_OHCI_HCD_PPC_OF=y
+CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
+# CONFIG_USB_OHCI_HCD_PPC_OF_LE is not set
+CONFIG_USB_OHCI_HCD_PCI=y
+CONFIG_USB_OHCI_BIG_ENDIAN_DESC=y
+CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_UHCI_HCD is not set
 # CONFIG_USB_SL811_HCD is not set
@@ -1224,53 +1273,10 @@ CONFIG_USB_STORAGE_JUMPSHOT=y
 # CONFIG_USB_LIBUSUAL is not set
 
 #
-# USB Input Devices
-#
-CONFIG_USB_HID=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
-CONFIG_HID_FF=y
-CONFIG_HID_PID=y
-CONFIG_LOGITECH_FF=y
-CONFIG_THRUSTMASTER_FF=y
-# CONFIG_ZEROPLUS_FF is not set
-CONFIG_USB_HIDDEV=y
-# CONFIG_USB_AIPTEK is not set
-# CONFIG_USB_WACOM is not set
-# CONFIG_USB_ACECAD is not set
-# CONFIG_USB_KBTAB is not set
-# CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_TOUCHSCREEN is not set
-# CONFIG_USB_YEALINK is not set
-# CONFIG_USB_XPAD is not set
-# CONFIG_USB_ATI_REMOTE is not set
-# CONFIG_USB_ATI_REMOTE2 is not set
-# CONFIG_USB_KEYSPAN_REMOTE is not set
-# CONFIG_USB_APPLETOUCH is not set
-
-#
 # USB Imaging devices
 #
 # CONFIG_USB_MDC800 is not set
 # CONFIG_USB_MICROTEK is not set
-
-#
-# USB Network Adapters
-#
-CONFIG_USB_CATC=m
-CONFIG_USB_KAWETH=m
-CONFIG_USB_PEGASUS=m
-CONFIG_USB_RTL8150=m
-# CONFIG_USB_USBNET_MII is not set
-CONFIG_USB_USBNET=m
-# CONFIG_USB_NET_AX8817X is not set
-CONFIG_USB_NET_CDCETHER=m
-# CONFIG_USB_NET_GL620A is not set
-# CONFIG_USB_NET_NET1080 is not set
-# CONFIG_USB_NET_PLUSB is not set
-# CONFIG_USB_NET_MCS7830 is not set
-# CONFIG_USB_NET_RNDIS_HOST is not set
-# CONFIG_USB_NET_CDC_SUBSET is not set
-# CONFIG_USB_NET_ZAURUS is not set
 CONFIG_USB_MON=y
 
 #
@@ -1343,6 +1349,7 @@ CONFIG_USB_EZUSB=y
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
@@ -1353,6 +1360,7 @@ CONFIG_USB_APPLEDISPLAY=m
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1363,16 +1371,13 @@ CONFIG_USB_APPLEDISPLAY=m
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
 # CONFIG_MMC is not set
 
 #
 # LED devices
 #
-# CONFIG_NEW_LEDS is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
 
 #
 # LED drivers
@@ -1381,6 +1386,10 @@ CONFIG_USB_APPLEDISPLAY=m
 #
 # LED Triggers
 #
+CONFIG_LEDS_TRIGGERS=y
+# CONFIG_LEDS_TRIGGER_TIMER is not set
+CONFIG_LEDS_TRIGGER_IDE_DISK=y
+# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
 
 #
 # InfiniBand support
@@ -1410,10 +1419,6 @@ CONFIG_USB_APPLEDISPLAY=m
 #
 
 #
-# Virtualization
-#
-
-#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -1461,7 +1466,6 @@ CONFIG_AUTOFS_FS=m
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_ZISOFS=y
-CONFIG_ZISOFS_FS=y
 CONFIG_UDF_FS=m
 CONFIG_UDF_NLS=y
 
@@ -1527,6 +1531,7 @@ CONFIG_NFS_ACL_SUPPORT=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 CONFIG_SUNRPC_GSS=y
+# CONFIG_SUNRPC_BIND34 is not set
 CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -1561,6 +1566,7 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_SUN_PARTITION is not set
 # CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
 
 #
 # Native Language Support
@@ -1610,6 +1616,7 @@ CONFIG_NLS_UTF8=y
 # Distributed Lock Manager
 #
 # CONFIG_DLM is not set
+# CONFIG_UCC_SLOW is not set
 
 #
 # Library routines
@@ -1617,12 +1624,15 @@ CONFIG_NLS_UTF8=y
 CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=m
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
 
 #
 # Instrumentation Support
@@ -1641,15 +1651,15 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
-CONFIG_LOG_BUF_SHIFT=17
+# CONFIG_DEBUG_SHIRQ is not set
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_RWSEMS is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1659,8 +1669,10 @@ CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_DEBUGGER is not set
 CONFIG_IRQSTACKS=y
 CONFIG_BOOTX_TEXT=y
@@ -1693,8 +1705,11 @@ CONFIG_CRYPTO_WP512=m
 # CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_CRYPTD is not set
 CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_TWOFISH_COMMON=m
@@ -1709,6 +1724,7 @@ CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
+# CONFIG_CRYPTO_CAMELLIA is not set
 CONFIG_CRYPTO_TEST=m
 
 #
