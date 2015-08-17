Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C5171A1D9B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:38:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Aug 2015 16:38:00 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A60DC2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:37:57 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7H6bl0258982430
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:37:56 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7H6bObH028582
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:37:25 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 2/8] kasan: MODULE_VADDR is not available on all archs
Date: Mon, 17 Aug 2015 12:06:34 +0530
Message-Id: <1439793400-18147-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Conditionalize the check using #ifdef

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 mm/kasan/report.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index e07c94fbd0ac..71ce7548d914 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -85,9 +85,14 @@ static void print_error_description(struct kasan_access_info *info)
 
 static inline bool kernel_or_module_addr(const void *addr)
 {
-	return (addr >= (void *)_stext && addr < (void *)_end)
-		|| (addr >= (void *)MODULES_VADDR
-			&& addr < (void *)MODULES_END);
+	if (addr >= (void *)_stext && addr < (void *)_end)
+		return true;
+#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
+	if (addr >= (void *)MODULES_VADDR
+			&& addr < (void *)MODULES_END)
+		return true;
+#endif
+	return false;
 }
 
 static inline bool init_task_stack_addr(const void *addr)
-- 
2.5.0
