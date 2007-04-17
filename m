Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BEEA5DDE09
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 00:45:17 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3HEjDJU009208
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 10:45:13 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3HEjDgC493590
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 10:45:13 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3HEj7bf008496
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 10:45:07 -0400
Subject: [PATCH 1/2] hvc_console polling mode timer backoff
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 17 Apr 2007 09:44:46 -0500
Message-Id: <1176821087.28514.145.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus, I think this is ready to go, please apply, thanks. 



Add a back-off mechanism to hvc_console's polling logic.   This change
drops the timers/second ratio from ~90 to ~1/2 while the console is
idle.
This change is most noticeable when watching /proc/timer_stats output.

This only affects when the hvc_console is running in poll mode, i.e.
power4 and cell systems.

I've tested on Power4, Michael Ellerman has both contributed to the
patch and tested on cell.   

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
cc: Michael Ellerman <michael@ellerman.id.au>


---
diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index a0a88aa..fc9bc77 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -47,8 +47,6 @@ #include "hvc_console.h"
 #define HVC_MAJOR	229
 #define HVC_MINOR	0
 
-#define TIMEOUT		(10)
-
 /*
  * Wait this long per iteration while trying to push buffered data to the
  * hypervisor before allowing the tty to complete a close operation.
@@ -550,6 +548,18 @@ static int hvc_chars_in_buffer(struct tt
 	return hp->n_outbuf;
 }
 
+/*
+ * timeout will vary between the MIN and MAX values defined here.  By default
+ * and during console activity we will use a default MIN_TIMEOUT of 10.  When
+ * the console is idle, we increase the timeout value on each pass through
+ * msleep until we reach the max.  This may be noticeable as a brief (average
+ * one second) delay on the console before the console responds to input when
+ * there has been no input for some time.
+ */
+#define MIN_TIMEOUT		(10)
+#define MAX_TIMEOUT		(2000)
+static u32 timeout = MIN_TIMEOUT;
+
 #define HVC_POLL_READ	0x00000001
 #define HVC_POLL_WRITE	0x00000002
 
@@ -642,9 +652,14 @@ #endif /* CONFIG_MAGIC_SYSRQ */
  bail:
 	spin_unlock_irqrestore(&hp->lock, flags);
 
-	if (read_total)
+	if (read_total) {
+		/* Activity is occurring, so reset the polling backoff value to
+		   a minimum for performance. */
+		timeout = MIN_TIMEOUT;
+
 		tty_flip_buffer_push(tty);
-	
+	}
+
 	return poll_mask;
 }
 
@@ -688,8 +703,12 @@ int khvcd(void *unused)
 		if (!hvc_kicked) {
 			if (poll_mask == 0)
 				schedule();
-			else
-				msleep_interruptible(TIMEOUT);
+			else {
+				if (timeout < MAX_TIMEOUT)
+					timeout += (timeout >> 6) + 1;
+
+				msleep_interruptible(timeout);
+			}
 		}
 		__set_current_state(TASK_RUNNING);
 	} while (!kthread_should_stop());
