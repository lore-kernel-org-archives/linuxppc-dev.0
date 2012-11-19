Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 214492C009B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:43:00 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 323/493] tty: remove use of __devinitdata
Date: Mon, 19 Nov 2012 13:24:32 -0500
Message-Id: <1353349642-3677-323-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Alan Cox <alan@linux.intel.com> 
Cc: Peter Korsgaard <jacmet@sunsite.dk> 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: linux-serial@vger.kernel.org 
---
 drivers/tty/hvc/hvc_opal.c         | 2 +-
 drivers/tty/hvc/hvc_vio.c          | 2 +-
 drivers/tty/rocket.c               | 2 +-
 drivers/tty/serial/8250/8250_pci.c | 2 +-
 drivers/tty/serial/8250/8250_pnp.c | 2 +-
 drivers/tty/serial/of_serial.c     | 2 +-
 drivers/tty/serial/sirfsoc_uart.c  | 2 +-
 drivers/tty/serial/uartlite.c      | 2 +-
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 5ddd6f5..700fedf 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -41,7 +41,7 @@
 
 static const char hvc_opal_name[] = "hvc_opal";
 
-static struct of_device_id hvc_opal_match[] __devinitdata = {
+static struct of_device_id hvc_opal_match[] = {
 	{ .name = "serial", .compatible = "ibm,opal-console-raw" },
 	{ .name = "serial", .compatible = "ibm,opal-console-hvsi" },
 	{ },
diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index f7333e3..7f51156 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -53,7 +53,7 @@
 
 static const char hvc_driver_name[] = "hvc_console";
 
-static struct vio_device_id hvc_driver_table[] __devinitdata = {
+static struct vio_device_id hvc_driver_table[] = {
 	{"serial", "hvterm1"},
 #ifndef HVC_OLD_HVSI
 	{"serial", "hvterm-protocol"},
diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index 9700d34..02a53f1 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1757,7 +1757,7 @@ static void rp_flush_buffer(struct tty_struct *tty)
 
 #ifdef CONFIG_PCI
 
-static struct pci_device_id __devinitdata __used rocket_pci_ids[] = {
+static struct pci_device_id __used rocket_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_ANY_ID) },
 	{ }
 };
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index a5acb57..3252c5d 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1987,7 +1987,7 @@ enum pci_board_num_t {
  * see first lines of serial_in() and serial_out() in 8250.c
 */
 
-static struct pciserial_board pci_boards[] __devinitdata = {
+static struct pciserial_board pci_boards[] = {
 	[pbn_default] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 1,
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 2b8a6ac..71daae9 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -370,7 +370,7 @@ static const struct pnp_device_id pnp_dev_table[] = {
 
 MODULE_DEVICE_TABLE(pnp, pnp_dev_table);
 
-static char *modem_names[] __devinitdata = {
+static char *modem_names[] = {
 	"MODEM", "Modem", "modem", "FAX", "Fax", "fax",
 	"56K", "56k", "K56", "33.6", "28.8", "14.4",
 	"33,600", "28,800", "14,400", "33.600", "28.800", "14.400",
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 1bce344..e7cae1c 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -231,7 +231,7 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 /*
  * A few common types, add more as needed.
  */
-static struct of_device_id __devinitdata of_platform_serial_table[] = {
+static struct of_device_id of_platform_serial_table[] = {
 	{ .compatible = "ns8250",   .data = (void *)PORT_8250, },
 	{ .compatible = "ns16450",  .data = (void *)PORT_16450, },
 	{ .compatible = "ns16550a", .data = (void *)PORT_16550A, },
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 4984984..5da5cb9 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -727,7 +727,7 @@ static int sirfsoc_uart_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id sirfsoc_uart_ids[] __devinitdata = {
+static struct of_device_id sirfsoc_uart_ids[] = {
 	{ .compatible = "sirf,prima2-uart", },
 	{}
 };
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index df9eeb4..2d20b01 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -562,7 +562,7 @@ static int __devexit ulite_release(struct device *dev)
 
 #if defined(CONFIG_OF)
 /* Match table for of_platform binding */
-static struct of_device_id ulite_of_match[] __devinitdata = {
+static struct of_device_id ulite_of_match[] = {
 	{ .compatible = "xlnx,opb-uartlite-1.00.b", },
 	{ .compatible = "xlnx,xps-uartlite-1.00.a", },
 	{}
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 6e9ce65..4e6380a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1046,7 +1046,7 @@ static int xuartps_resume(struct platform_device *pdev)
 /* Match table for of_platform binding */
 
 #ifdef CONFIG_OF
-static struct of_device_id xuartps_of_match[] __devinitdata = {
+static struct of_device_id xuartps_of_match[] = {
 	{ .compatible = "xlnx,xuartps", },
 	{}
 };
-- 
1.8.0
