Return-Path: <ml@stefan-roese.de>
Received: from server5.sohosted.com (www.sohosted5.com [193.138.249.49])
	by ozlabs.org (Postfix) with ESMTP id 8956367B8B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Nov 2006 22:14:28 +1100 (EST)
From: Stefan Roese <ml@stefan-roese.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx systems
Date: Mon, 20 Nov 2006 12:00:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200611201200.36780.ml@stefan-roese.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch fixes a problem seen on multiple 4xx platforms, where
the UART0 interrupt number is 0. The macro "is_real_interrupt" lead
on those systems to not use an real interrupt but the timer based
implementation.

This problem was detected and fixed by
Charles Gales <cgales@amcc.com> and John Baxter <jbaxter@amcc.com>
from AMCC.

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit f83094acd3258575c9a5cdb1d65e241c16eff03a
tree 72582c5eeb2a9c8ea57287616d51e42fff8ed641
parent f56f68c4e1977f0e884a304af4c617bed4909417
author Stefan Roese <sr@denx.de> Sat, 18 Nov 2006 10:28:50 +0100
committer Stefan Roese <sr@denx.de> Sat, 18 Nov 2006 10:28:50 +0100

 drivers/serial/8250.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index e34bd03..a51679e 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -76,8 +76,14 @@ static unsigned int nr_uarts = CONFIG_SE
  * We default to IRQ0 for the "no irq" hack.   Some
  * machine types want others as well - they're free
  * to redefine this in their header file.
+ * NOTE:  Some PPC4xx use IRQ0 for a UART Interrupt, so
+ * we will assume that the IRQ is always real
  */
+#ifdef CONFIG_4xx
+#define is_real_interrupt(irq)	(1)
+#else
 #define is_real_interrupt(irq)	((irq) != 0)
+#endif

 #ifdef CONFIG_SERIAL_8250_DETECT_IRQ
 #define CONFIG_SERIAL_DETECT_IRQ 1
