Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id C1F2CB7DC0
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 00:47:11 +1100 (EST)
From: Amit Shah <amit.shah@redhat.com>
To: rusty@rustcorp.com.au
Subject: [PATCH 04/32] hvc_console: Remove __devinit annotation from hvc_alloc
Date: Mon, 18 Jan 2010 19:14:58 +0530
Message-Id: <1263822326-24208-5-git-send-email-amit.shah@redhat.com>
In-Reply-To: <1263822326-24208-4-git-send-email-amit.shah@redhat.com>
References: <1263822326-24208-1-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-2-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-3-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-4-git-send-email-amit.shah@redhat.com>
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
