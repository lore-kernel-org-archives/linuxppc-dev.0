Return-Path: <jirislaby@gmail.com>
Received: from smtp.pripojeni.net (mail.pripojeni.net [178.22.112.14])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9E0C4B6FC9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2012 22:02:15 +1000 (EST)
From: Jiri Slaby <jslaby@suse.cz>
To: gregkh@linuxfoundation.org
Subject: [PATCH 37/69] TTY: HVC, add tty_port
Date: Mon,  2 Apr 2012 13:54:21 +0200
Message-Id: <1333367693-3244-38-git-send-email-jslaby@suse.cz>
In-Reply-To: <1333367693-3244-1-git-send-email-jslaby@suse.cz>
References: <1333367693-3244-1-git-send-email-jslaby@suse.cz>
Cc: jirislaby@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

And use kref from that. This means we need tty_port->ops->destruct to
properly free the structure. This is what destroy_hvc_struct used to
do so we leverage that.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/hvc/hvc_console.c |   23 ++++++++++++++---------
 drivers/tty/hvc/hvc_console.h |    2 +-
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 8880adf..12a4273 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -107,7 +107,7 @@ static struct hvc_struct *hvc_get_by_index(int index)
 	list_for_each_entry(hp, &hvc_structs, next) {
 		spin_lock_irqsave(&hp->lock, flags);
 		if (hp->index == index) {
-			kref_get(&hp->kref);
+			tty_port_get(&hp->port);
 			spin_unlock_irqrestore(&hp->lock, flags);
 			spin_unlock(&hvc_structs_lock);
 			return hp;
@@ -229,9 +229,9 @@ static int __init hvc_console_init(void)
 console_initcall(hvc_console_init);
 
 /* callback when the kboject ref count reaches zero. */
-static void destroy_hvc_struct(struct kref *kref)
+static void hvc_port_destruct(struct tty_port *port)
 {
-	struct hvc_struct *hp = container_of(kref, struct hvc_struct, kref);
+	struct hvc_struct *hp = container_of(port, struct hvc_struct, port);
 	unsigned long flags;
 
 	spin_lock(&hvc_structs_lock);
@@ -264,7 +264,7 @@ int hvc_instantiate(uint32_t vtermno, int index, const struct hv_ops *ops)
 	/* make sure no no tty has been registered in this index */
 	hp = hvc_get_by_index(index);
 	if (hp) {
-		kref_put(&hp->kref, destroy_hvc_struct);
+		tty_port_put(&hp->port);
 		return -1;
 	}
 
@@ -343,7 +343,7 @@ static int hvc_open(struct tty_struct *tty, struct file * filp)
 		spin_unlock_irqrestore(&hp->lock, flags);
 		tty_kref_put(tty);
 		tty->driver_data = NULL;
-		kref_put(&hp->kref, destroy_hvc_struct);
+		tty_port_put(&hp->port);
 		printk(KERN_ERR "hvc_open: request_irq failed with rc %d.\n", rc);
 	}
 	/* Force wakeup of the polling thread */
@@ -397,7 +397,7 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
 	}
 
 	tty_kref_put(tty);
-	kref_put(&hp->kref, destroy_hvc_struct);
+	tty_port_put(&hp->port);
 }
 
 static void hvc_hangup(struct tty_struct *tty)
@@ -437,7 +437,7 @@ static void hvc_hangup(struct tty_struct *tty)
 	while(temp_open_count) {
 		--temp_open_count;
 		tty_kref_put(tty);
-		kref_put(&hp->kref, destroy_hvc_struct);
+		tty_port_put(&hp->port);
 	}
 }
 
@@ -817,6 +817,10 @@ static const struct tty_operations hvc_ops = {
 #endif
 };
 
+static const struct tty_port_operations hvc_port_ops = {
+	.destruct = hvc_port_destruct,
+};
+
 struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 			     const struct hv_ops *ops,
 			     int outbuf_size)
@@ -842,7 +846,8 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 	hp->outbuf_size = outbuf_size;
 	hp->outbuf = &((char *)hp)[ALIGN(sizeof(*hp), sizeof(long))];
 
-	kref_init(&hp->kref);
+	tty_port_init(&hp->port);
+	hp->port.ops = &hvc_port_ops;
 
 	INIT_WORK(&hp->tty_resize, hvc_set_winsz);
 	spin_lock_init(&hp->lock);
@@ -891,7 +896,7 @@ int hvc_remove(struct hvc_struct *hp)
 	 * kref cause it to be removed, which will probably be the tty_vhangup
 	 * below.
 	 */
-	kref_put(&hp->kref, destroy_hvc_struct);
+	tty_port_put(&hp->port);
 
 	/*
 	 * This function call will auto chain call hvc_hangup.
diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index c335a14..926d9e4 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -46,6 +46,7 @@
 #define HVC_ALLOC_TTY_ADAPTERS	8
 
 struct hvc_struct {
+	struct tty_port port;
 	spinlock_t lock;
 	int index;
 	struct tty_struct *tty;
@@ -61,7 +62,6 @@ struct hvc_struct {
 	struct winsize ws;
 	struct work_struct tty_resize;
 	struct list_head next;
-	struct kref kref; /* ref count & hvc_struct lifetime */
 };
 
 /* implemented by a low level driver */
-- 
1.7.9.2
