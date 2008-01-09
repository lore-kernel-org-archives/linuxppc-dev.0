Return-Path: <b04825@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 56FA8DDF36
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 10:35:17 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] [POWERPC] qe: add support for Freescale QUICCEngine UART
Date: Wed,  9 Jan 2008 17:35:05 -0600
Message-Id: <11999217072674-git-send-email-timur@freescale.com>
In-Reply-To: <11999217062265-git-send-email-timur@freescale.com>
References: <11999217062265-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add support for UART serial ports using a Freescale QUICCEngine. Update
booting-without-of.txt to define new properties for a QE UART node.  Update
the MPC8323E-MDS device tree to add UCC5 as a UART.  Update the QE library
to support slow UCC devices and modules.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |    9 ++++-
 arch/powerpc/boot/dts/mpc832x_mds.dts        |   50 ++++++++++++++++++++++++++
 arch/powerpc/sysdev/qe_lib/Kconfig           |    2 +-
 arch/powerpc/sysdev/qe_lib/ucc_slow.c        |   10 +++++-
 4 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 53c2295..7ad221f 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1619,7 +1619,7 @@ platforms are moved over to use the flattened-device-tree model.
 
    Required properties:
    - device_type : should be "network", "hldc", "uart", "transparent"
-    "bisync" or "atm".
+     "bisync", "atm", or "serial".
    - compatible : could be "ucc_geth" or "fsl_atm" and so on.
    - model : should be "UCC".
    - device-id : the ucc number(1-8), corresponding to UCCx in UM.
@@ -1632,6 +1632,13 @@ platforms are moved over to use the flattened-device-tree model.
    - interrupt-parent : the phandle for the interrupt controller that
      services interrupts for this device.
    - pio-handle : The phandle for the Parallel I/O port configuration.
+   - port-number : for UART drivers, the port number to use, between 0 and 3.
+     This usually corresponds to the /dev/ttyQE device, e.g. <0> = /dev/ttyQE0.
+     The port number is added to the minor number of the device.  Unlike the
+     CPM UART driver, the port-number is required for the QE UART driver.
+   - soft-uart : for UART drivers, if specified this means the QE UART device
+     driver should use "Soft-UART" mode, which is needed on some SOCs that have
+     broken UART hardware.  Soft-UART is provided via a microcode upload.
    - rx-clock-name: the UCC receive clock source
      "none": clock source is disabled
      "brg1" through "brg16": clock source is BRG1-BRG16, respectively
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 26ac467..758cd98 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -7,6 +7,18 @@
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
+
+ * To enable external serial I/O on a Freescale MPC 8323 SYS/MDS board, do
+ * this:
+ *
+ * 1) On chip U61, lift (disconnect) pins 21 (TXD) and 22 (RXD) from the board.
+ * 2) Solder a wire from U61-21 to P19A-23.  P19 is a grid of pins on the board
+ *    next to the serial ports.
+ * 3) Solder a wire from U61-22 to P19K-22.
+ *
+ * Note that there's a typo in the schematic.  The board labels the last column
+ * of pins "P19K", but in the schematic, that column is called "P19J".  So if
+ * you're going by the schematic, the pin is called "P19J-K22".
  */
 
 / {
@@ -169,6 +181,23 @@
 					1 1e  1  0  1  0 	/* TX_EN */
 					1 1f  2  0  1  0>;/* CRS */
 			};
+			pio5: ucc_pin@05 {
+				pio-map = <
+				/*
+				 *    		      open       has
+				 *   port  pin  dir  drain  sel  irq
+				 */
+					2    0    1      0    2    0  /* TxD5 */
+					2    8    2      0    2    0  /* RxD5 */
+
+					2   1d    2      0    0    0  /* CTS5 */
+					2   1f    1      0    2    0  /* RTS5 */
+
+					2   18    2      0    0    0  /* CD */
+
+				>;
+			};
+
 		};
 	};
 
@@ -176,6 +205,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "qe";
+		compatible = "fsl,qe";
 		model = "QE";
 		ranges = <0 e0100000 00100000>;
 		reg = <e0100000 480>;
@@ -250,6 +280,26 @@
 			pio-handle = < &pio4 >;
 		};
 
+		ucc@2400 {
+			device_type = "serial";
+			compatible = "ucc_uart";
+			model = "UCC";
+			device-id = <5>;	/* The UCC number, 1-7*/
+			port-number = <0>;	/* Which ttyQEx device */
+			soft-uart;		/* We need Soft-UART */
+			reg = <2400 200>;
+			interrupts = <28>;	/* From Table 18-12 */
+			interrupt-parent = < &qeic >;
+			/*
+			 * For Soft-UART, we need to set TX to 1X, which
+			 * means specifying separate clock sources.
+			 */
+			rx-clock-name = "brg5";
+			tx-clock-name = "brg6";
+			pio-handle = < &pio5 >;
+		};
+
+
 		mdio@2320 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
index f611d34..adc6621 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -4,7 +4,7 @@
 
 config UCC_SLOW
 	bool
-	default n
+	default y if SERIAL_QE
 	help
 	  This option provides qe_lib support to UCC slow
 	  protocols: UART, BISYNC, QMC
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
index 0174b3a..b2870b2 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -19,6 +19,7 @@
 #include <linux/stddef.h>
 #include <linux/interrupt.h>
 #include <linux/err.h>
+#include <linux/module.h>
 
 #include <asm/io.h>
 #include <asm/immap_qe.h>
@@ -41,6 +42,7 @@ u32 ucc_slow_get_qe_cr_subblock(int uccs_num)
 	default: return QE_CR_SUBBLOCK_INVALID;
 	}
 }
+EXPORT_SYMBOL(ucc_slow_get_qe_cr_subblock);
 
 void ucc_slow_poll_transmitter_now(struct ucc_slow_private * uccs)
 {
@@ -56,6 +58,7 @@ void ucc_slow_graceful_stop_tx(struct ucc_slow_private * uccs)
 	qe_issue_cmd(QE_GRACEFUL_STOP_TX, id,
 			 QE_CR_PROTOCOL_UNSPECIFIED, 0);
 }
+EXPORT_SYMBOL(ucc_slow_graceful_stop_tx);
 
 void ucc_slow_stop_tx(struct ucc_slow_private * uccs)
 {
@@ -65,6 +68,7 @@ void ucc_slow_stop_tx(struct ucc_slow_private * uccs)
 	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
 	qe_issue_cmd(QE_STOP_TX, id, QE_CR_PROTOCOL_UNSPECIFIED, 0);
 }
+EXPORT_SYMBOL(ucc_slow_stop_tx);
 
 void ucc_slow_restart_tx(struct ucc_slow_private * uccs)
 {
@@ -74,6 +78,7 @@ void ucc_slow_restart_tx(struct ucc_slow_private * uccs)
 	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
 	qe_issue_cmd(QE_RESTART_TX, id, QE_CR_PROTOCOL_UNSPECIFIED, 0);
 }
+EXPORT_SYMBOL(ucc_slow_restart_tx);
 
 void ucc_slow_enable(struct ucc_slow_private * uccs, enum comm_dir mode)
 {
@@ -94,6 +99,7 @@ void ucc_slow_enable(struct ucc_slow_private * uccs, enum comm_dir mode)
 	}
 	out_be32(&us_regs->gumr_l, gumr_l);
 }
+EXPORT_SYMBOL(ucc_slow_enable);
 
 void ucc_slow_disable(struct ucc_slow_private * uccs, enum comm_dir mode)
 {
@@ -114,6 +120,7 @@ void ucc_slow_disable(struct ucc_slow_private * uccs, enum comm_dir mode)
 	}
 	out_be32(&us_regs->gumr_l, gumr_l);
 }
+EXPORT_SYMBOL(ucc_slow_disable);
 
 /* Initialize the UCC for Slow operations
  *
@@ -347,6 +354,7 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	*uccs_ret = uccs;
 	return 0;
 }
+EXPORT_SYMBOL(ucc_slow_init);
 
 void ucc_slow_free(struct ucc_slow_private * uccs)
 {
@@ -366,5 +374,5 @@ void ucc_slow_free(struct ucc_slow_private * uccs)
 
 	kfree(uccs);
 }
-
+EXPORT_SYMBOL(ucc_slow_free);
 
-- 
1.5.2.4
