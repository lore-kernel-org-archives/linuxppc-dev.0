Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E25CB6F00
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Jul 2011 13:14:00 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p613BRD2006271
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2011 22:11:37 -0500
Subject: [PATCH] powerpc/hvsi: Fix conflict with old HVSI driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Jul 2011 13:11:26 +1000
Message-ID: <1309489886.14501.238.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A mix of thinko & mismerge on my side caused a problem where both the
new hvsi_lib and the old hvsi driver gets compiled and try to define
symbols with the same name.

This fixes it by renaming the hvsi_lib exported symbols.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/hvsi.h |   24 ++++++++++++------------
 drivers/tty/hvc/hvc_vio.c       |   30 +++++++++++++++---------------
 drivers/tty/hvc/hvsi_lib.c      |   32 ++++++++++++++++----------------
 3 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/hvsi.h b/arch/powerpc/include/asm/hvsi.h
index 91e0453..d3f64f3 100644
--- a/arch/powerpc/include/asm/hvsi.h
+++ b/arch/powerpc/include/asm/hvsi.h
@@ -78,17 +78,17 @@ struct hvsi_priv {
 
 /* hvsi lib functions */
 struct hvc_struct;
-extern void hvsi_init(struct hvsi_priv *pv,
-		      int (*get_chars)(uint32_t termno, char *buf, int count),
-		      int (*put_chars)(uint32_t termno, const char *buf,
-				       int count),
-		      int termno, int is_console);
-extern int hvsi_open(struct hvsi_priv *pv, struct hvc_struct *hp);
-extern void hvsi_close(struct hvsi_priv *pv, struct hvc_struct *hp);
-extern int hvsi_read_mctrl(struct hvsi_priv *pv);
-extern int hvsi_write_mctrl(struct hvsi_priv *pv, int dtr);
-extern void hvsi_establish(struct hvsi_priv *pv);
-extern int hvsi_get_chars(struct hvsi_priv *pv, char *buf, int count);
-extern int hvsi_put_chars(struct hvsi_priv *pv, const char *buf, int count);
+extern void hvsilib_init(struct hvsi_priv *pv,
+			 int (*get_chars)(uint32_t termno, char *buf, int count),
+			 int (*put_chars)(uint32_t termno, const char *buf,
+					  int count),
+			 int termno, int is_console);
+extern int hvsilib_open(struct hvsi_priv *pv, struct hvc_struct *hp);
+extern void hvsilib_close(struct hvsi_priv *pv, struct hvc_struct *hp);
+extern int hvsilib_read_mctrl(struct hvsi_priv *pv);
+extern int hvsilib_write_mctrl(struct hvsi_priv *pv, int dtr);
+extern void hvsilib_establish(struct hvsi_priv *pv);
+extern int hvsilib_get_chars(struct hvsi_priv *pv, char *buf, int count);
+extern int hvsilib_put_chars(struct hvsi_priv *pv, const char *buf, int count);
 
 #endif /* _HVSI_H */
diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index ade73fa..710c06c 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -134,7 +134,7 @@ static int hvterm_hvsi_get_chars(uint32_t vtermno, char *buf, int count)
 	if (WARN_ON(!pv))
 		return 0;
 
-	return hvsi_get_chars(&pv->hvsi, buf, count);
+	return hvsilib_get_chars(&pv->hvsi, buf, count);
 }
 
 static int hvterm_hvsi_put_chars(uint32_t vtermno, const char *buf, int count)
@@ -144,7 +144,7 @@ static int hvterm_hvsi_put_chars(uint32_t vtermno, const char *buf, int count)
 	if (WARN_ON(!pv))
 		return 0;
 
-	return hvsi_put_chars(&pv->hvsi, buf, count);
+	return hvsilib_put_chars(&pv->hvsi, buf, count);
 }
 
 static int hvterm_hvsi_open(struct hvc_struct *hp, int data)
@@ -158,7 +158,7 @@ static int hvterm_hvsi_open(struct hvc_struct *hp, int data)
 	if (rc)
 		return rc;
 
-	return hvsi_open(&pv->hvsi, hp);
+	return hvsilib_open(&pv->hvsi, hp);
 }
 
 static void hvterm_hvsi_close(struct hvc_struct *hp, int data)
@@ -167,7 +167,7 @@ static void hvterm_hvsi_close(struct hvc_struct *hp, int data)
 
 	pr_devel("HVSI@%x: do close !\n", pv->termno);
 
-	hvsi_close(&pv->hvsi, hp);
+	hvsilib_close(&pv->hvsi, hp);
 
 	notifier_del_irq(hp, data);
 }
@@ -178,7 +178,7 @@ void hvterm_hvsi_hangup(struct hvc_struct *hp, int data)
 
 	pr_devel("HVSI@%x: do hangup !\n", pv->termno);
 
-	hvsi_close(&pv->hvsi, hp);
+	hvsilib_close(&pv->hvsi, hp);
 
 	notifier_hangup_irq(hp, data);
 }
@@ -201,9 +201,9 @@ static int hvterm_hvsi_tiocmset(struct hvc_struct *hp, unsigned int set,
 		 pv->termno, set, clear);
 
 	if (set & TIOCM_DTR)
-		hvsi_write_mctrl(&pv->hvsi, 1);
+		hvsilib_write_mctrl(&pv->hvsi, 1);
 	else if (clear & TIOCM_DTR)
-		hvsi_write_mctrl(&pv->hvsi, 0);
+		hvsilib_write_mctrl(&pv->hvsi, 0);
 
 	return 0;
 }
@@ -267,8 +267,8 @@ static int __devinit hvc_vio_probe(struct vio_dev *vdev,
 		pv->termno = vdev->unit_address;
 		pv->proto = proto;
 		hvterm_privs[termno] = pv;
-		hvsi_init(&pv->hvsi, hvc_get_chars, hvc_put_chars,
-			  pv->termno, 0);
+		hvsilib_init(&pv->hvsi, hvc_get_chars, hvc_put_chars,
+			     pv->termno, 0);
 	}
 
 	hp = hvc_alloc(termno, vdev->irq, ops, MAX_VIO_PUT_CHARS);
@@ -416,10 +416,10 @@ void __init hvc_vio_init_early(void)
 	else if (of_device_is_compatible(stdout_node, "hvterm-protocol")) {
 		hvterm_priv0.proto = HV_PROTOCOL_HVSI;
 		ops = &hvterm_hvsi_ops;
-		hvsi_init(&hvterm_priv0.hvsi, hvc_get_chars, hvc_put_chars,
-			  hvterm_priv0.termno, 1);
+		hvsilib_init(&hvterm_priv0.hvsi, hvc_get_chars, hvc_put_chars,
+			     hvterm_priv0.termno, 1);
 		/* HVSI, perform the handshake now */
-		hvsi_establish(&hvterm_priv0.hvsi);
+		hvsilib_establish(&hvterm_priv0.hvsi);
 	} else
 		goto out;
 	udbg_putc = udbg_hvc_putc;
@@ -462,8 +462,8 @@ void __init udbg_init_debug_lpar_hvsi(void)
 	udbg_putc = udbg_hvc_putc;
 	udbg_getc = udbg_hvc_getc;
 	udbg_getc_poll = udbg_hvc_getc_poll;
-	hvsi_init(&hvterm_priv0.hvsi, hvc_get_chars, hvc_put_chars,
-		  hvterm_priv0.termno, 1);
-	hvsi_establish(&hvterm_priv0.hvsi);
+	hvsilib_init(&hvterm_priv0.hvsi, hvc_get_chars, hvc_put_chars,
+		     hvterm_priv0.termno, 1);
+	hvsilib_establish(&hvterm_priv0.hvsi);
 }
 #endif /* CONFIG_PPC_EARLY_DEBUG_LPAR_HVSI */
diff --git a/drivers/tty/hvc/hvsi_lib.c b/drivers/tty/hvc/hvsi_lib.c
index 9401fcb..bd9b098 100644
--- a/drivers/tty/hvc/hvsi_lib.c
+++ b/drivers/tty/hvc/hvsi_lib.c
@@ -178,7 +178,7 @@ static int hvsi_get_packet(struct hvsi_priv *pv)
 	return 0;
 }
 
-int hvsi_get_chars(struct hvsi_priv *pv, char *buf, int count)
+int hvsilib_get_chars(struct hvsi_priv *pv, char *buf, int count)
 {
 	unsigned int tries, read = 0;
 
@@ -228,7 +228,7 @@ int hvsi_get_chars(struct hvsi_priv *pv, char *buf, int count)
 	return read;
 }
 
-int hvsi_put_chars(struct hvsi_priv *pv, const char *buf, int count)
+int hvsilib_put_chars(struct hvsi_priv *pv, const char *buf, int count)
 {
 	struct hvsi_data dp;
 	int rc, adjcount = min(count, HVSI_MAX_OUTGOING_DATA);
@@ -254,7 +254,7 @@ static void maybe_msleep(unsigned long ms)
 		msleep(ms);
 }
 
-int hvsi_read_mctrl(struct hvsi_priv *pv)
+int hvsilib_read_mctrl(struct hvsi_priv *pv)
 {
 	struct hvsi_query q;
 	int rc, timeout;
@@ -285,7 +285,7 @@ int hvsi_read_mctrl(struct hvsi_priv *pv)
 	return -EIO;
 }
 
-int hvsi_write_mctrl(struct hvsi_priv *pv, int dtr)
+int hvsilib_write_mctrl(struct hvsi_priv *pv, int dtr)
 {
 	struct hvsi_control ctrl;
 	unsigned short mctrl;
@@ -310,7 +310,7 @@ int hvsi_write_mctrl(struct hvsi_priv *pv, int dtr)
 	return hvsi_send_packet(pv, &ctrl.hdr);
 }
 
-void hvsi_establish(struct hvsi_priv *pv)
+void hvsilib_establish(struct hvsi_priv *pv)
 {
 	int timeout;
 
@@ -359,32 +359,32 @@ void hvsi_establish(struct hvsi_priv *pv)
 
 	pr_devel("HVSI@%x:   ... established, reading mctrl\n", pv->termno);
 
-	hvsi_read_mctrl(pv);
+	hvsilib_read_mctrl(pv);
 
 	/* Set our own DTR */
 
 	pr_devel("HVSI@%x:   ... setting mctrl\n", pv->termno);
 
-	hvsi_write_mctrl(pv, 1);
+	hvsilib_write_mctrl(pv, 1);
 
 	/* Set the opened flag so reads are allowed */
 	wmb();
 	pv->opened = 1;
 }
 
-int hvsi_open(struct hvsi_priv *pv, struct hvc_struct *hp)
+int hvsilib_open(struct hvsi_priv *pv, struct hvc_struct *hp)
 {
 	pr_devel("HVSI@%x: open !\n", pv->termno);
 
 	/* Keep track of the tty data structure */
 	pv->tty = tty_kref_get(hp->tty);
 
-	hvsi_establish(pv);
+	hvsilib_establish(pv);
 
 	return 0;
 }
 
-void hvsi_close(struct hvsi_priv *pv, struct hvc_struct *hp)
+void hvsilib_close(struct hvsi_priv *pv, struct hvc_struct *hp)
 {
 	unsigned long flags;
 
@@ -401,7 +401,7 @@ void hvsi_close(struct hvsi_priv *pv, struct hvc_struct *hp)
 
 		/* Clear our own DTR */
 		if (!pv->tty || (pv->tty->termios->c_cflag & HUPCL))
-			hvsi_write_mctrl(pv, 0);
+			hvsilib_write_mctrl(pv, 0);
 
 		/* Tear down the connection */
 		hvsi_send_close(pv);
@@ -412,11 +412,11 @@ void hvsi_close(struct hvsi_priv *pv, struct hvc_struct *hp)
 	pv->tty = NULL;
 }
 
-void hvsi_init(struct hvsi_priv *pv,
-	       int (*get_chars)(uint32_t termno, char *buf, int count),
-	       int (*put_chars)(uint32_t termno, const char *buf,
-				int count),
-	       int termno, int is_console)
+void hvsilib_init(struct hvsi_priv *pv,
+		  int (*get_chars)(uint32_t termno, char *buf, int count),
+		  int (*put_chars)(uint32_t termno, const char *buf,
+				   int count),
+		  int termno, int is_console)
 {
 	memset(pv, 0, sizeof(*pv));
 	pv->get_chars = get_chars;
