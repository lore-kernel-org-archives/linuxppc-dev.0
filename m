Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZSL90YVfzF2Q7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 00:56:49 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id o76so6929794pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 07:56:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] tty: hvc: use mutex instead of spinlock for hvc_structs
 lock
Date: Tue,  1 May 2018 00:55:53 +1000
Message-Id: <20180430145558.4308-11-npiggin@gmail.com>
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

This allows hvc operations to sleep under the lock.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 7709fcc707f4..fddb63322c67 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -73,7 +73,7 @@ static LIST_HEAD(hvc_structs);
  * Protect the list of hvc_struct instances from inserts and removals during
  * list traversal.
  */
-static DEFINE_SPINLOCK(hvc_structs_lock);
+static DEFINE_MUTEX(hvc_structs_mutex);
 
 /*
  * This value is used to assign a tty->index value to a hvc_struct based
@@ -83,7 +83,7 @@ static DEFINE_SPINLOCK(hvc_structs_lock);
 static int last_hvc = -1;
 
 /*
- * Do not call this function with either the hvc_structs_lock or the hvc_struct
+ * Do not call this function with either the hvc_structs_mutex or the hvc_struct
  * lock held.  If successful, this function increments the kref reference
  * count against the target hvc_struct so it should be released when finished.
  */
@@ -92,25 +92,24 @@ static struct hvc_struct *hvc_get_by_index(int index)
 	struct hvc_struct *hp;
 	unsigned long flags;
 
-	spin_lock(&hvc_structs_lock);
+	mutex_lock(&hvc_structs_mutex);
 
 	list_for_each_entry(hp, &hvc_structs, next) {
 		spin_lock_irqsave(&hp->lock, flags);
 		if (hp->index == index) {
 			tty_port_get(&hp->port);
 			spin_unlock_irqrestore(&hp->lock, flags);
-			spin_unlock(&hvc_structs_lock);
+			mutex_unlock(&hvc_structs_mutex);
 			return hp;
 		}
 		spin_unlock_irqrestore(&hp->lock, flags);
 	}
 	hp = NULL;
+	mutex_unlock(&hvc_structs_mutex);
 
-	spin_unlock(&hvc_structs_lock);
 	return hp;
 }
 
-
 /*
  * Initial console vtermnos for console API usage prior to full console
  * initialization.  Any vty adapter outside this range will not have usable
@@ -224,13 +223,13 @@ static void hvc_port_destruct(struct tty_port *port)
 	struct hvc_struct *hp = container_of(port, struct hvc_struct, port);
 	unsigned long flags;
 
-	spin_lock(&hvc_structs_lock);
+	mutex_lock(&hvc_structs_mutex);
 
 	spin_lock_irqsave(&hp->lock, flags);
 	list_del(&(hp->next));
 	spin_unlock_irqrestore(&hp->lock, flags);
 
-	spin_unlock(&hvc_structs_lock);
+	mutex_unlock(&hvc_structs_mutex);
 
 	kfree(hp);
 }
@@ -733,11 +732,11 @@ static int khvcd(void *unused)
 		try_to_freeze();
 		wmb();
 		if (!cpus_are_in_xmon()) {
-			spin_lock(&hvc_structs_lock);
+			mutex_lock(&hvc_structs_mutex);
 			list_for_each_entry(hp, &hvc_structs, next) {
 				poll_mask |= hvc_poll(hp);
 			}
-			spin_unlock(&hvc_structs_lock);
+			mutex_unlock(&hvc_structs_mutex);
 		} else
 			poll_mask |= HVC_POLL_READ;
 		if (hvc_kicked)
@@ -871,7 +870,7 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 
 	INIT_WORK(&hp->tty_resize, hvc_set_winsz);
 	spin_lock_init(&hp->lock);
-	spin_lock(&hvc_structs_lock);
+	mutex_lock(&hvc_structs_mutex);
 
 	/*
 	 * find index to use:
@@ -891,7 +890,7 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 	vtermnos[i] = vtermno;
 
 	list_add_tail(&(hp->next), &hvc_structs);
-	spin_unlock(&hvc_structs_lock);
+	mutex_unlock(&hvc_structs_mutex);
 
 	/* check if we need to re-register the kernel console */
 	hvc_check_console(i);
-- 
2.17.0
