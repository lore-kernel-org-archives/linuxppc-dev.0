Return-Path: <SRS0=lwUg=B7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A524C433E1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 15:21:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95CF2076E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 15:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvO/x3Lt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95CF2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BY4wh3LdtzDrBv
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Aug 2020 01:21:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=qvO/x3Lt; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BY4kr4n24zDqKf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2020 01:12:36 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id o13so1148819pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2020 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6FG53WANq96sGtoLSKrRzKN8EzzN/tCT8YeKUFryJxY=;
 b=qvO/x3LtuaWlzcRhfPRLNEAe+GmybLzPFd7TEDFfOiyJmw+WP/6BCuv7hyJuIxepte
 O8KDlYVX3ZQPdFw9zdlj57D8yw9Z6HeZXTn+Jm4YJA/kS7GU+MqF9x79PhCSvZcsEMVb
 XgfFKtwdZXMQ8ZoHAgH1Cl71OsLEN8hbyJrGrMDMb395P2issbN1XnfwEJo2JTlI/SXx
 DNXc1HnnxQz1u0FAKVB/p99YAbpu3gxrWalr7KOCWmuhD4u+uU4rpsLt+9ZiDXMoumHs
 L0Gm3rnnXdrnqMcXUEpiEzcVuknJM0Wov1F9YY7hzA01QFOErb5x3ckuVNqV9DoQ/+wn
 iqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6FG53WANq96sGtoLSKrRzKN8EzzN/tCT8YeKUFryJxY=;
 b=USYPfZ6+5zBLS3okK03rUHxsGAzk+pPyIsSxnx3qsy9GzzC8wgC89Ju/9ycyzy2+OO
 tZpaXLPqH9J2mD6pI6Zf+KtXSYCemhSUULBDsZcpINuyEFHcYSZVTVE3LI6jQmGn8W/d
 30d+zLl5V/jmozCTHfA0xS8j/VzTBoo48Fk5gG9ILo0IDcU+YukGmcNpysilPXXb9aq0
 h8ulNz93ShaKcoZywTeO3Hui6iUuSdDx4CdyyE/ocKY12Vc00vLqWlbxC7e0Gr/n6VvT
 uiwVJ4f5CabLh8/ZS+7NLM8hmZdU8Ey1vN+5TKsSKqwf+mKxYF08zZtwG8koibUzRNpg
 CHsA==
X-Gm-Message-State: AOAM531kA/BHccOGy+yIi6M89wuSGiA5s4/rEsAwu9H3wJWXhyMIoKzx
 7SBu7J3Nylq7uzFcg6Kityg=
X-Google-Smtp-Source: ABdhPJy2Q9rer+Gnc26wp0mgrvwzTqrrWkAV8Nt9IOzjPIJnUZWKJPJYiQTyxAK2BfQo5m1wdj6VAg==
X-Received: by 2002:a63:2324:: with SMTP id j36mr2705340pgj.221.1598022753623; 
 Fri, 21 Aug 2020 08:12:33 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
 by smtp.gmail.com with ESMTPSA id s8sm3126985pfc.122.2020.08.21.08.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 08:12:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 01/12] mm/vmalloc: fix vmalloc_to_page for huge vmap
 mappings
Date: Sat, 22 Aug 2020 01:12:05 +1000
Message-Id: <20200821151216.1005117-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200821151216.1005117-1-npiggin@gmail.com>
References: <20200821151216.1005117-1-npiggin@gmail.com>
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Zefan Li <lizefan@huawei.com>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

vmalloc_to_page returns NULL for addresses mapped by larger pages[*].
Whether or not a vmap is huge depends on the architecture details,
alignments, boot options, etc., which the caller can not be expected
to know. Therefore HUGE_VMAP is a regression for vmalloc_to_page.

This change teaches vmalloc_to_page about larger pages, and returns
the struct page that corresponds to the offset within the large page.
This makes the API agnostic to mapping implementation details.

[*] As explained by commit 029c54b095995 ("mm/vmalloc.c: huge-vmap:
    fail gracefully on unexpected huge vmap mappings")

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b482d240f9a2..4e9b21adc73d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -36,7 +36,7 @@
 #include <linux/bitops.h>
 #include <linux/rbtree_augmented.h>
 #include <linux/overflow.h>
-
+#include <linux/pgtable.h>
 #include <linux/uaccess.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
@@ -343,7 +343,9 @@ int is_vmalloc_or_module_addr(const void *x)
 }
 
 /*
- * Walk a vmap address to the struct page it maps.
+ * Walk a vmap address to the struct page it maps. Huge vmap mappings will
+ * return the tail page that corresponds to the base page address, which
+ * matches small vmap mappings.
  */
 struct page *vmalloc_to_page(const void *vmalloc_addr)
 {
@@ -363,25 +365,33 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 
 	if (pgd_none(*pgd))
 		return NULL;
+	if (WARN_ON_ONCE(pgd_leaf(*pgd)))
+		return NULL; /* XXX: no allowance for huge pgd */
+	if (WARN_ON_ONCE(pgd_bad(*pgd)))
+		return NULL;
+
 	p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d))
 		return NULL;
-	pud = pud_offset(p4d, addr);
+	if (p4d_leaf(*p4d))
+		return p4d_page(*p4d) + ((addr & ~P4D_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(p4d_bad(*p4d)))
+		return NULL;
 
-	/*
-	 * Don't dereference bad PUD or PMD (below) entries. This will also
-	 * identify huge mappings, which we may encounter on architectures
-	 * that define CONFIG_HAVE_ARCH_HUGE_VMAP=y. Such regions will be
-	 * identified as vmalloc addresses by is_vmalloc_addr(), but are
-	 * not [unambiguously] associated with a struct page, so there is
-	 * no correct value to return for them.
-	 */
-	WARN_ON_ONCE(pud_bad(*pud));
-	if (pud_none(*pud) || pud_bad(*pud))
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud))
+		return NULL;
+	if (pud_leaf(*pud))
+		return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(pud_bad(*pud)))
 		return NULL;
+
 	pmd = pmd_offset(pud, addr);
-	WARN_ON_ONCE(pmd_bad(*pmd));
-	if (pmd_none(*pmd) || pmd_bad(*pmd))
+	if (pmd_none(*pmd))
+		return NULL;
+	if (pmd_leaf(*pmd))
+		return pmd_page(*pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(pmd_bad(*pmd)))
 		return NULL;
 
 	ptep = pte_offset_map(pmd, addr);
@@ -389,6 +399,7 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 	if (pte_present(pte))
 		page = pte_page(pte);
 	pte_unmap(ptep);
+
 	return page;
 }
 EXPORT_SYMBOL(vmalloc_to_page);
-- 
2.23.0

