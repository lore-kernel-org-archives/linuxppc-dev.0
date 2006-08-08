Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1C2B67B5F
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 00:40:07 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k78Ee4Ph027616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2006 10:40:04 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k78Ee3uD232272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2006 10:40:03 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k78Ee3EF011189
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2006 10:40:03 -0400
Subject: Re: [PATCH] update {g5,iseries,pseries}_defconfigs
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <44D84145.7020408@sipsolutions.net>
References: <1154718328.5748.13.camel@farscape.rchland.ibm.com>
	<17624.10083.56514.758904@cargo.ozlabs.ibm.com>
	<44D84145.7020408@sipsolutions.net>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 09:40:00 -0500
Message-Id: <1155048001.5454.27.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-08-08 at 09:46 +0200, Johannes Berg wrote:
> Paul Mackerras wrote:
> >> +# CONFIG_SND_AOA is not set
> >> +# CONFIG_SND_AOA_SOUNDBUS is not set
> >>     
> >
> > We want these on for G5s.
> >   
> 
> newer PowerBooks/iBooks as well, and we'll want the new options these 
> open up, i.e. all the codecs.
> 
> Apologies for not updating the defconfigs myself, I just didn't think of 
> it :/
> 
> johannes

Ok, here is the second pass, incorporating the config suggestions made
by Paul and Johannes.    
Updating the defconfigs for iseries, pseries, and G5.   Sticking with
the defaults, with the following exceptions:  I've turned off HW_RANDOM
for all three configs.   For G5, I've enabled SND_AOA and friends as
modules; this includes the FABRIC_LAYOUT, ONYX, TAS, TOONIE and
SOUNDBUS* config options.  

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>

diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index a456275..8c6bd17 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -1,16 +1,18 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.17-rc1
-# Wed Apr 19 13:24:37 2006
+# Linux kernel version: 2.6.18-rc3
+# Tue Aug  8 09:12:29 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_COMPAT=y
@@ -33,6 +35,7 @@ CONFIG_PPC_STD_MMU=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
 # Code maturity level options
@@ -50,6 +53,7 @@ CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
@@ -67,10 +71,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
+CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -116,12 +122,16 @@ CONFIG_PPC_PMAC=y
 CONFIG_PPC_PMAC64=y
 # CONFIG_PPC_MAPLE is not set
 # CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PPC_IBM_CELL_BLADE is not set
+# CONFIG_UDBG_RTAS_CONSOLE is not set
 CONFIG_U3_DART=y
 CONFIG_MPIC=y
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
 CONFIG_MPIC_BROKEN_U3=y
 # CONFIG_PPC_MPC106 is not set
+CONFIG_PPC_970_NAP=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_TABLE=y
 # CONFIG_CPU_FREQ_DEBUG is not set
@@ -153,6 +163,7 @@ # CONFIG_BINFMT_MISC is not set
 CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_IOMMU_VMERGE=y
 # CONFIG_HOTPLUG_CPU is not set
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
 CONFIG_IRQ_ALL_CPUS=y
@@ -168,6 +179,7 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_RESOURCES_64BIT=y
 # CONFIG_PPC_64K_PAGES is not set
 # CONFIG_SCHED_SMT is not set
 CONFIG_PROC_DEVICETREE=y
@@ -184,6 +196,7 @@ # CONFIG_PPC_I8259 is not set
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
+# CONFIG_PCIEPORTBUS is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -227,6 +240,8 @@ CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_XFRM_TUNNEL=m
 CONFIG_INET_TUNNEL=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -239,6 +254,7 @@ # CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
 
@@ -263,6 +279,7 @@ CONFIG_IP_NF_TFTP=m
 CONFIG_IP_NF_AMANDA=m
 # CONFIG_IP_NF_PPTP is not set
 # CONFIG_IP_NF_H323 is not set
+# CONFIG_IP_NF_SIP is not set
 CONFIG_IP_NF_QUEUE=m
 
 #
@@ -318,6 +335,7 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_SYS_HYPERVISOR is not set
 
 #
 # Connector - unified userspace <-> kernelspace linker
@@ -355,6 +373,7 @@ # CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=65536
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_CDROM_PKTCDVD_BUFFERS=8
@@ -417,7 +436,6 @@ # CONFIG_BLK_DEV_VIA82CXXX is not set
 CONFIG_BLK_DEV_IDE_PMAC=y
 CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST=y
 CONFIG_BLK_DEV_IDEDMA_PMAC=y
-# CONFIG_BLK_DEV_IDE_PMAC_BLINK is not set
 # CONFIG_IDE_ARM is not set
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
@@ -478,6 +496,7 @@ # CONFIG_SCSI_ATA_PIIX is not set
 # CONFIG_SCSI_SATA_MV is not set
 # CONFIG_SCSI_SATA_NV is not set
 # CONFIG_SCSI_PDC_ADMA is not set
+# CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_SATA_QSTOR is not set
 # CONFIG_SCSI_SATA_PROMISE is not set
 # CONFIG_SCSI_SATA_SX4 is not set
@@ -497,7 +516,6 @@ # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_IPR is not set
-# CONFIG_SCSI_QLOGIC_FC is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 # CONFIG_SCSI_QLA_FC is not set
 # CONFIG_SCSI_LPFC is not set
@@ -514,9 +532,7 @@ CONFIG_MD_LINEAR=y
 CONFIG_MD_RAID0=y
 CONFIG_MD_RAID1=y
 CONFIG_MD_RAID10=m
-CONFIG_MD_RAID5=y
-# CONFIG_MD_RAID5_RESHAPE is not set
-CONFIG_MD_RAID6=m
+# CONFIG_MD_RAID456 is not set
 CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
 CONFIG_BLK_DEV_DM=y
@@ -559,7 +575,6 @@ # Protocol Drivers
 #
 CONFIG_IEEE1394_VIDEO1394=m
 CONFIG_IEEE1394_SBP2=m
-# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
 CONFIG_IEEE1394_ETH1394=m
 CONFIG_IEEE1394_DV1394=m
 CONFIG_IEEE1394_RAWIO=y
@@ -573,6 +588,7 @@ #
 # Macintosh device drivers
 #
 CONFIG_ADB_PMU=y
+# CONFIG_ADB_PMU_LED is not set
 CONFIG_PMAC_SMU=y
 CONFIG_THERM_PM72=y
 CONFIG_WINDFARM=y
@@ -643,6 +659,7 @@ #
 # CONFIG_CHELSIO_T1 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
+# CONFIG_MYRI10GE is not set
 
 #
 # Token Ring devices
@@ -739,6 +756,7 @@ #
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -754,6 +772,7 @@ # CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_BRIQ_PANEL is not set
 
 #
 # IPMI
@@ -764,6 +783,7 @@ #
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
+# CONFIG_HW_RANDOM is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_DTLK is not set
@@ -774,6 +794,7 @@ #
 # Ftape, the floppy tape device driver
 #
 CONFIG_AGP=m
+# CONFIG_AGP_SIS is not set
 # CONFIG_AGP_VIA is not set
 CONFIG_AGP_UNINORTH=m
 # CONFIG_DRM is not set
@@ -813,6 +834,7 @@ # CONFIG_I2C_I810 is not set
 # CONFIG_I2C_PIIX4 is not set
 CONFIG_I2C_POWERMAC=y
 # CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
@@ -849,7 +871,6 @@ # CONFIG_SPI_MASTER is not set
 #
 # Dallas's 1-wire bus
 #
-# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -865,6 +886,7 @@ #
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
+CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -875,22 +897,19 @@ # CONFIG_USB_DABUSB is not set
 #
 # Graphics support
 #
+CONFIG_FIRMWARE_EDID=y
 CONFIG_FB=y
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
 CONFIG_FB_MACMODES=y
-CONFIG_FB_FIRMWARE_EDID=y
+# CONFIG_FB_BACKLIGHT is not set
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
 # CONFIG_FB_CIRRUS is not set
 # CONFIG_FB_PM2 is not set
 # CONFIG_FB_CYBER2000 is not set
 CONFIG_FB_OF=y
-# CONFIG_FB_CONTROL is not set
-# CONFIG_FB_PLATINUM is not set
-# CONFIG_FB_VALKYRIE is not set
-# CONFIG_FB_CT65550 is not set
 # CONFIG_FB_ASILIANT is not set
 # CONFIG_FB_IMSTT is not set
 # CONFIG_FB_VGA16 is not set
@@ -990,6 +1009,18 @@ # CONFIG_SND_CA0106 is not set
 # CONFIG_SND_CMIPCI is not set
 # CONFIG_SND_CS4281 is not set
 # CONFIG_SND_CS46XX is not set
+# CONFIG_SND_DARLA20 is not set
+# CONFIG_SND_GINA20 is not set
+# CONFIG_SND_LAYLA20 is not set
+# CONFIG_SND_DARLA24 is not set
+# CONFIG_SND_GINA24 is not set
+# CONFIG_SND_LAYLA24 is not set
+# CONFIG_SND_MONA is not set
+# CONFIG_SND_MIA is not set
+# CONFIG_SND_ECHO3G is not set
+# CONFIG_SND_INDIGO is not set
+# CONFIG_SND_INDIGOIO is not set
+# CONFIG_SND_INDIGODJ is not set
 # CONFIG_SND_EMU10K1 is not set
 # CONFIG_SND_EMU10K1X is not set
 # CONFIG_SND_ENS1370 is not set
@@ -1027,6 +1058,17 @@ CONFIG_SND_POWERMAC=m
 CONFIG_SND_POWERMAC_AUTO_DRC=y
 
 #
+# Apple Onboard Audio driver
+#
+CONFIG_SND_AOA=m
+CONFIG_SND_AOA_FABRIC_LAYOUT=m
+CONFIG_SND_AOA_ONYX=m
+CONFIG_SND_AOA_TAS=m
+CONFIG_SND_AOA_TOONIE=m
+CONFIG_SND_AOA_SOUNDBUS=m
+CONFIG_SND_AOA_SOUNDBUS_I2S=m
+
+#
 # USB devices
 #
 CONFIG_SND_USB_AUDIO=m
@@ -1060,6 +1102,7 @@ #
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_SPLIT_ISO is not set
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
 # CONFIG_USB_ISP116X_HCD is not set
 CONFIG_USB_OHCI_HCD=y
 # CONFIG_USB_OHCI_BIG_ENDIAN is not set
@@ -1110,9 +1153,7 @@ # CONFIG_USB_WACOM is not set
 # CONFIG_USB_ACECAD is not set
 # CONFIG_USB_KBTAB is not set
 # CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_MTOUCH is not set
-# CONFIG_USB_ITMTOUCH is not set
-# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_TOUCHSCREEN is not set
 # CONFIG_USB_YEALINK is not set
 # CONFIG_USB_XPAD is not set
 # CONFIG_USB_ATI_REMOTE is not set
@@ -1155,6 +1196,7 @@ CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 # CONFIG_USB_SERIAL_AIRPRIME is not set
 # CONFIG_USB_SERIAL_ANYDATA is not set
+# CONFIG_USB_SERIAL_ARK3116 is not set
 CONFIG_USB_SERIAL_BELKIN=m
 # CONFIG_USB_SERIAL_WHITEHEAT is not set
 CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
@@ -1162,6 +1204,7 @@ # CONFIG_USB_SERIAL_CP2101 is not set
 CONFIG_USB_SERIAL_CYPRESS_M8=m
 CONFIG_USB_SERIAL_EMPEG=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
+# CONFIG_USB_SERIAL_FUNSOFT is not set
 CONFIG_USB_SERIAL_VISOR=m
 CONFIG_USB_SERIAL_IPAQ=m
 CONFIG_USB_SERIAL_IR=m
@@ -1191,9 +1234,11 @@ CONFIG_USB_SERIAL_PL2303=m
 # CONFIG_USB_SERIAL_HP4X is not set
 CONFIG_USB_SERIAL_SAFE=m
 CONFIG_USB_SERIAL_SAFE_PADDED=y
+# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
 CONFIG_USB_SERIAL_TI=m
 CONFIG_USB_SERIAL_CYBERJACK=m
 CONFIG_USB_SERIAL_XIRCOM=m
+# CONFIG_USB_SERIAL_OPTION is not set
 CONFIG_USB_SERIAL_OMNINET=m
 CONFIG_USB_EZUSB=y
 
@@ -1207,10 +1252,12 @@ # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
 # CONFIG_USB_PHIDGETKIT is not set
 # CONFIG_USB_PHIDGETSERVO is not set
 # CONFIG_USB_IDMOUSE is not set
+CONFIG_USB_APPLEDISPLAY=m
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TEST is not set
@@ -1235,6 +1282,14 @@ #
 # CONFIG_NEW_LEDS is not set
 
 #
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
 # InfiniBand support
 #
 # CONFIG_INFINIBAND is not set
@@ -1249,6 +1304,19 @@ #
 # CONFIG_RTC_CLASS is not set
 
 #
+# DMA Engine support
+#
+# CONFIG_DMA_ENGINE is not set
+
+#
+# DMA Clients
+#
+
+#
+# DMA Devices
+#
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -1273,7 +1341,6 @@ CONFIG_REISERFS_FS_SECURITY=y
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
 CONFIG_XFS_FS=m
-CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_QUOTA is not set
 CONFIG_XFS_SECURITY=y
 CONFIG_XFS_POSIX_ACL=y
@@ -1282,6 +1349,7 @@ # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
@@ -1363,7 +1431,9 @@ # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS is not set
+# CONFIG_CIFS_WEAK_PW_HASH is not set
 # CONFIG_CIFS_XATTR is not set
+# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_CIFS_EXPERIMENTAL is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1444,6 +1514,9 @@ CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
+CONFIG_TEXTSEARCH=y
+CONFIG_TEXTSEARCH_KMP=m
+CONFIG_PLIST=y
 
 #
 # Instrumentation Support
@@ -1457,14 +1530,19 @@ # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=17
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
-CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_RWSEMS is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
@@ -1476,11 +1554,7 @@ # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUGGER is not set
 CONFIG_IRQSTACKS=y
 CONFIG_BOOTX_TEXT=y
-# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
-# CONFIG_PPC_EARLY_DEBUG_G5 is not set
-# CONFIG_PPC_EARLY_DEBUG_RTAS is not set
-# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
-# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
 
 #
 # Security options
diff --git a/arch/powerpc/configs/iseries_defconfig b/arch/powerpc/configs/iseries_defconfig
index a95e455..72ed95b 100644
--- a/arch/powerpc/configs/iseries_defconfig
+++ b/arch/powerpc/configs/iseries_defconfig
@@ -1,16 +1,18 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.17-rc1
-# Wed Apr 19 11:46:44 2006
+# Linux kernel version: 2.6.18-rc3
+# Tue Aug  8 09:15:46 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_COMPAT=y
@@ -34,6 +36,7 @@ CONFIG_PPC_STD_MMU=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=32
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
 # Code maturity level options
@@ -51,6 +54,7 @@ CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 CONFIG_AUDITSYSCALL=y
@@ -69,10 +73,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
+CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -113,10 +119,14 @@ # CONFIG_PPC_MULTIPLATFORM is not set
 CONFIG_PPC_ISERIES=y
 # CONFIG_EMBEDDED6xx is not set
 # CONFIG_APUS is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_UDBG_RTAS_CONSOLE is not set
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
 CONFIG_IBMVIO=y
 # CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_WANT_EARLY_SERIAL is not set
 
@@ -135,6 +145,7 @@ CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_IOMMU_VMERGE=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_LPARCFG=y
 # CONFIG_NUMA is not set
@@ -149,6 +160,7 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_RESOURCES_64BIT=y
 # CONFIG_PPC_64K_PAGES is not set
 # CONFIG_SCHED_SMT is not set
 CONFIG_PROC_DEVICETREE=y
@@ -164,6 +176,7 @@ # CONFIG_PPC_I8259 is not set
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
+# CONFIG_PCIEPORTBUS is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -207,6 +220,8 @@ CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_XFRM_TUNNEL=m
 CONFIG_INET_TUNNEL=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -219,6 +234,7 @@ # CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
 
@@ -246,9 +262,11 @@ CONFIG_NETFILTER_XT_MATCH_MARK=m
 # CONFIG_NETFILTER_XT_MATCH_POLICY is not set
 # CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
 CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
+# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
 CONFIG_NETFILTER_XT_MATCH_REALM=m
 CONFIG_NETFILTER_XT_MATCH_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_STATE=m
+# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
 
@@ -267,6 +285,7 @@ CONFIG_IP_NF_TFTP=m
 CONFIG_IP_NF_AMANDA=m
 # CONFIG_IP_NF_PPTP is not set
 # CONFIG_IP_NF_H323 is not set
+# CONFIG_IP_NF_SIP is not set
 CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_IPRANGE=m
@@ -360,6 +379,7 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_SYS_HYPERVISOR is not set
 
 #
 # Connector - unified userspace <-> kernelspace linker
@@ -396,6 +416,7 @@ # CONFIG_BLK_DEV_SX8 is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=65536
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
@@ -453,6 +474,7 @@ # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
 # CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
@@ -464,7 +486,6 @@ # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_IPR is not set
-# CONFIG_SCSI_QLOGIC_FC is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 # CONFIG_SCSI_QLA_FC is not set
 # CONFIG_SCSI_LPFC is not set
@@ -481,9 +502,7 @@ CONFIG_MD_LINEAR=y
 CONFIG_MD_RAID0=y
 CONFIG_MD_RAID1=y
 CONFIG_MD_RAID10=m
-CONFIG_MD_RAID5=y
-# CONFIG_MD_RAID5_RESHAPE is not set
-CONFIG_MD_RAID6=m
+# CONFIG_MD_RAID456 is not set
 CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
 CONFIG_BLK_DEV_DM=y
@@ -596,6 +615,7 @@ #
 # CONFIG_CHELSIO_T1 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
+# CONFIG_MYRI10GE is not set
 
 #
 # Token Ring devices
@@ -696,6 +716,7 @@ # CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_BRIQ_PANEL is not set
 
 #
 # IPMI
@@ -706,6 +727,7 @@ #
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
+# CONFIG_HW_RANDOM is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_DTLK is not set
@@ -741,7 +763,6 @@ # CONFIG_SPI_MASTER is not set
 #
 # Dallas's 1-wire bus
 #
-# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -757,6 +778,7 @@ #
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
+CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -766,7 +788,9 @@ # CONFIG_DVB is not set
 #
 # Graphics support
 #
+CONFIG_FIRMWARE_EDID=y
 # CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -801,6 +825,14 @@ #
 # CONFIG_NEW_LEDS is not set
 
 #
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
 # InfiniBand support
 #
 # CONFIG_INFINIBAND is not set
@@ -815,6 +847,19 @@ #
 # CONFIG_RTC_CLASS is not set
 
 #
+# DMA Engine support
+#
+# CONFIG_DMA_ENGINE is not set
+
+#
+# DMA Clients
+#
+
+#
+# DMA Devices
+#
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -843,7 +888,6 @@ # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
 CONFIG_FS_POSIX_ACL=y
 CONFIG_XFS_FS=m
-CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_QUOTA is not set
 CONFIG_XFS_SECURITY=y
 CONFIG_XFS_POSIX_ACL=y
@@ -852,6 +896,7 @@ # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
@@ -933,8 +978,10 @@ CONFIG_RPCSEC_GSS_SPKM3=m
 # CONFIG_SMB_FS is not set
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS is not set
+# CONFIG_CIFS_WEAK_PW_HASH is not set
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
+# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_CIFS_EXPERIMENTAL is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1013,10 +1060,12 @@ CONFIG_TEXTSEARCH=y
 CONFIG_TEXTSEARCH_KMP=m
 CONFIG_TEXTSEARCH_BM=m
 CONFIG_TEXTSEARCH_FSM=m
+CONFIG_PLIST=y
 
 #
 # Instrumentation Support
 #
+# CONFIG_PROFILING is not set
 # CONFIG_KPROBES is not set
 
 #
@@ -1024,14 +1073,19 @@ # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=17
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
-# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_RWSEMS is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
@@ -1042,11 +1096,7 @@ CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DEBUG_STACK_USAGE=y
 # CONFIG_DEBUGGER is not set
 CONFIG_IRQSTACKS=y
-# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
-# CONFIG_PPC_EARLY_DEBUG_G5 is not set
-# CONFIG_PPC_EARLY_DEBUG_RTAS is not set
-# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
-# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
 
 #
 # Security options
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 31708ad..c18e860 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -1,13 +1,14 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.17-rc4
-# Sun May 28 07:26:56 2006
+# Linux kernel version: 2.6.18-rc3
+# Tue Aug  8 09:14:48 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
@@ -35,6 +36,7 @@ CONFIG_PPC_STD_MMU=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=128
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
 # Code maturity level options
@@ -52,6 +54,7 @@ CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 CONFIG_AUDITSYSCALL=y
@@ -70,10 +73,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
+CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -118,6 +123,9 @@ CONFIG_PPC_PSERIES=y
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 # CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PPC_IBM_CELL_BLADE is not set
+# CONFIG_UDBG_RTAS_CONSOLE is not set
 CONFIG_XICS=y
 # CONFIG_U3_DART is not set
 CONFIG_MPIC=y
@@ -149,6 +157,7 @@ CONFIG_BINFMT_MISC=m
 CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_IOMMU_VMERGE=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
 CONFIG_IRQ_ALL_CPUS=y
@@ -173,6 +182,7 @@ CONFIG_SPARSEMEM_EXTREME=y
 # CONFIG_MEMORY_HOTPLUG is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_MIGRATION=y
+CONFIG_RESOURCES_64BIT=y
 CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
 # CONFIG_PPC_64K_PAGES is not set
 CONFIG_SCHED_SMT=y
@@ -190,6 +200,7 @@ CONFIG_PPC_I8259=y
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
+# CONFIG_PCIEPORTBUS is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -238,6 +249,8 @@ CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_XFRM_TUNNEL=m
 CONFIG_INET_TUNNEL=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -250,6 +263,7 @@ # CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
 
@@ -277,6 +291,7 @@ CONFIG_IP_NF_TFTP=m
 CONFIG_IP_NF_AMANDA=m
 # CONFIG_IP_NF_PPTP is not set
 # CONFIG_IP_NF_H323 is not set
+# CONFIG_IP_NF_SIP is not set
 CONFIG_IP_NF_QUEUE=m
 
 #
@@ -316,6 +331,7 @@ #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
+# CONFIG_NET_TCPPROBE is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
@@ -332,6 +348,7 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_SYS_HYPERVISOR is not set
 
 #
 # Connector - unified userspace <-> kernelspace linker
@@ -352,6 +369,7 @@ # CONFIG_PARPORT_SERIAL is not set
 # CONFIG_PARPORT_PC_FIFO is not set
 # CONFIG_PARPORT_PC_SUPERIO is not set
 # CONFIG_PARPORT_GSC is not set
+# CONFIG_PARPORT_AX88796 is not set
 # CONFIG_PARPORT_1284 is not set
 
 #
@@ -376,6 +394,7 @@ # CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=65536
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
@@ -487,6 +506,7 @@ # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
 # CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
@@ -508,12 +528,6 @@ CONFIG_SCSI_IPR_TRACE=y
 CONFIG_SCSI_IPR_DUMP=y
 # CONFIG_SCSI_QLOGIC_1280 is not set
 CONFIG_SCSI_QLA_FC=m
-CONFIG_SCSI_QLA2XXX_EMBEDDED_FIRMWARE=y
-CONFIG_SCSI_QLA21XX=m
-CONFIG_SCSI_QLA22XX=m
-CONFIG_SCSI_QLA2300=m
-CONFIG_SCSI_QLA2322=m
-CONFIG_SCSI_QLA24XX=m
 CONFIG_SCSI_LPFC=m
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
@@ -528,9 +542,7 @@ CONFIG_MD_LINEAR=y
 CONFIG_MD_RAID0=y
 CONFIG_MD_RAID1=y
 CONFIG_MD_RAID10=m
-CONFIG_MD_RAID5=y
-CONFIG_MD_RAID5_RESHAPE=y
-CONFIG_MD_RAID6=m
+# CONFIG_MD_RAID456 is not set
 CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
 CONFIG_BLK_DEV_DM=y
@@ -651,6 +663,7 @@ CONFIG_IXGB=m
 # CONFIG_IXGB_NAPI is not set
 CONFIG_S2IO=m
 # CONFIG_S2IO_NAPI is not set
+# CONFIG_MYRI10GE is not set
 
 #
 # Token Ring devices
@@ -754,6 +767,7 @@ #
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -776,6 +790,7 @@ CONFIG_SERIAL_JSM=m
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_BRIQ_PANEL is not set
 # CONFIG_PRINTER is not set
 # CONFIG_PPDEV is not set
 # CONFIG_TIPAR is not set
@@ -793,6 +808,7 @@ #
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
+# CONFIG_HW_RANDOM is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_DTLK is not set
@@ -839,6 +855,7 @@ # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
 # CONFIG_I2C_PIIX4 is not set
 # CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PROSAVAGE is not set
@@ -876,7 +893,6 @@ # CONFIG_SPI_MASTER is not set
 #
 # Dallas's 1-wire bus
 #
-# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -892,6 +908,7 @@ #
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
+CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -902,19 +919,19 @@ # CONFIG_USB_DABUSB is not set
 #
 # Graphics support
 #
+CONFIG_FIRMWARE_EDID=y
 CONFIG_FB=y
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
 CONFIG_FB_MACMODES=y
-CONFIG_FB_FIRMWARE_EDID=y
+# CONFIG_FB_BACKLIGHT is not set
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
 # CONFIG_FB_CIRRUS is not set
 # CONFIG_FB_PM2 is not set
 # CONFIG_FB_CYBER2000 is not set
 CONFIG_FB_OF=y
-# CONFIG_FB_CT65550 is not set
 # CONFIG_FB_ASILIANT is not set
 # CONFIG_FB_IMSTT is not set
 # CONFIG_FB_VGA16 is not set
@@ -993,6 +1010,7 @@ #
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_SPLIT_ISO is not set
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
 # CONFIG_USB_ISP116X_HCD is not set
 CONFIG_USB_OHCI_HCD=y
 # CONFIG_USB_OHCI_BIG_ENDIAN is not set
@@ -1083,10 +1101,12 @@ # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
 # CONFIG_USB_PHIDGETKIT is not set
 # CONFIG_USB_PHIDGETSERVO is not set
 # CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_APPLEDISPLAY is not set
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TEST is not set
@@ -1124,12 +1144,14 @@ #
 CONFIG_INFINIBAND=m
 CONFIG_INFINIBAND_USER_MAD=m
 CONFIG_INFINIBAND_USER_ACCESS=m
+CONFIG_INFINIBAND_ADDR_TRANS=y
 CONFIG_INFINIBAND_MTHCA=m
 CONFIG_INFINIBAND_MTHCA_DEBUG=y
 CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_IPOIB_DEBUG=y
 # CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
 CONFIG_INFINIBAND_SRP=m
+# CONFIG_INFINIBAND_ISER is not set
 
 #
 # EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
@@ -1141,6 +1163,19 @@ #
 # CONFIG_RTC_CLASS is not set
 
 #
+# DMA Engine support
+#
+# CONFIG_DMA_ENGINE is not set
+
+#
+# DMA Clients
+#
+
+#
+# DMA Devices
+#
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -1169,15 +1204,16 @@ # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
 CONFIG_FS_POSIX_ACL=y
 CONFIG_XFS_FS=m
-CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_QUOTA is not set
 CONFIG_XFS_SECURITY=y
 CONFIG_XFS_POSIX_ACL=y
 # CONFIG_XFS_RT is not set
 CONFIG_OCFS2_FS=m
+CONFIG_OCFS2_DEBUG_MASKLOG=y
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
@@ -1259,8 +1295,10 @@ CONFIG_RPCSEC_GSS_SPKM3=m
 # CONFIG_SMB_FS is not set
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS is not set
+# CONFIG_CIFS_WEAK_PW_HASH is not set
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
+# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_CIFS_EXPERIMENTAL is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1326,6 +1364,9 @@ CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
+CONFIG_TEXTSEARCH=y
+CONFIG_TEXTSEARCH_KMP=m
+CONFIG_PLIST=y
 
 #
 # Instrumentation Support
@@ -1339,14 +1380,19 @@ # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=17
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
-# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_RWSEMS is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
