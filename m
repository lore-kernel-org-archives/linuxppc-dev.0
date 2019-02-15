Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA4FC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:09:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1112177E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="MQcNb/lD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1112177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440tt946RKzDqC8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 11:09:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="MQcNb/lD"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440tms6t0pzDqW6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:05:01 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id b5so4018548plr.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 16:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=reIvZujlRlaW1QSePQN68vjqnN4BTGKA/65ygZGxFlM=;
 b=MQcNb/lD2iW2CHmAdLCRzj+hF5NsCkD9NjYEoDeGebrMUvIFj4RkOAT/OlVBYVp700
 QOmIsCrgF4H+TXVxZPvbZC7FQK/kcNFDToZY4uZcYDawQK6FUXF49nVp3jmt+/M1U6lH
 IR71g92Yebs+SIkj/G1HUENlPKFcKbVMVu9G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=reIvZujlRlaW1QSePQN68vjqnN4BTGKA/65ygZGxFlM=;
 b=sGM0nIog2DgScig+Gxe9T3VxZysVvlDB+pOMvmOkKnjh0pFTZtnLpj4g4ljxnnFUQP
 FIJsjDia4FG8EQgt4T4PE4wL/0u0LAx16Eqkz/756mfKajSNN9zNlHUAm+xUMHuZSzCb
 lOwLwIcnpMbn4YmfssPGx8BeXMBVigbxPbX2i8GQNw3Ivuytuw5z31yMj3dFtf+i1Vc/
 iMu172Cqy/FH76P+zkx5fIRsdE0RmCipvebE4F8hYH3nUWkurfkOAld4HH+JP+qsuWys
 pr6l3WHx34o5sB+n6tQOR6XkgrOil2+qEhgaEhwvtgM2uzF0nMSuxutO5oUD0NX9qwZi
 t1Wg==
X-Gm-Message-State: AHQUAuY3MZeTqsusFnVs73TtKVFzjtA7wgxAC7ier5saOJDk2zcpnLwt
 HXI0kypjGKYIcOLXZKxp37Kqiw==
X-Google-Smtp-Source: AHgI3IZ+UfCn/SDcXbpn4uePscEZ+0tTNsGlHtutsQs/b5DPx9ZqliM7kjdI00CP/yiXYvWew7khdA==
X-Received: by 2002:a17:902:a588:: with SMTP id
 az8mr7034803plb.77.1550189100192; 
 Thu, 14 Feb 2019 16:05:00 -0800 (PST)
Received: from localhost (124-171-165-212.dyn.iinet.net.au. [124.171.165.212])
 by smtp.gmail.com with ESMTPSA id
 t3sm6745256pfa.50.2019.02.14.16.04.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 16:04:59 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: aneesh.kumar@linux.ibm.com, christophe.leroy@c-s.fr, bsingharora@gmail.com
Subject: [RFC PATCH 2/5] kasan: allow architectures to manage the
 memory-to-shadow mapping
Date: Fri, 15 Feb 2019 11:04:38 +1100
Message-Id: <20190215000441.14323-3-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215000441.14323-1-dja@axtens.net>
References: <20190215000441.14323-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

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

Signed-off-by: Daniel Axtens <dja@axtens.net>
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
index ffc64a9a97a5..bafa2f986660 100644
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
index 5e12035888f2..854f4de1fe10 100644
--- a/mm/kasan/generic_report.c
+++ b/mm/kasan/generic_report.c
@@ -110,7 +110,7 @@ static const char *get_wild_bug_type(struct kasan_access_info *info)
 
 const char *get_bug_type(struct kasan_access_info *info)
 {
-	if (addr_has_shadow(info->access_addr))
+	if (kasan_addr_has_shadow(info->access_addr))
 		return get_shadow_bug_type(info);
 	return get_wild_bug_type(info);
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index ea51b2d898ec..57ec24cf7bd1 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -111,16 +111,20 @@ struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
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
index bc759f8f1c67..cdefd0fe1f5d 100644
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
2.19.1

