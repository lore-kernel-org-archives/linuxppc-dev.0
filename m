Return-Path: <linuxppc-dev+bounces-25288-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EE5C55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:44:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDMvz52f9z3c1D;
	Tue, 04 Aug 2026 02:44:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785775471;
	cv=none; b=YvRA24mXL3Wb8pPj0R37PyOwASp+tWfK7yBebk2Qebt1yzVH8u4bHy0Ysdb2vBCeTwKRKfFVfDesTU2h4SHjpFaQXWnY3PHfL2jHTTyC7KSfjaIqibaPUA4h9KI/Euz/ppaV9T6Yvf6crIzHBf2CAx0eXhSG1Q1SedEZG+Z2riEH27zKwYBxAwY/3cjIaoAI32OwebNTjeYi9rhOqQ8JuNm3Qp+6hJscURA8nGgAANDqqvXMuv1HrV5O2fcHuO13StYP9Tiz3HwnPSml97MvooU47eujdNRhHg+69ddWpEkdIpXqbrnENgD6dIiDKZ+as8zWG/refzz//H4mTh7UDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785775471; c=relaxed/relaxed;
	bh=wZBAh6Nw2Wojw1x1c/oIpX3LymyujgAPhMLX7la+5sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRHeQl0yS3UuyxnJ9kP6OG9ggQFsNdWtG99OfN43+0wL70AzD1qp9rhjmcaidVuCsSw7kMmAwgFy5eVa4K0LRg86bX4TEIZc//miXoHjLZ83SvK5RnLWcg1Xkrk1AbdyQZiy1x+QHEgZCZygDGl4g7OPnjWaEevYovwYnXXASGhK8CymCwttZU76Q9y9pITF9u7tAa4BlftJG/7BxjzTTmm5NhO2bUdWIgWfHC32RBLfzR0py81HeBCjkfBa/1u3Lmj5Oa4En66aEelgb5FK8Z+JRPmn/sRUI2jisdNvFU6FzcgdloW0lox7gBVBoxdzXgbMjE9bsbbKR9FFmJ2BhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RCnX9DvB; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xaIbUspi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=giVnVJGx; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KQ3BcFN2; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RCnX9DvB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xaIbUspi;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=giVnVJGx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KQ3BcFN2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDMvy5mJnz30F0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 02:44:30 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01E9F3FC3;
	Mon,  3 Aug 2026 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785775464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZBAh6Nw2Wojw1x1c/oIpX3LymyujgAPhMLX7la+5sM=;
	b=RCnX9DvBdusp51QYUbBf7leNC2m/jnhcVFM5tmPTP/BhTZ3DqFPAqeh33IRpZN6BmPwqoP
	rzIo4y/i0IiJp8To57XQsHwj+IPT7FV5Ll5C7nv8aEmi07CIq112ysW2y06eVZEf2dH6wJ
	r3lk9k8/HQ6YyaSYXdsLZN6KGB8gFDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785775464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZBAh6Nw2Wojw1x1c/oIpX3LymyujgAPhMLX7la+5sM=;
	b=xaIbUspi5o6OZc06hALwJZqRpjo9E6iu/FYAsULDovkl6o6a+EctY/7NZl8UBxV14mSYy3
	LqsBwv3e4TeH+9CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785775460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZBAh6Nw2Wojw1x1c/oIpX3LymyujgAPhMLX7la+5sM=;
	b=giVnVJGxPhlzAiTUyO5cLvObJ3wJUrZwgTqO2byoJytTwsPx5geUMg3NE+GQojJgRcLFfW
	nGXGK8yEXMPkiUXaTlVnnCK1/idDeaoYBPP9wfBAGdYiKRQ9MMzDN+N8K1AAGzciOFRYLJ
	eZ2eJWx57aPm670VdUoqq6RZMBZewhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785775460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZBAh6Nw2Wojw1x1c/oIpX3LymyujgAPhMLX7la+5sM=;
	b=KQ3BcFN2qLOwnr8xm81Wv2EiUTXMUvdttWl+K12ejsYXnidRcK53HVXpu4yybbDfE5Irjs
	3RgNNZM+XdnbmZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C744779A1;
	Mon,  3 Aug 2026 16:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iCzPA2LFcGp/SQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 03 Aug 2026 16:44:18 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
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
Subject: [PATCH v2 6/6] mm: constify the pte_offset_map_ro_nolock() return value
Date: Mon,  3 Aug 2026 17:44:00 +0100
Message-ID: <20260803164400.531199-7-pfalcato@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803164400.531199-1-pfalcato@suse.de>
References: <20260803164400.531199-1-pfalcato@suse.de>
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
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_CC(0.00)[suse.de,arm.com,kernel.org,HansenPartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,infradead.org,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLxu57a9hfgn7tttf5jiwuqe5o)];
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
index 7fabe6c66b4b..acf5a5e31d34 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3885,8 +3885,8 @@ static inline pte_t *pte_offset_map(pmd_t *pmd, unsigned long addr)
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
index 6afec636881f..af5d3fcd1b05 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3490,7 +3490,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
-	pte_t *ptep;
+	const pte_t *ptep;
 
 	/*
 	 * We might have COW'ed a pagecache folio and might now have an mlocked
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b237f6e7662a..09efac93a8c6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1170,7 +1170,7 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
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


