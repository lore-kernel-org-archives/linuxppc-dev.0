Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B4F18DDEA2
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 14:36:31 +1000 (EST)
Date: Mon, 14 May 2007 14:36:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Update iseries_defconfig
Message-Id: <20070514143628.a799e7db.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/configs/iseries_defconfig |  209 ++++++++++++++++++--------------
 1 files changed, 116 insertions(+), 93 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/configs/iseries_defconfig b/arch/powerpc/configs/iseries_defconfig
index 5fc8744..af25118 100644
--- a/arch/powerpc/configs/iseries_defconfig
+++ b/arch/powerpc/configs/iseries_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc5
-# Mon Jan 22 22:16:44 2007
+# Linux kernel version: 2.6.22-rc1
+# Mon May 14 14:27:46 2007
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -40,6 +40,7 @@ CONFIG_PPC_FPU=y
 # CONFIG_PPC_OF_PLATFORM_PCI is not set
 # CONFIG_ALTIVEC is not set
 CONFIG_PPC_STD_MMU=y
+# CONFIG_PPC_MM_SLICES is not set
 CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=32
@@ -60,6 +61,7 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -68,9 +70,11 @@ CONFIG_AUDIT=y
 CONFIG_AUDITSYSCALL=y
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
@@ -85,14 +89,19 @@ CONFIG_BUG=y
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
@@ -131,15 +140,30 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_EMBEDDED6xx is not set
 # CONFIG_APUS is not set
 # CONFIG_PPC_PSERIES is not set
+CONFIG_LPARCFG=y
 CONFIG_PPC_ISERIES=y
+
+#
+# iSeries device drivers
+#
+CONFIG_VIODASD=y
+CONFIG_VIOCD=m
+CONFIG_VIOTAPE=m
+CONFIG_VIOPATH=y
 # CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_MPC5200 is not set
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 # CONFIG_PPC_PASEMI is not set
+# CONFIG_PPC_CELLEB is not set
+# CONFIG_PPC_PS3 is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_IBM_CELL_BLADE is not set
-# CONFIG_PPC_PS3 is not set
+# CONFIG_PQ2ADS is not set
+# CONFIG_MPIC is not set
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
 # CONFIG_U3_DART is not set
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
@@ -149,8 +173,7 @@ CONFIG_IBMVIO=y
 CONFIG_PPC_INDIRECT_IO=y
 CONFIG_GENERIC_IOMAP=y
 # CONFIG_CPU_FREQ is not set
-# CONFIG_WANT_EARLY_SERIAL is not set
-# CONFIG_MPIC is not set
+# CONFIG_CPM2 is not set
 
 #
 # Kernel options
@@ -172,7 +195,6 @@ CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
 CONFIG_IRQ_ALL_CPUS=y
-CONFIG_LPARCFG=y
 # CONFIG_NUMA is not set
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
@@ -187,34 +209,34 @@ CONFIG_FLAT_NODE_MEM_MAP=y
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
 
@@ -226,14 +248,15 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=m
 CONFIG_XFRM_SUB_POLICY=y
+# CONFIG_XFRM_MIGRATE is not set
 CONFIG_NET_KEY=m
+# CONFIG_NET_KEY_MIGRATE is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
@@ -275,8 +298,6 @@ CONFIG_NETFILTER=y
 #
 # CONFIG_NETFILTER_NETLINK is not set
 CONFIG_NF_CONNTRACK_ENABLED=m
-CONFIG_NF_CONNTRACK_SUPPORT=y
-# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
 CONFIG_NF_CONNTRACK=m
 # CONFIG_NF_CT_ACCT is not set
 CONFIG_NF_CONNTRACK_MARK=y
@@ -288,6 +309,7 @@ CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_IRC=m
 # CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
 # CONFIG_NF_CONNTRACK_PPTP is not set
+# CONFIG_NF_CONNTRACK_SANE is not set
 # CONFIG_NF_CONNTRACK_SIP is not set
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NETFILTER_XTABLES=m
@@ -298,7 +320,9 @@ CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
 # CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
 # CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
+# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
 CONFIG_NETFILTER_XT_MATCH_COMMENT=m
+# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
 # CONFIG_NETFILTER_XT_MATCH_DCCP is not set
@@ -340,7 +364,6 @@ CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_LOG=m
 CONFIG_IP_NF_TARGET_ULOG=m
-CONFIG_IP_NF_TARGET_TCPMSS=m
 CONFIG_NF_NAT=m
 CONFIG_NF_NAT_NEEDED=y
 CONFIG_IP_NF_TARGET_MASQUERADE=m
@@ -373,7 +396,12 @@ CONFIG_IP_NF_ARP_MANGLE=m
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-# CONFIG_IP_SCTP is not set
+CONFIG_IP_SCTP=m
+# CONFIG_SCTP_DBG_MSG is not set
+# CONFIG_SCTP_DBG_OBJCNT is not set
+# CONFIG_SCTP_HMAC_NONE is not set
+# CONFIG_SCTP_HMAC_SHA1 is not set
+CONFIG_SCTP_HMAC_MD5=y
 
 #
 # TIPC Configuration (EXPERIMENTAL)
@@ -405,7 +433,16 @@ CONFIG_NET_CLS_ROUTE=y
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
@@ -418,16 +455,13 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
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
@@ -438,6 +472,7 @@ CONFIG_FW_LOADER=m
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -456,15 +491,16 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
 #
 # Misc devices
 #
+# CONFIG_PHANTOM is not set
 # CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
+# CONFIG_BLINK is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -498,6 +534,7 @@ CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -544,11 +581,8 @@ CONFIG_SCSI_IBMVSCSI=m
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_ESP_CORE is not set
 # CONFIG_SCSI_SRP is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
 # CONFIG_ATA is not set
 
 #
@@ -570,6 +604,7 @@ CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 # CONFIG_DM_MULTIPATH is not set
+# CONFIG_DM_DELAY is not set
 
 #
 # Fusion MPT device support
@@ -582,18 +617,14 @@ CONFIG_DM_ZERO=m
 #
 # IEEE 1394 (FireWire) support
 #
+# CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 
 #
 # I2O device support
 #
 # CONFIG_I2O is not set
-
-#
-# Macintosh device drivers
-#
-# CONFIG_MAC_EMUMOUSEBTN is not set
-# CONFIG_WINDFARM is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
 
 #
 # Network device support
@@ -608,10 +639,6 @@ CONFIG_TUN=m
 # ARCnet devices
 #
 # CONFIG_ARCNET is not set
-
-#
-# PHY device support
-#
 # CONFIG_PHYLIB is not set
 
 #
@@ -648,10 +675,8 @@ CONFIG_E100=y
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
 # CONFIG_VIA_RHINE is not set
-
-#
-# Ethernet (1000 Mbit)
-#
+# CONFIG_SC92031 is not set
+CONFIG_NETDEV_1000=y
 CONFIG_ACENIC=m
 # CONFIG_ACENIC_OMIT_TIGON_I is not set
 # CONFIG_DL2K is not set
@@ -670,15 +695,17 @@ CONFIG_E1000=m
 # CONFIG_TIGON3 is not set
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
+# CONFIG_PASEMI_MAC is not set
+# CONFIG_MLX4_CORE is not set
+CONFIG_MLX4_DEBUG=y
 
 #
 # Token Ring devices
@@ -689,13 +716,10 @@ CONFIG_IBMOL=y
 # CONFIG_TMS380TR is not set
 
 #
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# Wan interfaces
+# Wireless LAN
 #
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 # CONFIG_WAN is not set
 CONFIG_ISERIES_VETH=y
 # CONFIG_FDDI is not set
@@ -715,7 +739,6 @@ CONFIG_SLHC=m
 # CONFIG_SHAPER is not set
 CONFIG_NETCONSOLE=y
 CONFIG_NETPOLL=y
-CONFIG_NETPOLL_RX=y
 CONFIG_NETPOLL_TRAP=y
 CONFIG_NET_POLL_CONTROLLER=y
 
@@ -753,6 +776,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -765,6 +789,10 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 #
 # Character devices
 #
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -781,20 +809,17 @@ CONFIG_SERIAL_ICOM=m
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
+CONFIG_HVC_DRIVER=y
+CONFIG_HVC_ISERIES=y
 
 #
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
 # CONFIG_AGP is not set
@@ -807,10 +832,7 @@ CONFIG_MAX_RAW_DEVS=256
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
+CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
 
 #
@@ -823,30 +845,39 @@ CONFIG_MAX_RAW_DEVS=256
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
+# CONFIG_DAB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Graphics support
 #
-# CONFIG_DVB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Graphics support
+# Display device support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Console display driver support
+#
+CONFIG_VGA_CONSOLE=y
+# CONFIG_VGACON_SOFT_SCROLLBACK is not set
+CONFIG_DUMMY_CONSOLE=y
 
 #
 # Sound
@@ -874,10 +905,6 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
 # CONFIG_MMC is not set
 
 #
@@ -921,10 +948,6 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 
 #
-# Virtualization
-#
-
-#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -979,7 +1002,6 @@ CONFIG_GENERIC_ACL=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_ZISOFS=y
-CONFIG_ZISOFS_FS=y
 CONFIG_UDF_FS=m
 CONFIG_UDF_NLS=y
 
@@ -1045,6 +1067,7 @@ CONFIG_NFS_ACL_SUPPORT=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 CONFIG_SUNRPC_GSS=y
+# CONFIG_SUNRPC_BIND34 is not set
 CONFIG_RPCSEC_GSS_KRB5=y
 CONFIG_RPCSEC_GSS_SPKM3=m
 # CONFIG_SMB_FS is not set
@@ -1114,18 +1137,9 @@ CONFIG_NLS_ISO8859_1=y
 # Distributed Lock Manager
 #
 CONFIG_DLM=m
-CONFIG_DLM_TCP=y
-# CONFIG_DLM_SCTP is not set
 # CONFIG_DLM_DEBUG is not set
-
-#
-# iSeries device drivers
-#
-CONFIG_VIOCONS=y
-CONFIG_VIODASD=y
-CONFIG_VIOCD=m
-CONFIG_VIOTAPE=m
-CONFIG_VIOPATH=y
+# CONFIG_UCC_SLOW is not set
+# CONFIG_UCC_FAST is not set
 
 #
 # Library routines
@@ -1133,6 +1147,7 @@ CONFIG_VIOPATH=y
 CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=m
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
@@ -1142,7 +1157,9 @@ CONFIG_TEXTSEARCH_KMP=m
 CONFIG_TEXTSEARCH_BM=m
 CONFIG_TEXTSEARCH_FSM=m
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
 
 #
 # Instrumentation Support
@@ -1160,15 +1177,15 @@ CONFIG_MAGIC_SYSRQ=y
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
 # CONFIG_DEBUG_MUTEXES is not set
-# CONFIG_DEBUG_RWSEMS is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1178,8 +1195,10 @@ CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_FORCED_INLINING is not set
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DEBUG_STACK_USAGE=y
+# CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_DEBUGGER is not set
 CONFIG_IRQSTACKS=y
 # CONFIG_BOOTX_TEXT is not set
@@ -1212,8 +1231,11 @@ CONFIG_CRYPTO_TGR192=m
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
@@ -1228,6 +1250,7 @@ CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
+# CONFIG_CRYPTO_CAMELLIA is not set
 CONFIG_CRYPTO_TEST=m
 
 #
-- 
1.5.1.4
