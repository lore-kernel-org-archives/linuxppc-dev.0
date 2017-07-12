Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6m6b2YyTzDqjj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 14:23:51 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6C4NmDN130549
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 00:23:48 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bncj588xt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 00:23:48 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 12 Jul 2017 14:23:37 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6C4NWtG26411020
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 14:23:32 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6C4NNZx023441
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 14:23:23 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Cc: benh@kernel.crashing.org, stewart@linux.vnet.ibm.com, dwmw2@infradead.org,
 rlippert@google.com, alistair@popple.id.au
Subject: [PATCH v3 08/10] powerpc/opal: Add
 opal_async_wait_response_interruptible() to opal-async
Date: Wed, 12 Jul 2017 14:23:02 +1000
In-Reply-To: <20170712042304.19745-1-cyrilbur@gmail.com>
References: <20170712042304.19745-1-cyrilbur@gmail.com>
Message-Id: <20170712042304.19745-9-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds an _interruptible version of opal_async_wait_response().
This is useful when a long running OPAL call is performed on behalf of a
userspace thread, for example, the opal_flash_{read,write,erase}
functions performed by the powernv-flash MTD driver.

It is foreseeable that these functions would take upwards of two minutes
causing the wait_event() to block long enough to cause hung task
warnings. Furthermore, wait_event_interruptible() is preferable as
otherwise there is no way for signals to stop the process which is going
to be confusing in userspace.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/opal.h             |  2 +
 arch/powerpc/platforms/powernv/opal-async.c | 87 +++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 5553ad2f3e53..6e9e53d744f3 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -294,6 +294,8 @@ extern void opal_notifier_update_evt(uint64_t evt_mask, uint64_t evt_val);
 extern int opal_async_get_token_interruptible(void);
 extern int opal_async_release_token(int token);
 extern int opal_async_wait_response(uint64_t token, struct opal_msg *msg);
+extern int opal_async_wait_response_interruptible(uint64_t token,
+		struct opal_msg *msg);
 extern int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data);
 
 struct rtc_time;
diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
index d692372a0363..f6b30cfceb8f 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -26,6 +26,8 @@
 enum opal_async_token_state {
 	ASYNC_TOKEN_FREE,
 	ASYNC_TOKEN_ALLOCATED,
+	ASYNC_TOKEN_DISPATCHED,
+	ASYNC_TOKEN_ABANDONED,
 	ASYNC_TOKEN_COMPLETED
 };
 
@@ -59,8 +61,10 @@ static int __opal_async_get_token(void)
 }
 
 /*
- * Note: If the returned token is used in an opal call and opal returns
- * OPAL_ASYNC_COMPLETION you MUST opal_async_wait_response() before
+ * Note: If the returned token is used in an opal call and opal
+ * returns OPAL_ASYNC_COMPLETION you MUST one of
+ * opal_async_wait_response() or
+ * opal_async_wait_response_interruptible() at least once before
  * calling another other opal_async_* function
  */
 int opal_async_get_token_interruptible(void)
@@ -97,6 +101,16 @@ static int __opal_async_release_token(int token)
 		opal_async_tokens[token].state = ASYNC_TOKEN_FREE;
 		rc = 0;
 		break;
+	/*
+	 * DISPATCHED and ABANDONED tokens must wait for OPAL to
+	 * respond.
+	 * Mark a DISPATCHED token as ABANDONED so that the response
+	 * response handling code knows no one cares and that it can
+	 * free it then.
+	 */
+	case ASYNC_TOKEN_DISPATCHED:
+		opal_async_tokens[token].state = ASYNC_TOKEN_ABANDONED;
+		/* Fall through */
 	default:
 		rc = 1;
 	}
@@ -129,7 +143,11 @@ int opal_async_wait_response(uint64_t token, struct opal_msg *msg)
 		return -EINVAL;
 	}
 
-	/* Wakeup the poller before we wait for events to speed things
+	/*
+	 * There is no need to mark the token as dispatched, wait_event()
+	 * will block until the token completes.
+	 *
+	 * Wakeup the poller before we wait for events to speed things
 	 * up on platforms or simulators where the interrupts aren't
 	 * functional.
 	 */
@@ -142,11 +160,66 @@ int opal_async_wait_response(uint64_t token, struct opal_msg *msg)
 }
 EXPORT_SYMBOL_GPL(opal_async_wait_response);
 
+int opal_async_wait_response_interruptible(uint64_t token, struct opal_msg *msg)
+{
+	unsigned long flags;
+	int ret;
+
+	if (token >= opal_max_async_tokens) {
+		pr_err("%s: Invalid token passed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!msg) {
+		pr_err("%s: Invalid message pointer passed\n", __func__);
+		return -EINVAL;
+	}
+
+	/*
+	 * The first time this gets called we mark the token as DISPATCHED
+	 * so that if wait_event_interruptible() returns not zero and the
+	 * caller frees the token, we know not to actually free the token
+	 * until the response comes.
+	 *
+	 * Only change if the token is ALLOCATED - it may have been
+	 * completed even before the caller gets around to calling this
+	 * the first time.
+	 *
+	 * There is also a dirty great comment at the token allocation
+	 * function that if the opal call returns OPAL_ASYNC_COMPLETION to
+	 * the caller then the caller *must* call this or the not
+	 * interruptible version before doing anything else with the
+	 * token.
+	 */
+	if (opal_async_tokens[token].state == ASYNC_TOKEN_ALLOCATED) {
+		spin_lock_irqsave(&opal_async_comp_lock, flags);
+		if (opal_async_tokens[token].state == ASYNC_TOKEN_ALLOCATED)
+			opal_async_tokens[token].state = ASYNC_TOKEN_DISPATCHED;
+		spin_unlock_irqrestore(&opal_async_comp_lock, flags);
+	}
+
+	/*
+	 * Wakeup the poller before we wait for events to speed things
+	 * up on platforms or simulators where the interrupts aren't
+	 * functional.
+	 */
+	opal_wake_poller();
+	ret = wait_event_interruptible(opal_async_wait,
+			opal_async_tokens[token].state ==
+			ASYNC_TOKEN_COMPLETED);
+	if (!ret)
+		memcpy(msg, &opal_async_tokens[token].response, sizeof(*msg));
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(opal_async_wait_response_interruptible);
+
 /* Called from interrupt context */
 static int opal_async_comp_event(struct notifier_block *nb,
 		unsigned long msg_type, void *msg)
 {
 	struct opal_msg *comp_msg = msg;
+	enum opal_async_token_state state;
 	unsigned long flags;
 	uint64_t token;
 
@@ -154,11 +227,17 @@ static int opal_async_comp_event(struct notifier_block *nb,
 		return 0;
 
 	token = be64_to_cpu(comp_msg->params[0]);
-	memcpy(&opal_async_tokens[token].response, comp_msg, sizeof(*comp_msg));
 	spin_lock_irqsave(&opal_async_comp_lock, flags);
+	state = opal_async_tokens[token].state;
 	opal_async_tokens[token].state = ASYNC_TOKEN_COMPLETED;
 	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
 
+	if (state == ASYNC_TOKEN_ABANDONED) {
+		/* Free the token, no one else will */
+		opal_async_release_token(token);
+		return 0;
+	}
+	memcpy(&opal_async_tokens[token].response, comp_msg, sizeof(*comp_msg));
 	wake_up(&opal_async_wait);
 
 	return 0;
-- 
2.13.2
