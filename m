Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrggK12m5zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 16:14:52 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5J6EYJq136862
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 02:14:50 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b64hthkpe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 02:14:50 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 19 Jun 2017 16:14:47 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5J6EiqN58917052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 16:14:44 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5J6EZlw027443
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 16:14:35 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V3 1/2] powerpc/powernv: Get a unique token for async
 completions
Date: Mon, 19 Jun 2017 11:44:31 +0530
In-Reply-To: <1497852872-7985-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1497852872-7985-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1497852872-7985-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support to get a unique token for async completion
requests. This will be used for creating non-repititive request
handles for consecutive requests in OPAL-OCC command/response
interface.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
No changes from V2.

 arch/powerpc/include/asm/opal.h             |  1 +
 arch/powerpc/platforms/powernv/opal-async.c | 46 +++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 588fb1c..03ed493 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -293,6 +293,7 @@ extern int opal_message_notifier_unregister(enum opal_msg_type msg_type,
 
 extern int __opal_async_get_token(void);
 extern int opal_async_get_token_interruptible(void);
+extern int opal_async_get_unique_token_interruptible(int last_token);
 extern int __opal_async_release_token(int token);
 extern int opal_async_release_token(int token);
 extern int opal_async_wait_response(uint64_t token, struct opal_msg *msg);
diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
index 83bebee..8caeea2 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -73,6 +73,52 @@ int opal_async_get_token_interruptible(void)
 }
 EXPORT_SYMBOL_GPL(opal_async_get_token_interruptible);
 
+static int __opal_async_get_new_token(int last_token)
+{
+	unsigned long flags;
+	int token;
+
+	spin_lock_irqsave(&opal_async_comp_lock, flags);
+	token = find_next_bit(opal_async_complete_map, opal_max_async_tokens,
+			      last_token + 1);
+	if (token >= opal_max_async_tokens) {
+		token = find_first_bit(opal_async_complete_map,
+				       opal_max_async_tokens);
+		if (token >= opal_max_async_tokens || token == last_token) {
+			token = -EBUSY;
+			goto out;
+		}
+	}
+
+	pr_debug("%s token = %d\n", __func__, token);
+	if (__test_and_set_bit(token, opal_async_token_map)) {
+		token = -EBUSY;
+		goto out;
+	}
+
+	__clear_bit(token, opal_async_complete_map);
+
+out:
+	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
+	return token;
+}
+
+int opal_async_get_unique_token_interruptible(int last_token)
+{
+	int token;
+
+	/* Wait until a token is available */
+	if (down_interruptible(&opal_async_sem))
+		return -ERESTARTSYS;
+
+	token = __opal_async_get_new_token(last_token);
+	if (token < 0)
+		up(&opal_async_sem);
+
+	return token;
+}
+EXPORT_SYMBOL_GPL(opal_async_get_unique_token_interruptible);
+
 int __opal_async_release_token(int token)
 {
 	unsigned long flags;
-- 
1.8.3.1
