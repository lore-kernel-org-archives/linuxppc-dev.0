Return-Path: <linuxppc-dev+bounces-18408-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FCF1088E74
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 03:24:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbrf903M5z2ytj;
	Thu, 19 Mar 2026 14:24:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773890672;
	cv=none; b=cv2iOVHTbr1dyw0jSgF0d/yRrYpIcm+X9yPYEAcL9d6d48K/+nrBcLWn0PsKisnAxFwDq0bZSA5Sg0SYkAJqyBZuvVQANd/aai8rLDhf31UD3TbE1sbra+Ymt/nlCbhvjTf+yBT2Fgm4lME7Pfc//7sq+5bY9EQ5cUTiO+eSfkOVX6vO0Yf13OYG8jbrCwLW8EQSfnZiTNQ4K1ybPNH0LPgsIAARlwsUZd9dA5/rSTjRM9tJRT9wLhmtzZElq5mPFXW8NlwxFK7Zu/huTrjKCf6IhvuR3Sddx1Gp2jiIhDZ6grJj1AqcdAmWAoKFcM+64D9dFlJljgGsZzxu6fSGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773890672; c=relaxed/relaxed;
	bh=6jNODp3wp4DROUhBG8kpRzhyFycKpwSYO5gu6salJm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCoxDJ5BTswAX/vXcrwOtRB8i102DooMPFgAn6+hKZgYOKVxRjfTueoP9s6GjUYdwEcZZ09qFxztiDP1FfYDrrewkko3pNaODGcjS3tW0LynkAOJea5VByoDZtP4mCSJlRfge89nwnBM1jJWvqHZf1+bpMV9f7/SfYaTUwAVaY3pAaoW7TH01NS/iNxhx6MK/H6KEaZAkDzOz5MAUIvF6qxmkZVjNTo8bTg+LxMaOKrAs6FV2pbQ+P3/HdEQdpNOL60JO+g/phV7e+uEHm+6E+1h9euZyzLBnhKGz+N9GEKpb7JhFN8xp1HSbRUhcgPJ+q7JqGoYMQPN0/HvjSfI7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mKUk+6SK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mKUk+6SK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbrf50VJGz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 14:24:28 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773890664; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6jNODp3wp4DROUhBG8kpRzhyFycKpwSYO5gu6salJm0=;
	b=mKUk+6SKDCmmeY5Q7msKhu32EuxcZIg+i3WeXd1dfUG8kr7ct97KxQns/EDjbVrajl2/LKJK3Z1FADZhzCTMK2KFsjXg52lYG5n057qbg+QaBRIo9ivzWokvw+pX+rGG60vB/yO7xO2whPoCkCPGLUjMQP1vexIOMDkc2TGj8W8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.Gt-DE_1773890662;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.Gt-DE_1773890662 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 11:24:23 +0800
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
Subject: [PATCH 4/6] mm: change to return bool for pmdp_clear_flush_young()
Date: Thu, 19 Mar 2026 11:24:03 +0800
Message-ID: <eb513ed809685f78e0abdeb7f7b6ebdec0fcca18.1773890510.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
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

The pmdp_clear_flush_young() is used to clear the young flag and flush the
TLB, returning whether the young flag was set for this PMD entry. Change
the return type to bool to make the intention clearer.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/s390/include/asm/pgtable.h |  4 ++--
 arch/x86/include/asm/pgtable.h  |  4 ++--
 arch/x86/mm/pgtable.c           |  6 +++---
 include/linux/pgtable.h         | 10 +++++-----
 mm/pgtable-generic.c            |  7 ++++---
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 1f5efb7be71d..90bba85ca4b8 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1693,8 +1693,8 @@ static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
 }
 
 #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
-static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
-					 unsigned long addr, pmd_t *pmdp)
+static inline bool pmdp_clear_flush_young(struct vm_area_struct *vma,
+					  unsigned long addr, pmd_t *pmdp)
 {
 	VM_BUG_ON(addr & ~HPAGE_MASK);
 	return pmdp_test_and_clear_young(vma, addr, pmdp);
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index bd02ee730a23..f9439449c9bd 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1301,8 +1301,8 @@ extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
 				     unsigned long addr, pud_t *pudp);
 
 #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
-extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
-				  unsigned long address, pmd_t *pmdp);
+extern bool pmdp_clear_flush_young(struct vm_area_struct *vma,
+				   unsigned long address, pmd_t *pmdp);
 
 
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 10a5e0b2be36..8c336edf0e65 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -503,10 +503,10 @@ bool ptep_clear_flush_young(struct vm_area_struct *vma,
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-int pmdp_clear_flush_young(struct vm_area_struct *vma,
-			   unsigned long address, pmd_t *pmdp)
+bool pmdp_clear_flush_young(struct vm_area_struct *vma,
+			    unsigned long address, pmd_t *pmdp)
 {
-	int young;
+	bool young;
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e53220b0a9a3..8b8838f19af3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -536,18 +536,18 @@ bool ptep_clear_flush_young(struct vm_area_struct *vma,
 
 #ifndef __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
-				  unsigned long address, pmd_t *pmdp);
+bool pmdp_clear_flush_young(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp);
 #else
 /*
  * Despite relevant to THP only, this API is called from generic rmap code
  * under PageTransHuge(), hence needs a dummy implementation for !THP
  */
-static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
-					 unsigned long address, pmd_t *pmdp)
+static inline bool pmdp_clear_flush_young(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp)
 {
 	BUILD_BUG();
-	return 0;
+	return false;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index db0ee918b08a..b91b1a98029c 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -124,10 +124,11 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
 #endif
 
 #ifndef __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
-int pmdp_clear_flush_young(struct vm_area_struct *vma,
-			   unsigned long address, pmd_t *pmdp)
+bool pmdp_clear_flush_young(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp)
 {
-	int young;
+	bool young;
+
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	young = pmdp_test_and_clear_young(vma, address, pmdp);
 	if (young)
-- 
2.47.3


