Message-ID: <3EEE648A.3060305@mvista.com>
Date: Mon, 16 Jun 2003 17:44:58 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel patch for pplus
Content-Type: multipart/mixed;
 boundary="------------050205040606060707000906"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------050205040606060707000906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch does the following:

1) updates pplus_defconfig
2) updates pplus_openpic_initsenses to work with new openpic code
3) adds KGDB support
4) does some minor cleanup

Please apply if it is acceptable.

Thanks,

Mark

--------------050205040606060707000906
Content-Type: text/plain;
 name="pplus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pplus.patch"

===== arch/ppc/config.in 1.187 vs edited =====
--- 1.187/arch/ppc/config.in	Sat Jun  7 10:13:25 2003
+++ edited/arch/ppc/config.in	Mon Jun 16 15:31:58 2003
@@ -495,8 +495,10 @@
   dep_bool '  Support for reading of PReP Residual Data in /proc' CONFIG_PROC_PREPRESIDUAL $CONFIG_PREP_RESIDUAL
   define_bool CONFIG_PPCBUG_NVRAM y
 fi
+
 if [ "$CONFIG_PPLUS" = "y" -o "$CONFIG_LOPEC" = "y" ]; then
   bool 'Enable reading PPCBUG NVRAM during boot' CONFIG_PPCBUG_NVRAM
+  define_bool CONFIG_GEN550 y
 fi

 bool 'Default bootloader kernel arguments' CONFIG_CMDLINE_BOOL
===== arch/ppc/configs/pplus_defconfig 1.3 vs edited =====
--- 1.3/arch/ppc/configs/pplus_defconfig	Thu Apr 17 22:47:41 2003
+++ edited/arch/ppc/configs/pplus_defconfig	Mon Jun 16 15:35:52 2003
@@ -10,6 +10,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
+# CONFIG_ADVANCED_OPTIONS is not set

 #
 # Loadable module support
@@ -25,6 +26,7 @@
 CONFIG_PPC32=y
 CONFIG_6xx=y
 # CONFIG_40x is not set
+# CONFIG_440 is not set
 # CONFIG_POWER3 is not set
 # CONFIG_8xx is not set
 # CONFIG_8260 is not set
@@ -32,11 +34,15 @@
 # CONFIG_ALL_PPC is not set
 # CONFIG_APUS is not set
 # CONFIG_WILLOW is not set
+# CONFIG_CPCI690 is not set
 # CONFIG_PCORE is not set
 # CONFIG_POWERPMC250 is not set
+# CONFIG_PPMC260 is not set
 # CONFIG_EV64260 is not set
 # CONFIG_SPRUCE is not set
 # CONFIG_MENF1 is not set
+# CONFIG_PUMA_A is not set
+# CONFIG_HXEB100 is not set
 # CONFIG_LOPEC is not set
 # CONFIG_MCPN765 is not set
 # CONFIG_MVME5100 is not set
@@ -46,11 +52,13 @@
 # CONFIG_SANDPOINT is not set
 # CONFIG_ADIR is not set
 # CONFIG_K2 is not set
+# CONFIG_PAL4 is not set
 # CONFIG_GEMINI is not set
 # CONFIG_ZX4500 is not set
 # CONFIG_SMP is not set
 # CONFIG_ALTIVEC is not set
 # CONFIG_TAU is not set
+CONFIG_PPC_ISATIMER=y

 #
 # General setup
@@ -77,7 +85,10 @@
 # Parallel port support
 #
 # CONFIG_PARPORT is not set
+# CONFIG_GEN_RTC is not set
 CONFIG_PPC_RTC=y
+# CONFIG_PPCBUG_NVRAM is not set
+CONFIG_GEN550=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="ip=on"

@@ -100,11 +111,14 @@
 # CONFIG_PARIDE is not set
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_CISS_SCSI_TAPE is not set
 # CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_BLK_STATS is not set

 #
 # Multi-device support (RAID and LVM)
@@ -123,8 +137,6 @@
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-CONFIG_NETLINK=y
-# CONFIG_RTNETLINK is not set
 # CONFIG_NETLINK_DEV is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
@@ -140,6 +152,7 @@
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
 # CONFIG_INET_ECN is not set
 CONFIG_SYN_COOKIES=y

@@ -148,18 +161,26 @@
 #
 CONFIG_IP_NF_CONNTRACK=m
 CONFIG_IP_NF_FTP=m
+# CONFIG_IP_NF_AMANDA is not set
+# CONFIG_IP_NF_TFTP is not set
 # CONFIG_IP_NF_IRC is not set
 # CONFIG_IP_NF_QUEUE is not set
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_LIMIT=m
 CONFIG_IP_NF_MATCH_MAC=m
+# CONFIG_IP_NF_MATCH_PKTTYPE is not set
 CONFIG_IP_NF_MATCH_MARK=m
 CONFIG_IP_NF_MATCH_MULTIPORT=m
 CONFIG_IP_NF_MATCH_TOS=m
+# CONFIG_IP_NF_MATCH_ECN is not set
+# CONFIG_IP_NF_MATCH_DSCP is not set
+# CONFIG_IP_NF_MATCH_AH_ESP is not set
 # CONFIG_IP_NF_MATCH_LENGTH is not set
 # CONFIG_IP_NF_MATCH_TTL is not set
 # CONFIG_IP_NF_MATCH_TCPMSS is not set
+# CONFIG_IP_NF_MATCH_HELPER is not set
 CONFIG_IP_NF_MATCH_STATE=m
+# CONFIG_IP_NF_MATCH_CONNTRACK is not set
 CONFIG_IP_NF_MATCH_UNCLEAN=m
 CONFIG_IP_NF_MATCH_OWNER=m
 CONFIG_IP_NF_FILTER=m
@@ -169,11 +190,14 @@
 CONFIG_IP_NF_NAT_NEEDED=y
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
+# CONFIG_IP_NF_NAT_LOCAL is not set
 # CONFIG_IP_NF_NAT_SNMP_BASIC is not set
 CONFIG_IP_NF_NAT_FTP=m
 # CONFIG_IP_NF_MANGLE is not set
 # CONFIG_IP_NF_TARGET_LOG is not set
+# CONFIG_IP_NF_TARGET_ULOG is not set
 # CONFIG_IP_NF_TARGET_TCPMSS is not set
+# CONFIG_IP_NF_ARPTABLES is not set
 CONFIG_IP_NF_COMPAT_IPCHAINS=m
 CONFIG_IP_NF_NAT_NEEDED=y
 # CONFIG_IP_NF_COMPAT_IPFWADM is not set
@@ -187,6 +211,11 @@
 #
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
+
+#
+# Appletalk devices
+#
+# CONFIG_DEV_APPLETALK is not set
 # CONFIG_DECNET is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_X25 is not set
@@ -204,6 +233,11 @@
 # CONFIG_NET_SCHED is not set

 #
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+
+#
 # ATA/IDE/MFM/RLL support
 #
 CONFIG_IDE=y
@@ -220,20 +254,13 @@
 # CONFIG_BLK_DEV_HD is not set
 CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_IDEDISK_MULTI_MODE is not set
-# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
-# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
-# CONFIG_BLK_DEV_IDEDISK_IBM is not set
-# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
-# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
-# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
-# CONFIG_BLK_DEV_IDEDISK_WD is not set
-# CONFIG_BLK_DEV_COMMERIAL is not set
-# CONFIG_BLK_DEV_TIVO is not set
+# CONFIG_IDEDISK_STROKE is not set
 # CONFIG_BLK_DEV_IDECS is not set
 CONFIG_BLK_DEV_IDECD=y
 # CONFIG_BLK_DEV_IDETAPE is not set
 CONFIG_BLK_DEV_IDEFLOPPY=y
 CONFIG_BLK_DEV_IDESCSI=y
+# CONFIG_IDE_TASK_IOCTL is not set

 #
 # IDE chipset support/bugfixes
@@ -241,34 +268,39 @@
 # CONFIG_BLK_DEV_CMD640 is not set
 # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
 # CONFIG_BLK_DEV_ISAPNP is not set
-# CONFIG_BLK_DEV_RZ1000 is not set
 CONFIG_BLK_DEV_IDEPCI=y
+# CONFIG_BLK_DEV_GENERIC is not set
 CONFIG_IDEPCI_SHARE_IRQ=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
+# CONFIG_IDEDMA_ONLYDISK is not set
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_PCI_WIP is not set
-# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
+# CONFIG_BLK_DEV_ADMA100 is not set
 # CONFIG_BLK_DEV_AEC62XX is not set
-# CONFIG_AEC62XX_TUNING is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_WDC_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
 # CONFIG_AMD74XX_OVERRIDE is not set
 # CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
 # CONFIG_BLK_DEV_CY82C693 is not set
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_HPT34X_AUTODMA is not set
 # CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_PIIX is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
-# CONFIG_BLK_DEV_PDC202XX is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
 # CONFIG_PDC202XX_BURST is not set
-# CONFIG_PDC202XX_FORCE is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_RZ1000 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
 # CONFIG_BLK_DEV_SIS5513 is not set
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
@@ -282,6 +314,7 @@
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
+# CONFIG_BLK_DEV_ATARAID_SII is not set

 #
 # SCSI support
@@ -317,7 +350,9 @@
 # CONFIG_SCSI_AHA152X is not set
 # CONFIG_SCSI_AHA1542 is not set
 # CONFIG_SCSI_AHA1740 is not set
+# CONFIG_SCSI_AACRAID is not set
 # CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
@@ -361,14 +396,34 @@
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_T128 is not set
 # CONFIG_SCSI_U14_34F is not set
+# CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set

 #
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+# CONFIG_FUSION_BOOT is not set
+# CONFIG_FUSION_ISENSE is not set
+# CONFIG_FUSION_CTL is not set
+# CONFIG_FUSION_LAN is not set
+
+#
 # IEEE 1394 (FireWire) support (EXPERIMENTAL)
 #
 # CONFIG_IEEE1394 is not set

 #
+# I2O device support
+#
+# CONFIG_I2O is not set
+# CONFIG_I2O_PCI is not set
+# CONFIG_I2O_BLOCK is not set
+# CONFIG_I2O_LAN is not set
+# CONFIG_I2O_SCSI is not set
+# CONFIG_I2O_PROC is not set
+
+#
 # Network device support
 #
 CONFIG_NETDEVICES=y
@@ -394,7 +449,6 @@
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNBMAC is not set
 # CONFIG_SUNQE is not set
-# CONFIG_SUNLANCE is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_LANCE is not set
@@ -404,6 +458,7 @@
 # CONFIG_NET_ISA is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_APRICOT is not set
 # CONFIG_CS89x0 is not set
@@ -414,6 +469,8 @@
 # CONFIG_DGRS is not set
 # CONFIG_DM9102 is not set
 CONFIG_EEPRO100=y
+# CONFIG_EEPRO100_PIO is not set
+# CONFIG_E100 is not set
 # CONFIG_LNE390 is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
@@ -425,11 +482,15 @@
 # CONFIG_8139TOO_PIO is not set
 # CONFIG_8139TOO_TUNE_TWISTER is not set
 # CONFIG_8139TOO_8129 is not set
+# CONFIG_8139_OLD_RX_RESET is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
+# CONFIG_SUNDANCE_MMIO is not set
 # CONFIG_TLAN is not set
+# CONFIG_TC35815 is not set
 # CONFIG_VIA_RHINE is not set
+# CONFIG_VIA_RHINE_MMIO is not set
 # CONFIG_WINBOND_840 is not set
 # CONFIG_NET_POCKET is not set

@@ -438,11 +499,14 @@
 #
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
 # CONFIG_MYRI_SBUS is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
 # CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PLIP is not set
@@ -537,6 +601,7 @@
 CONFIG_PSMOUSE=y
 # CONFIG_82C710_MOUSE is not set
 # CONFIG_PC110_PAD is not set
+# CONFIG_MK712_MOUSE is not set

 #
 # Joysticks
@@ -551,12 +616,18 @@
 # Input core support is needed for joysticks
 #
 # CONFIG_QIC02_TAPE is not set
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_IPMI_PANIC_EVENT is not set
+# CONFIG_IPMI_DEVICE_INTERFACE is not set
+# CONFIG_IPMI_KCS is not set
+# CONFIG_IPMI_WATCHDOG is not set

 #
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-# CONFIG_INTEL_RNG is not set
+# CONFIG_SCx200_GPIO is not set
+# CONFIG_AMD_PM768 is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
 # CONFIG_DTLK is not set
@@ -588,6 +659,8 @@
 # CONFIG_ADFS_FS_RW is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BEFS_DEBUG is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EXT3_FS is not set
 # CONFIG_JBD is not set
@@ -601,10 +674,13 @@
 # CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_TMPFS is not set
-# CONFIG_RAMFS is not set
+CONFIG_RAMFS=y
 CONFIG_ISO9660_FS=y
 # CONFIG_JOLIET is not set
 # CONFIG_ZISOFS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_JFS_DEBUG is not set
+# CONFIG_JFS_STATISTICS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
@@ -635,6 +711,7 @@
 CONFIG_ROOT_NFS=y
 # CONFIG_NFSD is not set
 # CONFIG_NFSD_V3 is not set
+# CONFIG_NFSD_TCP is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
 # CONFIG_SMB_FS is not set
@@ -648,7 +725,6 @@
 # CONFIG_NCPFS_NLS is not set
 # CONFIG_NCPFS_EXTRAS is not set
 # CONFIG_ZISOFS_FS is not set
-# CONFIG_ZLIB_FS_INFLATE is not set

 #
 # Partition Types
@@ -669,111 +745,18 @@
 # CONFIG_USB is not set

 #
-# USB Controllers
-#
-# CONFIG_USB_UHCI is not set
-# CONFIG_USB_UHCI_ALT is not set
-# CONFIG_USB_OHCI is not set
-
-#
-# USB Device Class drivers
-#
-# CONFIG_USB_AUDIO is not set
-# CONFIG_USB_BLUETOOTH is not set
-# CONFIG_USB_STORAGE is not set
-# CONFIG_USB_STORAGE_DEBUG is not set
-# CONFIG_USB_STORAGE_DATAFAB is not set
-# CONFIG_USB_STORAGE_FREECOM is not set
-# CONFIG_USB_STORAGE_ISD200 is not set
-# CONFIG_USB_STORAGE_DPCM is not set
-# CONFIG_USB_STORAGE_HP8200e is not set
-# CONFIG_USB_STORAGE_SDDR09 is not set
-# CONFIG_USB_STORAGE_JUMPSHOT is not set
-# CONFIG_USB_ACM is not set
-# CONFIG_USB_PRINTER is not set
-
-#
-# USB Human Interface Devices (HID)
-#
-
-#
-#   Input core support is needed for USB HID
-#
-
-#
-# USB Imaging devices
-#
-# CONFIG_USB_DC2XX is not set
-# CONFIG_USB_MDC800 is not set
-# CONFIG_USB_SCANNER is not set
-# CONFIG_USB_MICROTEK is not set
-# CONFIG_USB_HPUSBSCSI is not set
-
-#
-# USB Multimedia devices
-#
-
-#
-#   Video4Linux support is needed for USB Multimedia device support
-#
-
-#
-# USB Network adaptors
-#
-# CONFIG_USB_PEGASUS is not set
-# CONFIG_USB_KAWETH is not set
-# CONFIG_USB_CATC is not set
-# CONFIG_USB_CDCETHER is not set
-# CONFIG_USB_USBNET is not set
-
-#
-# USB port drivers
-#
-# CONFIG_USB_USS720 is not set
-
-#
-# USB Serial Converter support
-#
-# CONFIG_USB_SERIAL is not set
-# CONFIG_USB_SERIAL_GENERIC is not set
-# CONFIG_USB_SERIAL_BELKIN is not set
-# CONFIG_USB_SERIAL_WHITEHEAT is not set
-# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
-# CONFIG_USB_SERIAL_EMPEG is not set
-# CONFIG_USB_SERIAL_FTDI_SIO is not set
-# CONFIG_USB_SERIAL_VISOR is not set
-# CONFIG_USB_SERIAL_IR is not set
-# CONFIG_USB_SERIAL_EDGEPORT is not set
-# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
-# CONFIG_USB_SERIAL_KEYSPAN is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
-# CONFIG_USB_SERIAL_MCT_U232 is not set
-# CONFIG_USB_SERIAL_PL2303 is not set
-# CONFIG_USB_SERIAL_CYBERJACK is not set
-# CONFIG_USB_SERIAL_XIRCOM is not set
-# CONFIG_USB_SERIAL_OMNINET is not set
-
-#
-# USB Miscellaneous drivers
+# Bluetooth support
 #
-# CONFIG_USB_RIO500 is not set
+# CONFIG_BLUEZ is not set

 #
-# Bluetooth support
+# Library routines
 #
-# CONFIG_BLUEZ is not set
+# CONFIG_ZLIB_INFLATE is not set
+# CONFIG_ZLIB_DEFLATE is not set

 #
 # Kernel hacking
 #
-# CONFIG_MAGIC_SYSRQ is not set
-# CONFIG_KGDB is not set
-# CONFIG_XMON is not set
-# CONFIG_BDI_SWITCH is not set
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SERIAL_TEXT_DEBUG is not set
===== arch/ppc/platforms/pplus_pci.c 1.3 vs edited =====
--- 1.3/arch/ppc/platforms/pplus_pci.c	Wed Aug  7 12:18:06 2002
+++ edited/arch/ppc/platforms/pplus_pci.c	Thu Jun  5 14:57:14 2003
@@ -215,21 +215,22 @@
 #define	MOT_PROC2_BIT		0x800

 static u_char pplus_openpic_initsenses[] __initdata = {
-    1,	/* MVME2600_INT_SIO */
-    0,	/* MVME2600_INT_FALCN_ECC_ERR */
-    1,	/* MVME2600_INT_PCI_ETHERNET */
-    1,	/* MVME2600_INT_PCI_SCSI */
-    1,	/* MVME2600_INT_PCI_GRAPHICS */
-    1,	/* MVME2600_INT_PCI_VME0 */
-    1,	/* MVME2600_INT_PCI_VME1 */
-    1,	/* MVME2600_INT_PCI_VME2 */
-    1,	/* MVME2600_INT_PCI_VME3 */
-    1,	/* MVME2600_INT_PCI_INTA */
-    1,	/* MVME2600_INT_PCI_INTB */
-    1,	/* MVME2600_INT_PCI_INTC */
-    1,	/* MVME2600_INT_PCI_INTD */
-    1,	/* MVME2600_INT_LM_SIG0 */
-    1,	/* MVME2600_INT_LM_SIG1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),/* MVME2600_INT_SIO */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_NEGATIVE),/*MVME2600_INT_FALCN_ECC_ERR*/
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/*MVME2600_INT_PCI_ETHERNET */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* MVME2600_INT_PCI_SCSI */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* MVME2600_INT_PCI_GRAPHICS*/
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* MVME2600_INT_PCI_VME0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* MVME2600_INT_PCI_VME1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* MVME2600_INT_PCI_VME2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* MVME2600_INT_PCI_VME3 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* MVME2600_INT_PCI_INTA */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* MVME2600_INT_PCI_INTB */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* MVME2600_INT_PCI_INTC */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* MVME2600_INT_PCI_INTD */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* MVME2600_INT_LM_SIG0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* MVME2600_INT_LM_SIG1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),
 };

 int mot_entry = -1;
===== arch/ppc/platforms/pplus_setup.c 1.13 vs edited =====
--- 1.13/arch/ppc/platforms/pplus_setup.c	Tue Jan  7 14:56:02 2003
+++ edited/arch/ppc/platforms/pplus_setup.c	Mon Jun 16 15:35:22 2003
@@ -48,6 +48,8 @@
 #include <linux/ide.h>
 #include <linux/kdev_t.h>
 #include <linux/seq_file.h>
+#include <linux/serial.h>
+#include <linux/serialP.h>

 #include <asm/sections.h>
 #include <asm/mmu.h>
@@ -71,6 +73,7 @@
 #include <asm/pplus.h>
 #include <asm/todc.h>
 #include <asm/bootinfo.h>
+#include <asm/serial.h>

 #undef DUMP_DBATS

@@ -92,6 +95,9 @@

 extern unsigned long loops_per_jiffy;

+extern void gen550_progress(char *, unsigned short);
+extern void gen550_init(int, struct serial_struct *);
+
 static int
 pplus_show_cpuinfo(struct seq_file *m)
 {
@@ -109,13 +115,13 @@
 	unsigned char reg;

 	if ( ppc_md.progress )
-		ppc_md.progress("pplus_setup_arch: enter\n", 0);
+		ppc_md.progress("pplus_setup_arch: enter", 0);

 	/* init to some ~sane value until calibrate_delay() runs */
 	loops_per_jiffy = 50000000;

 	if ( ppc_md.progress )
-		ppc_md.progress("pplus_setup_arch: find_bridges\n", 0);
+		ppc_md.progress("pplus_setup_arch: find_bridges", 0);

 	/* Setup PCI host bridge */
 	pplus_setup_hose();
@@ -145,7 +151,7 @@
 	printk(KERN_INFO "Port by MontaVista Software, Inc. (source@mvista.com)\n");

 	if ( ppc_md.progress )
-		ppc_md.progress("pplus_setup_arch: raven_init\n", 0);
+		ppc_md.progress("pplus_setup_arch: raven_init", 0);

 	raven_init();

@@ -172,7 +178,7 @@
 	}
 #endif
 	if ( ppc_md.progress )
-		ppc_md.progress("pplus_setup_arch: exit\n", 0);
+		ppc_md.progress("pplus_setup_arch: exit", 0);
 }

 static void
@@ -241,8 +247,13 @@
 {
 	int i;

-	if (OpenPIC_Addr != NULL)
+	if (OpenPIC_Addr != NULL) {
+		openpic_set_sources(0, 16, OpenPIC_Addr+0x10000);
 		openpic_init(NUM_8259_INTERRUPTS);
+		openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
+					i8259_irq);
+	}
+
 	for ( i = 0 ; i < NUM_8259_INTERRUPTS ; i++ )
 		irq_desc[i].handler = &i8259_pic;
 	i8259_init(0);
@@ -370,7 +381,7 @@
 	unsigned long total;

 	if (ppc_md.progress)
-		ppc_md.progress("pplus_find_end_of_memory\n",0);
+		ppc_md.progress("pplus_find_end_of_memory",0);

 #ifdef DUMP_DBATS
 	dump_dbats();
@@ -430,41 +441,38 @@
 	return;
 }

-#ifdef CONFIG_SERIAL_TEXT_DEBUG
-#include <linux/serial.h>
-#include <linux/serialP.h>
-#include <linux/serial_reg.h>
-#include <asm/serial.h>
-
-static struct serial_state rs_table[RS_TABLE_SIZE] = {
-	SERIAL_PORT_DFNS        /* Defined in <asm/serial.h> */
-};
+#if defined(CONFIG_SERIAL) && \
+	(defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB))
+extern struct serial_state rs_table[];

-	void
-pplus_progress(char *s, unsigned short hex)
+static void __init
+pplus_early_serial_map(void)
 {
-	volatile char c;
-	volatile unsigned long com_port;
-	u16 shift;
-
-	com_port = rs_table[0].port + isa_io_base;
-	shift = rs_table[0].iomem_reg_shift;
-
-	while ((c = *s++) != 0) {
-		while ((*((volatile unsigned char *)com_port +
-						(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-			;
-		*(volatile unsigned char *)com_port = c;
-
-		if (c == '\n') {
-			while ((*((volatile unsigned char *)com_port +
-							(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-				;
-			*(volatile unsigned char *)com_port = '\r';
-		}
-	}
+	struct serial_struct serial_req;
+
+	/* Setup serial port access */
+	memset(&serial_req, 0, sizeof(serial_req));
+
+	/*
+	 * rs_table[] already set up by <asm/pc_serial.h> so use that info for
+	 * gen550_init().  This also means early_serial_setup() doesn't
+	 * have to be called.
+	 */
+	serial_req.port = rs_table[0].port;
+	serial_req.io_type = rs_table[0].io_type;
+	serial_req.iomem_reg_shift = rs_table[0].iomem_reg_shift;
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	gen550_init(0, &serial_req);
+#endif
+
+	serial_req.port = rs_table[1].port;
+	serial_req.io_type = rs_table[1].io_type;
+	serial_req.iomem_reg_shift = rs_table[1].iomem_reg_shift;
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	gen550_init(1, &serial_req);
+#endif
 }
-#endif  /* CONFIG_SERIAL_TEXT_DEBUG */
+#endif

 void __init
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
@@ -508,10 +516,6 @@
 	ppc_md.find_end_of_memory = pplus_find_end_of_memory;
 	ppc_md.setup_io_mappings = pplus_map_io;

-#ifdef CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.progress = pplus_progress;
-#endif
-
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 	ppc_ide_md.default_irq = pplus_ide_default_irq;
 	ppc_ide_md.default_io_base = pplus_ide_default_io_base;
@@ -529,6 +533,15 @@
 	ppc_md.ppc_kbd_sysrq_xlate	 = pckbd_sysrq_xlate;
 	SYSRQ_KEY = 0x54;
 #endif
+#endif
+
+#if defined(CONFIG_SERIAL) && \
+	(defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB))
+	pplus_early_serial_map();
+
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	ppc_md.progress = gen550_progress;
+#endif /* CONFIG_SERIAL_TEXT_DEBUG */
 #endif

 #ifdef CONFIG_SMP

--------------050205040606060707000906--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
