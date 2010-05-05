Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 3D3B9B7DB4
	for <linuxppc-dev@ozlabs.org>; Thu,  6 May 2010 06:38:10 +1000 (EST)
From: Amit Shah <amit.shah@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/3] virtio: console: Store each console's size in the console
	structure
Date: Thu,  6 May 2010 02:05:08 +0530
Message-Id: <1273091709-19963-3-git-send-email-amit.shah@redhat.com>
In-Reply-To: <1273091709-19963-2-git-send-email-amit.shah@redhat.com>
References: <1273091709-19963-1-git-send-email-amit.shah@redhat.com>
	<1273091709-19963-2-git-send-email-amit.shah@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Kusanagi Kouichi <slash@ac.auone-net.jp>, linuxppc-dev@ozlabs.org,
	Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With support for multiple consoles, just using one {rows,cols} pair in
the config space is not going to suffice.

Store each console's size as part of the console struct.

This changes the behaviour for one case when multiport is not enabled:
when notifier_add_vio() is called, the console size is taken from that
of the last config-space update instead of fetching it afresh from the
config space.

Also add a helper to update the size in the console struct as we'll need
to use the same code to update the size via control messages when
multiport support is enabled.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: linuxppc-dev@ozlabs.org
CC: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 drivers/char/virtio_console.c |   43 +++++++++++++++++++++++++++++-----------
 1 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e2d05ea..ccfe68a 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -78,6 +78,9 @@ struct console {
 	/* The hvc device associated with this console port */
 	struct hvc_struct *hvc;
 
+	/* The size of the console */
+	struct winsize ws;
+
 	/*
 	 * This number identifies the number that we used to register
 	 * with hvc in hvc_instantiate() and hvc_alloc(); this is the
@@ -773,22 +776,14 @@ static int get_chars(u32 vtermno, char *buf, int count)
 static void resize_console(struct port *port)
 {
 	struct virtio_device *vdev;
-	struct winsize ws;
 
 	/* The port could have been hot-unplugged */
-	if (!port)
+	if (!port || !is_console_port(port))
 		return;
 
 	vdev = port->portdev->vdev;
-	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)) {
-		vdev->config->get(vdev,
-				  offsetof(struct virtio_console_config, cols),
-				  &ws.ws_col, sizeof(u16));
-		vdev->config->get(vdev,
-				  offsetof(struct virtio_console_config, rows),
-				  &ws.ws_row, sizeof(u16));
-		hvc_resize(port->cons.hvc, ws);
-	}
+	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
+		hvc_resize(port->cons.hvc, port->cons.ws);
 }
 
 /* We set the configuration at this point, since we now have a tty */
@@ -952,6 +947,15 @@ static const struct file_operations port_debugfs_ops = {
 	.read  = debugfs_read,
 };
 
+static void set_console_size(struct port *port, u16 rows, u16 cols)
+{
+	if (!port || !is_console_port(port))
+		return;
+
+	port->cons.ws.ws_row = rows;
+	port->cons.ws.ws_col = cols;
+}
+
 static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *lock)
 {
 	struct port_buffer *buf;
@@ -1000,6 +1004,8 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->inbuf = NULL;
 	port->cons.hvc = NULL;
 
+	port->cons.ws.ws_row = port->cons.ws.ws_col = 0;
+
 	port->host_connected = port->guest_connected = false;
 
 	port->outvq_full = false;
@@ -1320,6 +1326,19 @@ static void config_intr(struct virtio_device *vdev)
 	portdev = vdev->priv;
 
 	if (!use_multiport(portdev)) {
+		struct port *port;
+		u16 rows, cols;
+
+		vdev->config->get(vdev,
+				  offsetof(struct virtio_console_config, cols),
+				  &cols, sizeof(u16));
+		vdev->config->get(vdev,
+				  offsetof(struct virtio_console_config, rows),
+				  &rows, sizeof(u16));
+
+		port = find_port_by_id(portdev, 0);
+		set_console_size(port, rows, cols);
+
 		/*
 		 * We'll use this way of resizing only for legacy
 		 * support.  For newer userspace
@@ -1327,7 +1346,7 @@ static void config_intr(struct virtio_device *vdev)
 		 * to indicate console size changes so that it can be
 		 * done per-port.
 		 */
-		resize_console(find_port_by_id(portdev, 0));
+		resize_console(port);
 	}
 }
 
-- 
1.6.2.5
