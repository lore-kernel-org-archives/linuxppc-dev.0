Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D99721A1DD2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:38:08 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Aug 2015 16:38:06 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DD29A3578058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:38:04 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7H6boHj55443534
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:37:58 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7H6bWTb028967
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:37:32 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 6/8] kasan: Allow arch to overrride kasan shadow offsets
Date: Mon, 17 Aug 2015 12:06:38 +0530
Message-Id: <1439793400-18147-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Some archs may want to provide kasan shadow memory as a constant
offset from the address. Such arch even though cannot use inline kasan
support, they can work with outofline kasan support.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 include/linux/kasan.h | 3 +++
 mm/kasan/kasan.h      | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 5486d777b706..e458ca64cdaf 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -15,11 +15,14 @@ struct vm_struct;
 #include <asm/kasan.h>
 #include <linux/sched.h>
 
+#ifndef kasan_mem_to_shadow
 static inline void *kasan_mem_to_shadow(const void *addr)
 {
 	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
 		+ KASAN_SHADOW_OFFSET;
 }
+#define kasan_mem_to_shadow kasan_mem_to_shadow
+#endif
 
 /* Enable reporting bugs after kasan_disable_current() */
 static inline void kasan_enable_current(void)
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index deb547d5a916..c0686f2b1224 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -57,11 +57,14 @@ struct kasan_global {
 void kasan_report_error(struct kasan_access_info *info);
 void kasan_report_user_access(struct kasan_access_info *info);
 
+#ifndef kasan_shadow_to_mem
 static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 {
 	return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
 		<< KASAN_SHADOW_SCALE_SHIFT);
 }
+#define kasan_shadow_to_mem kasan_shadow_to_mem
+#endif
 
 static inline bool kasan_report_enabled(void)
 {
-- 
2.5.0
