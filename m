Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F6351A17B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 18:26:59 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 26 Aug 2015 13:56:56 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id F36E43940061
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:51 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7Q8QfJQ65274104
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:42 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7Q8QdWD025164
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:41 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 03/10] kasan: Rename kasan_enabled to kasan_report_enabled
Date: Wed, 26 Aug 2015 13:56:11 +0530
Message-Id: <1440577578-15813-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
