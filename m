Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56A181A1DD0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:38:06 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Aug 2015 16:38:05 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2E10F2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:38:03 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7H6bs5s45744128
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:38:03 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7H6bURp028902
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:37:30 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 5/8] kasan: Enable arch to hook into kasan callbacks.
Date: Mon, 17 Aug 2015 12:06:37 +0530
Message-Id: <1439793400-18147-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We add enable/disable callbacks in this patch which architecture
can implemement. We will use this in the later patches for architecture
like ppc64, that cannot have early zero page kasan shadow region for the
entire virtual address space. Such architectures also cannot use
inline kasan support.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 mm/kasan/kasan.c |  9 +++++++++
 mm/kasan/kasan.h | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index 7b28e9cdf1c7..e4d33afd0eaf 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -43,6 +43,9 @@ static void kasan_poison_shadow(const void *address, size_t size, u8 value)
 {
 	void *shadow_start, *shadow_end;
 
+	if (!kasan_enabled())
+		return;
+
 	shadow_start = kasan_mem_to_shadow(address);
 	shadow_end = kasan_mem_to_shadow(address + size);
 
@@ -51,6 +54,9 @@ static void kasan_poison_shadow(const void *address, size_t size, u8 value)
 
 void kasan_unpoison_shadow(const void *address, size_t size)
 {
+	if (!kasan_enabled())
+		return;
+
 	kasan_poison_shadow(address, size, 0);
 
 	if (size & KASAN_SHADOW_MASK) {
@@ -238,6 +244,9 @@ static __always_inline void check_memory_region(unsigned long addr,
 {
 	struct kasan_access_info info;
 
+	if (!kasan_enabled())
+		return;
+
 	if (unlikely(size == 0))
 		return;
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index a6b46cc94907..deb547d5a916 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -68,6 +68,21 @@ static inline bool kasan_report_enabled(void)
 	return !current->kasan_depth;
 }
 
+#ifndef kasan_enabled
+/*
+ * Some archs may want to disable kasan callbacks.
+ */
+static inline bool kasan_enabled(void)
+{
+	return true;
+}
+#define kasan_enabled kasan_enabled
+#else
+#ifdef CONFIG_KASAN_INLINE
+#error "Kasan inline support cannot work with KASAN arch hooks"
+#endif
+#endif
+
 void kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 
-- 
2.5.0
