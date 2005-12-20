Return-Path: <tnt@246tNt.com>
Received: from outmx016.isp.belgacom.be (outmx016.isp.belgacom.be
	[195.238.2.115])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19934689AF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 07:41:40 +1100 (EST)
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
	by outmx016.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id jBKKfTO9021937
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Dec 2005 21:41:30 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <3.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
In-Reply-To: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
References: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
Date: Tue, 20 Dec 2005 21:41:32 +0100 (CET)
Cc: Tom Rini <trini@kernel.crashing.org>, Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 3/9] ppc32/serial: Change mpc52xx_uart.c to use the Low
	Density Serial port major
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32/serial: Change mpc52xx_uart.c to use the Low Density Serial port major

Before this patch we were just using the "classic" /dev/ttySx devices.
However when another on the system is loaded that uses those (like drivers
for serial PCMCIA), that creates a conflict for the minors. Therefore, we
now use /dev/ttyPSC[0:5] (note the 0-based numbering !) with some minors
we've been assigned in the "Low Density Serial port major"

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

---
commit 1661f915e8bd58e52fe3326e038efe74068702e0
tree 04215b96380f2d7d218a223d837b9eabe2f120f4
parent c83b03a94291bdd952c6b1b20ab15981456e8625
author Sylvain Munaut <tnt@246tNt.com> Sat, 17 Dec 2005 23:21:16 +0100
committer Sylvain Munaut <tnt@246tNt.com> Sat, 17 Dec 2005 23:21:16 +0100

 drivers/serial/mpc52xx_uart.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 4dcf031..1288d62 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -37,11 +37,11 @@
  * by the bootloader or in the platform init code.
  *
  * The idx field must be equal to the PSC index ( e.g. 0 for PSC1, 1 for PSC2,
- * and so on). So the PSC1 is mapped to /dev/ttyS0, PSC2 to /dev/ttyS1 and so
- * on. But be warned, it's an ABSOLUTE REQUIREMENT ! This is needed mainly for
- * the console code : without this 1:1 mapping, at early boot time, when we are
- * parsing the kernel args console=ttyS?, we wouldn't know wich PSC it will be
- * mapped to.
+ * and so on). So the PSC1 is mapped to /dev/ttyPSC0, PSC2 to /dev/ttyPSC1 and
+ * so on. But be warned, it's an ABSOLUTE REQUIREMENT ! This is needed mainly
+ * fpr the console code : without this 1:1 mapping, at early boot time, when we
+ * are parsing the kernel args console=ttyPSC?, we wouldn't know wich PSC it
+ * will be mapped to.
  */
 
 #include <linux/config.h>
@@ -65,6 +65,10 @@
 #include <linux/serial_core.h>
 
 
+/* We've been assigned a range on the "Low-density serial ports" major */
+#define SERIAL_PSC_MAJOR	204
+#define SERIAL_PSC_MINOR	148
+
 
 #define ISR_PASS_LIMIT 256	/* Max number of iteration in the interrupt */
 
@@ -671,12 +675,12 @@ mpc52xx_console_setup(struct console *co
 static struct uart_driver mpc52xx_uart_driver;
 
 static struct console mpc52xx_console = {
-	.name	= "ttyS",
+	.name	= "ttyPSC",
 	.write	= mpc52xx_console_write,
 	.device	= uart_console_device,
 	.setup	= mpc52xx_console_setup,
 	.flags	= CON_PRINTBUFFER,
-	.index	= -1,	/* Specified on the cmdline (e.g. console=ttyS0 ) */
+	.index	= -1,	/* Specified on the cmdline (e.g. console=ttyPSC0 ) */
 	.data	= &mpc52xx_uart_driver,
 };
 
@@ -703,10 +707,10 @@ console_initcall(mpc52xx_console_init);
 static struct uart_driver mpc52xx_uart_driver = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "mpc52xx_psc_uart",
-	.dev_name	= "ttyS",
-	.devfs_name	= "ttyS",
-	.major		= TTY_MAJOR,
-	.minor		= 64,
+	.dev_name	= "ttyPSC",
+	.devfs_name	= "ttyPSC",
+	.major		= SERIAL_PSC_MAJOR,
+	.minor		= SERIAL_PSC_MINOR,
 	.nr		= MPC52xx_PSC_MAXNUM,
 	.cons		= MPC52xx_PSC_CONSOLE,
 };
