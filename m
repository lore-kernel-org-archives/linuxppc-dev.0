Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9A7606A801
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1M0fii6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJkzQ46y3z2xjP;
	Tue, 03 Nov 2026 21:17:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793701074;
	cv=none; b=jCgr5sL5HANt8hpgV4JyZuttRsXNPAX/fsDgQSiuFqipTg1Irj8LfjywAbMrZVQB25rPnVT/lFGrpLBxVe23JQjfEVeqBUxcr6Wbl8BB/xlzDO0kVjz9fPjJN8PItK6D9vbZfQoMu5adP7bOHTzsXQbTC4rLmzTtvmSDBNYx4psk2wgeZ0rEy0iFN04WDn5viIdQAVwypYehJ+ot74sRfioMZjYf9pQdebLKKkAoxdNDXZgnU08c9IEIo1niAJ6orcLOCxVtDxAXn241v3Lq5jMQlQ8heymxkF0O8KlU/vEmJnQEye+wNPkfFLA3DAGoBXOX84VUI6rsNvKZS5dlfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793701074; c=relaxed/relaxed;
	bh=QQZGTVWVxsbky0R5YyDomc+9xqg3NrjJBS/7gn3/iEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GC88yiomGfyKp4agbwAYBisGzKDWWKFPomlYagRw3ZeNrxpc/2b4zATpTnNtZ6k7y99LbiU0GR7pJZL96FvaLdRMmcjzw9F8aS9CwvZagGPHeXk6Wu/TRadcesMSgZMVx1/gbA9q8X6gAu7ymLK1MfDfLdwxbP1oWAKqe97FOzp+VvJT/3TtFtBN6XNKlASXiz30UNIT1citlLawOov8bS4xHUFGx0dRatd/MvSpNPl45KMI76NQV7/SyCCwxPt3Z/8wyDALXadGYft6P9x0PHgla3U/l42JgDgJTrFRJBKUHoen8o9P6T07JqHoIG/Nc/SQ6/NX5jpJtb6+B+UOcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1M0fii6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1M0fii6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkzP62Glz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 21:17:53 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-36a18fc7a38so7564992eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701072; x=1794305872; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQZGTVWVxsbky0R5YyDomc+9xqg3NrjJBS/7gn3/iEE=;
        b=O1M0fii60X5l3jlAj/JrQiIbn+aizyFQCjz1Uz1xi5TX8qt/oF8vacix2rJwxjduh5
         hEXYqTvQoATcqz9yC0Dss2fg7TmReWoniKD0yXu5Wbw8uxF1xRMwkkK2Lag4msbn5BES
         jbVnpDCbNxwggLxbE1AM+p8zxZUvyJFbxA5pbk/ItdANaDnjjs+eDrJsZsKgUrAH1+Bl
         ES5uZ5/Ga5IyLjE6qXNmD9hH5quaqQcdtDW/PqfxokbpbfdIDOeMWNlluqBjfHWZpFIT
         Z3zCuAfcXb7qzpFewR9zTluqePbusge66ng8+vH53GssAxFMl24Lhfe6Rn6/09PD5aN4
         HoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701072; x=1794305872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQZGTVWVxsbky0R5YyDomc+9xqg3NrjJBS/7gn3/iEE=;
        b=ptcUUjmuMXVwGn5dfkw9jKqdZ0YA7VCQSZa7yyXNHHaDwHvzE70SUK9lUWbokncm1Z
         rVzFOyBoJLJbSb+9FdXRl3Fj3F4Z6SMCcp/lBZlFMPIjNcrxpVvRKl4E3xkpY9njEMWF
         xmcpqZXDdsZnGtHPrHh2R1Ll0pob7sf98IKRm5RppLpl8hjdi8ppb2UPXB1+TkcdYELb
         W4rPEhk77Wl+SmYLuHaBRld+IyiFaHWYlvA/BF7+eouTWk4/rYJSiVS3oUaY2rieelMP
         Yuxywmn60MYc7Nu961/p/zMhF9LO2wggKwUDFRwcJl52WwKP8SxBwobd9uqG16pUMoCX
         VJ6w==
X-Forwarded-Encrypted: i=1; AKwUvBxKQ1pmg4MTO5edoTTFGwhJGj+x+hvA0AvEX5TV1A8t4xnNxuIgM6/bdvH7ooUVBHfnU5uooxAp6TZbRK4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+93SZypewwbVe3y6CoN58AmTW2ox+oRfoU8w42TOdXdAcYdBx3
	qxnCOnc1dZpnIgMPv6TwaDYA9byjWuoeCrNuLCJTSoBJBhQ58sw4JYJY
X-Gm-Gg: AYBFou3bL0XbIVQkku4DZ7uQJv907yAewoikunCjguOI0kOaKHAJGi8MS+vZPPTFbm3
	K6iisMxst4jOQxXlz2cAVla5Cp8OfSdxDpKA23j61qUChSAHnqbb4n68Io8eex+7xPHtGgU5YbF
	SO/iMgGhnOnFn8sL87zsZLAynjgBVFjYDzjGh+23UZKtl/+PlBl/QZdVq7E4OQ3o44RZ44dvRr8
	9rBT9DV997HLn3xyGZQugKM4hpX9h/RDzE7VVbOom1FPeVnRKNMH4PwmWAMwPHj548Kmk0Ca/9k
	QWY7qSExvuHgvFwRHVlv1xCTk0/GJqwy8WPRkgY8mIER02jPicNWstJ41ciySK1bfMHvoGSjB0X
	dmWpA+SWipy/M+FQbQ449zokgwHFqXU8JCuaVjlf6hbdb6uZfPVayBBY0fJ6HdgCeLgNjBtZHZd
	CqlnRx5VoSTBsoEDjx2mIcnsshiDRBADKlrqjCgKK2qfzCn/rzZ5vUeBWVbliLOinijn7qVGFfp
	152cRcXn2dKYnyGsK6iQIWzutekNQ3ITyaFIeMrT2asCVChLmorF9KJIclYZxz1YW8uamJOQ6IF
	H94osYSLCVDAWkmZ2oB+f0qz/mnSeA==
X-Received: by 2002:a05:7301:2a95:b0:36c:9afe:fcd8 with SMTP id 5a478bee46e88-36c9afefe8dmr518555eec.30.1793701071962;
        Tue, 03 Nov 2026 02:17:51 -0800 (PST)
Received: from 027.. ([2409:8a20:4a5:7150:84fc:ce3c:7b09:dbca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm53145387eec.15.2026.11.03.02.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:17:51 -0800 (PST)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	linux-mm@kvack.org,
	urezki@gmail.com,
	will@kernel.org
Cc: Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com,
	anshuman.khandual@arm.com,
	baohua@kernel.org,
	chleroy@kernel.org,
	david@kernel.org,
	dev.jain@arm.com,
	jiangwen6@xiaomi.com,
	leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: [PATCH v11 06/10] mm/vmalloc: extract vmap_set_ptes() to consolidate PTE mapping logic
Date: Tue,  3 Nov 2026 18:16:54 +0800
Message-Id: <20261103101658.766905-7-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
References: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wen Jiang <jiangwen6@xiaomi.com>

Extract the common PTE mapping logic from vmap_pte_range() into a
shared helper vmap_set_ptes(). This handles both CONT_PTE and regular
PTE mappings in a single function, preparing for the next patch which
will extend vmap_pages_pte_range() to also use this helper.

No functional change.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
---
 mm/vmalloc.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index df37c8490ae7..e3ea9581e68d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -92,6 +92,29 @@ struct vfree_deferred {
 static DEFINE_PER_CPU(struct vfree_deferred, vfree_deferred);
 
 /*** Page table manipulation functions ***/
+
+/*
+ * Try contiguous mappings at the PTE level for arches which support them, and if
+ * requested by the caller. Fall back to PAGE_SIZE mappings otherwise.
+ *
+ * Return: mapping size.
+ */
+static __always_inline unsigned long vmap_set_ptes(pte_t *ptep,
+		unsigned long addr, unsigned long end, u64 pfn,
+		pgprot_t prot, unsigned int max_page_shift)
+{
+	unsigned long size;
+
+	size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
+	if (size != PAGE_SIZE) {
+		vmap_pte_set_huge(ptep, addr, PFN_PHYS(pfn), prot, size);
+		return size;
+	}
+
+	set_pte_at(&init_mm, addr, ptep, pfn_pte(pfn, prot));
+	return PAGE_SIZE;
+}
+
 static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift, pgtbl_mod_mask *mask)
@@ -100,6 +123,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	u64 pfn;
 	struct page *page;
 	unsigned long size;
+	unsigned int nr_pages;
 
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
 		return -EINVAL;
@@ -120,15 +144,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			BUG();
 		}
 
-		size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
-		if (size != PAGE_SIZE) {
-			vmap_pte_set_huge(pte, addr, PFN_PHYS(pfn), prot, size);
-			pfn += PFN_DOWN(size);
-			continue;
-		}
-		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
-		pfn++;
-	} while (pte += PFN_DOWN(size), addr += size, addr != end);
+		size = vmap_set_ptes(pte, addr, end, pfn, prot, max_page_shift);
+		nr_pages = PFN_DOWN(size);
+	} while (pte += nr_pages, pfn += nr_pages, addr += size, addr != end);
 
 	lazy_mmu_mode_disable();
 	*mask |= PGTBL_PTE_MODIFIED;
-- 
2.34.1


