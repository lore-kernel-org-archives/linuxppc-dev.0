Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BF9CBB72CC
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Sep 2011 00:20:20 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/21] tty/hvc/hvsi_lib: Updates for running under OPAL v2
Date: Sat, 10 Sep 2011 11:19:51 -0300
Message-Id: <1315664408-16797-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
References: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Experience shows that our hvsi negotiation timeouts were too short
under OPAL v2. This patch bumps them from 200ms to 500ms.

To limit the impact when the console is repeatedly opened/closed,
we also avoid re-negotiating an already opened & established
connection which typically happens when running init scripts
on the tty shared with the kernel console.

Finally, while touching hvsi, I added a comment explaining why we
limit our output packet size to 12 bytes.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/hvsi.h |    4 ++++
 drivers/tty/hvc/hvsi_lib.c      |   12 +++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/hvsi.h b/arch/powerpc/include/asm/hvsi.h
index d3f64f3..ca85d9d 100644
--- a/arch/powerpc/include/asm/hvsi.h
+++ b/arch/powerpc/include/asm/hvsi.h
@@ -19,6 +19,10 @@
 #define HVSI_TSDTR 0x01
 #define HVSI_TSCD  0x20
 
+/* Never send more than 12 bytes at once, that is 16 bytes
+ * with header, which is the max pHyp can swallow in one
+ * hcall.
+ */
 #define HVSI_MAX_OUTGOING_DATA 12
 #define HVSI_VERSION 1
 
diff --git a/drivers/tty/hvc/hvsi_lib.c b/drivers/tty/hvc/hvsi_lib.c
index bd9b098..08e3e90 100644
--- a/drivers/tty/hvc/hvsi_lib.c
+++ b/drivers/tty/hvc/hvsi_lib.c
@@ -316,10 +316,10 @@ void hvsilib_establish(struct hvsi_priv *pv)
 
 	pr_devel("HVSI@%x: Establishing...\n", pv->termno);
 
-	/* Try for up to 200ms, there can be a packet to
+	/* Try for up to 500ms, there can be a packet to
 	 * start the process waiting for us...
 	 */
-	for (timeout = 0; timeout < 20; timeout++) {
+	for (timeout = 0; timeout < 50; timeout++) {
 		if (pv->established)
 			goto established;
 		if (!hvsi_get_packet(pv))
@@ -341,8 +341,8 @@ void hvsilib_establish(struct hvsi_priv *pv)
 
 	pr_devel("HVSI@%x:   ... waiting handshake\n", pv->termno);
 
-	/* Try for up to 200s */
-	for (timeout = 0; timeout < 20; timeout++) {
+	/* Try for up to 500ms */
+	for (timeout = 0; timeout < 50; timeout++) {
 		if (pv->established)
 			goto established;
 		if (!hvsi_get_packet(pv))
@@ -379,7 +379,9 @@ int hvsilib_open(struct hvsi_priv *pv, struct hvc_struct *hp)
 	/* Keep track of the tty data structure */
 	pv->tty = tty_kref_get(hp->tty);
 
-	hvsilib_establish(pv);
+	WARN_ON(pv->opened && !pv->is_console);
+	if (!pv->opened)
+		hvsilib_establish(pv);
 
 	return 0;
 }
-- 
1.7.4.1
