Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjZP31vrNzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 14:51:50 +1000 (AEST)
Message-ID: <1467607904.13965.1.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/opal: Wake up kopald polling thread before waiting
 for events
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
Date: Mon, 04 Jul 2016 14:51:44 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On some environments (prototype machines, some simulators, etc...)
there is no functional interrupt source to signal completion, so
we rely on the fairly slow OPAL heartbeat.

In a number of cases, the calls complete very quickly or even
immediately. We've observed that it helps a lot to wakeup the OPAL
heartbeat thread before waiting for event in those cases, it will
call OPAL immediately to collect completions for anything that
finished fast enough.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal.h             |  2 ++
 arch/powerpc/platforms/powernv/opal-async.c |  5 +++++
 arch/powerpc/platforms/powernv/opal.c       | 12 ++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 6135816..0c76bc0 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -277,6 +277,8 @@ extern int opal_error_code(int rc);
 
 ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count);
 
+void opal_wake_poller(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_OPAL_H */
diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
index bdc8c0c..83bebee 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -117,6 +117,11 @@ int opal_async_wait_response(uint64_t token, struct opal_msg *msg)
 		return -EINVAL;
 	}
 
+	/* Wakeup the poller before we wait for events to speed things
+	 * up on platforms or simulators where the interrupts aren't
+	 * functional.
+	 */
+	opal_wake_poller();
 	wait_event(opal_async_wait, test_bit(token, opal_async_complete_map));
 	memcpy(msg, &opal_async_responses[token], sizeof(*msg));
 
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 802f3b7..7f13302 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -55,6 +55,7 @@ struct device_node *opal_node;
 static DEFINE_SPINLOCK(opal_write_lock);
 static struct atomic_notifier_head opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
 static uint32_t opal_heartbeat;
+static struct task_struct *kopald_tsk;
 
 void opal_configure_cores(void)
 {
@@ -650,6 +651,7 @@ static void opal_i2c_create_devs(void)
 
 static int kopald(void *unused)
 {
+	unsigned long timeout = msecs_to_jiffies(opal_heartbeat) + 1;
 	__be64 events;
 
 	set_freezable();
@@ -657,12 +659,18 @@ static int kopald(void *unused)
 		try_to_freeze();
 		opal_poll_events(&events);
 		opal_handle_events(be64_to_cpu(events));
-		msleep_interruptible(opal_heartbeat);
+		schedule_timeout_interruptible(timeout);
 	} while (!kthread_should_stop());
 
 	return 0;
 }
 
+void opal_wake_poller(void)
+{
+	if (kopald_tsk)
+		wake_up_process(kopald_tsk);
+}
+
 static void opal_init_heartbeat(void)
 {
 	/* Old firwmware, we assume the HVC heartbeat is sufficient */
@@ -671,7 +679,7 @@ static void opal_init_heartbeat(void)
 		opal_heartbeat = 0;
 
 	if (opal_heartbeat)
-		kthread_run(kopald, NULL, "kopald");
+		kopald_tsk = kthread_run(kopald, NULL, "kopald");
 }
 
 static int __init opal_init(void)
