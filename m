Message-ID: <3E4D2E56.9010602@mvista.com>
Date: Fri, 14 Feb 2003 10:58:46 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel patch for ev64260
Content-Type: multipart/mixed;
 boundary="------------040106000208000003000807"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040106000208000003000807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch contains some minor fixups for the ev64260 port.

Please apply this patch if there are no objections.

Thanks,

Mark

--------------040106000208000003000807
Content-Type: text/plain; name="ev64260.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ev64260.patch"

===== arch/ppc/configs/ev64260_defconfig 1.10 vs edited =====
--- 1.10/arch/ppc/configs/ev64260_defconfig	Tue Jan 14 09:08:28 2003
+++ edited/arch/ppc/configs/ev64260_defconfig	Thu Feb 13 17:49:59 2003
@@ -107,6 +107,7 @@
 # CONFIG_MTD_PARTITIONS is not set
 # CONFIG_MTD_CONCAT is not set
 # CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set

 #
 # User Modules And Translation Layers
@@ -125,6 +126,7 @@
 # CONFIG_MTD_CFI_ADV_OPTIONS is not set
 CONFIG_MTD_CFI_INTELEXT=y
 # CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
@@ -141,6 +143,7 @@
 CONFIG_MTD_PHYSMAP_LEN=02000000
 CONFIG_MTD_PHYSMAP_BUSWIDTH=4
 # CONFIG_MTD_PCI is not set
+# CONFIG_MTD_PCMCIA is not set

 #
 # Self-contained MTD device drivers
@@ -340,6 +343,7 @@
 CONFIG_GT64260_ETH=y
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_APRICOT is not set
 # CONFIG_CS89x0 is not set
@@ -490,6 +494,11 @@
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
===== arch/ppc/platforms/ev64260_setup.c 1.17 vs edited =====
--- 1.17/arch/ppc/platforms/ev64260_setup.c	Tue Jan 14 09:14:54 2003
+++ edited/arch/ppc/platforms/ev64260_setup.c	Thu Feb 13 16:29:31 2003
@@ -21,6 +21,8 @@
  * Note: I have not been able to get *all* PCI slots to work reliably
  *	at 66 MHz.  I recommend setting jumpers J15 & J16 to short pins 1&2
  *	so that 33 MHz is used. --MAG
+ * Note: The 750CXe and 7450 are not stable with a 125MHz or 133MHz TCLK/SYSCLK.
+ * 	At 100MHz, they are solid.
  */
 #include <linux/config.h>

@@ -75,18 +77,8 @@
 	if (ppcboot_bd_valid) {
 		speed = ppcboot_bd.bi_busfreq;
 	}
-	else switch (PVR_VER(mfspr(PVR))) {
-		case PVR_VER(PVR_750):
-			speed = 100000000;
-			break;
-		case PVR_VER(PVR_7450):
-			speed = 125000000;
-			break;
-		default:
-			printk("Bus speed unknown for this processor module\n");
-			printk("Processor PVR_VER(pvr): 0x%x\n",
-							PVR_VER(mfspr(PVR)));
-			speed = 100000000;
+	else {
+		speed = 100000000; /* XXX Only 100MHz is stable */
 	}

 	return speed;
@@ -575,8 +567,7 @@
 	seq_printf(m, "vendor\t\t: " BOARD_VENDOR "\n");
 	seq_printf(m, "machine\t\t: " BOARD_MACHINE "\n");

-	seq_printf(m, "PVID\t\t: 0x%x, vendor: %s\n",
-			pvid,
+	seq_printf(m, "cpu vendor\t: %s\n",
 			((pvid & (1<<15)) || IS_PVR_750CX(pvid))
 			    ? "IBM" : "Motorola" );
 	seq_printf(m, "cpu MHz\t\t: %d\n", ev64260_get_cpu_speed()/1000/1000);
===== drivers/net/Makefile 1.47 vs edited =====
--- 1.47/drivers/net/Makefile	Wed Jan 29 07:41:56 2003
+++ edited/drivers/net/Makefile	Wed Feb 12 17:58:40 2003
@@ -147,7 +147,7 @@
 obj-$(CONFIG_LNE390) += lne390.o 8390.o
 obj-$(CONFIG_NE3210) += ne3210.o 8390.o
 obj-$(CONFIG_NET_SB1250_MAC) += sb1250-mac.o
-obj-$(CONFIG_GT64260_ETH) += gt64260_eth.o
+obj-$(CONFIG_GT64260_ETH) += gt64260_eth.o mii.o
 obj-$(CONFIG_NPNET) += npnet.o
 obj-$(CONFIG_ARCTIC_ENET) += arctic_enet.o 8390.o


--------------040106000208000003000807--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
