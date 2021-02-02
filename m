Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A082C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 01:05:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FF564F50
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 01:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FF564F50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DVk483QyPzDwmr
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:04:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630;
 helo=mail-pl1-x630.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=BLtpKFo+; dkim-atps=neutral
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DVMSK2H31zDqgf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2021 22:06:08 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id u11so12244471plg.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Feb 2021 03:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6FRU9caWwWjvnrqszVqRsss5Upxnc33B3OfV8qLPoO8=;
 b=BLtpKFo+BgRlVpQQW3j8ZC4sQb7LUbMNxR9OvdZjYaGP3RrS6ZT9VkH/tfNgwrPXtW
 9rwl2g6E+WtOCQt4/ObVgzVNxX+JaJcrhE+itbc2msKRMNrNHilpd0PU73XKs0V+U665
 3QmQ7blDhtImH6Q9CMppiW4wQHpLr6snoHRrZ60Nlh5mWe4r+7Jyj3qraTpur6KnSx+S
 cSR3FiRUoSyITY3FZ1B/ieQp/GcyFpRs33NQJKPasX5U0hcIswq23D/F49PA1cvS3voZ
 PPjdbU7uFiZS0BOgFJHqfSD0MQ4VxgWB05EQgTr9dfCdKCSpP9Q/2WQYgwSw7WirAe41
 9wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6FRU9caWwWjvnrqszVqRsss5Upxnc33B3OfV8qLPoO8=;
 b=gzLS03pa/qdDmUKqp4RkMVVSdbwNTU6EgB4vVRXONovY5iOIhUVoxKxhQDBFqdyYjr
 4WjTSVK32X+5OENsk3EsQge6kZ5iGLFsEvZcopgn0RDrimQSQfM1PzM8EWi/SehYJFH4
 ReiRixdMYHTILs6McwEwEOfBZmVcgKudZBYEYHT2yxahheJVB9mZjXSScFLAi3cF07DO
 jWYoyR9+y3Qx0vNv0KgdNgrSHmPlSXTRznmA5q7n+iADwkQpRBhqeGGn3MDilJu4X506
 JBEpBPSg7X9cMcKSdFQjcZyTVzkS9lrMQX9OCDUARkfNMlZU0PLAAiLYF8yIKl6pHcat
 uSVw==
X-Gm-Message-State: AOAM532vmKpJlmXO3PHz0Zs2fNHK53hPPuc4GXx8TA2ua/rdNfHps/6w
 Bw+h94JKeNUMM/QUMQSILc4=
X-Google-Smtp-Source: ABdhPJxy5wuhLIGB5shBbmYaQt0JzKzJciEj6N12Zja8o8hEmPFloC9t+TSQo+EwkfIa1vbuWeaUdg==
X-Received: by 2002:a17:90a:6c26:: with SMTP id
 x35mr3834636pjj.52.1612263966435; 
 Tue, 02 Feb 2021 03:06:06 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-242-11-44.static.tpgi.com.au.
 [60.242.11.44])
 by smtp.gmail.com with ESMTPSA id g19sm3188979pfk.113.2021.02.02.03.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 03:06:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v12 07/14] powerpc: inline huge vmap supported functions
Date: Tue,  2 Feb 2021 21:05:08 +1000
Message-Id: <20210202110515.3575274-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210202110515.3575274-1-npiggin@gmail.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
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
Cc: linux-arch@vger.kernel.org, Ding Tianhong <dingtianhong@huawei.com>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This allows unsupported levels to be constant folded away, and so
p4d_free_pud_page can be removed because it's no longer linked to.

Cc: linuxppc-dev@lists.ozlabs.org
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/vmalloc.h       | 19 ++++++++++++++++---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 21 ---------------------
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/vmalloc.h b/arch/powerpc/include/asm/vmalloc.h
index 105abb73f075..3f0c153befb0 100644
--- a/arch/powerpc/include/asm/vmalloc.h
+++ b/arch/powerpc/include/asm/vmalloc.h
@@ -1,12 +1,25 @@
 #ifndef _ASM_POWERPC_VMALLOC_H
 #define _ASM_POWERPC_VMALLOC_H
 
+#include <asm/mmu.h>
 #include <asm/page.h>
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-bool arch_vmap_p4d_supported(pgprot_t prot);
-bool arch_vmap_pud_supported(pgprot_t prot);
-bool arch_vmap_pmd_supported(pgprot_t prot);
+static inline bool arch_vmap_p4d_supported(pgprot_t prot)
+{
+	return false;
+}
+
+static inline bool arch_vmap_pud_supported(pgprot_t prot)
+{
+	/* HPT does not cope with large pages in the vmalloc area */
+	return radix_enabled();
+}
+
+static inline bool arch_vmap_pmd_supported(pgprot_t prot)
+{
+	return radix_enabled();
+}
 #endif
 
 #endif /* _ASM_POWERPC_VMALLOC_H */
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 743807fc210f..8da62afccee5 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1082,22 +1082,6 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
 	set_pte_at(mm, addr, ptep, pte);
 }
 
-bool arch_vmap_pud_supported(pgprot_t prot)
-{
-	/* HPT does not cope with large pages in the vmalloc area */
-	return radix_enabled();
-}
-
-bool arch_vmap_pmd_supported(pgprot_t prot)
-{
-	return radix_enabled();
-}
-
-int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
-{
-	return 0;
-}
-
 int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 {
 	pte_t *ptep = (pte_t *)pud;
@@ -1181,8 +1165,3 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 	return 1;
 }
-
-bool arch_vmap_p4d_supported(pgprot_t prot)
-{
-	return false;
-}
-- 
2.23.0

