Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D87C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 22:46:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFA0214AE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 22:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Yb6UzHtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFA0214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jqpm2VwqzDqK9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 09:46:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Yb6UzHtN"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jq7b1XvKzDqGq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 09:16:27 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Jq7V4K2Fz9tylq;
 Tue, 12 Mar 2019 23:16:22 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Yb6UzHtN; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id vwXcDA_2HKgG; Tue, 12 Mar 2019 23:16:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Jq7V36Fvz9tyll;
 Tue, 12 Mar 2019 23:16:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552428982; bh=D8w+m6PVWbWnbVuhF9ZKnJbxwUjNhp1FDRV4ywUWxfs=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=Yb6UzHtNwFgb6Hxq13PPwFfbyi7aIHatfH6zZ/4zN3oa6InMCvqGTYwCJ5RIvCDrM
 icUKoYFtxRiWabE0zKzjt7lbjVgWsHYbAuY/f0FlOCqzI6v+I04QJRK+Zi6H3b1vfF
 Y3zXlOS/T2ylFG+3vXLJVZRwZDB0EgvWHQ73oqrU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A0E3B8B8B1;
 Tue, 12 Mar 2019 23:16:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id seg9g2DF1DLM; Tue, 12 Mar 2019 23:16:22 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F43A8B8A7;
 Tue, 12 Mar 2019 23:16:22 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 214836FA15; Tue, 12 Mar 2019 22:16:22 +0000 (UTC)
Message-Id: <6350da5e480a2006b8990124d74cdbfa70704d98.1552428161.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1552428161.git.christophe.leroy@c-s.fr>
References: <cover.1552428161.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH RFC v3 16/18] kasan: allow architectures to manage the
 memory-to-shadow mapping
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Date: Tue, 12 Mar 2019 22:16:22 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Daniel Axtens <dja@axtens.net>

Currently, shadow addresses are always addr >> shift + offset.
However, for powerpc, the virtual address space is fragmented in
ways that make this simple scheme impractical.

Allow architectures to override:
 - kasan_shadow_to_mem
 - kasan_mem_to_shadow
 - addr_has_shadow

Rename addr_has_shadow to kasan_addr_has_shadow as if it is
overridden it will be available in more places, increasing the
risk of collisions.

If architectures do not #define their own versions, the generic
code will continue to run as usual.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 include/linux/kasan.h     | 2 ++
 mm/kasan/generic.c        | 2 +-
 mm/kasan/generic_report.c | 2 +-
 mm/kasan/kasan.h          | 6 +++++-
 mm/kasan/report.c         | 6 +++---
 mm/kasan/tags.c           | 2 +-
 6 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b40ea104dd36..f6261840f94c 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -23,11 +23,13 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
 int kasan_populate_early_shadow(const void *shadow_start,
 				const void *shadow_end);
 
+#ifndef kasan_mem_to_shadow
 static inline void *kasan_mem_to_shadow(const void *addr)
 {
 	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
 		+ KASAN_SHADOW_OFFSET;
 }
+#endif
 
 /* Enable reporting bugs after kasan_disable_current() */
 extern void kasan_enable_current(void);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 9e5c989dab8c..a5b28e3ceacb 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -173,7 +173,7 @@ static __always_inline void check_memory_region_inline(unsigned long addr,
 	if (unlikely(size == 0))
 		return;
 
-	if (unlikely(!addr_has_shadow((void *)addr))) {
+	if (unlikely(!kasan_addr_has_shadow((void *)addr))) {
 		kasan_report(addr, size, write, ret_ip);
 		return;
 	}
diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
index 36c645939bc9..6caafd61fc3a 100644
--- a/mm/kasan/generic_report.c
+++ b/mm/kasan/generic_report.c
@@ -107,7 +107,7 @@ static const char *get_wild_bug_type(struct kasan_access_info *info)
 
 const char *get_bug_type(struct kasan_access_info *info)
 {
-	if (addr_has_shadow(info->access_addr))
+	if (kasan_addr_has_shadow(info->access_addr))
 		return get_shadow_bug_type(info);
 	return get_wild_bug_type(info);
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 3e0c11f7d7a1..958e984d4544 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -110,16 +110,20 @@ struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
 struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
 					const void *object);
 
+#ifndef kasan_shadow_to_mem
 static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 {
 	return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
 		<< KASAN_SHADOW_SCALE_SHIFT);
 }
+#endif
 
-static inline bool addr_has_shadow(const void *addr)
+#ifndef kasan_addr_has_shadow
+static inline bool kasan_addr_has_shadow(const void *addr)
 {
 	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
 }
+#endif
 
 void kasan_poison_shadow(const void *address, size_t size, u8 value);
 
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index ca9418fe9232..bc3355ee2dd0 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -298,7 +298,7 @@ void kasan_report(unsigned long addr, size_t size,
 	untagged_addr = reset_tag(tagged_addr);
 
 	info.access_addr = tagged_addr;
-	if (addr_has_shadow(untagged_addr))
+	if (kasan_addr_has_shadow(untagged_addr))
 		info.first_bad_addr = find_first_bad_addr(tagged_addr, size);
 	else
 		info.first_bad_addr = untagged_addr;
@@ -309,11 +309,11 @@ void kasan_report(unsigned long addr, size_t size,
 	start_report(&flags);
 
 	print_error_description(&info);
-	if (addr_has_shadow(untagged_addr))
+	if (kasan_addr_has_shadow(untagged_addr))
 		print_tags(get_tag(tagged_addr), info.first_bad_addr);
 	pr_err("\n");
 
-	if (addr_has_shadow(untagged_addr)) {
+	if (kasan_addr_has_shadow(untagged_addr)) {
 		print_address_description(untagged_addr);
 		pr_err("\n");
 		print_shadow_for_address(info.first_bad_addr);
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 87ebee0a6aea..661c23dd5340 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -109,7 +109,7 @@ void check_memory_region(unsigned long addr, size_t size, bool write,
 		return;
 
 	untagged_addr = reset_tag((const void *)addr);
-	if (unlikely(!addr_has_shadow(untagged_addr))) {
+	if (unlikely(!kasan_addr_has_shadow(untagged_addr))) {
 		kasan_report(addr, size, write, ret_ip);
 		return;
 	}
-- 
2.13.3

