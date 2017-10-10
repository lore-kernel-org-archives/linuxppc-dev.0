Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yB2l1509GzDr4W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 14:33:33 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9A3TGgC067740
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 23:33:29 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dgkh5fdq8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 23:33:29 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 10 Oct 2017 04:33:28 +0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9A3XNxL24576108
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 03:33:24 GMT
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9A3XPjq031568
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 14:33:26 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
 boris.brezillon@free-electrons.com, sjitindarsingh@gmail.com
Subject: [PATCH v4 05/10] powerpc/opal: Make __opal_async_{get,
 release}_token() static
Date: Tue, 10 Oct 2017 14:32:57 +1100
In-Reply-To: <20171010033302.20854-1-cyrilbur@gmail.com>
References: <20171010033302.20854-1-cyrilbur@gmail.com>
Message-Id: <20171010033302.20854-6-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are no callers of both __opal_async_get_token() and
__opal_async_release_token().

This patch also removes the possibility of "emergency through
synchronous call to __opal_async_get_token()" as such it makes more
sense to initialise opal_sync_sem for the maximum number of async
tokens.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/opal.h             |  2 --
 arch/powerpc/platforms/powernv/opal-async.c | 10 +++-------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 726c23304a57..0078eb5acf98 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -304,9 +304,7 @@ extern void opal_notifier_enable(void);
 extern void opal_notifier_disable(void);
 extern void opal_notifier_update_evt(uint64_t evt_mask, uint64_t evt_val);
 
-extern int __opal_async_get_token(void);
 extern int opal_async_get_token_interruptible(void);
-extern int __opal_async_release_token(int token);
 extern int opal_async_release_token(int token);
 extern int opal_async_wait_response(uint64_t token, struct opal_msg *msg);
 extern int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data);
diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
index cf33769a7b72..c43421ab2d2f 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -33,7 +33,7 @@ static struct semaphore opal_async_sem;
 static struct opal_msg *opal_async_responses;
 static unsigned int opal_max_async_tokens;
 
-int __opal_async_get_token(void)
+static int __opal_async_get_token(void)
 {
 	unsigned long flags;
 	int token;
@@ -73,7 +73,7 @@ int opal_async_get_token_interruptible(void)
 }
 EXPORT_SYMBOL_GPL(opal_async_get_token_interruptible);
 
-int __opal_async_release_token(int token)
+static int __opal_async_release_token(int token)
 {
 	unsigned long flags;
 
@@ -199,11 +199,7 @@ int __init opal_async_comp_init(void)
 		goto out_opal_node;
 	}
 
-	/* Initialize to 1 less than the maximum tokens available, as we may
-	 * require to pop one during emergency through synchronous call to
-	 * __opal_async_get_token()
-	 */
-	sema_init(&opal_async_sem, opal_max_async_tokens - 1);
+	sema_init(&opal_async_sem, opal_max_async_tokens);
 
 out_opal_node:
 	of_node_put(opal_node);
-- 
2.14.2
