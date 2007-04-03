Return-Path: <marny@rambler.ru>
Received: from ns.tz.ru (ns.tz.ru [194.149.234.1])
	by ozlabs.org (Postfix) with ESMTP id EACE2DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 15:51:18 +1000 (EST)
Received: from localhost (localhost.tz.ru [127.0.0.1])
	by ns.tz.ru (Postfix) with ESMTP id AAF033F4075
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 09:21:36 +0400 (MSD)
Received: from ns.tz.ru ([127.0.0.1])
	by localhost (ns.tz.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CQWtXjOij7zf for <linuxppc-dev@ozlabs.org>;
	Tue,  3 Apr 2007 09:21:35 +0400 (MSD)
Received: from marnat.intranet.tz.ru (static-85-90-97-192.inet.tz.ru
	[85.90.97.192]) by ns.tz.ru (Postfix) with ESMTP id 6CF233F4022
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 09:21:35 +0400 (MSD)
Date: Tue, 3 Apr 2007 09:21:34 +0400
From: Igor Marnat <marny@rambler.ru>
Message-ID: <05625250.20070403092134@rambler.ru>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppchameleon_early_serial_map hidden under #ifdef
	CONFIG_SERIAL_8250
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: Igor Marnat <marny@rambler.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello List!

Having selected PPChameleonEVB as a platform and having turned off
seral driver (CONFIG_SERIAL_8250 is not set) I got the following error
message during kernel compilation:

arch/ppc/platforms/4xx/built-in.o: In function `board_setup_arch':
: undefined reference to `early_serial_setup'


Perhaps the following patch will be ok?


Date: Tue, 3 Apr 2007 09:11:35 +0400
Subject: [PATCH] ppchameleon_early_serial_map hidden under #ifdef CONFIG_SERIAL_8250
Signed-off-by: Igor Marnat <marny@rambler.ru>
---
 arch/ppc/platforms/4xx/ppchameleon.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/platforms/4xx/ppchameleon.c b/arch/ppc/platforms/4xx/ppchameleon.c
index 6d8b7ad..159d4a6 100644
--- a/arch/ppc/platforms/4xx/ppchameleon.c
+++ b/arch/ppc/platforms/4xx/ppchameleon.c
@@ -45,7 +45,9 @@
 void *ppchameleon_rtc_base;

 extern void gen550_init(int, struct uart_port *);
+#ifdef CONFIG_SERIAL_8250
 extern int early_serial_setup(struct uart_port *port);
+#endif /* CONFIG_SERIAL_8250 */

 /* Some IRQs unique to the board
  * Used by the generic 405 PCI setup functions in ppc4xx_pci.c
@@ -75,6 +77,7 @@ ppc405_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
  * Calculate the proper input baud rate and setup the serial driver.
  */

+#ifdef CONFIG_SERIAL_8250
 static void __init
 ppchameleon_early_serial_map (void)
 {
@@ -105,7 +108,9 @@ ppchameleon_early_serial_map (void)
                printk ("Early serial init of port 0 failed\n");
        }
 }
-
+#else /* CONFIG_SERIAL_8250 */
+#define ppchameleon_early_serial_map()
+#endif /* CONFIG_SERIAL_8250 */

 void __init board_setup_arch (void)
 {
-- 

Best regards,
Igor Marnat
mailto:marny@rambler.ru
