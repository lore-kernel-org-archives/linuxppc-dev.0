Message-ID: <3E8E2D71.8050707@mvista.com>
Date: Fri, 04 Apr 2003 18:12:17 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Patch for PCORE on linuxppc_2_4_devel
Content-Type: multipart/mixed;
 boundary="------------060900000903080307080304"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060900000903080307080304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch does the following:
a) Modifies the CONFIG_MORE_COMPILE_OPTIONS setup at the bottom of
arch/ppc/config.in.  The way that it was didn't work well and seemed
difficult to read.  I believe that the new way is "more correct" and
easier to understand
b) Updates arch/ppc/configs/pcore_defconfig
c) Add support for SERIAL_IO_PORT to gen550_dbg.c (very simple addition)
d) Turns on L2 cache for PCORE platforms
e) Add KGDB support for PCORE platforms

All of these changes are simple so I hope there is no need to separate
them into separate patches.

Please push in if there are no objections.

Mark
--

--------------060900000903080307080304
Content-Type: text/plain;
 name="pcore.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcore.patch"

===== arch/ppc/config.in 1.172 vs edited =====
--- 1.172/arch/ppc/config.in	Tue Apr  1 12:48:31 2003
+++ edited/arch/ppc/config.in	Fri Apr  4 15:53:33 2003
@@ -171,6 +171,7 @@

 if [ "$CONFIG_PCORE" = "y" -o "$CONFIG_POWERPMC250" = "y" ]; then
   define_bool CONFIG_FORCE y
+  define_bool CONFIG_GEN550 y
 fi

 if [ "$CONFIG_EV64260" = "y" -o "$CONFIG_HXEB100" = "y" \
@@ -760,14 +761,9 @@
   # following look a little odd.
   if [ "$CONFIG_KGDB" = "y" -o "$CONFIG_XMON" = "y" \
 	-o "$CONFIG_BDI_SWITCH" = "y" ]; then
-    bool '  Add any additional compile options' CONFIG_MORE_COMPILE_OPTIONS
+    bool '  Add additional compile options' CONFIG_MORE_COMPILE_OPTIONS
     if [ "$CONFIG_MORE_COMPILE_OPTIONS" = "y" ]; then
       string '    Additional compile arguments' CONFIG_COMPILE_OPTIONS "-g -ggdb"
-    else
-      if [ "$CONFIG_KGDB" = "y" ]; then
-        define_bool CONFIG_MORE_COMPILE_OPTIONS y
-	define_string CONFIG_COMPILE_OPTIONS "-g"
-      fi
     fi
   fi
 fi
===== arch/ppc/configs/pcore_defconfig 1.5 vs edited =====
--- 1.5/arch/ppc/configs/pcore_defconfig	Thu Mar 28 16:26:52 2002
+++ edited/arch/ppc/configs/pcore_defconfig	Thu Apr  3 17:10:12 2003
@@ -4,11 +4,13 @@
 # CONFIG_UID16 is not set
 # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_HAVE_DEC_LOCK=y

 #
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
+# CONFIG_ADVANCED_OPTIONS is not set

 #
 # Loadable module support
@@ -24,26 +26,41 @@
 CONFIG_PPC32=y
 CONFIG_6xx=y
 # CONFIG_40x is not set
+# CONFIG_440 is not set
 # CONFIG_POWER3 is not set
 # CONFIG_8xx is not set
+# CONFIG_PPC_ISERIES is not set
 # CONFIG_8260 is not set
+CONFIG_PPC_STD_MMU=y
 # CONFIG_ALL_PPC is not set
 # CONFIG_APUS is not set
-# CONFIG_SPRUCE is not set
+# CONFIG_WILLOW is not set
 CONFIG_PCORE=y
+# CONFIG_POWERPMC250 is not set
+# CONFIG_EV64260 is not set
+# CONFIG_SPRUCE is not set
 # CONFIG_MENF1 is not set
+# CONFIG_PUMA_A is not set
+# CONFIG_HXEB100 is not set
+# CONFIG_LOPEC is not set
 # CONFIG_MCPN765 is not set
 # CONFIG_MVME5100 is not set
+# CONFIG_PPLUS is not set
 # CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
 # CONFIG_SANDPOINT is not set
+# CONFIG_ADIR is not set
 # CONFIG_K2 is not set
+# CONFIG_PAL4 is not set
 # CONFIG_GEMINI is not set
 # CONFIG_ZX4500 is not set
+CONFIG_FORCE=y
+CONFIG_GEN550=y
 # CONFIG_MPC10X_STORE_GATHERING is not set
-# CONFIG_PPC601_SYNC_FIX is not set
 # CONFIG_SMP is not set
 CONFIG_ALTIVEC=y
 # CONFIG_TAU is not set
+CONFIG_PPC_ISATIMER=y

 #
 # General setup
@@ -93,12 +110,15 @@
 # CONFIG_PARIDE is not set
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_CISS_SCSI_TAPE is not set
 # CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BLK_STATS is not set

 #
 # Multi-device support (RAID and LVM)
@@ -109,6 +129,7 @@
 # CONFIG_MD_RAID0 is not set
 # CONFIG_MD_RAID1 is not set
 # CONFIG_MD_RAID5 is not set
+# CONFIG_MD_MULTIPATH is not set
 # CONFIG_BLK_DEV_LVM is not set

 #
@@ -116,8 +137,6 @@
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-CONFIG_NETLINK=y
-# CONFIG_RTNETLINK is not set
 # CONFIG_NETLINK_DEV is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
@@ -133,6 +152,7 @@
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set

@@ -141,15 +161,24 @@
 #
 CONFIG_IP_NF_CONNTRACK=m
 CONFIG_IP_NF_FTP=m
+# CONFIG_IP_NF_IRC is not set
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
+# CONFIG_IP_NF_MATCH_LENGTH is not set
+# CONFIG_IP_NF_MATCH_TTL is not set
 CONFIG_IP_NF_MATCH_TCPMSS=m
+# CONFIG_IP_NF_MATCH_HELPER is not set
 CONFIG_IP_NF_MATCH_STATE=m
+# CONFIG_IP_NF_MATCH_CONNTRACK is not set
 CONFIG_IP_NF_MATCH_UNCLEAN=m
 CONFIG_IP_NF_MATCH_OWNER=m
 CONFIG_IP_NF_FILTER=m
@@ -159,22 +188,32 @@
 CONFIG_IP_NF_NAT_NEEDED=y
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
+# CONFIG_IP_NF_NAT_LOCAL is not set
+# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
 CONFIG_IP_NF_NAT_FTP=m
 # CONFIG_IP_NF_MANGLE is not set
 # CONFIG_IP_NF_TARGET_LOG is not set
+# CONFIG_IP_NF_TARGET_ULOG is not set
 CONFIG_IP_NF_TARGET_TCPMSS=m
+# CONFIG_IP_NF_ARPTABLES is not set
 CONFIG_IP_NF_COMPAT_IPCHAINS=m
 CONFIG_IP_NF_NAT_NEEDED=y
 # CONFIG_IP_NF_COMPAT_IPFWADM is not set
 # CONFIG_IPV6 is not set
 # CONFIG_KHTTPD is not set
 # CONFIG_ATM is not set
+# CONFIG_VLAN_8021Q is not set

 #
 #
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
@@ -192,6 +231,11 @@
 # CONFIG_NET_SCHED is not set

 #
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+
+#
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
@@ -232,8 +276,10 @@
 # CONFIG_SCSI_AHA152X is not set
 # CONFIG_SCSI_AHA1542 is not set
 # CONFIG_SCSI_AHA1740 is not set
+# CONFIG_SCSI_AACRAID is not set
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
 # CONFIG_SCSI_AM53C974 is not set
@@ -252,6 +298,7 @@
 # CONFIG_SCSI_INIA100 is not set
 # CONFIG_SCSI_NCR53C406A is not set
 # CONFIG_SCSI_NCR53C7xx is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_NCR53C8XX is not set
 CONFIG_SCSI_SYM53C8XX=y
 CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
@@ -274,16 +321,34 @@
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_T128 is not set
 # CONFIG_SCSI_U14_34F is not set
+# CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
-# CONFIG_SCSI_MESH is not set
-# CONFIG_SCSI_MAC53C94 is not set

 #
-# IEEE 1394 (FireWire) support
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+# CONFIG_FUSION_BOOT is not set
+# CONFIG_FUSION_ISENSE is not set
+# CONFIG_FUSION_CTL is not set
+# CONFIG_FUSION_LAN is not set
+
+#
+# IEEE 1394 (FireWire) support (EXPERIMENTAL)
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
@@ -297,7 +362,6 @@
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 # CONFIG_ETHERTAP is not set
-# CONFIG_NET_SB1000 is not set

 #
 # Ethernet (10 or 100Mbit)
@@ -306,55 +370,71 @@
 # CONFIG_MACE is not set
 # CONFIG_BMAC is not set
 # CONFIG_GMAC is not set
-# CONFIG_NCR885E is not set
-# CONFIG_OAKNET is not set
+# CONFIG_SUNLANCE is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNBMAC is not set
+# CONFIG_SUNQE is not set
+# CONFIG_SUNGEM is not set
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_LANCE is not set
 # CONFIG_NET_VENDOR_SMC is not set
 # CONFIG_NET_VENDOR_RACAL is not set
-# CONFIG_AT1700 is not set
-# CONFIG_DEPCA is not set
 # CONFIG_HP100 is not set
 # CONFIG_NET_ISA is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_APRICOT is not set
 # CONFIG_CS89x0 is not set
 CONFIG_TULIP=y
+# CONFIG_TULIP_MWI is not set
+# CONFIG_TULIP_MMIO is not set
 # CONFIG_DE4X5 is not set
 # CONFIG_DGRS is not set
 # CONFIG_DM9102 is not set
 CONFIG_EEPRO100=y
-# CONFIG_EEPRO100_PM is not set
+# CONFIG_EEPRO100_PIO is not set
+# CONFIG_E100 is not set
 # CONFIG_LNE390 is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
 # CONFIG_NE2K_PCI is not set
 # CONFIG_NE3210 is not set
 # CONFIG_ES3210 is not set
+# CONFIG_8139CP is not set
 # CONFIG_8139TOO is not set
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
-# CONFIG_HAPPYMEAL is not set
 # CONFIG_NET_POCKET is not set

 #
 # Ethernet (1000 Mbit)
 #
 # CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_MYRI_SBUS is not set
+# CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
 # CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
+# CONFIG_PLIP is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set

@@ -410,6 +490,10 @@
 # Input core support
 #
 # CONFIG_INPUT is not set
+# CONFIG_INPUT_KEYBDEV is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_EVDEV is not set

 #
 # Macintosh device drivers
@@ -442,22 +526,33 @@
 CONFIG_PSMOUSE=y
 # CONFIG_82C710_MOUSE is not set
 # CONFIG_PC110_PAD is not set
+# CONFIG_MK712_MOUSE is not set

 #
 # Joysticks
 #
-# CONFIG_JOYSTICK is not set
+# CONFIG_INPUT_GAMEPORT is not set
+
+#
+# Input core support is needed for gameports
+#

 #
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
@@ -484,22 +579,33 @@
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_REISERFS_CHECK is not set
+# CONFIG_REISERFS_PROC_INFO is not set
 # CONFIG_ADFS_FS is not set
 # CONFIG_ADFS_FS_RW is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BEFS_DEBUG is not set
 # CONFIG_BFS_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_JBD_DEBUG is not set
 # CONFIG_FAT_FS is not set
 # CONFIG_MSDOS_FS is not set
 # CONFIG_UMSDOS_FS is not set
 # CONFIG_VFAT_FS is not set
 # CONFIG_EFS_FS is not set
 # CONFIG_JFFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
 CONFIG_TMPFS=y
-# CONFIG_RAMFS is not set
+CONFIG_RAMFS=y
 # CONFIG_ISO9660_FS is not set
 # CONFIG_JOLIET is not set
+# CONFIG_ZISOFS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_JFS_DEBUG is not set
+# CONFIG_JFS_STATISTICS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
@@ -515,7 +621,6 @@
 # CONFIG_ROMFS_FS is not set
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
-# CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
 # CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
@@ -525,11 +630,13 @@
 # Network File Systems
 #
 # CONFIG_CODA_FS is not set
+# CONFIG_INTERMEZZO_FS is not set
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
 CONFIG_ROOT_NFS=y
 # CONFIG_NFSD is not set
 # CONFIG_NFSD_V3 is not set
+# CONFIG_NFSD_TCP is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
 # CONFIG_SMB_FS is not set
@@ -542,6 +649,7 @@
 # CONFIG_NCPFS_SMALLDOS is not set
 # CONFIG_NCPFS_NLS is not set
 # CONFIG_NCPFS_EXTRAS is not set
+# CONFIG_ZISOFS_FS is not set

 #
 # Partition Types
@@ -562,8 +670,18 @@
 # CONFIG_USB is not set

 #
+# Bluetooth support
+#
+# CONFIG_BLUEZ is not set
+
+#
+# Library routines
+#
+# CONFIG_ZLIB_INFLATE is not set
+# CONFIG_ZLIB_DEFLATE is not set
+
+#
 # Kernel hacking
 #
-# CONFIG_MAGIC_SYSRQ is not set
-# CONFIG_KGDB is not set
-# CONFIG_XMON is not set
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SERIAL_TEXT_DEBUG is not set
===== arch/ppc/kernel/gen550_dbg.c 1.1 vs edited =====
--- 1.1/arch/ppc/kernel/gen550_dbg.c	Thu Feb 27 02:45:30 2003
+++ edited/arch/ppc/kernel/gen550_dbg.c	Thu Apr  3 17:07:33 2003
@@ -129,6 +129,7 @@
 gen550_init(int i, struct serial_struct *serial_req)
 {
 	rs_table[i].io_type = serial_req->io_type;
+	rs_table[i].port = serial_req->port;
 	rs_table[i].iomem_base = serial_req->iomem_base;
 	rs_table[i].iomem_reg_shift = serial_req->iomem_reg_shift;
 }
===== arch/ppc/platforms/pcore_setup.c 1.22 vs edited =====
--- 1.22/arch/ppc/platforms/pcore_setup.c	Fri Aug 23 21:53:39 2002
+++ edited/arch/ppc/platforms/pcore_setup.c	Fri Apr  4 17:16:50 2003
@@ -29,6 +29,8 @@
 #include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/ide.h>
+#include <linux/serial.h>
+#include <linux/serialP.h>

 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -41,6 +43,7 @@
 #include <asm/mpc10x.h>
 #include <asm/todc.h>
 #include <asm/bootinfo.h>
+#include <asm/serial.h>

 #include "pcore.h"

@@ -49,6 +52,9 @@

 static int board_type;

+extern void gen550_progress(char *, unsigned short);
+extern void gen550_init(int, struct serial_struct *);
+
 /* Dummy variable to satisfy mpc10x_common.o */
 void *OpenPIC_Addr;

@@ -107,9 +113,43 @@
 	return 0;
 }

+#ifdef CONFIG_SERIAL
+extern struct serial_state rs_table[];
+
+static void __init
+pcore_early_serial_map(void)
+{
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
+}
+#endif
+
 static void __init
 pcore_setup_arch(void)
 {
+	unsigned long	l2cr;
+
 	/* init to some ~sane value until calibrate_delay() runs */
 	loops_per_jiffy = 50000000/HZ;

@@ -131,7 +171,10 @@
 	conswitchp = &dummy_con;
 #endif

-		 printk("Force PCore port (C) 2001 MontaVista Software, Inc. (source@mvista.com)\n");
+	 printk("Force PCore port (C) 2001 MontaVista Software, Inc. (source@mvista.com)\n");
+
+	 l2cr = _get_L2CR();
+	 _set_L2CR(L2CR_L2E | l2cr);
 }

 static void
@@ -248,4 +291,14 @@

 	ppc_md.nvram_read_val	= todc_m48txx_read_val;
 	ppc_md.nvram_write_val	= todc_m48txx_write_val;
+
+#if defined(CONFIG_SERIAL) && (defined(CONFIG_SERIAL_TEXT_DEBUG) \
+		|| defined(CONFIG_KGDB))
+	pcore_early_serial_map();
+
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	pcore_set_bat();
+	ppc_md.progress = gen550_progress;
+#endif /* CONFIG_SERIAL_TEXT_DEBUG */
+#endif
 }

--------------060900000903080307080304--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
