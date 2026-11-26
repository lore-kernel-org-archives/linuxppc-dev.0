Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE591606A32A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6JaML8N
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvBp4yFXz3bNr;
	Thu, 26 Nov 2026 22:16:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691810;
	cv=none; b=nSkikRogKdYw2fBZal35QsimyvZM/cRHul5uQEobQFv5/5wccUW4DTU4XVP41I6ZGwIJfFZH6LvbyfsQE4D1TI2KA/eIXdGvQADg4NNryKoC9GWY1x3cGflYTnEa66Rrd0VbAGEUEEIIr5GuOhIeomTBbXJa3J3bVmu3LyuumO9xIFw9f5mV4BfeaqJcVN/MUgPht6tTZGwyyrjGOhDomStVK6cNxZcxfYff4fKRNY2WPzhpsOKZ+loxyUb92QMQ1580fmiHAKqSDNyxx7uvraJUzZjZwWV165nsUliGPm6AYflqbZTgeDJ7DUx10b1uKBYHdKfTm0ok044S/sRH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691810; c=relaxed/relaxed;
	bh=ia0IpFMuZ2KgIGlhSeCcR6ahLTVFLFvimBCAHBa8K7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m9SdF40FTTKxBb7qN2OnR6dhoDTsvda11aOooMImr0qxFLjfuxLOy0r2gtKwTA5NDXwgtIkPDedVVVcsffWcdRMhMwwvNbfwHtuNNr3WgGG2L6c28EESKlI5ZVHvEFXw547WtJVTgLtTVw+nucg1xIv8W7dC2OofgC7dk2tLXPjPx/wTmR/Ur+KFIqBHCHFHuvrbenV9gbSw/09lSsU03pgTQxSqiqhFmhoBKDsWPik8FP79dlJ17akzoBAGSFTh618MH4Rf5U5iNrmgwX7+b5iL8nHsBrwO9OsE194eBc5FoT8vMqYC8ckTnV2/FtSOFeHNddYpBFKlwKNEjwch/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6JaML8N; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6JaML8N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvBn6Tlnz2yNj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:16:49 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0DDCD62BFE;
	Thu, 26 Nov 2026 11:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB7F1F000C0;
	Thu, 26 Nov 2026 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691807;
	bh=ia0IpFMuZ2KgIGlhSeCcR6ahLTVFLFvimBCAHBa8K7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C6JaML8N2aNTeIzENf2nvr8+aQgkt9RA0b/lUdY93mcchmhUi11+e2a0tScZ3CniC
	 QcRTPjB5Vvm2IKDrI4w2dr9YP7aKd6XiEFEQSWgHsN3oqfBPSbyJh4msiz7bJhFJnY
	 iHdEmk5VqDZ48vtOq9/cNB+6cQtOxm6d8cwlsfOe1vf3GC7TxG6ITRc00G6AjGH+kS
	 B1xDuZEPBtfEFIxDXf4DYfMJfU9pqQnNKwdDbA+opSwvI0DnVrHPn5m+cXAEC5semk
	 KHjBJ98o8aoZmxj2R6CX3JQmkDMDMQuLboY0NzWq2S7adY5QVhdyX0S7Rlpx6YLmpG
	 3SAUQuPMNGeGg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:27 +0200
Subject: [PATCH RFC v2 14/54] x86/mm/pat: take pgd_lock only around the
 pgd_list walks
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-14-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CPA takes pgd_lock around the split decision, the update of a large page,
the split and the collapse of large pages.

Everywhere else pgd_lock protects pgd_list. CPA needs it only on 32-bit, to
update the per-pgd copies of the kernel PMD entries when it changes them.

Updates of large pages are serialized by cpa_lock anyway, and the direct
map counters are atomic.

Take pgd_lock only around the pgd_list walks.

Without pgd_lock, should_split_large_page() only checks CPA_REQ_SPLIT
before it calls __should_split_large_page(). Fold it into
__should_split_large_page() and keep the shorter name.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 56 +++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8076d29a2931..9dfe69d608b8 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -916,24 +916,29 @@ EXPORT_SYMBOL_GPL(slow_virt_to_phys);
  */
 static void __set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte)
 {
+	struct ptdesc *ptdesc;
+
+	if (!IS_ENABLED(CONFIG_X86_32)) {
+		set_pte_atomic(kpte, pte);
+		return;
+	}
+
+	guard(spinlock)(&pgd_lock);
+
 	/* change init_mm */
 	set_pte_atomic(kpte, pte);
 
-	if (IS_ENABLED(CONFIG_X86_32)) {
-		struct ptdesc *ptdesc;
-
-		list_for_each_entry(ptdesc, &pgd_list, pt_list) {
-			pgd_t *pgd;
-			p4d_t *p4d;
-			pud_t *pud;
-			pmd_t *pmd;
-
-			pgd = (pgd_t *)ptdesc_address(ptdesc) + pgd_index(address);
-			p4d = p4d_offset(pgd, address);
-			pud = pud_offset(p4d, address);
-			pmd = pmd_offset(pud, address);
-			set_pte_atomic((pte_t *)pmd, pte);
-		}
+	list_for_each_entry(ptdesc, &pgd_list, pt_list) {
+		pgd_t *pgd;
+		p4d_t *p4d;
+		pud_t *pud;
+		pmd_t *pmd;
+
+		pgd = (pgd_t *)ptdesc_address(ptdesc) + pgd_index(address);
+		p4d = p4d_offset(pgd, address);
+		pud = pud_offset(p4d, address);
+		pmd = pmd_offset(pud, address);
+		set_pte_atomic((pte_t *)pmd, pte);
 	}
 }
 
@@ -954,8 +959,8 @@ static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
 	return prot;
 }
 
-static int __should_split_large_page(pte_t *kpte, unsigned long address,
-				     struct cpa_data *cpa)
+static int should_split_large_page(pte_t *kpte, unsigned long address,
+				   struct cpa_data *cpa)
 {
 	unsigned long numpages, pmask, psize, lpaddr, pfn, old_pfn;
 	pgprot_t old_prot, new_prot, req_prot, chk_prot;
@@ -963,6 +968,9 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	enum pg_level level;
 	bool nx, rw;
 
+	if (cpa->flags & CPA_REQ_SPLIT)
+		return 1;
+
 	/*
 	 * Check for races, another CPU might have split this page
 	 * up already:
@@ -1101,16 +1109,6 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	return 0;
 }
 
-static int should_split_large_page(pte_t *kpte, unsigned long address,
-				   struct cpa_data *cpa)
-{
-	if (cpa->flags & CPA_REQ_SPLIT)
-		return 1;
-
-	guard(spinlock)(&pgd_lock);
-	return __should_split_large_page(kpte, address, cpa);
-}
-
 static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
 			  pgprot_t ref_prot, unsigned long address,
 			  unsigned long size)
@@ -1158,7 +1156,6 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	bool nx, rw;
 	pte_t *tmp;
 
-	guard(spinlock)(&pgd_lock);
 	/*
 	 * Check for races, another CPU might have split this page
 	 * up for us already:
@@ -1304,6 +1301,8 @@ static int collapse_pmd_page(pmd_t *pmd, unsigned long addr,
 			return 0;
 	}
 
+	guard(spinlock)(&pgd_lock);
+
 	old_pmd = *pmd;
 
 	/* Success: set up a large page */
@@ -1404,7 +1403,6 @@ static int collapse_large_pages(unsigned long addr, struct list_head *pgtables)
 
 	addr &= PMD_MASK;
 
-	guard(spinlock)(&pgd_lock);
 	pgd = pgd_offset_k(addr);
 	if (pgd_none(*pgd))
 		return 0;

-- 
2.53.0


