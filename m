Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZSLK2PLHzF2QB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 00:56:57 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 82-v6so6470492pge.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 07:56:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] tty: hvc: hvc_poll may sleep
Date: Tue,  1 May 2018 00:55:55 +1000
Message-Id: <20180430145558.4308-13-npiggin@gmail.com>
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

Introduce points where hvc_poll drops the lock, enables interrupts,
and reschedules.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 745ac220fce8..2abfc0b15fbb 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -589,7 +589,7 @@ static u32 timeout = MIN_TIMEOUT;
 #define HVC_POLL_READ	0x00000001
 #define HVC_POLL_WRITE	0x00000002
 
-int hvc_poll(struct hvc_struct *hp)
+static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 {
 	struct tty_struct *tty;
 	int i, n, count, poll_mask = 0;
@@ -611,6 +611,12 @@ int hvc_poll(struct hvc_struct *hp)
 		timeout = (written_total) ? 0 : MIN_TIMEOUT;
 	}
 
+	if (may_sleep) {
+		spin_unlock_irqrestore(&hp->lock, flags);
+		cond_resched();
+		spin_lock_irqsave(&hp->lock, flags);
+	}
+
 	/* No tty attached, just skip */
 	tty = tty_port_tty_get(&hp->port);
 	if (tty == NULL)
@@ -698,6 +704,11 @@ int hvc_poll(struct hvc_struct *hp)
 
 	return poll_mask;
 }
+
+int hvc_poll(struct hvc_struct *hp)
+{
+	return __hvc_poll(hp, false);
+}
 EXPORT_SYMBOL_GPL(hvc_poll);
 
 /**
@@ -736,7 +747,8 @@ static int khvcd(void *unused)
 		if (!cpus_are_in_xmon()) {
 			mutex_lock(&hvc_structs_mutex);
 			list_for_each_entry(hp, &hvc_structs, next) {
-				poll_mask |= hvc_poll(hp);
+				poll_mask |= __hvc_poll(hp, true);
+				cond_resched();
 			}
 			mutex_unlock(&hvc_structs_mutex);
 		} else
-- 
2.17.0
