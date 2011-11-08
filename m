Return-Path: <miche@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B345210096A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 06:30:19 +1100 (EST)
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com
 [172.24.198.85]) by smtp-out.google.com with ESMTP id pA8JUD50009805
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Nov 2011 11:30:13 -0800
Received: from miche.sea.corp.google.com (miche.sea.corp.google.com
 [172.31.71.52])
 by wpaz21.hot.corp.google.com with ESMTP id pA8JUCxo002109
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Nov 2011 11:30:12 -0800
Received: from miche.sea.corp.google.com (localhost [IPv6:::1])
 by miche.sea.corp.google.com (Postfix) with ESMTP id D2AE520253
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 11:30:11 -0800 (PST)
Subject: [PATCH v2 1/3] virtio_console:  Fix locking of vtermno.
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Miche Baker-Harvey <miche@google.com>
Date: Tue, 08 Nov 2011 11:30:11 -0800
Message-ID: <20111108193011.30707.39360.stgit@miche.sea.corp.google.com>
In-Reply-To: <20111108193005.30707.23990.stgit@miche.sea.corp.google.com>
References: <20111108193005.30707.23990.stgit@miche.sea.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some modifications of vtermno were not done under the spinlock.

Moved assignment from vtermno and increment of vtermno together,
putting both under the spinlock.  Revert vtermno on failure.

Signed-off-by: Miche Baker-Harvey <miche@google.com>
---
 drivers/char/virtio_console.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 8e3c46d..9722e76 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -987,18 +987,21 @@ int init_port_console(struct port *port)
 	 * pointers.  The final argument is the output buffer size: we
 	 * can do any size, so we put PAGE_SIZE here.
 	 */
-	port->cons.vtermno = pdrvdata.next_vtermno;
+	spin_lock_irq(&pdrvdata_lock);
+	port->cons.vtermno = pdrvdata.next_vtermno++;
+	spin_unlock_irq(&pdrvdata_lock);
 
 	port->cons.hvc = hvc_alloc(port->cons.vtermno, 0, &hv_ops, PAGE_SIZE);
+	spin_lock_irq(&pdrvdata_lock);
 	if (IS_ERR(port->cons.hvc)) {
 		ret = PTR_ERR(port->cons.hvc);
 		dev_err(port->dev,
 			"error %d allocating hvc for port\n", ret);
 		port->cons.hvc = NULL;
+		port->cons.vtermno = pdrvdata.next_vtermno--;
+		spin_unlock_irq(&pdrvdata_lock);
 		return ret;
 	}
-	spin_lock_irq(&pdrvdata_lock);
-	pdrvdata.next_vtermno++;
 	list_add_tail(&port->cons.list, &pdrvdata.consoles);
 	spin_unlock_irq(&pdrvdata_lock);
 	port->guest_connected = true;
