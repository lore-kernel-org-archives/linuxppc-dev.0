Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id C0856B7C4D
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 01:36:06 +1100 (EST)
From: Amit Shah <amit.shah@redhat.com>
To: rusty@rustcorp.com.au
Subject: [PATCH 04/31] hvc_console: Remove __devinit annotation from hvc_alloc
Date: Tue, 22 Dec 2009 20:04:14 +0530
Message-Id: <1261492481-19817-5-git-send-email-amit.shah@redhat.com>
In-Reply-To: <1261492481-19817-4-git-send-email-amit.shah@redhat.com>
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-2-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-3-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-4-git-send-email-amit.shah@redhat.com>
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

Virtio consoles can be hotplugged, so hvc_alloc gets called from
multiple sites: from the initial probe() routine as well as later on
from workqueue handlers which aren't __devinit code.

So, drop the __devinit annotation for hvc_alloc.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
Cc: linuxppc-dev@ozlabs.org
---
 drivers/char/hvc_console.c |    6 +++---
 drivers/char/hvc_console.h |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index d8dac58..4c3b59b 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -748,9 +748,9 @@ static const struct tty_operations hvc_ops = {
 	.chars_in_buffer = hvc_chars_in_buffer,
 };
 
-struct hvc_struct __devinit *hvc_alloc(uint32_t vtermno, int data,
-				       const struct hv_ops *ops,
-				       int outbuf_size)
+struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
+			     const struct hv_ops *ops,
+			     int outbuf_size)
 {
 	struct hvc_struct *hp;
 	int i;
diff --git a/drivers/char/hvc_console.h b/drivers/char/hvc_console.h
index 52ddf4d..54381eb 100644
--- a/drivers/char/hvc_console.h
+++ b/drivers/char/hvc_console.h
@@ -80,8 +80,8 @@ extern int hvc_instantiate(uint32_t vtermno, int index,
 			   const struct hv_ops *ops);
 
 /* register a vterm for hvc tty operation (module_init or hotplug add) */
-extern struct hvc_struct * __devinit hvc_alloc(uint32_t vtermno, int data,
-				const struct hv_ops *ops, int outbuf_size);
+extern struct hvc_struct * hvc_alloc(uint32_t vtermno, int data,
+				     const struct hv_ops *ops, int outbuf_size);
 /* remove a vterm from hvc tty operation (module_exit or hotplug remove) */
 extern int hvc_remove(struct hvc_struct *hp);
 
-- 
1.6.2.5
