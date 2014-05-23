Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2BF21A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 19:41:17 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4553014007B
 for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2014 19:41:16 +1000 (EST)
Message-ID: <1400838066.29150.69.camel@pasglop>
Subject: [PATCH] tty/hvc/hvc_console: Fix wakeup of HVC thread on hvc_kick()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 23 May 2014 19:41:06 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Jiri Slaby <jslaby@suse.cz>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some backends call hvc_kick() to wakeup the HVC thread from its
slumber upon incoming characters. This however doesn't work
properly because it uses msleep_interruptible() which is mostly
immune to wake_up_process(). It will basically go back to sleep
until the timeout is expired (only signals can really wake it).

Replace it with a simple shedule_timeout_interruptible() instead,
which may wakeup earlier every now and then but we really don't
care in this case.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/tty/hvc/hvc_console.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 94f9e3a..1094265 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -760,10 +760,17 @@ static int khvcd(void *unused)
 			if (poll_mask == 0)
 				schedule();
 			else {
+				unsigned long j_timeout;
+
 				if (timeout < MAX_TIMEOUT)
 					timeout += (timeout >> 6) + 1;
 
-				msleep_interruptible(timeout);
+				/*
+				 * We don't use msleep_interruptible otherwise
+				 * "kick" will fail to wake us up
+				 */
+				j_timeout = msecs_to_jiffies(timeout) + 1;
+				schedule_timeout_interruptible(j_timeout);
 			}
 		}
 		__set_current_state(TASK_RUNNING);
