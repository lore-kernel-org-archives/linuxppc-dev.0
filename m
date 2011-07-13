Return-Path: <anton@samba.org>
Date: Wed, 13 Jul 2011 15:19:57 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/pseries: Fix hvterm_raw_get_chars to accept < 16
	chars, fixing xmon
Message-ID: <20110713151957.593494f8@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


commit 4d2bb3f50036 (powerpc/pseries: Re-implement HVSI as part of
hvc_vio) changed udbg_getc to be based on hvterm_raw_get_chars.
Unfortunately hvterm_raw_get_chars returns -EAGAIN if you ask
for anything less than 16 characters. As a result xmon no longer
accepts input and prints a stream of junk to the screen.

The recent change highlights a problem that xmon on pseries VIO 
has had all along, that it can drop input characters. The issue
is the hypervisor call does not take a count argument and can
return up to 16 characters.

This patch adds a per vterm buffer that we copy input data into
and give it out as requested.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/drivers/tty/hvc/hvc_vio.c
===================================================================
--- linux-powerpc.orig/drivers/tty/hvc/hvc_vio.c	2011-07-13 14:37:16.251635811 +1000
+++ linux-powerpc/drivers/tty/hvc/hvc_vio.c	2011-07-13 14:48:33.843356126 +1000
@@ -71,41 +71,53 @@ struct hvterm_priv {
 	u32			termno;	/* HV term number */
 	hv_protocol_t		proto;	/* Raw data or HVSI packets */
 	struct hvsi_priv	hvsi;	/* HVSI specific data */
+	spinlock_t		buf_lock;
+	char			buf[SIZE_VIO_GET_CHARS];
+	int			left;
+	int			offset;
 };
 static struct hvterm_priv *hvterm_privs[MAX_NR_HVC_CONSOLES];
-
 /* For early boot console */
 static struct hvterm_priv hvterm_priv0;
 
 static int hvterm_raw_get_chars(uint32_t vtermno, char *buf, int count)
 {
 	struct hvterm_priv *pv = hvterm_privs[vtermno];
-	unsigned long got, i;
+	unsigned long i;
+	unsigned long flags;
+	int got;
 
 	if (WARN_ON(!pv))
 		return 0;
 
-	/*
-	 * Vio firmware will read up to SIZE_VIO_GET_CHARS at its own discretion
-	 * so we play safe and avoid the situation where got > count which could
-	 * overload the flip buffer.
-	 */
-	if (count < SIZE_VIO_GET_CHARS)
-		return -EAGAIN;
-
-	got = hvc_get_chars(pv->termno, buf, count);
+	spin_lock_irqsave(&pv->buf_lock, flags);
 
-	/*
-	 * Work around a HV bug where it gives us a null
-	 * after every \r.  -- paulus
-	 */
-	for (i = 1; i < got; ++i) {
-		if (buf[i] == 0 && buf[i-1] == '\r') {
-			--got;
-			if (i < got)
-				memmove(&buf[i], &buf[i+1], got - i);
+	if (pv->left == 0) {
+		pv->offset = 0;
+		pv->left = hvc_get_chars(pv->termno, pv->buf, count);
+
+		/*
+		 * Work around a HV bug where it gives us a null
+		 * after every \r.  -- paulus
+		 */
+		for (i = 1; i < pv->left; ++i) {
+			if (pv->buf[i] == 0 && pv->buf[i-1] == '\r') {
+				--pv->left;
+				if (i < pv->left) {
+					memmove(&pv->buf[i], &pv->buf[i+1],
+						pv->left - i);
+				}
+			}
 		}
 	}
+
+	got = min(count, pv->left);
+	memcpy(buf, &pv->buf[pv->offset], got);
+	pv->offset += got;
+	pv->left -= got;
+
+	spin_unlock_irqrestore(&pv->buf_lock, flags);
+
 	return got;
 }
 
@@ -266,6 +278,7 @@ static int __devinit hvc_vio_probe(struc
 			return -ENOMEM;
 		pv->termno = vdev->unit_address;
 		pv->proto = proto;
+		spin_lock_init(&pv->buf_lock);
 		hvterm_privs[termno] = pv;
 		hvsilib_init(&pv->hvsi, hvc_get_chars, hvc_put_chars,
 			     pv->termno, 0);
@@ -406,6 +419,7 @@ void __init hvc_vio_init_early(void)
 	if (termno == NULL)
 		goto out;
 	hvterm_priv0.termno = *termno;
+	spin_lock_init(&hvterm_priv0.buf_lock);
 	hvterm_privs[0] = &hvterm_priv0;
 
 	/* Check the protocol */
@@ -447,6 +461,7 @@ void __init udbg_init_debug_lpar(void)
 	hvterm_privs[0] = &hvterm_priv0;
 	hvterm_priv0.termno = 0;
 	hvterm_priv0.proto = HV_PROTOCOL_RAW;
+	spin_lock_init(&hvterm_priv0.buf_lock)
 	udbg_putc = udbg_hvc_putc;
 	udbg_getc = udbg_hvc_getc;
 	udbg_getc_poll = udbg_hvc_getc_poll;
@@ -459,6 +474,7 @@ void __init udbg_init_debug_lpar_hvsi(vo
 	hvterm_privs[0] = &hvterm_priv0;
 	hvterm_priv0.termno = CONFIG_PPC_EARLY_DEBUG_HVSI_VTERMNO;
 	hvterm_priv0.proto = HV_PROTOCOL_HVSI;
+	spin_lock_init(&hvterm_priv0.buf_lock)
 	udbg_putc = udbg_hvc_putc;
 	udbg_getc = udbg_hvc_getc;
 	udbg_getc_poll = udbg_hvc_getc_poll;
