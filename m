Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 72DC4B6F1E
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Mar 2011 18:30:17 +1100 (EST)
From: Amit Shah <amit.shah@redhat.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] hvc_console: Don't access hvc_task if not initialised
Date: Thu, 24 Mar 2011 12:59:58 +0530
Message-Id: <df8ea6d65c1ceeb25b0a3fdfc66995b8a8273ea5.1300951793.git.amit.shah@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	greg@kroah.com, Amit Shah <amit.shah@redhat.com>, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hvc_open() can be called without having any backing device.  This
results in a call to hvc_kick() which calls wake_up_process on a NULL
pointer.  Ensure hvc is initialised by checking for a non-NULL hvc_task
before waking up the hvc thread.

This was found by an autotest run for virtio_console without having a
console backend.

CC: stable@kernel.org
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/tty/hvc/hvc_console.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index e9cba13..b2cb5cc 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -286,6 +286,9 @@ EXPORT_SYMBOL_GPL(hvc_instantiate);
 /* Wake the sleeping khvcd */
 void hvc_kick(void)
 {
+	if (!hvc_task)
+		return;
+
 	hvc_kicked = 1;
 	wake_up_process(hvc_task);
 }
-- 
1.7.4
