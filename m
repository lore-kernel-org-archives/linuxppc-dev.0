Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21AAE1A0179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 18:26:50 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 26 Aug 2015 13:56:47 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5BD90125806D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:07 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7Q8QfHm63045868
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:42 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7Q8QdZb025139
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:40 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 02/10] kasan: MODULE_VADDR is not available on all archs
Date: Wed, 26 Aug 2015 13:56:10 +0530
Message-Id: <1440577578-15813-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
