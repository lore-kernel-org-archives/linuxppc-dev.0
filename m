Message-ID: <3E483EE2.4080100@mvista.com>
Date: Mon, 10 Feb 2003 17:08:02 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4devel KGDB patch for Sandpoint
Content-Type: multipart/mixed;
 boundary="------------070200060507070309090800"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------070200060507070309090800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

If no one objects to the attached patch, please apply it to get KGDB
working on the sandpoint.

Thanks,

Mark
--

--------------070200060507070309090800
Content-Type: text/plain;
 name="sandpoint.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sandpoint.patch"

===== arch/ppc/config.in 1.167 vs edited =====
--- 1.167/arch/ppc/config.in	Sat Feb  8 11:34:15 2003
+++ edited/arch/ppc/config.in	Mon Feb 10 15:40:10 2003
@@ -222,6 +222,7 @@

 if [ "$CONFIG_SANDPOINT_X3" = "y" ]; then
   define_bool CONFIG_EPIC_SERIAL_MODE y
+  define_bool CONFIG_GEN550 y
 fi

 if [ "$CONFIG_SPRUCE" = "y" ]; then
===== arch/ppc/configs/sandpoint_defconfig 1.8 vs edited =====
--- 1.8/arch/ppc/configs/sandpoint_defconfig	Mon Jun  3 13:20:31 2002
+++ edited/arch/ppc/configs/sandpoint_defconfig	Mon Feb 10 15:55:30 2003
@@ -49,16 +49,19 @@
 CONFIG_SANDPOINT=y
 # CONFIG_ADIR is not set
 # CONFIG_K2 is not set
+# CONFIG_PAL4 is not set
 # CONFIG_GEMINI is not set
 # CONFIG_ZX4500 is not set
 # CONFIG_MPC10X_STORE_GATHERING is not set
 CONFIG_SANDPOINT_X3=y
 CONFIG_EPIC_SERIAL_MODE=y
+CONFIG_GEN550=y
 # CONFIG_SMP is not set
 CONFIG_ALTIVEC=y
 CONFIG_TAU=y
 # CONFIG_TAU_INT is not set
 # CONFIG_TAU_AVERAGE is not set
+CONFIG_PPC_ISATIMER=y

 #
 # General setup
@@ -115,6 +118,7 @@
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BLK_STATS is not set

 #
 # Multi-device support (RAID and LVM)
@@ -203,15 +207,6 @@
 CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_IDEDISK_MULTI_MODE is not set
 # CONFIG_IDEDISK_STROKE is not set
-# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
-# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
-# CONFIG_BLK_DEV_IDEDISK_IBM is not set
-# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
-# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
-# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
-# CONFIG_BLK_DEV_IDEDISK_WD is not set
-# CONFIG_BLK_DEV_COMMERIAL is not set
-# CONFIG_BLK_DEV_TIVO is not set
 # CONFIG_BLK_DEV_IDECS is not set
 CONFIG_BLK_DEV_IDECD=y
 # CONFIG_BLK_DEV_IDETAPE is not set
@@ -225,8 +220,8 @@
 # CONFIG_BLK_DEV_CMD640 is not set
 # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
 # CONFIG_BLK_DEV_ISAPNP is not set
-# CONFIG_BLK_DEV_RZ1000 is not set
 CONFIG_BLK_DEV_IDEPCI=y
+# CONFIG_BLK_DEV_GENERIC is not set
 CONFIG_IDEPCI_SHARE_IRQ=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
@@ -235,28 +230,31 @@
 # CONFIG_IDEDMA_ONLYDISK is not set
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_PCI_WIP is not set
-# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
-# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
-# CONFIG_AEC62XX_TUNING is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_WDC_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
 # CONFIG_AMD74XX_OVERRIDE is not set
 CONFIG_BLK_DEV_CMD64X=y
-# CONFIG_BLK_DEV_CMD680 is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
 # CONFIG_BLK_DEV_CY82C693 is not set
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_HPT34X_AUTODMA is not set
 # CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_NFORCE is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
-CONFIG_BLK_DEV_PDC202XX=y
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
 # CONFIG_PDC202XX_BURST is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_PDC202XX_FORCE is not set
+# CONFIG_BLK_DEV_RZ1000 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
 # CONFIG_BLK_DEV_SIS5513 is not set
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
@@ -270,6 +268,7 @@
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
+# CONFIG_BLK_DEV_ATARAID_SII is not set

 #
 # SCSI support
@@ -353,6 +352,7 @@
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_T128 is not set
 # CONFIG_SCSI_U14_34F is not set
+# CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set

 #
@@ -414,17 +414,18 @@
 # CONFIG_NET_ISA is not set
 CONFIG_NET_PCI=y
 CONFIG_PCNET32=y
+# CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_APRICOT is not set
 # CONFIG_CS89x0 is not set
 CONFIG_TULIP=y
-# CONFIG_TC35815 is not set
 # CONFIG_TULIP_MWI is not set
 # CONFIG_TULIP_MMIO is not set
 CONFIG_DE4X5=y
 # CONFIG_DGRS is not set
 # CONFIG_DM9102 is not set
 CONFIG_EEPRO100=y
+# CONFIG_E100 is not set
 # CONFIG_LNE390 is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
@@ -436,11 +437,13 @@
 # CONFIG_8139TOO_PIO is not set
 # CONFIG_8139TOO_TUNE_TWISTER is not set
 # CONFIG_8139TOO_8129 is not set
-# CONFIG_8139_NEW_RX_RESET is not set
+# CONFIG_8139_OLD_RX_RESET is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
+# CONFIG_SUNDANCE_MMIO is not set
 # CONFIG_TLAN is not set
+# CONFIG_TC35815 is not set
 # CONFIG_VIA_RHINE is not set
 # CONFIG_VIA_RHINE_MMIO is not set
 # CONFIG_WINBOND_840 is not set
@@ -451,10 +454,12 @@
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
 # CONFIG_TIGON3 is not set
 # CONFIG_FDDI is not set
@@ -559,11 +564,18 @@
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
+# CONFIG_SCx200_GPIO is not set
+# CONFIG_AMD_PM768 is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
 # CONFIG_DTLK is not set
@@ -595,6 +607,8 @@
 # CONFIG_ADFS_FS_RW is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BEFS_DEBUG is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EXT3_FS is not set
 # CONFIG_JBD is not set
@@ -612,6 +626,9 @@
 # CONFIG_ISO9660_FS is not set
 # CONFIG_JOLIET is not set
 # CONFIG_ZISOFS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_JFS_DEBUG is not set
+# CONFIG_JFS_STATISTICS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
@@ -642,6 +659,7 @@
 CONFIG_ROOT_NFS=y
 # CONFIG_NFSD is not set
 # CONFIG_NFSD_V3 is not set
+# CONFIG_NFSD_TCP is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
 # CONFIG_SMB_FS is not set
@@ -655,7 +673,6 @@
 # CONFIG_NCPFS_NLS is not set
 # CONFIG_NCPFS_EXTRAS is not set
 # CONFIG_ZISOFS_FS is not set
-# CONFIG_ZLIB_FS_INFLATE is not set

 #
 # Partition Types
@@ -681,10 +698,13 @@
 # CONFIG_BLUEZ is not set

 #
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
-# CONFIG_BDI_SWITCH is not set
+# CONFIG_DEBUG_KERNEL is not set
 # CONFIG_SERIAL_TEXT_DEBUG is not set
===== arch/ppc/platforms/sandpoint_setup.c 1.31 vs edited =====
--- 1.31/arch/ppc/platforms/sandpoint_setup.c	Tue Jan  7 14:56:02 2003
+++ edited/arch/ppc/platforms/sandpoint_setup.c	Mon Feb 10 14:28:40 2003
@@ -73,6 +73,7 @@
 #include <linux/ide.h>
 #include <linux/irq.h>
 #include <linux/seq_file.h>
+#include <linux/serial.h>

 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -93,6 +94,7 @@
 #include <asm/pci-bridge.h>

 #include "sandpoint.h"
+#include "sandpoint_serial.h"

 extern int pckbd_setkeycode(unsigned int scancode, unsigned int keycode);
 extern int pckbd_getkeycode(unsigned int scancode);
@@ -103,6 +105,9 @@
 extern void pckbd_init_hw(void);
 extern unsigned char pckbd_sysrq_xlate[128];

+extern void gen550_progress(char *, unsigned short);
+extern void gen550_init(int, struct serial_struct *);
+
 unsigned char __res[sizeof(bd_t)];

 static void	sandpoint_halt(void);
@@ -129,6 +134,45 @@
 #endif
 };

+#ifdef CONFIG_SERIAL
+static void __init
+sandpoint_early_serial_map(void)
+{
+	struct serial_struct serial_req;
+
+	/* Setup serial port access */
+	memset(&serial_req, 0, sizeof(serial_req));
+	serial_req.baud_base = BASE_BAUD;
+	serial_req.line = 0;
+	serial_req.port = 0;
+	serial_req.irq = 4;
+	serial_req.flags = STD_COM_FLAGS;
+	serial_req.io_type = SERIAL_IO_MEM;
+	serial_req.iomem_base = (u_char *)SANDPOINT_SERIAL_0;
+	serial_req.iomem_reg_shift = 0;
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	gen550_init(0, &serial_req);
+#endif
+
+	if (early_serial_setup(&serial_req) != 0)
+		printk("Early serial init of port 0 failed\n");
+
+	/* Assume early_serial_setup() doesn't modify serial_req */
+	serial_req.line = 1;
+	serial_req.port = 1;
+	serial_req.irq = 3; /* XXXX */
+	serial_req.iomem_base = (u_char *)SANDPOINT_SERIAL_1;
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	gen550_init(1, &serial_req);
+#endif
+
+	if (early_serial_setup(&serial_req) != 0)
+		printk("Early serial init of port 1 failed\n");
+}
+#endif
+
 static void __init
 sandpoint_setup_arch(void)
 {
@@ -148,6 +192,10 @@
 	/* Lookup PCI host bridges */
 	sandpoint_find_bridges();

+#ifdef CONFIG_SERIAL
+	sandpoint_early_serial_map();
+#endif
+
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
@@ -533,44 +581,6 @@
 			: "=r" (bat3u), "=r" (bat3l));
 }

-#ifdef CONFIG_SERIAL_TEXT_DEBUG
-#include <linux/serial.h>
-#include <linux/serialP.h>
-#include <linux/serial_reg.h>
-#include <asm/serial.h>
-
-static struct serial_state rs_table[RS_TABLE_SIZE] = {
-	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
-};
-
-volatile unsigned char *com_port;
-volatile unsigned char *com_port_lsr;
-
-static void
-serial_writechar(char c)
-{
-	while ((*com_port_lsr & UART_LSR_THRE) == 0)
-		;
-	*com_port = c;
-}
-
-void
-sandpoint_progress(char *s, unsigned short hex)
-{
-	volatile char c;
-
-	com_port = (volatile unsigned char *) rs_table[0].port;
-	com_port_lsr = com_port + UART_LSR;
-
-	while ((c = *s++) != 0)
-		serial_writechar(c);
-
-	/* Most messages don't have a newline in them */
-	serial_writechar('\n');
-	serial_writechar('\r');
-}
-#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
-
 TODC_ALLOC();

 void __init
@@ -638,8 +648,15 @@
 	ppc_md.nvram_read_val = todc_mc146818_read_val;
 	ppc_md.nvram_write_val = todc_mc146818_write_val;

-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.progress = sandpoint_progress;
+#if defined(CONFIG_SERIAL) && (defined(CONFIG_SERIAL_TEXT_DEBUG) \
+		|| defined(CONFIG_KGDB))
+	sandpoint_set_bat();
+	sandpoint_early_serial_map();
+
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	ppc_md.progress = gen550_progress;
+#endif /* CONFIG_SERIAL_TEXT_DEBUG */
+	ppc_md.early_serial_map = sandpoint_early_serial_map;
 #endif

 #ifdef CONFIG_VT

--------------070200060507070309090800--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
