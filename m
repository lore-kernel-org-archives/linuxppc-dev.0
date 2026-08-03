Return-Path: <linuxppc-dev+bounces-25286-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC18C55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:44:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDMvs5YP8z3bwX;
	Tue, 04 Aug 2026 02:44:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785775465;
	cv=none; b=eg/bKir2mMNg4gJXHrNv7nwLXKwX568aSDROP8UrZRc/vEZR2vjBoI5yCB9R8me3m2eBi0ets4auJQUhRyj6ofuXFg9tgICzBUJwoz5yVKdjuiav7BlwyIDZWdKoPTHGBUm9ms3AXkEtD1xIuQxdDEqpe4CNDHjgf2W+3XTKQe4txM/YhBmOyP5vsdNb+FgYB3RwiJg7Jh/N28HdWDgwKOcPKgZRqgZgSK/yuNNFR/t2WVFuQdsDBTyJp/bzHaqUCehV/p2cljBfG7M0nHYb4C5envPOV032Yha6/YQImTHjuQuXpmdmjsnewwFT9SQKuY7s7g4ix7Xk5frc7GadCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785775465; c=relaxed/relaxed;
	bh=ygAzH+FQgLJrgBdhFAHfKQ03vfYuxl+i8XyjFfW9SDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtLUOvb2G1iOtV7N8MUFO1Xpb1IM0oh1KC47zp5z8433ghVzudiGTKC5y7KQggtJ7WhCMOD1I/Etra6g6MxAcEy9gsOVBVB5pDprt0+X6KfABnFfVfpELR930cnz3+8ZniCGgw6L8yCl61SrE/dXmvxa6L5ekD6prZjaIBULGRRh3MxeJhKrlBzIo8yDDFOheyl1R/r6flqtyYEPQMob3Ri2kpI+OFfRbMbRET73TzX+lRYRpvB1BCDb9e3HSRKj1EwiviOVwlGN0Jq/S6Ml5BT4McWv68xkOUOigU6+i0sqJnmohSJdsTqdAkbiJSrUTlgJougF2xHdDjSSaXkXAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fVaZOjiw; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QGD/Qwf3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eRAF//7c; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WidZld5p; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fVaZOjiw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QGD/Qwf3;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eRAF//7c;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WidZld5p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDMvr3bY6z3bs0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 02:44:24 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2D5F3FB9;
	Mon,  3 Aug 2026 16:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785775454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygAzH+FQgLJrgBdhFAHfKQ03vfYuxl+i8XyjFfW9SDo=;
	b=fVaZOjiw4tGe5jF9DxPqF1IHf3xZVUT8j+7Jh/SXq8L7ymBs6PTJLAnL4+tv7s0yaEZ+NH
	YSugHilLxwkrEvdmR76hUCZ1NvxUUDyj3r6uNtGNFcaDvcdY+X1LSlHXhgFiHuMS3qevEP
	p2EppnDRsBeL569Y9Bd6fHytSS8/1Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785775454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygAzH+FQgLJrgBdhFAHfKQ03vfYuxl+i8XyjFfW9SDo=;
	b=QGD/Qwf3pojJ4A/NOwOvvQ2GmpGoO8Os2O5gMourjcbIPZJUW08FkNErONVX2eVVZ4UWmC
	i2YHuREacuyUCkBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785775449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygAzH+FQgLJrgBdhFAHfKQ03vfYuxl+i8XyjFfW9SDo=;
	b=eRAF//7c2hrRZi6Hqw/71YZVfpFa30gEZRxzsYvfPwSj4Nq9HeINTwlhjKCxi2K27cgHvW
	ppE9niHbkpGCZ9sgEQ/CnlNX5zfyfcuzHk+qf2kzjERVfz+I1J3NfV5VksDRE0lOtGgeVi
	kcrn3D6lMVLWc2CX8aQS/X79BbUCxaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785775449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygAzH+FQgLJrgBdhFAHfKQ03vfYuxl+i8XyjFfW9SDo=;
	b=WidZld5pCyaSuY5KrUcuhomuCxHdCu/rO89ht0SZwK06aFUx2fkO7daLaHjvmADVX/aVr7
	PQnrLsfuzhh7Y4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03E7A779C1;
	Mon,  3 Aug 2026 16:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sGJtOVfFcGp/SQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 03 Aug 2026 16:44:07 +0000
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
Subject: [PATCH v2 1/6] mm/arm64: constify pte_get*() and contpte get logic
Date: Mon,  3 Aug 2026 17:43:55 +0100
Message-ID: <20260803164400.531199-2-pfalcato@suse.de>
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
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_CC(0.00)[suse.de,arm.com,kernel.org,HansenPartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,infradead.org,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLxu57a9hfgn7tttf5jiwuqe5o)];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]

None of the contpte code needs write access to the PTEs.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 arch/arm64/include/asm/pgtable.h | 10 +++++-----
 arch/arm64/mm/contpte.c          | 11 ++++++++---
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a2681d755358..043bc0649cee 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -378,7 +378,7 @@ static inline void __set_pte(pte_t *ptep, pte_t pte)
 	__set_pte_complete(pte);
 }
 
-static inline pte_t __ptep_get(pte_t *ptep)
+static inline pte_t __ptep_get(const pte_t *ptep)
 {
 	return READ_ONCE(*ptep);
 }
@@ -1652,8 +1652,8 @@ extern void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte);
 extern void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte);
-extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
-extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
+extern pte_t contpte_ptep_get(const pte_t *ptep, pte_t orig_pte);
+extern pte_t contpte_ptep_get_lockless(const pte_t *orig_ptep);
 extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, unsigned int nr);
 extern void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
@@ -1732,7 +1732,7 @@ static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
  */
 
 #define ptep_get ptep_get
-static inline pte_t ptep_get(pte_t *ptep)
+static inline pte_t ptep_get(const pte_t *ptep)
 {
 	pte_t pte = __ptep_get(ptep);
 
@@ -1743,7 +1743,7 @@ static inline pte_t ptep_get(pte_t *ptep)
 }
 
 #define ptep_get_lockless ptep_get_lockless
-static inline pte_t ptep_get_lockless(pte_t *ptep)
+static inline pte_t ptep_get_lockless(const pte_t *ptep)
 {
 	pte_t pte = __ptep_get(ptep);
 
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 2de12656b4d8..3a5d6937fb51 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -26,6 +26,11 @@ static inline pte_t *contpte_align_down(pte_t *ptep)
 	return PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
 }
 
+#define contpte_align_down(ptep)                                                       \
+	_Generic((ptep),                                                               \
+		 const pte_t *: (const pte_t *) contpte_align_down((pte_t *) (ptep)),  \
+		 pte_t *: contpte_align_down((pte_t *) ptep))
+
 static inline pte_t *contpte_align_addr_ptep(unsigned long *start,
 					     unsigned long *end, pte_t *ptep,
 					     unsigned int nr)
@@ -310,7 +315,7 @@ void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(__contpte_try_unfold);
 
-pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
+pte_t contpte_ptep_get(const pte_t *ptep, pte_t orig_pte)
 {
 	/*
 	 * Gather access/dirty bits, which may be populated in any of the ptes
@@ -367,7 +372,7 @@ static inline bool contpte_is_consistent(pte_t pte, unsigned long pfn,
 			pgprot_val(prot) == pgprot_val(orig_prot);
 }
 
-pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
+pte_t contpte_ptep_get_lockless(const pte_t *orig_ptep)
 {
 	/*
 	 * The ptep_get_lockless() API requires us to read and return *orig_ptep
@@ -386,10 +391,10 @@ pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
 	 * because it is not part of a contpte range.
 	 */
 
+	const pte_t *ptep;
 	pgprot_t orig_prot;
 	unsigned long pfn;
 	pte_t orig_pte;
-	pte_t *ptep;
 	pte_t pte;
 	int i;
 
-- 
2.55.0


