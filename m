Return-Path: <jan.dakinevich@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vQ4k46qm1zDqJx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 07:43:40 +1100 (AEDT)
Received: by mail-lf0-x242.google.com with SMTP id x1so4653196lff.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 12:43:40 -0800 (PST)
From: Jan Dakinevich <jan.dakinevich@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Jan Dakinevich <jan.dakinevich@gmail.com>,
 Peter Hurley <peter@hurleysoftware.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: hvc: don't allocate a buffer for console print on stack
Date: Fri, 17 Feb 2017 23:42:45 +0300
Message-Id: <1487364165-21882-1-git-send-email-jan.dakinevich@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The buffer is used by virtio console driver as DMA buffer. Since v4.9
(if VMAP_STACK is enabled) we shouldn't use the stack for DMA.

Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 9b5c0fb..1ce6aaf 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -143,10 +143,15 @@ static struct hvc_struct *hvc_get_by_index(int index)
 static void hvc_console_print(struct console *co, const char *b,
 			      unsigned count)
 {
-	char c[N_OUTBUF] __ALIGNED__;
 	unsigned i = 0, n = 0;
 	int r, donecr = 0, index = co->index;
 
+	/*
+	 * Access to the buffer is serialized by console_sem in caller code from
+	 * kernel/printk/printk.c
+	 */
+	static char c[N_OUTBUF] __ALIGNED__;
+
 	/* Console access attempt outside of acceptable console range. */
 	if (index >= MAX_NR_HVC_CONSOLES)
 		return;
-- 
1.9.1
