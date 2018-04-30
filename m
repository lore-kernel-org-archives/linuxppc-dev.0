Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZSL13ZdQzF2QC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 00:56:41 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id z9so6924866pfe.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 07:56:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] powerpc/powernv: implement opal_put_chars_atomic
Date: Tue,  1 May 2018 00:55:51 +1000
Message-Id: <20180430145558.4308-9-npiggin@gmail.com>
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RAW console does not need writes to be atomic, so relax
opal_put_chars to be able to do partial writes, and implement an
_atomic variant which does not take a spinlock. This API is used
in xmon, so the less locking that is used, the better chance there
is that a crash can be debugged.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/opal.h       |  1 +
 arch/powerpc/platforms/powernv/opal.c | 37 +++++++++++++++++++--------
 drivers/tty/hvc/hvc_opal.c            | 18 +++++++++----
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index bbff49fab0e5..5d7072411561 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -303,6 +303,7 @@ extern void opal_configure_cores(void);
 
 extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
 extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
+extern int opal_put_chars_atomic(uint32_t vtermno, const char *buf, int total_len);
 extern int opal_flush_console(uint32_t vtermno);
 
 extern void hvc_opal_init_early(void);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 55d4b1983110..bcdb90ada938 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -344,9 +344,9 @@ int opal_get_chars(uint32_t vtermno, char *buf, int count)
 	return 0;
 }
 
-int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
+static int __opal_put_chars(uint32_t vtermno, const char *data, int total_len, bool atomic)
 {
-	unsigned long flags;
+	unsigned long flags = 0 /* shut up gcc */;
 	int written;
 	__be64 olen;
 	s64 rc;
@@ -354,11 +354,8 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	if (!opal.entry)
 		return -ENODEV;
 
-	/* We want put_chars to be atomic to avoid mangling of hvsi
-	 * packets. To do that, we first test for room and return
-	 * -EAGAIN if there isn't enough.
-	 */
-	spin_lock_irqsave(&opal_write_lock, flags);
+	if (atomic)
+		spin_lock_irqsave(&opal_write_lock, flags);
 	rc = opal_console_write_buffer_space(vtermno, &olen);
 	if (rc || be64_to_cpu(olen) < total_len) {
 		/* Closed -> drop characters */
@@ -391,14 +388,18 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 
 	written = be64_to_cpu(olen);
 	if (written < total_len) {
-		/* Should not happen */
-		pr_warn("atomic console write returned partial len=%d written=%d\n", total_len, written);
+		if (atomic) {
+			/* Should not happen */
+			pr_warn("atomic console write returned partial "
+				"len=%d written=%d\n", total_len, written);
+		}
 		if (!written)
 			written = -EAGAIN;
 	}
 
 out:
-	spin_unlock_irqrestore(&opal_write_lock, flags);
+	if (atomic)
+		spin_unlock_irqrestore(&opal_write_lock, flags);
 
 	/* In the -EAGAIN case, callers loop, so we have to flush the console
 	 * here in case they have interrupts off (and we don't want to wait
@@ -412,6 +413,22 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	return written;
 }
 
+int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
+{
+	return __opal_put_chars(vtermno, data, total_len, false);
+}
+
+/*
+ * opal_put_chars_atomic will not perform partial-writes. Data will be
+ * atomically written to the terminal or not at all. This is not strictly
+ * true at the moment because console space can race with OPAL's console
+ * writes.
+ */
+int opal_put_chars_atomic(uint32_t vtermno, const char *data, int total_len)
+{
+	return __opal_put_chars(vtermno, data, total_len, true);
+}
+
 int opal_flush_console(uint32_t vtermno)
 {
 	s64 rc;
diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index af122ad7f06d..0a72f98ee082 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -183,9 +183,15 @@ static int hvc_opal_probe(struct platform_device *dev)
 			return -ENOMEM;
 		pv->proto = proto;
 		hvc_opal_privs[termno] = pv;
-		if (proto == HV_PROTOCOL_HVSI)
-			hvsilib_init(&pv->hvsi, opal_get_chars, opal_put_chars,
+		if (proto == HV_PROTOCOL_HVSI) {
+			/*
+			 * We want put_chars to be atomic to avoid mangling of
+			 * hvsi packets.
+			 */
+			hvsilib_init(&pv->hvsi,
+				     opal_get_chars, opal_put_chars_atomic,
 				     termno, 0);
+		}
 
 		/* Instanciate now to establish a mapping index==vtermno */
 		hvc_instantiate(termno, termno, ops);
@@ -376,8 +382,9 @@ void __init hvc_opal_init_early(void)
 	else if (of_device_is_compatible(stdout_node,"ibm,opal-console-hvsi")) {
 		hvc_opal_boot_priv.proto = HV_PROTOCOL_HVSI;
 		ops = &hvc_opal_hvsi_ops;
-		hvsilib_init(&hvc_opal_boot_priv.hvsi, opal_get_chars,
-			     opal_put_chars, index, 1);
+		hvsilib_init(&hvc_opal_boot_priv.hvsi,
+			     opal_get_chars, opal_put_chars_atomic,
+			     index, 1);
 		/* HVSI, perform the handshake now */
 		hvsilib_establish(&hvc_opal_boot_priv.hvsi);
 		pr_devel("hvc_opal: Found HVSI console\n");
@@ -409,7 +416,8 @@ void __init udbg_init_debug_opal_hvsi(void)
 	hvc_opal_privs[index] = &hvc_opal_boot_priv;
 	hvc_opal_boot_termno = index;
 	udbg_init_opal_common();
-	hvsilib_init(&hvc_opal_boot_priv.hvsi, opal_get_chars, opal_put_chars,
+	hvsilib_init(&hvc_opal_boot_priv.hvsi,
+		     opal_get_chars, opal_put_chars_atomic,
 		     index, 1);
 	hvsilib_establish(&hvc_opal_boot_priv.hvsi);
 }
-- 
2.17.0
