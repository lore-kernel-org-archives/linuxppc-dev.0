Return-Path: <majianpeng@gmail.com>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1A531104792
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2012 17:45:27 +1100 (EST)
Received: by obbup6 with SMTP id up6so4178267obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Feb 2012 22:45:24 -0800 (PST)
Date: Fri, 3 Feb 2012 14:46:00 +0800
From: "majianpeng" <majianpeng@gmail.com>
To: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
Subject: Using existing function instead statement
Message-ID: <201202031445537184460@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 53bcbc301e72ed951f67abb6428199e7edfccc16 Mon Sep 17 00:00:00 2001
From: majianpeng <majianpeng@gmail.com>
Date: Fri, 3 Feb 2012 14:35:59 +0000
Subject: [PATCH] Using existing function instead statement.


Signed-off-by: majianpeng <majianpeng@gmail.com>
---
 drivers/macintosh/adb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 75049e7..b026896 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -710,7 +710,7 @@ static ssize_t adb_read(struct file *file, char __user *buf,
 	req = NULL;
 	spin_lock_irqsave(&state->lock, flags);
 	add_wait_queue(&state->wait_queue, &wait);
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 
 	for (;;) {
 		req = state->completed;
@@ -734,7 +734,7 @@ static ssize_t adb_read(struct file *file, char __user *buf,
 		spin_lock_irqsave(&state->lock, flags);
 	}
 
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&state->wait_queue, &wait);
 	spin_unlock_irqrestore(&state->lock, flags);
 	
-- 
1.7.3

 				
--------------
majianpeng
2012-02-03
