Return-Path: <linuxppc-dev+bounces-25287-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC1DC55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:44:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDMvt3N26z3bxC;
	Tue, 04 Aug 2026 02:44:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785775466;
	cv=none; b=Jju4eqA5XG/x7J19FFCZsO0ygQrcn786PgLE6AaZDJzvwdv0qOtiu1FtvKG9brzT0GRt+eVFf1Bo411P/GemUlbnJ0g7yzx95LOhELh47PEGWXUdcu0E1HbUFKN0KWNApRGR3dnRzj6knlya1Zl2/kz2RgVC962ggp0SOwWaItv5EEfvr89VqOUBehZUvmhj8ieLrYs1vKbE6OY+98LWOp5pP75WalvRvPReEbf/X4/hdkxWsHFRcMNzNF/Bg4KP0MBpyVvbXpQm/9rh+Je0ScMjt8avb26/txCnnrTO3+8xUZZUGZAONxsBY0h4MA0HedGiTl+e/6obWeqpk4RMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785775466; c=relaxed/relaxed;
	bh=QLRKQOwI7WJiEvMshK9BQ7DGGYsinDl7hpt5eENmCoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKFFCtZPLrvs+a8oI+zdnWPaH79rba8iN6DGa1urRLeP4f1l/ILreW9WYQFaDt1H4SM5bzBD345419KRE87KcXtobgQp67s8o+l3RWKHbLoByXYON/q1Rs0DN0Tok/YpwJktBz1bCxejAjnfJR9xcKEdJN062ymiT7HpkvvzJ/suO8P9yZ1U1NTkZk2MjtSCbjIJQ5/12ixTIhB1B2cuyEDfzk2KhhdW+lDcCEeHiSUrhrQPZp3yyYrm1I2ms44I2rilSD6ASBP9vgrgtghOOODnrifiT2obj3SiIRDpx8dEsgok6i2i4gO0QVu19cqxyIrQPK5s2lkNYHHI68MNXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=h3I4OPyQ; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SAzezfRd; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=h3I4OPyQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SAzezfRd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDMvs3LpGz3bs2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 02:44:25 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F1A997F250;
	Mon,  3 Aug 2026 16:44:11 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785775452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLRKQOwI7WJiEvMshK9BQ7DGGYsinDl7hpt5eENmCoc=;
	b=h3I4OPyQasor+vcYWgGA36JKeTQmaWQvyAr5sYRA7P9gLxM4zAurUYIs+AIgquFpYzoklb
	7w52Pi76vf/h3NoiLs9/2z2uPBgHGr2tmJx2QV+Uv3ezoavRB/n2pEdnIGynBl2sP/KYGm
	tOV0jboSrLdzHzXuP7Xdb7rWj8G4CNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785775452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLRKQOwI7WJiEvMshK9BQ7DGGYsinDl7hpt5eENmCoc=;
	b=SAzezfRdkpajLsYmi0xGypBXWYHyXa1uTXjGpQOCflTceH2UQ97C2SJbGckUCzXlhJvb7+
	q0wWRCx5dys1C8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05AAD779D3;
	Mon,  3 Aug 2026 16:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kJ7TOVnFcGp/SQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 03 Aug 2026 16:44:09 +0000
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
	linux-fsdevel@vger.kernel.org,
	John David Anglin <dave.anglin@bell.net>
Subject: [PATCH v2 2/6] parisc: Drop own implementations for ptep_get() and ptep_test_and_clear_young()
Date: Mon,  3 Aug 2026 17:43:56 +0100
Message-ID: <20260803164400.531199-3-pfalcato@suse.de>
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
X-Rspamd-Queue-Id: F1A997F250
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL764437jfm1qe6abtk9nwyx8m)]
X-Rspamd-Action: no action

From: Helge Deller <deller@gmx.de>

Switch to the generic implementations, which are identical.

Suggested-by: Usama Arif <usama.arif@linux.dev>
Suggested-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 arch/parisc/include/asm/pgtable.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 467b8547ac8b..d92dee9fef3f 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -432,25 +432,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return pte;
 }
 
-static inline pte_t ptep_get(pte_t *ptep)
-{
-	return READ_ONCE(*ptep);
-}
-#define ptep_get ptep_get
-
-static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep)
-{
-	pte_t pte;
-
-	pte = ptep_get(ptep);
-	if (!pte_young(pte)) {
-		return false;
-	}
-	set_pte_at(vma->vm_mm, addr, ptep, pte_mkold(pte));
-	return true;
-}
-
 bool ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
 pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
 
@@ -491,7 +472,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
-- 
2.55.0


