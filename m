Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B98F11A1DAF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:38:03 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Aug 2015 16:38:01 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 406C92CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:37:59 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7H6bq0l9175274
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:38:00 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7H6bQSE028665
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:37:26 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 3/8] kasan: Rename kasan_enabled to kasan_report_enabled
Date: Mon, 17 Aug 2015 12:06:35 +0530
Message-Id: <1439793400-18147-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

The function only disable/enable reporting. In the later patch
we will be adding a kasan early enable/disable. Rename kasan_enabled
to properly reflect its function.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 mm/kasan/kasan.h  | 2 +-
 mm/kasan/report.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index c242adf6bc85..a6b46cc94907 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -63,7 +63,7 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 		<< KASAN_SHADOW_SCALE_SHIFT);
 }
 
-static inline bool kasan_enabled(void)
+static inline bool kasan_report_enabled(void)
 {
 	return !current->kasan_depth;
 }
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 71ce7548d914..d19d01823a68 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -225,7 +225,7 @@ void kasan_report(unsigned long addr, size_t size,
 {
 	struct kasan_access_info info;
 
-	if (likely(!kasan_enabled()))
+	if (likely(!kasan_report_enabled()))
 		return;
 
 	info.access_addr = (void *)addr;
-- 
2.5.0
