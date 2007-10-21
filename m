Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 5A5E3DDE24
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 09:03:55 +1000 (EST)
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQA00G4JAOXRLB0@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 21 Oct 2007 17:02:57 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQA006UEAOXQF40@pd2mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 21 Oct 2007 17:02:57 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQA009PGAOWA1J0@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 21 Oct 2007 17:02:56 -0600 (MDT)
Date: Sun, 21 Oct 2007 17:02:55 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Uartlite: speed up console output
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jacmet@sunsite.dk
Message-id: <20071021230255.7066.64565.stgit@trillian.cg.shawcable.net>
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

Change the wait_tx routine to call cpu_relax() instead of udelay() to
reduce console output latency and test for the TXFULL bit instead of
TXEMPTY.  That way the FIFO doesn't need to by 100% flushed before
writing the next character.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/serial/uartlite.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index dfef83f..a85f2d3 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -329,12 +329,14 @@ static struct uart_ops ulite_ops = {
 static void ulite_console_wait_tx(struct uart_port *port)
 {
 	int i;
+	u8 val;
 
-	/* wait up to 10ms for the character(s) to be sent */
-	for (i = 0; i < 10000; i++) {
-		if (readb(port->membase + ULITE_STATUS) & ULITE_STATUS_TXEMPTY)
+	/* Spin waiting for TX fifo to have space available */
+	for (i = 0; i < 100000; i++) {
+		val = readb(port->membase + ULITE_STATUS);
+		if ((val & ULITE_STATUS_TXFULL) == 0)
 			break;
-		udelay(1);
+		cpu_relax();
 	}
 }
 
