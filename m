Return-Path: <miche@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4E4921007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 08:45:21 +1100 (EST)
Subject: [PATCH v3 1/3] virtio_console:  Fix locking of vtermno.
To: Greg Kroah-Hartman <gregkh@suse.de>
From: Miche Baker-Harvey <miche@google.com>
Date: Tue, 08 Nov 2011 13:44:58 -0800
Message-ID: <20111108214458.28884.86759.stgit@miche.sea.corp.google.com>
In-Reply-To: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, xen-devel@lists.xensource.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>,
 Amit Shah <amit.shah@redhat.com>, Mike Waychison <mikew@google.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Eric Northrup <digitaleric@google.com>
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
