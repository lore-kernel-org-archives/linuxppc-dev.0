Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id A8B8FB7CA0
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 00:47:01 +1100 (EST)
From: Amit Shah <amit.shah@redhat.com>
To: rusty@rustcorp.com.au
Subject: [PATCH 03/32] hvc_console: make the ops pointer const.
Date: Mon, 18 Jan 2010 19:14:57 +0530
Message-Id: <1263822326-24208-4-git-send-email-amit.shah@redhat.com>
In-Reply-To: <1263822326-24208-3-git-send-email-amit.shah@redhat.com>
References: <1263822326-24208-1-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-2-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-3-git-send-email-amit.shah@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, linuxppc-dev@ozlabs.org,
	virtualization@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rusty Russell <rusty@rustcorp.com.au>

This is nicer for modern R/O protection.  And noone needs it non-const, so
constify the callers as well.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org
---
 drivers/char/hvc_beat.c       |    2 +-
 drivers/char/hvc_console.c    |    7 ++++---
 drivers/char/hvc_console.h    |    7 ++++---
 drivers/char/hvc_iseries.c    |    2 +-
 drivers/char/hvc_iucv.c       |    2 +-
 drivers/char/hvc_rtas.c       |    2 +-
 drivers/char/hvc_udbg.c       |    2 +-
 drivers/char/hvc_vio.c        |    2 +-
 drivers/char/hvc_xen.c        |    2 +-
 drivers/char/virtio_console.c |    2 +-
 10 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/char/hvc_beat.c b/drivers/char/hvc_beat.c
index 0afc8b8..6913fc3 100644
--- a/drivers/char/hvc_beat.c
+++ b/drivers/char/hvc_beat.c
@@ -84,7 +84,7 @@ static int hvc_beat_put_chars(uint32_t vtermno, const char *buf, int cnt)
 	return cnt;
 }
 
-static struct hv_ops hvc_beat_get_put_ops = {
+static const struct hv_ops hvc_beat_get_put_ops = {
 	.get_chars = hvc_beat_get_chars,
 	.put_chars = hvc_beat_put_chars,
 };
diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index 416d342..d8dac58 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -125,7 +125,7 @@ static struct hvc_struct *hvc_get_by_index(int index)
  * console interfaces but can still be used as a tty device.  This has to be
  * static because kmalloc will not work during early console init.
  */
-static struct hv_ops *cons_ops[MAX_NR_HVC_CONSOLES];
+static const struct hv_ops *cons_ops[MAX_NR_HVC_CONSOLES];
 static uint32_t vtermnos[MAX_NR_HVC_CONSOLES] =
 	{[0 ... MAX_NR_HVC_CONSOLES - 1] = -1};
 
@@ -247,7 +247,7 @@ static void destroy_hvc_struct(struct kref *kref)
  * vty adapters do NOT get an hvc_instantiate() callback since they
  * appear after early console init.
  */
-int hvc_instantiate(uint32_t vtermno, int index, struct hv_ops *ops)
+int hvc_instantiate(uint32_t vtermno, int index, const struct hv_ops *ops)
 {
 	struct hvc_struct *hp;
 
@@ -749,7 +749,8 @@ static const struct tty_operations hvc_ops = {
 };
 
 struct hvc_struct __devinit *hvc_alloc(uint32_t vtermno, int data,
-					struct hv_ops *ops, int outbuf_size)
+				       const struct hv_ops *ops,
+				       int outbuf_size)
 {
 	struct hvc_struct *hp;
 	int i;
diff --git a/drivers/char/hvc_console.h b/drivers/char/hvc_console.h
index 10950ca..52ddf4d 100644
--- a/drivers/char/hvc_console.h
+++ b/drivers/char/hvc_console.h
@@ -55,7 +55,7 @@ struct hvc_struct {
 	int outbuf_size;
 	int n_outbuf;
 	uint32_t vtermno;
-	struct hv_ops *ops;
+	const struct hv_ops *ops;
 	int irq_requested;
 	int data;
 	struct winsize ws;
@@ -76,11 +76,12 @@ struct hv_ops {
 };
 
 /* Register a vterm and a slot index for use as a console (console_init) */
-extern int hvc_instantiate(uint32_t vtermno, int index, struct hv_ops *ops);
+extern int hvc_instantiate(uint32_t vtermno, int index,
+			   const struct hv_ops *ops);
 
 /* register a vterm for hvc tty operation (module_init or hotplug add) */
 extern struct hvc_struct * __devinit hvc_alloc(uint32_t vtermno, int data,
-				struct hv_ops *ops, int outbuf_size);
+				const struct hv_ops *ops, int outbuf_size);
 /* remove a vterm from hvc tty operation (module_exit or hotplug remove) */
 extern int hvc_remove(struct hvc_struct *hp);
 
diff --git a/drivers/char/hvc_iseries.c b/drivers/char/hvc_iseries.c
index 936d05b..fd02426 100644
--- a/drivers/char/hvc_iseries.c
+++ b/drivers/char/hvc_iseries.c
@@ -197,7 +197,7 @@ done:
 	return sent;
 }
 
-static struct hv_ops hvc_get_put_ops = {
+static const struct hv_ops hvc_get_put_ops = {
 	.get_chars = get_chars,
 	.put_chars = put_chars,
 	.notifier_add = notifier_add_irq,
diff --git a/drivers/char/hvc_iucv.c b/drivers/char/hvc_iucv.c
index fe62bd0..21681a8 100644
--- a/drivers/char/hvc_iucv.c
+++ b/drivers/char/hvc_iucv.c
@@ -922,7 +922,7 @@ static int hvc_iucv_pm_restore_thaw(struct device *dev)
 
 
 /* HVC operations */
-static struct hv_ops hvc_iucv_ops = {
+static const struct hv_ops hvc_iucv_ops = {
 	.get_chars = hvc_iucv_get_chars,
 	.put_chars = hvc_iucv_put_chars,
 	.notifier_add = hvc_iucv_notifier_add,
diff --git a/drivers/char/hvc_rtas.c b/drivers/char/hvc_rtas.c
index 88590d0..61c4a61 100644
--- a/drivers/char/hvc_rtas.c
+++ b/drivers/char/hvc_rtas.c
@@ -71,7 +71,7 @@ static int hvc_rtas_read_console(uint32_t vtermno, char *buf, int count)
 	return i;
 }
 
-static struct hv_ops hvc_rtas_get_put_ops = {
+static const struct hv_ops hvc_rtas_get_put_ops = {
 	.get_chars = hvc_rtas_read_console,
 	.put_chars = hvc_rtas_write_console,
 };
diff --git a/drivers/char/hvc_udbg.c b/drivers/char/hvc_udbg.c
index bd63ba8..b0957e6 100644
--- a/drivers/char/hvc_udbg.c
+++ b/drivers/char/hvc_udbg.c
@@ -58,7 +58,7 @@ static int hvc_udbg_get(uint32_t vtermno, char *buf, int count)
 	return i;
 }
 
-static struct hv_ops hvc_udbg_ops = {
+static const struct hv_ops hvc_udbg_ops = {
 	.get_chars = hvc_udbg_get,
 	.put_chars = hvc_udbg_put,
 };
diff --git a/drivers/char/hvc_vio.c b/drivers/char/hvc_vio.c
index 10be343..27370e9 100644
--- a/drivers/char/hvc_vio.c
+++ b/drivers/char/hvc_vio.c
@@ -77,7 +77,7 @@ static int filtered_get_chars(uint32_t vtermno, char *buf, int count)
 	return got;
 }
 
-static struct hv_ops hvc_get_put_ops = {
+static const struct hv_ops hvc_get_put_ops = {
 	.get_chars = filtered_get_chars,
 	.put_chars = hvc_put_chars,
 	.notifier_add = notifier_add_irq,
diff --git a/drivers/char/hvc_xen.c b/drivers/char/hvc_xen.c
index b1a7163..60446f8 100644
--- a/drivers/char/hvc_xen.c
+++ b/drivers/char/hvc_xen.c
@@ -122,7 +122,7 @@ static int read_console(uint32_t vtermno, char *buf, int len)
 	return recv;
 }
 
-static struct hv_ops hvc_ops = {
+static const struct hv_ops hvc_ops = {
 	.get_chars = read_console,
 	.put_chars = write_console,
 	.notifier_add = notifier_add_irq,
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1d844a4..791be4e 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -163,7 +163,7 @@ static void hvc_handle_input(struct virtqueue *vq)
 }
 
 /* The operations for the console. */
-static struct hv_ops hv_ops = {
+static const struct hv_ops hv_ops = {
 	.get_chars = get_chars,
 	.put_chars = put_chars,
 	.notifier_add = notifier_add_vio,
-- 
1.6.2.5
