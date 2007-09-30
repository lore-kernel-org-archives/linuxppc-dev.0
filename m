Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id E0ADFDDEBB
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 07:47:26 +1000 (EST)
Received: from pd2mr2so.prod.shaw.ca
	(pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP700KQ6B67OJ00@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 15:46:55 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd2mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP7004JWB67BL10@pd2mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 30 Sep 2007 15:46:56 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP7002CPB668UD0@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 15:46:55 -0600 (MDT)
Date: Sun, 30 Sep 2007 15:46:55 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/3] Uartlite: Flush RX fifo in bootwrapper
In-reply-to: <20070930214140.31899.55951.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20070930214654.31899.25457.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070930214140.31899.55951.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Flush the uartlite RX fifo so that characters typed before entry into
the zImage wrapper do not muck up the kernel command line.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/ppc/boot/simple/misc-embedded.c |    4 +++-
 arch/ppc/boot/simple/uartlite_tty.c  |    8 ++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/boot/simple/misc-embedded.c b/arch/ppc/boot/simple/misc-embedded.c
index 8a08ad3..d5a00eb 100644
--- a/arch/ppc/boot/simple/misc-embedded.c
+++ b/arch/ppc/boot/simple/misc-embedded.c
@@ -89,7 +89,9 @@ load_kernel(unsigned long load_addr, int num_words, unsigned long cksum, bd_t *b
 	 * initialize the serial console port.
 	 */
 	embed_config(&bp);
-#if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE)
+#if defined(CONFIG_SERIAL_CPM_CONSOLE) || \
+    defined(CONFIG_SERIAL_8250_CONSOLE) || \
+    defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 	com_port = serial_init(0, bp);
 #endif
 
diff --git a/arch/ppc/boot/simple/uartlite_tty.c b/arch/ppc/boot/simple/uartlite_tty.c
index 0eae1ea..ca1743e 100644
--- a/arch/ppc/boot/simple/uartlite_tty.c
+++ b/arch/ppc/boot/simple/uartlite_tty.c
@@ -16,6 +16,14 @@
 
 #define UARTLITE_BASEADDR ((void*)(XPAR_UARTLITE_0_BASEADDR))
 
+unsigned long
+serial_init(int chan, void *ignored)
+{
+	/* Clear the RX FIFO */
+	out_be32(UARTLITE_BASEADDR + 0x0C, 0x2);
+	return 0;
+}
+
 void
 serial_putc(unsigned long com_port, unsigned char c)
 {
