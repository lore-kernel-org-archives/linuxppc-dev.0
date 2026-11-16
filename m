Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B7606A329
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YN6vXP2/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSnkc6bSLz30WF;
	Mon, 16 Nov 2026 23:49:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794833384;
	cv=none; b=UwD5VADcjMNaGWykC6Qh3Apyl/iXQSIfmxyTD38t66D7bTBxjhEF+t0VJ/5lQZv31efG796Cbmri4buV4ndNgcOkuDGZLl3Bve+CYmbrcUesKW17ZuB1lMjgw+OIXQqyhpgHKHBs5He514oiT1KdCHGLHpDdN/W4lcA/vjxy1RPEdb9M8AGayJFlwjTCMaCdee5HNDvY03bvlmzIvd2rXUnipTkhVQjXp9vo1C4KVa4hLRNEjcaxYl3/QJzOxnGvoRMBFPwBQ6bddJru0LUjlDoWjqRDU6e/3RSXvTa4phe7T01jGY/zOr5AUxMxnQ4Yc4kTFiQK5SR/pBozFqSj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794833384; c=relaxed/relaxed;
	bh=SkKlFLJh0bHRqw2u6qo7FKqMD2VqM3GiEa/4Vt9PFN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFTn6HjJcSakTG+AAWxGd7kKsaLWie9BMqcc1MhhnRAFvsY61LA4U3IBL1UpU5IPWDN9znJyjLU9Y4gIWGqQD86e9/MDPuaCeERYcZHv6gUaqxY3zJDxYBCvA5K5VSccxGVmCi3vN0Ee54rGCuA92pnEMDH12Z4bDgrPQq0jeF6F+0hHlmqHMhzHPbwiyegXtsegqJoeTZWAxoBcMsS0bwoqMr/5jy2no5vf1G90VuMjjAQOqEl531LMa+fV+M87BivpAePL0OdwTNUrdj36g2m2SCoqBj5C3iuv6sGHg/PoDqLvVRYMbz5Xzqd5KJFONPkZ6XmAjv/Pm3qS6DmeIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YN6vXP2/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YN6vXP2/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSnkc2jy5z30VX
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 23:49:44 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D84A84472D;
	Mon, 16 Nov 2026 12:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7A81F000C4;
	Mon, 16 Nov 2026 12:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833382;
	bh=SkKlFLJh0bHRqw2u6qo7FKqMD2VqM3GiEa/4Vt9PFN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YN6vXP2/30cO412t3zjUajzb81yQ99gS8AJH9uEGiLmyUcS+qgSf/HMMiYqZRaboR
	 ZUFcOr5HG9bo2sXqK49utjfTBexB9GVMo4s30Q88My/RcnmlqYraEayTKRWAaUPYBv
	 gJD87jCCGbOS1fLcEpdk6WBb9etOKPgjDOEYZ83r/ZxRTQUrtiQYy4ZjKVlbAQ0+AG
	 gOt7Oq3YkH4zTVirFjUmewxyf0ab6ZbbxAwI2IJ2lwpk9XMrXjGusor5THb7GEcBg7
	 cbyEw+CgHbue8NDj72vH/de54rhuF8daoE/kSNW/EKSHRf3CGYKQi/RoPfiBxBVMN6
	 r2cGCwk/VJD7A==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linusw@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [PATCH v3 10/10] mm: print pte in __print_bad_page_map_pgtable()
Date: Mon, 16 Nov 2026 13:48:32 +0100
Message-ID: <20261116124832.662455-11-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116124832.662455-1-arnd@kernel.org>
References: <20261116124832.662455-1-arnd@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arnd Bergmann <arnd@arndb.de>

HIGHPTE support is gone now, so it's easy enough to print the
PTE here along with the upper level entries.

Acked-by: "David Hildenbrand (Arm)" <david@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/memory.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ec3d9d99ccee..6404bb447d9c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -528,9 +528,11 @@ static void __print_bad_page_map_pgtable(struct mm_struct *mm, unsigned long add
 	char p4d_str[PTVAL_STR_MAX];
 	char pud_str[PTVAL_STR_MAX];
 	char pmd_str[PTVAL_STR_MAX];
+	char pte_str[PTVAL_STR_MAX];
 	p4d_t p4d, *p4dp;
 	pud_t pud, *pudp;
 	pmd_t pmd, *pmdp;
+	pte_t pte, *ptep;
 	pgd_t *pgdp;
 
 	/*
@@ -567,13 +569,18 @@ static void __print_bad_page_map_pgtable(struct mm_struct *mm, unsigned long add
 	pmd = pmdp_get(pmdp);
 	ptval_to_str(pmd_str, pmd_val(pmd));
 
-	/*
-	 * Dumping the PTE would be nice, but it's tricky with CONFIG_HIGHPTE,
-	 * because the table should already be mapped by the caller and
-	 * doing another map would be bad. print_bad_page_map() should
-	 * already take care of printing the PTE.
-	 */
-	pr_alert("pgd:%s p4d:%s pud:%s pmd:%s\n", pgd_str, p4d_str, pud_str, pmd_str);
+	if (!pmd_present(pmd) || pmd_leaf(pmd)) {
+		pr_alert("pgd:%s p4d:%s pud:%s pmd: %s\n",
+			 pgd_str, p4d_str, pud_str, pmd_str);
+		return;
+	}
+
+	ptep = pte_offset_kernel(pmdp, addr);
+	pte = ptep_get(ptep);
+	ptval_to_str(pte_str, pte_val(pte));
+
+	pr_alert("pgd:%s p4d:%s pud:%s pmd:%s pte:%s\n",
+		 pgd_str, p4d_str, pud_str, pmd_str, pte_str);
 }
 
 /*
-- 
2.53.0


