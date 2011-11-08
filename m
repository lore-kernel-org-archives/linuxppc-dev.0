Return-Path: <miche@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 44ED4100A2D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 06:30:22 +1100 (EST)
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com
 [172.25.149.12]) by smtp-out.google.com with ESMTP id pA8JUJaf018886
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Nov 2011 11:30:19 -0800
Received: from miche.sea.corp.google.com (miche.sea.corp.google.com
 [172.31.71.52])
 by hpaq12.eem.corp.google.com with ESMTP id pA8JUHqu028151
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Nov 2011 11:30:17 -0800
Received: from miche.sea.corp.google.com (localhost [IPv6:::1])
 by miche.sea.corp.google.com (Postfix) with ESMTP id 3146D20253
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 11:30:17 -0800 (PST)
Subject: [PATCH v2 2/3] hvc_init():  Enforce one-time initialization.
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Miche Baker-Harvey <miche@google.com>
Date: Tue, 08 Nov 2011 11:30:17 -0800
Message-ID: <20111108193016.30707.95497.stgit@miche.sea.corp.google.com>
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

hvc_init() must only be called once, and no thread should continue with hvc_alloc()
until after initialization is complete.  The original code does not enforce either
of these requirements.  A new mutex limits entry to hvc_init() to a single thread,
and blocks all later comers until it has completed.

This patch fixes multiple crash symptoms.

Signed-off-by: Miche Baker-Harvey <miche@google.com>
---
 drivers/tty/hvc/hvc_console.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index b6b2d18..09a6159 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -29,8 +29,9 @@
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
-#include <linux/module.h>
 #include <linux/major.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/sysrq.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
@@ -84,6 +85,10 @@ static LIST_HEAD(hvc_structs);
  * list traversal.
  */
 static DEFINE_SPINLOCK(hvc_structs_lock);
+/*
+ * only one task does allocation at a time.
+ */
+static DEFINE_MUTEX(hvc_ports_mutex);
 
 /*
  * This value is used to assign a tty->index value to a hvc_struct based
@@ -825,11 +830,15 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 	int i;
 
 	/* We wait until a driver actually comes along */
+	mutex_lock(&hvc_ports_mutex);
 	if (!hvc_driver) {
 		int err = hvc_init();
-		if (err)
+		if (err) {
+			mutex_unlock(&hvc_ports_mutex);
 			return ERR_PTR(err);
+		}
 	}
+	mutex_unlock(&hvc_ports_mutex);
 
 	hp = kzalloc(ALIGN(sizeof(*hp), sizeof(long)) + outbuf_size,
 			GFP_KERNEL);
