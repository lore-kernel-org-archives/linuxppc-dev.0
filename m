Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6m6Z4RqMzDqjd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 14:23:50 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6C4Nmx1038616
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 00:23:48 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bncj4r8tj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 00:23:48 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 12 Jul 2017 14:23:37 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6C4NWX824707260
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 14:23:32 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6C4NVNL007256
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 14:23:31 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Cc: benh@kernel.crashing.org, stewart@linux.vnet.ibm.com, dwmw2@infradead.org,
 rlippert@google.com, alistair@popple.id.au
Subject: [PATCH v3 06/10] powerpc/opal: Rework the opal-async interface
Date: Wed, 12 Jul 2017 14:23:00 +1000
In-Reply-To: <20170712042304.19745-1-cyrilbur@gmail.com>
References: <20170712042304.19745-1-cyrilbur@gmail.com>
Message-Id: <20170712042304.19745-7-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Future work will add an opal_async_wait_response_interruptible()
which will call wait_event_interruptible(). This work requires extra
token state to be tracked as wait_event_interruptible() can return and
the caller could release the token before OPAL responds.

Currently token state is tracked with two bitfields which are 64 bits
big but may not need to be as OPAL informs Linux how many async tokens
there are. It also uses an array indexed by token to store response
messages for each token.

The bitfields make it difficult to add more state and also provide a
hard maximum as to how many tokens there can be - it is possible that
OPAL will inform Linux that there are more than 64 tokens.

Rather than add a bitfield to track the extra state, rework the
internals slightly.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-async.c | 97 ++++++++++++++++-------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
index 1d56ac9da347..d692372a0363 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -1,7 +1,7 @@
 /*
  * PowerNV OPAL asynchronous completion interfaces
  *
- * Copyright 2013 IBM Corp.
+ * Copyright 2013-2017 IBM Corp.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -23,40 +23,46 @@
 #include <asm/machdep.h>
 #include <asm/opal.h>
 
-#define N_ASYNC_COMPLETIONS	64
+enum opal_async_token_state {
+	ASYNC_TOKEN_FREE,
+	ASYNC_TOKEN_ALLOCATED,
+	ASYNC_TOKEN_COMPLETED
+};
+
+struct opal_async_token {
+	enum opal_async_token_state state;
+	struct opal_msg response;
+};
 
-static DECLARE_BITMAP(opal_async_complete_map, N_ASYNC_COMPLETIONS) = {~0UL};
-static DECLARE_BITMAP(opal_async_token_map, N_ASYNC_COMPLETIONS);
 static DECLARE_WAIT_QUEUE_HEAD(opal_async_wait);
 static DEFINE_SPINLOCK(opal_async_comp_lock);
 static struct semaphore opal_async_sem;
-static struct opal_msg *opal_async_responses;
 static unsigned int opal_max_async_tokens;
+static struct opal_async_token *opal_async_tokens;
 
 static int __opal_async_get_token(void)
 {
 	unsigned long flags;
 	int token;
 
-	spin_lock_irqsave(&opal_async_comp_lock, flags);
-	token = find_first_bit(opal_async_complete_map, opal_max_async_tokens);
-	if (token >= opal_max_async_tokens) {
-		token = -EBUSY;
-		goto out;
-	}
-
-	if (__test_and_set_bit(token, opal_async_token_map)) {
-		token = -EBUSY;
-		goto out;
+	for (token = 0; token < opal_max_async_tokens; token++) {
+		spin_lock_irqsave(&opal_async_comp_lock, flags);
+		if (opal_async_tokens[token].state == ASYNC_TOKEN_FREE) {
+			opal_async_tokens[token].state = ASYNC_TOKEN_ALLOCATED;
+			spin_unlock_irqrestore(&opal_async_comp_lock, flags);
+			return token;
+		}
+		spin_unlock_irqrestore(&opal_async_comp_lock, flags);
 	}
 
-	__clear_bit(token, opal_async_complete_map);
-
-out:
-	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
-	return token;
+	return -EBUSY;
 }
 
+/*
+ * Note: If the returned token is used in an opal call and opal returns
+ * OPAL_ASYNC_COMPLETION you MUST opal_async_wait_response() before
+ * calling another other opal_async_* function
+ */
 int opal_async_get_token_interruptible(void)
 {
 	int token;
@@ -76,6 +82,7 @@ EXPORT_SYMBOL_GPL(opal_async_get_token_interruptible);
 static int __opal_async_release_token(int token)
 {
 	unsigned long flags;
+	int rc;
 
 	if (token < 0 || token >= opal_max_async_tokens) {
 		pr_err("%s: Passed token is out of range, token %d\n",
@@ -84,11 +91,18 @@ static int __opal_async_release_token(int token)
 	}
 
 	spin_lock_irqsave(&opal_async_comp_lock, flags);
-	__set_bit(token, opal_async_complete_map);
-	__clear_bit(token, opal_async_token_map);
+	switch (opal_async_tokens[token].state) {
+	case ASYNC_TOKEN_COMPLETED:
+	case ASYNC_TOKEN_ALLOCATED:
+		opal_async_tokens[token].state = ASYNC_TOKEN_FREE;
+		rc = 0;
+		break;
+	default:
+		rc = 1;
+	}
 	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
 
-	return 0;
+	return rc;
 }
 
 int opal_async_release_token(int token)
@@ -96,12 +110,10 @@ int opal_async_release_token(int token)
 	int ret;
 
 	ret = __opal_async_release_token(token);
-	if (ret)
-		return ret;
-
-	up(&opal_async_sem);
+	if (!ret)
+		up(&opal_async_sem);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(opal_async_release_token);
 
@@ -122,13 +134,15 @@ int opal_async_wait_response(uint64_t token, struct opal_msg *msg)
 	 * functional.
 	 */
 	opal_wake_poller();
-	wait_event(opal_async_wait, test_bit(token, opal_async_complete_map));
-	memcpy(msg, &opal_async_responses[token], sizeof(*msg));
+	wait_event(opal_async_wait, opal_async_tokens[token].state
+			== ASYNC_TOKEN_COMPLETED);
+	memcpy(msg, &opal_async_tokens[token].response, sizeof(*msg));
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(opal_async_wait_response);
 
+/* Called from interrupt context */
 static int opal_async_comp_event(struct notifier_block *nb,
 		unsigned long msg_type, void *msg)
 {
@@ -140,9 +154,9 @@ static int opal_async_comp_event(struct notifier_block *nb,
 		return 0;
 
 	token = be64_to_cpu(comp_msg->params[0]);
-	memcpy(&opal_async_responses[token], comp_msg, sizeof(*comp_msg));
+	memcpy(&opal_async_tokens[token].response, comp_msg, sizeof(*comp_msg));
 	spin_lock_irqsave(&opal_async_comp_lock, flags);
-	__set_bit(token, opal_async_complete_map);
+	opal_async_tokens[token].state = ASYNC_TOKEN_COMPLETED;
 	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
 
 	wake_up(&opal_async_wait);
@@ -178,24 +192,19 @@ int __init opal_async_comp_init(void)
 	}
 
 	opal_max_async_tokens = be32_to_cpup(async);
-	if (opal_max_async_tokens > N_ASYNC_COMPLETIONS)
-		opal_max_async_tokens = N_ASYNC_COMPLETIONS;
+	opal_async_tokens = kcalloc(opal_max_async_tokens,
+			sizeof(*opal_async_tokens), GFP_KERNEL);
+	if (!opal_async_tokens) {
+		err = -ENOMEM;
+		goto out_opal_node;
+	}
 
 	err = opal_message_notifier_register(OPAL_MSG_ASYNC_COMP,
 			&opal_async_comp_nb);
 	if (err) {
 		pr_err("%s: Can't register OPAL event notifier (%d)\n",
 				__func__, err);
-		goto out_opal_node;
-	}
-
-	opal_async_responses = kzalloc(
-			sizeof(*opal_async_responses) * opal_max_async_tokens,
-			GFP_KERNEL);
-	if (!opal_async_responses) {
-		pr_err("%s: Out of memory, failed to do asynchronous "
-				"completion init\n", __func__);
-		err = -ENOMEM;
+		kfree(opal_async_tokens);
 		goto out_opal_node;
 	}
 
-- 
2.13.2
