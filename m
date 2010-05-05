Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id CC44EB7DBD
	for <linuxppc-dev@ozlabs.org>; Thu,  6 May 2010 06:38:07 +1000 (EST)
From: Amit Shah <amit.shah@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/3] virtio: console: Accept console size along with resize
	control message
Date: Thu,  6 May 2010 02:05:09 +0530
Message-Id: <1273091709-19963-4-git-send-email-amit.shah@redhat.com>
In-Reply-To: <1273091709-19963-3-git-send-email-amit.shah@redhat.com>
References: <1273091709-19963-1-git-send-email-amit.shah@redhat.com>
	<1273091709-19963-2-git-send-email-amit.shah@redhat.com>
	<1273091709-19963-3-git-send-email-amit.shah@redhat.com>
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

The VIRTIO_CONSOLE_RESIZE control message sent to us by the host now
contains the new {rows, cols} values for the console. This ensures each
console port gets its own size, and we don't depend on the config-space
rows and cols values at all now.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: linuxppc-dev@ozlabs.org
CC: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 drivers/char/virtio_console.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index ccfe68a..5cab839 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1194,12 +1194,23 @@ static void handle_control_message(struct ports_device *portdev,
 		 * have to notify the host first.
 		 */
 		break;
-	case VIRTIO_CONSOLE_RESIZE:
+	case VIRTIO_CONSOLE_RESIZE: {
+		struct {
+			__u16 rows;
+			__u16 cols;
+		} size;
+
 		if (!is_console_port(port))
 			break;
+
+		memcpy(&size, buf->buf + buf->offset + sizeof(*cpkt),
+		       sizeof(size));
+		set_console_size(port, size.rows, size.cols);
+
 		port->cons.hvc->irq_requested = 1;
 		resize_console(port);
 		break;
+	}
 	case VIRTIO_CONSOLE_PORT_OPEN:
 		port->host_connected = cpkt->value;
 		wake_up_interruptible(&port->waitqueue);
-- 
1.6.2.5
