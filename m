Return-Path: <linuxppc-dev+bounces-24777-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C92C531FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 10:21:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h63sk0FyVz2yYd;
	Fri, 24 Jul 2026 20:20:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784888442;
	cv=none; b=a+rc9Et6pZHQRb1Z+KvdFotwkGuXXbgBKKuXovn1lhFIw3JnwLp1+fi29cFZisewZxks3it/pKM6oZph9jVV/Qhntm93mdvN3fCLS73O9d0KY+Qe5SdW/+jg9z9gMY4Cl2lMsqPIGnjxT9CIfNkq1j1J9E289ka2s2b+sZqGQBSuflXOrcdOknwROKITpDJs+1B/KdaYu8S7rDDCxzzPOA5n5/siWL2EoneC+q0iW0AyipxUSCADHh+4SwwlLCWLWgnngmmkm9FsumQP6hOgrt/qBqBpnJus8moUHl7OxNkwPQXFLk4qPegqNMGIourtPNPMB9HUJqQqYGfiCoFuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784888442; c=relaxed/relaxed;
	bh=mfE/8+iwZ8S6lsJKsovOA297WtRq/6z3EhWYSO8IBSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGL5YOFp1+TlvP2abuupuovBHdYLAAmz+GyiksWFvLbgKVQqzW0wUS2vlU9HCMeVOGmJqMdFZz2xDImxj6iv20VUaP6RUk5uh24CToOGQfP71spaGqpQR26q5Z2il2m9ibYnnrh4sPnEsSQkMIT0Ab9J3gq1BnfE5L0A14xoGltx/+zPLkGMUOad4JCCy7so6J2QsJhAdezPmZ4EXrBEw0jDAY3OsRut1EG3/Lmn6rr6IYz20CdQ9XI+ITbyOp24uZrD55bJsT89YvnYbAkFPDrDb08TBKOZJGe7ac6Nz8DfxiBo9i6QwmYfpsqi3YCP2p3kivT0rNLaOc9MEyt0aQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2XRde9Es; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nWFZqGyr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2XRde9Es; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nWFZqGyr; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2XRde9Es;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nWFZqGyr;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2XRde9Es;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nWFZqGyr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h63sh72YZz2yqX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 20:20:40 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 87BAA3EBC;
	Fri, 24 Jul 2026 10:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784888434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mfE/8+iwZ8S6lsJKsovOA297WtRq/6z3EhWYSO8IBSA=;
	b=2XRde9Es1Obd3JUQsYR9MjkLTwhjIiyHNuFAdEOJ9RBq9XN18bsHlLEQ3J0p03kAsBAYnA
	6UTwuwaRQzOagFacHFgrT2QAlgi2weAN4Xf3iJES29YoD5BLH0WG78W6M8cBeU6td7O2qi
	bzaeqHcA+Akxn4qZlZd6+oDTe7ydgSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784888434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mfE/8+iwZ8S6lsJKsovOA297WtRq/6z3EhWYSO8IBSA=;
	b=nWFZqGyrL7G2Rkn0DahcLSwiyr5XvmDdgAt6JLfipfgUhf8tu7CUZHpTxJ0N3OtXBaYDWK
	PH8FsXMzNkjgDuCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784888434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mfE/8+iwZ8S6lsJKsovOA297WtRq/6z3EhWYSO8IBSA=;
	b=2XRde9Es1Obd3JUQsYR9MjkLTwhjIiyHNuFAdEOJ9RBq9XN18bsHlLEQ3J0p03kAsBAYnA
	6UTwuwaRQzOagFacHFgrT2QAlgi2weAN4Xf3iJES29YoD5BLH0WG78W6M8cBeU6td7O2qi
	bzaeqHcA+Akxn4qZlZd6+oDTe7ydgSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784888434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mfE/8+iwZ8S6lsJKsovOA297WtRq/6z3EhWYSO8IBSA=;
	b=nWFZqGyrL7G2Rkn0DahcLSwiyr5XvmDdgAt6JLfipfgUhf8tu7CUZHpTxJ0N3OtXBaYDWK
	PH8FsXMzNkjgDuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06311779BA;
	Fri, 24 Jul 2026 10:20:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gJGlOW88Y2oSaQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 24 Jul 2026 10:20:31 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] mm: constify the pte_offset_map_ro_nolock() return value
Date: Fri, 24 Jul 2026 11:20:17 +0100
Message-ID: <20260724102017.141532-6-pfalcato@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724102017.141532-1-pfalcato@suse.de>
References: <20260724102017.141532-1-pfalcato@suse.de>
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
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[suse.de,arm.com,kernel.org,HansenPartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,infradead.org,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLxu57a9hfgn7tttf5jiwuqe5o)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]

Constify the pte_t * retval from pte_offset_map_ro_nolock(), for which it is
already pledged that accesses must be read-only. With it, convert the three
treewide users to use const pte_t *.

khugepaged passes the result right down to fault code (do_swap_page()). This
leads to a complicated set of conditions that, in order to be correct, must
not install anything into *vmf->pte. This is not trivial to work around in
fault code, and as such just trivially cast to non-const pte_t* in the
meantime.

The other users are far more trivial and the conversion is equally
trivially simple.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 arch/powerpc/mm/pgtable.c | 2 +-
 include/linux/mm.h        | 4 ++--
 include/linux/pgtable.h   | 2 +-
 mm/filemap.c              | 2 +-
 mm/khugepaged.c           | 2 +-
 mm/pgtable-generic.c      | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index a9be337be3e4..e29db41b6043 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -390,7 +390,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	const pte_t *pte;
 	spinlock_t *ptl;
 
 	if (mm == &init_mm)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 87feaa5a2b78..4b768639d31d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3887,8 +3887,8 @@ static inline pte_t *pte_offset_map(pmd_t *pmd, unsigned long addr)
 pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 			   unsigned long addr, spinlock_t **ptlp);
 
-pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
-				unsigned long addr, spinlock_t **ptlp);
+const pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
+				      unsigned long addr, spinlock_t **ptlp);
 pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long addr, pmd_t *pmdvalp,
 				spinlock_t **ptlp);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index dc418553e57a..dd51e722c535 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -112,7 +112,7 @@ static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
 {
 	return pte_offset_kernel(pmd, address);
 }
-static inline void pte_unmap(pte_t *pte)
+static inline void pte_unmap(const pte_t *pte)
 {
 	rcu_read_unlock();
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index 1dbb4c6f824e..4f0575f13b3a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3484,7 +3484,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
-	pte_t *ptep;
+	const pte_t *ptep;
 
 	/*
 	 * We might have COW'ed a pagecache folio and might now have an mlocked
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 27e8f3077e80..b87e23ad094f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1169,7 +1169,7 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
 			 * Here the ptl is only used to check pte_same() in
 			 * do_swap_page(), so readonly version is enough.
 			 */
-			pte = pte_offset_map_ro_nolock(mm, pmd, addr, &ptl);
+			pte = (pte_t *) pte_offset_map_ro_nolock(mm, pmd, addr, &ptl);
 			if (!pte) {
 				mmap_read_unlock(mm);
 				result = SCAN_NO_PTE_TABLE;
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index b91b1a98029c..2cfc6e608ef4 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -308,8 +308,8 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 	return NULL;
 }
 
-pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
-				unsigned long addr, spinlock_t **ptlp)
+const pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
+				      unsigned long addr, spinlock_t **ptlp)
 {
 	pmd_t pmdval;
 	pte_t *pte;
-- 
2.55.0


