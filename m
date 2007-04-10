Return-Path: <marny@rambler.ru>
Received: from ns.tz.ru (ns.tz.ru [194.149.234.1])
	by ozlabs.org (Postfix) with ESMTP id 1A2A5DDEEB
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 17:32:02 +1000 (EST)
Date: Tue, 10 Apr 2007 11:31:57 +0400
From: Igor Marnat <marny@rambler.ru>
Message-ID: <4459387031.20070410113157@rambler.ru>
To: glikely@gmail.com, "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re[2]: [PATCH] ppchameleon_early_serial_map hidden under #ifdef
	CONFIG_SERIAL_8250
In-Reply-To: <528646bc0704041012v5cd1fd05pa9ca88d05b7e031b@mail.gmail.com>
References: <05625250.20070403092134@rambler.ru>
	<528646bc0704022305s307c299hcdab589fa7e1776b@mail.gmail.com>
	<15978422796.20070404115813@rambler.ru>
	<528646bc0704041012v5cd1fd05pa9ca88d05b7e031b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Reply-To: Igor Marnat <marny@rambler.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello!

>> GL> This is just ugly, but not because of your patch.  External function
>> GL> prototypes that aren't pulled from header files can lead to all kinds
>> GL> of wierdness.  Since the code is already ugly and dangerous, I
>> GL> wouldn't even bother with adding the #ifdef around it.

I changed the patch as you recommended. You were correct, external
declarations are of no use there. At least kernel gets built
successfully both with and without CONFIG_SERIAL_8250 with the patch
applied. Hope it will suit better.


Author: Igor Marnat <marny@rambler.ru>
Date:   Tue Apr 10 11:16:35 2007 +0400

    ppchameleon_early_serial_map hidden under #ifdef CONFIG_SERIAL_8250,
    "extern void gen550_init" and  "extern int early_serial_setup" declarations removed
    since they are already included in header files

    Signed-off-by: Igor Marnat <marny@rambler.ru>

diff --git a/arch/ppc/platforms/4xx/ppchameleon.c b/arch/ppc/platforms/4xx/ppchameleon.c
index 6d8b7ad..f3cf7ec 100644
--- a/arch/ppc/platforms/4xx/ppchameleon.c
+++ b/arch/ppc/platforms/4xx/ppchameleon.c
@@ -44,9 +44,6 @@

 void *ppchameleon_rtc_base;

-extern void gen550_init(int, struct uart_port *);
-extern int early_serial_setup(struct uart_port *port);
-
 /* Some IRQs unique to the board
  * Used by the generic 405 PCI setup functions in ppc4xx_pci.c
  */
@@ -75,6 +72,7 @@ ppc405_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
  * Calculate the proper input baud rate and setup the serial driver.
  */

+#ifdef CONFIG_SERIAL_8250
 static void __init
 ppchameleon_early_serial_map (void)
 {
@@ -105,7 +103,9 @@ ppchameleon_early_serial_map (void)
                printk ("Early serial init of port 0 failed\n");
        }
 }
-
+#else /* CONFIG_SERIAL_8250 */
+#define ppchameleon_early_serial_map()
+#endif /* CONFIG_SERIAL_8250 */

 void __init board_setup_arch (void)
 {



Best regards,
Igor Marnat
mailto:marny@rambler.ru
