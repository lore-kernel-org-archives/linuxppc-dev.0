Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] hvc_console polling mode timer backoff
From: Michael Ellerman <michael@ellerman.id.au>
To: will_schmidt@vnet.ibm.com
In-Reply-To: <1176394477.28514.32.camel@farscape.rchland.ibm.com>
References: <1176394477.28514.32.camel@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 13 Apr 2007 17:47:39 +1000
Message-Id: <1176450459.4734.32.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-12 at 11:14 -0500, Will Schmidt wrote:
> Add a backoff mechanism to hvc_console's polling logic.   This change
> drops the timers/second ratio from ~90 to ~1 while the console is idle.
> This is very noticable when watching /proc/timer_stats output.
> 
> This only affects when the hvc_console is running in poll mode, i.e. power4
> and cell systems.
> 
> I've tested on Power4, Michael Ellerman has tested on cell.

I played with this a bit more, and a ~2% increment seems to work nicely.
It stays low for the first 10-20 seconds, but then approaches the max
much faster once there's no activity for a while.

A few examples:
http://michael.ellerman.id.au/files/cell-backoff.svg

As you can (sort of) see on the graph, after 30 seconds the delay is
still around 1/2 a second which is basically unnoticable IMHO.

Because this is a super tight performance critical inner loop I've
changed it to use a shift instead of divide. So now it's more like 1.5%,
but still the point is it increases faster as time passes.

It'd be good if some more people can bang on this and see what they
think of the interactivity.

Index: cell/drivers/char/hvc_console.c
===================================================================
--- cell.orig/drivers/char/hvc_console.c
+++ cell/drivers/char/hvc_console.c
@@ -47,8 +47,6 @@
 #define HVC_MAJOR	229
 #define HVC_MINOR	0
 
-#define TIMEOUT		(10)
-
 /*
  * Wait this long per iteration while trying to push buffered data to the
  * hypervisor before allowing the tty to complete a close operation.
@@ -550,6 +548,26 @@ static int hvc_chars_in_buffer(struct tt
 	return hp->n_outbuf;
 }
 
+/*
+ * timeout will vary between the MIN and MAX values defined here.  By default
+ * and during console activity we will use a default MIN_TIMEOUT of 10.  When
+ * the console is idle, we increase the timeout value on each pass through
+ * msleep until we reach the max.  This may be noticable as a brief (average
+ * one second) delay on the console before the console responds to input when
+ * there has been no input for sometime.
+ */
+#define MIN_TIMEOUT		(10)
+#define MAX_TIMEOUT		(2000)
+static u32 timeout = MIN_TIMEOUT;
+
+#include <linux/debugfs.h>
+static int hvc_debug_init(void)
+{
+	debugfs_create_u32("hvc_timeout", 0400, NULL, &timeout);
+	return 0;
+}
+__initcall(hvc_debug_init);
+
 #define HVC_POLL_READ	0x00000001
 #define HVC_POLL_WRITE	0x00000002
 
@@ -642,9 +660,14 @@ static int hvc_poll(struct hvc_struct *h
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
 
@@ -688,8 +711,12 @@ int khvcd(void *unused)
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
