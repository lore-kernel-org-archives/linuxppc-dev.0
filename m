Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 796A2DDE0A
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 02:46:02 +1000 (EST)
Received: from pd4mr5so.prod.shaw.ca (pd4mr5so-qfe3.prod.shaw.ca [10.0.141.50])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPA0077KMKPMLD0@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 02 Oct 2007 10:46:01 -0600 (MDT)
Received: from pn2ml4so.prod.shaw.ca ([10.0.121.148])
	by pd4mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPA008JRMKGYF00@pd4mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Tue, 02 Oct 2007 10:45:57 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPA0048RMHSZPL0@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 02 Oct 2007 10:44:16 -0600 (MDT)
Date: Tue, 02 Oct 2007 10:44:15 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] Uartlite: Add macros for register names
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20071002164415.24562.44426.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Add macros to define register names to improve readability.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/uartlite.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/uartlite.c b/arch/powerpc/boot/uartlite.c
index f4249a7..38a470b 100644
--- a/arch/powerpc/boot/uartlite.c
+++ b/arch/powerpc/boot/uartlite.c
@@ -16,30 +16,45 @@
 #include "io.h"
 #include "ops.h"
 
+#define ULITE_RX		0x00
+#define ULITE_TX		0x04
+#define ULITE_STATUS		0x08
+#define ULITE_CONTROL		0x0c
+
+#define ULITE_STATUS_RXVALID	0x01
+#define ULITE_STATUS_TXFULL	0x08
+
+#define ULITE_CONTROL_RST_RX	0x02
+
 static void * reg_base;
 
 static int uartlite_open(void)
 {
 	/* Clear the RX FIFO */
-	out_be32(reg_base + 0x0C, 0x2);
+	out_be32(reg_base + ULITE_CONTROL, ULITE_CONTROL_RST_RX);
 	return 0;
 }
 
 static void uartlite_putc(unsigned char c)
 {
-	while ((in_be32(reg_base + 0x8) & 0x08) != 0); /* spin */
-	out_be32(reg_base + 0x4, c);
+	u32 reg = ULITE_STATUS_TXFULL;
+	while (reg & ULITE_STATUS_TXFULL) /* spin on TXFULL bit */
+		reg = in_be32(reg_base + ULITE_STATUS);
+	out_be32(reg_base + ULITE_TX, c);
 }
 
 static unsigned char uartlite_getc(void)
 {
-	while ((in_be32(reg_base + 0x8) & 0x01) == 0); /* spin */
-	return in_be32(reg_base);
+	u32 reg = ULITE_STATUS_RXVALID;
+	while (reg & ULITE_STATUS_RXVALID) /* spin on RXVALID bit */
+		reg = in_be32(reg_base + ULITE_STATUS);
+	return in_be32(reg_base + ULITE_RX);
 }
 
 static u8 uartlite_tstc(void)
 {
-	return ((in_be32(reg_base + 0x8) & 0x01) != 0);
+	u32 reg = in_be32(reg_base + ULITE_STATUS);
+	return reg & ULITE_STATUS_RXVALID;
 }
 
 int uartlite_console_init(void *devp, struct serial_console_data *scdp)
