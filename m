Return-Path: <arnd@arndb.de>
Message-Id: <20061219143451.375476000@arndb.de>
References: <20061219143240.705255000@arndb.de>
Date: Tue, 19 Dec 2006 15:32:41 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 1/6] cell: update cell_defconfig
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

New options appeared in the kernel, and new hardware became
available for us to use.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/configs/cell_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/cell_defconfig
+++ linux-2.6/arch/powerpc/configs/cell_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.19-rc6
-# Wed Nov 22 15:33:04 2006
+# Linux kernel version: 2.6.20-rc1
+# Tue Dec 19 14:59:53 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -10,6 +10,8 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_ARCH_HAS_ILOG2_U64=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -23,6 +25,7 @@ CONFIG_PPC_OF=y
 CONFIG_PPC_UDBG_16550=y
 # CONFIG_GENERIC_TBSYNC is not set
 CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
 # CONFIG_DEFAULT_UIMAGE is not set
 
 #
@@ -66,6 +69,7 @@ CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CPUSETS=y
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
@@ -128,14 +132,16 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_APUS is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_ISERIES is not set
+# CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 # CONFIG_PPC_PASEMI is not set
 CONFIG_PPC_CELL=y
 CONFIG_PPC_CELL_NATIVE=y
 CONFIG_PPC_IBM_CELL_BLADE=y
-CONFIG_UDBG_RTAS_CONSOLE=y
 CONFIG_PPC_PS3=y
+CONFIG_PPC_NATIVE=y
+CONFIG_UDBG_RTAS_CONSOLE=y
 # CONFIG_U3_DART is not set
 CONFIG_PPC_RTAS=y
 # CONFIG_RTAS_ERROR_LOGGING is not set
@@ -177,12 +183,14 @@ CONFIG_CBE_CPUFREQ=m
 CONFIG_PS3_HTAB_SIZE=20
 # CONFIG_PS3_DYNAMIC_DMA is not set
 CONFIG_PS3_USE_LPAR_ADDR=y
+CONFIG_PS3_VUART=y
 
 #
 # Kernel options
 #
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -237,6 +245,7 @@ CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCIEPORTBUS=y
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -270,7 +279,10 @@ CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_FIB_HASH=y
-# CONFIG_IP_PNP is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
 CONFIG_NET_IPIP=y
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
@@ -289,6 +301,7 @@ CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 
 #
 # IP: Virtual Server Configuration
@@ -317,31 +330,67 @@ CONFIG_NETFILTER=y
 #
 # Core Netfilter Configuration
 #
-# CONFIG_NETFILTER_NETLINK is not set
-# CONFIG_NETFILTER_XTABLES is not set
+CONFIG_NETFILTER_NETLINK=m
+CONFIG_NETFILTER_NETLINK_QUEUE=m
+CONFIG_NETFILTER_NETLINK_LOG=m
+# CONFIG_NF_CONNTRACK_ENABLED is not set
+CONFIG_NETFILTER_XTABLES=m
+CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
+CONFIG_NETFILTER_XT_TARGET_DSCP=m
+CONFIG_NETFILTER_XT_TARGET_MARK=m
+CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
+CONFIG_NETFILTER_XT_TARGET_NFLOG=m
+CONFIG_NETFILTER_XT_MATCH_COMMENT=m
+CONFIG_NETFILTER_XT_MATCH_DCCP=m
+CONFIG_NETFILTER_XT_MATCH_DSCP=m
+CONFIG_NETFILTER_XT_MATCH_ESP=m
+CONFIG_NETFILTER_XT_MATCH_LENGTH=m
+CONFIG_NETFILTER_XT_MATCH_LIMIT=m
+CONFIG_NETFILTER_XT_MATCH_MAC=m
+CONFIG_NETFILTER_XT_MATCH_MARK=m
+CONFIG_NETFILTER_XT_MATCH_POLICY=m
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
+CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
+CONFIG_NETFILTER_XT_MATCH_QUOTA=m
+CONFIG_NETFILTER_XT_MATCH_REALM=m
+CONFIG_NETFILTER_XT_MATCH_SCTP=m
+CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
+CONFIG_NETFILTER_XT_MATCH_STRING=m
+CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
 
 #
 # IP: Netfilter Configuration
 #
-CONFIG_IP_NF_CONNTRACK=y
-# CONFIG_IP_NF_CT_ACCT is not set
-# CONFIG_IP_NF_CONNTRACK_MARK is not set
-# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
-CONFIG_IP_NF_CT_PROTO_SCTP=y
-CONFIG_IP_NF_FTP=m
-CONFIG_IP_NF_IRC=m
-# CONFIG_IP_NF_NETBIOS_NS is not set
-CONFIG_IP_NF_TFTP=m
-CONFIG_IP_NF_AMANDA=m
-# CONFIG_IP_NF_PPTP is not set
-# CONFIG_IP_NF_H323 is not set
-# CONFIG_IP_NF_SIP is not set
 CONFIG_IP_NF_QUEUE=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_MATCH_IPRANGE=m
+CONFIG_IP_NF_MATCH_TOS=m
+CONFIG_IP_NF_MATCH_RECENT=m
+CONFIG_IP_NF_MATCH_ECN=m
+CONFIG_IP_NF_MATCH_AH=m
+CONFIG_IP_NF_MATCH_TTL=m
+CONFIG_IP_NF_MATCH_OWNER=m
+CONFIG_IP_NF_MATCH_ADDRTYPE=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_TARGET_LOG=m
+CONFIG_IP_NF_TARGET_ULOG=m
+CONFIG_IP_NF_TARGET_TCPMSS=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_IP_NF_TARGET_TOS=m
+CONFIG_IP_NF_TARGET_ECN=m
+CONFIG_IP_NF_TARGET_TTL=m
+CONFIG_IP_NF_RAW=m
+CONFIG_IP_NF_ARPTABLES=m
+CONFIG_IP_NF_ARPFILTER=m
+CONFIG_IP_NF_ARP_MANGLE=m
 
 #
 # IPv6: Netfilter Configuration (EXPERIMENTAL)
 #
 # CONFIG_IP6_NF_QUEUE is not set
+# CONFIG_IP6_NF_IPTABLES is not set
 
 #
 # DCCP Configuration (EXPERIMENTAL)
@@ -373,6 +422,7 @@ CONFIG_IP_NF_QUEUE=m
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+CONFIG_NET_CLS_ROUTE=y
 
 #
 # Network testing
@@ -428,6 +478,7 @@ CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=131072
@@ -457,6 +508,7 @@ CONFIG_IDEDISK_MULTI_MODE=y
 # CONFIG_BLK_DEV_IDECD is not set
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_BLK_DEV_IDESCSI is not set
 # CONFIG_IDE_TASK_IOCTL is not set
 
 #
@@ -468,7 +520,6 @@ CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
-# CONFIG_BLK_DEV_SL82C105 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
@@ -492,6 +543,7 @@ CONFIG_BLK_DEV_AEC62XX=y
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_SVWKS is not set
 CONFIG_BLK_DEV_SIIMAGE=y
+# CONFIG_BLK_DEV_SL82C105 is not set
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
@@ -505,8 +557,74 @@ CONFIG_IDEDMA_AUTO=y
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
-# CONFIG_SCSI is not set
+CONFIG_SCSI=m
+# CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=m
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=m
+# CONFIG_BLK_DEV_SR_VENDOR is not set
+CONFIG_CHR_DEV_SG=m
+# CONFIG_CHR_DEV_SCH is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_ISCSI_TCP is not set
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_ARCMSR is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_HPTIOP is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
 
 #
 # Serial ATA (prod) and Parallel ATA (experimental) drivers
@@ -538,6 +656,9 @@ CONFIG_DM_MULTIPATH=m
 # Fusion MPT device support
 #
 # CONFIG_FUSION is not set
+# CONFIG_FUSION_SPI is not set
+# CONFIG_FUSION_FC is not set
+# CONFIG_FUSION_SAS is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -552,6 +673,7 @@ CONFIG_DM_MULTIPATH=m
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -559,7 +681,7 @@ CONFIG_DM_MULTIPATH=m
 #
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
-CONFIG_BONDING=y
+CONFIG_BONDING=m
 # CONFIG_EQUALIZER is not set
 CONFIG_TUN=y
 
@@ -604,11 +726,11 @@ CONFIG_E1000_NAPI=y
 # CONFIG_R8169 is not set
 # CONFIG_SIS190 is not set
 CONFIG_SKGE=m
-# CONFIG_SKY2 is not set
+CONFIG_SKY2=m
 # CONFIG_SK98LIN is not set
-# CONFIG_TIGON3 is not set
+CONFIG_TIGON3=y
 # CONFIG_BNX2 is not set
-CONFIG_SPIDER_NET=m
+CONFIG_SPIDER_NET=y
 # CONFIG_QLA3XXX is not set
 
 #
@@ -618,6 +740,7 @@ CONFIG_SPIDER_NET=m
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -637,6 +760,7 @@ CONFIG_SPIDER_NET=m
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
@@ -703,6 +827,7 @@ CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_DIGIEPCA is not set
 # CONFIG_MOXA_INTELLIO is not set
 # CONFIG_MOXA_SMARTIO is not set
+# CONFIG_MOXA_SMARTIO_NEW is not set
 # CONFIG_ISI is not set
 # CONFIG_SYNCLINK is not set
 # CONFIG_SYNCLINKMP is not set
@@ -729,6 +854,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_HVC_DRIVER=y
@@ -756,16 +882,17 @@ CONFIG_WATCHDOG_RTAS=y
 #
 # CONFIG_PCIPCWATCHDOG is not set
 # CONFIG_WDTPCI is not set
+
+#
+# USB-based Watchdog Cards
+#
+# CONFIG_USBPCWATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -855,12 +982,14 @@ CONFIG_I2C_ALGOBIT=y
 # Digital Video Broadcasting Devices
 #
 # CONFIG_DVB is not set
+# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
 #
 CONFIG_FIRMWARE_EDID=y
 # CONFIG_FB is not set
+# CONFIG_FB_IBM_GXT4500 is not set
 
 #
 # Console display driver support
@@ -875,18 +1004,145 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+CONFIG_HID=m
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
+CONFIG_USB=m
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_MULTITHREAD_PROBE is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=m
+# CONFIG_USB_EHCI_SPLIT_ISO is not set
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=m
+# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
+# may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=m
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Input Devices
+#
+# CONFIG_USB_HID is not set
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_ACECAD is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_TOUCHSCREEN is not set
+# CONFIG_USB_YEALINK is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+# CONFIG_USB_ATI_REMOTE2 is not set
+# CONFIG_USB_KEYSPAN_REMOTE is not set
+# CONFIG_USB_APPLETOUCH is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
+# CONFIG_USB_USBNET is not set
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_TEST is not set
+
+#
+# USB DSL modem support
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -912,7 +1168,7 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 # InfiniBand support
 #
-CONFIG_INFINIBAND=y
+CONFIG_INFINIBAND=m
 CONFIG_INFINIBAND_USER_MAD=m
 CONFIG_INFINIBAND_USER_ACCESS=m
 CONFIG_INFINIBAND_ADDR_TRANS=y
@@ -922,6 +1178,8 @@ CONFIG_INFINIBAND_MTHCA_DEBUG=y
 CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_IPOIB_DEBUG=y
 CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=y
+# CONFIG_INFINIBAND_SRP is not set
+# CONFIG_INFINIBAND_ISER is not set
 
 #
 # EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
@@ -946,6 +1204,10 @@ CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=y
 #
 
 #
+# Virtualization
+#
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -1028,23 +1290,18 @@ CONFIG_RAMFS=y
 #
 # Network File Systems
 #
-CONFIG_NFS_FS=m
+CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 # CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=m
-CONFIG_NFSD_V2_ACL=y
-CONFIG_NFSD_V3=y
-CONFIG_NFSD_V3_ACL=y
-# CONFIG_NFSD_V4 is not set
-CONFIG_NFSD_TCP=y
-CONFIG_LOCKD=m
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-CONFIG_EXPORTFS=m
-CONFIG_NFS_ACL_SUPPORT=m
+CONFIG_NFS_ACL_SUPPORT=y
 CONFIG_NFS_COMMON=y
-CONFIG_SUNRPC=m
+CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -1120,8 +1377,14 @@ CONFIG_NLS_ISO8859_15=m
 # CONFIG_NLS_UTF8 is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -1130,7 +1393,10 @@ CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
 CONFIG_TEXTSEARCH=y
 CONFIG_TEXTSEARCH_KMP=m
+CONFIG_TEXTSEARCH_BM=m
+CONFIG_TEXTSEARCH_FSM=m
 CONFIG_PLIST=y
+CONFIG_IOMAP_COPY=y
 
 #
 # Instrumentation Support
@@ -1146,6 +1412,8 @@ CONFIG_OPROFILE=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=15
 CONFIG_DETECT_SOFTLOCKUP=y
@@ -1159,12 +1427,11 @@ CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
-CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_FORCED_INLINING is not set
-# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
@@ -1191,6 +1458,7 @@ CONFIG_CRYPTO_BLKCIPHER=m
 CONFIG_CRYPTO_HASH=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_HMAC=y
+# CONFIG_CRYPTO_XCBC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=m
@@ -1199,8 +1467,10 @@ CONFIG_CRYPTO_SHA1=m
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=m
+# CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=m
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set

--
