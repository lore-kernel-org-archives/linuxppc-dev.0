Return-Path: <SRS0+2925e47be95e8461dd39+501+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4AF02BF21
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jan 2005 03:03:20 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1102242855.11763.70.camel@gaston>
References: <1102242855.11763.70.camel@gaston>
Content-Type: multipart/mixed; boundary="=-WfHEFeDD2HnhprlqkfEk"
Date: Thu, 06 Jan 2005 16:02:02 +0000
Message-Id: <1105027322.5698.32.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Cc: fedora-ppc@lists.infradead.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep patch #7
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-WfHEFeDD2HnhprlqkfEk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-12-05 at 21:34 +1100, Benjamin Herrenschmidt wrote:
> Ok, here's the 7th version of the sleep patch for ATI based albooks &
> iBook G4. Other machine users, please test too as it may cause
> regressions (or improvements) as well.

This is it updated to 2.6.10. I wasn't paying much attention -- mostly
just clicking on the pretty BK merge tool :)

But it survives booting and a couple of suspend/resume cycles on my
shinybook so it seems OK. Fedora Core 3 RPMS as before in the yum repo
at ftp://ftp.uk.linux.org/pub/people/dwmw2/fc3-kernel-ppc/

-- 
dwmw2

--=-WfHEFeDD2HnhprlqkfEk
Content-Disposition: inline; filename=albook-ibookg4-sleep-7-for-2.6.10.diff
Content-Type: text/x-patch; name=albook-ibookg4-sleep-7-for-2.6.10.diff;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uNr linus-2.6.10/arch/ppc/configs/pmac_defconfig sleep-2.6.10/arch/ppc/configs/pmac_defconfig
--- linus-2.6.10/arch/ppc/configs/pmac_defconfig	2005-01-06 10:48:40.744261888 +0000
+++ sleep-2.6.10/arch/ppc/configs/pmac_defconfig	2005-01-06 11:39:21.689183824 +0000
@@ -1,5 +1,7 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.9-gack
+# Wed Dec  1 15:52:56 2004
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -13,12 +15,12 @@
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
-# CONFIG_STANDALONE is not set
 CONFIG_BROKEN_ON_SMP=y
 
 #
 # General setup
 #
+CONFIG_LOCALVERSION=""
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -31,6 +33,7 @@
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_IOSCHED_NOOP=y
@@ -38,6 +41,8 @@
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+# CONFIG_TINY_SHMEM is not set
 
 #
 # Loadable module support
@@ -58,6 +63,7 @@
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
 # CONFIG_8xx is not set
+# CONFIG_E500 is not set
 CONFIG_ALTIVEC=y
 CONFIG_TAU=y
 # CONFIG_TAU_INT is not set
@@ -67,8 +73,10 @@
 CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
-# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
-# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
+# CONFIG_CPU_FREQ_24_API is not set
 CONFIG_CPU_FREQ_PMAC=y
 CONFIG_CPU_FREQ_TABLE=y
 CONFIG_PPC601_SYNC_FIX=y
@@ -97,9 +105,12 @@
 # CONFIG_PAL4 is not set
 # CONFIG_GEMINI is not set
 # CONFIG_EST8260 is not set
+# CONFIG_SBC82xx is not set
 # CONFIG_SBS8260 is not set
-# CONFIG_RPX6 is not set
+# CONFIG_RPX8260 is not set
 # CONFIG_TQM8260 is not set
+# CONFIG_ADS8272 is not set
+# CONFIG_LITE5200 is not set
 CONFIG_PPC_CHRP=y
 CONFIG_PPC_PMAC=y
 CONFIG_PPC_PREP=y
@@ -108,11 +119,9 @@
 # CONFIG_SMP is not set
 # CONFIG_PREEMPT is not set
 # CONFIG_HIGHMEM is not set
-CONFIG_KERNEL_ELF=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
 CONFIG_PROC_DEVICETREE=y
-CONFIG_PPC_RTAS=y
 # CONFIG_PREP_RESIDUAL is not set
 # CONFIG_CMDLINE_BOOL is not set
 
@@ -133,8 +142,9 @@
 # CONFIG_PCMCIA_DEBUG is not set
 CONFIG_YENTA=m
 CONFIG_CARDBUS=y
-CONFIG_I82092=m
-CONFIG_TCIC=m
+# CONFIG_PD6729 is not set
+# CONFIG_I82092 is not set
+# CONFIG_TCIC is not set
 
 #
 # Advanced setup
@@ -156,6 +166,8 @@
 #
 # Generic Driver Options
 #
+# CONFIG_STANDALONE is not set
+CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 
 #
@@ -176,6 +188,7 @@
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_MAC_FLOPPY is not set
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
@@ -183,7 +196,8 @@
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_CARMEL is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
@@ -198,9 +212,9 @@
 #
 # Please see Documentation/ide.txt for help/info on IDE drives
 #
+# CONFIG_BLK_DEV_IDE_SATA is not set
 CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_IDEDISK_MULTI_MODE is not set
-# CONFIG_IDEDISK_STROKE is not set
 CONFIG_BLK_DEV_IDECS=m
 CONFIG_BLK_DEV_IDECD=y
 # CONFIG_BLK_DEV_IDETAPE is not set
@@ -223,7 +237,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
@@ -250,6 +263,7 @@
 CONFIG_BLK_DEV_IDEDMA_PMAC=y
 CONFIG_BLK_DEV_IDE_PMAC_BLINK=y
 CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO=y
+# CONFIG_IDE_ARM is not set
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
@@ -275,7 +289,6 @@
 # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
 #
 # CONFIG_SCSI_MULTI_LUN is not set
-# CONFIG_SCSI_REPORT_LUNS is not set
 CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_LOGGING is not set
 
@@ -289,22 +302,22 @@
 # SCSI low-level drivers
 #
 # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
 # CONFIG_SCSI_ACARD is not set
 # CONFIG_SCSI_AACRAID is not set
 CONFIG_SCSI_AIC7XXX=m
 CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
 CONFIG_AIC7XXX_RESET_DELAY_MS=15000
-# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
 CONFIG_AIC7XXX_DEBUG_ENABLE=y
 CONFIG_AIC7XXX_DEBUG_MASK=0
 CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
 CONFIG_SCSI_AIC7XXX_OLD=m
 # CONFIG_SCSI_AIC79XX is not set
-CONFIG_SCSI_ADVANSYS=m
-# CONFIG_SCSI_MEGARAID is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_SCSI_SATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
-# CONFIG_SCSI_CPQFCTS is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
 # CONFIG_SCSI_EATA_PIO is not set
@@ -400,8 +413,6 @@
 CONFIG_PMAC_PBOOK=y
 CONFIG_PMAC_APM_EMU=y
 CONFIG_PMAC_BACKLIGHT=y
-# CONFIG_MAC_FLOPPY is not set
-CONFIG_MAC_SERIAL=y
 CONFIG_ADB_MACIO=y
 CONFIG_INPUT_ADBHID=y
 CONFIG_MAC_EMUMOUSEBTN=y
@@ -434,6 +445,7 @@
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
 
 #
 # IP: Virtual Server Configuration
@@ -447,6 +459,8 @@
 # IP: Netfilter Configuration
 #
 CONFIG_IP_NF_CONNTRACK=m
+# CONFIG_IP_NF_CT_ACCT is not set
+# CONFIG_IP_NF_CT_PROTO_SCTP is not set
 CONFIG_IP_NF_FTP=m
 CONFIG_IP_NF_IRC=m
 CONFIG_IP_NF_TFTP=m
@@ -471,8 +485,15 @@
 CONFIG_IP_NF_MATCH_STATE=m
 CONFIG_IP_NF_MATCH_CONNTRACK=m
 CONFIG_IP_NF_MATCH_OWNER=m
+# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
+# CONFIG_IP_NF_MATCH_REALM is not set
+# CONFIG_IP_NF_MATCH_SCTP is not set
+# CONFIG_IP_NF_MATCH_COMMENT is not set
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
+# CONFIG_IP_NF_TARGET_LOG is not set
+CONFIG_IP_NF_TARGET_ULOG=m
+CONFIG_IP_NF_TARGET_TCPMSS=m
 CONFIG_IP_NF_NAT=m
 CONFIG_IP_NF_NAT_NEEDED=y
 CONFIG_IP_NF_TARGET_MASQUERADE=m
@@ -486,16 +507,13 @@
 CONFIG_IP_NF_NAT_TFTP=m
 CONFIG_IP_NF_NAT_AMANDA=m
 # CONFIG_IP_NF_MANGLE is not set
-# CONFIG_IP_NF_TARGET_LOG is not set
-CONFIG_IP_NF_TARGET_ULOG=m
-CONFIG_IP_NF_TARGET_TCPMSS=m
+CONFIG_IP_NF_RAW=m
+CONFIG_IP_NF_TARGET_NOTRACK=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_IP_NF_COMPAT_IPCHAINS=m
 # CONFIG_IP_NF_COMPAT_IPFWADM is not set
-CONFIG_IP_NF_TARGET_NOTRACK=m
-CONFIG_IP_NF_RAW=m
 
 #
 # SCTP Configuration (EXPERIMENTAL)
@@ -519,6 +537,7 @@
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
@@ -594,7 +613,6 @@
 CONFIG_MACE=y
 # CONFIG_MACE_AAUI_PORT is not set
 CONFIG_BMAC=y
-# CONFIG_OAKNET is not set
 # CONFIG_HAPPYMEAL is not set
 CONFIG_SUNGEM=y
 # CONFIG_NET_VENDOR_3COM is not set
@@ -623,6 +641,7 @@
 # CONFIG_SUNDANCE is not set
 # CONFIG_TLAN is not set
 # CONFIG_VIA_RHINE is not set
+# CONFIG_VIA_VELOCITY is not set
 
 #
 # Ethernet (1000 Mbit)
@@ -668,7 +687,6 @@
 #
 # Wireless 802.11b ISA/PCI cards support
 #
-# CONFIG_AIRO is not set
 CONFIG_HERMES=m
 CONFIG_APPLE_AIRPORT=m
 # CONFIG_PLX_HERMES is not set
@@ -718,7 +736,6 @@
 # CONFIG_PPPOE is not set
 # CONFIG_SLIP is not set
 # CONFIG_NET_FC is not set
-# CONFIG_RCPCI is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 
@@ -759,6 +776,7 @@
 # CONFIG_SERIO_SERPORT is not set
 # CONFIG_SERIO_CT82C710 is not set
 # CONFIG_SERIO_PCIPS2 is not set
+# CONFIG_SERIO_RAW is not set
 
 #
 # Input Device Drivers
@@ -802,7 +820,6 @@
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_QIC02_TAPE is not set
 
 #
 # IPMI
@@ -823,7 +840,6 @@
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_FTAPE is not set
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
@@ -844,6 +860,7 @@
 #
 CONFIG_I2C_ALGOBIT=y
 # CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
 
 #
 # I2C Hardware Bus support
@@ -870,23 +887,29 @@
 # CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
 # CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_ISA is not set
 
 #
 # Hardware Sensors Chip support
 #
 # CONFIG_I2C_SENSOR is not set
 # CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ASB100 is not set
 # CONFIG_SENSORS_DS1621 is not set
 # CONFIG_SENSORS_FSCHER is not set
 # CONFIG_SENSORS_GL518SM is not set
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
 # CONFIG_SENSORS_LM78 is not set
 # CONFIG_SENSORS_LM80 is not set
 # CONFIG_SENSORS_LM83 is not set
 # CONFIG_SENSORS_LM85 is not set
 # CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
 # CONFIG_SENSORS_VIA686A is not set
 # CONFIG_SENSORS_W83781D is not set
 # CONFIG_SENSORS_W83L785TS is not set
@@ -898,12 +921,18 @@
 # CONFIG_SENSORS_EEPROM is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
 
 #
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
 # Misc devices
 #
 
@@ -921,6 +950,8 @@
 # Graphics support
 #
 CONFIG_FB=y
+CONFIG_FB_MODE_HELPERS=y
+# CONFIG_FB_CIRRUS is not set
 # CONFIG_FB_PM2 is not set
 # CONFIG_FB_CYBER2000 is not set
 CONFIG_FB_OF=y
@@ -928,8 +959,8 @@
 CONFIG_FB_PLATINUM=y
 CONFIG_FB_VALKYRIE=y
 CONFIG_FB_CT65550=y
+# CONFIG_FB_ASILIANT is not set
 CONFIG_FB_IMSTT=y
-# CONFIG_FB_S3TRIO is not set
 # CONFIG_FB_VGA16 is not set
 # CONFIG_FB_RIVA is not set
 CONFIG_FB_MATROX=y
@@ -953,6 +984,7 @@
 # CONFIG_FB_NEOMAGIC is not set
 # CONFIG_FB_KYRO is not set
 CONFIG_FB_3DFX=y
+# CONFIG_FB_3DFX_ACCEL is not set
 # CONFIG_FB_VOODOO1 is not set
 # CONFIG_FB_TRIDENT is not set
 # CONFIG_FB_VIRTUAL is not set
@@ -961,10 +993,8 @@
 # Console display driver support
 #
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_MDA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_PCI_CONSOLE=y
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
@@ -1014,6 +1044,7 @@
 #
 # CONFIG_SND_ALI5451 is not set
 # CONFIG_SND_ATIIXP is not set
+# CONFIG_SND_ATIIXP_MODEM is not set
 # CONFIG_SND_AU8810 is not set
 # CONFIG_SND_AU8820 is not set
 # CONFIG_SND_AU8830 is not set
@@ -1056,6 +1087,7 @@
 # ALSA USB devices
 #
 CONFIG_SND_USB_AUDIO=m
+# CONFIG_SND_USB_USX2Y is not set
 
 #
 # PCMCIA devices
@@ -1078,6 +1110,8 @@
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_BANDWIDTH is not set
 CONFIG_USB_DYNAMIC_MINORS=y
+# CONFIG_USB_SUSPEND is not set
+# CONFIG_USB_OTG is not set
 
 #
 # USB Host Controller Drivers
@@ -1108,6 +1142,7 @@
 # CONFIG_USB_KBTAB is not set
 # CONFIG_USB_POWERMATE is not set
 # CONFIG_USB_MTOUCH is not set
+# CONFIG_USB_EGALAX is not set
 # CONFIG_USB_XPAD is not set
 # CONFIG_USB_ATI_REMOTE is not set
 
@@ -1178,6 +1213,7 @@
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGETSERVO is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1220,6 +1256,8 @@
 CONFIG_FAT_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -1267,6 +1305,7 @@
 CONFIG_EXPORTFS=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
 CONFIG_SMB_FS=m
 # CONFIG_SMB_NLS_DEFAULT is not set
 # CONFIG_CIFS is not set
@@ -1289,7 +1328,6 @@
 # CONFIG_SOLARIS_X86_PARTITION is not set
 # CONFIG_UNIXWARE_DISKLABEL is not set
 # CONFIG_LDM_PARTITION is not set
-# CONFIG_NEC98_PARTITION is not set
 # CONFIG_SGI_PARTITION is not set
 # CONFIG_ULTRIX_PARTITION is not set
 # CONFIG_SUN_PARTITION is not set
@@ -1323,6 +1361,7 @@
 # CONFIG_NLS_ISO8859_8 is not set
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
 CONFIG_NLS_ISO8859_1=m
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
@@ -1341,12 +1380,19 @@
 #
 # Library routines
 #
+CONFIG_CRC_CCITT=y
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
 
 #
+# Profiling support
+#
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=m
+
+#
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
diff -uNr linus-2.6.10/arch/ppc/kernel/cpu_setup_6xx.S sleep-2.6.10/arch/ppc/kernel/cpu_setup_6xx.S
--- linus-2.6.10/arch/ppc/kernel/cpu_setup_6xx.S	2005-01-06 10:47:26.580221608 +0000
+++ sleep-2.6.10/arch/ppc/kernel/cpu_setup_6xx.S	2005-01-06 11:38:47.307220544 +0000
@@ -292,13 +292,15 @@
 	cmplwi	cr2,r3,0x800c	/* 7410 */
 	cmplwi	cr3,r3,0x8001	/* 7455 */
 	cmplwi	cr4,r3,0x8002	/* 7457 */
-	cmplwi	cr5,r3,0x7000	/* 750FX */
+	cmplwi	cr5,r3,0x8003	/* 7447A */
+	cmplwi	cr6,r3,0x7000	/* 750FX */
 	/* cr1 is 7400 || 7410 */
 	cror	4*cr1+eq,4*cr1+eq,4*cr2+eq
 	/* cr0 is 74xx */
 	cror	4*cr0+eq,4*cr0+eq,4*cr3+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr4+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
+	cror	4*cr0+eq,4*cr0+eq,4*cr5+eq
 	bne	1f
 	/* Backup 74xx specific regs */
 	mfspr	r4,SPRN_MSSCR0
@@ -316,7 +318,7 @@
 	mfspr	r4,SPRN_LDSTDB
 	stw	r4,CS_LDSTDB(r5)
 1:
-	bne	cr5,1f
+	bne	cr6,1f
 	/* Backup 750FX specific registers */
 	mfspr	r4,SPRN_HID1
 	stw	r4,CS_HID1(r5)
@@ -359,13 +361,15 @@
 	cmplwi	cr2,r3,0x800c	/* 7410 */
 	cmplwi	cr3,r3,0x8001	/* 7455 */
 	cmplwi	cr4,r3,0x8002	/* 7457 */
-	cmplwi	cr5,r3,0x7000	/* 750FX */
+	cmplwi	cr5,r3,0x8003	/* 7447A */
+	cmplwi	cr6,r3,0x7000	/* 750FX */
 	/* cr1 is 7400 || 7410 */
 	cror	4*cr1+eq,4*cr1+eq,4*cr2+eq
 	/* cr0 is 74xx */
 	cror	4*cr0+eq,4*cr0+eq,4*cr3+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr4+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
+	cror	4*cr0+eq,4*cr0+eq,4*cr5+eq
 	bne	2f
 	/* Restore 74xx specific regs */
 	lwz	r4,CS_MSSCR0(r5)
@@ -404,7 +408,7 @@
 	mtspr	SPRN_LDSTDB,r4
 	isync
 	sync
-2:	bne	cr5,1f
+2:	bne	cr6,1f
 	/* Restore 750FX specific registers
 	 * that is restore HID2 on rev 2.x and PLL config & switch
 	 * to PLL 0 on all
diff -uNr linus-2.6.10/arch/ppc/kernel/l2cr.S sleep-2.6.10/arch/ppc/kernel/l2cr.S
--- linus-2.6.10/arch/ppc/kernel/l2cr.S	2005-01-06 10:48:03.613181696 +0000
+++ sleep-2.6.10/arch/ppc/kernel/l2cr.S	2005-01-06 11:39:08.412206712 +0000
@@ -45,6 +45,7 @@
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
 #include <asm/cache.h>
+#include <asm/page.h>
 
 /* Usage:
 
@@ -284,7 +285,7 @@
 	/* Tweak some bits */
 	rlwinm	r5,r3,0,0,0		/* r5 contains the new enable bit */
 	rlwinm	r3,r3,0,22,20		/* Turn off the invalidate bit */
-	rlwinm	r3,r3,0,1,31		/* Turn off the enable bit */
+	rlwinm	r3,r3,0,2,31		/* Turn off the enable & PE bits */
 	rlwinm	r3,r3,0,5,3		/* Turn off the clken bit */
 	/* Check to see if we need to flush */
 	rlwinm.	r4,r4,0,0,0
@@ -379,7 +380,7 @@
 /* flush_disable_L1()	- Flush and disable L1 cache
  *
  * clobbers r0, r3, ctr, cr0
- *
+ * Must be called with interrupts disabled and MMU enabled.
  */
 _GLOBAL(__flush_disable_L1)
 	/* Stop pending alitvec streams and memory accesses */
@@ -393,7 +394,7 @@
 	 */
 	li	r3,0x4000	/* 512kB / 32B */
 	mtctr	r3
-	li	r3, 0
+	lis	r3,KERNELBASE@h
 1:
 	lwz	r0,0(r3)
 	addi	r3,r3,0x0020	/* Go to start of next cache line */
@@ -404,7 +405,7 @@
 	/* Now flush those cache lines */
 	li	r3,0x4000	/* 512kB / 32B */
 	mtctr	r3
-	li	r3, 0
+	lis	r3,KERNELBASE@h
 1:
 	dcbf	0,r3
 	addi	r3,r3,0x0020	/* Go to start of next cache line */
diff -uNr linus-2.6.10/arch/ppc/platforms/Makefile sleep-2.6.10/arch/ppc/platforms/Makefile
--- linus-2.6.10/arch/ppc/platforms/Makefile	2005-01-06 10:48:54.706268184 +0000
+++ sleep-2.6.10/arch/ppc/platforms/Makefile	2005-01-06 11:39:26.692227976 +0000
@@ -11,7 +11,7 @@
 endif
 obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
 					pmac_feature.o pmac_pci.o pmac_sleep.o \
-					pmac_low_i2c.o
+					pmac_low_i2c.o pmac_cache.o
 obj-$(CONFIG_PPC_CHRP)		+= chrp_setup.o chrp_time.o chrp_pci.o
 obj-$(CONFIG_PPC_PREP)		+= prep_pci.o prep_setup.o
 ifeq ($(CONFIG_PPC_PMAC),y)
diff -uNr linus-2.6.10/arch/ppc/platforms/pmac_cache.S sleep-2.6.10/arch/ppc/platforms/pmac_cache.S
--- linus-2.6.10/arch/ppc/platforms/pmac_cache.S	1970-01-01 01:00:00.000000000 +0100
+++ sleep-2.6.10/arch/ppc/platforms/pmac_cache.S	2005-01-06 11:38:56.005229208 +0000
@@ -0,0 +1,314 @@
+/*
+ * This file contains low-level cache management functions
+ * used for sleep and CPU speed changes on Apple machines.
+ * (In fact the only thing that is Apple-specific is that we assume
+ * that we can read from ROM at physical address 0xfff00000.)
+ *
+ *    Copyright (C) 2004 Paul Mackerras (paulus@samba.org).
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+#include <asm/cputable.h>
+
+/*
+ * Flush and disable all data caches (dL1, L2, L3).
+ */
+_GLOBAL(flush_disable_caches)
+BEGIN_FTR_SECTION
+	b	flush_disable_745x
+END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
+BEGIN_FTR_SECTION
+	b	flush_disable_75x
+END_FTR_SECTION_IFSET(CPU_FTR_L2CR)
+	b	__flush_disable_L1
+
+/* This is the code for G3 and 74[01]0 */
+flush_disable_75x:
+	mflr	r10
+
+	/* Turn off EE and DR in MSR */
+	mfmsr	r11
+	rlwinm	r0,r11,0,~MSR_EE
+	rlwinm	r0,r0,0,~MSR_DR
+	sync
+	mtmsr	r0
+	isync
+
+	/* Stop DST streams */
+BEGIN_FTR_SECTION
+	DSSALL
+	sync
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+
+	/* Stop DPM */
+	mfspr	r8,SPRN_HID0		/* Save HID0 in r8 */
+	rlwinm	r4,r8,0,12,10		/* Turn off HID0[DPM] */
+	sync
+	mtspr	SPRN_HID0,r4		/* Disable DPM */
+	sync
+
+	/* disp-flush L1 */
+	li	r4,0x4000
+	mtctr	r4
+	lis	r4,0xfff0
+1:	lwzx	r0,r0,r4
+	addi	r4,r4,32
+	bdnz	1b
+	sync
+	isync
+	
+	/* disable / invalidate / enable L1 data */
+	mfspr	r3,SPRN_HID0
+	rlwinm	r0,r0,0,~HID0_DCE
+	mtspr	SPRN_HID0,r3
+	sync
+	isync
+	ori	r3,r3,HID0_DCE|HID0_DCI
+	sync
+	isync
+	mtspr	SPRN_HID0,r3
+	xori	r3,r3,HID0_DCI
+	mtspr	SPRN_HID0,r3
+	sync
+
+	/* Get the current enable bit of the L2CR into r4 */
+	mfspr	r5,L2CR
+	/* Set to data-only (pre-745x bit) */
+	oris	r3,r5,L2CR_L2DO@h
+	b	2f
+	/* When disabling L2, code must be in L1 */
+	.balign 32
+1:	mtspr	L2CR,r3
+3:	sync
+	isync
+	b	1f
+2:	b	3f
+3:	sync
+	isync
+	b	1b
+1:	/* disp-flush L2. The interesting thing here is that the L2 can be
+	 * up to 2Mb ... so using the ROM, we'll end up wrapping back to memory
+	 * but that is probbaly fine. We disp-flush over 4Mb to be safe
+	 */
+	lis	r4,2
+	mtctr	r4
+	lis	r4,0xfff0
+1:	lwzx	r0,r0,r4
+	addi	r4,r4,32
+	bdnz	1b
+	sync
+	isync
+	/* now disable L2 */	
+	rlwinm	r5,r5,0,~L2CR_L2E
+	b	2f
+	/* When disabling L2, code must be in L1 */
+	.balign 32
+1:	mtspr	L2CR,r5
+3:	sync
+	isync
+	b	1f
+2:	b	3f
+3:	sync
+	isync
+	b	1b
+1:	sync
+	isync
+	/* Invalidate L2. This is pre-745x, we clear the L2I bit ourselves */
+	oris	r4,r5,L2CR_L2I@h
+	mtspr	L2CR,r4
+	sync
+	isync
+	xoris	r4,r4,L2CR_L2I@h
+	sync
+	mtspr	L2CR,r4
+	sync
+	
+	/* now disable the L1 data cache */
+	mfspr	r0,HID0
+	rlwinm	r0,r0,0,~HID0_DCE
+	mtspr	HID0,r0
+	sync
+	isync
+
+	/* Restore HID0[DPM] to whatever it was before */
+	sync
+	mtspr	SPRN_HID0,r8
+	sync
+
+	/* restore DR and EE */
+	sync
+	mtmsr	r11
+	isync
+
+	mtlr	r10
+	blr
+
+/* This code is for 745x processors */
+flush_disable_745x:
+	/* Turn off EE and DR in MSR */
+	mfmsr	r11
+	rlwinm	r0,r11,0,~MSR_EE
+	rlwinm	r0,r0,0,~MSR_DR
+	sync
+	mtmsr	r0
+	isync
+
+	/* Stop prefetch streams */
+	DSSALL
+	sync
+
+	/* Disable L2 prefetching */
+	mfspr	r0,SPRN_MSSCR0
+	rlwinm	r0,r0,0,0,29
+	mtspr	SPRN_MSSCR0,r0
+	sync
+	isync
+	lis	r4,0
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+
+#if 1	
+        lis     r4,0x0002
+        mtctr   r4
+ 	li      r4,0
+1:
+        lwzx    r0,r0,r4
+        addi    r4,r4,32                /* Go to start of next cache line */
+        bdnz    1b
+        isync
+
+        /* Now, flush the first 4MB of memory */
+        lis     r4,0x0002
+        mtctr   r4
+	li      r4,0
+        sync
+1:
+        dcbf    0,r4
+        addi    r4,r4,32                /* Go to start of next cache line */
+        bdnz    1b
+#endif
+
+	/* Flush and disable the L1 data cache */
+	mfspr	r6,SPRN_LDSTCR
+	lis	r3,0xfff0	/* read from ROM for displacement flush */
+	li	r4,0xfe		/* start with only way 0 unlocked */
+	li	r5,128		/* 128 lines in each way */
+1:	mtctr	r5
+	rlwimi	r6,r4,0,24,31
+	mtspr	SPRN_LDSTCR,r6
+	sync
+	isync
+2:	lwz	r0,0(r3)	/* touch each cache line */
+	addi	r3,r3,32
+	bdnz	2b
+	rlwinm	r4,r4,1,24,30	/* move on to the next way */
+	ori	r4,r4,1
+	cmpwi	r4,0xff		/* all done? */
+	bne	1b
+	/* now unlock the L1 data cache */
+	li	r4,0
+	rlwimi	r6,r4,0,24,31
+	sync
+	mtspr	SPRN_LDSTCR,r6
+	sync
+	isync
+
+	/* Flush the L2 cache using the hardware assist */
+	mfspr	r3,L2CR
+	cmpwi	r3,0		/* check if it is enabled first */
+	bge	4f
+	oris	r0,r3,(L2CR_L2IO_745x|L2CR_L2DO_745x)@h
+	b	2f
+	/* When disabling/locking L2, code must be in L1 */
+	.balign 32
+1:	mtspr	L2CR,r0		/* lock the L2 cache */
+3:	sync
+	isync
+	b	1f
+2:	b	3f
+3:	sync
+	isync
+	b	1b
+1:	sync
+	isync
+	ori	r0,r3,L2CR_L2HWF_745x
+	sync
+	mtspr	L2CR,r0		/* set the hardware flush bit */
+3:	mfspr	r0,L2CR		/* wait for it to go to 0 */
+	andi.	r0,r0,L2CR_L2HWF_745x
+	bne	3b
+	sync
+	rlwinm	r3,r3,0,~L2CR_L2E
+	b	2f
+	/* When disabling L2, code must be in L1 */
+	.balign 32
+1:	mtspr	L2CR,r3		/* disable the L2 cache */
+3:	sync
+	isync
+	b	1f
+2:	b	3f
+3:	sync
+	isync
+	b	1b
+1:	sync
+	isync
+	oris	r4,r3,L2CR_L2I@h
+	mtspr	L2CR,r4
+	sync
+	isync
+1:	mfspr	r4,L2CR
+	andis.	r0,r4,L2CR_L2I@h
+	bne	1b
+	sync
+
+BEGIN_FTR_SECTION
+	/* Flush the L3 cache using the hardware assist */
+4:	mfspr	r3,L3CR
+	cmpwi	r3,0		/* check if it is enabled */
+	bge	6f
+	oris	r0,r3,L3CR_L3IO@h
+	ori	r0,r0,L3CR_L3DO
+	sync
+	mtspr	L3CR,r0		/* lock the L3 cache */
+	sync
+	isync
+	ori	r0,r0,L3CR_L3HWF
+	sync
+	mtspr	L3CR,r0		/* set the hardware flush bit */
+5:	mfspr	r0,L3CR		/* wait for it to go to zero */
+	andi.	r0,r0,L3CR_L3HWF
+	bne	5b
+	rlwinm	r3,r3,0,~L3CR_L3E
+	sync
+	mtspr	L3CR,r3		/* disable the L3 cache */
+	sync
+	ori	r4,r3,L3CR_L3I
+	mtspr	SPRN_L3CR,r4
+1:	mfspr	r4,SPRN_L3CR
+	andi.	r0,r4,L3CR_L3I
+	bne	1b
+	sync
+END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
+
+6:	mfspr	r0,HID0		/* now disable the L1 data cache */
+	rlwinm	r0,r0,0,~HID0_DCE
+	mtspr	HID0,r0
+	sync
+	isync
+	mtmsr	r11		/* restore DR and EE */
+	isync
+	blr
diff -uNr linus-2.6.10/arch/ppc/platforms/pmac_cpufreq.c sleep-2.6.10/arch/ppc/platforms/pmac_cpufreq.c
--- linus-2.6.10/arch/ppc/platforms/pmac_cpufreq.c	2005-01-06 10:48:03.701168320 +0000
+++ sleep-2.6.10/arch/ppc/platforms/pmac_cpufreq.c	2005-01-06 11:39:08.531188624 +0000
@@ -154,6 +154,14 @@
 	return 0;
 }
 
+static unsigned int __pmac dfs_get_cpu_speed(unsigned int cpu)
+{
+	if (mfspr(HID1) & HID1_DFS)
+		return low_freq;
+	else
+		return hi_freq;
+}
+
 
 /* Switch CPU speed using slewing GPIOs
  */
@@ -229,10 +237,6 @@
 	/* Save & disable L2 and L3 caches */
 	save_l3cr = _get_L3CR();	/* (returns -1 if not available) */
 	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
-	if (save_l3cr != 0xffffffff && (save_l3cr & L3CR_L3E) != 0)
-		_set_L3CR(save_l3cr & 0x7fffffff);
-	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
-		_set_L2CR(save_l2cr & 0x7fffffff);
 
 	/* Send the new speed command. My assumption is that this command
 	 * will cause PLL_CFG[0..3] to be changed next time CPU goes to sleep
@@ -458,14 +462,13 @@
 {
 	struct device_node *volt_gpio_np;
 	u32 *reg;
+	struct cpufreq_driver *driver = &pmac_cpufreq_driver;
 
 	/* OF only reports the high frequency */
 	hi_freq = cur_freq;
 	low_freq = cur_freq/2;
-	if (mfspr(HID1) & HID1_DFS)
-		cur_freq = low_freq;
-	else
-		cur_freq = hi_freq;
+	driver->get = dfs_get_cpu_speed;
+	cur_freq = driver->get(0);
 
 	volt_gpio_np = of_find_node_by_name(NULL, "cpu-vcore-select");
 	if (!volt_gpio_np){
diff -uNr linus-2.6.10/arch/ppc/platforms/pmac_feature.c sleep-2.6.10/arch/ppc/platforms/pmac_feature.c
--- linus-2.6.10/arch/ppc/platforms/pmac_feature.c	2005-01-06 10:48:40.778256720 +0000
+++ sleep-2.6.10/arch/ppc/platforms/pmac_feature.c	2005-01-06 11:39:21.767171968 +0000
@@ -1177,6 +1177,39 @@
 			(void)MACIO_IN32(KEYLARGO_FCR3);
 			udelay(10);
 		}
+		if (macio->type == macio_intrepid) {
+			/* wait for clock stopped bits to clear */
+			u32 test0 = 0, test1 = 0;
+			u32 status0, status1;
+			int timeout = 1000;
+
+			UNLOCK(flags);
+			switch (number) {
+			case 0:
+				test0 = UNI_N_CLOCK_STOPPED_USB0;
+				test1 = UNI_N_CLOCK_STOPPED_USB0PCI;
+				break;
+			case 2:
+				test0 = UNI_N_CLOCK_STOPPED_USB1;
+				test1 = UNI_N_CLOCK_STOPPED_USB1PCI;
+				break;
+			case 4:
+				test0 = UNI_N_CLOCK_STOPPED_USB2;
+				test1 = UNI_N_CLOCK_STOPPED_USB2PCI;
+				break;
+			}
+			do {
+				if (--timeout <= 0) {
+					printk(KERN_ERR "core99_usb_enable: "
+					       "Timeout waiting for clocks\n");
+					break;
+				}
+				mdelay(1);
+				status0 = UN_IN(UNI_N_CLOCK_STOP_STATUS0);
+				status1 = UN_IN(UNI_N_CLOCK_STOP_STATUS1);
+			} while ((status0 & test0) | (status1 & test1));
+			LOCK(flags);
+		}
 	} else {
 		/* Turn OFF */
 		if (number < 4) {
@@ -1199,20 +1232,20 @@
 			udelay(1);
 		}
 		if (number == 0) {
-			MACIO_BIC(KEYLARGO_FCR0, KL0_USB0_CELL_ENABLE);
+			if (macio->type != macio_intrepid)
+				MACIO_BIC(KEYLARGO_FCR0, KL0_USB0_CELL_ENABLE);
 			(void)MACIO_IN32(KEYLARGO_FCR0);
 			udelay(1);
 			MACIO_BIS(KEYLARGO_FCR0, (KL0_USB0_PAD_SUSPEND0 | KL0_USB0_PAD_SUSPEND1));
 			(void)MACIO_IN32(KEYLARGO_FCR0);
 		} else if (number == 2) {
-			MACIO_BIC(KEYLARGO_FCR0, KL0_USB1_CELL_ENABLE);
+			if (macio->type != macio_intrepid)
+				MACIO_BIC(KEYLARGO_FCR0, KL0_USB1_CELL_ENABLE);
 			(void)MACIO_IN32(KEYLARGO_FCR0);
 			udelay(1);
 			MACIO_BIS(KEYLARGO_FCR0, (KL0_USB1_PAD_SUSPEND0 | KL0_USB1_PAD_SUSPEND1));
 			(void)MACIO_IN32(KEYLARGO_FCR0);
 		} else if (number == 4) {
-			MACIO_BIC(KEYLARGO_FCR1, KL1_USB2_CELL_ENABLE);
-			(void)MACIO_IN32(KEYLARGO_FCR1);
 			udelay(1);
 			MACIO_BIS(KEYLARGO_FCR1, (KL1_USB2_PAD_SUSPEND0 | KL1_USB2_PAD_SUSPEND1));
 			(void)MACIO_IN32(KEYLARGO_FCR1);
@@ -1554,22 +1587,17 @@
 	u32 temp;
 
 	MACIO_BIC(KEYLARGO_FCR0,KL0_SCCA_ENABLE | KL0_SCCB_ENABLE |
-				KL0_SCC_CELL_ENABLE |
-				KL0_USB0_CELL_ENABLE | KL0_USB1_CELL_ENABLE);
+		  KL0_SCC_CELL_ENABLE);
 
 	MACIO_BIC(KEYLARGO_FCR1,
-		KL1_USB2_CELL_ENABLE |
+		  /*KL1_USB2_CELL_ENABLE |*/
 		KL1_I2S0_CELL_ENABLE | KL1_I2S0_CLK_ENABLE_BIT |
 		KL1_I2S0_ENABLE | KL1_I2S1_CELL_ENABLE |
 		KL1_I2S1_CLK_ENABLE_BIT | KL1_I2S1_ENABLE);
 	if (pmac_mb.board_flags & PMAC_MB_MOBILE)
 		MACIO_BIC(KEYLARGO_FCR1, KL1_UIDE_RESET_N);
 
-	MACIO_BIS(KEYLARGO_FCR2, KL2_ALT_DATA_OUT);
-
 	temp = MACIO_IN32(KEYLARGO_FCR3);
-	temp |= KL3_IT_SHUTDOWN_PLL1 | KL3_IT_SHUTDOWN_PLL2 |
-		KL3_IT_SHUTDOWN_PLL3;
 	temp &= ~(KL3_CLK49_ENABLE | KL3_CLK45_ENABLE |
 		  KL3_I2S1_CLK18_ENABLE | KL3_I2S0_CLK18_ENABLE);
 	if (sleep_mode)
@@ -1577,7 +1605,8 @@
 	MACIO_OUT32(KEYLARGO_FCR3, temp);
 
 	/* Flush posted writes & wait a bit */
-	(void)MACIO_IN32(KEYLARGO_FCR0); mdelay(1);
+	(void)MACIO_IN32(KEYLARGO_FCR0);
+	mdelay(10);
 }
 
 static int __pmac
@@ -1591,6 +1620,12 @@
 	    macio->type != macio_intrepid)
 		return -ENODEV;
 
+	/* The device-tree contains that in the hwclock node */
+	if (macio->type == macio_intrepid) {
+		UN_OUT(UNI_N_CLOCK_SPREADING, 0);
+		mdelay(40);
+	}
+
 	/* We power off the wireless slot in case it was not done
 	 * by the driver. We don't power it on automatically however
 	 */
@@ -1653,11 +1688,15 @@
 	 */
 
 	save_unin_clock_ctl = UN_IN(UNI_N_CLOCK_CNTL);
+	/* Note: do not switch GMAC off, driver does it when necessary, WOL must keep it
+	 * enabled !
+	 */
 	UN_OUT(UNI_N_CLOCK_CNTL, save_unin_clock_ctl &
-		~(UNI_N_CLOCK_CNTL_GMAC|UNI_N_CLOCK_CNTL_FW/*|UNI_N_CLOCK_CNTL_PCI*/));
+	       ~(/*UNI_N_CLOCK_CNTL_GMAC|*/UNI_N_CLOCK_CNTL_FW/*|UNI_N_CLOCK_CNTL_PCI*/));
 	udelay(100);
 	UN_OUT(UNI_N_HWINIT_STATE, UNI_N_HWINIT_STATE_SLEEPING);
 	UN_OUT(UNI_N_POWER_MGT, UNI_N_POWER_MGT_SLEEP);
+	mdelay(10);
 
 	/*
 	 * FIXME: A bit of black magic with OpenPIC (don't ask me why)
@@ -1729,6 +1768,12 @@
 	UN_OUT(UNI_N_CLOCK_CNTL, save_unin_clock_ctl);
 	udelay(100);
 
+	/* Restore clock spreading */
+	if (macio->type == macio_intrepid) {
+		UN_OUT(UNI_N_CLOCK_SPREADING, 2);
+		mdelay(40);
+	}
+
 	return 0;
 }
 
@@ -1752,6 +1797,33 @@
 	}
 	if ((pmac_mb.board_flags & PMAC_MB_CAN_SLEEP) == 0)
 		return -EPERM;
+
+#ifdef CONFIG_CPU_FREQ_PMAC
+	/* XXX should be elsewhere */
+	if (machine_is_compatible("PowerBook6,5") ||
+	    machine_is_compatible("PowerBook6,4") ||
+	    machine_is_compatible("PowerBook5,5") ||
+	    machine_is_compatible("PowerBook5,4")) {
+		struct device_node *volt_gpio_np;
+		u32 *reg = NULL;
+
+		volt_gpio_np = of_find_node_by_name(NULL, "cpu-vcore-select");
+		if (volt_gpio_np != NULL)
+			reg = (u32 *)get_property(volt_gpio_np, "reg", NULL);
+		if (reg != NULL) {
+			/* Set the CPU voltage high if sleeping */
+			if (value == 1) {
+				pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL,
+						  *reg, 0x05);
+			} else if (value == 0 && (mfspr(HID1) & HID1_DFS)) {
+				pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL,
+						  *reg, 0x04);
+			}
+			mdelay(2);
+		}
+	}
+#endif /* CONFIG_CPU_FREQ_PMAC */
+
 	if (value == 1)
 		return core99_sleep();
 	else if (value == 0)
@@ -1762,6 +1834,18 @@
 #endif /* CONFIG_POWER4 */
 
 static long __pmac
+generic_dev_can_wake(struct device_node* node, long param, long value)
+{
+	/* Todo: eventually check we are really dealing with on-board
+	 * video device ...
+	 */
+
+	if (pmac_mb.board_flags & PMAC_MB_MAY_SLEEP)
+		pmac_mb.board_flags |= PMAC_MB_CAN_SLEEP;
+	return 0;
+}
+
+static long __pmac
 generic_get_mb_info(struct device_node* node, long param, long value)
 {
 	switch(param) {
@@ -1786,6 +1870,7 @@
  */
 static struct feature_table_entry any_features[]  __pmacdata = {
 	{ PMAC_FTR_GET_MB_INFO,		generic_get_mb_info },
+	{ PMAC_FTR_DEVICE_CAN_WAKE,	generic_dev_can_wake },
 	{ 0, NULL }
 };
 
@@ -2014,7 +2099,7 @@
 	},
 	{	"PowerBook1,1",			"PowerBook 101 (Lombard)",
 		PMAC_TYPE_101_PBOOK,		paddington_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_MOBILE
 	},
 	{	"iMac,1",			"iMac (first generation)",
 		PMAC_TYPE_ORIG_IMAC,		paddington_features,
@@ -2022,23 +2107,23 @@
 	},
 	{	"PowerMac4,1",			"iMac \"Flower Power\"",
 		PMAC_TYPE_PANGEA_IMAC,		pangea_features,
-		PMAC_MB_CAN_SLEEP
+		PMAC_MB_MAY_SLEEP
 	},
 	{	"PowerBook4,3",			"iBook 2 rev. 2",
 		PMAC_TYPE_IBOOK2,		pangea_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"PowerBook4,2",			"iBook 2",
 		PMAC_TYPE_IBOOK2,		pangea_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"PowerBook4,1",			"iBook 2",
 		PMAC_TYPE_IBOOK2,		pangea_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"PowerMac4,4",			"eMac",
 		PMAC_TYPE_EMAC,			core99_features,
-		PMAC_MB_CAN_SLEEP
+		PMAC_MB_MAY_SLEEP
 	},
 	{	"PowerMac4,2",			"Flat panel iMac",
 		PMAC_TYPE_FLAT_PANEL_IMAC,	pangea_features,
@@ -2062,55 +2147,57 @@
 	},
 	{	"PowerMac3,2",			"PowerMac G4 AGP Graphics",
 		PMAC_TYPE_SAWTOOTH,		core99_features,
-		PMAC_MB_OLD_CORE99
+		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
 	},
 	{	"PowerMac3,3",			"PowerMac G4 AGP Graphics",
 		PMAC_TYPE_SAWTOOTH,		core99_features,
-		PMAC_MB_OLD_CORE99
+		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
 	},
 	{	"PowerMac2,1",			"iMac FireWire",
 		PMAC_TYPE_FW_IMAC,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_OLD_CORE99
+		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
 	},
 	{	"PowerMac2,2",			"iMac FireWire",
 		PMAC_TYPE_FW_IMAC,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_OLD_CORE99
+		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
 	},
 	{	"PowerBook2,2",			"iBook FireWire",
 		PMAC_TYPE_FW_IBOOK,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_OLD_CORE99 | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER |
+		PMAC_MB_OLD_CORE99 | PMAC_MB_MOBILE
 	},
 	{	"PowerMac5,1",			"PowerMac G4 Cube",
 		PMAC_TYPE_CUBE,			core99_features,
-		PMAC_MB_OLD_CORE99
+		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
 	},
 	{	"PowerMac3,4",			"PowerMac G4 Silver",
 		PMAC_TYPE_QUICKSILVER,		core99_features,
-		0
+		PMAC_MB_MAY_SLEEP
 	},
 	{	"PowerMac3,5",			"PowerMac G4 Silver",
 		PMAC_TYPE_QUICKSILVER,		core99_features,
-		0
+		PMAC_MB_MAY_SLEEP
 	},
 	{	"PowerBook3,1",			"PowerBook Pismo",
 		PMAC_TYPE_PISMO,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_OLD_CORE99 | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER |
+		PMAC_MB_OLD_CORE99 | PMAC_MB_MOBILE
 	},
 	{	"PowerBook3,2",			"PowerBook Titanium",
 		PMAC_TYPE_TITANIUM,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"PowerBook3,3",			"PowerBook Titanium II",
 		PMAC_TYPE_TITANIUM2,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"PowerBook3,4",			"PowerBook Titanium III",
 		PMAC_TYPE_TITANIUM3,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"PowerBook3,5",			"PowerBook Titanium IV",
 		PMAC_TYPE_TITANIUM4,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"RackMac1,1",			"XServe",
 		PMAC_TYPE_RACKMAC,		rackmac_features,
@@ -2122,7 +2209,7 @@
 	},
 	{	"PowerMac3,6",			"PowerMac G4 Windtunnel",
 		PMAC_TYPE_WINDTUNNEL,		core99_features,
-		0,
+		PMAC_MB_MAY_SLEEP,
 	},
 	{	"PowerBook5,1",			"PowerBook G4 17\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
@@ -2130,39 +2217,39 @@
 	},
 	{	"PowerBook5,2",			"PowerBook G4 15\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook5,3",			"PowerBook G4 17\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook5,4",			"PowerBook G4 15\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook5,5",			"PowerBook G4 17\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook6,1",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook6,2",			"PowerBook G4",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook6,3",			"iBook G4",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook6,4",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook6,5",			"iBook G4",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 #else /* CONFIG_POWER4 */
 	{	"PowerMac7,2",			"PowerMac G5",
@@ -2839,3 +2926,27 @@
 }
 
 #endif /* CONFIG_POWER4 */
+
+/*
+ * Early video resume hook
+ */
+
+static void (*pmac_early_vresume_proc)(void *data) __pmacdata;
+static void *pmac_early_vresume_data __pmacdata;
+
+void pmac_set_early_video_resume(void (*proc)(void *data), void *data)
+{
+	if (_machine != _MACH_Pmac)
+		return;
+	preempt_disable();
+	pmac_early_vresume_proc = proc;
+	pmac_early_vresume_data = data;
+	preempt_enable();
+}
+EXPORT_SYMBOL(pmac_set_early_video_resume);
+
+void __pmac pmac_call_early_video_resume(void)
+{
+	if (pmac_early_vresume_proc)
+		pmac_early_vresume_proc(pmac_early_vresume_data);
+}
diff -uNr linus-2.6.10/arch/ppc/platforms/pmac_pci.c sleep-2.6.10/arch/ppc/platforms/pmac_pci.c
--- linus-2.6.10/arch/ppc/platforms/pmac_pci.c	2005-01-06 10:47:54.576224408 +0000
+++ sleep-2.6.10/arch/ppc/platforms/pmac_pci.c	2005-01-06 11:39:05.730215072 +0000
@@ -919,8 +919,12 @@
 	 * (iBook second controller)
 	 */
 	if (dev->vendor == PCI_VENDOR_ID_APPLE
-	    && dev->device == PCI_DEVICE_ID_APPLE_KL_USB && !node)
+	    && (dev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x10))
+	    && !node) {
+		printk(KERN_INFO "Apple USB OHCI %s disabled by firmware\n",
+		       pci_name(dev));
 		return -EINVAL;
+	}
 
 	if (!node)
 		return 0;
diff -uNr linus-2.6.10/arch/ppc/platforms/pmac_sleep.S sleep-2.6.10/arch/ppc/platforms/pmac_sleep.S
--- linus-2.6.10/arch/ppc/platforms/pmac_sleep.S	2005-01-06 10:47:25.406270904 +0000
+++ sleep-2.6.10/arch/ppc/platforms/pmac_sleep.S	2005-01-06 11:38:43.111196576 +0000
@@ -161,12 +161,8 @@
 	addi r3,r3,sleep_storage@l
 	stw r5,0(r3)
 
-	/* Disable DPM during cache flush */
-	mfspr	r3, SPRN_HID0
-	rlwinm	r3,r3,0,12,10
-	sync
-	mtspr	SPRN_HID0,r3
-	sync
+	/* Flush & disable all caches */
+	bl	flush_disable_caches
 
 	/* Turn off data relocation. */
 	mfmsr	r3		/* Save MSR in r7 */
@@ -175,8 +171,13 @@
 	mtmsr	r3
 	isync
 
-	/* Flush & disable L1 cache */
-	bl	__flush_disable_L1
+BEGIN_FTR_SECTION
+	/* Flush any pending L2 data prefetches to work around HW bug */
+	sync
+	lis	r3,0xfff0
+	lwz	r0,0(r3)	/* perform cache-inhibited load to ROM */
+	sync			/* (caches are disabled at this point) */
+END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
 
 /*
  * Set the HID0 and MSR for sleep.
diff -uNr linus-2.6.10/drivers/macintosh/via-pmu.c sleep-2.6.10/drivers/macintosh/via-pmu.c
--- linus-2.6.10/drivers/macintosh/via-pmu.c	2005-01-06 10:48:31.637181088 +0000
+++ sleep-2.6.10/drivers/macintosh/via-pmu.c	2005-01-06 11:39:19.209298480 +0000
@@ -45,6 +45,7 @@
 #include <linux/device.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
+#include <linux/cpu.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -152,7 +153,6 @@
 #ifdef CONFIG_PMAC_PBOOK
 static int option_lid_wakeup = 1;
 static int sleep_in_progress;
-static int can_sleep;
 #endif /* CONFIG_PMAC_PBOOK */
 static unsigned long async_req_locks;
 static unsigned int pmu_irq_stats[11];
@@ -406,8 +406,6 @@
 	bright_req_2.complete = 1;
 #ifdef CONFIG_PMAC_PBOOK
 	batt_req.complete = 1;
-	if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
-		can_sleep = 1;
 #endif
 
 	if (request_irq(vias->intrs[0].line, via_pmu_interrupt, 0, "VIA-PMU",
@@ -885,7 +883,8 @@
 	char *p = page;
 
 #ifdef CONFIG_PMAC_PBOOK
-	if (pmu_kind == PMU_KEYLARGO_BASED && can_sleep)
+	if (pmu_kind == PMU_KEYLARGO_BASED &&
+	    pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
 		p += sprintf(p, "lid_wakeup=%d\n", option_lid_wakeup);
 #endif /* CONFIG_PMAC_PBOOK */
 	if (pmu_kind == PMU_KEYLARGO_BASED)
@@ -925,7 +924,8 @@
 	while(*val == ' ')
 		val++;
 #ifdef CONFIG_PMAC_PBOOK
-	if (pmu_kind == PMU_KEYLARGO_BASED && can_sleep)
+	if (pmu_kind == PMU_KEYLARGO_BASED && 
+	    pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
 		if (!strcmp(label, "lid_wakeup"))
 			option_lid_wakeup = ((*val) == '1');
 #endif /* CONFIG_PMAC_PBOOK */
@@ -2313,7 +2313,7 @@
 pmac_suspend_devices(void)
 {
 	int ret;
-	
+
 	pm_prepare_console();
 	
 	/* Notify old-style device drivers & userland */
@@ -2341,13 +2341,13 @@
 	/* Send suspend call to devices, hold the device core's dpm_sem */
 	ret = device_suspend(PM_SUSPEND_MEM);
 	if (ret) {
-		printk(KERN_ERR "Driver sleep failed\n");
 		broadcast_wake();
+		printk(KERN_ERR "Driver sleep failed\n");
 		return -EBUSY;
 	}
-	
+
 	preempt_disable();
-	
+
 	/* Make sure the decrementer won't interrupt us */
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
 	/* Make sure any pending DEC interrupt occurring while we did
@@ -2404,8 +2404,6 @@
 	/* Power back up system devices (including the PIC) */
 	device_power_up();
 
-	pmu_blink(1);
-
 	/* Force a poll of ADB interrupts */
 	adb_int_pending = 1;
 	via_pmu_interrupt(0, NULL, NULL);
@@ -2416,7 +2414,7 @@
 	/* Re-enable local CPU interrupts */
 	local_irq_enable();
 
-	pmu_blink(1);
+	mdelay(100);
 
 	preempt_enable();
 
@@ -2464,8 +2462,6 @@
 
 	/* For 750, save backside cache setting and disable it */
 	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
-	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
-		_set_L2CR(save_l2cr & 0x7fffffff);
 
 	if (!__fake_sleep) {
 		/* Ask the PMU to put us to sleep */
@@ -2530,17 +2526,22 @@
 	struct adb_request req;
 	int ret;
 	
-	if (!can_sleep) {
+	if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0) {
 		printk(KERN_ERR "Sleep mode not supported on this machine\n");
 		return -ENOSYS;
 	}
-	
+
+	if (num_online_cpus() > 1 || cpu_is_offline(0))
+		return -EAGAIN;
+
 	ret = pmac_suspend_devices();
 	if (ret) {
 		printk(KERN_ERR "Sleep rejected by devices\n");
 		return ret;
 	}
-	
+
+	printk(KERN_DEBUG "HID1, before: %x\n", mfspr(SPRN_HID1));
+
 	/* Tell PMU what events will wake us up */
 	pmu_request(&req, NULL, 4, PMU_POWER_EVENTS, PMU_PWR_CLR_WAKEUP_EVENTS,
 		0xff, 0xff);
@@ -2550,16 +2551,9 @@
 		(option_lid_wakeup ? PMU_PWR_WAKEUP_LID_OPEN : 0));
 	pmu_wait_complete(&req);
 
-	/* Save & disable L2 and L3 caches*/
+	/* Save the state of the L2 and L3 caches */
 	save_l3cr = _get_L3CR();	/* (returns -1 if not available) */
 	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
-	if (save_l3cr != 0xffffffff && (save_l3cr & L3CR_L3E) != 0)
-		_set_L3CR(save_l3cr & 0x7fffffff);
-	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
-		_set_L2CR(save_l2cr & 0x7fffffff);
-
-	/* Save the state of PCI config space for some slots */
-	//pbook_pci_save();
 
 	if (!__fake_sleep) {
 		/* Ask the PMU to put us to sleep */
@@ -2574,7 +2568,7 @@
 	 * talk to the PMU after this, so I moved it to _after_ sending the
 	 * sleep command to it. Still need to be checked.
 	 */
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,1);
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 1);
 
 	/* Call low-level ASM sleep handler */
 	if (__fake_sleep)
@@ -2583,18 +2577,13 @@
 		low_sleep_handler();
 
 	/* Restore Apple core ASICs state */
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,0);
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 0);
 
 	/* Restore VIA */
 	restore_via_state();
 
-	/* Restore PCI config space. This should be overridable by PCI device
-	 * drivers as some of them may need special restore code. That's yet
-	 * another issue that should be handled by the common code properly,
-	 * maybe one day ?
-	 */
-	/* Don't restore PCI for now, it crashes. Maybe unnecessary on pbook */
-	//pbook_pci_restore();
+	/* Restore video */
+	pmac_call_early_video_resume();
 
 	/* Restore L2 cache */
 	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
@@ -2615,6 +2604,8 @@
 
 	pmu_blink(1);
 
+	printk(KERN_DEBUG "HID1, after: %x\n", mfspr(SPRN_HID1));
+
 	pmac_wakeup_devices();
 
 	return 0;
@@ -2909,7 +2900,10 @@
 		sleep_in_progress = 0;
 		return error;
 	case PMU_IOC_CAN_SLEEP:
-		return put_user((u32)can_sleep, argp);
+		if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0)
+			return put_user(0, argp);
+		else
+			return put_user(1, argp);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	/* Backlight should have its own device or go via
diff -uNr linus-2.6.10/drivers/net/sungem.c sleep-2.6.10/drivers/net/sungem.c
--- linus-2.6.10/drivers/net/sungem.c	2005-01-06 10:48:42.025199328 +0000
+++ sleep-2.6.10/drivers/net/sungem.c	2005-01-06 11:39:22.556187040 +0000
@@ -10,9 +10,24 @@
  * (C) 2004 by Eric Lemoine (eric.lemoine@gmail.com)
  * 
  * TODO: 
- *  - Get rid of all those nasty mdelay's and replace them
- * with schedule_timeout.
- *  - Implement WOL
+ *  - Now that the driver was significantly simplified, I need to rework
+ *    the locking. I'm sure we don't need _2_ spinlocks, and we probably
+ *    can avoid taking most of them for so long period of time (and schedule
+ *    instead). The main issues at this point are caused by the netdev layer
+ *    though:
+ *    
+ *    gem_change_mtu() and gem_set_multicast() are called with a read_lock()
+ *    help by net/core/dev.c, thus they can't schedule. That means they can't
+ *    call netif_poll_disable() neither, thus force gem_poll() to keep a spinlock
+ *    where it could have been dropped. change_mtu especially would love also to
+ *    be able to msleep instead of horrid locked delays when resetting the HW,
+ *    but that read_lock() makes it impossible, unless I defer it's action to
+ *    the reset task, which means it'll be asynchronous (won't take effect until
+ *    the system schedules a bit).
+ *
+ *    Also, it would probably be possible to also remove most of the long-life
+ *    locking in open/resume code path (gem_reinit_chip) by beeing more careful
+ *    about when we can start taking interrupts or get xmit() called...
  */
 
 #include <linux/module.h>
@@ -196,6 +211,29 @@
 	writel(GREG_STAT_NAPI | GREG_STAT_TXDONE, gp->regs + GREG_IMASK);
 }
 
+static void gem_get_cell(struct gem *gp)
+{
+	gp->cell_enabled++;
+#ifdef CONFIG_PPC_PMAC
+	if (gp->cell_enabled == 1) {
+		mb();
+		pmac_call_feature(PMAC_FTR_GMAC_ENABLE, gp->of_node, 0, 1);
+		udelay(10);
+	}
+#endif /* CONFIG_PPC_PMAC */
+}
+
+/* Turn off the chip's clock */
+static void gem_put_cell(struct gem *gp)
+{
+	gp->cell_enabled--;
+	BUG_ON(gp->cell_enabled < 0);
+#ifdef CONFIG_PPC_PMAC
+	if (gp->cell_enabled == 0)
+		pmac_call_feature(PMAC_FTR_GMAC_ENABLE, gp->of_node, 0, 0);
+#endif /* CONFIG_PPC_PMAC */
+}
+
 static void gem_handle_mif_event(struct gem *gp, u32 reg_val, u32 changed_bits)
 {
 	if (netif_msg_intr(gp))
@@ -597,7 +635,7 @@
 	return 0;
 
 do_reset:
-	gp->reset_task_pending = 2;
+	gp->reset_task_pending = 1;
 	schedule_work(&gp->reset_task);
 
 	return 1;
@@ -823,6 +861,9 @@
 	struct gem *gp = dev->priv;
 	unsigned long flags;
 
+	/*
+	 * NAPI locking nightmare: See comment at head of driver 
+	 */
 	spin_lock_irqsave(&gp->lock, flags);
 
 	do {
@@ -874,8 +915,11 @@
 	struct gem *gp = dev->priv;
 	unsigned long flags;
 
-	/* Swallow interrupts when shutting the chip down */
-	if (!gp->hw_running)
+	/* Swallow interrupts when shutting the chip down, though
+	 * that shouldn't happen, we should have done free_irq() at
+	 * this point...
+	 */
+	if (!gp->running)
 		return IRQ_HANDLED;
 
 	spin_lock_irqsave(&gp->lock, flags);
@@ -916,7 +960,7 @@
 	struct gem *gp = dev->priv;
 
 	printk(KERN_ERR "%s: transmit timed out, resetting\n", dev->name);
-	if (!gp->hw_running) {
+	if (!gp->running) {
 		printk("%s: hrm.. hw not running !\n", dev->name);
 		return;
 	}
@@ -934,7 +978,7 @@
 	spin_lock_irq(&gp->lock);
 	spin_lock(&gp->tx_lock);
 
-	gp->reset_task_pending = 2;
+	gp->reset_task_pending = 1;
 	schedule_work(&gp->reset_task);
 
 	spin_unlock(&gp->tx_lock);
@@ -975,6 +1019,11 @@
 		local_irq_restore(flags);
 		return NETDEV_TX_LOCKED;
 	}
+	/* We raced with gem_do_stop() */
+	if (!gp->running) {
+		spin_unlock_irqrestore(&gp->tx_lock, flags);
+		return NETDEV_TX_BUSY;
+	}
 
 	/* This is a hard error, log it. */
 	if (TX_BUFFS_AVAIL(gp) <= (skb_shinfo(skb)->nr_frags + 1)) {
@@ -1073,46 +1122,10 @@
 	return NETDEV_TX_OK;
 }
 
-/* Jumbo-grams don't seem to work :-( */
-#define GEM_MIN_MTU	68
-#if 1
-#define GEM_MAX_MTU	1500
-#else
-#define GEM_MAX_MTU	9000
-#endif
-
-static int gem_change_mtu(struct net_device *dev, int new_mtu)
-{
-	struct gem *gp = dev->priv;
-
-	if (new_mtu < GEM_MIN_MTU || new_mtu > GEM_MAX_MTU)
-		return -EINVAL;
-
-	if (!netif_running(dev) || !netif_device_present(dev)) {
-		/* We'll just catch it later when the
-		 * device is up'd or resumed.
-		 */
-		dev->mtu = new_mtu;
-		return 0;
-	}
-
-	spin_lock_irq(&gp->lock);
-	spin_lock(&gp->tx_lock);
-	dev->mtu = new_mtu;
-	gp->reset_task_pending = 1;
-	schedule_work(&gp->reset_task);
-	spin_unlock(&gp->tx_lock);
-	spin_unlock_irq(&gp->lock);
-
-	flush_scheduled_work();
-
-	return 0;
-}
-
 #define STOP_TRIES 32
 
 /* Must be invoked under gp->lock and gp->tx_lock. */
-static void gem_stop(struct gem *gp)
+static void gem_reset(struct gem *gp)
 {
 	int limit;
 	u32 val;
@@ -1140,7 +1153,7 @@
 /* Must be invoked under gp->lock and gp->tx_lock. */
 static void gem_start_dma(struct gem *gp)
 {
-	unsigned long val;
+	u32 val;
 	
 	/* We are ready to rock, turn everything on. */
 	val = readl(gp->regs + TXDMA_CFG);
@@ -1155,10 +1168,31 @@
 	(void) readl(gp->regs + MAC_RXCFG);
 	udelay(100);
 
-	writel(GREG_STAT_TXDONE, gp->regs + GREG_IMASK);
+	gem_enable_ints(gp);
 
 	writel(RX_RING_SIZE - 4, gp->regs + RXDMA_KICK);
+}
+
+/* Must be invoked under gp->lock and gp->tx_lock. DMA won't be
+ * actually stopped before about 4ms tho ...
+ */
+static void gem_stop_dma(struct gem *gp)
+{
+	u32 val;
+
+	/* We are done rocking, turn everything off. */
+	val = readl(gp->regs + TXDMA_CFG);
+	writel(val & ~TXDMA_CFG_ENABLE, gp->regs + TXDMA_CFG);
+	val = readl(gp->regs + RXDMA_CFG);
+	writel(val & ~RXDMA_CFG_ENABLE, gp->regs + RXDMA_CFG);
+	val = readl(gp->regs + MAC_TXCFG);
+	writel(val & ~MAC_TXCFG_ENAB, gp->regs + MAC_TXCFG);
+	val = readl(gp->regs + MAC_RXCFG);
+	writel(val & ~MAC_RXCFG_ENAB, gp->regs + MAC_RXCFG);
+
+	(void) readl(gp->regs + MAC_RXCFG);
 
+	/* Need to wait a bit ... done by the caller */
 }
 
 
@@ -1219,10 +1253,10 @@
 	if (speed == 0)
 		speed = SPEED_10;
 	
-	/* If HW is down, we don't try to actually setup the PHY, we
+	/* If we are asleep, we don't try to actually setup the PHY, we
 	 * just store the settings
 	 */
-	if (!gp->hw_running) {
+	if (gp->asleep) {
 		gp->phy_mii.autoneg = gp->want_autoneg = autoneg;
 		gp->phy_mii.speed = speed;
 		gp->phy_mii.duplex = duplex;
@@ -1279,6 +1313,9 @@
 		printk(KERN_INFO "%s: Link is up at %d Mbps, %s-duplex.\n",
 			gp->dev->name, speed, (full_duplex ? "full" : "half"));
 
+	if (!gp->running)
+		return 0;
+
 	val = (MAC_TXCFG_EIPG0 | MAC_TXCFG_NGU);
 	if (full_duplex) {
 		val |= (MAC_TXCFG_ICS | MAC_TXCFG_ICOLL);
@@ -1405,48 +1442,19 @@
 	}
 }
 
-static void gem_init_rings(struct gem *);
-static void gem_init_hw(struct gem *, int);
-
-static void gem_reset_task(void *data)
-{
-	struct gem *gp = (struct gem *) data;
-
-	netif_poll_disable(gp->dev);
-	spin_lock_irq(&gp->lock);
-	spin_lock(&gp->tx_lock);
-
-	if (gp->hw_running && gp->opened) {
-		netif_stop_queue(gp->dev);
-
-		/* Reset the chip & rings */
-		gem_stop(gp);
-		gem_init_rings(gp);
-
-		gem_init_hw(gp,
-			    (gp->reset_task_pending == 2));
-
-		netif_wake_queue(gp->dev);
-	}
-	gp->reset_task_pending = 0;
-
-	spin_unlock(&gp->tx_lock);
-	spin_unlock_irq(&gp->lock);
-	netif_poll_enable(gp->dev);
-}
-
 static void gem_link_timer(unsigned long data)
 {
 	struct gem *gp = (struct gem *) data;
 	int restart_aneg = 0;
 		
-	if (!gp->hw_running)
+	if (gp->asleep)
 		return;
 
 	spin_lock_irq(&gp->lock);
 	spin_lock(&gp->tx_lock);
+	gem_get_cell(gp);
 
-	/* If the link of task is still pending, we just
+	/* If the reset task is still pending, we just
 	 * reschedule the link timer
 	 */
 	if (gp->reset_task_pending)
@@ -1462,8 +1470,7 @@
 		if ((val & PCS_MIISTAT_LS) != 0) {
 			gp->lstate = link_up;
 			netif_carrier_on(gp->dev);
-			if (gp->opened)
-				(void)gem_set_link_modes(gp);
+			(void)gem_set_link_modes(gp);
 		}
 		goto restart;
 	}
@@ -1484,7 +1491,7 @@
 		} else if (gp->lstate != link_up) {
 			gp->lstate = link_up;
 			netif_carrier_on(gp->dev);
-			if (gp->opened && gem_set_link_modes(gp))
+			if (gem_set_link_modes(gp))
 				restart_aneg = 1;
 		}
 	} else {
@@ -1497,7 +1504,7 @@
 				printk(KERN_INFO "%s: Link down\n",
 					gp->dev->name);
 			netif_carrier_off(gp->dev);
-			gp->reset_task_pending = 2;
+			gp->reset_task_pending = 1;
 			schedule_work(&gp->reset_task);
 			restart_aneg = 1;
 		} else if (++gp->timer_ticks > 10) {
@@ -1514,6 +1521,7 @@
 restart:
 	mod_timer(&gp->link_timer, jiffies + ((12 * HZ) / 10));
 out_unlock:
+	gem_put_cell(gp);
 	spin_unlock(&gp->tx_lock);
 	spin_unlock_irq(&gp->lock);
 }
@@ -1619,59 +1627,40 @@
 	wmb();
 }
 
-/* Must be invoked under gp->lock and gp->tx_lock. */
+/* Init PHY interface and start link poll state machine */
 static void gem_init_phy(struct gem *gp)
 {
 	u32 mifcfg;
-	
+
 	/* Revert MIF CFG setting done on stop_phy */
 	mifcfg = readl(gp->regs + MIF_CFG);
 	mifcfg &= ~MIF_CFG_BBMODE;
 	writel(mifcfg, gp->regs + MIF_CFG);
 	
-#ifdef CONFIG_PPC_PMAC
 	if (gp->pdev->vendor == PCI_VENDOR_ID_APPLE) {
-		int i, j;
+		int i;
 
 		/* Those delay sucks, the HW seem to love them though, I'll
 		 * serisouly consider breaking some locks here to be able
 		 * to schedule instead
 		 */
-		pmac_call_feature(PMAC_FTR_GMAC_PHY_RESET, gp->of_node, 0, 0);
-		for (j = 0; j < 3; j++) {
+		for (i = 0; i < 3; i++) {
+#ifdef CONFIG_PPC_PMAC
+			pmac_call_feature(PMAC_FTR_GMAC_PHY_RESET, gp->of_node, 0, 0);
+			msleep(20);
+#endif
 			/* Some PHYs used by apple have problem getting back to us,
-			 * we _know_ it's actually at addr 0 or 1, that's a hack, but
-			 * it helps to do that reset now. I suspect some motherboards
-			 * don't wire the PHY reset line properly, thus the PHY doesn't
-			 * come back with the above pmac_call_feature.
+			 * we do an additional reset here
 			 */
-			gp->mii_phy_addr = 0;
-			phy_write(gp, MII_BMCR, BMCR_RESET);
-			gp->mii_phy_addr = 1;
 			phy_write(gp, MII_BMCR, BMCR_RESET);
-			/* We should probably break some locks here and schedule... */
-			mdelay(10);
-			
-			/* On K2, we only probe the internal PHY at address 1, other
-			 * addresses tend to return garbage.
-			 */
-			if (gp->pdev->device == PCI_DEVICE_ID_APPLE_K2_GMAC)
+			msleep(20);
+			if (phy_read(gp, MII_BMCR) != 0xffff)
 				break;
-
-			for (i = 0; i < 32; i++) {
-				gp->mii_phy_addr = i;
-				if (phy_read(gp, MII_BMCR) != 0xffff)
-					break;
-			}
-			if (i == 32) {
+			if (i == 2)
 				printk(KERN_WARNING "%s: GMAC PHY not responding !\n",
 				       gp->dev->name);
-				gp->mii_phy_addr = 0;
-			} else
-				break;
 		}
 	}
-#endif /* CONFIG_PPC_PMAC */
 
 	if (gp->pdev->vendor == PCI_VENDOR_ID_SUN &&
 	    gp->pdev->device == PCI_DEVICE_ID_SUN_GEM) {
@@ -1755,6 +1744,16 @@
 			val |= PCS_SCTRL_LOOP;
 		writel(val, gp->regs + PCS_SCTRL);
 	}
+
+	/* Default aneg parameters */
+	gp->timer_ticks = 0;
+	gp->lstate = link_down;
+	netif_carrier_off(gp->dev);
+
+	/* Can I advertise gigabit here ? I'd need BCM PHY docs... */
+	spin_lock_irq(&gp->lock);
+	gem_begin_auto_negotiation(gp, NULL);
+	spin_unlock_irq(&gp->lock);
 }
 
 /* Must be invoked under gp->lock and gp->tx_lock. */
@@ -1796,8 +1795,7 @@
 }
 
 /* Must be invoked under gp->lock and gp->tx_lock. */
-static u32
-gem_setup_multicast(struct gem *gp)
+static u32 gem_setup_multicast(struct gem *gp)
 {
 	u32 rxcfg = 0;
 	int i;
@@ -1914,6 +1912,10 @@
 	 * make no use of those events other than to record them.
 	 */
 	writel(0xffffffff, gp->regs + MAC_MCMASK);
+
+	/* Don't enable GEM's WOL in normal operations
+	 */
+	writel(0, gp->regs + WOL_WAKECSR);
 }
 
 /* Must be invoked under gp->lock and gp->tx_lock. */
@@ -1975,6 +1977,23 @@
 		gp->tx_fifo_sz = readl(gp->regs + TXDMA_FSZ) * 64;
 		gp->rx_fifo_sz = readl(gp->regs + RXDMA_FSZ) * 64;
 		gp->swrst_base = 0;
+
+		mif_cfg = readl(gp->regs + MIF_CFG);
+		mif_cfg &= ~(MIF_CFG_PSELECT|MIF_CFG_POLL|MIF_CFG_BBMODE|MIF_CFG_MDI1);
+		mif_cfg |= MIF_CFG_MDI0;
+		writel(mif_cfg, gp->regs + MIF_CFG);
+		writel(PCS_DMODE_MGM, gp->regs + PCS_DMODE);
+		writel(MAC_XIFCFG_OE, gp->regs + MAC_XIFCFG);
+
+		/* We hard-code the PHY address so we can properly bring it out of
+		 * reset later on, we can't really probe it at this point, though
+		 * that isn't an issue.
+		 */
+		if (gp->pdev->device == PCI_DEVICE_ID_APPLE_K2_GMAC)
+			gp->mii_phy_addr = 1;
+		else
+			gp->mii_phy_addr = 0;
+
 		return 0;
 	}
 
@@ -2053,68 +2072,28 @@
 }
 
 /* Must be invoked under gp->lock and gp->tx_lock. */
-static void gem_init_hw(struct gem *gp, int restart_link)
+static void gem_reinit_chip(struct gem *gp)
 {
-	/* On Apple's gmac, I initialize the PHY only after
-	 * setting up the chip. It appears the gigabit PHYs
-	 * don't quite like beeing talked to on the GII when
-	 * the chip is not running, I suspect it might not
-	 * be clocked at that point. --BenH
-	 */
-	if (restart_link)
-		gem_init_phy(gp);
-	gem_init_pause_thresholds(gp);
-	gem_init_dma(gp);
-	gem_init_mac(gp);
-
-	if (restart_link) {
-		/* Default aneg parameters */
-		gp->timer_ticks = 0;
-		gp->lstate = link_down;
-		netif_carrier_off(gp->dev);
-
-		/* Can I advertise gigabit here ? I'd need BCM PHY docs... */
-		gem_begin_auto_negotiation(gp, NULL);
-	} else {
-		if (gp->lstate == link_up) {
-			netif_carrier_on(gp->dev);
-			gem_set_link_modes(gp);
-		}
-	}
-}
+	/* Reset the chip */
+	gem_reset(gp);
 
-#ifdef CONFIG_PPC_PMAC
-/* Enable the chip's clock and make sure it's config space is
- * setup properly. There appear to be no need to restore the
- * base addresses.
- */
-static void gem_apple_powerup(struct gem *gp)
-{
-	u32 mif_cfg;
+	/* Make sure ints are disabled */
+	gem_disable_ints(gp);
 
-	mb();
-	pmac_call_feature(PMAC_FTR_GMAC_ENABLE, gp->of_node, 0, 1);
+	/* Allocate & setup ring buffers */
+	gem_init_rings(gp);
 
-	udelay(3);
-	
-	mif_cfg = readl(gp->regs + MIF_CFG);
-	mif_cfg &= ~(MIF_CFG_PSELECT|MIF_CFG_POLL|MIF_CFG_BBMODE|MIF_CFG_MDI1);
-	mif_cfg |= MIF_CFG_MDI0;
-	writel(mif_cfg, gp->regs + MIF_CFG);
-	writel(PCS_DMODE_MGM, gp->regs + PCS_DMODE);
-	writel(MAC_XIFCFG_OE, gp->regs + MAC_XIFCFG);
-}
+	/* Configure pause thresholds */
+	gem_init_pause_thresholds(gp);
 
-/* Turn off the chip's clock */
-static void gem_apple_powerdown(struct gem *gp)
-{
-	pmac_call_feature(PMAC_FTR_GMAC_ENABLE, gp->of_node, 0, 0);
+	/* Init DMA & MAC engines */
+	gem_init_dma(gp);
+	gem_init_mac(gp);
 }
 
-#endif /* CONFIG_PPC_PMAC */
 
 /* Must be invoked with no lock held. */
-static void gem_stop_phy(struct gem *gp)
+static void gem_stop_phy(struct gem *gp, int wol)
 {
 	u32 mifcfg;
 	unsigned long flags;
@@ -2131,8 +2110,22 @@
 	mifcfg &= ~MIF_CFG_POLL;
 	writel(mifcfg, gp->regs + MIF_CFG);
 
-	if (gp->wake_on_lan) {
-		/* Setup wake-on-lan */
+	if (wol) {
+		unsigned char *e = &gp->dev->dev_addr[0];
+		u32 csr;
+
+		/* Setup wake-on-lan for MAGIC packet */
+		writel(MAC_RXCFG_HFE | MAC_RXCFG_SFCS | MAC_RXCFG_ENAB,
+		       gp->regs + MAC_RXCFG);	
+		writel((e[4] << 8) | e[5], gp->regs + WOL_MATCH0);
+		writel((e[2] << 8) | e[3], gp->regs + WOL_MATCH1);
+		writel((e[0] << 8) | e[1], gp->regs + WOL_MATCH2);
+
+		writel(WOL_MCOUNT_N | WOL_MCOUNT_M, gp->regs + WOL_MCOUNT);
+		csr = WOL_WAKECSR_ENABLE;
+		if ((readl(gp->regs + MAC_XIFCFG) & MAC_XIFCFG_GMII) == 0)
+			csr |= WOL_WAKECSR_MII;
+		writel(csr, gp->regs + WOL_WAKECSR);
 	} else {
 		writel(0, gp->regs + MAC_RXCFG);
 		(void)readl(gp->regs + MAC_RXCFG);
@@ -2148,20 +2141,20 @@
 	writel(0, gp->regs + TXDMA_CFG);
 	writel(0, gp->regs + RXDMA_CFG);
 
-	if (!gp->wake_on_lan) {
+	if (!wol) {
 		spin_lock_irqsave(&gp->lock, flags);
 		spin_lock(&gp->tx_lock);
-		gem_stop(gp);
+		gem_reset(gp);
 		writel(MAC_TXRST_CMD, gp->regs + MAC_TXRST);
 		writel(MAC_RXRST_CMD, gp->regs + MAC_RXRST);
 		spin_unlock(&gp->tx_lock);
 		spin_unlock_irqrestore(&gp->lock, flags);
-	}
 
-	if (found_mii_phy(gp) && gp->phy_mii.def->ops->suspend)
-		gp->phy_mii.def->ops->suspend(&gp->phy_mii, 0 /* wake on lan options */);
+		/* No need to take the lock here */
+
+		if (found_mii_phy(gp) && gp->phy_mii.def->ops->suspend)
+			gp->phy_mii.def->ops->suspend(&gp->phy_mii);
 
-	if (!gp->wake_on_lan) {
 		/* According to Apple, we must set the MDIO pins to this begnign
 		 * state or we may 1) eat more current, 2) damage some PHYs
 		 */
@@ -2174,181 +2167,160 @@
 	}
 }
 
-/* Shut down the chip, must be called with pm_sem held.  */
-static void gem_shutdown(struct gem *gp)
+
+static int gem_do_start(struct net_device *dev)
 {
-	/* Make us not-running to avoid timers respawning
-	 * and swallow irqs 
-	 */
-	gp->hw_running = 0;
-	wmb();
+	struct gem *gp = dev->priv;
+	unsigned long flags;
 
-	/* Stop the link timer */
-	del_timer_sync(&gp->link_timer);
+	spin_lock_irqsave(&gp->lock, flags);
+	spin_lock(&gp->tx_lock);
 
-	/* Stop the reset task */
-	while (gp->reset_task_pending)
-		yield();
+	/* Enable the cell */
+	gem_get_cell(gp);
 	
-	/* Actually stop the chip */
-	if (gp->pdev->vendor == PCI_VENDOR_ID_APPLE) {
-		gem_stop_phy(gp);
+	/* Init & setup chip hardware */
+	gem_reinit_chip(gp);
 
-#ifdef CONFIG_PPC_PMAC
-		/* Power down the chip */
-		gem_apple_powerdown(gp);
-#endif /* CONFIG_PPC_PMAC */
-	} else{
-		unsigned long flags;
+	gp->running = 1;
+
+	if (gp->lstate == link_up) {
+		netif_carrier_on(gp->dev);
+		gem_set_link_modes(gp);
+	}
+
+	netif_wake_queue(gp->dev);
+
+	spin_unlock(&gp->tx_lock);
+	spin_unlock_irqrestore(&gp->lock, flags);
+
+	if (request_irq(gp->pdev->irq, gem_interrupt,
+				   SA_SHIRQ, dev->name, (void *)dev)) {
+		printk(KERN_ERR "%s: failed to request irq !\n", gp->dev->name);
 
 		spin_lock_irqsave(&gp->lock, flags);
 		spin_lock(&gp->tx_lock);
-		gem_stop(gp);
+
+		gp->running =  0;
+		gem_reset(gp);
+		gem_clean_rings(gp);
+		gem_put_cell(gp);
+		
 		spin_unlock(&gp->tx_lock);
 		spin_unlock_irqrestore(&gp->lock, flags);
+
+		return -EAGAIN;
 	}
+
+	return 0;
 }
 
-static void gem_pm_task(void *data)
+static void gem_do_stop(struct net_device *dev, int wol)
 {
-	struct gem *gp = (struct gem *) data;
+	struct gem *gp = dev->priv;
+	unsigned long flags;
 
-	/* We assume if we can't lock the pm_sem, then open() was
-	 * called again (or suspend()), and we can safely ignore
-	 * the PM request
-	 */
-	if (down_trylock(&gp->pm_sem))
-		return;
+	spin_lock_irqsave(&gp->lock, flags);
+	spin_lock(&gp->tx_lock);
 
-	/* Driver was re-opened or already shut down */
-	if (gp->opened || !gp->hw_running) {
-		up(&gp->pm_sem);
-		return;
-	}
+	gp->running = 0;
 
-	gem_shutdown(gp);
+	/* Stop netif queue */
+	netif_stop_queue(dev);
 
-	up(&gp->pm_sem);
-}
+	/* Make sure ints are disabled */
+	gem_disable_ints(gp);
 
-static void gem_pm_timer(unsigned long data)
-{
-	struct gem *gp = (struct gem *) data;
+	/* We can drop the lock now */
+	spin_unlock(&gp->tx_lock);
+	spin_unlock_irqrestore(&gp->lock, flags);
+
+	/* If we are going to sleep with WOL */
+	gem_stop_dma(gp);
+	msleep(10);
+	if (!wol)
+		gem_reset(gp);
+	msleep(10);
+
+	/* Get rid of rings */
+	gem_clean_rings(gp);
+
+	/* No irq needed anymore */
+	free_irq(gp->pdev->irq, (void *) dev);
 
-	schedule_work(&gp->pm_task);
+	/* Cell not needed neither if no WOL */
+	if (!wol) {
+		spin_lock_irqsave(&gp->lock, flags);
+		gem_put_cell(gp);
+		spin_unlock_irqrestore(&gp->lock, flags);
+	}
 }
 
-static int gem_open(struct net_device *dev)
+static void gem_reset_task(void *data)
 {
-	struct gem *gp = dev->priv;
-	int hw_was_up;
+	struct gem *gp = (struct gem *) data;
 
 	down(&gp->pm_sem);
 
-	hw_was_up = gp->hw_running;
+	netif_poll_disable(gp->dev);
 
-	/* Stop the PM timer/task */
-	del_timer(&gp->pm_timer);
-	flush_scheduled_work();
+	spin_lock_irq(&gp->lock);
+	spin_lock(&gp->tx_lock);
 
-	/* The power-management semaphore protects the hw_running
-	 * etc. state so it is safe to do this bit without gp->lock
-	 */
-	if (!gp->hw_running) {
-#ifdef CONFIG_PPC_PMAC
-		/* First, we need to bring up the chip */
-		if (gp->pdev->vendor == PCI_VENDOR_ID_APPLE) {
-			gem_apple_powerup(gp);
-			gem_check_invariants(gp);
-		}
-#endif /* CONFIG_PPC_PMAC */
+	if (gp->running == 0)
+		goto not_running;
 
-		/* Reset the chip */
-		spin_lock_irq(&gp->lock);
-		spin_lock(&gp->tx_lock);
-		gem_stop(gp);
-		spin_unlock(&gp->tx_lock);
-		spin_unlock_irq(&gp->lock);
+	if (gp->running) {
+		netif_stop_queue(gp->dev);
 
-		gp->hw_running = 1;
+		/* Reset the chip & rings */
+		gem_reinit_chip(gp);
+		if (gp->lstate == link_up)
+			gem_set_link_modes(gp);
+		netif_wake_queue(gp->dev);
 	}
+ not_running:
+	gp->reset_task_pending = 0;
 
-	/* We can now request the interrupt as we know it's masked
-	 * on the controller
-	 */
-	if (request_irq(gp->pdev->irq, gem_interrupt,
-			SA_SHIRQ, dev->name, (void *)dev)) {
-		printk(KERN_ERR "%s: failed to request irq !\n", gp->dev->name);
+	spin_unlock(&gp->tx_lock);
+	spin_unlock_irq(&gp->lock);
 
-		spin_lock_irq(&gp->lock);
-		spin_lock(&gp->tx_lock);
-#ifdef CONFIG_PPC_PMAC
-		if (!hw_was_up && gp->pdev->vendor == PCI_VENDOR_ID_APPLE)
-			gem_apple_powerdown(gp);
-#endif /* CONFIG_PPC_PMAC */
-		/* Fire the PM timer that will shut us down in about 10 seconds */
-		gp->pm_timer.expires = jiffies + 10*HZ;
-		add_timer(&gp->pm_timer);
-		up(&gp->pm_sem);
-		spin_unlock(&gp->tx_lock);
-		spin_unlock_irq(&gp->lock);
-
-		return -EAGAIN;
-	}
+	netif_poll_enable(gp->dev);
 
-       	spin_lock_irq(&gp->lock);
-	spin_lock(&gp->tx_lock);
+	up(&gp->pm_sem);
+}
 
-	/* Allocate & setup ring buffers */
-	gem_init_rings(gp);
 
-	/* Init & setup chip hardware */
-	gem_init_hw(gp, !hw_was_up);
+static int gem_open(struct net_device *dev)
+{
+	struct gem *gp = dev->priv;
+	int rc = 0;
 
-	gp->opened = 1;
+	down(&gp->pm_sem);
 
-	spin_unlock(&gp->tx_lock);
-	spin_unlock_irq(&gp->lock);
+	/* We need the cell enabled */
+	if (!gp->asleep)
+		rc = gem_do_start(dev);
+	gp->opened = (rc == 0);
 
 	up(&gp->pm_sem);
 
-	return 0;
+	return rc;
 }
 
 static int gem_close(struct net_device *dev)
 {
 	struct gem *gp = dev->priv;
 
-	/* Make sure we don't get distracted by suspend/resume */
-	down(&gp->pm_sem);
-
 	/* Note: we don't need to call netif_poll_disable() here because
 	 * our caller (dev_close) already did it for us
 	 */
 
-	/* Stop traffic, mark us closed */
-	spin_lock_irq(&gp->lock);
-	spin_lock(&gp->tx_lock);
+	down(&gp->pm_sem);
 
 	gp->opened = 0;	
-
-	netif_stop_queue(dev);
-
-	/* Stop chip */
-	gem_stop(gp);
-
-	/* Get rid of rings */
-	gem_clean_rings(gp);
-
-	/* Bye, the pm timer will finish the job */
-	free_irq(gp->pdev->irq, (void *) dev);
-
-	spin_unlock(&gp->tx_lock);
-	spin_unlock_irq(&gp->lock);
-
-	/* Fire the PM timer that will shut us down in about 10 seconds */
-	gp->pm_timer.expires = jiffies + 10*HZ;
-	add_timer(&gp->pm_timer);
+	if (!gp->asleep)
+		gem_do_stop(dev, 0);
 
 	up(&gp->pm_sem);
 	
@@ -2360,45 +2332,62 @@
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct gem *gp = dev->priv;
+	unsigned long flags;
 
-	netif_poll_disable(dev);
-
-	/* We hold the PM semaphore during entire driver
-	 * sleep time
-	 */
 	down(&gp->pm_sem);
 
+	netif_poll_disable(dev);
+
 	printk(KERN_INFO "%s: suspending, WakeOnLan %s\n",
-	       dev->name, gp->wake_on_lan ? "enabled" : "disabled");
+	       dev->name,
+	       (gp->wake_on_lan && gp->opened) ? "enabled" : "disabled");
 	
-	/* If the driver is opened, we stop the DMA */
-	if (gp->opened) {
-		spin_lock_irq(&gp->lock);
-		spin_lock(&gp->tx_lock);
+	/* Keep the cell enabled during the entire operation */
+	spin_lock_irqsave(&gp->lock, flags);
+	spin_lock(&gp->tx_lock);
+	gem_get_cell(gp);
+	spin_unlock(&gp->tx_lock);
+	spin_unlock_irqrestore(&gp->lock, flags);
 
+	/* If the driver is opened, we stop the MAC */
+	if (gp->opened) {
 		/* Stop traffic, mark us closed */
 		netif_device_detach(dev);
 
-		/* Stop chip */
-		gem_stop(gp);
+		/* Switch off MAC, remember WOL setting */
+		gp->asleep_wol = gp->wake_on_lan;
+		gem_do_stop(dev, gp->asleep_wol);
+	} else
+		gp->asleep_wol = 0;
 
-		/* Get rid of ring buffers */
-		gem_clean_rings(gp);
+	/* Mark us asleep */
+	gp->asleep = 1;
+	wmb();
 
-		spin_unlock(&gp->tx_lock);
-		spin_unlock_irq(&gp->lock);
+	/* Stop the link timer */
+	del_timer_sync(&gp->link_timer);
 
-		if (gp->pdev->vendor == PCI_VENDOR_ID_APPLE)
-			disable_irq(gp->pdev->irq);
-	}
+	/* Now we release the semaphore to not block the reset task who
+	 * can take it too. We are marked asleep, so there will be no
+	 * conflict here
+	 */
+	up(&gp->pm_sem);
 
-	if (gp->hw_running) {
-		/* Kill PM timer if any */
-		del_timer_sync(&gp->pm_timer);
-		flush_scheduled_work();
+	/* Wait for a pending reset task to complete */
+	while (gp->reset_task_pending)
+		yield();
+	flush_scheduled_work();
 
-		gem_shutdown(gp);
-	}
+	/* Shut the PHY down eventually and setup WOL */
+	gem_stop_phy(gp, gp->asleep_wol);
+
+	/* Make sure bus master is disabled */
+	pci_disable_device(gp->pdev);
+
+	/* Release the cell, no need to take a lock at this point since
+	 * nothing else can happen now
+	 */
+	gem_put_cell(gp);
 
 	return 0;
 }
@@ -2407,36 +2396,74 @@
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct gem *gp = dev->priv;
+	unsigned long flags;
 
 	printk(KERN_INFO "%s: resuming\n", dev->name);
 
-	if (gp->opened) {
-#ifdef CONFIG_PPC_PMAC
-		/* First, we need to bring up the chip */
-		if (gp->pdev->vendor == PCI_VENDOR_ID_APPLE) {
-			gem_apple_powerup(gp);
-			gem_check_invariants(gp);
-		}
-#endif /* CONFIG_PPC_PMAC */
-		spin_lock_irq(&gp->lock);
-		spin_lock(&gp->tx_lock);
+	down(&gp->pm_sem);
 
-		gem_stop(gp);
-		gp->hw_running = 1;
-		gem_init_rings(gp);
-		gem_init_hw(gp, 1);
+	/* Keep the cell enabled during the entire operation, no need to
+	 * take a lock here tho since nothing else can happen while we are
+	 * marked asleep
+	 */
+	gem_get_cell(gp);
+
+	/* Make sure PCI access and bus master are enabled */
+	if (pci_enable_device(gp->pdev)) {
+		printk(KERN_ERR "%s: Can't re-enable chip !\n",
+		       dev->name);
+		/* Put cell and forget it for now, it will be considered as
+		 * still asleep, a new sleep cycle may bring it back
+		 */
+		gem_put_cell(gp);
+		up(&gp->pm_sem);
+		return 0;
+	}
+	pci_set_master(gp->pdev);
 
-		spin_unlock(&gp->tx_lock);
-		spin_unlock_irq(&gp->lock);
+	/* Reset everything */
+	gem_reset(gp);
+
+	/* Mark us woken up */
+	gp->asleep = 0;
+	wmb();
+
+	/* Bring the PHY back. Again, lock is useless at this point as
+	 * nothing can be happening until we restart the whole thing
+	 */
+	gem_init_phy(gp);
 
+	/* If we were opened, bring everything back */
+	if (gp->opened) {
+		/* Restart MAC */
+		gem_do_start(dev);
+
+		/* Re-attach net device */
 		netif_device_attach(dev);
-		if (gp->pdev->vendor == PCI_VENDOR_ID_APPLE)
-			enable_irq(gp->pdev->irq);
+
 	}
-	up(&gp->pm_sem);
+
+	spin_lock_irqsave(&gp->lock, flags);
+	spin_lock(&gp->tx_lock);
+
+	/* If we had WOL enabled, the cell clock was never turned off during
+	 * sleep, so we end up beeing unbalanced. Fix that here
+	 */
+	if (gp->asleep_wol)
+		gem_put_cell(gp);
+
+	/* This function doesn't need to hold the cell, it will be held if the
+	 * driver is open by gem_do_start().
+	 */
+	gem_put_cell(gp);
+
+	spin_unlock(&gp->tx_lock);
+	spin_unlock_irqrestore(&gp->lock, flags);
 
 	netif_poll_enable(dev);
 	
+	up(&gp->pm_sem);
+
 	return 0;
 }
 #endif /* CONFIG_PM */
@@ -2449,7 +2476,10 @@
 	spin_lock_irq(&gp->lock);
 	spin_lock(&gp->tx_lock);
 
-	if (gp->hw_running) {
+	/* I have seen this being called while the PM was in progress,
+	 * so we shield against this
+	 */
+	if (gp->running) {
 		stats->rx_crc_errors += readl(gp->regs + MAC_FCSERR);
 		writel(0, gp->regs + MAC_FCSERR);
 
@@ -2479,12 +2509,12 @@
 	u32 rxcfg, rxcfg_new;
 	int limit = 10000;
 	
-	if (!gp->hw_running)
-		return;
-		
 	spin_lock_irq(&gp->lock);
 	spin_lock(&gp->tx_lock);
 
+	if (!gp->running)
+		goto bail;
+
 	netif_stop_queue(dev);
 
 	rxcfg = readl(gp->regs + MAC_RXCFG);
@@ -2507,9 +2537,46 @@
 	writel(rxcfg, gp->regs + MAC_RXCFG);
 
 	netif_wake_queue(dev);
+ bail:
+	spin_unlock(&gp->tx_lock);
+	spin_unlock_irq(&gp->lock);
+}
+
+/* Jumbo-grams don't seem to work :-( */
+#define GEM_MIN_MTU	68
+#if 1
+#define GEM_MAX_MTU	1500
+#else
+#define GEM_MAX_MTU	9000
+#endif
+
+static int gem_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct gem *gp = dev->priv;
+
+	if (new_mtu < GEM_MIN_MTU || new_mtu > GEM_MAX_MTU)
+		return -EINVAL;
 
+	if (!netif_running(dev) || !netif_device_present(dev)) {
+		/* We'll just catch it later when the
+		 * device is up'd or resumed.
+		 */
+		dev->mtu = new_mtu;
+		return 0;
+	}
+
+	spin_lock_irq(&gp->lock);
+	spin_lock(&gp->tx_lock);
+	dev->mtu = new_mtu;
+	if (gp->running) {
+		gem_reinit_chip(gp);
+		if (gp->lstate == link_up)
+			gem_set_link_modes(gp);
+	}
 	spin_unlock(&gp->tx_lock);
 	spin_unlock_irq(&gp->lock);
+
+	return 0;
 }
 
 static void gem_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
@@ -2540,7 +2607,6 @@
 
 		/* Return current PHY settings */
 		spin_lock_irq(&gp->lock);
-		spin_lock(&gp->tx_lock);
 		cmd->autoneg = gp->want_autoneg;
 		cmd->speed = gp->phy_mii.speed;
 		cmd->duplex = gp->phy_mii.duplex;			
@@ -2552,7 +2618,6 @@
 		 */
 		if (cmd->advertising == 0)
 			cmd->advertising = cmd->supported;
-		spin_unlock(&gp->tx_lock);
 		spin_unlock_irq(&gp->lock);
 	} else { // XXX PCS ?
 		cmd->supported =
@@ -2592,9 +2657,9 @@
 	      
 	/* Apply settings and restart link process. */
 	spin_lock_irq(&gp->lock);
-	spin_lock(&gp->tx_lock);
+	gem_get_cell(gp);
 	gem_begin_auto_negotiation(gp, cmd);
-	spin_unlock(&gp->tx_lock);
+	gem_put_cell(gp);
 	spin_unlock_irq(&gp->lock);
 
 	return 0;
@@ -2609,9 +2674,9 @@
 
 	/* Restart link process. */
 	spin_lock_irq(&gp->lock);
-	spin_lock(&gp->tx_lock);
+	gem_get_cell(gp);
 	gem_begin_auto_negotiation(gp, NULL);
-	spin_unlock(&gp->tx_lock);
+	gem_put_cell(gp);
 	spin_unlock_irq(&gp->lock);
 
 	return 0;
@@ -2628,7 +2693,31 @@
 	struct gem *gp = dev->priv;
 	gp->msg_enable = value;
 }
-  
+
+
+/* Add more when I understand how to program the chip */
+/* like WAKE_UCAST | WAKE_MCAST | WAKE_BCAST */
+
+#define WOL_SUPPORTED_MASK	(WAKE_MAGIC)
+
+static void gem_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct gem *gp = dev->priv;
+
+	/* Add more when I understand how to program the chip */
+	wol->supported = WOL_SUPPORTED_MASK;
+	wol->wolopts = gp->wake_on_lan;
+}
+
+static int gem_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct gem *gp = dev->priv;
+
+	gp->wake_on_lan = wol->wolopts & WOL_SUPPORTED_MASK;
+
+	return 0;
+}
+
 static struct ethtool_ops gem_ethtool_ops = {
 	.get_drvinfo		= gem_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
@@ -2637,6 +2726,8 @@
 	.nway_reset		= gem_nway_reset,
 	.get_msglevel		= gem_get_msglevel,
 	.set_msglevel		= gem_set_msglevel,
+	.get_wol		= gem_get_wol,
+	.set_wol		= gem_set_wol,
 };
 
 static int gem_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
@@ -2644,22 +2735,28 @@
 	struct gem *gp = dev->priv;
 	struct mii_ioctl_data *data = if_mii(ifr);
 	int rc = -EOPNOTSUPP;
-	
+	unsigned long flags;
+
 	/* Hold the PM semaphore while doing ioctl's or we may collide
-	 * with open/close and power management and oops.
+	 * with power management.
 	 */
 	down(&gp->pm_sem);
-	
+		
+	spin_lock_irqsave(&gp->lock, flags);
+	gem_get_cell(gp);
+	spin_unlock_irqrestore(&gp->lock, flags);
+
 	switch (cmd) {
 	case SIOCGMIIPHY:		/* Get address of MII PHY in use. */
 		data->phy_id = gp->mii_phy_addr;
 		/* Fallthrough... */
 
 	case SIOCGMIIREG:		/* Read MII PHY register. */
-		if (!gp->hw_running)
-			rc = -EIO;
+		if (!gp->running)
+			rc = -EAGAIN;
 		else {
-			data->val_out = __phy_read(gp, data->phy_id & 0x1f, data->reg_num & 0x1f);
+			data->val_out = __phy_read(gp, data->phy_id & 0x1f,
+						   data->reg_num & 0x1f);
 			rc = 0;
 		}
 		break;
@@ -2667,14 +2764,19 @@
 	case SIOCSMIIREG:		/* Write MII PHY register. */
 		if (!capable(CAP_NET_ADMIN))
 			rc = -EPERM;
-		else if (!gp->hw_running)
-			rc = -EIO;
+		else if (!gp->running)
+			rc = -EAGAIN;
 		else {
-			__phy_write(gp, data->phy_id & 0x1f, data->reg_num & 0x1f, data->val_in);
+			__phy_write(gp, data->phy_id & 0x1f, data->reg_num & 0x1f,
+				    data->val_in);
 			rc = 0;
 		}
 		break;
 	};
+	
+	spin_lock_irqsave(&gp->lock, flags);
+	gem_put_cell(gp);
+	spin_unlock_irqrestore(&gp->lock, flags);
 
 	up(&gp->pm_sem);
 	
@@ -2779,6 +2881,47 @@
 	return 0;
 }
 
+static void __devexit gem_remove_one(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+
+	if (dev) {
+		struct gem *gp = dev->priv;
+
+		unregister_netdev(dev);
+
+		/* Stop the link timer */
+		del_timer_sync(&gp->link_timer);
+
+		/* We shouldn't need any locking here */
+		gem_get_cell(gp);
+
+		/* Wait for a pending reset task to complete */
+		while (gp->reset_task_pending)
+			yield();
+		flush_scheduled_work();
+
+		/* Shut the PHY down */
+		gem_stop_phy(gp, 0);
+
+		gem_put_cell(gp);
+
+		/* Make sure bus master is disabled */
+		pci_disable_device(gp->pdev);
+
+		/* Free resources */
+		pci_free_consistent(pdev,
+				    sizeof(struct gem_init_block),
+				    gp->init_block,
+				    gp->gblock_dvma);
+		iounmap(gp->regs);
+		pci_release_regions(pdev);
+		free_netdev(dev);
+
+		pci_set_drvdata(pdev, NULL);
+	}
+}
+
 static int __devinit gem_init_one(struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
@@ -2870,11 +3013,6 @@
 	gp->link_timer.function = gem_link_timer;
 	gp->link_timer.data = (unsigned long) gp;
 
-	init_timer(&gp->pm_timer);
-	gp->pm_timer.function = gem_pm_timer;
-	gp->pm_timer.data = (unsigned long) gp;
-
-	INIT_WORK(&gp->pm_task, gem_pm_task, gp);
 	INIT_WORK(&gp->reset_task, gem_reset_task, gp);
 	
 	gp->lstate = link_down;
@@ -2890,19 +3028,18 @@
 	}
 
 	/* On Apple, we power the chip up now in order for check
-	 * invariants to work, but also because the firmware might
-	 * not have properly shut down the PHY.
+	 * invariants to work. We also set some registers that are
+	 * normally
 	 */
 #ifdef CONFIG_PPC_PMAC
 	gp->of_node = pci_device_to_OF_node(pdev);
-	if (pdev->vendor == PCI_VENDOR_ID_APPLE)
-		gem_apple_powerup(gp);
 #endif
-	spin_lock_irq(&gp->lock);
-	spin_lock(&gp->tx_lock);
-	gem_stop(gp);
-	spin_unlock(&gp->tx_lock);
-	spin_unlock_irq(&gp->lock);
+
+	/* Make sure cell is enabled */
+	gem_get_cell(gp);
+
+	/* Make sure everything is stopped and in init state */
+	gem_reset(gp);
 
 	/* Fill up the mii_phy structure (even if we won't use it) */
 	gp->phy_mii.dev = dev;
@@ -2911,7 +3048,8 @@
 
 	/* By default, we start with autoneg */
 	gp->want_autoneg = 1;
-	
+
+	/* Check fifo sizes, PHY type, etc... */
 	if (gem_check_invariants(gp)) {
 		err = -ENODEV;
 		goto err_out_iounmap;
@@ -2951,6 +3089,19 @@
 	dev->poll_controller = gem_poll_controller;
 #endif
 
+	/* Set that now, in case PM kicks in now */
+	pci_set_drvdata(pdev, dev);
+
+	/* Detect & init PHY, start autoneg, we release the cell now
+	 * too, it will be managed by whoever needs it
+	 */
+	gem_init_phy(gp);
+
+	spin_lock_irq(&gp->lock);
+	gem_put_cell(gp);
+	spin_unlock_irq(&gp->lock);
+
+	/* Register with kernel */
 	if (register_netdev(dev)) {
 		printk(KERN_ERR PFX "Cannot register net device, "
 		       "aborting.\n");
@@ -2965,48 +3116,22 @@
 		       i == 5 ? ' ' : ':');
 	printk("\n");
 
-	/* Detect & init PHY, start autoneg */
-	spin_lock_irq(&gp->lock);
-	spin_lock(&gp->tx_lock);
-	gp->hw_running = 1;
-	gem_init_phy(gp);
-	gem_begin_auto_negotiation(gp, NULL);
-	spin_unlock(&gp->tx_lock);
-	spin_unlock_irq(&gp->lock);
-
 	if (gp->phy_type == phy_mii_mdio0 ||
      	    gp->phy_type == phy_mii_mdio1)
 		printk(KERN_INFO "%s: Found %s PHY\n", dev->name, 
 			gp->phy_mii.def ? gp->phy_mii.def->name : "no");
 
-	pci_set_drvdata(pdev, dev);
-
 	/* GEM can do it all... */
 	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_LLTX;
 	if (pci_using_dac)
 		dev->features |= NETIF_F_HIGHDMA;
 
-	/* Fire the PM timer that will shut us down in about 10 seconds */
-	gp->pm_timer.expires = jiffies + 10*HZ;
-	add_timer(&gp->pm_timer);
-
 	return 0;
 
 err_out_free_consistent:
-	pci_free_consistent(pdev,
-			    sizeof(struct gem_init_block),
-			    gp->init_block,
-			    gp->gblock_dvma);
-
+	gem_remove_one(pdev);
 err_out_iounmap:
-	down(&gp->pm_sem);
-	/* Stop the PM timer & task */
-	del_timer_sync(&gp->pm_timer);
-	flush_scheduled_work();
-	if (gp->hw_running)
-		gem_shutdown(gp);
-	up(&gp->pm_sem);
-
+	gem_put_cell(gp);
 	iounmap(gp->regs);
 
 err_out_free_res:
@@ -3020,34 +3145,6 @@
 
 }
 
-static void __devexit gem_remove_one(struct pci_dev *pdev)
-{
-	struct net_device *dev = pci_get_drvdata(pdev);
-
-	if (dev) {
-		struct gem *gp = dev->priv;
-
-		unregister_netdev(dev);
-
-		down(&gp->pm_sem);
-		/* Stop the PM timer & task */
-		del_timer_sync(&gp->pm_timer);
-		flush_scheduled_work();
-		if (gp->hw_running)
-			gem_shutdown(gp);
-		up(&gp->pm_sem);
-
-		pci_free_consistent(pdev,
-				    sizeof(struct gem_init_block),
-				    gp->init_block,
-				    gp->gblock_dvma);
-		iounmap(gp->regs);
-		pci_release_regions(pdev);
-		free_netdev(dev);
-
-		pci_set_drvdata(pdev, NULL);
-	}
-}
 
 static struct pci_driver gem_driver = {
 	.name		= GEM_MODULE_NAME,
diff -uNr linus-2.6.10/drivers/net/sungem.h sleep-2.6.10/drivers/net/sungem.h
--- linus-2.6.10/drivers/net/sungem.h	2005-01-06 10:48:03.408212856 +0000
+++ sleep-2.6.10/drivers/net/sungem.h	2005-01-06 11:39:08.331219024 +0000
@@ -170,6 +170,27 @@
  * them later. -DaveM
  */
 
+/* WakeOnLan Registers	*/
+#define WOL_MATCH0	0x3000UL
+#define WOL_MATCH1	0x3004UL
+#define WOL_MATCH2	0x3008UL
+#define WOL_MCOUNT	0x300CUL
+#define WOL_WAKECSR	0x3010UL
+
+/* WOL Match count register
+ */
+#define WOL_MCOUNT_N		0x00000010
+#define WOL_MCOUNT_M		0x00000000 /* 0 << 8 */
+
+#define WOL_WAKECSR_ENABLE	0x00000001
+#define WOL_WAKECSR_MII		0x00000002
+#define WOL_WAKECSR_SEEN	0x00000004
+#define WOL_WAKECSR_FILT_UCAST	0x00000008
+#define WOL_WAKECSR_FILT_MCAST	0x00000010
+#define WOL_WAKECSR_FILT_BCAST	0x00000020
+#define WOL_WAKECSR_FILT_SEEN	0x00000040
+
+
 /* Receive DMA Registers */
 #define RXDMA_CFG	0x4000UL	/* RX Configuration Register	*/
 #define RXDMA_DBLOW	0x4004UL	/* RX Descriptor Base Low	*/
@@ -961,11 +982,12 @@
 	/* Set when chip is actually in operational state
 	 * (ie. not power managed)
 	 */
-	int hw_running;
-	int opened;
+	int asleep;		/* chip asleep, protected by pm_sem */
+	int asleep_wol;		/* was asleep with WOL enabled */
+	int cell_enabled;	/* cell enable count, protected by lock */
+	int opened;		/* driver opened, protected by pm_sem */
+	int running;		/* chip configured, protected by lock */
 	struct semaphore pm_sem;
-	struct work_struct pm_task;
-	struct timer_list pm_timer;
 
 	struct gem_init_block *init_block;
 
diff -uNr linus-2.6.10/drivers/net/sungem_phy.c sleep-2.6.10/drivers/net/sungem_phy.c
--- linus-2.6.10/drivers/net/sungem_phy.c	2005-01-06 10:47:31.551263624 +0000
+++ sleep-2.6.10/drivers/net/sungem_phy.c	2005-01-06 11:38:52.306260152 +0000
@@ -98,25 +98,15 @@
 	data &= ~MII_BCM5201_MULTIPHY_SUPERISOLATE;
 	phy_write(phy, MII_BCM5201_MULTIPHY, data);
 
+	phy_write(phy, MII_BCM5201_INTERRUPT, 0);
+
 	return 0;
 }
 
-static int bcm5201_suspend(struct mii_phy* phy, int wol_options)
+static int bcm5201_suspend(struct mii_phy* phy)
 {
-	if (!wol_options)
-		phy_write(phy, MII_BCM5201_INTERRUPT, 0);
-
-	/* Here's a strange hack used by both MacOS 9 and X */
-	phy_write(phy, MII_LPA, phy_read(phy, MII_LPA));
-	
-	if (!wol_options) {
-#if 0 /* Commented out in Darwin... someone has those dawn docs ? */
-		u16 val = phy_read(phy, MII_BCM5201_AUXMODE2)
-		phy_write(phy, MII_BCM5201_AUXMODE2,
-			  val & ~MII_BCM5201_AUXMODE2_LOWPOWER);
-#endif			
-		phy_write(phy, MII_BCM5201_MULTIPHY, MII_BCM5201_MULTIPHY_SUPERISOLATE);
-	}
+	phy_write(phy, MII_BCM5201_INTERRUPT, 0);
+	phy_write(phy, MII_BCM5201_MULTIPHY, MII_BCM5201_MULTIPHY_SUPERISOLATE);
 
 	return 0;
 }
@@ -144,6 +134,21 @@
 	return 0;
 }
 
+static int bcm5221_suspend(struct mii_phy* phy)
+{
+	u16 data;
+
+	data = phy_read(phy, MII_BCM5221_TEST);
+	phy_write(phy, MII_BCM5221_TEST,
+		data | MII_BCM5221_TEST_ENABLE_SHADOWS);
+
+	data = phy_read(phy, MII_BCM5221_SHDOW_AUX_MODE4);
+	phy_write(phy, MII_BCM5221_SHDOW_AUX_MODE4,
+		  data | MII_BCM5221_SHDOW_AUX_MODE4_IDDQMODE);
+
+	return 0;
+}
+
 static int bcm5400_init(struct mii_phy* phy)
 {
 	u16 data;
@@ -173,7 +178,7 @@
 	return 0;
 }
 
-static int bcm5400_suspend(struct mii_phy* phy, int wol_options)
+static int bcm5400_suspend(struct mii_phy* phy)
 {
 #if 0 /* Commented out in Darwin... someone has those dawn docs ? */
 	phy_write(phy, MII_BMCR, BMCR_PDOWN);
@@ -229,7 +234,7 @@
 	return 0;
 }
 
-static int bcm5401_suspend(struct mii_phy* phy, int wol_options)
+static int bcm5401_suspend(struct mii_phy* phy)
 {
 #if 0 /* Commented out in Darwin... someone has those dawn docs ? */
 	phy_write(phy, MII_BMCR, BMCR_PDOWN);
@@ -266,7 +271,7 @@
 	return 0;
 }
 
-static int bcm5411_suspend(struct mii_phy* phy, int wol_options)
+static int bcm5411_suspend(struct mii_phy* phy)
 {
 	phy_write(phy, MII_BMCR, BMCR_PDOWN);
 
@@ -662,7 +667,7 @@
 
 /* Broadcom BCM 5221 */
 static struct mii_phy_ops bcm5221_phy_ops = {
-	.suspend	= bcm5201_suspend,
+	.suspend	= bcm5221_suspend,
 	.init		= bcm5221_init,
 	.setup_aneg	= genmii_setup_aneg,
 	.setup_forced	= genmii_setup_forced,
diff -uNr linus-2.6.10/drivers/net/sungem_phy.h sleep-2.6.10/drivers/net/sungem_phy.h
--- linus-2.6.10/drivers/net/sungem_phy.h	2005-01-06 10:48:25.359203584 +0000
+++ sleep-2.6.10/drivers/net/sungem_phy.h	2005-01-06 11:39:13.992291008 +0000
@@ -7,7 +7,7 @@
 struct mii_phy_ops
 {
 	int		(*init)(struct mii_phy *phy);
-	int		(*suspend)(struct mii_phy *phy, int wol_options);
+	int		(*suspend)(struct mii_phy *phy);
 	int		(*setup_aneg)(struct mii_phy *phy, u32 advertise);
 	int		(*setup_forced)(struct mii_phy *phy, int speed, int fd);
 	int		(*poll_link)(struct mii_phy *phy);
@@ -80,6 +80,7 @@
 #define MII_BCM5221_SHDOW_AUX_STAT2		0x1b
 #define MII_BCM5221_SHDOW_AUX_STAT2_APD		0x0020
 #define MII_BCM5221_SHDOW_AUX_MODE4		0x1a
+#define MII_BCM5221_SHDOW_AUX_MODE4_IDDQMODE	0x0001
 #define MII_BCM5221_SHDOW_AUX_MODE4_CLKLOPWR	0x0004
 
 /* MII BCM5400 1000-BASET Control register */
diff -uNr linus-2.6.10/drivers/serial/pmac_zilog.c sleep-2.6.10/drivers/serial/pmac_zilog.c
--- linus-2.6.10/drivers/serial/pmac_zilog.c	2005-01-06 10:47:24.218180480 +0000
+++ sleep-2.6.10/drivers/serial/pmac_zilog.c	2005-01-06 11:38:39.088272768 +0000
@@ -1946,6 +1946,8 @@
 	unsigned long flags;
 	int i;
 
+	if (ZS_IS_ASLEEP(uap))
+		return;
 	spin_lock_irqsave(&uap->port.lock, flags);
 
 	/* Turn of interrupts and enable the transmitter. */
diff -uNr linus-2.6.10/drivers/video/aty/ati_ids.h sleep-2.6.10/drivers/video/aty/ati_ids.h
--- linus-2.6.10/drivers/video/aty/ati_ids.h	2005-01-06 10:47:37.884236768 +0000
+++ sleep-2.6.10/drivers/video/aty/ati_ids.h	2005-01-06 11:38:56.071219176 +0000
@@ -4,6 +4,18 @@
  * radeonfb
  */
 
+#define PCI_CHIP_RV380_3150             0x3150
+#define PCI_CHIP_RV380_3151             0x3151
+#define PCI_CHIP_RV380_3152             0x3152
+#define PCI_CHIP_RV380_3153             0x3153
+#define PCI_CHIP_RV380_3154             0x3154
+#define PCI_CHIP_RV380_3156             0x3156
+#define PCI_CHIP_RV380_3E50             0x3E50
+#define PCI_CHIP_RV380_3E51             0x3E51
+#define PCI_CHIP_RV380_3E52             0x3E52
+#define PCI_CHIP_RV380_3E53             0x3E53
+#define PCI_CHIP_RV380_3E54             0x3E54
+#define PCI_CHIP_RV380_3E56             0x3E56
 #define PCI_CHIP_RS100_4136		0x4136
 #define PCI_CHIP_RS200_4137		0x4137
 #define PCI_CHIP_R300_AD		0x4144
@@ -52,6 +64,14 @@
 #define PCI_CHIP_RV250_Ie		0x4965
 #define PCI_CHIP_RV250_If		0x4966
 #define PCI_CHIP_RV250_Ig		0x4967
+#define PCI_CHIP_R420_JH                0x4A48
+#define PCI_CHIP_R420_JI                0x4A49
+#define PCI_CHIP_R420_JJ                0x4A4A
+#define PCI_CHIP_R420_JK                0x4A4B
+#define PCI_CHIP_R420_JL                0x4A4C
+#define PCI_CHIP_R420_JM                0x4A4D
+#define PCI_CHIP_R420_JN                0x4A4E
+#define PCI_CHIP_R420_JP                0x4A50
 #define PCI_CHIP_MACH64LB		0x4C42
 #define PCI_CHIP_MACH64LD		0x4C44
 #define PCI_CHIP_RAGE128LE		0x4C45
@@ -73,6 +93,7 @@
 #define PCI_CHIP_RV250_Le		0x4C65
 #define PCI_CHIP_RV250_Lf		0x4C66
 #define PCI_CHIP_RV250_Lg		0x4C67
+#define PCI_CHIP_RV250_Ln		0x4C6E
 #define PCI_CHIP_RAGE128MF		0x4D46
 #define PCI_CHIP_RAGE128ML		0x4D4C
 #define PCI_CHIP_R300_ND		0x4E44
@@ -148,6 +169,21 @@
 #define PCI_CHIP_RAGE128TS		0x5453
 #define PCI_CHIP_RAGE128TT		0x5454
 #define PCI_CHIP_RAGE128TU		0x5455
+#define PCI_CHIP_RV370_5460             0x5460
+#define PCI_CHIP_RV370_5461             0x5461
+#define PCI_CHIP_RV370_5462             0x5462
+#define PCI_CHIP_RV370_5463             0x5463
+#define PCI_CHIP_RV370_5464             0x5464
+#define PCI_CHIP_RV370_5465             0x5465
+#define PCI_CHIP_RV370_5466             0x5466
+#define PCI_CHIP_RV370_5467             0x5467
+#define PCI_CHIP_R423_UH                0x5548
+#define PCI_CHIP_R423_UI                0x5549
+#define PCI_CHIP_R423_UJ                0x554A
+#define PCI_CHIP_R423_UK                0x554B
+#define PCI_CHIP_R423_UQ                0x5551
+#define PCI_CHIP_R423_UR                0x5552
+#define PCI_CHIP_R423_UT                0x5554
 #define PCI_CHIP_MACH64VT		0x5654
 #define PCI_CHIP_MACH64VU		0x5655
 #define PCI_CHIP_MACH64VV		0x5656
@@ -155,14 +191,21 @@
 #define PCI_CHIP_RS300_5835		0x5835
 #define PCI_CHIP_RS300_5836		0x5836
 #define PCI_CHIP_RS300_5837		0x5837
+#define PCI_CHIP_RV370_5B60             0x5B60
+#define PCI_CHIP_RV370_5B61             0x5B61
+#define PCI_CHIP_RV370_5B62             0x5B62
+#define PCI_CHIP_RV370_5B63             0x5B63
+#define PCI_CHIP_RV370_5B64             0x5B64
+#define PCI_CHIP_RV370_5B65             0x5B65
+#define PCI_CHIP_RV370_5B66             0x5B66
+#define PCI_CHIP_RV370_5B67             0x5B67
 #define PCI_CHIP_RV280_5960		0x5960
 #define PCI_CHIP_RV280_5961		0x5961
 #define PCI_CHIP_RV280_5962		0x5962
-#define PCI_CHIP_RV280_5963		0x5963
 #define PCI_CHIP_RV280_5964		0x5964
-#define PCI_CHIP_RV280_5968		0x5968
-#define PCI_CHIP_RV280_5969		0x5969
-#define PCI_CHIP_RV280_596A		0x596A
-#define PCI_CHIP_RV280_596B		0x596B
 #define PCI_CHIP_RV280_5C61		0x5C61
 #define PCI_CHIP_RV280_5C63		0x5C63
+#define PCI_CHIP_R423_5D57              0x5D57
+#define PCI_CHIP_RS350_7834             0x7834
+#define PCI_CHIP_RS350_7835             0x7835
+
diff -uNr linus-2.6.10/drivers/video/aty/aty128fb.c sleep-2.6.10/drivers/video/aty/aty128fb.c
--- linus-2.6.10/drivers/video/aty/aty128fb.c	2005-01-06 10:47:47.412248424 +0000
+++ sleep-2.6.10/drivers/video/aty/aty128fb.c	2005-01-06 11:39:05.133172664 +0000
@@ -67,6 +67,7 @@
 #include <asm/io.h>
 
 #ifdef CONFIG_PPC_PMAC
+#include <asm/pmac_feature.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include "../macmodes.h"
@@ -1737,6 +1738,18 @@
  *  Initialisation
  */
 
+#ifdef CONFIG_PPC_PMAC
+static void aty128_early_resume(void *data)
+{
+        struct aty128fb_par *par = data;
+
+	if (try_acquire_console_sem())
+		return;
+	aty128_do_resume(par->pdev);
+	release_console_sem();
+}
+#endif /* CONFIG_PPC_PMAC */
+
 static int __init aty128_init(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
@@ -1781,6 +1794,13 @@
 	var = default_var;
 #ifdef CONFIG_PPC_PMAC
 	if (_machine == _MACH_Pmac) {
+		/* Indicate sleep capability */
+		if (par->chip_gen == rage_M3) {
+			pmac_call_feature(PMAC_FTR_DEVICE_CAN_WAKE, NULL, 0, 1);
+			pmac_set_early_video_resume(aty128_early_resume, par);
+		}
+
+		/* Find default mode */
 		if (mode_option) {
 			if (!mac_find_mode(&var, info, mode_option, 8))
 				var = default_var;
@@ -2397,7 +2417,7 @@
 	return 0;
 }
 
-static int aty128_pci_resume(struct pci_dev *pdev)
+static int aty128_do_resume(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
@@ -2405,8 +2425,6 @@
 	if (pdev->dev.power.power_state == 0)
 		return 0;
 
-	acquire_console_sem();
-
 	/* Wakeup chip */
 	if (pdev->dev.power.power_state == 2)
 		aty128_set_suspend(par, 0);
@@ -2426,8 +2444,6 @@
 	par->lock_blank = 0;
 	aty128fb_blank(0, info);
 
-	release_console_sem();
-
 	pdev->dev.power.power_state = 0;
 
 	printk(KERN_DEBUG "aty128fb: resumed !\n");
@@ -2435,6 +2451,18 @@
 	return 0;
 }
 
+static int aty128_pci_resume(struct pci_dev *pdev)
+{
+	int rc;
+
+	acquire_console_sem();
+	rc = aty128_do_resume(pdev);
+	release_console_sem();
+
+	return rc;
+}
+
+
 int __init aty128fb_init(void)
 {
 #ifndef MODULE
diff -uNr linus-2.6.10/drivers/video/aty/radeon_base.c sleep-2.6.10/drivers/video/aty/radeon_base.c
--- linus-2.6.10/drivers/video/aty/radeon_base.c	2005-01-06 10:47:32.496253136 +0000
+++ sleep-2.6.10/drivers/video/aty/radeon_base.c	2005-01-06 11:58:41.282290464 +0000
@@ -1,5 +1,7 @@
+
 /*
- *	drivers/video/radeonfb.c
+ *	drivers/video/aty/radeon_base.c
+ *
  *	framebuffer driver for ATI Radeon chipset video boards
  *
  *	Copyright 2003	Ben. Herrenschmidt <benh@kernel.crashing.org>
@@ -75,7 +77,6 @@
 
 #ifdef CONFIG_PPC_OF
 
-#include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include "../macmodes.h"
 
@@ -150,8 +151,10 @@
 	CHIP_DEF(PCI_CHIP_RV250_Ig,	RV250,	CHIP_HAS_CRTC2),
 	/* Mobility 9100 IGP (U3) */
 	CHIP_DEF(PCI_CHIP_RS300_5835,	RS300,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RS350_7835,	RS300,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
 	/* 9100 IGP (A5) */
 	CHIP_DEF(PCI_CHIP_RS300_5834,	RS300,	CHIP_HAS_CRTC2 | CHIP_IS_IGP),
+	CHIP_DEF(PCI_CHIP_RS350_7834,	RS300,	CHIP_HAS_CRTC2 | CHIP_IS_IGP),
 	/* Mobility 9200 (M9+) */
 	CHIP_DEF(PCI_CHIP_RV280_5C61,	RV280,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
 	CHIP_DEF(PCI_CHIP_RV280_5C63,	RV280,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
@@ -194,6 +197,33 @@
 	CHIP_DEF(PCI_CHIP_R350_NI,	R350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R360_NJ,	R350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R350_NK,	R350,	CHIP_HAS_CRTC2),
+	/* Newer stuff */ 
+	CHIP_DEF(PCI_CHIP_RV380_3E50,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV380_3E54,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV380_3150,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV380_3154,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV370_5B60,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV370_5B62,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV370_5B64,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV370_5B65,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV370_5460,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV370_5464,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R420_JH,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JI,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JJ,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JK,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JL,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JM,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JN,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R420_JP,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UH,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UI,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UJ,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UK,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UQ,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UR,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UT,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_5D57,	R420,	CHIP_HAS_CRTC2),
 	/* Original Radeon/7200 */
 	CHIP_DEF(PCI_CHIP_RADEON_QD,	RADEON,	0),
 	CHIP_DEF(PCI_CHIP_RADEON_QE,	RADEON,	0),
@@ -233,6 +263,7 @@
 static char *mode_option;
 static char *monitor_layout;
 static int noaccel = 0;
+static int default_dynclk = 0;
 static int nomodeset = 0;
 static int ignore_edid = 0;
 static int mirror = 0;
@@ -317,7 +348,8 @@
 	
 	rom = ioremap(r->start, r->end - r->start + 1);
 	if (!rom) {
-		printk(KERN_ERR "radeonfb: ROM failed to map\n");
+		printk(KERN_ERR "radeonfb (%s): ROM failed to map\n",
+		       pci_name(rinfo->pdev));
 		return -ENOMEM;
 	}
 	
@@ -325,8 +357,8 @@
 
 	/* Very simple test to make sure it appeared */
 	if (BIOS_IN16(0) != 0xaa55) {
-		printk(KERN_ERR "radeonfb: Invalid ROM signature %x should be 0xaa55\n",
-		       BIOS_IN16(0));
+		printk(KERN_ERR "radeonfb (%s): Invalid ROM signature %x should be"
+		       "0xaa55\n", pci_name(rinfo->pdev), BIOS_IN16(0));
 		goto failed;
 	}
 	/* Look for the PCI data to check the ROM type */
@@ -357,8 +389,8 @@
 	 * } pci_data_t;
 	 */
 	if (BIOS_IN32(dptr) !=  (('R' << 24) | ('I' << 16) | ('C' << 8) | 'P')) {
-		printk(KERN_WARNING "radeonfb: PCI DATA signature in ROM incorrect: %08x\n",
-		       BIOS_IN32(dptr));
+		printk(KERN_WARNING "radeonfb (%s): PCI DATA signature in ROM"
+		       "incorrect: %08x\n", pci_name(rinfo->pdev), BIOS_IN32(dptr));
 		goto anyway;
 	}
 	rom_type = BIOS_IN8(dptr + 0x14);
@@ -425,14 +457,11 @@
  */
 static int __devinit radeon_read_xtal_OF (struct radeonfb_info *rinfo)
 {
-	struct device_node *dp;
+	struct device_node *dp = rinfo->of_node;
 	u32 *val;
 
-	dp = pci_device_to_OF_node(rinfo->pdev);
-	if (dp == NULL) {
-		printk(KERN_WARNING "radeonfb: Cannot match card to OF node !\n");
+	if (dp == NULL)
 		return -ENODEV;
-	}
 	val = (u32 *) get_property(dp, "ATY,RefCLK", NULL);
 	if (!val || !*val) {
 		printk(KERN_WARNING "radeonfb: No ATY,RefCLK property !\n");
@@ -515,20 +544,20 @@
 		denom = 1;
 		break;
 	case 1:
-		n = ((INPLL(X_MPLL_REF_FB_DIV) >> 16) & 0xff);
-		m = (INPLL(X_MPLL_REF_FB_DIV) & 0xff);
+		n = ((INPLL(M_SPLL_REF_FB_DIV) >> 16) & 0xff);
+		m = (INPLL(M_SPLL_REF_FB_DIV) & 0xff);
 		num = 2*n;
 		denom = 2*m;
 		break;
 	case 2:
-		n = ((INPLL(X_MPLL_REF_FB_DIV) >> 8) & 0xff);
-		m = (INPLL(X_MPLL_REF_FB_DIV) & 0xff);
+		n = ((INPLL(M_SPLL_REF_FB_DIV) >> 8) & 0xff);
+		m = (INPLL(M_SPLL_REF_FB_DIV) & 0xff);
 		num = 2*n;
 		denom = 2*m;
         break;
 	}
 
-	ppll_div_sel = INREG(CLOCK_CNTL_INDEX + 1) & 0x3;
+	ppll_div_sel = (INREG(CLOCK_CNTL_INDEX) >> 8) & 0x3;
 
 	n = (INPLL(PPLL_DIV_0 + ppll_div_sel) & 0x7ff);
 	m = (INPLL(PPLL_REF_DIV) & 0x3ff);
@@ -572,7 +601,7 @@
 		return -1;
 	}
 
-	tmp = INPLL(X_MPLL_REF_FB_DIV);
+	tmp = INPLL(M_SPLL_REF_FB_DIV);
 	ref_div = INPLL(PPLL_REF_DIV) & 0x3ff;
 
 	Ns = (tmp & 0xff0000) >> 16;
@@ -652,7 +681,7 @@
 		rinfo->pll.ref_clk = 2700;
 		break;
 	}
-	rinfo->pll.ref_div = INPLL(PPLL_REF_DIV) & 0x3ff;
+	rinfo->pll.ref_div = INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK;
 
 
 #ifdef CONFIG_PPC_OF
@@ -933,7 +962,7 @@
 }
 
 
-static int radeon_screen_blank (struct radeonfb_info *rinfo, int blank, int mode_switch)
+int radeon_screen_blank (struct radeonfb_info *rinfo, int blank, int mode_switch)
 {
         u32 val;
 	u32 tmp_pix_clks;
@@ -963,7 +1000,7 @@
         }
 	OUTREG(CRTC_EXT_CNTL, val);
 
-
+	radeon_fifo_wait(1);
 	switch (rinfo->mon1_type) {
 	case MT_DFP:
 		if (mode_switch)
@@ -1030,7 +1067,7 @@
 	return (blank == FB_BLANK_NORMAL) ? -EINVAL : 0;
 }
 
-int radeonfb_blank (int blank, struct fb_info *info)
+static int radeonfb_blank (int blank, struct fb_info *info)
 {
         struct radeonfb_info *rinfo = info->par;
 
@@ -1124,7 +1161,7 @@
 }
 
 
-static void radeon_save_state (struct radeonfb_info *rinfo, struct radeon_regs *save)
+void radeon_save_state (struct radeonfb_info *rinfo, struct radeon_regs *save)
 {
 	/* CRTC regs */
 	save->crtc_gen_cntl = INREG(CRTC_GEN_CNTL);
@@ -1148,8 +1185,14 @@
 	save->fp_vert_stretch = INREG(FP_VERT_STRETCH);
 	save->lvds_gen_cntl = INREG(LVDS_GEN_CNTL);
 	save->lvds_pll_cntl = INREG(LVDS_PLL_CNTL);
-	save->tmds_crc = INREG(TMDS_CRC);	save->tmds_transmitter_cntl = INREG(TMDS_TRANSMITTER_CNTL);
+	save->tmds_crc = INREG(TMDS_CRC);
+	save->tmds_transmitter_cntl = INREG(TMDS_TRANSMITTER_CNTL);
 	save->vclk_ecp_cntl = INPLL(VCLK_ECP_CNTL);
+
+	/* PLL regs */
+	save->clk_cntl_index = INREG(CLOCK_CNTL_INDEX) & ~0x3f;
+	save->ppll_div_3 = INPLL(PPLL_DIV_3);
+	save->ppll_ref_div = INPLL(PPLL_REF_DIV);
 }
 
 
@@ -1161,19 +1204,22 @@
 
 	/* Workaround from XFree */
 	if (rinfo->is_mobility) {
-	        /* A temporal workaround for the occational blanking on certain laptop panels. 
-	           This appears to related to the PLL divider registers (fail to lock?).  
-		   It occurs even when all dividers are the same with their old settings.  
-	           In this case we really don't need to fiddle with PLL registers. 
-	           By doing this we can avoid the blanking problem with some panels.
-	        */
+	        /* A temporal workaround for the occational blanking on certain laptop
+		 * panels. This appears to related to the PLL divider registers
+		 * (fail to lock?). It occurs even when all dividers are the same
+		 * with their old settings. In this case we really don't need to
+		 * fiddle with PLL registers. By doing this we can avoid the blanking
+		 * problem with some panels.
+	         */
 		if ((mode->ppll_ref_div == (INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK)) &&
 		    (mode->ppll_div_3 == (INPLL(PPLL_DIV_3) &
 					  (PPLL_POST3_DIV_MASK | PPLL_FB3_DIV_MASK)))) {
-			/* We still have to force a switch to PPLL div 3 thanks to
+			/* We still have to force a switch to selected PPLL div thanks to
 			 * an XFree86 driver bug which will switch it away in some cases
 			 * even when using UseFDev */
-			OUTREGP(CLOCK_CNTL_INDEX, PPLL_DIV_SEL_MASK, ~PPLL_DIV_SEL_MASK);
+			OUTREGP(CLOCK_CNTL_INDEX,
+				mode->clk_cntl_index & PPLL_DIV_SEL_MASK,
+				~PPLL_DIV_SEL_MASK);
             		return;
 		}
 	}
@@ -1186,8 +1232,10 @@
 		PPLL_RESET | PPLL_ATOMIC_UPDATE_EN | PPLL_VGA_ATOMIC_UPDATE_EN,
 		~(PPLL_RESET | PPLL_ATOMIC_UPDATE_EN | PPLL_VGA_ATOMIC_UPDATE_EN));
 
-	/* Switch to PPLL div 3 */
-	OUTREGP(CLOCK_CNTL_INDEX, PPLL_DIV_SEL_MASK, ~PPLL_DIV_SEL_MASK);
+	/* Switch to selected PPLL divider */
+	OUTREGP(CLOCK_CNTL_INDEX,
+		mode->clk_cntl_index & PPLL_DIV_SEL_MASK,
+		~PPLL_DIV_SEL_MASK);
 
 	/* Set PPLL ref. div */
 	if (rinfo->family == CHIP_FAMILY_R300 ||
@@ -1232,7 +1280,7 @@
 		~(PPLL_RESET | PPLL_SLEEP | PPLL_ATOMIC_UPDATE_EN | PPLL_VGA_ATOMIC_UPDATE_EN));
 
 	/* We may want some locking ... oh well */
-       	msleep(5);
+       	radeon_msleep(5);
 
 	/* Switch back VCLK source to PPLL */
 	OUTPLLP(VCLK_ECP_CNTL, VCLK_SRC_SEL_PPLLCLK, ~VCLK_SRC_SEL_MASK);
@@ -1245,21 +1293,17 @@
 {
 	struct radeonfb_info *rinfo = (struct radeonfb_info *)data;
 
-	radeon_fifo_wait(3);
+	radeon_engine_idle();
 
 	OUTREG(LVDS_GEN_CNTL, rinfo->pending_lvds_gen_cntl);
-	if (rinfo->pending_pixclks_cntl) {
-		OUTPLL(PIXCLKS_CNTL, rinfo->pending_pixclks_cntl);
-		rinfo->pending_pixclks_cntl = 0;
-	}
 }
 
 /*
  * Apply a video mode. This will apply the whole register set, including
  * the PLL registers, to the card
  */
-static void radeon_write_mode (struct radeonfb_info *rinfo,
-                               struct radeon_regs *mode)
+void radeon_write_mode (struct radeonfb_info *rinfo, struct radeon_regs *mode,
+			int regs_only)
 {
 	int i;
 	int primary_mon = PRIMARY_MONITOR(rinfo);
@@ -1267,11 +1311,11 @@
 	if (nomodeset)
 		return;
 
-	del_timer_sync(&rinfo->lvds_timer);
-
-	radeon_screen_blank(rinfo, FB_BLANK_POWERDOWN, 1);
-	msleep(100);
-
+	if (!regs_only) {
+		del_timer_sync(&rinfo->lvds_timer);
+		radeon_screen_blank(rinfo, FB_BLANK_POWERDOWN, 1);
+		radeon_msleep(100);
+	}
 	radeon_fifo_wait(31);
 	for (i=0; i<10; i++)
 		OUTREG(common_regs[i].reg, common_regs[i].val);
@@ -1423,6 +1467,16 @@
 	       rinfo->pll.ref_div, rinfo->pll.ref_clk,
 	       pll_output_freq);
 
+	/* If we fall through the bottom, try the "default value"
+	   given by the terminal post_div->bitvalue */
+	if ( !post_div->divider ) {
+		post_div = &post_divs[post_div->bitvalue];
+		pll_output_freq = post_div->divider * freq;
+	}
+	RTRACE("ref_div = %d, ref_clk = %d, output_freq = %d\n",
+	       rinfo->pll.ref_div, rinfo->pll.ref_clk,
+	       pll_output_freq);
+
 	fb_div = round_div(rinfo->pll.ref_div*pll_output_freq,
 				  rinfo->pll.ref_clk);
 	regs->ppll_ref_div = rinfo->pll.ref_div;
@@ -1433,22 +1487,27 @@
 	RTRACE("ppll_div_3 = 0x%x\n", regs->ppll_div_3);
 }
 
-int radeonfb_set_par(struct fb_info *info)
+static int radeonfb_set_par(struct fb_info *info)
 {
 	struct radeonfb_info *rinfo = info->par;
 	struct fb_var_screeninfo *mode = &info->var;
-	struct radeon_regs newmode;
+	struct radeon_regs *newmode;
 	int hTotal, vTotal, hSyncStart, hSyncEnd,
 	    hSyncPol, vSyncStart, vSyncEnd, vSyncPol, cSync;
 	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
 	u8 hsync_fudge_fp[] = {2, 2, 0, 0, 5, 5};
 	u32 sync, h_sync_pol, v_sync_pol, dotClock, pixClock;
 	int i, freq;
-        int format = 0;
+	int format = 0;
 	int nopllcalc = 0;
 	int hsync_start, hsync_fudge, bytpp, hsync_wid, vsync_wid;
 	int primary_mon = PRIMARY_MONITOR(rinfo);
 	int depth = var_to_depth(mode);
+	int use_rmx = 0;
+
+	newmode = kmalloc(sizeof(struct radeon_regs), GFP_KERNEL);
+	if (!newmode)
+		return -ENOMEM;
 
 	/* We always want engine to be idle on a mode switch, even
 	 * if we won't actually change the mode
@@ -1489,9 +1548,9 @@
 
 		if (rinfo->panel_info.use_bios_dividers) {
 			nopllcalc = 1;
-			newmode.ppll_div_3 = rinfo->panel_info.fbk_divider |
+			newmode->ppll_div_3 = rinfo->panel_info.fbk_divider |
 				(rinfo->panel_info.post_divider << 16);
-			newmode.ppll_ref_div = rinfo->panel_info.ref_divider;
+			newmode->ppll_ref_div = rinfo->panel_info.ref_divider;
 		}
 	}
 	dotClock = 1000000000 / pixClock;
@@ -1529,38 +1588,38 @@
 
 	hsync_start = hSyncStart - 8 + hsync_fudge;
 
-	newmode.crtc_gen_cntl = CRTC_EXT_DISP_EN | CRTC_EN |
+	newmode->crtc_gen_cntl = CRTC_EXT_DISP_EN | CRTC_EN |
 				(format << 8);
 
 	/* Clear auto-center etc... */
-	newmode.crtc_more_cntl = rinfo->init_state.crtc_more_cntl;
-	newmode.crtc_more_cntl &= 0xfffffff0;
+	newmode->crtc_more_cntl = rinfo->init_state.crtc_more_cntl;
+	newmode->crtc_more_cntl &= 0xfffffff0;
 	
 	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
-		newmode.crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN;
+		newmode->crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN;
 		if (mirror)
-			newmode.crtc_ext_cntl |= CRTC_CRT_ON;
+			newmode->crtc_ext_cntl |= CRTC_CRT_ON;
 
-		newmode.crtc_gen_cntl &= ~(CRTC_DBL_SCAN_EN |
+		newmode->crtc_gen_cntl &= ~(CRTC_DBL_SCAN_EN |
 					   CRTC_INTERLACE_EN);
 	} else {
-		newmode.crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN |
+		newmode->crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN |
 					CRTC_CRT_ON;
 	}
 
-	newmode.dac_cntl = /* INREG(DAC_CNTL) | */ DAC_MASK_ALL | DAC_VGA_ADR_EN |
+	newmode->dac_cntl = /* INREG(DAC_CNTL) | */ DAC_MASK_ALL | DAC_VGA_ADR_EN |
 			   DAC_8BIT_EN;
 
-	newmode.crtc_h_total_disp = ((((hTotal / 8) - 1) & 0x3ff) |
+	newmode->crtc_h_total_disp = ((((hTotal / 8) - 1) & 0x3ff) |
 				     (((mode->xres / 8) - 1) << 16));
 
-	newmode.crtc_h_sync_strt_wid = ((hsync_start & 0x1fff) |
+	newmode->crtc_h_sync_strt_wid = ((hsync_start & 0x1fff) |
 					(hsync_wid << 16) | (h_sync_pol << 23));
 
-	newmode.crtc_v_total_disp = ((vTotal - 1) & 0xffff) |
+	newmode->crtc_v_total_disp = ((vTotal - 1) & 0xffff) |
 				    ((mode->yres - 1) << 16);
 
-	newmode.crtc_v_sync_strt_wid = (((vSyncStart - 1) & 0xfff) |
+	newmode->crtc_v_sync_strt_wid = (((vSyncStart - 1) & 0xfff) |
 					 (vsync_wid << 16) | (v_sync_pol  << 23));
 
 	if (!(info->flags & FBINFO_HWACCEL_DISABLED)) {
@@ -1569,18 +1628,18 @@
  				& ~(0x3f)) >> 6;
 
 		/* Then, re-multiply it to get the CRTC pitch */
-		newmode.crtc_pitch = (rinfo->pitch << 3) / ((mode->bits_per_pixel + 1) / 8);
+		newmode->crtc_pitch = (rinfo->pitch << 3) / ((mode->bits_per_pixel + 1) / 8);
 	} else
-		newmode.crtc_pitch = (mode->xres_virtual >> 3);
+		newmode->crtc_pitch = (mode->xres_virtual >> 3);
 
-	newmode.crtc_pitch |= (newmode.crtc_pitch << 16);
+	newmode->crtc_pitch |= (newmode->crtc_pitch << 16);
 
 	/*
 	 * It looks like recent chips have a problem with SURFACE_CNTL,
 	 * setting SURF_TRANSLATION_DIS completely disables the
 	 * swapper as well, so we leave it unset now.
 	 */
-	newmode.surface_cntl = 0;
+	newmode->surface_cntl = 0;
 
 #if defined(__BIG_ENDIAN)
 
@@ -1590,28 +1649,28 @@
 	 */
 	switch (mode->bits_per_pixel) {
 		case 16:
-			newmode.surface_cntl |= NONSURF_AP0_SWP_16BPP;
-			newmode.surface_cntl |= NONSURF_AP1_SWP_16BPP;
+			newmode->surface_cntl |= NONSURF_AP0_SWP_16BPP;
+			newmode->surface_cntl |= NONSURF_AP1_SWP_16BPP;
 			break;
 		case 24:	
 		case 32:
-			newmode.surface_cntl |= NONSURF_AP0_SWP_32BPP;
-			newmode.surface_cntl |= NONSURF_AP1_SWP_32BPP;
+			newmode->surface_cntl |= NONSURF_AP0_SWP_32BPP;
+			newmode->surface_cntl |= NONSURF_AP1_SWP_32BPP;
 			break;
 	}
 #endif
 
 	/* Clear surface registers */
 	for (i=0; i<8; i++) {
-		newmode.surf_lower_bound[i] = 0;
-		newmode.surf_upper_bound[i] = 0x1f;
-		newmode.surf_info[i] = 0;
+		newmode->surf_lower_bound[i] = 0;
+		newmode->surf_upper_bound[i] = 0x1f;
+		newmode->surf_info[i] = 0;
 	}
 
 	RTRACE("h_total_disp = 0x%x\t   hsync_strt_wid = 0x%x\n",
-		newmode.crtc_h_total_disp, newmode.crtc_h_sync_strt_wid);
+		newmode->crtc_h_total_disp, newmode->crtc_h_sync_strt_wid);
 	RTRACE("v_total_disp = 0x%x\t   vsync_strt_wid = 0x%x\n",
-		newmode.crtc_v_total_disp, newmode.crtc_v_sync_strt_wid);
+		newmode->crtc_v_total_disp, newmode->crtc_v_sync_strt_wid);
 
 	rinfo->bpp = mode->bits_per_pixel;
 	rinfo->depth = depth;
@@ -1619,10 +1678,14 @@
 	RTRACE("pixclock = %lu\n", (unsigned long)pixClock);
 	RTRACE("freq = %lu\n", (unsigned long)freq);
 
+	/* We use PPLL_DIV_3 */
+	newmode->clk_cntl_index = 0x300;
+
+	/* Calculate PPLL value if necessary */
 	if (!nopllcalc)
-		radeon_calc_pll_regs(rinfo, &newmode, freq);
+		radeon_calc_pll_regs(rinfo, newmode, freq);
 
-	newmode.vclk_ecp_cntl = rinfo->init_state.vclk_ecp_cntl;
+	newmode->vclk_ecp_cntl = rinfo->init_state.vclk_ecp_cntl;
 
 	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
 		unsigned int hRatio, vRatio;
@@ -1632,35 +1695,37 @@
 		if (mode->yres > rinfo->panel_info.yres)
 			mode->yres = rinfo->panel_info.yres;
 
-		newmode.fp_horz_stretch = (((rinfo->panel_info.xres / 8) - 1)
+		newmode->fp_horz_stretch = (((rinfo->panel_info.xres / 8) - 1)
 					   << HORZ_PANEL_SHIFT);
-		newmode.fp_vert_stretch = ((rinfo->panel_info.yres - 1)
+		newmode->fp_vert_stretch = ((rinfo->panel_info.yres - 1)
 					   << VERT_PANEL_SHIFT);
 
 		if (mode->xres != rinfo->panel_info.xres) {
 			hRatio = round_div(mode->xres * HORZ_STRETCH_RATIO_MAX,
 					   rinfo->panel_info.xres);
-			newmode.fp_horz_stretch = (((((unsigned long)hRatio) & HORZ_STRETCH_RATIO_MASK)) |
-						   (newmode.fp_horz_stretch &
+			newmode->fp_horz_stretch = (((((unsigned long)hRatio) & HORZ_STRETCH_RATIO_MASK)) |
+						   (newmode->fp_horz_stretch &
 						    (HORZ_PANEL_SIZE | HORZ_FP_LOOP_STRETCH |
 						     HORZ_AUTO_RATIO_INC)));
-			newmode.fp_horz_stretch |= (HORZ_STRETCH_BLEND |
+			newmode->fp_horz_stretch |= (HORZ_STRETCH_BLEND |
 						    HORZ_STRETCH_ENABLE);
+			use_rmx = 1;
 		}
-		newmode.fp_horz_stretch &= ~HORZ_AUTO_RATIO;
+		newmode->fp_horz_stretch &= ~HORZ_AUTO_RATIO;
 
 		if (mode->yres != rinfo->panel_info.yres) {
 			vRatio = round_div(mode->yres * VERT_STRETCH_RATIO_MAX,
 					   rinfo->panel_info.yres);
-			newmode.fp_vert_stretch = (((((unsigned long)vRatio) & VERT_STRETCH_RATIO_MASK)) |
-						   (newmode.fp_vert_stretch &
+			newmode->fp_vert_stretch = (((((unsigned long)vRatio) & VERT_STRETCH_RATIO_MASK)) |
+						   (newmode->fp_vert_stretch &
 						   (VERT_PANEL_SIZE | VERT_STRETCH_RESERVED)));
-			newmode.fp_vert_stretch |= (VERT_STRETCH_BLEND |
+			newmode->fp_vert_stretch |= (VERT_STRETCH_BLEND |
 						    VERT_STRETCH_ENABLE);
+			use_rmx = 1;
 		}
-		newmode.fp_vert_stretch &= ~VERT_AUTO_RATIO_EN;
+		newmode->fp_vert_stretch &= ~VERT_AUTO_RATIO_EN;
 
-		newmode.fp_gen_cntl = (rinfo->init_state.fp_gen_cntl & (u32)
+		newmode->fp_gen_cntl = (rinfo->init_state.fp_gen_cntl & (u32)
 				       ~(FP_SEL_CRTC2 |
 					 FP_RMX_HVSYNC_CONTROL_EN |
 					 FP_DFP_SYNC_SEL |
@@ -1670,46 +1735,56 @@
 					 FP_CRTC_USE_SHADOW_VEND |
 					 FP_CRT_SYNC_ALT));
 
-		newmode.fp_gen_cntl |= (FP_CRTC_DONT_SHADOW_VPAR |
-					FP_CRTC_DONT_SHADOW_HEND);
-
-		newmode.lvds_gen_cntl = rinfo->init_state.lvds_gen_cntl;
-		newmode.lvds_pll_cntl = rinfo->init_state.lvds_pll_cntl;
-		newmode.tmds_crc = rinfo->init_state.tmds_crc;
-		newmode.tmds_transmitter_cntl = rinfo->init_state.tmds_transmitter_cntl;
+		newmode->fp_gen_cntl |= (FP_CRTC_DONT_SHADOW_VPAR |
+					FP_CRTC_DONT_SHADOW_HEND |
+					FP_PANEL_FORMAT);
+
+		if (IS_R300_VARIANT(rinfo) ||
+		    (rinfo->family == CHIP_FAMILY_R200)) {
+			newmode->fp_gen_cntl &= ~R200_FP_SOURCE_SEL_MASK;
+			if (use_rmx)
+				newmode->fp_gen_cntl |= R200_FP_SOURCE_SEL_RMX;
+			else
+				newmode->fp_gen_cntl |= R200_FP_SOURCE_SEL_CRTC1;
+		} else 
+			newmode->fp_gen_cntl |= FP_SEL_CRTC1;
+
+		newmode->lvds_gen_cntl = rinfo->init_state.lvds_gen_cntl;
+		newmode->lvds_pll_cntl = rinfo->init_state.lvds_pll_cntl;
+		newmode->tmds_crc = rinfo->init_state.tmds_crc;
+		newmode->tmds_transmitter_cntl = rinfo->init_state.tmds_transmitter_cntl;
 
 		if (primary_mon == MT_LCD) {
-			newmode.lvds_gen_cntl |= (LVDS_ON | LVDS_BLON);
-			newmode.fp_gen_cntl &= ~(FP_FPON | FP_TMDS_EN);
+			newmode->lvds_gen_cntl |= (LVDS_ON | LVDS_BLON);
+			newmode->fp_gen_cntl &= ~(FP_FPON | FP_TMDS_EN);
 		} else {
 			/* DFP */
-			newmode.fp_gen_cntl |= (FP_FPON | FP_TMDS_EN);
-			newmode.tmds_transmitter_cntl = (TMDS_RAN_PAT_RST | TMDS_ICHCSEL) &
+			newmode->fp_gen_cntl |= (FP_FPON | FP_TMDS_EN);
+			newmode->tmds_transmitter_cntl = (TMDS_RAN_PAT_RST | TMDS_ICHCSEL) &
 							 ~(TMDS_PLLRST);
 			/* TMDS_PLL_EN bit is reversed on RV (and mobility) chips */
-			if ((rinfo->family == CHIP_FAMILY_R300) ||
-			    (rinfo->family == CHIP_FAMILY_R350) ||
-			    (rinfo->family == CHIP_FAMILY_RV350) ||
+			if (IS_R300_VARIANT(rinfo) ||
 			    (rinfo->family == CHIP_FAMILY_R200) || !rinfo->has_CRTC2)
-				newmode.tmds_transmitter_cntl &= ~TMDS_PLL_EN;
+				newmode->tmds_transmitter_cntl &= ~TMDS_PLL_EN;
 			else
-				newmode.tmds_transmitter_cntl |= TMDS_PLL_EN;
-			newmode.crtc_ext_cntl &= ~CRTC_CRT_ON;
+				newmode->tmds_transmitter_cntl |= TMDS_PLL_EN;
+			newmode->crtc_ext_cntl &= ~CRTC_CRT_ON;
 		}
 
-		newmode.fp_crtc_h_total_disp = (((rinfo->panel_info.hblank / 8) & 0x3ff) |
+		newmode->fp_crtc_h_total_disp = (((rinfo->panel_info.hblank / 8) & 0x3ff) |
 				(((mode->xres / 8) - 1) << 16));
-		newmode.fp_crtc_v_total_disp = (rinfo->panel_info.vblank & 0xffff) |
+		newmode->fp_crtc_v_total_disp = (rinfo->panel_info.vblank & 0xffff) |
 				((mode->yres - 1) << 16);
-		newmode.fp_h_sync_strt_wid = ((rinfo->panel_info.hOver_plus & 0x1fff) |
+		newmode->fp_h_sync_strt_wid = ((rinfo->panel_info.hOver_plus & 0x1fff) |
 				(hsync_wid << 16) | (h_sync_pol << 23));
-		newmode.fp_v_sync_strt_wid = ((rinfo->panel_info.vOver_plus & 0xfff) |
+		newmode->fp_v_sync_strt_wid = ((rinfo->panel_info.vOver_plus & 0xfff) |
 				(vsync_wid << 16) | (v_sync_pol  << 23));
 	}
 
 	/* do it! */
 	if (!rinfo->asleep) {
-		radeon_write_mode (rinfo, &newmode);
+		memcpy(&rinfo->state, newmode, sizeof(*newmode));
+		radeon_write_mode (rinfo, newmode, 0);
 		/* (re)initialize the engine */
 		if (!(info->flags & FBINFO_HWACCEL_DISABLED))
 			radeonfb_engine_init (rinfo);
@@ -1729,6 +1804,7 @@
 			     rinfo->depth, info->fix.line_length);
 #endif
 
+	kfree(newmode);
 	return 0;
 }
 
@@ -1838,12 +1914,14 @@
 	if (on && (level > BACKLIGHT_OFF)) {
 		lvds_gen_cntl &= ~LVDS_DISPLAY_DIS;
 		if (!(lvds_gen_cntl & LVDS_BLON) || !(lvds_gen_cntl & LVDS_ON)) {
-			lvds_gen_cntl |= LVDS_BLON /* | LVDS_EN | LVDS_DIGON */;
+			lvds_gen_cntl |= (rinfo->init_state.lvds_gen_cntl & LVDS_DIGON);
+			lvds_gen_cntl |= LVDS_BLON | LVDS_EN;
 			OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
 			lvds_gen_cntl &= ~LVDS_BL_MOD_LEVEL_MASK;
 			lvds_gen_cntl |= (conv_table[level] <<
 					  LVDS_BL_MOD_LEVEL_SHIFT);
 			lvds_gen_cntl |= LVDS_ON;
+			lvds_gen_cntl |= (rinfo->init_state.lvds_gen_cntl & LVDS_BL_MOD_EN);
 			rinfo->pending_lvds_gen_cntl = lvds_gen_cntl;
 			mod_timer(&rinfo->lvds_timer,
 				  jiffies + msecs_to_jiffies(rinfo->panel_info.pwr_delay));
@@ -1863,13 +1941,17 @@
 		tmpPixclksCntl = INPLL(PIXCLKS_CNTL);
 		if (rinfo->is_mobility || rinfo->is_IGP)
 			OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
-		lvds_gen_cntl &= ~LVDS_BL_MOD_LEVEL_MASK;
+		lvds_gen_cntl &= ~(LVDS_BL_MOD_LEVEL_MASK | LVDS_BL_MOD_EN);
 		lvds_gen_cntl |= (conv_table[0] <<
 				  LVDS_BL_MOD_LEVEL_SHIFT);
 		lvds_gen_cntl |= LVDS_DISPLAY_DIS;
 		OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
-		lvds_gen_cntl &= ~(LVDS_ON | LVDS_BLON /* | LVDS_EN | LVDS_DIGON */);
-		OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
+		lvds_gen_cntl &= ~(LVDS_DIGON);
+		rinfo->pending_lvds_gen_cntl = lvds_gen_cntl;
+		mod_timer(&rinfo->lvds_timer,
+			  jiffies + msecs_to_jiffies(rinfo->panel_info.pwr_delay));
+		if (rinfo->is_mobility || rinfo->is_IGP)
+			OUTPLL(PIXCLKS_CNTL, tmpPixclksCntl);
 		if (rinfo->is_mobility || rinfo->is_IGP)
 			OUTPLL(PIXCLKS_CNTL, tmpPixclksCntl);
 	}
@@ -1952,10 +2034,12 @@
 	OUTREG(DISPLAY_BASE_ADDR, aper_base);
 	if (rinfo->has_CRTC2)
 		OUTREG(CRTC2_DISPLAY_BASE_ADDR, aper_base);
+	OUTREG(OV0_BASE_ADDR, aper_base);
 #else
 	OUTREG(DISPLAY_BASE_ADDR, 0);
 	if (rinfo->has_CRTC2)
 		OUTREG(CRTC2_DISPLAY_BASE_ADDR, 0);
+	OUTREG(OV0_BASE_ADDR, 0);
 #endif
 	mdelay(100);
 
@@ -1973,6 +2057,100 @@
 #endif /* CONFIG_PPC_OF */
 
 
+static void radeon_identify_vram(struct radeonfb_info *rinfo)
+{
+	u32 tmp;
+
+	/* framebuffer size */
+        if ((rinfo->family == CHIP_FAMILY_RS100) ||
+            (rinfo->family == CHIP_FAMILY_RS200) ||
+            (rinfo->family == CHIP_FAMILY_RS300)) {
+          u32 tom = INREG(NB_TOM);
+          tmp = ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
+ 
+ 		radeon_fifo_wait(6);
+          OUTREG(MC_FB_LOCATION, tom);
+          OUTREG(DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
+          OUTREG(CRTC2_DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
+          OUTREG(OV0_BASE_ADDR, (tom & 0xffff) << 16);
+ 
+          /* This is supposed to fix the crtc2 noise problem. */
+          OUTREG(GRPH2_BUFFER_CNTL, INREG(GRPH2_BUFFER_CNTL) & ~0x7f0000);
+ 
+          if ((rinfo->family == CHIP_FAMILY_RS100) ||
+              (rinfo->family == CHIP_FAMILY_RS200)) {
+             /* This is to workaround the asic bug for RMX, some versions
+                of BIOS dosen't have this register initialized correctly.
+             */
+             OUTREGP(CRTC_MORE_CNTL, CRTC_H_CUTOFF_ACTIVE_EN,
+                     ~CRTC_H_CUTOFF_ACTIVE_EN);
+          }
+        } else {
+          tmp = INREG(CONFIG_MEMSIZE);
+        }
+
+	/* mem size is bits [28:0], mask off the rest */
+	rinfo->video_ram = tmp & CONFIG_MEMSIZE_MASK;
+
+	/*
+	 * Hack to get around some busted production M6's
+	 * reporting no ram
+	 */
+	if (rinfo->video_ram == 0) {
+		switch (rinfo->pdev->device) {
+	       	case PCI_CHIP_RADEON_LY:
+		case PCI_CHIP_RADEON_LZ:
+	       		rinfo->video_ram = 8192 * 1024;
+	       		break;
+	       	default:
+	       		break;
+		}
+	}
+
+
+	/*
+	 * Now try to identify VRAM type
+	 */
+	if (rinfo->is_IGP || (rinfo->family >= CHIP_FAMILY_R300) ||
+	    (INREG(MEM_SDRAM_MODE_REG) & (1<<30)))
+		rinfo->vram_ddr = 1;
+	else
+		rinfo->vram_ddr = 0;
+
+	tmp = INREG(MEM_CNTL);
+	if (IS_R300_VARIANT(rinfo)) {
+		tmp &=  R300_MEM_NUM_CHANNELS_MASK;
+		switch (tmp) {
+		case 0:  rinfo->vram_width = 64; break;
+		case 1:  rinfo->vram_width = 128; break;
+		case 2:  rinfo->vram_width = 256; break;
+		default: rinfo->vram_width = 128; break;
+		}
+	} else if ((rinfo->family == CHIP_FAMILY_RV100) ||
+		   (rinfo->family == CHIP_FAMILY_RS100) ||
+		   (rinfo->family == CHIP_FAMILY_RS200)){
+		if (tmp & RV100_MEM_HALF_MODE)
+			rinfo->vram_width = 32;
+		else
+			rinfo->vram_width = 64;
+	} else {
+		if (tmp & MEM_NUM_CHANNELS_MASK)
+			rinfo->vram_width = 128;
+		else
+			rinfo->vram_width = 64;
+	}
+
+	/* This may not be correct, as some cards can have half of channel disabled 
+	 * ToDo: identify these cases
+	 */
+
+	RTRACE("radeonfb (%s): Found %ldk of %s %d bits wide videoram\n",
+	       pci_name(rinfo->pdev),
+	       rinfo->video_ram / 1024,
+	       rinfo->vram_ddr ? "DDR" : "SDRAM",
+	       rinfo->vram_width);
+}
+
 /*
  * Sysfs
  */
@@ -2038,7 +2216,6 @@
 {
 	struct fb_info *info;
 	struct radeonfb_info *rinfo;
-	u32 tmp;
 	int ret;
 
 	RTRACE("radeonfb_pci_register BEGIN\n");
@@ -2046,13 +2223,15 @@
 	/* Enable device in PCI config */
 	ret = pci_enable_device(pdev);
 	if (ret < 0) {
-		printk(KERN_ERR "radeonfb: Cannot enable PCI device\n");
+		printk(KERN_ERR "radeonfb (%s): Cannot enable PCI device\n",
+		       pci_name(pdev));
 		goto err_out;
 	}
 
 	info = framebuffer_alloc(sizeof(struct radeonfb_info), &pdev->dev);
 	if (!info) {
-		printk (KERN_ERR "radeonfb: could not allocate memory\n");
+		printk (KERN_ERR "radeonfb (%s): could not allocate memory\n",
+			pci_name(pdev));
 		ret = -ENOMEM;
 		goto err_disable;
 	}
@@ -2081,121 +2260,39 @@
 	/* request the mem regions */
 	ret = pci_request_regions(pdev, "radeonfb");
 	if (ret < 0) {
-		printk( KERN_ERR "radeonfb: cannot reserve PCI regions."
-			"  Someone already got them?\n");
+		printk( KERN_ERR "radeonfb (%s): cannot reserve PCI regions."
+			"  Someone already got them?\n", pci_name(rinfo->pdev));
 		goto err_release_fb;
 	}
 
 	/* map the regions */
 	rinfo->mmio_base = ioremap(rinfo->mmio_base_phys, RADEON_REGSIZE);
 	if (!rinfo->mmio_base) {
-		printk(KERN_ERR "radeonfb: cannot map MMIO\n");
+		printk(KERN_ERR "radeonfb (%s): cannot map MMIO\n", pci_name(rinfo->pdev));
 		ret = -EIO;
 		goto err_release_pci;
 	}
 
+	rinfo->fb_local_base = INREG(MC_FB_LOCATION) << 16;
+
+#ifdef CONFIG_PPC_OF
+	/* On PPC, we obtain the OF device-node pointer to the firmware
+	 * data for this chip
+	 */
+	rinfo->of_node = pci_device_to_OF_node(pdev);
+	if (rinfo->of_node == NULL)
+		printk(KERN_WARNING "radeonfb (%s): Cannot match card to OF node !\n",
+		       pci_name(rinfo->pdev));
+
 	/* On PPC, the firmware sets up a memory mapping that tends
 	 * to cause lockups when enabling the engine. We reconfigure
 	 * the card internal memory mappings properly
 	 */
-#ifdef CONFIG_PPC_OF
 	fixup_memory_mappings(rinfo);
-#else	
-	rinfo->fb_local_base = INREG(MC_FB_LOCATION) << 16;
 #endif /* CONFIG_PPC_OF */
 
-	/* framebuffer size */
-        if ((rinfo->family == CHIP_FAMILY_RS100) ||
-            (rinfo->family == CHIP_FAMILY_RS200) ||
-            (rinfo->family == CHIP_FAMILY_RS300)) {
-          u32 tom = INREG(NB_TOM);
-          tmp = ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
- 
- 		radeon_fifo_wait(6);
-          OUTREG(MC_FB_LOCATION, tom);
-          OUTREG(DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
-          OUTREG(CRTC2_DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
-          OUTREG(OV0_BASE_ADDR, (tom & 0xffff) << 16);
- 
-          /* This is supposed to fix the crtc2 noise problem. */
-          OUTREG(GRPH2_BUFFER_CNTL, INREG(GRPH2_BUFFER_CNTL) & ~0x7f0000);
- 
-          if ((rinfo->family == CHIP_FAMILY_RS100) ||
-              (rinfo->family == CHIP_FAMILY_RS200)) {
-             /* This is to workaround the asic bug for RMX, some versions
-                of BIOS dosen't have this register initialized correctly.
-             */
-             OUTREGP(CRTC_MORE_CNTL, CRTC_H_CUTOFF_ACTIVE_EN,
-                     ~CRTC_H_CUTOFF_ACTIVE_EN);
-          }
-        } else {
-          tmp = INREG(CONFIG_MEMSIZE);
-        }
-
-	/* mem size is bits [28:0], mask off the rest */
-	rinfo->video_ram = tmp & CONFIG_MEMSIZE_MASK;
-
-	/* ram type */
-	tmp = INREG(MEM_SDRAM_MODE_REG);
-	switch ((MEM_CFG_TYPE & tmp) >> 30) {
-       	case 0:
-       		/* SDR SGRAM (2:1) */
-       		strcpy(rinfo->ram_type, "SDR SGRAM");
-       		rinfo->ram.ml = 4;
-       		rinfo->ram.mb = 4;
-       		rinfo->ram.trcd = 1;
-       		rinfo->ram.trp = 2;
-       		rinfo->ram.twr = 1;
-       		rinfo->ram.cl = 2;
-       		rinfo->ram.loop_latency = 16;
-       		rinfo->ram.rloop = 16;
-       		break;
-       	case 1:
-       		/* DDR SGRAM */
-       		strcpy(rinfo->ram_type, "DDR SGRAM");
-       		rinfo->ram.ml = 4;
-       		rinfo->ram.mb = 4;
-       		rinfo->ram.trcd = 3;
-       		rinfo->ram.trp = 3;
-       		rinfo->ram.twr = 2;
-       		rinfo->ram.cl = 3;
-       		rinfo->ram.tr2w = 1;
-       		rinfo->ram.loop_latency = 16;
-       		rinfo->ram.rloop = 16;
-		break;
-       	default:
-       		/* 64-bit SDR SGRAM */
-       		strcpy(rinfo->ram_type, "SDR SGRAM 64");
-       		rinfo->ram.ml = 4;
-       		rinfo->ram.mb = 8;
-       		rinfo->ram.trcd = 3;
-       		rinfo->ram.trp = 3;
-       		rinfo->ram.twr = 1;
-       		rinfo->ram.cl = 3;
-       		rinfo->ram.tr2w = 1;
-       		rinfo->ram.loop_latency = 17;
-       		rinfo->ram.rloop = 17;
-		break;
-	}
-
-	/*
-	 * Hack to get around some busted production M6's
-	 * reporting no ram
-	 */
-	if (rinfo->video_ram == 0) {
-		switch (pdev->device) {
-	       	case PCI_CHIP_RADEON_LY:
-		case PCI_CHIP_RADEON_LZ:
-	       		rinfo->video_ram = 8192 * 1024;
-	       		break;
-	       	default:
-			printk (KERN_ERR "radeonfb: no video RAM reported\n");
-			ret = -ENXIO;
-			goto err_unmap_rom;
-		}
-	}
-
-	RTRACE("radeonfb: probed %s %ldk videoram\n", (rinfo->ram_type), (rinfo->video_ram/1024));
+	/* Get VRAM size and type */
+	radeon_identify_vram(rinfo);
 
 	rinfo->mapped_vram = min_t(unsigned long, MAX_MAPPED_VRAM, rinfo->video_ram);
 
@@ -2208,12 +2305,13 @@
 	if (rinfo->fb_base)
 		memset_io(rinfo->fb_base, 0, rinfo->mapped_vram);
 	else {
-		printk (KERN_ERR "radeonfb: cannot map FB\n");
+		printk (KERN_ERR "radeonfb (%s): cannot map FB\n", pci_name(rinfo->pdev));
 		ret = -EIO;
 		goto err_unmap_rom;
 	}
 
-	RTRACE("radeonfb: mapped %ldk videoram\n", rinfo->mapped_vram/1024);
+	RTRACE("radeonfb (%s): mapped %ldk videoram\n", pci_name(rinfo->pdev),
+	       rinfo->mapped_vram/1024);
 
 	/*
 	 * Check for required workaround for PLL accesses
@@ -2280,21 +2378,27 @@
 	 * so we can restore this upon __exit
 	 */
 	radeon_save_state (rinfo, &rinfo->init_state);
+	memcpy(&rinfo->state, &rinfo->init_state, sizeof(struct radeon_regs));
 
 	pci_set_drvdata(pdev, info);
 
-	/* Enable PM on mobility chips */
-	if (rinfo->is_mobility) {
-		/* Find PM registers in config space */
-		rinfo->pm_reg = pci_find_capability(pdev, PCI_CAP_ID_PM);
-		/* Enable dynamic PM of chip clocks */
-		radeon_pm_enable_dynamic_mode(rinfo);
-		printk("radeonfb: Power Management enabled for Mobility chipsets\n");
+	/* Setup Power Management capabilities */
+	switch(default_dynclk) {
+	case 0:
+		radeonfb_pm_init(rinfo, rinfo->is_mobility);
+		break;
+	case 1:
+		radeonfb_pm_init(rinfo, 1);
+		break;
+	default:
+		radeonfb_pm_init(rinfo, 0);
 	}
 
+	/* Register with fbdev layer */
 	ret = register_framebuffer(info);
 	if (ret < 0) {
-		printk (KERN_ERR "radeonfb: could not register framebuffer\n");
+		printk (KERN_ERR "radeonfb (%s): could not register framebuffer\n",
+			pci_name(rinfo->pdev));
 		goto err_unmap_fb;
 	}
 
@@ -2313,8 +2417,7 @@
 	}
 #endif
 
-	printk ("radeonfb: %s %s %ld MB\n", rinfo->name, rinfo->ram_type,
-		(rinfo->video_ram/(1024*1024)));
+	printk ("radeonfb (%s): %s\n", pci_name(rinfo->pdev), rinfo->name);
 
 	if (rinfo->bios_seg)
 		radeon_unmap_ROM(rinfo, pdev);
@@ -2357,12 +2460,14 @@
         if (!rinfo)
                 return;
  
+	radeonfb_pm_exit(rinfo);
+
 	/* restore original state
 	 * 
 	 * Doesn't quite work yet, possibly because of the PPC hacking
 	 * I do on startup, disable for now. --BenH
 	 */
-        radeon_write_mode (rinfo, &rinfo->init_state);
+        radeon_write_mode (rinfo, &rinfo->init_state, 1);
  
 	del_timer_sync(&rinfo->lvds_timer);
 
@@ -2469,6 +2574,8 @@
 MODULE_DESCRIPTION("framebuffer driver for ATI Radeon chipset");
 MODULE_LICENSE("GPL");
 module_param(noaccel, bool, 0);
+module_param(default_dynclk, int, 0);
+MODULE_PARM_DESC(default_dynclk, "int: -1=off, 0=mobility only, 1=on");
 MODULE_PARM_DESC(noaccel, "bool: disable acceleration");
 module_param(nomodeset, bool, 0);
 MODULE_PARM_DESC(nomodeset, "bool: disable actual setting of video mode");
diff -uNr linus-2.6.10/drivers/video/aty/radeonfb.h sleep-2.6.10/drivers/video/aty/radeonfb.h
--- linus-2.6.10/drivers/video/aty/radeonfb.h	2005-01-06 10:48:55.499280800 +0000
+++ sleep-2.6.10/drivers/video/aty/radeonfb.h	2005-01-06 11:39:30.198222672 +0000
@@ -16,8 +16,17 @@
 
 #include <asm/io.h>
 
+#ifdef CONFIG_PPC_OF
+#include <asm/prom.h>
+#endif
+
 #include <video/radeon.h>
 
+/* Some weird black magic use by Apple driver that we don't use for
+ * now --BenH
+ */
+#undef HAS_PLL_M9_GPIO_MAGIC
+
 /***************************************************************
  * Most of the definitions here are adapted right from XFree86 *
  ***************************************************************/
@@ -33,7 +42,8 @@
 	CHIP_FAMILY_RV100,
 	CHIP_FAMILY_RS100,    /* U1 (IGP320M) or A3 (IGP320)*/
 	CHIP_FAMILY_RV200,
-	CHIP_FAMILY_RS200,    /* U2 (IGP330M/340M/350M) or A4 (IGP330/340/345/350), RS250 (IGP 7000) */
+	CHIP_FAMILY_RS200,    /* U2 (IGP330M/340M/350M) or A4 (IGP330/340/345/350),
+				 RS250 (IGP 7000) */
 	CHIP_FAMILY_R200,
 	CHIP_FAMILY_RV250,
 	CHIP_FAMILY_RS300,    /* Radeon 9000 IGP */
@@ -41,9 +51,26 @@
 	CHIP_FAMILY_R300,
 	CHIP_FAMILY_R350,
 	CHIP_FAMILY_RV350,
+	CHIP_FAMILY_RV380,    /* RV370/RV380/M22/M24 */
+	CHIP_FAMILY_R420,     /* R420/R423/M18 */
 	CHIP_FAMILY_LAST,
 };
 
+#define IS_RV100_VARIANT(rinfo) (((rinfo)->family == CHIP_FAMILY_RV100)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RV200)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RS100)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RS200)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RV250)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RV280)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RS300))
+
+
+#define IS_R300_VARIANT(rinfo) (((rinfo)->family == CHIP_FAMILY_R300)  || \
+				((rinfo)->family == CHIP_FAMILY_RV350) || \
+				((rinfo)->family == CHIP_FAMILY_R350)  || \
+				((rinfo)->family == CHIP_FAMILY_RV380) || \
+				((rinfo)->family == CHIP_FAMILY_R420))
+
 /*
  * Chip flags
  */
@@ -102,21 +129,6 @@
 	int ref_clk;
 };
 
-/*
- * VRAM infos
- */
-struct ram_info {
-	int ml;
-	int mb;
-	int trcd;
-	int trp;
-	int twr;
-	int cl;
-	int tr2w;
-	int loop_latency;
-	int rloop;
-};
-
 
 /*
  * This structure contains the various registers manipulated by this
@@ -210,6 +222,7 @@
 	u32		ppll_div_3;
 	u32		ppll_ref_div;
 	u32		vclk_ecp_cntl;
+	u32		clk_cntl_index;
 
 	/* Computed values for PLL2 */
 	u32		dot_clock_freq_2;
@@ -250,6 +263,12 @@
 };
 #endif
 
+enum radeon_pm_mode {
+	radeon_pm_none	= 0,		/* Nothing supported */
+	radeon_pm_d2	= 0x00000001,	/* Can do D2 state */
+	radeon_pm_off	= 0x00000002,	/* Can resume from D3 cold */
+};
+
 struct radeonfb_info {
 	struct fb_info		*info;
 
@@ -257,7 +276,6 @@
 	struct radeon_regs	init_state;
 
 	char			name[DEVICE_NAME_SIZE];
-	char			ram_type[12];
 
 	unsigned long		mmio_base_phys;
 	unsigned long		fb_base_phys;
@@ -268,6 +286,9 @@
 	unsigned long		fb_local_base;
 
 	struct pci_dev		*pdev;
+#ifdef CONFIG_PPC_OF
+	struct device_node	*of_node;
+#endif
 
 	void __iomem		*bios_seg;
 	int			fp_bios_start;
@@ -281,6 +302,8 @@
 	u8			rev;
 	unsigned long		video_ram;
 	unsigned long		mapped_vram;
+	int			vram_width;
+	int			vram_ddr;
 
 	int			pitch, bpp, depth;
 
@@ -288,6 +311,7 @@
 	int			is_mobility;
 	int			is_IGP;
 	int			R300_cg_workaround;
+	int			m9p_workaround;
 	int			reversed_DAC;
 	int			reversed_TMDS;
 	struct panel_info	panel_info;
@@ -302,14 +326,16 @@
 
 	struct pll_info		pll;
 
-	struct ram_info		ram;
-
 	int			mtrr_hdl;
 
 	int			pm_reg;
-	u32			save_regs[64];
+	u32			save_regs[100];
 	int			asleep;
 	int			lock_blank;
+	int			dynclk;
+	int			no_schedule;
+	enum radeon_pm_mode	pm_mode;
+	void			(*reinit_func)(struct radeonfb_info *rinfo);
 
 	/* Lock on register access */
 	spinlock_t		reg_lock;
@@ -317,11 +343,12 @@
 	/* Timer used for delayed LVDS operations */
 	struct timer_list	lvds_timer;
 	u32			pending_lvds_gen_cntl;
-	u32			pending_pixclks_cntl;
 
 #ifdef CONFIG_FB_RADEON_I2C
 	struct radeon_i2c_chan 	i2c[4];
 #endif
+
+	u32			cfg_save[64];
 };
 
 
@@ -353,6 +380,22 @@
 #define INREG(addr)		readl((rinfo->mmio_base)+addr)
 #define OUTREG(addr,val)	writel(val, (rinfo->mmio_base)+addr)
 
+static inline void _OUTREGP(struct radeonfb_info *rinfo, u32 addr,
+		       u32 val, u32 mask)
+{
+	unsigned long flags;
+	unsigned int tmp;
+	
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
+	tmp = INREG(addr);
+	tmp &= (mask);
+	tmp |= (val);
+	OUTREG(addr, tmp);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+}
+
+#define OUTREGP(addr,val,mask)	_OUTREGP(rinfo, addr, val,mask)
+
 static inline void R300_cg_workardound(struct radeonfb_info *rinfo)
 {
 	u32 save, tmp;
@@ -363,18 +406,35 @@
 	OUTREG(CLOCK_CNTL_INDEX, save);
 }
 
-#define __OUTPLL(addr,val)	\
-	do {	\
-		OUTREG8(CLOCK_CNTL_INDEX, (addr & 0x0000003f) | 0x00000080); \
-		OUTREG(CLOCK_CNTL_DATA, val); \
-} while(0)
-
 
 static inline u32 __INPLL(struct radeonfb_info *rinfo, u32 addr)
 {
 	u32 data;
+#ifdef HAS_PLL_M9_GPIO_MAGIC
+	u32 sv[3];
+
+	if (rinfo->m9p_workaround) {
+		sv[0] = INREG(0x19c);
+		sv[1] = INREG(0x1a0);
+		sv[2] = INREG(0x198);
+		OUTREG(0x198, 0);
+		OUTREG(0x1a0, 0);
+		OUTREG(0x19c, 0);
+	}
+#endif /* HAS_PLL_M9_GPIO_MAGIC */
+
 	OUTREG8(CLOCK_CNTL_INDEX, addr & 0x0000003f);
 	data = (INREG(CLOCK_CNTL_DATA));
+
+#ifdef HAS_PLL_M9_GPIO_MAGIC
+	if (rinfo->m9p_workaround) {
+		(void)INREG(CRTC_GEN_CNTL);
+		data = INREG(CLOCK_CNTL_DATA);
+		OUTREG(0x19c, sv[0]);
+		OUTREG(0x1a0, sv[1]);
+		OUTREG(0x198, sv[2]);
+	}
+#endif /* HAS_PLL_M9_GPIO_MAGIC */
 	if (rinfo->R300_cg_workaround)
 		R300_cg_workardound(rinfo);
 	return data;
@@ -393,37 +453,60 @@
 
 #define INPLL(addr)		_INPLL(rinfo, addr)
 
-#define OUTPLL(addr,val)	\
-	do {	\
-		unsigned long flags;\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); \
-		__OUTPLL(addr, val); \
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); \
-	} while(0)
-
-#define OUTPLLP(addr,val,mask)  					\
-	do {								\
-		unsigned long flags;                                    \
-		unsigned int _tmp;					\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); 		\
-		_tmp  = __INPLL(rinfo,addr);				\
-		_tmp &= (mask);						\
-		_tmp |= (val);						\
-		__OUTPLL(addr, _tmp);					\
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); 	\
-	} while (0)
-
-#define OUTREGP(addr,val,mask)  					\
-	do {								\
-		unsigned long flags;                                    \
-		unsigned int _tmp;					\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); 		\
-		_tmp = INREG(addr);				       	\
-		_tmp &= (mask);						\
-		_tmp |= (val);						\
-		OUTREG(addr, _tmp);					\
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); 	\
-	} while (0)
+static inline void __OUTPLL(struct radeonfb_info *rinfo, unsigned int index, u32 val)
+{
+#ifdef HAS_PLL_M9_GPIO_MAGIC
+	u32 sv[3];
+
+	if (rinfo->m9p_workaround) {
+		sv[0] = INREG(0x19c);
+		sv[1] = INREG(0x1a0);
+		sv[2] = INREG(0x198);
+		OUTREG(0x198, 0);
+		OUTREG(0x1a0, 0);
+		OUTREG(0x19c, 0);
+		mdelay(1);
+	}
+#endif /* HAS_PLL_M9_GPIO_MAGIC */
+
+	OUTREG8(CLOCK_CNTL_INDEX, (index & 0x0000003f) | 0x00000080);
+	OUTREG(CLOCK_CNTL_DATA, val);
+
+#ifdef HAS_PLL_M9_GPIO_MAGIC
+	if (rinfo->m9p_workaround) {
+		OUTREG(0x19c, sv[0]);
+		OUTREG(0x1a0, sv[1]);
+		OUTREG(0x198, sv[2]);
+	}
+#endif /* HAS_PLL_M9_GPIO_MAGIC */
+}
+	
+static inline void _OUTPLL(struct radeonfb_info *rinfo, unsigned int index, u32 val)
+{
+       	unsigned long flags;
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
+	__OUTPLL(rinfo, index, val);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+}
+
+static inline void _OUTPLLP(struct radeonfb_info *rinfo, unsigned int index,
+			    u32 val, u32 mask)
+{
+	unsigned long flags;
+	unsigned int tmp;
+
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
+	tmp  = __INPLL(rinfo, index);
+	tmp &= (mask);
+	tmp |= (val);
+	__OUTPLL(rinfo, index, tmp);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+}
+
+
+#define OUTPLL(index, val)		_OUTPLL(rinfo, index, val)
+#define OUTPLLP(index, val, mask)	_OUTPLLP(rinfo, index, val, mask)
+
 
 #define BIOS_IN8(v)  	(readb(rinfo->bios_seg + (v)))
 #define BIOS_IN16(v) 	(readb(rinfo->bios_seg + (v)) | \
@@ -484,7 +567,7 @@
 }
 
 
-static inline void _radeon_fifo_wait (struct radeonfb_info *rinfo, int entries)
+static inline void _radeon_fifo_wait(struct radeonfb_info *rinfo, int entries)
 {
 	int i;
 
@@ -497,7 +580,7 @@
 }
 
 
-static inline void _radeon_engine_idle (struct radeonfb_info *rinfo)
+static inline void _radeon_engine_idle(struct radeonfb_info *rinfo)
 {
 	int i;
 
@@ -514,8 +597,24 @@
 	printk(KERN_ERR "radeonfb: Idle Timeout !\n");
 }
 
+/* Note about this function: we have some rare cases where we must not schedule,
+ * this typically happen with our special "wake up early" hook which allows us to
+ * wake up the graphic chip (and thus get the console back) before everything else
+ * on some machines that support that mecanism. At this point, interrupts are off
+ * and scheduling is not permitted
+ */
+static inline void _radeon_msleep(struct radeonfb_info *rinfo, unsigned long ms)
+{
+	if (rinfo->no_schedule)
+		mdelay(ms);
+	else
+		msleep(ms);
+}
+
+
 #define radeon_engine_idle()		_radeon_engine_idle(rinfo)
 #define radeon_fifo_wait(entries)	_radeon_fifo_wait(rinfo,entries)
+#define radeon_msleep(ms)		_radeon_msleep(rinfo,ms)
 
 
 /* I2C Functions */
@@ -524,10 +623,10 @@
 extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid);
 
 /* PM Functions */
-extern void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo);
-extern void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo);
 extern int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state);
 extern int radeonfb_pci_resume(struct pci_dev *pdev);
+extern void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk);
+extern void radeonfb_pm_exit(struct radeonfb_info *rinfo);
 
 /* Monitor probe functions */
 extern void radeon_probe_screens(struct radeonfb_info *rinfo,
@@ -546,7 +645,9 @@
 extern void radeonfb_engine_reset(struct radeonfb_info *rinfo);
 
 /* Other functions */
-extern int radeonfb_blank(int blank, struct fb_info *info);
-extern int radeonfb_set_par(struct fb_info *info);
+extern int radeon_screen_blank(struct radeonfb_info *rinfo, int blank, int mode_switch);
+extern void radeon_save_state (struct radeonfb_info *rinfo, struct radeon_regs *save);
+extern void radeon_write_mode (struct radeonfb_info *rinfo, struct radeon_regs *mode,
+			       int reg_only);
 
 #endif /* __RADEONFB_H__ */
diff -uNr linus-2.6.10/drivers/video/aty/radeon_monitor.c sleep-2.6.10/drivers/video/aty/radeon_monitor.c
--- linus-2.6.10/drivers/video/aty/radeon_monitor.c	2005-01-06 10:47:23.023230968 +0000
+++ sleep-2.6.10/drivers/video/aty/radeon_monitor.c	2005-01-06 11:38:37.975174792 +0000
@@ -1,11 +1,6 @@
 #include "radeonfb.h"
 #include "../edid.h"
 
-#ifdef CONFIG_PPC_OF
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#endif /* CONFIG_PPC_OF */
-
 static struct fb_var_screeninfo radeonfb_default_var = {
 	.xres		= 640,
 	.yres		= 480,
@@ -64,9 +59,11 @@
  * models with broken OF probing by hard-coding known EDIDs for some Mac
  * laptops internal LVDS panel. (XXX: not done yet)
  */
-static int __devinit radeon_parse_montype_prop(struct device_node *dp, u8 **out_EDID, int hdno)
+static int __devinit radeon_parse_montype_prop(struct device_node *dp, u8 **out_EDID,
+					       int hdno)
 {
-        static char *propnames[] = { "DFP,EDID", "LCD,EDID", "EDID", "EDID1", "EDID2",  NULL };
+        static char *propnames[] = { "DFP,EDID", "LCD,EDID", "EDID",
+				     "EDID1", "EDID2",  NULL };
 	u8 *pedid = NULL;
 	u8 *pmt = NULL;
 	u8 *tmp;
@@ -122,7 +119,7 @@
 
 	RTRACE("radeon_probe_OF_head\n");
 
-        dp = pci_device_to_OF_node(rinfo->pdev);
+        dp = rinfo->of_node;
         while (dp == NULL)
 		return MT_NONE;
 
@@ -502,8 +499,9 @@
 #endif /* CONFIG_PPC_OF */
 #ifdef CONFIG_FB_RADEON_I2C
 			if (rinfo->mon1_type == MT_NONE)
-				rinfo->mon1_type = radeon_probe_i2c_connector(rinfo, ddc_dvi,
-								      &rinfo->mon1_EDID);
+				rinfo->mon1_type =
+					radeon_probe_i2c_connector(rinfo, ddc_dvi,
+								   &rinfo->mon1_EDID);
 			if (rinfo->mon1_type == MT_NONE)
 				rinfo->mon1_type =
 					radeon_probe_i2c_connector(rinfo, ddc_vga,
@@ -545,7 +543,8 @@
 		 */
 #ifdef CONFIG_PPC_OF
 		if (rinfo->mon1_type == MT_NONE)
-			rinfo->mon1_type = radeon_probe_OF_head(rinfo, 0, &rinfo->mon1_EDID);
+			rinfo->mon1_type = radeon_probe_OF_head(rinfo, 0,
+								&rinfo->mon1_EDID);
 #endif /* CONFIG_PPC_OF */
 #ifdef CONFIG_FB_RADEON_I2C
 		if (rinfo->mon1_type == MT_NONE)
@@ -572,7 +571,8 @@
 		 */
 #ifdef CONFIG_PPC_OF
 		if (rinfo->mon2_type == MT_NONE)
-			rinfo->mon2_type = radeon_probe_OF_head(rinfo, 1, &rinfo->mon2_EDID);
+			rinfo->mon2_type = radeon_probe_OF_head(rinfo, 1,
+								&rinfo->mon2_EDID);
 #endif /* CONFIG_PPC_OF */
 #ifdef CONFIG_FB_RADEON_I2C
 		if (rinfo->mon2_type == MT_NONE)
diff -uNr linus-2.6.10/drivers/video/aty/radeon_pm.c sleep-2.6.10/drivers/video/aty/radeon_pm.c
--- linus-2.6.10/drivers/video/aty/radeon_pm.c	2005-01-06 10:48:18.264217112 +0000
+++ sleep-2.6.10/drivers/video/aty/radeon_pm.c	2005-01-06 11:58:45.747277392 +0000
@@ -1,207 +1,464 @@
+/*
+ *	drivers/video/aty/radeon_pm.c
+ *
+ *	Copyright 2003,2004 Ben. Herrenschmidt <benh@kernel.crashing.org>
+ *	Copyright 2004 Paul Mackerras <paulus@samba.org>
+ *
+ *	This is the power management code for ATI radeon chipsets. It contains
+ *	some dynamic clock PM enable/disable code similar to what X.org does,
+ *	some D2-state (APM-style) sleep/wakeup code for use on some PowerMacs,
+ *	and the necessary bits to re-initialize from scratch a few chips found
+ *	on PowerMacs as well. The later could be extended to more platforms
+ *	provided the memory controller configuration code be made more generic,
+ *	and you can get the proper mode register commands for your RAMs.
+ *	Those things may be found in the BIOS image...
+ */
+
 #include "radeonfb.h"
 
 #include <linux/console.h>
 #include <linux/agp_backend.h>
 
-/*
- * Currently, only PowerMac do D2 state
- */
-#define CONFIG_RADEON_HAS_D2	CONFIG_PPC_PMAC
-
-#ifdef CONFIG_RADEON_HAS_D2
-/*
- * On PowerMac, we assume any mobility chip based machine does D2
- */
 #ifdef CONFIG_PPC_PMAC
-static inline int radeon_suspend_to_d2(struct radeonfb_info *rinfo, u32 state)
-{
-	return rinfo->is_mobility;
-}
-#else
-static inline int radeon_suspend_to_d2(struct radeonfb_info *rinfo, u32 state)
-{
-	return 0;
-}
+#include <asm/processor.h>
+#include <asm/prom.h>
+#include <asm/pmac_feature.h>
 #endif
 
-#endif /* CONFIG_RADEON_HAS_D2 */
-
-/*
- * Radeon M6, M7 and M9 Power Management code. This code currently
- * only supports the mobile chips in D2 mode, that is typically what
- * is used on Apple laptops, it's based from some informations provided
- * by ATI along with hours of tracing of MacOS drivers.
- * 
- * New version of this code almost totally rewritten by ATI, many thanks
- * for their support.
- */
+#include "ati_ids.h"
 
 void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo)
 {
+	u32 tmp;
 
-	u32 sclk_cntl;
-	u32 mclk_cntl;
-	u32 sclk_more_cntl;
-	
-	u32 vclk_ecp_cntl;
-	u32 pixclks_cntl;
-
-	/* Mobility chips only, untested on M9+/M10/11 */
-	if (!rinfo->is_mobility)
+	/* RV100 */
+	if ((rinfo->family == CHIP_FAMILY_RV100) && (!rinfo->is_mobility)) {
+		if (rinfo->has_CRTC2) {
+			tmp = INPLL(pllSCLK_CNTL);
+			tmp &= ~SCLK_CNTL__DYN_STOP_LAT_MASK;
+			tmp |= SCLK_CNTL__CP_MAX_DYN_STOP_LAT | SCLK_CNTL__FORCEON_MASK;
+			OUTPLL(pllSCLK_CNTL, tmp);
+		}
+		tmp = INPLL(pllMCLK_CNTL);
+		tmp |= (MCLK_CNTL__FORCE_MCLKA |
+		        MCLK_CNTL__FORCE_MCLKB |
+		        MCLK_CNTL__FORCE_YCLKA |
+		        MCLK_CNTL__FORCE_YCLKB |
+			MCLK_CNTL__FORCE_AIC |
+			MCLK_CNTL__FORCE_MC);
+                OUTPLL(pllMCLK_CNTL, tmp);
+		return;
+	}					 
+	/* R100 */
+	if (!rinfo->has_CRTC2) {
+                tmp = INPLL(pllSCLK_CNTL);
+                tmp |= (SCLK_CNTL__FORCE_CP	| SCLK_CNTL__FORCE_HDP	|
+			SCLK_CNTL__FORCE_DISP1	| SCLK_CNTL__FORCE_TOP	|
+                        SCLK_CNTL__FORCE_E2	| SCLK_CNTL__FORCE_SE 	|
+			SCLK_CNTL__FORCE_IDCT	| SCLK_CNTL__FORCE_VIP	|
+			SCLK_CNTL__FORCE_RE	| SCLK_CNTL__FORCE_PB 	|
+			SCLK_CNTL__FORCE_TAM	| SCLK_CNTL__FORCE_TDM	|
+                        SCLK_CNTL__FORCE_RB);
+                OUTPLL(pllSCLK_CNTL, tmp);
 		return;
-	if (rinfo->family > CHIP_FAMILY_RV250)
+	}
+	/* RV350 (M10) */
+	if (rinfo->family == CHIP_FAMILY_RV350) {
+                /* for RV350/M10, no delays are required. */
+                tmp = INPLL(pllSCLK_CNTL2);
+                tmp |= (SCLK_CNTL2__R300_FORCE_TCL |
+                        SCLK_CNTL2__R300_FORCE_GA  |
+			SCLK_CNTL2__R300_FORCE_CBA);
+                OUTPLL(pllSCLK_CNTL2, tmp);
+
+                tmp = INPLL(pllSCLK_CNTL);
+                tmp |= (SCLK_CNTL__FORCE_DISP2		| SCLK_CNTL__FORCE_CP		|
+                        SCLK_CNTL__FORCE_HDP		| SCLK_CNTL__FORCE_DISP1	|
+                        SCLK_CNTL__FORCE_TOP		| SCLK_CNTL__FORCE_E2		|
+                        SCLK_CNTL__R300_FORCE_VAP	| SCLK_CNTL__FORCE_IDCT    	|
+			SCLK_CNTL__FORCE_VIP		| SCLK_CNTL__R300_FORCE_SR	|
+			SCLK_CNTL__R300_FORCE_PX	| SCLK_CNTL__R300_FORCE_TX	|
+			SCLK_CNTL__R300_FORCE_US	| SCLK_CNTL__FORCE_TV_SCLK	|
+                        SCLK_CNTL__R300_FORCE_SU	| SCLK_CNTL__FORCE_OV0);
+                OUTPLL(pllSCLK_CNTL, tmp);
+
+                tmp = INPLL(pllSCLK_MORE_CNTL);
+		tmp |= (SCLK_MORE_CNTL__FORCE_DISPREGS	| SCLK_MORE_CNTL__FORCE_MC_GUI	|
+			SCLK_MORE_CNTL__FORCE_MC_HOST);
+                OUTPLL(pllSCLK_MORE_CNTL, tmp);
+		
+		tmp = INPLL(pllMCLK_CNTL);
+		tmp |= (MCLK_CNTL__FORCE_MCLKA |
+		        MCLK_CNTL__FORCE_MCLKB |
+		        MCLK_CNTL__FORCE_YCLKA |
+		        MCLK_CNTL__FORCE_YCLKB |
+			MCLK_CNTL__FORCE_MC);
+                OUTPLL(pllMCLK_CNTL, tmp);
+
+                tmp = INPLL(pllVCLK_ECP_CNTL);
+                tmp &= ~(VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb  | 
+                         VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb | 
+			 VCLK_ECP_CNTL__R300_DISP_DAC_PIXCLK_DAC_BLANK_OFF);
+                OUTPLL(pllVCLK_ECP_CNTL, tmp);
+
+                tmp = INPLL(pllPIXCLKS_CNTL);
+                tmp &= ~(PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__DISP_TVOUT_PIXCLK_TV_ALWAYS_ONb	| 
+			 PIXCLKS_CNTL__R300_DVOCLK_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__R300_PIXCLK_DVO_ALWAYS_ONb	| 
+			 PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb	| 
+			 PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb	| 
+			 PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__R300_DISP_DAC_PIXCLK_DAC2_BLANK_OFF); 
+                OUTPLL(pllPIXCLKS_CNTL, tmp);
+
 		return;
+	}
 	
+	/* Default */
+
 	/* Force Core Clocks */
-	sclk_cntl = INPLL( pllSCLK_CNTL_M6);
-	sclk_cntl |= 	SCLK_CNTL_M6__FORCE_CP|
-			SCLK_CNTL_M6__FORCE_HDP|
-			SCLK_CNTL_M6__FORCE_DISP1|
-			SCLK_CNTL_M6__FORCE_DISP2|
-			SCLK_CNTL_M6__FORCE_TOP|
-			SCLK_CNTL_M6__FORCE_E2|
-			SCLK_CNTL_M6__FORCE_SE|
-			SCLK_CNTL_M6__FORCE_IDCT|
-			SCLK_CNTL_M6__FORCE_VIP|
-			SCLK_CNTL_M6__FORCE_RE|
-			SCLK_CNTL_M6__FORCE_PB|
-			SCLK_CNTL_M6__FORCE_TAM|
-			SCLK_CNTL_M6__FORCE_TDM|
-			SCLK_CNTL_M6__FORCE_RB|
-			SCLK_CNTL_M6__FORCE_TV_SCLK|
-			SCLK_CNTL_M6__FORCE_SUBPIC|
-			SCLK_CNTL_M6__FORCE_OV0;
-    	OUTPLL( pllSCLK_CNTL_M6, sclk_cntl);
-	
-	
-	
-	sclk_more_cntl = INPLL(pllSCLK_MORE_CNTL);
-	sclk_more_cntl |= 	SCLK_MORE_CNTL__FORCE_DISPREGS|
-				SCLK_MORE_CNTL__FORCE_MC_GUI|
-				SCLK_MORE_CNTL__FORCE_MC_HOST;	
-	OUTPLL(pllSCLK_MORE_CNTL, sclk_more_cntl);
-	
-	/* Force Display clocks	*/
-	vclk_ecp_cntl = INPLL( pllVCLK_ECP_CNTL);
-	vclk_ecp_cntl &= ~(	VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb |
-			 	VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb);
+	tmp = INPLL(pllSCLK_CNTL);
+	tmp |= (SCLK_CNTL__FORCE_CP | SCLK_CNTL__FORCE_E2);
 
-	OUTPLL( pllVCLK_ECP_CNTL, vclk_ecp_cntl);
-	
-	pixclks_cntl = INPLL( pllPIXCLKS_CNTL);
-	pixclks_cntl &= ~(	PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb |
-			 	PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb|
-				PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb |
-				PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb|
-				PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb|
-				PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb|
-				PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb);
-						
- 	OUTPLL( pllPIXCLKS_CNTL, pixclks_cntl);
+	/* XFree doesn't do that case, but we had this code from Apple and it
+	 * seem necessary for proper suspend/resume operations
+	 */
+	if (rinfo->is_mobility) {
+		tmp |= 	SCLK_CNTL__FORCE_HDP|
+			SCLK_CNTL__FORCE_DISP1|
+			SCLK_CNTL__FORCE_DISP2|
+			SCLK_CNTL__FORCE_TOP|
+			SCLK_CNTL__FORCE_SE|
+			SCLK_CNTL__FORCE_IDCT|
+			SCLK_CNTL__FORCE_VIP|
+			SCLK_CNTL__FORCE_PB|
+			SCLK_CNTL__FORCE_RE|
+			SCLK_CNTL__FORCE_TAM|
+			SCLK_CNTL__FORCE_TDM|
+			SCLK_CNTL__FORCE_RB|
+			SCLK_CNTL__FORCE_TV_SCLK|
+			SCLK_CNTL__FORCE_SUBPIC|
+			SCLK_CNTL__FORCE_OV0;
+	}
+	else if (rinfo->family == CHIP_FAMILY_R300 ||
+		   rinfo->family == CHIP_FAMILY_R350) {
+		tmp |=  SCLK_CNTL__FORCE_HDP   |
+			SCLK_CNTL__FORCE_DISP1 |
+			SCLK_CNTL__FORCE_DISP2 |
+			SCLK_CNTL__FORCE_TOP   |
+			SCLK_CNTL__FORCE_IDCT  |
+			SCLK_CNTL__FORCE_VIP;
+	}
+    	OUTPLL(pllSCLK_CNTL, tmp);
+	radeon_msleep(16);
+
+	if (rinfo->family == CHIP_FAMILY_R300 || rinfo->family == CHIP_FAMILY_R350) {
+		tmp = INPLL(pllSCLK_CNTL2);
+		tmp |=  SCLK_CNTL2__R300_FORCE_TCL |
+			SCLK_CNTL2__R300_FORCE_GA  |
+			SCLK_CNTL2__R300_FORCE_CBA;
+		OUTPLL(pllSCLK_CNTL2, tmp);
+		radeon_msleep(16);
+	}
+
+
+	tmp = INPLL( pllCLK_PWRMGT_CNTL);
+	tmp |= CLK_PWRMGT_CNTL__ENGINE_DYNCLK_MODE_MASK;
+	tmp |= CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT_MASK|
+	       CLK_PWRMGT_CNTL__DISP_DYN_STOP_LAT_MASK|
+	       CLK_PWRMGT_CNTL__DYN_STOP_MODE_MASK;
+	OUTPLL( pllCLK_PWRMGT_CNTL, tmp);
+	radeon_msleep(15);
+
+	tmp = INPLL(pllCLK_PIN_CNTL);
+	tmp &= ~CLK_PIN_CNTL__SCLK_DYN_START_CNTL;
+	OUTPLL(pllCLK_PIN_CNTL, tmp);
+	radeon_msleep(15);
+
+	if (rinfo->is_IGP) {
+		/* Weird  ... X is _un_ forcing clocks here, I think it's
+		 * doing backward. Imitate it for now...
+		 */
+		tmp = INPLL(pllMCLK_CNTL);
+		tmp &= ~(MCLK_CNTL__FORCE_MCLKA |
+			 MCLK_CNTL__FORCE_YCLKA);
+		OUTREG(pllMCLK_CNTL, tmp);
+		radeon_msleep(16);
+	}
+	/* Hrm... same shit, X doesn't do that but I have to */
+	else if (rinfo->is_mobility) {
+		tmp = INPLL(pllMCLK_CNTL);
+		tmp |= (MCLK_CNTL__FORCE_MCLKA |  
+			MCLK_CNTL__FORCE_MCLKB |
+			MCLK_CNTL__FORCE_YCLKA |
+			MCLK_CNTL__FORCE_YCLKB);
+		OUTPLL(pllMCLK_CNTL, tmp);
+		radeon_msleep(16);
+
+		tmp = INPLL(pllMCLK_MISC);
+		tmp &= 	~(MCLK_MISC__MC_MCLK_MAX_DYN_STOP_LAT|
+			  MCLK_MISC__IO_MCLK_MAX_DYN_STOP_LAT|
+			  MCLK_MISC__MC_MCLK_DYN_ENABLE|
+			  MCLK_MISC__IO_MCLK_DYN_ENABLE);
+		OUTPLL(pllMCLK_MISC, tmp);
+		radeon_msleep(15);
+	}
 
-	/* Force Memory Clocks */
-	mclk_cntl = INPLL( pllMCLK_CNTL_M6);
-	mclk_cntl &= ~(	MCLK_CNTL_M6__FORCE_MCLKA |  
-			MCLK_CNTL_M6__FORCE_MCLKB |
-			MCLK_CNTL_M6__FORCE_YCLKA |
-			MCLK_CNTL_M6__FORCE_YCLKB );
-    	OUTPLL( pllMCLK_CNTL_M6, mclk_cntl);
+	if (rinfo->is_mobility) {
+		tmp = INPLL(pllSCLK_MORE_CNTL);
+		tmp |= 	SCLK_MORE_CNTL__FORCE_DISPREGS|
+			SCLK_MORE_CNTL__FORCE_MC_GUI|
+			SCLK_MORE_CNTL__FORCE_MC_HOST;	
+		OUTPLL(pllSCLK_MORE_CNTL, tmp);
+		radeon_msleep(16);
+	}
+	
+	tmp = INPLL(pllPIXCLKS_CNTL);
+	tmp &= ~(PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb |
+		 PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb|
+		 PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb |
+		 PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb|
+		 PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb|
+		 PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb|
+		 PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb);
+ 	OUTPLL(pllPIXCLKS_CNTL, tmp);
+	radeon_msleep(16);
+
+	tmp = INPLL( pllVCLK_ECP_CNTL);
+	tmp &= ~(VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb |
+		 VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb);
+	OUTPLL( pllVCLK_ECP_CNTL, tmp);
+	radeon_msleep(16);
 }
 
 void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
 {
-	u32 clk_pwrmgt_cntl;
-	u32 sclk_cntl;
-	u32 sclk_more_cntl;
-	u32 clk_pin_cntl;
-	u32 pixclks_cntl;
-	u32 vclk_ecp_cntl;
-	u32 mclk_cntl;
-	u32 mclk_misc;
+	u32 tmp;
 
-	/* Mobility chips only, untested on M9+/M10/11 */
-	if (!rinfo->is_mobility)
-		return;
-	if (rinfo->family > CHIP_FAMILY_RV250)
+	/* R100 */
+	if (!rinfo->has_CRTC2) {
+                tmp = INPLL(pllSCLK_CNTL);
+
+		if ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) > CFG_ATI_REV_A13)
+                    tmp &= ~(SCLK_CNTL__FORCE_CP	| SCLK_CNTL__FORCE_RB);
+                tmp &= ~(SCLK_CNTL__FORCE_HDP		| SCLK_CNTL__FORCE_DISP1 |
+			 SCLK_CNTL__FORCE_TOP		| SCLK_CNTL__FORCE_SE   |
+			 SCLK_CNTL__FORCE_IDCT		| SCLK_CNTL__FORCE_RE   |
+			 SCLK_CNTL__FORCE_PB		| SCLK_CNTL__FORCE_TAM  |
+			 SCLK_CNTL__FORCE_TDM);
+                OUTPLL(pllSCLK_CNTL, tmp);
 		return;
-	
-	/* Set Latencies */
-	clk_pwrmgt_cntl = INPLL( pllCLK_PWRMGT_CNTL_M6);
-	
-	clk_pwrmgt_cntl &= ~(	 CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE_MASK|
-				 CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT_MASK|
-				 CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT_MASK|
-				 CLK_PWRMGT_CNTL_M6__DYN_STOP_MODE_MASK);
-	/* Mode 1 */
-	clk_pwrmgt_cntl = 	CLK_PWRMGT_CNTL_M6__MC_CH_MODE|
-				CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE | 
-				(1<<CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT__SHIFT) |
-				(0<<CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT__SHIFT)|
-				(0<<CLK_PWRMGT_CNTL_M6__DYN_STOP_MODE__SHIFT);
+	}
 
-	OUTPLL( pllCLK_PWRMGT_CNTL_M6, clk_pwrmgt_cntl);
-						
+	/* M10 */
+	if (rinfo->family == CHIP_FAMILY_RV350) {
+		tmp = INPLL(pllSCLK_CNTL2);
+		tmp &= ~(SCLK_CNTL2__R300_FORCE_TCL |
+			 SCLK_CNTL2__R300_FORCE_GA  |
+			 SCLK_CNTL2__R300_FORCE_CBA);
+		tmp |=  (SCLK_CNTL2__R300_TCL_MAX_DYN_STOP_LAT |
+			 SCLK_CNTL2__R300_GA_MAX_DYN_STOP_LAT  |
+			 SCLK_CNTL2__R300_CBA_MAX_DYN_STOP_LAT);
+		OUTPLL(pllSCLK_CNTL2, tmp);
+
+		tmp = INPLL(pllSCLK_CNTL);
+		tmp &= ~(SCLK_CNTL__FORCE_DISP2 | SCLK_CNTL__FORCE_CP      |
+			 SCLK_CNTL__FORCE_HDP   | SCLK_CNTL__FORCE_DISP1   |
+			 SCLK_CNTL__FORCE_TOP   | SCLK_CNTL__FORCE_E2      |
+			 SCLK_CNTL__R300_FORCE_VAP | SCLK_CNTL__FORCE_IDCT |
+			 SCLK_CNTL__FORCE_VIP   | SCLK_CNTL__R300_FORCE_SR |
+			 SCLK_CNTL__R300_FORCE_PX | SCLK_CNTL__R300_FORCE_TX |
+			 SCLK_CNTL__R300_FORCE_US | SCLK_CNTL__FORCE_TV_SCLK |
+			 SCLK_CNTL__R300_FORCE_SU | SCLK_CNTL__FORCE_OV0);
+		tmp |= SCLK_CNTL__DYN_STOP_LAT_MASK;
+		OUTPLL(pllSCLK_CNTL, tmp);
+
+		tmp = INPLL(pllSCLK_MORE_CNTL);
+		tmp &= ~SCLK_MORE_CNTL__FORCEON;
+		tmp |=  SCLK_MORE_CNTL__DISPREGS_MAX_DYN_STOP_LAT |
+			SCLK_MORE_CNTL__MC_GUI_MAX_DYN_STOP_LAT |
+			SCLK_MORE_CNTL__MC_HOST_MAX_DYN_STOP_LAT;
+		OUTPLL(pllSCLK_MORE_CNTL, tmp);
+
+		tmp = INPLL(pllVCLK_ECP_CNTL);
+		tmp |= (VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb |
+			VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb);   
+		OUTPLL(pllVCLK_ECP_CNTL, tmp);
+
+		tmp = INPLL(pllPIXCLKS_CNTL);
+		tmp |= (PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb         |
+			PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb     |
+			PIXCLKS_CNTL__DISP_TVOUT_PIXCLK_TV_ALWAYS_ONb |
+			PIXCLKS_CNTL__R300_DVOCLK_ALWAYS_ONb            |   
+			PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb    |
+			PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb       |
+			PIXCLKS_CNTL__R300_PIXCLK_DVO_ALWAYS_ONb        | 
+			PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb     |
+			PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb     |
+			PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb      |
+			PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb        |
+			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb           |
+			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb);
+		OUTPLL(pllPIXCLKS_CNTL, tmp);
+
+		tmp = INPLL(pllMCLK_MISC);
+		tmp |= (MCLK_MISC__MC_MCLK_DYN_ENABLE |
+			MCLK_MISC__IO_MCLK_DYN_ENABLE);
+		OUTPLL(pllMCLK_MISC, tmp);
+
+		tmp = INPLL(pllMCLK_CNTL);
+		tmp |= (MCLK_CNTL__FORCE_MCLKA | MCLK_CNTL__FORCE_MCLKB);
+		tmp &= ~(MCLK_CNTL__FORCE_YCLKA  |
+			 MCLK_CNTL__FORCE_YCLKB  |
+			 MCLK_CNTL__FORCE_MC);
+
+		/* Some releases of vbios have set DISABLE_MC_MCLKA
+		 * and DISABLE_MC_MCLKB bits in the vbios table.  Setting these
+		 * bits will cause H/W hang when reading video memory with dynamic
+		 * clocking enabled.
+		 */
+		if ((tmp & MCLK_CNTL__R300_DISABLE_MC_MCLKA) &&
+		    (tmp & MCLK_CNTL__R300_DISABLE_MC_MCLKB)) {
+			/* If both bits are set, then check the active channels */
+			tmp = INPLL(pllMCLK_CNTL);
+			if (rinfo->vram_width == 64) {
+			    if (INREG(MEM_CNTL) & R300_MEM_USE_CD_CH_ONLY)
+				tmp &= ~MCLK_CNTL__R300_DISABLE_MC_MCLKB;
+			    else
+				tmp &= ~MCLK_CNTL__R300_DISABLE_MC_MCLKA;
+			} else {
+			    tmp &= ~(MCLK_CNTL__R300_DISABLE_MC_MCLKA |
+				     MCLK_CNTL__R300_DISABLE_MC_MCLKB);
+			}
+		}
+		OUTPLL(pllMCLK_CNTL, tmp);
+		return;
+	}
 
-	clk_pin_cntl = INPLL( pllCLK_PIN_CNTL);
-	clk_pin_cntl |= CLK_PIN_CNTL__SCLK_DYN_START_CNTL;
-	 
-	OUTPLL( pllCLK_PIN_CNTL, clk_pin_cntl);
+	/* R300 */
+	if (rinfo->family == CHIP_FAMILY_R300 || rinfo->family == CHIP_FAMILY_R350) {
+		tmp = INPLL(pllSCLK_CNTL);
+		tmp &= ~(SCLK_CNTL__R300_FORCE_VAP);
+		tmp |= SCLK_CNTL__FORCE_CP;
+		OUTPLL(pllSCLK_CNTL, tmp);
+		radeon_msleep(15);
+
+		tmp = INPLL(pllSCLK_CNTL2);
+		tmp &= ~(SCLK_CNTL2__R300_FORCE_TCL |
+			 SCLK_CNTL2__R300_FORCE_GA  |
+			 SCLK_CNTL2__R300_FORCE_CBA);
+		OUTPLL(pllSCLK_CNTL2, tmp);
+	}
 
-	/* Enable Dyanmic mode for SCLK */
+	/* Others */
 
-	sclk_cntl = INPLL( pllSCLK_CNTL_M6);	
-	sclk_cntl &= SCLK_CNTL_M6__SCLK_SRC_SEL_MASK;
-	sclk_cntl |= SCLK_CNTL_M6__FORCE_VIP;		
+	tmp = INPLL( pllCLK_PWRMGT_CNTL);
+	/* X doesn't do this one ... let's assume it only work for Mac chipsets...*/
+#ifdef CONFIG_PPC_OF
+	if (rinfo->is_mobility) {
+		tmp &= ~CLK_PWRMGT_CNTL__ENGINE_DYNCLK_MODE_MASK;
+		//tmp |= CLK_PWRMGT_CNTL__MC_CH_MODE;
+	}
+#endif
+	tmp &= ~(CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT_MASK|
+		 CLK_PWRMGT_CNTL__DISP_DYN_STOP_LAT_MASK|
+		 CLK_PWRMGT_CNTL__DYN_STOP_MODE_MASK);
+	OUTPLL( pllCLK_PWRMGT_CNTL, tmp);
+	radeon_msleep(15);
+
+	tmp = INPLL(pllCLK_PIN_CNTL);
+	tmp |= CLK_PIN_CNTL__SCLK_DYN_START_CNTL;
+	OUTPLL(pllCLK_PIN_CNTL, tmp);
+	radeon_msleep(15);
 
-	OUTPLL( pllSCLK_CNTL_M6, sclk_cntl);
+	/* When DRI is enabled, setting DYN_STOP_LAT to zero can cause some R200 
+	 * to lockup randomly, leave them as set by BIOS.
+	 */
+	tmp = INPLL(pllSCLK_CNTL);	
+	tmp &= ~SCLK_CNTL__FORCEON_MASK;	
 
+	/*RAGE_6::A11 A12 A12N1 A13, RV250::A11 A12, R300*/
+	if ((rinfo->family == CHIP_FAMILY_RV250 &&
+	     ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) < CFG_ATI_REV_A13)) || 
+	    ((rinfo->family == CHIP_FAMILY_RV100) &&
+	     ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) <= CFG_ATI_REV_A13))) {
+		tmp |= SCLK_CNTL__FORCE_CP;
+		tmp |= SCLK_CNTL__FORCE_VIP;
+	}
+	OUTPLL(pllSCLK_CNTL, tmp);
+	radeon_msleep(15);
 
-	sclk_more_cntl = INPLL(pllSCLK_MORE_CNTL);
-	sclk_more_cntl &= ~(SCLK_MORE_CNTL__FORCE_DISPREGS);
-				                    
-	OUTPLL(pllSCLK_MORE_CNTL, sclk_more_cntl);
 
+	if ((rinfo->family == CHIP_FAMILY_RV200) ||
+	    (rinfo->family == CHIP_FAMILY_RV250) ||
+	    (rinfo->family == CHIP_FAMILY_RV280)) {
+		tmp = INPLL(pllSCLK_MORE_CNTL);
+		tmp &= ~SCLK_MORE_CNTL__FORCEON;
+
+		/* RV200::A11 A12 RV250::A11 A12 */
+		if (((rinfo->family == CHIP_FAMILY_RV200) ||
+		     (rinfo->family == CHIP_FAMILY_RV250)) &&
+		    ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) < CFG_ATI_REV_A13))
+			tmp |= SCLK_MORE_CNTL__FORCEON;
+		    
+		OUTPLL(pllSCLK_MORE_CNTL, tmp);
+		radeon_msleep(15);
+	}
 	
-	/* Enable Dynamic mode for PIXCLK & PIX2CLK */
 
-	pixclks_cntl = INPLL( pllPIXCLKS_CNTL);
-	
-	pixclks_cntl|=  PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb | 
-			PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb|
-			PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb|
-			PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb|
-			PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb|
-			PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb|
-			PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb;
+	/* RV200::A11 A12, RV250::A11 A12 */
+	if (((rinfo->family == CHIP_FAMILY_RV200) ||
+	     (rinfo->family == CHIP_FAMILY_RV250)) &&
+	    ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) < CFG_ATI_REV_A13)) {
+		tmp = INPLL(pllPLL_PWRMGT_CNTL);
+		tmp |= PLL_PWRMGT_CNTL__TCL_BYPASS_DISABLE;
+		OUTREG(pllPLL_PWRMGT_CNTL, tmp);
+		radeon_msleep(15);
+	}
 
-	OUTPLL( pllPIXCLKS_CNTL, pixclks_cntl);
+	tmp = INPLL(pllPIXCLKS_CNTL);
+	tmp |=  PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb | 
+		PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb|
+		PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb|
+		PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb|
+		PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb|
+		PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb|
+		PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb;
+	OUTPLL(pllPIXCLKS_CNTL, tmp);
+	radeon_msleep(15);
 		
-		
-	vclk_ecp_cntl = INPLL( pllVCLK_ECP_CNTL);
-	
-	vclk_ecp_cntl|=  VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb | 
-			 VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb;
-
-	OUTPLL( pllVCLK_ECP_CNTL, vclk_ecp_cntl);
-
-
-	/* Enable Dynamic mode for MCLK	*/
-
-	mclk_cntl  = INPLL( pllMCLK_CNTL_M6);
-	mclk_cntl |= 	MCLK_CNTL_M6__FORCE_MCLKA|  
-			MCLK_CNTL_M6__FORCE_MCLKB|	
-			MCLK_CNTL_M6__FORCE_YCLKA|
-			MCLK_CNTL_M6__FORCE_YCLKB;
-			
-    	OUTPLL( pllMCLK_CNTL_M6, mclk_cntl);
+	tmp = INPLL(pllVCLK_ECP_CNTL);
+	tmp |=  VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb | 
+		VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb;
+	OUTPLL(pllVCLK_ECP_CNTL, tmp);
+
+	/* X doesn't do that ... hrm, we do on mobility && Macs */
+#ifdef CONFIG_PPC_OF
+	if (rinfo->is_mobility) {
+		tmp  = INPLL(pllMCLK_CNTL);
+		tmp &= ~(MCLK_CNTL__FORCE_MCLKA |
+			 MCLK_CNTL__FORCE_MCLKB |
+			 MCLK_CNTL__FORCE_YCLKA |
+			 MCLK_CNTL__FORCE_YCLKB);
+		OUTPLL(pllMCLK_CNTL, tmp);
+		radeon_msleep(15);
 
-	mclk_misc = INPLL(pllMCLK_MISC);
-	mclk_misc |= 	MCLK_MISC__MC_MCLK_MAX_DYN_STOP_LAT|
+		tmp = INPLL(pllMCLK_MISC);
+		tmp |= 	MCLK_MISC__MC_MCLK_MAX_DYN_STOP_LAT|
 			MCLK_MISC__IO_MCLK_MAX_DYN_STOP_LAT|
 			MCLK_MISC__MC_MCLK_DYN_ENABLE|
-			MCLK_MISC__IO_MCLK_DYN_ENABLE;	
-	
-	OUTPLL(pllMCLK_MISC, mclk_misc);
+			MCLK_MISC__IO_MCLK_DYN_ENABLE;
+		OUTPLL(pllMCLK_MISC, tmp);
+		radeon_msleep(15);
+	}
+#endif /* CONFIG_PPC_OF */
 }
 
 #ifdef CONFIG_PM
@@ -218,7 +475,7 @@
 	return INREG( MC_IND_DATA);
 }
 
-static void radeon_pm_save_regs(struct radeonfb_info *rinfo)
+static void radeon_pm_save_regs(struct radeonfb_info *rinfo, int saving_for_d3)
 {
 	rinfo->save_regs[0] = INPLL(PLL_PWRMGT_CNTL);
 	rinfo->save_regs[1] = INPLL(CLK_PWRMGT_CNTL);
@@ -233,7 +490,6 @@
 	rinfo->save_regs[9] = INREG(DISP_MISC_CNTL);
 	rinfo->save_regs[10] = INREG(DISP_PWR_MAN);
 	rinfo->save_regs[11] = INREG(LVDS_GEN_CNTL);
-	rinfo->save_regs[12] = INREG(LVDS_PLL_CNTL);
 	rinfo->save_regs[13] = INREG(TV_DAC_CNTL);
 	rinfo->save_regs[14] = INREG(BUS_CNTL1);
 	rinfo->save_regs[15] = INREG(CRTC_OFFSET_CNTL);
@@ -256,6 +512,93 @@
 	rinfo->save_regs[31] = INREG(DISPLAY_BASE_ADDR);
 	rinfo->save_regs[32] = INREG(MC_AGP_LOCATION);
 	rinfo->save_regs[33] = INREG(CRTC2_DISPLAY_BASE_ADDR);
+
+	rinfo->save_regs[34] = INPLL(SCLK_MORE_CNTL);
+	rinfo->save_regs[35] = INREG(MEM_SDRAM_MODE_REG);
+	rinfo->save_regs[36] = INREG(BUS_CNTL);
+	rinfo->save_regs[39] = INREG(RBBM_CNTL);
+	rinfo->save_regs[40] = INREG(DAC_CNTL);
+	rinfo->save_regs[41] = INREG(HOST_PATH_CNTL);
+	rinfo->save_regs[37] = INREG(MPP_TB_CONFIG);
+	rinfo->save_regs[38] = INREG(FCP_CNTL);
+
+	if (rinfo->is_mobility) {
+		rinfo->save_regs[12] = INREG(LVDS_PLL_CNTL);
+		rinfo->save_regs[43] = INPLL(pllSSPLL_CNTL);
+		rinfo->save_regs[44] = INPLL(pllSSPLL_REF_DIV);
+		rinfo->save_regs[45] = INPLL(pllSSPLL_DIV_0);
+		rinfo->save_regs[90] = INPLL(pllSS_INT_CNTL);	
+		rinfo->save_regs[91] = INPLL(pllSS_TST_CNTL);	
+		rinfo->save_regs[81] = INREG(LVDS_GEN_CNTL);
+	}
+
+	if (rinfo->family >= CHIP_FAMILY_RV200) {
+		rinfo->save_regs[42] = INREG(MEM_REFRESH_CNTL);
+		rinfo->save_regs[46] = INREG(MC_CNTL);
+		rinfo->save_regs[47] = INREG(MC_INIT_GFX_LAT_TIMER);
+		rinfo->save_regs[48] = INREG(MC_INIT_MISC_LAT_TIMER);
+		rinfo->save_regs[49] = INREG(MC_TIMING_CNTL);
+		rinfo->save_regs[50] = INREG(MC_READ_CNTL_AB);
+		rinfo->save_regs[51] = INREG(MC_IOPAD_CNTL);
+		rinfo->save_regs[52] = INREG(MC_CHIP_IO_OE_CNTL_AB);
+		rinfo->save_regs[53] = INREG(MC_DEBUG);
+	}
+	rinfo->save_regs[54] = INREG(PAMAC0_DLY_CNTL);
+	rinfo->save_regs[55] = INREG(PAMAC1_DLY_CNTL);
+	rinfo->save_regs[56] = INREG(PAD_CTLR_MISC);
+	rinfo->save_regs[57] = INREG(FW_CNTL);
+
+	if (rinfo->family >= CHIP_FAMILY_R300) {
+		rinfo->save_regs[58] = INMC(rinfo, ixR300_MC_MC_INIT_WR_LAT_TIMER);
+		rinfo->save_regs[59] = INMC(rinfo, ixR300_MC_IMP_CNTL);
+		rinfo->save_regs[60] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_C0);
+		rinfo->save_regs[61] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_C1);
+		rinfo->save_regs[62] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_D0);
+		rinfo->save_regs[63] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_D1);
+		rinfo->save_regs[64] = INMC(rinfo, ixR300_MC_BIST_CNTL_3);
+		rinfo->save_regs[65] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_A0);
+		rinfo->save_regs[66] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_A1);
+		rinfo->save_regs[67] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_B0);
+		rinfo->save_regs[68] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_B1);
+		rinfo->save_regs[69] = INMC(rinfo, ixR300_MC_DEBUG_CNTL);
+		rinfo->save_regs[70] = INMC(rinfo, ixR300_MC_DLL_CNTL);
+		rinfo->save_regs[71] = INMC(rinfo, ixR300_MC_IMP_CNTL_0);
+		rinfo->save_regs[72] = INMC(rinfo, ixR300_MC_ELPIDA_CNTL);
+		rinfo->save_regs[96] = INMC(rinfo, ixR300_MC_READ_CNTL_CD);
+	} else {
+		rinfo->save_regs[59] = INMC(rinfo, ixMC_IMP_CNTL);
+		rinfo->save_regs[65] = INMC(rinfo, ixMC_CHP_IO_CNTL_A0);
+		rinfo->save_regs[66] = INMC(rinfo, ixMC_CHP_IO_CNTL_A1);
+		rinfo->save_regs[67] = INMC(rinfo, ixMC_CHP_IO_CNTL_B0);
+		rinfo->save_regs[68] = INMC(rinfo, ixMC_CHP_IO_CNTL_B1);
+		rinfo->save_regs[71] = INMC(rinfo, ixMC_IMP_CNTL_0);
+	}
+
+	rinfo->save_regs[73] = INPLL(pllMPLL_CNTL);
+	rinfo->save_regs[74] = INPLL(pllSPLL_CNTL);
+	rinfo->save_regs[75] = INPLL(pllMPLL_AUX_CNTL);
+	rinfo->save_regs[76] = INPLL(pllSPLL_AUX_CNTL);
+	rinfo->save_regs[77] = INPLL(pllM_SPLL_REF_FB_DIV);
+	rinfo->save_regs[78] = INPLL(pllAGP_PLL_CNTL);
+	rinfo->save_regs[79] = INREG(PAMAC2_DLY_CNTL);
+
+	rinfo->save_regs[80] = INREG(OV0_BASE_ADDR);
+	rinfo->save_regs[82] = INREG(FP_GEN_CNTL);
+	rinfo->save_regs[83] = INREG(FP2_GEN_CNTL);
+	rinfo->save_regs[84] = INREG(TMDS_CNTL);
+	rinfo->save_regs[85] = INREG(TMDS_TRANSMITTER_CNTL);
+	rinfo->save_regs[86] = INREG(DISP_OUTPUT_CNTL);
+	rinfo->save_regs[87] = INREG(DISP_HW_DEBUG);
+	rinfo->save_regs[88] = INREG(TV_MASTER_CNTL);
+	rinfo->save_regs[89] = INPLL(pllP2PLL_REF_DIV);
+	rinfo->save_regs[92] = INPLL(pllPPLL_DIV_0);
+	rinfo->save_regs[93] = INPLL(pllPPLL_CNTL);
+	rinfo->save_regs[94] = INREG(GRPH_BUFFER_CNTL);
+	rinfo->save_regs[95] = INREG(GRPH2_BUFFER_CNTL);
+	rinfo->save_regs[96] = INREG(HDP_DEBUG);
+	rinfo->save_regs[97] = INPLL(pllMDLL_CKO);
+	rinfo->save_regs[98] = INPLL(pllMDLL_RDCKA);
+	rinfo->save_regs[99] = INPLL(pllMDLL_RDCKB);
 }
 
 static void radeon_pm_restore_regs(struct radeonfb_info *rinfo)
@@ -270,12 +613,15 @@
 	OUTPLL(VCLK_ECP_CNTL, rinfo->save_regs[5]);
 	OUTPLL(PIXCLKS_CNTL, rinfo->save_regs[6]);
 	OUTPLL(MCLK_MISC, rinfo->save_regs[7]);
-	
+	if (rinfo->family == CHIP_FAMILY_RV350)
+		OUTPLL(SCLK_MORE_CNTL, rinfo->save_regs[34]);
+
 	OUTREG(SURFACE_CNTL, rinfo->save_regs[29]);
 	OUTREG(MC_FB_LOCATION, rinfo->save_regs[30]);
 	OUTREG(DISPLAY_BASE_ADDR, rinfo->save_regs[31]);
 	OUTREG(MC_AGP_LOCATION, rinfo->save_regs[32]);
 	OUTREG(CRTC2_DISPLAY_BASE_ADDR, rinfo->save_regs[33]);
+	OUTREG(CONFIG_MEMSIZE, rinfo->video_ram);
 
 	OUTREG(DISP_MISC_CNTL, rinfo->save_regs[9]);
 	OUTREG(DISP_PWR_MAN, rinfo->save_regs[10]);
@@ -287,10 +633,8 @@
 	OUTREG(AGP_CNTL, rinfo->save_regs[16]);
 	OUTREG(CRTC_GEN_CNTL, rinfo->save_regs[17]);
 	OUTREG(CRTC2_GEN_CNTL, rinfo->save_regs[18]);
-
-	// wait VBL before that one  ?
 	OUTPLL(P2PLL_CNTL, rinfo->save_regs[8]);
-	
+
 	OUTREG(GPIOPAD_A, rinfo->save_regs[19]);
 	OUTREG(GPIOPAD_EN, rinfo->save_regs[20]);
 	OUTREG(GPIOPAD_MASK, rinfo->save_regs[21]);
@@ -319,30 +663,32 @@
 
 static void radeon_pm_program_v2clk(struct radeonfb_info *rinfo)
 {
-	/* we use __INPLL and _OUTPLL and do the locking ourselves... */
-	unsigned long flags;
-	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	/* Set v2clk to 65MHz */
-  	__OUTPLL(pllPIXCLKS_CNTL,
-  		__INPLL(rinfo, pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
+	if (rinfo->family <= CHIP_FAMILY_RV280) {
+		OUTPLL(pllPIXCLKS_CNTL,
+			 __INPLL(rinfo, pllPIXCLKS_CNTL)
+			 & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
 	 
-  	__OUTPLL(pllP2PLL_REF_DIV, 0x0000000c);
-	__OUTPLL(pllP2PLL_CNTL, 0x0000bf00);
-	__OUTPLL(pllP2PLL_DIV_0, 0x00020074 | P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W);
+		OUTPLL(pllP2PLL_REF_DIV, 0x0000000c);
+		OUTPLL(pllP2PLL_CNTL, 0x0000bf00);
+	} else {
+		OUTPLL(pllP2PLL_REF_DIV, 0x0000000c);
+		INPLL(pllP2PLL_REF_DIV);
+		OUTPLL(pllP2PLL_CNTL, 0x0000a700);
+	}
+
+	OUTPLL(pllP2PLL_DIV_0, 0x00020074 | P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W);
 	
-	__OUTPLL(pllP2PLL_CNTL,
-		__INPLL(rinfo, pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_SLEEP);
+	OUTPLL(pllP2PLL_CNTL, INPLL(pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_SLEEP);
 	mdelay(1);
 
-	__OUTPLL(pllP2PLL_CNTL,
-		__INPLL(rinfo, pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_RESET);
+	OUTPLL(pllP2PLL_CNTL, INPLL(pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_RESET);
 	mdelay( 1);
 
-  	__OUTPLL(pllPIXCLKS_CNTL,
-  		(__INPLL(rinfo, pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK)
+  	OUTPLL(pllPIXCLKS_CNTL,
+  		(INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK)
   		| (0x03 << PIXCLKS_CNTL__PIX2CLK_SRC_SEL__SHIFT));
 	mdelay( 1);	
-	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 }
 
 static void radeon_pm_low_current(struct radeonfb_info *rinfo)
@@ -350,8 +696,12 @@
 	u32 reg;
 
 	reg  = INREG(BUS_CNTL1);
-	reg &= ~BUS_CNTL1_MOBILE_PLATFORM_SEL_MASK;
-	reg |= BUS_CNTL1_AGPCLK_VALID | (1<<BUS_CNTL1_MOBILE_PLATFORM_SEL_SHIFT);
+	if (rinfo->family <= CHIP_FAMILY_RV280) {
+		reg &= ~BUS_CNTL1_MOBILE_PLATFORM_SEL_MASK;
+		reg |= BUS_CNTL1_AGPCLK_VALID | (1<<BUS_CNTL1_MOBILE_PLATFORM_SEL_SHIFT);
+	} else {
+		reg |= 0x4080;
+	}
 	OUTREG(BUS_CNTL1, reg);
 	
 	reg  = INPLL(PLL_PWRMGT_CNTL);
@@ -400,35 +750,42 @@
 	u32 tmp;
 	
 	/* Force Core Clocks */
-	sclk_cntl = INPLL( pllSCLK_CNTL_M6);
-	sclk_cntl |= 	SCLK_CNTL_M6__IDCT_MAX_DYN_STOP_LAT|
-			SCLK_CNTL_M6__VIP_MAX_DYN_STOP_LAT|
-			SCLK_CNTL_M6__RE_MAX_DYN_STOP_LAT|
-			SCLK_CNTL_M6__PB_MAX_DYN_STOP_LAT|
-			SCLK_CNTL_M6__TAM_MAX_DYN_STOP_LAT|
-			SCLK_CNTL_M6__TDM_MAX_DYN_STOP_LAT|
-			SCLK_CNTL_M6__RB_MAX_DYN_STOP_LAT|
+	sclk_cntl = INPLL( pllSCLK_CNTL);
+	sclk_cntl |= 	SCLK_CNTL__IDCT_MAX_DYN_STOP_LAT|
+			SCLK_CNTL__VIP_MAX_DYN_STOP_LAT|
+			SCLK_CNTL__RE_MAX_DYN_STOP_LAT|
+			SCLK_CNTL__PB_MAX_DYN_STOP_LAT|
+			SCLK_CNTL__TAM_MAX_DYN_STOP_LAT|
+			SCLK_CNTL__TDM_MAX_DYN_STOP_LAT|
+			SCLK_CNTL__RB_MAX_DYN_STOP_LAT|
 			
-			SCLK_CNTL_M6__FORCE_DISP2|
-			SCLK_CNTL_M6__FORCE_CP|
-			SCLK_CNTL_M6__FORCE_HDP|
-			SCLK_CNTL_M6__FORCE_DISP1|
-			SCLK_CNTL_M6__FORCE_TOP|
-			SCLK_CNTL_M6__FORCE_E2|
-			SCLK_CNTL_M6__FORCE_SE|
-			SCLK_CNTL_M6__FORCE_IDCT|
-			SCLK_CNTL_M6__FORCE_VIP|
+			SCLK_CNTL__FORCE_DISP2|
+			SCLK_CNTL__FORCE_CP|
+			SCLK_CNTL__FORCE_HDP|
+			SCLK_CNTL__FORCE_DISP1|
+			SCLK_CNTL__FORCE_TOP|
+			SCLK_CNTL__FORCE_E2|
+			SCLK_CNTL__FORCE_SE|
+			SCLK_CNTL__FORCE_IDCT|
+			SCLK_CNTL__FORCE_VIP|
 			
-			SCLK_CNTL_M6__FORCE_RE|
-			SCLK_CNTL_M6__FORCE_PB|
-			SCLK_CNTL_M6__FORCE_TAM|
-			SCLK_CNTL_M6__FORCE_TDM|
-			SCLK_CNTL_M6__FORCE_RB|
-			SCLK_CNTL_M6__FORCE_TV_SCLK|
-			SCLK_CNTL_M6__FORCE_SUBPIC|
-			SCLK_CNTL_M6__FORCE_OV0;
+			SCLK_CNTL__FORCE_PB|
+			SCLK_CNTL__FORCE_TAM|
+			SCLK_CNTL__FORCE_TDM|
+			SCLK_CNTL__FORCE_RB|
+			SCLK_CNTL__FORCE_TV_SCLK|
+			SCLK_CNTL__FORCE_SUBPIC|
+			SCLK_CNTL__FORCE_OV0;
+	if (rinfo->family <= CHIP_FAMILY_RV280)
+		sclk_cntl |= SCLK_CNTL__FORCE_RE;
+	else
+		sclk_cntl |= SCLK_CNTL__SE_MAX_DYN_STOP_LAT |
+			SCLK_CNTL__E2_MAX_DYN_STOP_LAT |
+			SCLK_CNTL__TV_MAX_DYN_STOP_LAT |
+			SCLK_CNTL__HDP_MAX_DYN_STOP_LAT |
+			SCLK_CNTL__CP_MAX_DYN_STOP_LAT;
 
-	OUTPLL( pllSCLK_CNTL_M6, sclk_cntl);
+	OUTPLL( pllSCLK_CNTL, sclk_cntl);
 
 	sclk_more_cntl = INPLL(pllSCLK_MORE_CNTL);
 	sclk_more_cntl |= 	SCLK_MORE_CNTL__FORCE_DISPREGS |
@@ -438,18 +795,19 @@
 	OUTPLL(pllSCLK_MORE_CNTL, sclk_more_cntl);		
 
 	
-	mclk_cntl = INPLL( pllMCLK_CNTL_M6);
-	mclk_cntl &= ~(	MCLK_CNTL_M6__FORCE_MCLKA |  
-			MCLK_CNTL_M6__FORCE_MCLKB |
-			MCLK_CNTL_M6__FORCE_YCLKA | 
-			MCLK_CNTL_M6__FORCE_YCLKB | 
-			MCLK_CNTL_M6__FORCE_MC
+	mclk_cntl = INPLL( pllMCLK_CNTL);
+	mclk_cntl &= ~(	MCLK_CNTL__FORCE_MCLKA |  
+			MCLK_CNTL__FORCE_MCLKB |
+			MCLK_CNTL__FORCE_YCLKA | 
+			MCLK_CNTL__FORCE_YCLKB | 
+			MCLK_CNTL__FORCE_MC
 		      );	
-    	OUTPLL( pllMCLK_CNTL_M6, mclk_cntl);
+    	OUTPLL( pllMCLK_CNTL, mclk_cntl);
 	
 	/* Force Display clocks	*/
 	vclk_ecp_cntl = INPLL( pllVCLK_ECP_CNTL);
-	vclk_ecp_cntl &= ~(VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb |VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb);
+	vclk_ecp_cntl &= ~(VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb
+			   | VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb);
 	vclk_ecp_cntl |= VCLK_ECP_CNTL__ECP_FORCE_ON;
 	OUTPLL( pllVCLK_ECP_CNTL, vclk_ecp_cntl);
 	
@@ -480,26 +838,27 @@
 						
 	OUTPLL( pllPLL_PWRMGT_CNTL, pll_pwrmgt_cntl);
 	
-	clk_pwrmgt_cntl	 = INPLL( pllCLK_PWRMGT_CNTL_M6);
+	clk_pwrmgt_cntl	 = INPLL( pllCLK_PWRMGT_CNTL);
 	
-	clk_pwrmgt_cntl &= ~(	CLK_PWRMGT_CNTL_M6__MPLL_PWRMGT_OFF|
-				CLK_PWRMGT_CNTL_M6__SPLL_PWRMGT_OFF|
-				CLK_PWRMGT_CNTL_M6__PPLL_PWRMGT_OFF|
-				CLK_PWRMGT_CNTL_M6__P2PLL_PWRMGT_OFF|
-				CLK_PWRMGT_CNTL_M6__MCLK_TURNOFF|
-				CLK_PWRMGT_CNTL_M6__SCLK_TURNOFF|
-				CLK_PWRMGT_CNTL_M6__PCLK_TURNOFF|
-				CLK_PWRMGT_CNTL_M6__P2CLK_TURNOFF|
-				CLK_PWRMGT_CNTL_M6__TVPLL_PWRMGT_OFF|
-				CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN|
-				CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE|
-				CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT_MASK|
-				CLK_PWRMGT_CNTL_M6__CG_NO1_DEBUG_MASK			
+	clk_pwrmgt_cntl &= ~(	CLK_PWRMGT_CNTL__MPLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL__SPLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL__PPLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL__P2PLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL__MCLK_TURNOFF|
+				CLK_PWRMGT_CNTL__SCLK_TURNOFF|
+				CLK_PWRMGT_CNTL__PCLK_TURNOFF|
+				CLK_PWRMGT_CNTL__P2CLK_TURNOFF|
+				CLK_PWRMGT_CNTL__TVPLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL__GLOBAL_PMAN_EN|
+				CLK_PWRMGT_CNTL__ENGINE_DYNCLK_MODE|
+				CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT_MASK|
+				CLK_PWRMGT_CNTL__CG_NO1_DEBUG_MASK			
 			);
 						
-	clk_pwrmgt_cntl |= CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN | CLK_PWRMGT_CNTL_M6__DISP_PM;
+	clk_pwrmgt_cntl |= CLK_PWRMGT_CNTL__GLOBAL_PMAN_EN 
+		| CLK_PWRMGT_CNTL__DISP_PM;
 	
-	OUTPLL( pllCLK_PWRMGT_CNTL_M6, clk_pwrmgt_cntl);	
+	OUTPLL( pllCLK_PWRMGT_CNTL, clk_pwrmgt_cntl);	
 	
 	clk_pin_cntl = INPLL( pllCLK_PIN_CNTL);
 	
@@ -510,12 +869,19 @@
 	OUTPLL( pllMCLK_MISC, tmp);
 	
 	/* AGP PLL control */
-	OUTREG(BUS_CNTL1, INREG(BUS_CNTL1) |  BUS_CNTL1__AGPCLK_VALID);
+	if (rinfo->family <= CHIP_FAMILY_RV280) {
+		OUTREG(BUS_CNTL1, INREG(BUS_CNTL1) |  BUS_CNTL1__AGPCLK_VALID);
 
-	OUTREG(BUS_CNTL1,
-		(INREG(BUS_CNTL1) & ~BUS_CNTL1__MOBILE_PLATFORM_SEL_MASK)
-		| (2<<BUS_CNTL1__MOBILE_PLATFORM_SEL__SHIFT));	// 440BX
-	OUTREG(CRTC_OFFSET_CNTL, (INREG(CRTC_OFFSET_CNTL) & ~CRTC_OFFSET_CNTL__CRTC_STEREO_SYNC_OUT_EN));
+		OUTREG(BUS_CNTL1,
+		       (INREG(BUS_CNTL1) & ~BUS_CNTL1__MOBILE_PLATFORM_SEL_MASK)
+		       | (2<<BUS_CNTL1__MOBILE_PLATFORM_SEL__SHIFT));	// 440BX
+	} else {
+		OUTREG(BUS_CNTL1, INREG(BUS_CNTL1));
+		OUTREG(BUS_CNTL1, (INREG(BUS_CNTL1) & ~0x4000) | 0x8000);
+	}
+
+	OUTREG(CRTC_OFFSET_CNTL, (INREG(CRTC_OFFSET_CNTL)
+				  & ~CRTC_OFFSET_CNTL__CRTC_STEREO_SYNC_OUT_EN));
 	
 	clk_pin_cntl &= ~CLK_PIN_CNTL__CG_CLK_TO_OUTPIN;
 	clk_pin_cntl |= CLK_PIN_CNTL__XTALIN_ALWAYS_ONb;	
@@ -547,16 +913,16 @@
 				DISP_MISC_CNTL__SOFT_RESET_DIG_TMDS|
 				DISP_MISC_CNTL__SOFT_RESET_TV);
 	
-	OUTREG(DISP_MISC_CNTL, disp_mis_cntl);					
+	OUTREG(DISP_MISC_CNTL, disp_mis_cntl);
 						
 	disp_pwr_man = INREG(DISP_PWR_MAN);
 	
 	disp_pwr_man &= ~(	DISP_PWR_MAN__DISP_PWR_MAN_D3_CRTC_EN	| 
-						DISP_PWR_MAN__DISP2_PWR_MAN_D3_CRTC2_EN |
-						DISP_PWR_MAN__DISP_PWR_MAN_DPMS_MASK|		
-						DISP_PWR_MAN__DISP_D3_RST|
-						DISP_PWR_MAN__DISP_D3_REG_RST
-					);
+				DISP_PWR_MAN__DISP2_PWR_MAN_D3_CRTC2_EN |
+				DISP_PWR_MAN__DISP_PWR_MAN_DPMS_MASK|
+				DISP_PWR_MAN__DISP_D3_RST|
+				DISP_PWR_MAN__DISP_D3_REG_RST
+				);
 	
 	disp_pwr_man |= DISP_PWR_MAN__DISP_D3_GRPH_RST|
 					DISP_PWR_MAN__DISP_D3_SUBPIC_RST|
@@ -571,27 +937,29 @@
 	
 	OUTREG(DISP_PWR_MAN, disp_pwr_man);					
 							
-	clk_pwrmgt_cntl = INPLL( pllCLK_PWRMGT_CNTL_M6);
+	clk_pwrmgt_cntl = INPLL( pllCLK_PWRMGT_CNTL);
 	pll_pwrmgt_cntl = INPLL( pllPLL_PWRMGT_CNTL) ;
 	clk_pin_cntl 	= INPLL( pllCLK_PIN_CNTL);
 	disp_pwr_man	= INREG(DISP_PWR_MAN);
 		
 	
 	/* D2 */
-	clk_pwrmgt_cntl |= CLK_PWRMGT_CNTL_M6__DISP_PM;
+	clk_pwrmgt_cntl |= CLK_PWRMGT_CNTL__DISP_PM;
 	pll_pwrmgt_cntl |= PLL_PWRMGT_CNTL__MOBILE_SU | PLL_PWRMGT_CNTL__SU_SCLK_USE_BCLK;
 	clk_pin_cntl	|= CLK_PIN_CNTL__XTALIN_ALWAYS_ONb;
-	disp_pwr_man 	&= ~(DISP_PWR_MAN__DISP_PWR_MAN_D3_CRTC_EN_MASK | DISP_PWR_MAN__DISP2_PWR_MAN_D3_CRTC2_EN_MASK);							
-						
+	disp_pwr_man 	&= ~(DISP_PWR_MAN__DISP_PWR_MAN_D3_CRTC_EN_MASK
+			     | DISP_PWR_MAN__DISP2_PWR_MAN_D3_CRTC2_EN_MASK);
 
-	OUTPLL( pllCLK_PWRMGT_CNTL_M6, clk_pwrmgt_cntl);
+	OUTPLL( pllCLK_PWRMGT_CNTL, clk_pwrmgt_cntl);
 	OUTPLL( pllPLL_PWRMGT_CNTL, pll_pwrmgt_cntl);
 	OUTPLL( pllCLK_PIN_CNTL, clk_pin_cntl);
 	OUTREG(DISP_PWR_MAN, disp_pwr_man);
 
 	/* disable display request & disable display */
-	OUTREG( CRTC_GEN_CNTL, (INREG( CRTC_GEN_CNTL) & ~CRTC_GEN_CNTL__CRTC_EN) | CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B);
-	OUTREG( CRTC2_GEN_CNTL, (INREG( CRTC2_GEN_CNTL) & ~CRTC2_GEN_CNTL__CRTC2_EN) | CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B);
+	OUTREG( CRTC_GEN_CNTL, (INREG( CRTC_GEN_CNTL) & ~CRTC_GEN_CNTL__CRTC_EN)
+		| CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B);
+	OUTREG( CRTC2_GEN_CNTL, (INREG( CRTC2_GEN_CNTL) & ~CRTC2_GEN_CNTL__CRTC2_EN)
+		| CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B);
 
 	mdelay(17);				   
 
@@ -601,17 +969,15 @@
 {
 	u32 mc_chp_io_cntl_a1, mc_chp_io_cntl_b1;
 
-	mc_chp_io_cntl_a1 = INMC( rinfo, ixMC_CHP_IO_CNTL_A1) & ~MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA_MASK;
-	mc_chp_io_cntl_b1 = INMC( rinfo, ixMC_CHP_IO_CNTL_B1) & ~MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB_MASK;
-
-	OUTMC( rinfo, ixMC_CHP_IO_CNTL_A1, mc_chp_io_cntl_a1 | (1<<MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA__SHIFT));
-	OUTMC( rinfo, ixMC_CHP_IO_CNTL_B1, mc_chp_io_cntl_b1 | (1<<MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB__SHIFT));
-
-	/* Wassup ? This doesn't seem to be defined, let's hope we are ok this way --BenH */
-#ifdef MCLK_YCLK_SYNC_ENABLE
-	mc_chp_io_cntl_a1 |= (2<<MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA__SHIFT);
-	mc_chp_io_cntl_b1 |= (2<<MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB__SHIFT);
-#endif
+	mc_chp_io_cntl_a1 = INMC( rinfo, ixMC_CHP_IO_CNTL_A1)
+		& ~MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA_MASK;
+	mc_chp_io_cntl_b1 = INMC( rinfo, ixMC_CHP_IO_CNTL_B1)
+		& ~MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB_MASK;
+
+	OUTMC( rinfo, ixMC_CHP_IO_CNTL_A1, mc_chp_io_cntl_a1
+	       | (1<<MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA__SHIFT));
+	OUTMC( rinfo, ixMC_CHP_IO_CNTL_B1, mc_chp_io_cntl_b1
+	       | (1<<MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB__SHIFT));
 
 	OUTMC( rinfo, ixMC_CHP_IO_CNTL_A1, mc_chp_io_cntl_a1);
 	OUTMC( rinfo, ixMC_CHP_IO_CNTL_B1, mc_chp_io_cntl_b1);
@@ -619,25 +985,70 @@
 	mdelay( 1);
 }
 
-static void radeon_pm_program_mode_reg(struct radeonfb_info *rinfo, u16 value, u8 delay_required)
+static void radeon_pm_yclk_mclk_sync_m10(struct radeonfb_info *rinfo)
+{
+	u32 mc_chp_io_cntl_a1, mc_chp_io_cntl_b1;
+
+	mc_chp_io_cntl_a1 = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_A1)
+		& ~MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA_MASK;
+	mc_chp_io_cntl_b1 = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_B1)
+		& ~MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB_MASK;
+
+	OUTMC( rinfo, ixR300_MC_CHP_IO_CNTL_A1,
+	       mc_chp_io_cntl_a1 | (1<<MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA__SHIFT));
+	OUTMC( rinfo, ixR300_MC_CHP_IO_CNTL_B1,
+	       mc_chp_io_cntl_b1 | (1<<MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB__SHIFT));
+
+	OUTMC( rinfo, ixR300_MC_CHP_IO_CNTL_A1, mc_chp_io_cntl_a1);
+	OUTMC( rinfo, ixR300_MC_CHP_IO_CNTL_B1, mc_chp_io_cntl_b1);
+
+	mdelay( 1);
+}
+
+static void radeon_pm_program_mode_reg(struct radeonfb_info *rinfo, u16 value,
+				       u8 delay_required)
 {  
 	u32 mem_sdram_mode;
 
 	mem_sdram_mode  = INREG( MEM_SDRAM_MODE_REG);
 
 	mem_sdram_mode &= ~MEM_SDRAM_MODE_REG__MEM_MODE_REG_MASK;
-	mem_sdram_mode |= (value<<MEM_SDRAM_MODE_REG__MEM_MODE_REG__SHIFT) | MEM_SDRAM_MODE_REG__MEM_CFG_TYPE;
+	mem_sdram_mode |= (value<<MEM_SDRAM_MODE_REG__MEM_MODE_REG__SHIFT)
+		| MEM_SDRAM_MODE_REG__MEM_CFG_TYPE;
 	OUTREG( MEM_SDRAM_MODE_REG, mem_sdram_mode);
+	if (delay_required >= 2)
+		mdelay(1);
 
 	mem_sdram_mode |=  MEM_SDRAM_MODE_REG__MEM_SDRAM_RESET;
 	OUTREG( MEM_SDRAM_MODE_REG, mem_sdram_mode);
+	if (delay_required >= 2)
+		mdelay(1);
 
 	mem_sdram_mode &= ~MEM_SDRAM_MODE_REG__MEM_SDRAM_RESET;
 	OUTREG( MEM_SDRAM_MODE_REG, mem_sdram_mode);
+	if (delay_required >= 2)
+		mdelay(1);
+
+	if (delay_required) {
+		do {
+			if (delay_required >= 2)
+				mdelay(1);
+		} while ((INREG(MC_STATUS)
+			  & (MC_STATUS__MEM_PWRUP_COMPL_A |
+			     MC_STATUS__MEM_PWRUP_COMPL_B)) == 0);
+	}
+}
+
+static void radeon_pm_m10_program_mode_wait(struct radeonfb_info *rinfo)
+{
+	int cnt;
 
-	if (delay_required == 1)
-		while( (INREG( MC_STATUS) & (MC_STATUS__MEM_PWRUP_COMPL_A | MC_STATUS__MEM_PWRUP_COMPL_B) ) == 0 )
-			{ }; 	
+	for (cnt = 0; cnt < 100; ++cnt) {
+		mdelay(1);
+		if (INREG(MC_STATUS) & (MC_STATUS__MEM_PWRUP_COMPL_A
+					| MC_STATUS__MEM_PWRUP_COMPL_B))
+			break;
+	}
 }
 
 
@@ -646,126 +1057,274 @@
 #define DLL_RESET_DELAY 	5
 #define DLL_SLEEP_DELAY		1
 
-	u32 DLL_CKO_Value = INPLL(pllMDLL_CKO)   | MDLL_CKO__MCKOA_SLEEP |  MDLL_CKO__MCKOA_RESET;
-	u32 DLL_CKA_Value = INPLL(pllMDLL_RDCKA) | MDLL_RDCKA__MRDCKA0_SLEEP | MDLL_RDCKA__MRDCKA1_SLEEP | MDLL_RDCKA__MRDCKA0_RESET | MDLL_RDCKA__MRDCKA1_RESET;
-	u32 DLL_CKB_Value = INPLL(pllMDLL_RDCKB) | MDLL_RDCKB__MRDCKB0_SLEEP | MDLL_RDCKB__MRDCKB1_SLEEP | MDLL_RDCKB__MRDCKB0_RESET | MDLL_RDCKB__MRDCKB1_RESET;
+	u32 cko = INPLL(pllMDLL_CKO)   | MDLL_CKO__MCKOA_SLEEP
+		| MDLL_CKO__MCKOA_RESET;
+	u32 cka = INPLL(pllMDLL_RDCKA) | MDLL_RDCKA__MRDCKA0_SLEEP
+		| MDLL_RDCKA__MRDCKA1_SLEEP | MDLL_RDCKA__MRDCKA0_RESET
+		| MDLL_RDCKA__MRDCKA1_RESET;
+	u32 ckb = INPLL(pllMDLL_RDCKB) | MDLL_RDCKB__MRDCKB0_SLEEP
+		| MDLL_RDCKB__MRDCKB1_SLEEP | MDLL_RDCKB__MRDCKB0_RESET
+		| MDLL_RDCKB__MRDCKB1_RESET;
 
 	/* Setting up the DLL range for write */
-	OUTPLL(pllMDLL_CKO,   	DLL_CKO_Value);
-	OUTPLL(pllMDLL_RDCKA,  	DLL_CKA_Value);
-	OUTPLL(pllMDLL_RDCKB,	DLL_CKB_Value);
-
-	mdelay( DLL_RESET_DELAY);
-
-	/* Channel A */
-
-	/* Power Up */
-	DLL_CKO_Value &= ~(MDLL_CKO__MCKOA_SLEEP );
-	OUTPLL(pllMDLL_CKO,   	DLL_CKO_Value);
-	mdelay( DLL_SLEEP_DELAY);  		
-   
-	DLL_CKO_Value &= ~(MDLL_CKO__MCKOA_RESET );
-	OUTPLL(pllMDLL_CKO,	DLL_CKO_Value);
-	mdelay( DLL_RESET_DELAY);  		
-
-	/* Power Up */
-	DLL_CKA_Value &= ~(MDLL_RDCKA__MRDCKA0_SLEEP );
-	OUTPLL(pllMDLL_RDCKA,  	DLL_CKA_Value);
-	mdelay( DLL_SLEEP_DELAY);  		
-
-	DLL_CKA_Value &= ~(MDLL_RDCKA__MRDCKA0_RESET );
-	OUTPLL(pllMDLL_RDCKA,	DLL_CKA_Value);
-	mdelay( DLL_RESET_DELAY);  		
-
-	/* Power Up */
-	DLL_CKA_Value &= ~(MDLL_RDCKA__MRDCKA1_SLEEP);
-	OUTPLL(pllMDLL_RDCKA,	DLL_CKA_Value);
-	mdelay( DLL_SLEEP_DELAY);  		
+	OUTPLL(pllMDLL_CKO,   	cko);
+	OUTPLL(pllMDLL_RDCKA,  	cka);
+	OUTPLL(pllMDLL_RDCKB,	ckb);
+
+	mdelay(DLL_RESET_DELAY*2);
+
+	cko &= ~(MDLL_CKO__MCKOA_SLEEP | MDLL_CKO__MCKOB_SLEEP);
+	OUTPLL(pllMDLL_CKO, cko);
+	mdelay(DLL_SLEEP_DELAY);
+	cko &= ~(MDLL_CKO__MCKOA_RESET | MDLL_CKO__MCKOB_RESET);
+	OUTPLL(pllMDLL_CKO, cko);
+	mdelay(DLL_RESET_DELAY);
+
+	cka &= ~(MDLL_RDCKA__MRDCKA0_SLEEP | MDLL_RDCKA__MRDCKA1_SLEEP);
+	OUTPLL(pllMDLL_RDCKA, cka);
+	mdelay(DLL_SLEEP_DELAY);
+	cka &= ~(MDLL_RDCKA__MRDCKA0_RESET | MDLL_RDCKA__MRDCKA1_RESET);
+	OUTPLL(pllMDLL_RDCKA, cka);
+	mdelay(DLL_RESET_DELAY);
+
+	ckb &= ~(MDLL_RDCKB__MRDCKB0_SLEEP | MDLL_RDCKB__MRDCKB1_SLEEP);
+	OUTPLL(pllMDLL_RDCKB, ckb);
+	mdelay(DLL_SLEEP_DELAY);
+	ckb &= ~(MDLL_RDCKB__MRDCKB0_RESET | MDLL_RDCKB__MRDCKB1_RESET);
+	OUTPLL(pllMDLL_RDCKB, ckb);
+	mdelay(DLL_RESET_DELAY);
 
-	DLL_CKA_Value &= ~(MDLL_RDCKA__MRDCKA1_RESET);
-	OUTPLL(pllMDLL_RDCKA,	DLL_CKA_Value);
-	mdelay( DLL_RESET_DELAY);  		
 
+#undef DLL_RESET_DELAY 
+#undef DLL_SLEEP_DELAY
+}
 
-	/* Channel B */
+static void radeon_pm_enable_dll_m10(struct radeonfb_info *rinfo)
+{  
+	u32 dll_value;
+	u32 dll_sleep_mask = 0;
+	u32 dll_reset_mask = 0;
+	u32 mc;
 
-	/* Power Up */
-	DLL_CKO_Value &= ~(MDLL_CKO__MCKOB_SLEEP );
-	OUTPLL(pllMDLL_CKO,   	DLL_CKO_Value);
-	mdelay( DLL_SLEEP_DELAY);  		
-   
-	DLL_CKO_Value &= ~(MDLL_CKO__MCKOB_RESET );
-	OUTPLL(pllMDLL_CKO,   	DLL_CKO_Value);
-	mdelay( DLL_RESET_DELAY);  		
+#define DLL_RESET_DELAY 	5
+#define DLL_SLEEP_DELAY		1
 
-	/* Power Up */
-	DLL_CKB_Value &= ~(MDLL_RDCKB__MRDCKB0_SLEEP);
-	OUTPLL(pllMDLL_RDCKB,   DLL_CKB_Value);
-	mdelay( DLL_SLEEP_DELAY);  		
+	OUTMC(rinfo, ixR300_MC_DLL_CNTL, rinfo->save_regs[70]);
+	mc = INREG(MC_CNTL);
+	/* Check which channels are enabled */
+	switch (mc & 0x3) {
+	case 1:
+		if (mc & 0x4)
+			break;
+	case 2:
+		dll_sleep_mask |= MDLL_R300_RDCK__MRDCKB_SLEEP;
+		dll_reset_mask |= MDLL_R300_RDCK__MRDCKB_RESET;
+	case 0:
+		dll_sleep_mask |= MDLL_R300_RDCK__MRDCKA_SLEEP;
+		dll_reset_mask |= MDLL_R300_RDCK__MRDCKA_RESET;
+	}
+	switch (mc & 0x3) {
+	case 1:
+		if (!(mc & 0x4))
+			break;
+	case 2:
+		dll_sleep_mask |= MDLL_R300_RDCK__MRDCKD_SLEEP;
+		dll_reset_mask |= MDLL_R300_RDCK__MRDCKD_RESET;
+		dll_sleep_mask |= MDLL_R300_RDCK__MRDCKC_SLEEP;
+		dll_reset_mask |= MDLL_R300_RDCK__MRDCKC_RESET;
+	}
 
-	DLL_CKB_Value &= ~(MDLL_RDCKB__MRDCKB0_RESET);
-	OUTPLL(pllMDLL_RDCKB,   DLL_CKB_Value);
-	mdelay( DLL_RESET_DELAY);  		
+	dll_value = INPLL(pllMDLL_RDCKA);
 
 	/* Power Up */
-	DLL_CKB_Value &= ~(MDLL_RDCKB__MRDCKB1_SLEEP);
-	OUTPLL(pllMDLL_RDCKB,   DLL_CKB_Value);
+	dll_value &= ~(dll_sleep_mask);
+	OUTPLL(pllMDLL_RDCKA, dll_value);
 	mdelay( DLL_SLEEP_DELAY);  		
 
-	DLL_CKB_Value &= ~(MDLL_RDCKB__MRDCKB1_RESET);
-	OUTPLL(pllMDLL_RDCKB,   DLL_CKB_Value);
+	dll_value &= ~(dll_reset_mask);
+	OUTPLL(pllMDLL_RDCKA, dll_value);
 	mdelay( DLL_RESET_DELAY);  		
 
 #undef DLL_RESET_DELAY 
 #undef DLL_SLEEP_DELAY
 }
 
+
 static void radeon_pm_full_reset_sdram(struct radeonfb_info *rinfo)
 {
-	u32 crtcGenCntl, crtcGenCntl2, memRefreshCntl, crtc_more_cntl, fp_gen_cntl, fp2_gen_cntl;
+	u32 crtcGenCntl, crtcGenCntl2, memRefreshCntl, crtc_more_cntl,
+		fp_gen_cntl, fp2_gen_cntl;
  
 	crtcGenCntl  = INREG( CRTC_GEN_CNTL);
 	crtcGenCntl2 = INREG( CRTC2_GEN_CNTL);
 
-	memRefreshCntl 	= INREG( MEM_REFRESH_CNTL);
 	crtc_more_cntl 	= INREG( CRTC_MORE_CNTL);
 	fp_gen_cntl 	= INREG( FP_GEN_CNTL);
 	fp2_gen_cntl 	= INREG( FP2_GEN_CNTL);
  
 
-	OUTREG( CRTC_MORE_CNTL, 	0);
-	OUTREG( FP_GEN_CNTL, 	0);
-	OUTREG( FP2_GEN_CNTL, 	0);
+	OUTREG( CRTC_MORE_CNTL, 0);
+	OUTREG( FP_GEN_CNTL, 0);
+	OUTREG( FP2_GEN_CNTL,0);
  
 	OUTREG( CRTC_GEN_CNTL,  (crtcGenCntl | CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B) );
 	OUTREG( CRTC2_GEN_CNTL, (crtcGenCntl2 | CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B) );
   
-	/* Disable refresh */
-	OUTREG( MEM_REFRESH_CNTL, memRefreshCntl | MEM_REFRESH_CNTL__MEM_REFRESH_DIS);
+	/* This is the code for the Aluminium PowerBooks M10 */
+	if (rinfo->family == CHIP_FAMILY_RV350) {
+		u32 sdram_mode_reg = rinfo->save_regs[35];
+		static u32 default_mrtable[] =
+			{ 0x21320032,
+			  0x21321000, 0xa1321000, 0x21321000, 0xffffffff,
+			  0x21320032, 0xa1320032, 0x21320032, 0xffffffff,
+			  0x21321002, 0xa1321002, 0x21321002, 0xffffffff,
+			  0x21320132, 0xa1320132, 0x21320132, 0xffffffff,
+			  0x21320032, 0xa1320032, 0x21320032, 0xffffffff,
+			  0x31320032 };
+
+		u32 *mrtable = default_mrtable;
+		int i, mrtable_size = ARRAY_SIZE(default_mrtable);
+						 
+		mdelay(30);
+
+		/* Disable refresh */
+		memRefreshCntl 	= INREG( MEM_REFRESH_CNTL)
+			& ~MEM_REFRESH_CNTL__MEM_REFRESH_DIS;
+		OUTREG( MEM_REFRESH_CNTL, memRefreshCntl 
+			| MEM_REFRESH_CNTL__MEM_REFRESH_DIS);
+ 
+		/* Configure and enable M & SPLLs */
+       		radeon_pm_enable_dll_m10(rinfo);
+		radeon_pm_yclk_mclk_sync_m10(rinfo);
+
+#ifdef CONFIG_PPC_OF
+		if (rinfo->of_node != NULL) {
+			int size;
+
+			mrtable = (u32 *)get_property(rinfo->of_node, "ATY,MRT", &size);
+			if (mrtable)
+				mrtable_size = size >> 2;
+			else
+				mrtable = default_mrtable;
+		}
+#endif /* CONFIG_PPC_OF */
+
+		/* Program the SDRAM */
+		sdram_mode_reg = mrtable[0];
+		OUTREG(MEM_SDRAM_MODE_REG, sdram_mode_reg);
+		for (i = 0; i < mrtable_size; i++) {
+			if (mrtable[i] == 0xffffffffu)
+				radeon_pm_m10_program_mode_wait(rinfo);
+			else {
+				sdram_mode_reg &= ~(MEM_SDRAM_MODE_REG__MEM_MODE_REG_MASK
+						    | MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE
+						    | MEM_SDRAM_MODE_REG__MEM_SDRAM_RESET);
+				sdram_mode_reg |= mrtable[i];
+
+				OUTREG(MEM_SDRAM_MODE_REG, sdram_mode_reg);
+				mdelay(1);
+			}
+		}
+
+		/* Restore memory refresh */
+		OUTREG(MEM_REFRESH_CNTL, memRefreshCntl);
+		mdelay(30);
+
+	}
+	/* Here come the desktop RV200 "QW" card */
+	else if (!rinfo->is_mobility && rinfo->family == CHIP_FAMILY_RV200) {
+		/* Disable refresh */
+		memRefreshCntl 	= INREG( MEM_REFRESH_CNTL)
+			& ~MEM_REFRESH_CNTL__MEM_REFRESH_DIS;
+		OUTREG(MEM_REFRESH_CNTL, memRefreshCntl
+		       | MEM_REFRESH_CNTL__MEM_REFRESH_DIS);
+		mdelay(30);
+ 
+		/* Reset memory */
+		OUTREG(MEM_SDRAM_MODE_REG,
+		       INREG( MEM_SDRAM_MODE_REG) & ~MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
+
+		radeon_pm_program_mode_reg(rinfo, 0x2002, 2);
+		radeon_pm_program_mode_reg(rinfo, 0x0132, 2);   
+		radeon_pm_program_mode_reg(rinfo, 0x0032, 2); 
+
+		OUTREG(MEM_SDRAM_MODE_REG,
+		       INREG(MEM_SDRAM_MODE_REG) | MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
+
+		OUTREG( MEM_REFRESH_CNTL, 	memRefreshCntl);
+
+	}
+	/* The M6 */
+	else if (rinfo->is_mobility && rinfo->family == CHIP_FAMILY_RV100) {
+		/* Disable refresh */
+		memRefreshCntl = INREG(EXT_MEM_CNTL) & ~(1 << 20);
+		OUTREG( EXT_MEM_CNTL, memRefreshCntl | (1 << 20));
  
-	/* Reset memory */
-	OUTREG( MEM_SDRAM_MODE_REG,
-		INREG( MEM_SDRAM_MODE_REG) & ~MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE); // Init  Not Complete
+		/* Reset memory */
+		OUTREG( MEM_SDRAM_MODE_REG,
+			INREG( MEM_SDRAM_MODE_REG)
+			& ~MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
 
-	/* DLL */
-	radeon_pm_enable_dll(rinfo);
+		/* DLL */
+		radeon_pm_enable_dll(rinfo);
 
-	// MLCK /YCLK sync 
-	radeon_pm_yclk_mclk_sync(rinfo);
+		/* MLCK / YCLK sync */
+		radeon_pm_yclk_mclk_sync(rinfo);
 
-       	/* M6, M7 and M9 so far ... */
-	if (rinfo->is_mobility && rinfo->family <= CHIP_FAMILY_RV250) {
+		/* Program Mode Register */
 		radeon_pm_program_mode_reg(rinfo, 0x2000, 1);   
 		radeon_pm_program_mode_reg(rinfo, 0x2001, 1);   
 		radeon_pm_program_mode_reg(rinfo, 0x2002, 1);   
 		radeon_pm_program_mode_reg(rinfo, 0x0132, 1);   
 		radeon_pm_program_mode_reg(rinfo, 0x0032, 1); 
-	}	
 
-	OUTREG( MEM_SDRAM_MODE_REG,
-		INREG( MEM_SDRAM_MODE_REG) |  MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE); // Init Complete
+		/* Complete & re-enable refresh */
+		OUTREG( MEM_SDRAM_MODE_REG,
+			INREG( MEM_SDRAM_MODE_REG) | MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
 
-	OUTREG( MEM_REFRESH_CNTL, 	memRefreshCntl);
+		OUTREG(EXT_MEM_CNTL, memRefreshCntl);
+	}
+	/* And finally, the M7..M9 models, including M9+ (RV280) */
+	else if (rinfo->is_mobility) {
+
+		/* Disable refresh */
+		memRefreshCntl 	= INREG( MEM_REFRESH_CNTL)
+			& ~MEM_REFRESH_CNTL__MEM_REFRESH_DIS;
+		OUTREG( MEM_REFRESH_CNTL, memRefreshCntl
+			| MEM_REFRESH_CNTL__MEM_REFRESH_DIS);
+ 
+		/* Reset memory */
+		OUTREG( MEM_SDRAM_MODE_REG,
+			INREG( MEM_SDRAM_MODE_REG)
+			& ~MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
+
+		/* DLL */
+		radeon_pm_enable_dll(rinfo);
+
+		/* MLCK / YCLK sync */
+		radeon_pm_yclk_mclk_sync(rinfo);
+
+		/* M6, M7 and M9 so far ... */
+		if (rinfo->family <= CHIP_FAMILY_RV250) {
+			radeon_pm_program_mode_reg(rinfo, 0x2000, 1);   
+			radeon_pm_program_mode_reg(rinfo, 0x2001, 1);   
+			radeon_pm_program_mode_reg(rinfo, 0x2002, 1);   
+			radeon_pm_program_mode_reg(rinfo, 0x0132, 1);   
+			radeon_pm_program_mode_reg(rinfo, 0x0032, 1); 
+		}
+		/* M9+ (iBook G4) */
+		else if (rinfo->family == CHIP_FAMILY_RV280) {
+			radeon_pm_program_mode_reg(rinfo, 0x2000, 1);   
+			radeon_pm_program_mode_reg(rinfo, 0x0132, 1);   
+			radeon_pm_program_mode_reg(rinfo, 0x0032, 1); 
+		}
+
+		/* Complete & re-enable refresh */
+		OUTREG( MEM_SDRAM_MODE_REG,
+			INREG( MEM_SDRAM_MODE_REG) | MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
+
+		OUTREG( MEM_REFRESH_CNTL, 	memRefreshCntl);
+	}
 
 	OUTREG( CRTC_GEN_CNTL, 		crtcGenCntl);
 	OUTREG( CRTC2_GEN_CNTL, 	crtcGenCntl2);
@@ -777,10 +1336,1076 @@
 	mdelay( 15);
 }
 
+#ifdef CONFIG_PPC_OF
+
+static void radeon_pm_reset_pad_ctlr_strength(struct radeonfb_info *rinfo)
+{
+	u32 tmp, tmp2;
+	int i,j;
+
+	/* Reset the PAD_CTLR_STRENGTH & wait for it to be stable */
+	INREG(PAD_CTLR_STRENGTH);
+	OUTREG(PAD_CTLR_STRENGTH, INREG(PAD_CTLR_STRENGTH) & ~PAD_MANUAL_OVERRIDE);
+	tmp = INREG(PAD_CTLR_STRENGTH);
+	for (i = j = 0; i < 65; ++i) {
+		mdelay(1);
+		tmp2 = INREG(PAD_CTLR_STRENGTH);
+		if (tmp != tmp2) {
+			tmp = tmp2;
+			i = 0;
+			j++;
+			if (j > 10) {
+				printk(KERN_WARNING "radeon: PAD_CTLR_STRENGTH doesn't "
+				       "stabilize !\n");
+				break;
+			}
+		}
+	}
+}
+
+static void radeon_pm_all_ppls_off(struct radeonfb_info *rinfo)
+{
+	u32 tmp;
+
+	tmp = INPLL(pllPPLL_CNTL);
+	OUTPLL(pllPPLL_CNTL, tmp | 0x3);
+	tmp = INPLL(pllP2PLL_CNTL);
+	OUTPLL(pllP2PLL_CNTL, tmp | 0x3);
+	tmp = INPLL(pllSPLL_CNTL);
+	OUTPLL(pllSPLL_CNTL, tmp | 0x3);
+	tmp = INPLL(pllMPLL_CNTL);
+	OUTPLL(pllMPLL_CNTL, tmp | 0x3);
+}
+
+static void radeon_pm_start_mclk_sclk(struct radeonfb_info *rinfo)
+{
+	u32 tmp;
+
+	/* Switch SPLL to PCI source */
+	tmp = INPLL(pllSCLK_CNTL);
+	OUTPLL(pllSCLK_CNTL, tmp & ~SCLK_CNTL__SCLK_SRC_SEL_MASK);
+
+	/* Reconfigure SPLL charge pump, VCO gain, duty cycle */
+	tmp = INPLL(pllSPLL_CNTL);
+	OUTREG8(CLOCK_CNTL_INDEX, pllSPLL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+
+	/* Set SPLL feedback divider */
+	tmp = INPLL(pllM_SPLL_REF_FB_DIV);
+	tmp = (tmp & 0xff00fffful) | (rinfo->save_regs[77] & 0x00ff0000ul);
+	OUTPLL(pllM_SPLL_REF_FB_DIV, tmp);
+
+	/* Power up SPLL */
+	tmp = INPLL(pllSPLL_CNTL);
+	OUTPLL(pllSPLL_CNTL, tmp & ~1);
+	(void)INPLL(pllSPLL_CNTL);
+
+	mdelay(10);
+
+	/* Release SPLL reset */
+	tmp = INPLL(pllSPLL_CNTL);
+	OUTPLL(pllSPLL_CNTL, tmp & ~0x2);
+	(void)INPLL(pllSPLL_CNTL);
+
+	mdelay(10);
+
+	/* Select SCLK source  */
+	tmp = INPLL(pllSCLK_CNTL);
+	tmp &= ~SCLK_CNTL__SCLK_SRC_SEL_MASK;
+	tmp |= rinfo->save_regs[3] & SCLK_CNTL__SCLK_SRC_SEL_MASK;
+	OUTPLL(pllSCLK_CNTL, tmp);
+	(void)INPLL(pllSCLK_CNTL);
+
+	mdelay(10);
+
+	/* Reconfigure MPLL charge pump, VCO gain, duty cycle */
+	tmp = INPLL(pllMPLL_CNTL);
+	OUTREG8(CLOCK_CNTL_INDEX, pllMPLL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+
+	/* Set MPLL feedback divider */
+	tmp = INPLL(pllM_SPLL_REF_FB_DIV);
+	tmp = (tmp & 0xffff00fful) | (rinfo->save_regs[77] & 0x0000ff00ul);
+
+	OUTPLL(pllM_SPLL_REF_FB_DIV, tmp);
+	/* Power up MPLL */
+	tmp = INPLL(pllMPLL_CNTL);
+	OUTPLL(pllMPLL_CNTL, tmp & ~0x2);
+	(void)INPLL(pllMPLL_CNTL);
+
+	mdelay(10);
+     
+	/* Un-reset MPLL */
+	tmp = INPLL(pllMPLL_CNTL);
+	OUTPLL(pllMPLL_CNTL, tmp & ~0x1);
+	(void)INPLL(pllMPLL_CNTL);
+
+	mdelay(10);
+
+	/* Select source for MCLK */
+	tmp = INPLL(pllMCLK_CNTL);
+	tmp |= rinfo->save_regs[2] & 0xffff;
+	OUTPLL(pllMCLK_CNTL, tmp);
+	(void)INPLL(pllMCLK_CNTL);
+
+	mdelay(10);
+}
+
+static void radeon_pm_m10_disable_spread_spectrum(struct radeonfb_info *rinfo)
+{
+	u32 r2ec;
+
+	/* GACK ! I though we didn't have a DDA on Radeon's anymore 
+	 * here we rewrite with the same value, ... I suppose we clear
+	 * some bits that are already clear ? Or maybe this 0x2ec
+	 * register is something new ?
+	 */
+	mdelay(20);
+	r2ec = INREG(VGA_DDA_ON_OFF);
+	OUTREG(VGA_DDA_ON_OFF, r2ec);
+	mdelay(1);
+
+	/* Spread spectrum PLLL off */
+	OUTPLL(pllSSPLL_CNTL, 0xbf03);
+
+	/* Spread spectrum disabled */
+	OUTPLL(pllSS_INT_CNTL, rinfo->save_regs[90] & ~3);
+
+	/* The trace shows read & rewrite of LVDS_PLL_CNTL here with same
+	 * value, not sure what for...
+	 */
+
+	r2ec |= 0x3f0;
+	OUTREG(VGA_DDA_ON_OFF, r2ec);
+	mdelay(1);
+}
+
+static void radeon_pm_m10_enable_lvds_spread_spectrum(struct radeonfb_info *rinfo)
+{
+	u32 r2ec, tmp;
+
+	/* GACK (bis) ! I though we didn't have a DDA on Radeon's anymore 
+	 * here we rewrite with the same value, ... I suppose we clear/set
+	 * some bits that are already clear/set ?
+	 */
+	r2ec = INREG(VGA_DDA_ON_OFF);
+	OUTREG(VGA_DDA_ON_OFF, r2ec);
+	mdelay(1);
+
+	/* Enable spread spectrum */
+	OUTPLL(pllSSPLL_CNTL, rinfo->save_regs[43] | 3);
+	mdelay(3);
+
+	OUTPLL(pllSSPLL_REF_DIV, rinfo->save_regs[44]);
+	OUTPLL(pllSSPLL_DIV_0, rinfo->save_regs[45]);
+	tmp = INPLL(pllSSPLL_CNTL);
+	OUTPLL(pllSSPLL_CNTL, tmp & ~0x2);
+	mdelay(6);
+	tmp = INPLL(pllSSPLL_CNTL);
+	OUTPLL(pllSSPLL_CNTL, tmp & ~0x1);
+	mdelay(5);
+
+       	OUTPLL(pllSS_INT_CNTL, rinfo->save_regs[90]);
+
+	r2ec |= 8;
+	OUTREG(VGA_DDA_ON_OFF, r2ec);
+	mdelay(20);
+
+	/* Enable LVDS interface */
+	tmp = INREG(LVDS_GEN_CNTL);
+	OUTREG(LVDS_GEN_CNTL, tmp | LVDS_EN);
+
+	/* Enable LVDS_PLL */
+	tmp = INREG(LVDS_PLL_CNTL);
+	tmp &= ~0x30000;
+	tmp |= 0x10000;
+	OUTREG(LVDS_PLL_CNTL, tmp);
+
+	OUTPLL(pllSCLK_MORE_CNTL, rinfo->save_regs[34]);
+	OUTPLL(pllSS_TST_CNTL, rinfo->save_regs[91]);
+
+	/* The trace reads that one here, waiting for something to settle down ? */
+	INREG(RBBM_STATUS); 
+
+	/* Ugh ? SS_TST_DEC is supposed to be a read register in the
+	 * R300 register spec at least...
+	 */
+	tmp = INPLL(pllSS_TST_CNTL);
+	tmp |= 0x00400000;
+	OUTPLL(pllSS_TST_CNTL, tmp);
+}
+
+static void radeon_pm_restore_pixel_pll(struct radeonfb_info *rinfo)
+{
+	u32 tmp;
+
+	OUTREG8(CLOCK_CNTL_INDEX, pllHTOTAL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA, 0);
+
+	tmp = INPLL(pllVCLK_ECP_CNTL);
+	OUTPLL(pllVCLK_ECP_CNTL, tmp | 0x80);
+	mdelay(5);
+
+	tmp = INPLL(pllPPLL_REF_DIV);
+	tmp = (tmp & ~PPLL_REF_DIV_MASK) | rinfo->pll.ref_div;
+	OUTPLL(pllPPLL_REF_DIV, tmp);
+	INPLL(pllPPLL_REF_DIV);
+
+	/* Reconfigure SPLL charge pump, VCO gain, duty cycle,
+	 * probably useless since we already did it ...
+	 */
+	tmp = INPLL(pllPPLL_CNTL);
+	OUTREG8(CLOCK_CNTL_INDEX, pllSPLL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+
+	/* Not sure what was intended here ... */
+	tmp = INREG(CLOCK_CNTL_INDEX);
+	OUTREG(CLOCK_CNTL_INDEX, tmp);
+
+	/* Restore our "reference" PPLL divider set by firmware
+	 * according to proper spread spectrum calculations
+	 */
+	OUTPLL(pllPPLL_DIV_0, rinfo->save_regs[92]);
+
+	tmp = INPLL(pllPPLL_CNTL);
+	OUTPLL(pllPPLL_CNTL, tmp & ~0x2);
+	mdelay(5);
+
+	tmp = INPLL(pllPPLL_CNTL);
+	OUTPLL(pllPPLL_CNTL, tmp & ~0x1);
+	mdelay(5);
+
+	tmp = INPLL(pllVCLK_ECP_CNTL);
+	OUTPLL(pllVCLK_ECP_CNTL, tmp | 3);
+	mdelay(5);
+
+	tmp = INPLL(pllVCLK_ECP_CNTL);
+	OUTPLL(pllVCLK_ECP_CNTL, tmp | 3);
+	mdelay(5);
+
+	/* Switch pixel clock to firmware default div 0 */
+	OUTREG8(CLOCK_CNTL_INDEX+1, 0);
+}
+
+static void radeon_pm_m10_reconfigure_mc(struct radeonfb_info *rinfo)
+{
+	OUTREG(MC_CNTL, rinfo->save_regs[46]);
+	OUTREG(MC_INIT_GFX_LAT_TIMER, rinfo->save_regs[47]);
+	OUTREG(MC_INIT_MISC_LAT_TIMER, rinfo->save_regs[48]);
+	OUTREG(MEM_SDRAM_MODE_REG,
+	       rinfo->save_regs[35] & ~MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
+	OUTREG(MC_TIMING_CNTL, rinfo->save_regs[49]);
+	OUTREG(MEM_REFRESH_CNTL, rinfo->save_regs[42]);
+	OUTREG(MC_READ_CNTL_AB, rinfo->save_regs[50]);
+	OUTREG(MC_CHIP_IO_OE_CNTL_AB, rinfo->save_regs[52]);
+	OUTREG(MC_IOPAD_CNTL, rinfo->save_regs[51]);
+	OUTREG(MC_DEBUG, rinfo->save_regs[53]);
+
+	OUTMC(rinfo, ixR300_MC_MC_INIT_WR_LAT_TIMER, rinfo->save_regs[58]);
+	OUTMC(rinfo, ixR300_MC_IMP_CNTL, rinfo->save_regs[59]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_C0, rinfo->save_regs[60]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_C1, rinfo->save_regs[61]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_D0, rinfo->save_regs[62]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_D1, rinfo->save_regs[63]);
+	OUTMC(rinfo, ixR300_MC_BIST_CNTL_3, rinfo->save_regs[64]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_A0, rinfo->save_regs[65]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_A1, rinfo->save_regs[66]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_B0, rinfo->save_regs[67]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_B1, rinfo->save_regs[68]);
+	OUTMC(rinfo, ixR300_MC_DEBUG_CNTL, rinfo->save_regs[69]);
+	OUTMC(rinfo, ixR300_MC_DLL_CNTL, rinfo->save_regs[70]);
+	OUTMC(rinfo, ixR300_MC_IMP_CNTL_0, rinfo->save_regs[71]);
+	OUTMC(rinfo, ixR300_MC_ELPIDA_CNTL, rinfo->save_regs[72]);
+	OUTMC(rinfo, ixR300_MC_READ_CNTL_CD, rinfo->save_regs[96]);
+	OUTREG(MC_IND_INDEX, 0);
+}
+
+static void radeon_reinitialize_M10(struct radeonfb_info *rinfo)
+{
+	u32 tmp, i;
+
+	/* Restore a bunch of registers first */
+	OUTREG(MC_AGP_LOCATION, rinfo->save_regs[32]);
+	OUTREG(DISPLAY_BASE_ADDR, rinfo->save_regs[31]);
+	OUTREG(CRTC2_DISPLAY_BASE_ADDR, rinfo->save_regs[33]);
+	OUTREG(MC_FB_LOCATION, rinfo->save_regs[30]);
+	OUTREG(OV0_BASE_ADDR, rinfo->save_regs[80]);
+	OUTREG(CONFIG_MEMSIZE, rinfo->video_ram);
+	OUTREG(BUS_CNTL, rinfo->save_regs[36]);	
+	OUTREG(BUS_CNTL1, rinfo->save_regs[14]);
+	OUTREG(MPP_TB_CONFIG, rinfo->save_regs[37]);
+	OUTREG(FCP_CNTL, rinfo->save_regs[38]);
+	OUTREG(RBBM_CNTL, rinfo->save_regs[39]);
+	OUTREG(DAC_CNTL, rinfo->save_regs[40]);
+	OUTREG(DAC_MACRO_CNTL, (INREG(DAC_MACRO_CNTL) & ~0x6) | 8);
+	OUTREG(DAC_MACRO_CNTL, (INREG(DAC_MACRO_CNTL) & ~0x6) | 8);
+
+	/* Hrm... */
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) | DAC2_EXPAND_MODE);
+
+	/* Reset the PAD CTLR */
+	radeon_pm_reset_pad_ctlr_strength(rinfo);
+       
+	/* Some PLLs are Read & written identically in the trace here...
+	 * I suppose it's actually to switch them all off & reset,
+	 * let's assume off is what we want. I'm just doing that for all major PLLs now.
+	 */
+	radeon_pm_all_ppls_off(rinfo);
+
+	/* Clear tiling, reset swappers */
+	INREG(SURFACE_CNTL);
+	OUTREG(SURFACE_CNTL, 0);
+
+	/* Some black magic with TV_DAC_CNTL, we should restore those from backups
+	 * rather than hard coding...
+	 */
+	tmp = INREG(TV_DAC_CNTL) & ~TV_DAC_CNTL_BGADJ_MASK;
+	tmp |= 8 << TV_DAC_CNTL_BGADJ__SHIFT;
+	OUTREG(TV_DAC_CNTL, tmp);
+
+	tmp = INREG(TV_DAC_CNTL) & ~TV_DAC_CNTL_DACADJ_MASK;
+	tmp |= 7 << TV_DAC_CNTL_DACADJ__SHIFT;
+	OUTREG(TV_DAC_CNTL, tmp);
+
+	/* More registers restored */
+	OUTREG(AGP_CNTL, rinfo->save_regs[16]);
+	OUTREG(HOST_PATH_CNTL, rinfo->save_regs[41]);
+	OUTREG(DISP_MISC_CNTL, rinfo->save_regs[9]);
+
+	/* Hrmmm ... What is that ? */
+	tmp = rinfo->save_regs[1]
+		& ~(CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT_MASK |
+		    CLK_PWRMGT_CNTL__MC_BUSY);
+	OUTPLL(pllCLK_PWRMGT_CNTL, tmp);
+
+	OUTREG(PAD_CTLR_MISC, rinfo->save_regs[56]);
+	OUTREG(FW_CNTL, rinfo->save_regs[57]);
+	OUTREG(HDP_DEBUG, rinfo->save_regs[96]);
+	OUTREG(PAMAC0_DLY_CNTL, rinfo->save_regs[54]);
+	OUTREG(PAMAC1_DLY_CNTL, rinfo->save_regs[55]);
+	OUTREG(PAMAC2_DLY_CNTL, rinfo->save_regs[79]);
+
+	/* Restore Memory Controller configuration */
+	radeon_pm_m10_reconfigure_mc(rinfo);
+
+	/* Make sure CRTC's dont touch memory */
+	OUTREG(CRTC_GEN_CNTL, INREG(CRTC_GEN_CNTL) 
+	       | CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B);
+	OUTREG(CRTC2_GEN_CNTL, INREG(CRTC2_GEN_CNTL)
+	       | CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B);
+	mdelay(30);
+      
+	/* Disable SDRAM refresh */
+	OUTREG(MEM_REFRESH_CNTL, INREG(MEM_REFRESH_CNTL)
+	       | MEM_REFRESH_CNTL__MEM_REFRESH_DIS);
+
+	/* Restore XTALIN routing (CLK_PIN_CNTL) */
+	OUTPLL(pllCLK_PIN_CNTL, rinfo->save_regs[4]);
+
+	/* Switch MCLK, YCLK and SCLK PLLs to PCI source & force them ON */
+	tmp = rinfo->save_regs[2] & 0xff000000;
+	tmp |=	MCLK_CNTL__FORCE_MCLKA |
+		MCLK_CNTL__FORCE_MCLKB |
+		MCLK_CNTL__FORCE_YCLKA |
+		MCLK_CNTL__FORCE_YCLKB |
+		MCLK_CNTL__FORCE_MC;
+	OUTPLL(pllMCLK_CNTL, tmp);
+
+	/* Force all clocks on in SCLK */
+	tmp = INPLL(pllSCLK_CNTL);
+	tmp |=	SCLK_CNTL__FORCE_DISP2|
+		SCLK_CNTL__FORCE_CP|
+		SCLK_CNTL__FORCE_HDP|
+		SCLK_CNTL__FORCE_DISP1|
+		SCLK_CNTL__FORCE_TOP|
+		SCLK_CNTL__FORCE_E2|
+		SCLK_CNTL__FORCE_SE|
+		SCLK_CNTL__FORCE_IDCT|
+		SCLK_CNTL__FORCE_VIP|
+		SCLK_CNTL__FORCE_PB|
+		SCLK_CNTL__FORCE_TAM|
+		SCLK_CNTL__FORCE_TDM|
+		SCLK_CNTL__FORCE_RB|
+		SCLK_CNTL__FORCE_TV_SCLK|
+		SCLK_CNTL__FORCE_SUBPIC|
+		SCLK_CNTL__FORCE_OV0;
+	tmp |=	SCLK_CNTL__CP_MAX_DYN_STOP_LAT  |
+		SCLK_CNTL__HDP_MAX_DYN_STOP_LAT |
+		SCLK_CNTL__TV_MAX_DYN_STOP_LAT  |
+		SCLK_CNTL__E2_MAX_DYN_STOP_LAT  |
+		SCLK_CNTL__SE_MAX_DYN_STOP_LAT  |
+		SCLK_CNTL__IDCT_MAX_DYN_STOP_LAT|
+		SCLK_CNTL__VIP_MAX_DYN_STOP_LAT |
+		SCLK_CNTL__RE_MAX_DYN_STOP_LAT  |
+		SCLK_CNTL__PB_MAX_DYN_STOP_LAT  |
+		SCLK_CNTL__TAM_MAX_DYN_STOP_LAT |
+		SCLK_CNTL__TDM_MAX_DYN_STOP_LAT |
+		SCLK_CNTL__RB_MAX_DYN_STOP_LAT;
+	OUTPLL(pllSCLK_CNTL, tmp);
+
+	OUTPLL(pllVCLK_ECP_CNTL, 0);
+	OUTPLL(pllPIXCLKS_CNTL, 0);
+	OUTPLL(pllMCLK_MISC,
+	       MCLK_MISC__MC_MCLK_MAX_DYN_STOP_LAT |
+	       MCLK_MISC__IO_MCLK_MAX_DYN_STOP_LAT);
+
+	mdelay(5);
+
+	/* Restore the M_SPLL_REF_FB_DIV, MPLL_AUX_CNTL and SPLL_AUX_CNTL values */
+	OUTPLL(pllM_SPLL_REF_FB_DIV, rinfo->save_regs[77]);
+	OUTPLL(pllMPLL_AUX_CNTL, rinfo->save_regs[75]);
+	OUTPLL(pllSPLL_AUX_CNTL, rinfo->save_regs[76]);
+	
+	/* Now restore the major PLLs settings, keeping them off & reset though */
+	OUTPLL(pllPPLL_CNTL, rinfo->save_regs[93] | 0x3);
+	OUTPLL(pllP2PLL_CNTL, rinfo->save_regs[8] | 0x3);
+	OUTPLL(pllMPLL_CNTL, rinfo->save_regs[73] | 0x03);
+	OUTPLL(pllSPLL_CNTL, rinfo->save_regs[74] | 0x03);
+
+	/* Restore MC DLL state and switch it off/reset too  */ 
+	OUTMC(rinfo, ixR300_MC_DLL_CNTL, rinfo->save_regs[70]);
+
+	/* Switch MDLL off & reset */
+	OUTPLL(pllMDLL_RDCKA, rinfo->save_regs[98] | 0xff);
+	mdelay(5);
+
+	/* Setup some black magic bits in PLL_PWRMGT_CNTL. Hrm... we saved
+	 * 0xa1100007... and MacOS writes 0xa1000007 ..
+	 */
+	OUTPLL(pllPLL_PWRMGT_CNTL, rinfo->save_regs[0]);
+
+	/* Restore more stuffs */
+	OUTPLL(pllHTOTAL_CNTL, 0);
+	OUTPLL(pllHTOTAL2_CNTL, 0);
+
+	/* More PLL initial configuration */
+	tmp = INPLL(pllSCLK_CNTL2); /* What for ? */
+	OUTPLL(pllSCLK_CNTL2, tmp);
+
+	tmp = INPLL(pllSCLK_MORE_CNTL);
+	tmp |= 	SCLK_MORE_CNTL__FORCE_DISPREGS |	/* a guess */
+		SCLK_MORE_CNTL__FORCE_MC_GUI |
+		SCLK_MORE_CNTL__FORCE_MC_HOST;
+	OUTPLL(pllSCLK_MORE_CNTL, tmp);
+
+	/* Now we actually start MCLK and SCLK */
+	radeon_pm_start_mclk_sclk(rinfo);
+
+	/* Full reset sdrams, this also re-inits the MDLL */
+	radeon_pm_full_reset_sdram(rinfo);
+
+	/* Fill palettes */
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) | 0x20);	
+	for (i=0; i<256; i++)
+		OUTREG(PALETTE_30_DATA, 0x15555555);
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) & ~20);
+	udelay(20);
+	for (i=0; i<256; i++)
+		OUTREG(PALETTE_30_DATA, 0x15555555);
+
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) & ~0x20);
+	mdelay(3);
+
+	/* Restore TMDS */
+	OUTREG(FP_GEN_CNTL, rinfo->save_regs[82]);
+	OUTREG(FP2_GEN_CNTL, rinfo->save_regs[83]);
+
+	/* Set LVDS registers but keep interface & pll down */
+	OUTREG(LVDS_GEN_CNTL, rinfo->save_regs[11] &
+	       ~(LVDS_EN | LVDS_ON | LVDS_DIGON | LVDS_BLON | LVDS_BL_MOD_EN));
+	OUTREG(LVDS_PLL_CNTL, (rinfo->save_regs[12] & ~0xf0000) | 0x20000);
+
+	OUTREG(DISP_OUTPUT_CNTL, rinfo->save_regs[86]);
+
+	/* Restore GPIOPAD state */
+	OUTREG(GPIOPAD_A, rinfo->save_regs[19]);
+	OUTREG(GPIOPAD_EN, rinfo->save_regs[20]);
+	OUTREG(GPIOPAD_MASK, rinfo->save_regs[21]);
+
+	/* write some stuff to the framebuffer... */
+	for (i = 0; i < 0x8000; ++i)
+		writeb(0, rinfo->fb_base + i);
+	
+	mdelay(40);
+	OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) | LVDS_DIGON | LVDS_ON);
+	mdelay(40);
+
+	/* Restore a few more things */
+	OUTREG(GRPH_BUFFER_CNTL, rinfo->save_regs[94]);
+	OUTREG(GRPH2_BUFFER_CNTL, rinfo->save_regs[95]);
+
+	/* Take care of spread spectrum & PPLLs now */
+	radeon_pm_m10_disable_spread_spectrum(rinfo);
+	radeon_pm_restore_pixel_pll(rinfo);
+
+	/* GRRRR... I can't figure out the proper LVDS power sequence, and the
+	 * code I have for blank/unblank doesn't quite work on some laptop models
+	 * it seems ... Hrm. What I have here works most of the time ...
+	 */
+	radeon_pm_m10_enable_lvds_spread_spectrum(rinfo);
+}
+
+static void radeon_pm_m9p_reconfigure_mc(struct radeonfb_info *rinfo)
+{
+	OUTREG(MC_CNTL, rinfo->save_regs[46]);
+	OUTREG(MC_INIT_GFX_LAT_TIMER, rinfo->save_regs[47]);
+	OUTREG(MC_INIT_MISC_LAT_TIMER, rinfo->save_regs[48]);
+	OUTREG(MEM_SDRAM_MODE_REG,
+	       rinfo->save_regs[35] & ~MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
+	OUTREG(MC_TIMING_CNTL, rinfo->save_regs[49]);
+	OUTREG(MC_READ_CNTL_AB, rinfo->save_regs[50]);
+	OUTREG(MEM_REFRESH_CNTL, rinfo->save_regs[42]);
+	OUTREG(MC_IOPAD_CNTL, rinfo->save_regs[51]);
+	OUTREG(MC_DEBUG, rinfo->save_regs[53]);
+	OUTREG(MC_CHIP_IO_OE_CNTL_AB, rinfo->save_regs[52]);
+
+	OUTMC(rinfo, ixMC_IMP_CNTL, rinfo->save_regs[59] /*0x00f460d6*/);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_A0, rinfo->save_regs[65] /*0xfecfa666*/);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_A1, rinfo->save_regs[66] /*0x141555ff*/);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_B0, rinfo->save_regs[67] /*0xfecfa666*/);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_B1, rinfo->save_regs[68] /*0x141555ff*/);
+	OUTMC(rinfo, ixMC_IMP_CNTL_0, rinfo->save_regs[71] /*0x00009249*/);
+	OUTREG(MC_IND_INDEX, 0);
+	OUTREG(CONFIG_MEMSIZE, rinfo->video_ram);
+
+	mdelay(20);
+}
+
+static void radeon_reinitialize_M9P(struct radeonfb_info *rinfo)
+{
+	u32 tmp, i;
+	
+	/* Restore a bunch of registers first */
+	OUTREG(SURFACE_CNTL, rinfo->save_regs[29]);
+	OUTREG(MC_AGP_LOCATION, rinfo->save_regs[32]);
+	OUTREG(DISPLAY_BASE_ADDR, rinfo->save_regs[31]);
+	OUTREG(CRTC2_DISPLAY_BASE_ADDR, rinfo->save_regs[33]);
+	OUTREG(MC_FB_LOCATION, rinfo->save_regs[30]);
+	OUTREG(OV0_BASE_ADDR, rinfo->save_regs[80]);
+	OUTREG(BUS_CNTL, rinfo->save_regs[36]);
+	OUTREG(BUS_CNTL1, rinfo->save_regs[14]);
+	OUTREG(MPP_TB_CONFIG, rinfo->save_regs[37]);
+	OUTREG(FCP_CNTL, rinfo->save_regs[38]);
+	OUTREG(RBBM_CNTL, rinfo->save_regs[39]);
+
+	OUTREG(DAC_CNTL, rinfo->save_regs[40]);
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) | DAC2_EXPAND_MODE);
+
+	/* Reset the PAD CTLR */
+	radeon_pm_reset_pad_ctlr_strength(rinfo);
+
+	/* Some PLLs are Read & written identically in the trace here...
+	 * I suppose it's actually to switch them all off & reset,
+	 * let's assume off is what we want. I'm just doing that for all major PLLs now.
+	 */
+	radeon_pm_all_ppls_off(rinfo);
+
+	/* Clear tiling, reset swappers */
+	INREG(SURFACE_CNTL);
+	OUTREG(SURFACE_CNTL, 0);
+
+	/* Some black magic with TV_DAC_CNTL, we should restore those from backups
+	 * rather than hard coding...
+	 */
+	tmp = INREG(TV_DAC_CNTL) & ~TV_DAC_CNTL_BGADJ_MASK;
+	tmp |= 6 << TV_DAC_CNTL_BGADJ__SHIFT;
+	OUTREG(TV_DAC_CNTL, tmp);
+
+	tmp = INREG(TV_DAC_CNTL) & ~TV_DAC_CNTL_DACADJ_MASK;
+	tmp |= 6 << TV_DAC_CNTL_DACADJ__SHIFT;
+	OUTREG(TV_DAC_CNTL, tmp);
+	
+	OUTPLL(pllAGP_PLL_CNTL, rinfo->save_regs[78]);
+
+	OUTREG(PAMAC0_DLY_CNTL, rinfo->save_regs[54]);
+	OUTREG(PAMAC1_DLY_CNTL, rinfo->save_regs[55]);
+	OUTREG(PAMAC2_DLY_CNTL, rinfo->save_regs[79]);
+
+	OUTREG(AGP_CNTL, rinfo->save_regs[16]);
+	OUTREG(HOST_PATH_CNTL, rinfo->save_regs[41]); /* MacOS sets that to 0 !!! */
+	OUTREG(DISP_MISC_CNTL, rinfo->save_regs[9]);
+
+	tmp  = rinfo->save_regs[1]
+		& ~(CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT_MASK |
+		    CLK_PWRMGT_CNTL__MC_BUSY);
+	OUTPLL(pllCLK_PWRMGT_CNTL, tmp);
+
+	OUTREG(FW_CNTL, rinfo->save_regs[57]);
+
+	/* Disable SDRAM refresh */
+	OUTREG(MEM_REFRESH_CNTL, INREG(MEM_REFRESH_CNTL)
+	       | MEM_REFRESH_CNTL__MEM_REFRESH_DIS);
+
+	/* Restore XTALIN routing (CLK_PIN_CNTL) */
+       	OUTPLL(pllCLK_PIN_CNTL, rinfo->save_regs[4]);
+
+	/* Force MCLK to be PCI sourced and forced ON */
+	tmp = rinfo->save_regs[2] & 0xff000000;
+	tmp |=	MCLK_CNTL__FORCE_MCLKA |
+		MCLK_CNTL__FORCE_MCLKB |
+		MCLK_CNTL__FORCE_YCLKA |
+		MCLK_CNTL__FORCE_YCLKB |
+		MCLK_CNTL__FORCE_MC    |
+		MCLK_CNTL__FORCE_AIC;
+	OUTPLL(pllMCLK_CNTL, tmp);
+
+	/* Force SCLK to be PCI sourced with a bunch forced */
+	tmp =	0 |
+		SCLK_CNTL__FORCE_DISP2|
+		SCLK_CNTL__FORCE_CP|
+		SCLK_CNTL__FORCE_HDP|
+		SCLK_CNTL__FORCE_DISP1|
+		SCLK_CNTL__FORCE_TOP|
+		SCLK_CNTL__FORCE_E2|
+		SCLK_CNTL__FORCE_SE|
+		SCLK_CNTL__FORCE_IDCT|
+		SCLK_CNTL__FORCE_VIP|
+		SCLK_CNTL__FORCE_RE|
+		SCLK_CNTL__FORCE_PB|
+		SCLK_CNTL__FORCE_TAM|
+		SCLK_CNTL__FORCE_TDM|
+		SCLK_CNTL__FORCE_RB;
+	OUTPLL(pllSCLK_CNTL, tmp);
+
+	/* Clear VCLK_ECP_CNTL & PIXCLKS_CNTL  */
+	OUTPLL(pllVCLK_ECP_CNTL, 0);
+	OUTPLL(pllPIXCLKS_CNTL, 0);
+
+	/* Setup MCLK_MISC, non dynamic mode */
+	OUTPLL(pllMCLK_MISC,
+	       MCLK_MISC__MC_MCLK_MAX_DYN_STOP_LAT |
+	       MCLK_MISC__IO_MCLK_MAX_DYN_STOP_LAT);
+
+	mdelay(5);
+
+	/* Set back the default clock dividers */
+	OUTPLL(pllM_SPLL_REF_FB_DIV, rinfo->save_regs[77]);
+	OUTPLL(pllMPLL_AUX_CNTL, rinfo->save_regs[75]);
+	OUTPLL(pllSPLL_AUX_CNTL, rinfo->save_regs[76]);
+
+	/* PPLL and P2PLL default values & off */
+	OUTPLL(pllPPLL_CNTL, rinfo->save_regs[93] | 0x3);
+	OUTPLL(pllP2PLL_CNTL, rinfo->save_regs[8] | 0x3);
+
+	/* S and M PLLs are reset & off, configure them */
+	OUTPLL(pllMPLL_CNTL, rinfo->save_regs[73] | 0x03);
+	OUTPLL(pllSPLL_CNTL, rinfo->save_regs[74] | 0x03);
+
+	/* Default values for MDLL ... fixme */
+	OUTPLL(pllMDLL_CKO, 0x9c009c);
+	OUTPLL(pllMDLL_RDCKA, 0x08830883);
+	OUTPLL(pllMDLL_RDCKB, 0x08830883);
+	mdelay(5);
+
+	/* Restore PLL_PWRMGT_CNTL */ // XXXX
+	tmp = rinfo->save_regs[0];
+	tmp &= ~PLL_PWRMGT_CNTL_SU_SCLK_USE_BCLK;
+	tmp |= PLL_PWRMGT_CNTL_SU_MCLK_USE_BCLK;
+	OUTPLL(PLL_PWRMGT_CNTL,  tmp);
+	
+	/* Clear HTOTAL_CNTL & HTOTAL2_CNTL */
+	OUTPLL(pllHTOTAL_CNTL, 0);
+	OUTPLL(pllHTOTAL2_CNTL, 0);
+
+	/* All outputs off */
+	OUTREG(CRTC_GEN_CNTL, 0x04000000);
+	OUTREG(CRTC2_GEN_CNTL, 0x04000000);
+	OUTREG(FP_GEN_CNTL, 0x00004008);
+	OUTREG(FP2_GEN_CNTL, 0x00000008);
+	OUTREG(LVDS_GEN_CNTL, 0x08000008);
+
+	/* Restore Memory Controller configuration */
+	radeon_pm_m9p_reconfigure_mc(rinfo);
+
+	/* Now we actually start MCLK and SCLK */
+	radeon_pm_start_mclk_sclk(rinfo);
+
+	/* Full reset sdrams, this also re-inits the MDLL */
+	radeon_pm_full_reset_sdram(rinfo);
+
+	/* Fill palettes */
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) | 0x20);	
+	for (i=0; i<256; i++)
+		OUTREG(PALETTE_30_DATA, 0x15555555);
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) & ~20);
+	udelay(20);
+	for (i=0; i<256; i++)
+		OUTREG(PALETTE_30_DATA, 0x15555555);
+
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) & ~0x20);
+	mdelay(3);
+
+	/* Restore TV stuff, make sure TV DAC is down */
+	OUTREG(TV_MASTER_CNTL, rinfo->save_regs[88]);
+	OUTREG(TV_DAC_CNTL, rinfo->save_regs[13] | 0x07000000);
+
+	/* Restore GPIOS. MacOS does some magic here with one of the GPIO bits,
+	 * possibly related to the weird PLL related workarounds and to the
+	 * fact that CLK_PIN_CNTL is tweaked in ways I don't fully understand,
+	 * but we keep things the simple way here
+	 */
+	OUTREG(GPIOPAD_A, rinfo->save_regs[19]);
+	OUTREG(GPIOPAD_EN, rinfo->save_regs[20]);
+	OUTREG(GPIOPAD_MASK, rinfo->save_regs[21]);
+
+	/* Now do things with SCLK_MORE_CNTL. Force bits are already set, copy
+	 * high bits from backup
+	 */
+	tmp = INPLL(pllSCLK_MORE_CNTL) & 0x0000ffff;
+	tmp |= rinfo->save_regs[34] & 0xffff0000;
+	tmp |= SCLK_MORE_CNTL__FORCE_DISPREGS;
+	OUTPLL(pllSCLK_MORE_CNTL, tmp);
+
+	tmp = INPLL(pllSCLK_MORE_CNTL) & 0x0000ffff;
+	tmp |= rinfo->save_regs[34] & 0xffff0000;
+	tmp |= SCLK_MORE_CNTL__FORCE_DISPREGS;
+	OUTPLL(pllSCLK_MORE_CNTL, tmp);
+	
+	OUTREG(LVDS_GEN_CNTL, rinfo->save_regs[11] &
+	       ~(LVDS_EN | LVDS_ON | LVDS_DIGON | LVDS_BLON | LVDS_BL_MOD_EN));
+	OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) | LVDS_BLON);
+	OUTREG(LVDS_PLL_CNTL, (rinfo->save_regs[12] & ~0xf0000) | 0x20000);
+	mdelay(20);
+
+	/* write some stuff to the framebuffer... */
+	for (i = 0; i < 0x8000; ++i)
+		writeb(0, rinfo->fb_base + i);
+		
+	OUTREG(0x2ec, 0x6332a020);
+	OUTPLL(pllSSPLL_REF_DIV, rinfo->save_regs[44] /*0x3f */);
+	OUTPLL(pllSSPLL_DIV_0, rinfo->save_regs[45] /*0x000081bb */);
+	tmp = INPLL(pllSSPLL_CNTL);
+	tmp &= ~2;
+	OUTPLL(pllSSPLL_CNTL, tmp);
+	mdelay(6);
+	tmp &= ~1;
+	OUTPLL(pllSSPLL_CNTL, tmp);
+	mdelay(5);
+	tmp |= 3;
+	OUTPLL(pllSSPLL_CNTL, tmp);
+	mdelay(5);
+	
+	OUTPLL(pllSS_INT_CNTL, rinfo->save_regs[90] & ~3);/*0x0020300c*/
+	OUTREG(0x2ec, 0x6332a3f0);
+	mdelay(17);
+
+	OUTPLL(pllPPLL_REF_DIV, rinfo->pll.ref_div);;
+	OUTPLL(pllPPLL_DIV_0, rinfo->save_regs[92]);
+	
+	mdelay(40);
+	OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) | LVDS_DIGON | LVDS_ON);
+	mdelay(40);
+
+	/* Restore a few more things */
+	OUTREG(GRPH_BUFFER_CNTL, rinfo->save_regs[94]);
+	OUTREG(GRPH2_BUFFER_CNTL, rinfo->save_regs[95]);
+
+	/* Restore PPLL, spread spectrum & LVDS */
+	radeon_pm_m10_disable_spread_spectrum(rinfo);
+	radeon_pm_restore_pixel_pll(rinfo);
+	radeon_pm_m10_enable_lvds_spread_spectrum(rinfo);
+}
+
+#if 0 /* Not ready yet */
+static void radeon_reinitialize_QW(struct radeonfb_info *rinfo)
+{
+	int i;
+	u32 tmp, tmp2;
+	u32 cko, cka, ckb;
+	u32 cgc, cec, c2gc;
+
+	OUTREG(MC_AGP_LOCATION, rinfo->save_regs[32]);
+	OUTREG(DISPLAY_BASE_ADDR, rinfo->save_regs[31]);
+	OUTREG(CRTC2_DISPLAY_BASE_ADDR, rinfo->save_regs[33]);
+	OUTREG(MC_FB_LOCATION, rinfo->save_regs[30]);
+	OUTREG(BUS_CNTL, rinfo->save_regs[36]);
+	OUTREG(RBBM_CNTL, rinfo->save_regs[39]);
+
+	INREG(PAD_CTLR_STRENGTH);
+	OUTREG(PAD_CTLR_STRENGTH, INREG(PAD_CTLR_STRENGTH) & ~0x10000);
+	for (i = 0; i < 65; ++i) {
+		mdelay(1);
+		INREG(PAD_CTLR_STRENGTH);
+	}
+
+	OUTREG(DISP_TEST_DEBUG_CNTL, INREG(DISP_TEST_DEBUG_CNTL) | 0x10000000);
+	OUTREG(OV0_FLAG_CNTRL, INREG(OV0_FLAG_CNTRL) | 0x100);
+	OUTREG(CRTC_GEN_CNTL, INREG(CRTC_GEN_CNTL));
+	OUTREG(DAC_CNTL, 0xff00410a);
+	OUTREG(CRTC2_GEN_CNTL, INREG(CRTC2_GEN_CNTL));
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) | 0x4000);
+
+	OUTREG(SURFACE_CNTL, rinfo->save_regs[29]);
+	OUTREG(AGP_CNTL, rinfo->save_regs[16]);
+	OUTREG(HOST_PATH_CNTL, rinfo->save_regs[41]);
+	OUTREG(DISP_MISC_CNTL, rinfo->save_regs[9]);
+
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_A0, 0xf7bb4433);
+	OUTREG(MC_IND_INDEX, 0);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_B0, 0xf7bb4433);
+	OUTREG(MC_IND_INDEX, 0);
+
+	OUTREG(CRTC_MORE_CNTL, INREG(CRTC_MORE_CNTL));
+
+	tmp = INPLL(pllVCLK_ECP_CNTL);
+	OUTPLL(pllVCLK_ECP_CNTL, tmp);
+	tmp = INPLL(pllPIXCLKS_CNTL);
+	OUTPLL(pllPIXCLKS_CNTL, tmp);
+
+	OUTPLL(MCLK_CNTL, 0xaa3f0000);
+	OUTPLL(SCLK_CNTL, 0xffff0000);
+	OUTPLL(pllMPLL_AUX_CNTL, 6);
+	OUTPLL(pllSPLL_AUX_CNTL, 1);
+	OUTPLL(MDLL_CKO, 0x9f009f);
+	OUTPLL(MDLL_RDCKA, 0x830083);
+	OUTPLL(pllMDLL_RDCKB, 0x830083);
+	OUTPLL(PPLL_CNTL, 0xa433);
+	OUTPLL(P2PLL_CNTL, 0xa433);
+	OUTPLL(MPLL_CNTL, 0x0400a403);
+	OUTPLL(SPLL_CNTL, 0x0400a433);
+
+	tmp = INPLL(M_SPLL_REF_FB_DIV);
+	OUTPLL(M_SPLL_REF_FB_DIV, tmp);
+	tmp = INPLL(M_SPLL_REF_FB_DIV);
+	OUTPLL(M_SPLL_REF_FB_DIV, tmp | 0xc);
+	INPLL(M_SPLL_REF_FB_DIV);
+
+	tmp = INPLL(MPLL_CNTL);
+	OUTREG8(CLOCK_CNTL_INDEX, MPLL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+
+	tmp = INPLL(M_SPLL_REF_FB_DIV);
+	OUTPLL(M_SPLL_REF_FB_DIV, tmp | 0x5900);
+
+	tmp = INPLL(MPLL_CNTL);
+	OUTPLL(MPLL_CNTL, tmp & ~0x2);
+	mdelay(1);
+	tmp = INPLL(MPLL_CNTL);
+	OUTPLL(MPLL_CNTL, tmp & ~0x1);
+	mdelay(10);
+
+	OUTPLL(MCLK_CNTL, 0xaa3f1212);
+	mdelay(1);
+
+	INPLL(M_SPLL_REF_FB_DIV);
+	INPLL(MCLK_CNTL);
+	INPLL(M_SPLL_REF_FB_DIV);
+
+	tmp = INPLL(SPLL_CNTL);
+	OUTREG8(CLOCK_CNTL_INDEX, SPLL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+
+	tmp = INPLL(M_SPLL_REF_FB_DIV);
+	OUTPLL(M_SPLL_REF_FB_DIV, tmp | 0x780000);
+
+	tmp = INPLL(SPLL_CNTL);
+	OUTPLL(SPLL_CNTL, tmp & ~0x1);
+	mdelay(1);
+	tmp = INPLL(SPLL_CNTL);
+	OUTPLL(SPLL_CNTL, tmp & ~0x2);
+	mdelay(10);
+
+	tmp = INPLL(SCLK_CNTL);
+	OUTPLL(SCLK_CNTL, tmp | 2);
+	mdelay(1);
+
+	cko = INPLL(pllMDLL_CKO);
+	cka = INPLL(pllMDLL_RDCKA);
+	ckb = INPLL(pllMDLL_RDCKB);
+
+	cko &= ~(MDLL_CKO__MCKOA_SLEEP | MDLL_CKO__MCKOB_SLEEP);
+	OUTPLL(pllMDLL_CKO, cko);
+	mdelay(1);
+	cko &= ~(MDLL_CKO__MCKOA_RESET | MDLL_CKO__MCKOB_RESET);
+	OUTPLL(pllMDLL_CKO, cko);
+	mdelay(5);
+
+	cka &= ~(MDLL_RDCKA__MRDCKA0_SLEEP | MDLL_RDCKA__MRDCKA1_SLEEP);
+	OUTPLL(pllMDLL_RDCKA, cka);
+	mdelay(1);
+	cka &= ~(MDLL_RDCKA__MRDCKA0_RESET | MDLL_RDCKA__MRDCKA1_RESET);
+	OUTPLL(pllMDLL_RDCKA, cka);
+	mdelay(5);
+
+	ckb &= ~(MDLL_RDCKB__MRDCKB0_SLEEP | MDLL_RDCKB__MRDCKB1_SLEEP);
+	OUTPLL(pllMDLL_RDCKB, ckb);
+	mdelay(1);
+	ckb &= ~(MDLL_RDCKB__MRDCKB0_RESET | MDLL_RDCKB__MRDCKB1_RESET);
+	OUTPLL(pllMDLL_RDCKB, ckb);
+	mdelay(5);
+
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_A1, 0x151550ff);
+	OUTREG(MC_IND_INDEX, 0);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_B1, 0x151550ff);
+	OUTREG(MC_IND_INDEX, 0);
+	mdelay(1);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_A1, 0x141550ff);
+	OUTREG(MC_IND_INDEX, 0);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_B1, 0x141550ff);
+	OUTREG(MC_IND_INDEX, 0);
+	mdelay(1);
+
+	OUTPLL(pllHTOTAL_CNTL, 0);
+	OUTPLL(pllHTOTAL2_CNTL, 0);
+
+	OUTREG(MEM_CNTL, 0x29002901);
+	OUTREG(MEM_SDRAM_MODE_REG, 0x45320032);	/* XXX use save_regs[35]? */
+	OUTREG(EXT_MEM_CNTL, 0x1a394333);
+	OUTREG(MEM_IO_CNTL_A1, 0x0aac0aac);
+	OUTREG(MEM_INIT_LATENCY_TIMER, 0x34444444);
+	OUTREG(MEM_REFRESH_CNTL, 0x1f1f7218);	/* XXX or save_regs[42]? */
+	OUTREG(MC_DEBUG, 0);
+	OUTREG(MEM_IO_OE_CNTL, 0x04300430);
+
+	OUTMC(rinfo, ixMC_IMP_CNTL, 0x00f460d6);
+	OUTREG(MC_IND_INDEX, 0);
+	OUTMC(rinfo, ixMC_IMP_CNTL_0, 0x00009249);
+	OUTREG(MC_IND_INDEX, 0);
+
+	OUTREG(CONFIG_MEMSIZE, rinfo->video_ram);
+
+	radeon_pm_full_reset_sdram(rinfo);
+
+	INREG(FP_GEN_CNTL);
+	OUTREG(TMDS_CNTL, 0x01000000);	/* XXX ? */
+	tmp = INREG(FP_GEN_CNTL);
+	tmp |= FP_CRTC_DONT_SHADOW_HEND | FP_CRTC_DONT_SHADOW_VPAR | 0x200;
+	OUTREG(FP_GEN_CNTL, tmp);
+
+	tmp = INREG(DISP_OUTPUT_CNTL);
+	tmp &= ~0x400;
+	OUTREG(DISP_OUTPUT_CNTL, tmp);
+
+	OUTPLL(CLK_PIN_CNTL, rinfo->save_regs[4]);
+	OUTPLL(CLK_PWRMGT_CNTL, rinfo->save_regs[1]);
+	OUTPLL(PLL_PWRMGT_CNTL, rinfo->save_regs[0]);
+
+	tmp = INPLL(MCLK_MISC);
+	tmp |= MCLK_MISC__MC_MCLK_DYN_ENABLE | MCLK_MISC__IO_MCLK_DYN_ENABLE;
+	OUTPLL(MCLK_MISC, tmp);
+
+	tmp = INPLL(SCLK_CNTL);
+	OUTPLL(SCLK_CNTL, tmp);
+
+	OUTREG(CRTC_MORE_CNTL, 0);
+	OUTREG8(CRTC_GEN_CNTL+1, 6);
+	OUTREG8(CRTC_GEN_CNTL+3, 1);
+	OUTREG(CRTC_PITCH, 32);
+
+	tmp = INPLL(VCLK_ECP_CNTL);
+	OUTPLL(VCLK_ECP_CNTL, tmp);
+
+	tmp = INPLL(PPLL_CNTL);
+	OUTPLL(PPLL_CNTL, tmp);
+
+	/* palette stuff and BIOS_1_SCRATCH... */
+
+	tmp = INREG(FP_GEN_CNTL);
+	tmp2 = INREG(TMDS_TRANSMITTER_CNTL);
+	tmp |= 2;
+	OUTREG(FP_GEN_CNTL, tmp);
+	mdelay(5);
+	OUTREG(FP_GEN_CNTL, tmp);
+	mdelay(5);
+	OUTREG(TMDS_TRANSMITTER_CNTL, tmp2);
+	OUTREG(CRTC_MORE_CNTL, 0);
+	mdelay(20);
+
+	tmp = INREG(CRTC_MORE_CNTL);
+	OUTREG(CRTC_MORE_CNTL, tmp);
+
+	cgc = INREG(CRTC_GEN_CNTL);
+	cec = INREG(CRTC_EXT_CNTL);
+	c2gc = INREG(CRTC2_GEN_CNTL);
+
+	OUTREG(CRTC_H_SYNC_STRT_WID, 0x008e0580);
+	OUTREG(CRTC_H_TOTAL_DISP, 0x009f00d2);
+	OUTREG8(CLOCK_CNTL_INDEX, HTOTAL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA, 0);
+	OUTREG(CRTC_V_SYNC_STRT_WID, 0x00830403);
+	OUTREG(CRTC_V_TOTAL_DISP, 0x03ff0429);
+	OUTREG(FP_CRTC_H_TOTAL_DISP, 0x009f0033);
+	OUTREG(FP_H_SYNC_STRT_WID, 0x008e0080);
+	OUTREG(CRT_CRTC_H_SYNC_STRT_WID, 0x008e0080);
+	OUTREG(FP_CRTC_V_TOTAL_DISP, 0x03ff002a);
+	OUTREG(FP_V_SYNC_STRT_WID, 0x00830004);
+	OUTREG(CRT_CRTC_V_SYNC_STRT_WID, 0x00830004);
+	OUTREG(FP_HORZ_VERT_ACTIVE, 0x009f03ff);
+	OUTREG(FP_HORZ_STRETCH, 0);
+	OUTREG(FP_VERT_STRETCH, 0);
+	OUTREG(OVR_CLR, 0);
+	OUTREG(OVR_WID_LEFT_RIGHT, 0);
+	OUTREG(OVR_WID_TOP_BOTTOM, 0);
+
+	tmp = INPLL(PPLL_REF_DIV);
+	tmp = (tmp & ~PPLL_REF_DIV_MASK) | rinfo->pll.ref_div;
+	OUTPLL(PPLL_REF_DIV, tmp);
+	INPLL(PPLL_REF_DIV);
+
+	OUTREG8(CLOCK_CNTL_INDEX, PPLL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA + 1, 0xbc);
+
+	tmp = INREG(CLOCK_CNTL_INDEX);
+	OUTREG(CLOCK_CNTL_INDEX, tmp & 0xff);
+
+	OUTPLL(PPLL_DIV_0, 0x48090);
+
+	tmp = INPLL(PPLL_CNTL);
+	OUTPLL(PPLL_CNTL, tmp & ~0x2);
+	mdelay(1);
+	tmp = INPLL(PPLL_CNTL);
+	OUTPLL(PPLL_CNTL, tmp & ~0x1);
+	mdelay(10);
+
+	tmp = INPLL(VCLK_ECP_CNTL);
+	OUTPLL(VCLK_ECP_CNTL, tmp | 3);
+	mdelay(1);
+
+	tmp = INPLL(VCLK_ECP_CNTL);
+	OUTPLL(VCLK_ECP_CNTL, tmp);
+
+	c2gc |= CRTC2_DISP_REQ_EN_B;
+	OUTREG(CRTC2_GEN_CNTL, c2gc);
+	cgc |= CRTC_EN;
+	OUTREG(CRTC_GEN_CNTL, cgc);
+	OUTREG(CRTC_EXT_CNTL, cec);
+	OUTREG(CRTC_PITCH, 0xa0);
+	OUTREG(CRTC_OFFSET, 0);
+	OUTREG(CRTC_OFFSET_CNTL, 0);
+
+	OUTREG(GRPH_BUFFER_CNTL, 0x20117c7c);
+	OUTREG(GRPH2_BUFFER_CNTL, 0x00205c5c);
+
+	tmp2 = INREG(FP_GEN_CNTL);
+	tmp = INREG(TMDS_TRANSMITTER_CNTL);
+	OUTREG(0x2a8, 0x0000061b);
+	tmp |= TMDS_PLL_EN;
+	OUTREG(TMDS_TRANSMITTER_CNTL, tmp);
+	mdelay(1);
+	tmp &= ~TMDS_PLLRST;
+	OUTREG(TMDS_TRANSMITTER_CNTL, tmp);
+	tmp2 &= ~2;
+	tmp2 |= FP_TMDS_EN;
+	OUTREG(FP_GEN_CNTL, tmp2);
+	mdelay(5);
+	tmp2 |= FP_FPON;
+	OUTREG(FP_GEN_CNTL, tmp2);
+
+	OUTREG(CUR_HORZ_VERT_OFF, CUR_LOCK | 1);
+	cgc = INREG(CRTC_GEN_CNTL);
+	OUTREG(CUR_HORZ_VERT_POSN, 0xbfff0fff);
+	cgc |= 0x10000;
+	OUTREG(CUR_OFFSET, 0);
+}
+#endif /* 0 */
+
+#endif /* CONFIG_PPC_OF */
+
 static void radeon_set_suspend(struct radeonfb_info *rinfo, int suspend)
 {
 	u16 pwr_cmd;
 	u32 tmp;
+	int i;
 
 	if (!rinfo->pm_reg)
 		return;
@@ -796,13 +2421,13 @@
 		 * duration of the suspend/resume process
 		 */
 		radeon_pm_disable_dynamic_mode(rinfo);
+
 		/* Save some registers */
-		radeon_pm_save_regs(rinfo);
+		radeon_pm_save_regs(rinfo, 0);
 
-		/* Prepare mobility chips for suspend. Only do that on <= RV250 chips that
-		 * have been tested
+		/* Prepare mobility chips for suspend.
 		 */
-		if (rinfo->is_mobility && rinfo->family <= CHIP_FAMILY_RV250) {
+		if (rinfo->is_mobility) {
 			/* Program V2CLK */
 			radeon_pm_program_v2clk(rinfo);
 		
@@ -815,13 +2440,22 @@
 			/* Prepare chip for power management */
 			radeon_pm_setup_for_suspend(rinfo);
 
-			/* Reset the MDLL */
-			/* because both INPLL and OUTPLL take the same lock, that's why. */
-			tmp = INPLL( pllMDLL_CKO) | MDLL_CKO__MCKOA_RESET | MDLL_CKO__MCKOB_RESET;
-			OUTPLL( pllMDLL_CKO, tmp );
+			if (rinfo->family <= CHIP_FAMILY_RV280) {
+				/* Reset the MDLL */
+				/* because both INPLL and OUTPLL take the same
+				 * lock, that's why. */
+				tmp = INPLL( pllMDLL_CKO) | MDLL_CKO__MCKOA_RESET
+					| MDLL_CKO__MCKOB_RESET;
+				OUTPLL( pllMDLL_CKO, tmp );
+			}
 		}
 
+		for (i = 0; i < 64; ++i)
+			pci_read_config_dword(rinfo->pdev, i * 4,
+					      &rinfo->cfg_save[i]);
+
 		/* Switch PCI power managment to D2. */
+		pci_disable_device(rinfo->pdev);
 		for (;;) {
 			pci_read_config_word(
 				rinfo->pdev, rinfo->pm_reg+PCI_PM_CTRL,
@@ -841,37 +2475,73 @@
 		pci_write_config_word(rinfo->pdev, rinfo->pm_reg+PCI_PM_CTRL, 0);
 		mdelay(500);
 
-		/* Reset the SDRAM controller  */
-       		radeon_pm_full_reset_sdram(rinfo);
-		
-		/* Restore some registers */
-		radeon_pm_restore_regs(rinfo);
-		radeon_pm_enable_dynamic_mode(rinfo);
+		if (rinfo->family <= CHIP_FAMILY_RV250) {
+			/* Reset the SDRAM controller  */
+			radeon_pm_full_reset_sdram(rinfo);
+
+			/* Restore some registers */
+			radeon_pm_restore_regs(rinfo);
+		} else {
+			/* Restore registers first */
+			radeon_pm_restore_regs(rinfo);
+			/* init sdram controller */
+			radeon_pm_full_reset_sdram(rinfo);
+		}
 	}
 }
 
+static int radeon_restore_pci_cfg(struct radeonfb_info *rinfo)
+{
+	int i;
+	static u32 radeon_cfg_after_resume[64];
+
+	for (i = 0; i < 64; ++i)
+		pci_read_config_dword(rinfo->pdev, i * 4,
+				      &radeon_cfg_after_resume[i]);
+
+	if (radeon_cfg_after_resume[PCI_BASE_ADDRESS_0/4]
+	    == rinfo->cfg_save[PCI_BASE_ADDRESS_0/4])
+		return 0;	/* assume everything is ok */
+
+	for (i = PCI_BASE_ADDRESS_0/4; i < 64; ++i) {
+		if (radeon_cfg_after_resume[i] != rinfo->cfg_save[i])
+			pci_write_config_dword(rinfo->pdev, i * 4,
+					       rinfo->cfg_save[i]);
+	}
+	pci_write_config_word(rinfo->pdev, PCI_CACHE_LINE_SIZE,
+			      rinfo->cfg_save[PCI_CACHE_LINE_SIZE/4]);
+	pci_write_config_word(rinfo->pdev, PCI_COMMAND,
+			      rinfo->cfg_save[PCI_COMMAND/4]);
+	return 1;
+}
+
+
+static/*extern*/ int susdisking = 0;
+
 int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state)
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
+	int i;
 
-	/* We don't do anything but D2, for now we return 0, but
-	 * we may want to change that. How do we know if the BIOS
-	 * can properly take care of D3 ? Also, with swsusp, we
-	 * know we'll be rebooted, ...
-	 */
+	if (state == pdev->dev.power.power_state)
+		return 0;
 
 	printk(KERN_DEBUG "radeonfb: suspending to state: %d...\n", state);
-	
-	acquire_console_sem();
 
-	/* Userland should do this but doesn't... bridge gets suspended
-	 * too late. Unfortunately, that works only when AGP is built-in,
-	 * not for a module.
+	/* For suspend-to-disk, we cheat here. We don't suspend anything and
+	 * let fbcon continue drawing until we are all set. That shouldn't
+	 * really cause any problem at this point, provided that the wakeup
+	 * code knows that any state in memory may not match the HW
 	 */
-#ifdef CONFIG_AGP
-	agp_enable(0);
-#endif
+	if (state != PM_SUSPEND_MEM)
+		goto done;
+	if (susdisking) {
+		printk("suspending to disk but state = %d\n", state);
+		goto done;
+	}
+
+	acquire_console_sem();
 
 	fb_set_suspend(info, 1);
 
@@ -883,21 +2553,52 @@
 	}
 
 	/* Blank display and LCD */
-	radeonfb_blank(VESA_POWERDOWN, info);
+	radeon_screen_blank(rinfo, FB_BLANK_POWERDOWN, 1);
 
 	/* Sleep */
 	rinfo->asleep = 1;
 	rinfo->lock_blank = 1;
+	del_timer_sync(&rinfo->lvds_timer);
 
-	/* Suspend the chip to D2 state when supported
+	/* If we support wakeup from poweroff, we save all regs we can including cfg
+	 * space
 	 */
-#ifdef CONFIG_RADEON_HAS_D2
-	if (radeon_suspend_to_d2(rinfo, state))
+	if (rinfo->pm_mode & radeon_pm_off) {
+		/* Always disable dynamic clocks or weird things are happening when
+		 * the chip goes off (basically the panel doesn't shut down properly
+		 * and we crash on wakeup),
+		 * also, we want the saved regs context to have no dynamic clocks in
+		 * it, we'll restore the dynamic clocks state on wakeup
+		 */
+		radeon_pm_disable_dynamic_mode(rinfo);
+		mdelay(50);
+		radeon_pm_save_regs(rinfo, 1);
+
+		if (rinfo->is_mobility && !(rinfo->pm_mode & radeon_pm_d2)) {
+			/* Switch off LVDS interface */
+			mdelay(1);
+			OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) & ~(LVDS_BL_MOD_EN));
+			mdelay(1);
+			OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) & ~(LVDS_EN | LVDS_ON));
+			OUTREG(LVDS_PLL_CNTL, (INREG(LVDS_PLL_CNTL) & ~30000) | 0x20000);
+			mdelay(20);
+			OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) & ~(LVDS_DIGON));
+
+			// FIXME: Use PCI layer
+			for (i = 0; i < 64; ++i)
+				pci_read_config_dword(rinfo->pdev, i * 4,
+						      &rinfo->cfg_save[i]);
+		}
+	}
+	/* If we support D2, we go to it (should be fixed later with a flag forcing
+	 * D3 only for some laptops)
+	 */
+	if (rinfo->pm_mode & radeon_pm_d2)
 		radeon_set_suspend(rinfo, 1);
-#endif /* CONFIG_RADEON_HAS_D2 */
 
 	release_console_sem();
 
+ done:
 	pdev->dev.power.power_state = state;
 
 	return 0;
@@ -907,22 +2608,63 @@
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
+	int rc = 0;
 
 	if (pdev->dev.power.power_state == 0)
 		return 0;
 
-	acquire_console_sem();
+	if (rinfo->no_schedule) {
+		if (try_acquire_console_sem())
+			return 0;
+	} else
+		acquire_console_sem();
+
+	printk(KERN_DEBUG "radeonfb (%s): resuming from state: %d...\n",
+	       pci_name(pdev), pdev->dev.power.power_state);
+
 
-	/* Wakeup chip */
-#ifdef CONFIG_RADEON_HAS_D2
-	if (radeon_suspend_to_d2(rinfo, 0))
-		radeon_set_suspend(rinfo, 0);
-#endif /* CONFIG_RADEON_HAS_D2 */
+	if (pci_enable_device(pdev)) {
+		rc = -ENODEV;
+		printk(KERN_ERR "radeonfb (%s): can't enable PCI device !\n",
+		       pci_name(pdev));
+		goto bail;
+	}
+	pci_set_master(pdev);
+
+	if (susdisking) {
+		printk("dev power state = %d\n", pdev->dev.power.power_state);
+		radeon_engine_idle();
+		printk("engine_idle done\n");
+	} else if (pdev->dev.power.power_state == PM_SUSPEND_MEM) {
+		/* Wakeup chip. Check from config space if we were powered off
+		 * (todo: additionally, check CLK_PIN_CNTL too)
+		 */
+		if ((rinfo->pm_mode & radeon_pm_off) && radeon_restore_pci_cfg(rinfo)) {
+			if (rinfo->reinit_func != NULL)
+				rinfo->reinit_func(rinfo);
+			else {
+				printk(KERN_ERR "radeonfb (%s): can't resume radeon from"
+				       " D3 cold, need softboot !", pci_name(pdev));
+				rc = -EIO;
+				goto bail;
+			}
+		}
+		/* If we support D2, try to resume... we should check what was our
+		 * state though... (were we really in D2 state ?). Right now, this code
+		 * is only enable on Macs so it's fine.
+		 */
+		else if (rinfo->pm_mode & radeon_pm_d2)
+			radeon_set_suspend(rinfo, 0);
 
-	rinfo->asleep = 0;
+		rinfo->asleep = 0;
+	} else
+		radeon_engine_idle();
 
 	/* Restore display & engine */
-	radeonfb_set_par(info);
+	radeon_write_mode (rinfo, &rinfo->state, 1);
+	if (!(info->flags & FBINFO_HWACCEL_DISABLED))
+		radeonfb_engine_init (rinfo);
+
 	fb_pan_display(info, &info->var);
 	fb_set_cmap(&info->cmap, info);
 
@@ -931,15 +2673,104 @@
 
 	/* Unblank */
 	rinfo->lock_blank = 0;
-	radeonfb_blank(0, info);
 
-	release_console_sem();
+	/* Check status of dynclk */
+	if (rinfo->dynclk)
+		radeon_pm_enable_dynamic_mode(rinfo);
+	else
+		radeon_pm_disable_dynamic_mode(rinfo);
 
 	pdev->dev.power.power_state = 0;
+ bail:
+	release_console_sem();
+
+	return rc;
+}
 
-	printk(KERN_DEBUG "radeonfb: resumed !\n");
+#ifdef CONFIG_PPC_OF
+static void radeonfb_early_resume(void *data)
+{
+        struct radeonfb_info *rinfo = data;
 
-	return 0;
+	rinfo->no_schedule = 1;
+	radeonfb_pci_resume(rinfo->pdev);
+	rinfo->no_schedule = 0;
+#endif /* CONFIG_PPC_OF */
 }
 
 #endif /* CONFIG_PM */
+
+void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk)
+{
+	/* Find PM registers in config space if any*/
+	rinfo->pm_reg = pci_find_capability(rinfo->pdev, PCI_CAP_ID_PM);
+
+	/* Enable/Disable dynamic clocks: TODO add sysfs access */
+	if (dynclk) {
+		rinfo->dynclk = 1;
+		radeon_pm_enable_dynamic_mode(rinfo);
+		printk("radeonfb: Dynamic Clock Power Management enabled\n");
+	} else {
+		rinfo->dynclk = 0;
+		radeon_pm_disable_dynamic_mode(rinfo);
+		printk("radeonfb: Dynamic Clock Power Management disabled\n");
+	}
+
+	/* Check if we can power manage on suspend/resume. We can do
+	 * D2 on M6, M7 and M9, and we can resume from D3 cold a few other
+	 * "Mac" cards, but that's all. We need more infos about what the
+	 * BIOS does tho. Right now, all this PM stuff is pmac-only for that
+	 * reason. --BenH
+	 */
+#if defined(CONFIG_PM) && defined(CONFIG_PPC_OF)
+	if (_machine == _MACH_Pmac && rinfo->of_node) {
+		if (rinfo->is_mobility && rinfo->pm_reg &&
+		    rinfo->family <= CHIP_FAMILY_RV250)
+			rinfo->pm_mode |= radeon_pm_d2;
+
+		/* We can restart Jasper (M10 chip in albooks), BlueStone (7500 chip
+		 * in some desktop G4s), and Via (M9+ chip on iBook G4)
+		 */
+		if (!strcmp(rinfo->of_node->name, "ATY,JasperParent")) {
+			rinfo->reinit_func = radeon_reinitialize_M10;
+			rinfo->pm_mode |= radeon_pm_off;
+		}
+#if 0 /* Not ready yet */
+		if (!strcmp(rinfo->of_node->name, "ATY,BlueStoneParent")) {
+			rinfo->reinit_func = radeon_reinitialize_QW;
+			rinfo->pm_mode |= radeon_pm_off;
+		}
+#endif
+		if (!strcmp(rinfo->of_node->name, "ATY,ViaParent")) {
+			rinfo->reinit_func = radeon_reinitialize_M9P;
+			rinfo->pm_mode |= radeon_pm_off;
+			/* Workaround not used for now */
+			rinfo->m9p_workaround = 1;
+		}
+
+		/* If any of the above is set, we assume the machine can sleep/resume.
+		 * It's a bit of a "shortcut" but will work fine. Ideally, we need infos
+		 * from the platform about what happens to the chip...
+		 * Now we tell the platform about our capability
+		 */
+		if (rinfo->pm_mode != radeon_pm_none) {
+			pmac_call_feature(PMAC_FTR_DEVICE_CAN_WAKE, rinfo->of_node, 0, 1);
+			pmac_set_early_video_resume(radeonfb_early_resume, rinfo);
+		}
+
+		/* Power down TV DAC, taht saves a significant amount of power,
+		 * we'll have something better once we actually have some TVOut
+		 * support
+		 */
+		OUTREG(TV_DAC_CNTL, INREG(TV_DAC_CNTL) | 0x07000000);
+	}
+#endif /* defined(CONFIG_PM) && defined(CONFIG_PPC_OF) */
+}
+
+void radeonfb_pm_exit(struct radeonfb_info *rinfo)
+{
+#if defined(CONFIG_PM) && defined(CONFIG_PPC_OF)
+	if (rinfo->pm_mode != radeon_pm_none)
+		pmac_set_early_video_resume(NULL, NULL);
+#endif
+}
diff -uNr linus-2.6.10/include/asm-ppc/pmac_feature.h sleep-2.6.10/include/asm-ppc/pmac_feature.h
--- linus-2.6.10/include/asm-ppc/pmac_feature.h	2005-01-06 10:48:55.266183064 +0000
+++ sleep-2.6.10/include/asm-ppc/pmac_feature.h	2005-01-06 11:39:29.963258392 +0000
@@ -125,6 +125,7 @@
 #define PMAC_MB_HAS_FW_POWER		0x00000002
 #define PMAC_MB_OLD_CORE99		0x00000004
 #define PMAC_MB_MOBILE			0x00000008
+#define PMAC_MB_MAY_SLEEP		0x00000010
 
 /*
  * Feature calls supported on pmac
@@ -238,7 +239,10 @@
 
 /* PMAC_FTR_SLEEP_STATE		(struct device_node* node, 0, int value)
  * set the sleep state of the motherboard.
+ * 
  * Pass -1 as value to query for sleep capability
+ * Pass 1 to set IOs to sleep
+ * Pass 0 to set IOs to wake
  */
 #define PMAC_FTR_SLEEP_STATE		PMAC_FTR_DEF(15)
 
@@ -279,11 +283,22 @@
  */
 #define PMAC_FTR_AACK_DELAY_ENABLE     	PMAC_FTR_DEF(20)
 
+/* PMAC_FTR_DEVICE_CAN_WAKE
+ *
+ * Used by video drivers to inform system that they can actually perform
+ * wakeup from sleep
+ */
+#define PMAC_FTR_DEVICE_CAN_WAKE	PMAC_FTR_DEF(22)
+
 
 /* Don't use those directly, they are for the sake of pmac_setup.c */
 extern long pmac_do_feature_call(unsigned int selector, ...);
 extern void pmac_feature_init(void);
 
+/* Video suspend tweak */
+extern void pmac_set_early_video_resume(void (*proc)(void *data), void *data);
+extern void pmac_call_early_video_resume(void);
+
 #define PMAC_FTR_DEF(x) ((_MACH_Pmac << 16) | (x))
 
 
diff -uNr linus-2.6.10/include/asm-ppc/reg.h sleep-2.6.10/include/asm-ppc/reg.h
--- linus-2.6.10/include/asm-ppc/reg.h	2005-01-06 10:48:27.108204888 +0000
+++ sleep-2.6.10/include/asm-ppc/reg.h	2005-01-06 11:39:14.903285536 +0000
@@ -244,6 +244,10 @@
 #define L2CR_L2DF		0x00004000	/* L2 differential clock */
 #define L2CR_L2BYP		0x00002000	/* L2 DLL bypass */
 #define L2CR_L2IP		0x00000001	/* L2 GI in progress */
+#define L2CR_L2IO_745x		0x00100000	/* L2 instr. only (745x) */
+#define L2CR_L2DO_745x		0x00010000	/* L2 data only (745x) */
+#define L2CR_L2REP_745x		0x00001000	/* L2 repl. algorithm (745x) */
+#define L2CR_L2HWF_745x		0x00000800	/* L2 hardware flush (745x) */
 #define SPRN_L3CR		0x3FA	/* Level 3 Cache Control Regsiter */
 #define L3CR_L3E		0x80000000	/* L3 enable */
 #define L3CR_L3PE		0x40000000	/* L3 data parity enable */
diff -uNr linus-2.6.10/include/asm-ppc/system.h sleep-2.6.10/include/asm-ppc/system.h
--- linus-2.6.10/include/asm-ppc/system.h	2005-01-06 10:47:44.322191648 +0000
+++ sleep-2.6.10/include/asm-ppc/system.h	2005-01-06 11:38:56.644266080 +0000
@@ -74,6 +74,7 @@
 extern void pmac_find_display(void);
 extern void giveup_fpu(struct task_struct *);
 extern void enable_kernel_fp(void);
+extern void enable_kernel_altivec(void);
 extern void giveup_altivec(struct task_struct *);
 extern void load_up_altivec(struct task_struct *);
 extern void giveup_spe(struct task_struct *);
diff -uNr linus-2.6.10/include/asm-ppc/uninorth.h sleep-2.6.10/include/asm-ppc/uninorth.h
--- linus-2.6.10/include/asm-ppc/uninorth.h	2005-01-06 10:48:30.124277912 +0000
+++ sleep-2.6.10/include/asm-ppc/uninorth.h	2005-01-06 11:39:18.473274352 +0000
@@ -148,6 +148,55 @@
 #define UNI_N_AACK_DELAY		0x0100
 #define UNI_N_AACK_DELAY_ENABLE		0x00000001
 
+/* Clock status for Intrepid */
+#define UNI_N_CLOCK_STOP_STATUS0	0x0150
+#define UNI_N_CLOCK_STOPPED_EXTAGP	0x00200000
+#define UNI_N_CLOCK_STOPPED_AGPDEL	0x00100000
+#define UNI_N_CLOCK_STOPPED_I2S0_45_49	0x00080000
+#define UNI_N_CLOCK_STOPPED_I2S0_18	0x00040000
+#define UNI_N_CLOCK_STOPPED_I2S1_45_49	0x00020000
+#define UNI_N_CLOCK_STOPPED_I2S1_18	0x00010000
+#define UNI_N_CLOCK_STOPPED_TIMER	0x00008000
+#define UNI_N_CLOCK_STOPPED_SCC_RTCLK18	0x00004000
+#define UNI_N_CLOCK_STOPPED_SCC_RTCLK32	0x00002000
+#define UNI_N_CLOCK_STOPPED_SCC_VIA32	0x00001000
+#define UNI_N_CLOCK_STOPPED_SCC_SLOT0	0x00000800
+#define UNI_N_CLOCK_STOPPED_SCC_SLOT1	0x00000400
+#define UNI_N_CLOCK_STOPPED_SCC_SLOT2	0x00000200
+#define UNI_N_CLOCK_STOPPED_PCI_FBCLKO	0x00000100
+#define UNI_N_CLOCK_STOPPED_VEO0	0x00000080
+#define UNI_N_CLOCK_STOPPED_VEO1	0x00000040
+#define UNI_N_CLOCK_STOPPED_USB0	0x00000020
+#define UNI_N_CLOCK_STOPPED_USB1	0x00000010
+#define UNI_N_CLOCK_STOPPED_USB2	0x00000008
+#define UNI_N_CLOCK_STOPPED_32		0x00000004
+#define UNI_N_CLOCK_STOPPED_45		0x00000002
+#define UNI_N_CLOCK_STOPPED_49		0x00000001
+
+#define UNI_N_CLOCK_STOP_STATUS1	0x0160
+#define UNI_N_CLOCK_STOPPED_PLL4REF	0x00080000
+#define UNI_N_CLOCK_STOPPED_CPUDEL	0x00040000
+#define UNI_N_CLOCK_STOPPED_CPU		0x00020000
+#define UNI_N_CLOCK_STOPPED_BUF_REFCKO	0x00010000
+#define UNI_N_CLOCK_STOPPED_PCI2	0x00008000
+#define UNI_N_CLOCK_STOPPED_FW		0x00004000
+#define UNI_N_CLOCK_STOPPED_GB		0x00002000
+#define UNI_N_CLOCK_STOPPED_ATA66	0x00001000
+#define UNI_N_CLOCK_STOPPED_ATA100	0x00000800
+#define UNI_N_CLOCK_STOPPED_MAX		0x00000400
+#define UNI_N_CLOCK_STOPPED_PCI1	0x00000200
+#define UNI_N_CLOCK_STOPPED_KLPCI	0x00000100
+#define UNI_N_CLOCK_STOPPED_USB0PCI	0x00000080
+#define UNI_N_CLOCK_STOPPED_USB1PCI	0x00000040
+#define UNI_N_CLOCK_STOPPED_USB2PCI	0x00000020
+#define UNI_N_CLOCK_STOPPED_7PCI1	0x00000008
+#define UNI_N_CLOCK_STOPPED_AGP		0x00000004
+#define UNI_N_CLOCK_STOPPED_PCI0	0x00000002
+#define UNI_N_CLOCK_STOPPED_18		0x00000001
+
+/* Intrepid registe to OF do-platform-clockspreading */
+#define UNI_N_CLOCK_SPREADING		0x190
+
 /* Uninorth 1.5 rev. has additional perf. monitor registers at 0xf00-0xf50 */
 
 
diff -uNr linus-2.6.10/include/linux/console.h sleep-2.6.10/include/linux/console.h
--- linus-2.6.10/include/linux/console.h	2005-01-06 10:47:44.474295696 +0000
+++ sleep-2.6.10/include/linux/console.h	2005-01-06 11:38:56.693258632 +0000
@@ -105,6 +105,7 @@
 extern int unregister_console(struct console *);
 extern struct console *console_drivers;
 extern void acquire_console_sem(void);
+extern int try_acquire_console_sem(void);
 extern void release_console_sem(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
diff -uNr linus-2.6.10/include/video/radeon.h sleep-2.6.10/include/video/radeon.h
--- linus-2.6.10/include/video/radeon.h	2005-01-06 10:48:48.933217768 +0000
+++ sleep-2.6.10/include/video/radeon.h	2005-01-06 11:39:26.490258680 +0000
@@ -21,6 +21,7 @@
 #define PAD_AGPINPUT_DELAY                     0x0164  
 #define PAD_CTLR_STRENGTH                      0x0168  
 #define PAD_CTLR_UPDATE                        0x016C
+#define PAD_CTLR_MISC                          0x0aa0
 #define AGP_CNTL                               0x0174
 #define BM_STATUS                              0x0160
 #define CAP0_TRIG_CNTL			       0x0950
@@ -68,18 +69,26 @@
 #define DAC_CNTL2                              0x007c
 #define CRTC_GEN_CNTL                          0x0050  
 #define MEM_CNTL                               0x0140  
+#define MC_CNTL                                0x0140  
 #define EXT_MEM_CNTL                           0x0144  
+#define MC_TIMING_CNTL                         0x0144  
 #define MC_AGP_LOCATION                        0x014C  
 #define MEM_IO_CNTL_A0                         0x0178  
+#define MEM_REFRESH_CNTL                       0x0178
 #define MEM_INIT_LATENCY_TIMER                 0x0154  
+#define MC_INIT_GFX_LAT_TIMER                  0x0154  
 #define MEM_SDRAM_MODE_REG                     0x0158  
 #define AGP_BASE                               0x0170  
 #define MEM_IO_CNTL_A1                         0x017C  
+#define MC_READ_CNTL_AB                        0x017C  
 #define MEM_IO_CNTL_B0                         0x0180
+#define MC_INIT_MISC_LAT_TIMER                 0x0180
 #define MEM_IO_CNTL_B1                         0x0184
+#define MC_IOPAD_CNTL                          0x0184
 #define MC_DEBUG                               0x0188
 #define MC_STATUS                              0x0150  
 #define MEM_IO_OE_CNTL                         0x018C  
+#define MC_CHIP_IO_OE_CNTL_AB                  0x018C  
 #define MC_FB_LOCATION                         0x0148  
 #define HOST_PATH_CNTL                         0x0130  
 #define MEM_VGA_WP_SEL                         0x0038  
@@ -385,6 +394,13 @@
 #define TMDS_CRC			       0x02a0
 #define TMDS_TRANSMITTER_CNTL		       0x02a4
 #define MPP_TB_CONFIG            	       0x01c0
+#define PAMAC0_DLY_CNTL                        0x0a94
+#define PAMAC1_DLY_CNTL                        0x0a98
+#define PAMAC2_DLY_CNTL                        0x0a9c
+#define FW_CNTL                                0x0118
+#define FCP_CNTL                               0x0910
+#define VGA_DDA_ON_OFF                         0x02ec
+#define TV_MASTER_CNTL                         0x0800
 
 //#define BASE_CODE			       0x0f0b
 #define BIOS_0_SCRATCH			       0x0010
@@ -418,7 +434,7 @@
 #define PPLL_DIV_3                                 0x0007
 #define VCLK_ECP_CNTL                              0x0008
 #define HTOTAL_CNTL                                0x0009
-#define X_MPLL_REF_FB_DIV                          0x000a
+#define M_SPLL_REF_FB_DIV                          0x000a
 #define AGP_PLL_CNTL                               0x000b
 #define SPLL_CNTL                                  0x000c
 #define SCLK_CNTL                                  0x000d
@@ -497,6 +513,8 @@
 #define CFG_VGA_RAM_EN                             0x00000100
 #define CFG_ATI_REV_ID_MASK			   (0xf << 16)
 #define CFG_ATI_REV_A11				   (0 << 16)
+#define CFG_ATI_REV_A12				   (1 << 16)
+#define CFG_ATI_REV_A13				   (2 << 16)
 
 /* CRTC_EXT_CNTL bit constants */
 #define VGA_ATI_LINEAR                             0x00000008
@@ -573,9 +591,17 @@
 /* FP_GEN_CNTL bit constants */
 #define FP_FPON					   (1 << 0)
 #define FP_TMDS_EN				   (1 << 2)
+#define FP_PANEL_FORMAT                            (1 << 3)
 #define FP_EN_TMDS				   (1 << 7)
 #define FP_DETECT_SENSE				   (1 << 8)
+#define R200_FP_SOURCE_SEL_MASK                    (3 << 10)
+#define R200_FP_SOURCE_SEL_CRTC1                   (0 << 10)
+#define R200_FP_SOURCE_SEL_CRTC2                   (1 << 10)
+#define R200_FP_SOURCE_SEL_RMX                     (2 << 10)
+#define R200_FP_SOURCE_SEL_TRANS                   (3 << 10)
+#define FP_SEL_CRTC1				   (0 << 13)
 #define FP_SEL_CRTC2				   (1 << 13)
+#define FP_USE_VGA_HSYNC                           (1 << 14)
 #define FP_CRTC_DONT_SHADOW_HPAR		   (1 << 15)
 #define FP_CRTC_DONT_SHADOW_VPAR		   (1 << 16)
 #define FP_CRTC_DONT_SHADOW_HEND		   (1 << 17)
@@ -671,6 +697,7 @@
 #define DAC_CMP_OUTPUT                             (1 <<  7)
 
 /* DAC_CNTL2 bit constants */   
+#define DAC2_EXPAND_MODE			   (1 << 14)
 #define DAC2_CMP_EN                                (1 << 7)
 #define DAC2_PALETTE_ACCESS_CNTL                   (1 << 5)
 
@@ -697,6 +724,11 @@
 #define MEM_ARBITER_STATUS_BUSY                    0x00400000
 #define MEM_REQ_UNLOCK                             0x00000000
 #define MEM_REQ_LOCK                               0x00800000
+#define MEM_NUM_CHANNELS_MASK 			   0x00000001
+#define MEM_USE_B_CH_ONLY                          0x00000002
+#define RV100_MEM_HALF_MODE                        0x00000008
+#define R300_MEM_NUM_CHANNELS_MASK                 0x00000003
+#define R300_MEM_USE_CD_CH_ONLY                    0x00000004
 
 
 /* RBBM_SOFT_RESET bit constants */
@@ -963,9 +995,11 @@
 
 #define MC_IND_INDEX                           0x01F8
 #define MC_IND_DATA                            0x01FC
-#define MEM_REFRESH_CNTL                       0x0178
 
-// CLK_PIN_CNTL
+/* PAD_CTLR_STRENGTH */
+#define PAD_MANUAL_OVERRIDE		0x80000000
+
+// pllCLK_PIN_CNTL
 #define CLK_PIN_CNTL__OSC_EN_MASK                          0x00000001L
 #define CLK_PIN_CNTL__OSC_EN                               0x00000001L
 #define CLK_PIN_CNTL__XTL_LOW_GAIN_MASK                    0x00000004L
@@ -991,32 +1025,32 @@
 #define CLK_PIN_CNTL__XTALIN_ALWAYS_ONb                    0x00080000L
 #define CLK_PIN_CNTL__PWRSEQ_DELAY_MASK                    0xff000000L
 
-// CLK_PWRMGT_CNTL_M6
-#define	CLK_PWRMGT_CNTL_M6__MPLL_PWRMGT_OFF__SHIFT         0x00000000
-#define	CLK_PWRMGT_CNTL_M6__SPLL_PWRMGT_OFF__SHIFT         0x00000001
-#define	CLK_PWRMGT_CNTL_M6__PPLL_PWRMGT_OFF__SHIFT         0x00000002
-#define	CLK_PWRMGT_CNTL_M6__P2PLL_PWRMGT_OFF__SHIFT        0x00000003
-#define	CLK_PWRMGT_CNTL_M6__MCLK_TURNOFF__SHIFT            0x00000004
-#define	CLK_PWRMGT_CNTL_M6__SCLK_TURNOFF__SHIFT            0x00000005
-#define	CLK_PWRMGT_CNTL_M6__PCLK_TURNOFF__SHIFT            0x00000006
-#define	CLK_PWRMGT_CNTL_M6__P2CLK_TURNOFF__SHIFT           0x00000007
-#define	CLK_PWRMGT_CNTL_M6__MC_CH_MODE__SHIFT              0x00000008
-#define	CLK_PWRMGT_CNTL_M6__TEST_MODE__SHIFT               0x00000009
-#define	CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN__SHIFT          0x0000000a
-#define	CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE__SHIFT      0x0000000c
-#define	CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT__SHIFT         0x0000000d
-#define	CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT__SHIFT       0x0000000f
-#define	CLK_PWRMGT_CNTL_M6__MC_BUSY__SHIFT                 0x00000010
-#define	CLK_PWRMGT_CNTL_M6__MC_INT_CNTL__SHIFT             0x00000011
-#define	CLK_PWRMGT_CNTL_M6__MC_SWITCH__SHIFT               0x00000012
-#define	CLK_PWRMGT_CNTL_M6__DLL_READY__SHIFT               0x00000013
-#define	CLK_PWRMGT_CNTL_M6__DISP_PM__SHIFT                 0x00000014
-#define	CLK_PWRMGT_CNTL_M6__DYN_STOP_MODE__SHIFT           0x00000015
-#define	CLK_PWRMGT_CNTL_M6__CG_NO1_DEBUG__SHIFT            0x00000018
-#define	CLK_PWRMGT_CNTL_M6__TVPLL_PWRMGT_OFF__SHIFT        0x0000001e
-#define	CLK_PWRMGT_CNTL_M6__TVCLK_TURNOFF__SHIFT           0x0000001f
+// pllCLK_PWRMGT_CNTL
+#define	CLK_PWRMGT_CNTL__MPLL_PWRMGT_OFF__SHIFT         0x00000000
+#define	CLK_PWRMGT_CNTL__SPLL_PWRMGT_OFF__SHIFT         0x00000001
+#define	CLK_PWRMGT_CNTL__PPLL_PWRMGT_OFF__SHIFT         0x00000002
+#define	CLK_PWRMGT_CNTL__P2PLL_PWRMGT_OFF__SHIFT        0x00000003
+#define	CLK_PWRMGT_CNTL__MCLK_TURNOFF__SHIFT            0x00000004
+#define	CLK_PWRMGT_CNTL__SCLK_TURNOFF__SHIFT            0x00000005
+#define	CLK_PWRMGT_CNTL__PCLK_TURNOFF__SHIFT            0x00000006
+#define	CLK_PWRMGT_CNTL__P2CLK_TURNOFF__SHIFT           0x00000007
+#define	CLK_PWRMGT_CNTL__MC_CH_MODE__SHIFT              0x00000008
+#define	CLK_PWRMGT_CNTL__TEST_MODE__SHIFT               0x00000009
+#define	CLK_PWRMGT_CNTL__GLOBAL_PMAN_EN__SHIFT          0x0000000a
+#define	CLK_PWRMGT_CNTL__ENGINE_DYNCLK_MODE__SHIFT      0x0000000c
+#define	CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT__SHIFT         0x0000000d
+#define	CLK_PWRMGT_CNTL__DISP_DYN_STOP_LAT__SHIFT       0x0000000f
+#define	CLK_PWRMGT_CNTL__MC_BUSY__SHIFT                 0x00000010
+#define	CLK_PWRMGT_CNTL__MC_INT_CNTL__SHIFT             0x00000011
+#define	CLK_PWRMGT_CNTL__MC_SWITCH__SHIFT               0x00000012
+#define	CLK_PWRMGT_CNTL__DLL_READY__SHIFT               0x00000013
+#define	CLK_PWRMGT_CNTL__DISP_PM__SHIFT                 0x00000014
+#define	CLK_PWRMGT_CNTL__DYN_STOP_MODE__SHIFT           0x00000015
+#define	CLK_PWRMGT_CNTL__CG_NO1_DEBUG__SHIFT            0x00000018
+#define	CLK_PWRMGT_CNTL__TVPLL_PWRMGT_OFF__SHIFT        0x0000001e
+#define	CLK_PWRMGT_CNTL__TVCLK_TURNOFF__SHIFT           0x0000001f
 
-// P2PLL_CNTL
+// pllP2PLL_CNTL
 #define P2PLL_CNTL__P2PLL_RESET_MASK                       0x00000001L
 #define P2PLL_CNTL__P2PLL_RESET                            0x00000001L
 #define P2PLL_CNTL__P2PLL_SLEEP_MASK                       0x00000002L
@@ -1041,7 +1075,7 @@
 #define P2PLL_CNTL__P2PLL_DISABLE_AUTO_RESET_MASK          0x00080000L
 #define P2PLL_CNTL__P2PLL_DISABLE_AUTO_RESET               0x00080000L
 
-// PIXCLKS_CNTL
+// pllPIXCLKS_CNTL
 #define	PIXCLKS_CNTL__PIX2CLK_SRC_SEL__SHIFT               0x00000000
 #define	PIXCLKS_CNTL__PIX2CLK_INVERT__SHIFT                0x00000004
 #define	PIXCLKS_CNTL__PIX2CLK_SRC_INVERT__SHIFT            0x00000005
@@ -1055,31 +1089,29 @@
 #define	PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb__SHIFT        0x0000000f
 
 
-// PIXCLKS_CNTL
+// pllPIXCLKS_CNTL
 #define PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK                 0x00000003L
-#define PIXCLKS_CNTL__PIX2CLK_INVERT_MASK                  0x00000010L
 #define PIXCLKS_CNTL__PIX2CLK_INVERT                       0x00000010L
-#define PIXCLKS_CNTL__PIX2CLK_SRC_INVERT_MASK              0x00000020L
 #define PIXCLKS_CNTL__PIX2CLK_SRC_INVERT                   0x00000020L
-#define PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb_MASK              0x00000040L
 #define PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb                   0x00000040L
-#define PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb_MASK          0x00000080L
 #define PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb               0x00000080L
-#define PIXCLKS_CNTL__PIXCLK_TV_SRC_SEL_MASK               0x00000100L
 #define PIXCLKS_CNTL__PIXCLK_TV_SRC_SEL                    0x00000100L
-#define PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb_MASK         0x00000800L
 #define PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb              0x00000800L
-#define PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb_MASK            0x00001000L
 #define PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb                 0x00001000L
-#define PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb_MASK      0x00002000L
 #define PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb           0x00002000L
-#define PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb_MASK          0x00004000L
 #define PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb               0x00004000L
-#define PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb_MASK          0x00008000L
 #define PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb               0x00008000L
+#define PIXCLKS_CNTL__DISP_TVOUT_PIXCLK_TV_ALWAYS_ONb      (1 << 9)
+#define PIXCLKS_CNTL__R300_DVOCLK_ALWAYS_ONb               (1 << 10)
+#define PIXCLKS_CNTL__R300_PIXCLK_DVO_ALWAYS_ONb           (1 << 13)
+#define PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb         (1 << 16)
+#define PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb           (1 << 17)
+#define PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb              (1 << 18)
+#define PIXCLKS_CNTL__R300_P2G2CLK_DAC_ALWAYS_ONb          (1 << 19)
+#define PIXCLKS_CNTL__R300_DISP_DAC_PIXCLK_DAC2_BLANK_OFF  (1 << 23)
 
 
-// P2PLL_DIV_0
+// pllP2PLL_DIV_0
 #define P2PLL_DIV_0__P2PLL_FB_DIV_MASK                     0x000007ffL
 #define P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W_MASK            0x00008000L
 #define P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W                 0x00008000L
@@ -1087,124 +1119,97 @@
 #define P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_R                 0x00008000L
 #define P2PLL_DIV_0__P2PLL_POST_DIV_MASK                   0x00070000L
 
-// SCLK_CNTL_M6
-#define SCLK_CNTL_M6__SCLK_SRC_SEL_MASK                    0x00000007L
-#define SCLK_CNTL_M6__CP_MAX_DYN_STOP_LAT_MASK             0x00000008L
-#define SCLK_CNTL_M6__CP_MAX_DYN_STOP_LAT                  0x00000008L
-#define SCLK_CNTL_M6__HDP_MAX_DYN_STOP_LAT_MASK            0x00000010L
-#define SCLK_CNTL_M6__HDP_MAX_DYN_STOP_LAT                 0x00000010L
-#define SCLK_CNTL_M6__TV_MAX_DYN_STOP_LAT_MASK             0x00000020L
-#define SCLK_CNTL_M6__TV_MAX_DYN_STOP_LAT                  0x00000020L
-#define SCLK_CNTL_M6__E2_MAX_DYN_STOP_LAT_MASK             0x00000040L
-#define SCLK_CNTL_M6__E2_MAX_DYN_STOP_LAT                  0x00000040L
-#define SCLK_CNTL_M6__SE_MAX_DYN_STOP_LAT_MASK             0x00000080L
-#define SCLK_CNTL_M6__SE_MAX_DYN_STOP_LAT                  0x00000080L
-#define SCLK_CNTL_M6__IDCT_MAX_DYN_STOP_LAT_MASK           0x00000100L
-#define SCLK_CNTL_M6__IDCT_MAX_DYN_STOP_LAT                0x00000100L
-#define SCLK_CNTL_M6__VIP_MAX_DYN_STOP_LAT_MASK            0x00000200L
-#define SCLK_CNTL_M6__VIP_MAX_DYN_STOP_LAT                 0x00000200L
-#define SCLK_CNTL_M6__RE_MAX_DYN_STOP_LAT_MASK             0x00000400L
-#define SCLK_CNTL_M6__RE_MAX_DYN_STOP_LAT                  0x00000400L
-#define SCLK_CNTL_M6__PB_MAX_DYN_STOP_LAT_MASK             0x00000800L
-#define SCLK_CNTL_M6__PB_MAX_DYN_STOP_LAT                  0x00000800L
-#define SCLK_CNTL_M6__TAM_MAX_DYN_STOP_LAT_MASK            0x00001000L
-#define SCLK_CNTL_M6__TAM_MAX_DYN_STOP_LAT                 0x00001000L
-#define SCLK_CNTL_M6__TDM_MAX_DYN_STOP_LAT_MASK            0x00002000L
-#define SCLK_CNTL_M6__TDM_MAX_DYN_STOP_LAT                 0x00002000L
-#define SCLK_CNTL_M6__RB_MAX_DYN_STOP_LAT_MASK             0x00004000L
-#define SCLK_CNTL_M6__RB_MAX_DYN_STOP_LAT                  0x00004000L
-#define SCLK_CNTL_M6__FORCE_DISP2_MASK                     0x00008000L
-#define SCLK_CNTL_M6__FORCE_DISP2                          0x00008000L
-#define SCLK_CNTL_M6__FORCE_CP_MASK                        0x00010000L
-#define SCLK_CNTL_M6__FORCE_CP                             0x00010000L
-#define SCLK_CNTL_M6__FORCE_HDP_MASK                       0x00020000L
-#define SCLK_CNTL_M6__FORCE_HDP                            0x00020000L
-#define SCLK_CNTL_M6__FORCE_DISP1_MASK                     0x00040000L
-#define SCLK_CNTL_M6__FORCE_DISP1                          0x00040000L
-#define SCLK_CNTL_M6__FORCE_TOP_MASK                       0x00080000L
-#define SCLK_CNTL_M6__FORCE_TOP                            0x00080000L
-#define SCLK_CNTL_M6__FORCE_E2_MASK                        0x00100000L
-#define SCLK_CNTL_M6__FORCE_E2                             0x00100000L
-#define SCLK_CNTL_M6__FORCE_SE_MASK                        0x00200000L
-#define SCLK_CNTL_M6__FORCE_SE                             0x00200000L
-#define SCLK_CNTL_M6__FORCE_IDCT_MASK                      0x00400000L
-#define SCLK_CNTL_M6__FORCE_IDCT                           0x00400000L
-#define SCLK_CNTL_M6__FORCE_VIP_MASK                       0x00800000L
-#define SCLK_CNTL_M6__FORCE_VIP                            0x00800000L
-#define SCLK_CNTL_M6__FORCE_RE_MASK                        0x01000000L
-#define SCLK_CNTL_M6__FORCE_RE                             0x01000000L
-#define SCLK_CNTL_M6__FORCE_PB_MASK                        0x02000000L
-#define SCLK_CNTL_M6__FORCE_PB                             0x02000000L
-#define SCLK_CNTL_M6__FORCE_TAM_MASK                       0x04000000L
-#define SCLK_CNTL_M6__FORCE_TAM                            0x04000000L
-#define SCLK_CNTL_M6__FORCE_TDM_MASK                       0x08000000L
-#define SCLK_CNTL_M6__FORCE_TDM                            0x08000000L
-#define SCLK_CNTL_M6__FORCE_RB_MASK                        0x10000000L
-#define SCLK_CNTL_M6__FORCE_RB                             0x10000000L
-#define SCLK_CNTL_M6__FORCE_TV_SCLK_MASK                   0x20000000L
-#define SCLK_CNTL_M6__FORCE_TV_SCLK                        0x20000000L
-#define SCLK_CNTL_M6__FORCE_SUBPIC_MASK                    0x40000000L
-#define SCLK_CNTL_M6__FORCE_SUBPIC                         0x40000000L
-#define SCLK_CNTL_M6__FORCE_OV0_MASK                       0x80000000L
-#define SCLK_CNTL_M6__FORCE_OV0                            0x80000000L
+// pllSCLK_CNTL
+#define SCLK_CNTL__SCLK_SRC_SEL_MASK                    0x00000007L
+#define SCLK_CNTL__CP_MAX_DYN_STOP_LAT                  0x00000008L
+#define SCLK_CNTL__HDP_MAX_DYN_STOP_LAT                 0x00000010L
+#define SCLK_CNTL__TV_MAX_DYN_STOP_LAT                  0x00000020L
+#define SCLK_CNTL__E2_MAX_DYN_STOP_LAT                  0x00000040L
+#define SCLK_CNTL__SE_MAX_DYN_STOP_LAT                  0x00000080L
+#define SCLK_CNTL__IDCT_MAX_DYN_STOP_LAT                0x00000100L
+#define SCLK_CNTL__VIP_MAX_DYN_STOP_LAT                 0x00000200L
+#define SCLK_CNTL__RE_MAX_DYN_STOP_LAT                  0x00000400L
+#define SCLK_CNTL__PB_MAX_DYN_STOP_LAT                  0x00000800L
+#define SCLK_CNTL__TAM_MAX_DYN_STOP_LAT                 0x00001000L
+#define SCLK_CNTL__TDM_MAX_DYN_STOP_LAT                 0x00002000L
+#define SCLK_CNTL__RB_MAX_DYN_STOP_LAT                  0x00004000L
+#define SCLK_CNTL__DYN_STOP_LAT_MASK                     0x00007ff8
+#define SCLK_CNTL__FORCE_DISP2                          0x00008000L
+#define SCLK_CNTL__FORCE_CP                             0x00010000L
+#define SCLK_CNTL__FORCE_HDP                            0x00020000L
+#define SCLK_CNTL__FORCE_DISP1                          0x00040000L
+#define SCLK_CNTL__FORCE_TOP                            0x00080000L
+#define SCLK_CNTL__FORCE_E2                             0x00100000L
+#define SCLK_CNTL__FORCE_SE                             0x00200000L
+#define SCLK_CNTL__FORCE_IDCT                           0x00400000L
+#define SCLK_CNTL__FORCE_VIP                            0x00800000L
+#define SCLK_CNTL__FORCE_RE                             0x01000000L
+#define SCLK_CNTL__FORCE_PB                             0x02000000L
+#define SCLK_CNTL__FORCE_TAM                            0x04000000L
+#define SCLK_CNTL__FORCE_TDM                            0x08000000L
+#define SCLK_CNTL__FORCE_RB                             0x10000000L
+#define SCLK_CNTL__FORCE_TV_SCLK                        0x20000000L
+#define SCLK_CNTL__FORCE_SUBPIC                         0x40000000L
+#define SCLK_CNTL__FORCE_OV0                            0x80000000L
+#define SCLK_CNTL__R300_FORCE_VAP                       (1<<21)
+#define SCLK_CNTL__R300_FORCE_SR                        (1<<25)
+#define SCLK_CNTL__R300_FORCE_PX                        (1<<26)
+#define SCLK_CNTL__R300_FORCE_TX                        (1<<27)
+#define SCLK_CNTL__R300_FORCE_US                        (1<<28)
+#define SCLK_CNTL__R300_FORCE_SU                        (1<<30)
+#define SCLK_CNTL__FORCEON_MASK                         0xffff8000L
+
+// pllSCLK_CNTL2
+#define SCLK_CNTL2__R300_TCL_MAX_DYN_STOP_LAT           (1<<10)
+#define SCLK_CNTL2__R300_GA_MAX_DYN_STOP_LAT            (1<<11)
+#define SCLK_CNTL2__R300_CBA_MAX_DYN_STOP_LAT           (1<<12)
+#define SCLK_CNTL2__R300_FORCE_TCL                      (1<<13)
+#define SCLK_CNTL2__R300_FORCE_CBA                      (1<<14)
+#define SCLK_CNTL2__R300_FORCE_GA                       (1<<15)
 
 // SCLK_MORE_CNTL
-#define SCLK_MORE_CNTL__DISPREGS_MAX_DYN_STOP_LAT_MASK     0x00000001L
 #define SCLK_MORE_CNTL__DISPREGS_MAX_DYN_STOP_LAT          0x00000001L
-#define SCLK_MORE_CNTL__MC_GUI_MAX_DYN_STOP_LAT_MASK       0x00000002L
 #define SCLK_MORE_CNTL__MC_GUI_MAX_DYN_STOP_LAT            0x00000002L
-#define SCLK_MORE_CNTL__MC_HOST_MAX_DYN_STOP_LAT_MASK      0x00000004L
 #define SCLK_MORE_CNTL__MC_HOST_MAX_DYN_STOP_LAT           0x00000004L
-#define SCLK_MORE_CNTL__FORCE_DISPREGS_MASK                0x00000100L
 #define SCLK_MORE_CNTL__FORCE_DISPREGS                     0x00000100L
-#define SCLK_MORE_CNTL__FORCE_MC_GUI_MASK                  0x00000200L
 #define SCLK_MORE_CNTL__FORCE_MC_GUI                       0x00000200L
-#define SCLK_MORE_CNTL__FORCE_MC_HOST_MASK                 0x00000400L
 #define SCLK_MORE_CNTL__FORCE_MC_HOST                      0x00000400L
-#define SCLK_MORE_CNTL__STOP_SCLK_EN_MASK                  0x00001000L
 #define SCLK_MORE_CNTL__STOP_SCLK_EN                       0x00001000L
-#define SCLK_MORE_CNTL__STOP_SCLK_A_MASK                   0x00002000L
 #define SCLK_MORE_CNTL__STOP_SCLK_A                        0x00002000L
-#define SCLK_MORE_CNTL__STOP_SCLK_B_MASK                   0x00004000L
 #define SCLK_MORE_CNTL__STOP_SCLK_B                        0x00004000L
-#define SCLK_MORE_CNTL__STOP_SCLK_C_MASK                   0x00008000L
 #define SCLK_MORE_CNTL__STOP_SCLK_C                        0x00008000L
-#define SCLK_MORE_CNTL__HALF_SPEED_SCLK_MASK               0x00010000L
 #define SCLK_MORE_CNTL__HALF_SPEED_SCLK                    0x00010000L
-#define SCLK_MORE_CNTL__IO_CG_VOLTAGE_DROP_MASK            0x00020000L
 #define SCLK_MORE_CNTL__IO_CG_VOLTAGE_DROP                 0x00020000L
-#define SCLK_MORE_CNTL__TVFB_SOFT_RESET_MASK               0x00040000L
 #define SCLK_MORE_CNTL__TVFB_SOFT_RESET                    0x00040000L
-#define SCLK_MORE_CNTL__VOLTAGE_DROP_SYNC_MASK             0x00080000L
 #define SCLK_MORE_CNTL__VOLTAGE_DROP_SYNC                  0x00080000L
-#define SCLK_MORE_CNTL__VOLTAGE_DELAY_SEL_MASK             0x00300000L
-#define SCLK_MORE_CNTL__IDLE_DELAY_HALF_SCLK_MASK          0x00400000L
 #define SCLK_MORE_CNTL__IDLE_DELAY_HALF_SCLK               0x00400000L
-#define SCLK_MORE_CNTL__AGP_BUSY_HALF_SCLK_MASK            0x00800000L
 #define SCLK_MORE_CNTL__AGP_BUSY_HALF_SCLK                 0x00800000L
 #define SCLK_MORE_CNTL__CG_SPARE_RD_C_MASK                 0xff000000L
+#define SCLK_MORE_CNTL__FORCEON                            0x00000700L
 
-// MCLK_CNTL_M6
-#define MCLK_CNTL_M6__MCLKA_SRC_SEL_MASK                   0x00000007L
-#define MCLK_CNTL_M6__YCLKA_SRC_SEL_MASK                   0x00000070L
-#define MCLK_CNTL_M6__MCLKB_SRC_SEL_MASK                   0x00000700L
-#define MCLK_CNTL_M6__YCLKB_SRC_SEL_MASK                   0x00007000L
-#define MCLK_CNTL_M6__FORCE_MCLKA_MASK                     0x00010000L
-#define MCLK_CNTL_M6__FORCE_MCLKA                          0x00010000L
-#define MCLK_CNTL_M6__FORCE_MCLKB_MASK                     0x00020000L
-#define MCLK_CNTL_M6__FORCE_MCLKB                          0x00020000L
-#define MCLK_CNTL_M6__FORCE_YCLKA_MASK                     0x00040000L
-#define MCLK_CNTL_M6__FORCE_YCLKA                          0x00040000L
-#define MCLK_CNTL_M6__FORCE_YCLKB_MASK                     0x00080000L
-#define MCLK_CNTL_M6__FORCE_YCLKB                          0x00080000L
-#define MCLK_CNTL_M6__FORCE_MC_MASK                        0x00100000L
-#define MCLK_CNTL_M6__FORCE_MC                             0x00100000L
-#define MCLK_CNTL_M6__FORCE_AIC_MASK                       0x00200000L
-#define MCLK_CNTL_M6__FORCE_AIC                            0x00200000L
-#define MCLK_CNTL_M6__MRDCKA0_SOUTSEL_MASK                 0x03000000L
-#define MCLK_CNTL_M6__MRDCKA1_SOUTSEL_MASK                 0x0c000000L
-#define MCLK_CNTL_M6__MRDCKB0_SOUTSEL_MASK                 0x30000000L
-#define MCLK_CNTL_M6__MRDCKB1_SOUTSEL_MASK                 0xc0000000L
+// MCLK_CNTL
+#define MCLK_CNTL__MCLKA_SRC_SEL_MASK                   0x00000007L
+#define MCLK_CNTL__YCLKA_SRC_SEL_MASK                   0x00000070L
+#define MCLK_CNTL__MCLKB_SRC_SEL_MASK                   0x00000700L
+#define MCLK_CNTL__YCLKB_SRC_SEL_MASK                   0x00007000L
+#define MCLK_CNTL__FORCE_MCLKA_MASK                     0x00010000L
+#define MCLK_CNTL__FORCE_MCLKA                          0x00010000L
+#define MCLK_CNTL__FORCE_MCLKB_MASK                     0x00020000L
+#define MCLK_CNTL__FORCE_MCLKB                          0x00020000L
+#define MCLK_CNTL__FORCE_YCLKA_MASK                     0x00040000L
+#define MCLK_CNTL__FORCE_YCLKA                          0x00040000L
+#define MCLK_CNTL__FORCE_YCLKB_MASK                     0x00080000L
+#define MCLK_CNTL__FORCE_YCLKB                          0x00080000L
+#define MCLK_CNTL__FORCE_MC_MASK                        0x00100000L
+#define MCLK_CNTL__FORCE_MC                             0x00100000L
+#define MCLK_CNTL__FORCE_AIC_MASK                       0x00200000L
+#define MCLK_CNTL__FORCE_AIC                            0x00200000L
+#define MCLK_CNTL__MRDCKA0_SOUTSEL_MASK                 0x03000000L
+#define MCLK_CNTL__MRDCKA1_SOUTSEL_MASK                 0x0c000000L
+#define MCLK_CNTL__MRDCKB0_SOUTSEL_MASK                 0x30000000L
+#define MCLK_CNTL__MRDCKB1_SOUTSEL_MASK                 0xc0000000L
+#define MCLK_CNTL__R300_DISABLE_MC_MCLKA                (1 << 21)
+#define MCLK_CNTL__R300_DISABLE_MC_MCLKB                (1 << 21)
 
 // MCLK_MISC
 #define MCLK_MISC__SCLK_SOURCED_FROM_MPLL_SEL_MASK         0x00000003L
@@ -1238,19 +1243,14 @@
 
 // VCLK_ECP_CNTL
 #define VCLK_ECP_CNTL__VCLK_SRC_SEL_MASK                   0x00000003L
-#define VCLK_ECP_CNTL__VCLK_INVERT_MASK                    0x00000010L
 #define VCLK_ECP_CNTL__VCLK_INVERT                         0x00000010L
-#define VCLK_ECP_CNTL__PIXCLK_SRC_INVERT_MASK              0x00000020L
 #define VCLK_ECP_CNTL__PIXCLK_SRC_INVERT                   0x00000020L
-#define VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb_MASK              0x00000040L
 #define VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb                   0x00000040L
-#define VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb_MASK          0x00000080L
 #define VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb               0x00000080L
 #define VCLK_ECP_CNTL__ECP_DIV_MASK                        0x00000300L
-#define VCLK_ECP_CNTL__ECP_FORCE_ON_MASK                   0x00040000L
 #define VCLK_ECP_CNTL__ECP_FORCE_ON                        0x00040000L
-#define VCLK_ECP_CNTL__SUBCLK_FORCE_ON_MASK                0x00080000L
 #define VCLK_ECP_CNTL__SUBCLK_FORCE_ON                     0x00080000L
+#define VCLK_ECP_CNTL__R300_DISP_DAC_PIXCLK_DAC_BLANK_OFF  (1<<23)
 
 // PLL_PWRMGT_CNTL
 #define PLL_PWRMGT_CNTL__MPLL_TURNOFF_MASK                 0x00000001L
@@ -1282,54 +1282,54 @@
 #define PLL_PWRMGT_CNTL__SU_SUSTAIN_DISABLE                0x00080000L
 #define PLL_PWRMGT_CNTL__TCL_BYPASS_DISABLE_MASK           0x00100000L
 #define PLL_PWRMGT_CNTL__TCL_BYPASS_DISABLE                0x00100000L
-#define PLL_PWRMGT_CNTL__TCL_CLOCK_ACTIVE_RD_MASK          0x00200000L
+#define PLL_PWRMGT_CNTL__TCL_CLOCK_CTIVE_RD_MASK          0x00200000L
 #define PLL_PWRMGT_CNTL__TCL_CLOCK_ACTIVE_RD               0x00200000L
 #define PLL_PWRMGT_CNTL__CG_NO2_DEBUG_MASK                 0xff000000L
 
-// CLK_PWRMGT_CNTL_M6
-#define CLK_PWRMGT_CNTL_M6__MPLL_PWRMGT_OFF_MASK           0x00000001L
-#define CLK_PWRMGT_CNTL_M6__MPLL_PWRMGT_OFF                0x00000001L
-#define CLK_PWRMGT_CNTL_M6__SPLL_PWRMGT_OFF_MASK           0x00000002L
-#define CLK_PWRMGT_CNTL_M6__SPLL_PWRMGT_OFF                0x00000002L
-#define CLK_PWRMGT_CNTL_M6__PPLL_PWRMGT_OFF_MASK           0x00000004L
-#define CLK_PWRMGT_CNTL_M6__PPLL_PWRMGT_OFF                0x00000004L
-#define CLK_PWRMGT_CNTL_M6__P2PLL_PWRMGT_OFF_MASK          0x00000008L
-#define CLK_PWRMGT_CNTL_M6__P2PLL_PWRMGT_OFF               0x00000008L
-#define CLK_PWRMGT_CNTL_M6__MCLK_TURNOFF_MASK              0x00000010L
-#define CLK_PWRMGT_CNTL_M6__MCLK_TURNOFF                   0x00000010L
-#define CLK_PWRMGT_CNTL_M6__SCLK_TURNOFF_MASK              0x00000020L
-#define CLK_PWRMGT_CNTL_M6__SCLK_TURNOFF                   0x00000020L
-#define CLK_PWRMGT_CNTL_M6__PCLK_TURNOFF_MASK              0x00000040L
-#define CLK_PWRMGT_CNTL_M6__PCLK_TURNOFF                   0x00000040L
-#define CLK_PWRMGT_CNTL_M6__P2CLK_TURNOFF_MASK             0x00000080L
-#define CLK_PWRMGT_CNTL_M6__P2CLK_TURNOFF                  0x00000080L
-#define CLK_PWRMGT_CNTL_M6__MC_CH_MODE_MASK                0x00000100L
-#define CLK_PWRMGT_CNTL_M6__MC_CH_MODE                     0x00000100L
-#define CLK_PWRMGT_CNTL_M6__TEST_MODE_MASK                 0x00000200L
-#define CLK_PWRMGT_CNTL_M6__TEST_MODE                      0x00000200L
-#define CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN_MASK            0x00000400L
-#define CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN                 0x00000400L
-#define CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE_MASK        0x00001000L
-#define CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE             0x00001000L
-#define CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT_MASK           0x00006000L
-#define CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT_MASK         0x00008000L
-#define CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT              0x00008000L
-#define CLK_PWRMGT_CNTL_M6__MC_BUSY_MASK                   0x00010000L
-#define CLK_PWRMGT_CNTL_M6__MC_BUSY                        0x00010000L
-#define CLK_PWRMGT_CNTL_M6__MC_INT_CNTL_MASK               0x00020000L
-#define CLK_PWRMGT_CNTL_M6__MC_INT_CNTL                    0x00020000L
-#define CLK_PWRMGT_CNTL_M6__MC_SWITCH_MASK                 0x00040000L
-#define CLK_PWRMGT_CNTL_M6__MC_SWITCH                      0x00040000L
-#define CLK_PWRMGT_CNTL_M6__DLL_READY_MASK                 0x00080000L
-#define CLK_PWRMGT_CNTL_M6__DLL_READY                      0x00080000L
-#define CLK_PWRMGT_CNTL_M6__DISP_PM_MASK                   0x00100000L
-#define CLK_PWRMGT_CNTL_M6__DISP_PM                        0x00100000L
-#define CLK_PWRMGT_CNTL_M6__DYN_STOP_MODE_MASK             0x00e00000L
-#define CLK_PWRMGT_CNTL_M6__CG_NO1_DEBUG_MASK              0x3f000000L
-#define CLK_PWRMGT_CNTL_M6__TVPLL_PWRMGT_OFF_MASK          0x40000000L
-#define CLK_PWRMGT_CNTL_M6__TVPLL_PWRMGT_OFF               0x40000000L
-#define CLK_PWRMGT_CNTL_M6__TVCLK_TURNOFF_MASK             0x80000000L
-#define CLK_PWRMGT_CNTL_M6__TVCLK_TURNOFF                  0x80000000L
+// CLK_PWRMGT_CNTL
+#define CLK_PWRMGT_CNTL__MPLL_PWRMGT_OFF_MASK           0x00000001L
+#define CLK_PWRMGT_CNTL__MPLL_PWRMGT_OFF                0x00000001L
+#define CLK_PWRMGT_CNTL__SPLL_PWRMGT_OFF_MASK           0x00000002L
+#define CLK_PWRMGT_CNTL__SPLL_PWRMGT_OFF                0x00000002L
+#define CLK_PWRMGT_CNTL__PPLL_PWRMGT_OFF_MASK           0x00000004L
+#define CLK_PWRMGT_CNTL__PPLL_PWRMGT_OFF                0x00000004L
+#define CLK_PWRMGT_CNTL__P2PLL_PWRMGT_OFF_MASK          0x00000008L
+#define CLK_PWRMGT_CNTL__P2PLL_PWRMGT_OFF               0x00000008L
+#define CLK_PWRMGT_CNTL__MCLK_TURNOFF_MASK              0x00000010L
+#define CLK_PWRMGT_CNTL__MCLK_TURNOFF                   0x00000010L
+#define CLK_PWRMGT_CNTL__SCLK_TURNOFF_MASK              0x00000020L
+#define CLK_PWRMGT_CNTL__SCLK_TURNOFF                   0x00000020L
+#define CLK_PWRMGT_CNTL__PCLK_TURNOFF_MASK              0x00000040L
+#define CLK_PWRMGT_CNTL__PCLK_TURNOFF                   0x00000040L
+#define CLK_PWRMGT_CNTL__P2CLK_TURNOFF_MASK             0x00000080L
+#define CLK_PWRMGT_CNTL__P2CLK_TURNOFF                  0x00000080L
+#define CLK_PWRMGT_CNTL__MC_CH_MODE_MASK                0x00000100L
+#define CLK_PWRMGT_CNTL__MC_CH_MODE                     0x00000100L
+#define CLK_PWRMGT_CNTL__TEST_MODE_MASK                 0x00000200L
+#define CLK_PWRMGT_CNTL__TEST_MODE                      0x00000200L
+#define CLK_PWRMGT_CNTL__GLOBAL_PMAN_EN_MASK            0x00000400L
+#define CLK_PWRMGT_CNTL__GLOBAL_PMAN_EN                 0x00000400L
+#define CLK_PWRMGT_CNTL__ENGINE_DYNCLK_MODE_MASK        0x00001000L
+#define CLK_PWRMGT_CNTL__ENGINE_DYNCLK_MODE             0x00001000L
+#define CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT_MASK           0x00006000L
+#define CLK_PWRMGT_CNTL__DISP_DYN_STOP_LAT_MASK         0x00008000L
+#define CLK_PWRMGT_CNTL__DISP_DYN_STOP_LAT              0x00008000L
+#define CLK_PWRMGT_CNTL__MC_BUSY_MASK                   0x00010000L
+#define CLK_PWRMGT_CNTL__MC_BUSY                        0x00010000L
+#define CLK_PWRMGT_CNTL__MC_INT_CNTL_MASK               0x00020000L
+#define CLK_PWRMGT_CNTL__MC_INT_CNTL                    0x00020000L
+#define CLK_PWRMGT_CNTL__MC_SWITCH_MASK                 0x00040000L
+#define CLK_PWRMGT_CNTL__MC_SWITCH                      0x00040000L
+#define CLK_PWRMGT_CNTL__DLL_READY_MASK                 0x00080000L
+#define CLK_PWRMGT_CNTL__DLL_READY                      0x00080000L
+#define CLK_PWRMGT_CNTL__DISP_PM_MASK                   0x00100000L
+#define CLK_PWRMGT_CNTL__DISP_PM                        0x00100000L
+#define CLK_PWRMGT_CNTL__DYN_STOP_MODE_MASK             0x00e00000L
+#define CLK_PWRMGT_CNTL__CG_NO1_DEBUG_MASK              0x3f000000L
+#define CLK_PWRMGT_CNTL__TVPLL_PWRMGT_OFF_MASK          0x40000000L
+#define CLK_PWRMGT_CNTL__TVPLL_PWRMGT_OFF               0x40000000L
+#define CLK_PWRMGT_CNTL__TVCLK_TURNOFF_MASK             0x80000000L
+#define CLK_PWRMGT_CNTL__TVCLK_TURNOFF                  0x80000000L
 
 // BUS_CNTL1
 #define BUS_CNTL1__PMI_IO_DISABLE_MASK                     0x00000001L
@@ -1876,53 +1876,63 @@
 #define MDLL_RDCKB__MRDCKB1_BP_SEL_MASK                    0x80000000L
 #define MDLL_RDCKB__MRDCKB1_BP_SEL                         0x80000000L
 
-#define pllVCLK_ECP_CNTL                            0x0008
-#define pllDISP_TEST_MACRO_RW_WRITE                 0x001A
-#define pllDISP_TEST_MACRO_RW_READ                  0x001B
-#define pllDISP_TEST_MACRO_RW_DATA                  0x001C
-#define pllDISP_TEST_MACRO_RW_CNTL                  0x001D
-#define pllPIXCLKS_CNTL                             0x002D
+#define MDLL_R300_RDCK__MRDCKA_SLEEP                       0x00000001L
+#define MDLL_R300_RDCK__MRDCKA_RESET                       0x00000002L
+#define MDLL_R300_RDCK__MRDCKB_SLEEP                       0x00000004L
+#define MDLL_R300_RDCK__MRDCKB_RESET                       0x00000008L
+#define MDLL_R300_RDCK__MRDCKC_SLEEP                       0x00000010L
+#define MDLL_R300_RDCK__MRDCKC_RESET                       0x00000020L
+#define MDLL_R300_RDCK__MRDCKD_SLEEP                       0x00000040L
+#define MDLL_R300_RDCK__MRDCKD_RESET                       0x00000080L
+
+#define pllCLK_PIN_CNTL                             0x0001
+#define pllPPLL_CNTL                                0x0002
+#define pllPPLL_REF_DIV                             0x0003
 #define pllPPLL_DIV_0                               0x0004
 #define pllPPLL_DIV_1                               0x0005
 #define pllPPLL_DIV_2                               0x0006
 #define pllPPLL_DIV_3                               0x0007
+#define pllVCLK_ECP_CNTL                            0x0008
 #define pllHTOTAL_CNTL                              0x0009
-#define pllPLL_TEST_CNTL_M6                         0x0013
-#define pllP2PLL_DIV_0                              0x002C
-#define pllHTOTAL2_CNTL                             0x002E
-#define pllCLK_PIN_CNTL                             0x0001
-#define pllPPLL_CNTL                                0x0002
-#define pllPPLL_REF_DIV                             0x0003
-#define pllSPLL_CNTL                                0x000C
-#define pllSPLL_AUX_CNTL                            0x0024
-#define pllSCLK_CNTL_M6                             0x000D
+#define pllM_SPLL_REF_FB_DIV                        0x000A
 #define pllAGP_PLL_CNTL                             0x000B
+#define pllSPLL_CNTL                                0x000C
+#define pllSCLK_CNTL                                0x000D
+#define pllMPLL_CNTL                                0x000E
+#define pllMDLL_CKO                                 0x000F
+#define pllMDLL_RDCKA                               0x0010
+#define pllMDLL_RDCKB                               0x0011
+#define pllMCLK_CNTL                                0x0012
+#define pllPLL_TEST_CNTL                            0x0013
+#define pllCLK_PWRMGT_CNTL                          0x0014
+#define pllPLL_PWRMGT_CNTL                          0x0015
+#define pllCG_TEST_MACRO_RW_WRITE                   0x0016
+#define pllCG_TEST_MACRO_RW_READ                    0x0017
+#define pllCG_TEST_MACRO_RW_DATA                    0x0018
+#define pllCG_TEST_MACRO_RW_CNTL                    0x0019
+#define pllDISP_TEST_MACRO_RW_WRITE                 0x001A
+#define pllDISP_TEST_MACRO_RW_READ                  0x001B
+#define pllDISP_TEST_MACRO_RW_DATA                  0x001C
+#define pllDISP_TEST_MACRO_RW_CNTL                  0x001D
+#define pllSCLK_CNTL2                               0x001E
+#define pllMCLK_MISC                                0x001F
 #define pllTV_PLL_FINE_CNTL                         0x0020
 #define pllTV_PLL_CNTL                              0x0021
 #define pllTV_PLL_CNTL1                             0x0022
 #define pllTV_DTO_INCREMENTS                        0x0023
+#define pllSPLL_AUX_CNTL                            0x0024
+#define pllMPLL_AUX_CNTL                            0x0025
 #define pllP2PLL_CNTL                               0x002A
 #define pllP2PLL_REF_DIV                            0x002B
+#define pllP2PLL_DIV_0                              0x002C
+#define pllPIXCLKS_CNTL                             0x002D
+#define pllHTOTAL2_CNTL                             0x002E
 #define pllSSPLL_CNTL                               0x0030
 #define pllSSPLL_REF_DIV                            0x0031
 #define pllSSPLL_DIV_0                              0x0032
 #define pllSS_INT_CNTL                              0x0033
 #define pllSS_TST_CNTL                              0x0034
 #define pllSCLK_MORE_CNTL                           0x0035
-#define pllCLK_PWRMGT_CNTL_M6                       0x0014
-#define pllPLL_PWRMGT_CNTL                          0x0015
-#define pllM_SPLL_REF_FB_DIV                        0x000A
-#define pllMPLL_CNTL                                0x000E
-#define pllMPLL_AUX_CNTL                            0x0025
-#define pllMDLL_CKO                                 0x000F
-#define pllMDLL_RDCKA                               0x0010
-#define pllMDLL_RDCKB                               0x0011
-#define pllMCLK_CNTL_M6                             0x0012
-#define pllMCLK_MISC                                0x001F
-#define pllCG_TEST_MACRO_RW_WRITE                   0x0016
-#define pllCG_TEST_MACRO_RW_READ                    0x0017
-#define pllCG_TEST_MACRO_RW_DATA                    0x0018
-#define pllCG_TEST_MACRO_RW_CNTL                    0x0019
 
 #define ixMC_PERF_CNTL                             0x0000
 #define ixMC_PERF_SEL                              0x0001
@@ -1945,7 +1955,29 @@
 #define ixMC_BIST_CTRL                             0x0012
 #define ixREG_COLLAR_WRITE                         0x0013
 #define ixREG_COLLAR_READ                          0x0014
-
+#define ixR300_MC_IMP_CNTL                         0x0018
+#define ixR300_MC_CHP_IO_CNTL_A0                   0x0019
+#define ixR300_MC_CHP_IO_CNTL_A1                   0x001a
+#define ixR300_MC_CHP_IO_CNTL_B0                   0x001b
+#define ixR300_MC_CHP_IO_CNTL_B1                   0x001c
+#define ixR300_MC_CHP_IO_CNTL_C0                   0x001d
+#define ixR300_MC_CHP_IO_CNTL_C1                   0x001e
+#define ixR300_MC_CHP_IO_CNTL_D0                   0x001f
+#define ixR300_MC_CHP_IO_CNTL_D1                   0x0020
+#define ixR300_MC_IMP_CNTL_0                       0x0021
+#define ixR300_MC_ELPIDA_CNTL                      0x0022
+#define ixR300_MC_CHP_IO_OE_CNTL_CD                0x0023
+#define ixR300_MC_READ_CNTL_CD                     0x0024
+#define ixR300_MC_MC_INIT_WR_LAT_TIMER             0x0025
+#define ixR300_MC_DEBUG_CNTL                       0x0026
+#define ixR300_MC_BIST_CNTL_0                      0x0028
+#define ixR300_MC_BIST_CNTL_1                      0x0029
+#define ixR300_MC_BIST_CNTL_2                      0x002a
+#define ixR300_MC_BIST_CNTL_3                      0x002b
+#define ixR300_MC_BIST_CNTL_4                      0x002c
+#define ixR300_MC_BIST_CNTL_5                      0x002d
+#define ixR300_MC_IMP_STATUS                       0x002e
+#define ixR300_MC_DLL_CNTL                         0x002f
 #define NB_TOM                                     0x15C
 
 
diff -uNr linus-2.6.10/kernel/printk.c sleep-2.6.10/kernel/printk.c
--- linus-2.6.10/kernel/printk.c	2005-01-06 10:48:48.846230992 +0000
+++ sleep-2.6.10/kernel/printk.c	2005-01-06 11:39:26.431267648 +0000
@@ -608,6 +608,16 @@
 }
 EXPORT_SYMBOL(acquire_console_sem);
 
+int try_acquire_console_sem(void)
+{
+	if (down_trylock(&console_sem))
+		return -1;
+	console_locked = 1;
+	console_may_schedule = 0;
+	return 0;
+}
+EXPORT_SYMBOL(try_acquire_console_sem);
+
 int is_console_locked(void)
 {
 	return console_locked;
diff -uNr linus-2.6.10/sound/ppc/tumbler.c sleep-2.6.10/sound/ppc/tumbler.c
--- linus-2.6.10/sound/ppc/tumbler.c	2005-01-06 10:47:24.154190208 +0000
+++ sleep-2.6.10/sound/ppc/tumbler.c	2005-01-06 11:38:39.014284016 +0000
@@ -1028,7 +1028,7 @@
 	}
 	tumbler_set_master_volume(mix);
 	if (chip->update_automute)
-		chip->update_automute(chip, 0);
+		chip->update_automute(chip, 1);
 }
 #endif
 

--=-WfHEFeDD2HnhprlqkfEk--
