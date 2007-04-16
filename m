Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DECC6DDEC0
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 06:23:07 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3GKN4pF028224
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 16:23:04 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3GKN40q482674
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 16:23:04 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3GKMl5C013291
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 16:22:48 -0400
Subject: Re: [PATCH] hvc_console polling mode timer backoff
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <97762565fcdccbf85d1d04cd055b1197@bga.com>
References: <97762565fcdccbf85d1d04cd055b1197@bga.com>
Content-Type: text/plain
Date: Mon, 16 Apr 2007 15:22:23 -0500
Message-Id: <1176754943.28514.133.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, ppcdev <linuxppc-dev@ozlabs.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-14-04 at 14:42 -0500, Milton Miller wrote:
> Michael Ellerman wrote:

> Did you consider making MAX_TIMEOUT a module parameter?   It could then
> be changed at runtime through /sys/modules/.

Yup, considered that.

Decided against it, for no reason other than "keeping it simple".  Not
sure that extra function does more good or bad. 

Who really wants the ability to tune their console timeout value
anyway? :-)    hrm, maybe thats a silly question.

For discussion, I'll attach a version of the patch that adds a sysfs
parm for setting max_timeout.   I'm not 100% on the S_IR* parms in the
param call, but verified that it works and it's sufficient to illustrate
what we're discussing.   
A downside is that it does no input checking, so if a useradmin wishes
to wait a very long time for their console, they can do so.  In this
implementation, it is worth noting that the current timeout value (say
100000), will not automatically decrease if a smaller max_timeout value
(say 500) is entered.  The timeout only gets reset (to MIN_TIMEOUT)
during console input.

> Keeping MIN_TIMEOUT a define is okay with me, and the code will
> naturally ignore max < MIN.  It may overshoot timeout by 1/64th.

> I doubt we would worry about the overflow case, because by then
> the timeout would have been quite long, and the user would like
> it to be short again.

You mean like ending up with a timeout of 2016 when max_timeout is 2000?
I think we're OK with that. :-)

> milton
> 

(Not sure I prefer this over the other one, but will see what other
commentary this generates...)
-Will

--
diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index a0a88aa..ba4c3cc 100644
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
@@ -550,6 +548,23 @@ static int hvc_chars_in_buffer(struct tt
 	return hp->n_outbuf;
 }
 
+/*
+ * timeout will vary between the MIN and max_timeout values here.  By default
+ * and during console activity we will use a default MIN_TIMEOUT of 10.  When
+ * the console is idle, we increase the timeout value on each pass through
+ * msleep until we reach the max.  This may be noticeable as a brief (average
+ * one second) delay on the console before the console responds to input when
+ * there has been no input for some time.  The max_timeout defaults to 2000, but
+ * can be set via /sys/module/hvc_console/parameters/max_timeout.
+ */
+#define MIN_TIMEOUT		(10)
+static u32 max_timeout = 2000;
+static u32 timeout = MIN_TIMEOUT;
+
+module_param_named(max_timeout,max_timeout,uint,S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(max_timeout,
+	"Max for timer delay used by hvc_console in polling mode. (default: 2000)");
+
 #define HVC_POLL_READ	0x00000001
 #define HVC_POLL_WRITE	0x00000002
 
@@ -642,9 +657,14 @@ #endif /* CONFIG_MAGIC_SYSRQ */
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
 
@@ -688,8 +708,12 @@ int khvcd(void *unused)
 		if (!hvc_kicked) {
 			if (poll_mask == 0)
 				schedule();
-			else
-				msleep_interruptible(TIMEOUT);
+			else {
+				if (timeout < max_timeout)
+					timeout += (timeout >> 6) + 1;
+
+				msleep_interruptible(timeout);
+			}
 		}
 		__set_current_state(TASK_RUNNING);
 	} while (!kthread_should_stop());
