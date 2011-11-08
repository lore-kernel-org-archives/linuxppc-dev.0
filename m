Return-Path: <miche@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DD50F100AD5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 06:30:26 +1100 (EST)
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com
 [172.24.198.101]) by smtp-out.google.com with ESMTP id pA8JUNMP006667
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Nov 2011 11:30:23 -0800
Received: from miche.sea.corp.google.com (miche.sea.corp.google.com
 [172.31.71.52])
 by wpaz37.hot.corp.google.com with ESMTP id pA8JUMJ0012510
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Nov 2011 11:30:23 -0800
Received: from miche.sea.corp.google.com (localhost [IPv6:::1])
 by miche.sea.corp.google.com (Postfix) with ESMTP id 8994620253
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 11:30:22 -0800 (PST)
Subject: [PATCH v2 3/3] Use separate struct console structure for each
 hvc_console.
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Miche Baker-Harvey <miche@google.com>
Date: Tue, 08 Nov 2011 11:30:22 -0800
Message-ID: <20111108193022.30707.84711.stgit@miche.sea.corp.google.com>
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

It is possible to make any virtio_console port be a console
by sending VIRITO_CONSOLE_CONSOLE_PORT.  But hvc_alloc was
using a single struct console hvc_console, which contains
both an index and flags which are per-port.

This adds a separate struct console for each virtio_console
that is CONSOLE_PORT.

Signed-off-by: Miche Baker-Harvey <miche@google.com>
---
 drivers/tty/hvc/hvc_console.c |   20 ++++++++++++++++++++
 drivers/tty/hvc/hvc_console.h |    1 +
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 09a6159..24a84d6 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -247,6 +247,7 @@ static void destroy_hvc_struct(struct kref *kref)
 
 	spin_unlock(&hvc_structs_lock);
 
+	kfree(hp->hvc_console);
 	kfree(hp);
 }
 
@@ -827,6 +828,7 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 			     int outbuf_size)
 {
 	struct hvc_struct *hp;
+	struct console *cp;
 	int i;
 
 	/* We wait until a driver actually comes along */
@@ -854,6 +856,17 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 	kref_init(&hp->kref);
 
 	INIT_WORK(&hp->tty_resize, hvc_set_winsz);
+	/*
+	 * Make each console its own struct console.
+	 */
+	cp = kmemdup(&hvc_console, sizeof(*cp), GFP_KERNEL);
+	if (!cp) {
+		kfree(hp);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	hp->hvc_console = cp;
+
 	spin_lock_init(&hp->lock);
 	spin_lock(&hvc_structs_lock);
 
@@ -872,8 +885,13 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 
 	hp->index = i;
 
+	cp->index = i;
+	vtermnos[i] = vtermno;
+	cons_ops[i] = ops;
+
 	list_add_tail(&(hp->next), &hvc_structs);
 	spin_unlock(&hvc_structs_lock);
+	register_console(cp);
 
 	return hp;
 }
@@ -884,6 +902,8 @@ int hvc_remove(struct hvc_struct *hp)
 	unsigned long flags;
 	struct tty_struct *tty;
 
+	BUG_ON(!hp->hvc_console);
+	unregister_console(hp->hvc_console);
 	spin_lock_irqsave(&hp->lock, flags);
 	tty = tty_kref_get(hp->tty);
 
diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index c335a14..2d20ab7 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -58,6 +58,7 @@ struct hvc_struct {
 	const struct hv_ops *ops;
 	int irq_requested;
 	int data;
+	struct console *hvc_console;
 	struct winsize ws;
 	struct work_struct tty_resize;
 	struct list_head next;
