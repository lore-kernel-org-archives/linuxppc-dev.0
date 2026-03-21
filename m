Return-Path: <linuxppc-dev+bounces-18540-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5DF1093170
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 06:43:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd8yf5qfmz2yqW;
	Sat, 21 Mar 2026 17:43:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774075402;
	cv=none; b=X0PPT81/KEhVN/b0qAx4yRFKB4ACF1OewOicPs8qB1Mri3GsFzNhZUdEatqz0agFyW2b68YAYhtM0cCUt3HV9+KKBx8nUZ+XZ0zuE9OHfDIFNcaxe2pLpJMQJDsN8Yjle7bundWYm837zeNKel5/ulCn20biaIAsocB0CgDjnrzd0vWX0h3FJFLIKbw4ZJ1tVg+nMuAGxvP5XGNgLd1sa7qLoOx7G/ZT5egLfRjCug3dGgUfLwsCOHbYQbZZswcCcrdZu/qDQTBXscHpu262J0yqc+UyVV7GMKFuwp8SUCaE7u1KR8+pIMeCtZpAtdvl2zNmMrpzvBHTFZq1CH8Jjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774075402; c=relaxed/relaxed;
	bh=geANMdd5vMUOFn3a4OVwvlZ4St3DjzF/8lMKgupwtPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGiYUBZtrvvnK4txp/HnskZ+H5Fmm+Wy7C+uLOBqRN+asWCLT/Dn/+VHpzh6wHEhjvZoXyb+x5JwEpdI3DownyjQV4lvt2uLysyXgRjuHse/XqD0JwAGNROxDER1FNVLqwjTPLFxBIK7Vid9zPDVKhXs+A2q3YVLOPEWIfyVGLl6OtONdBC1UaDDmryWOnGcuRL9J9LAWCw+KYkIIrspdCHoGAFVp4NbcLpTya/JS3iX5z1QUxD+Ter4ECie6+MkrEIInujR4Us+m/UuSD6JV7IZ75XHm4r7Oddw7kYpbRRxq1GA3GrK7PlcF/rh0B05Wez6iwbq1RD/7FhVlV7bdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pg7mtxHm; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pg7mtxHm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd8yb4sPxz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 17:43:18 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774075394; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=geANMdd5vMUOFn3a4OVwvlZ4St3DjzF/8lMKgupwtPE=;
	b=pg7mtxHmNo9TlEnmWtuxA6WMOdcw+GwfwTUDLE/zRBhcXG+CPBalWGHDRGgTbND1mJNOyKpm5xaYafImjw9/0ThTToPU6NHUJP6dlm2ckE19L1rU9fUq0zJPOWmsyrZv/PBXmc31csWwBwk7vy6bhBZc1Ja2IqeUZUi16658L7Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.O5tJb_1774075393;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.O5tJb_1774075393 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Mar 2026 14:43:13 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	david@kernel.org
Cc: ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	baolin.wang@linux.alibaba.com,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org (open),
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] mm: change to return bool for pudp_test_and_clear_young()
Date: Sat, 21 Mar 2026 14:42:53 +0800
Message-ID: <2c56fe52c1bf9404145274d7e91d4a65060f6c7c.1774075004.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1774075004.git.baolin.wang@linux.alibaba.com>
References: <cover.1774075004.git.baolin.wang@linux.alibaba.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pudp_test_and_clear_young() is used to clear the young flag,
returning whether the young flag was set for this PUD entry. Change
the return type to bool to make the intention clearer.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
 arch/powerpc/mm/book3s64/pgtable.c           |  4 ++--
 arch/riscv/include/asm/pgtable.h             |  4 ++--
 arch/x86/include/asm/pgtable.h               |  4 ++--
 arch/x86/mm/pgtable.c                        |  6 +++---
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 8b354e81ab22..60e283cf22be 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1172,13 +1172,13 @@ static inline bool __pmdp_test_and_clear_young(struct mm_struct *mm,
 	return ((old & _PAGE_ACCESSED) != 0);
 }
 
-static inline int __pudp_test_and_clear_young(struct mm_struct *mm,
-					      unsigned long addr, pud_t *pudp)
+static inline bool __pudp_test_and_clear_young(struct mm_struct *mm,
+		unsigned long addr, pud_t *pudp)
 {
 	unsigned long old;
 
 	if ((pud_raw(*pudp) & cpu_to_be64(_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
-		return 0;
+		return false;
 	old = pud_hugepage_update(mm, addr, pudp, _PAGE_ACCESSED, 0);
 	return ((old & _PAGE_ACCESSED) != 0);
 }
@@ -1303,8 +1303,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
 bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp);
 #define __HAVE_ARCH_PUDP_TEST_AND_CLEAR_YOUNG
-extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
-				     unsigned long address, pud_t *pudp);
+bool pudp_test_and_clear_young(struct vm_area_struct *vma,
+		unsigned long address, pud_t *pudp);
 
 
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index c584321e3d41..ddc766e95855 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -104,8 +104,8 @@ bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
 	return __pmdp_test_and_clear_young(vma->vm_mm, address, pmdp);
 }
 
-int pudp_test_and_clear_young(struct vm_area_struct *vma,
-			      unsigned long address, pud_t *pudp)
+bool pudp_test_and_clear_young(struct vm_area_struct *vma,
+		unsigned long address, pud_t *pudp)
 {
 	return __pudp_test_and_clear_young(vma->vm_mm, address, pudp);
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 67e7746e3fbe..a6e0eaba2653 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -1109,8 +1109,8 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
 	return ptep_set_access_flags(vma, address, (pte_t *)pudp, pud_pte(entry), dirty);
 }
 
-static inline int pudp_test_and_clear_young(struct vm_area_struct *vma,
-					    unsigned long address, pud_t *pudp)
+static inline bool pudp_test_and_clear_young(struct vm_area_struct *vma,
+		unsigned long address, pud_t *pudp)
 {
 	return ptep_test_and_clear_young(vma, address, (pte_t *)pudp);
 }
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 6c8f2b17d3f9..13e3e9a054cb 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1297,8 +1297,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t *pmdp);
-extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
-				     unsigned long addr, pud_t *pudp);
+bool pudp_test_and_clear_young(struct vm_area_struct *vma,
+		unsigned long addr, pud_t *pudp);
 
 #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
 bool pmdp_clear_flush_young(struct vm_area_struct *vma,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index fc1c996c5b2d..da7f0a03cf90 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -470,10 +470,10 @@ bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
 #endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-int pudp_test_and_clear_young(struct vm_area_struct *vma,
-			      unsigned long addr, pud_t *pudp)
+bool pudp_test_and_clear_young(struct vm_area_struct *vma,
+		unsigned long addr, pud_t *pudp)
 {
-	int ret = 0;
+	bool ret = false;
 
 	if (pud_young(*pudp))
 		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
-- 
2.47.3


