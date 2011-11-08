Return-Path: <miche@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 509BB1007D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 08:45:21 +1100 (EST)
Subject: [PATCH v3 2/3] hvc_init():  Enforce one-time initialization.
To: Greg Kroah-Hartman <gregkh@suse.de>
From: Miche Baker-Harvey <miche@google.com>
Date: Tue, 08 Nov 2011 13:45:04 -0800
Message-ID: <20111108214504.28884.61814.stgit@miche.sea.corp.google.com>
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
