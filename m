Return-Path: <linuxppc-dev+bounces-24772-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F47C531FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 10:20:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h63sS5Hcsz2yYd;
	Fri, 24 Jul 2026 20:20:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784888428;
	cv=none; b=aJ7QDoAvsBn8McS3GUYoRbFbzfwu7oXWcvVXIwuAmkbBMrcUfoQmR8yxjWghmIyrdR7utY7z2eiCvfHttAz0Pwmq45NSB1cxZp1yhW/m9gXUe5nVu+ER/sRRlp+X/0vQt2oNtS2lLs28b0DljLDBbhMhBI+iAAl0Z+Ut60L7jVuklyg+aZ68u6lpuPZrmBbcOraUUvrSR2GrCewJLhSgHh/iKLViZGUco35G42dw6zPkpB5H5MgtdPpZ/kzUJKUCTcwdFC7oTk2f9LJGF/6u7xdQft7pZj8gbP/lisWC6t+59zCwqjjVpUhtYuLPPZ11d414PeVqVwxYqPPIahTpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784888428; c=relaxed/relaxed;
	bh=SePwpieQyuy4I1jGDOGIB8gwV902Jt9JP/rZL79vbug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6hZ135v0fPRUMSZGAxyCTsnmh7m/EVJYD8/Z+cS9t23QMaVfijFwkgO/j24qQpjClfdC0w8RajXD7blPgxbc0VXXFjmfR8Xg4hMG0L8grCSlgTAEPB6aRzIWxHpg/HDfZxjGIusHB8oo2fqX3PEGBzf4hNL2nfJr6TbdDgAe4bX5dYc56dC3Yf7FYDdX5Dc0CCAUiCzivBc8kvAXPkkRSrnkpxhPDpLkaDtlxIyD08cc7Xg61qtf1DqbZOCIjB51u3F6ZcPp7FOLBXN9fHsmVBcumw0Ki0WaOaGDSLMy8w5kMLxIt+C8G3zlJvk/VQXvHfO4znLc4WJDgmABkkDRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VDT9W77a; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bn2TWpyR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VDT9W77a; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bn2TWpyR; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VDT9W77a;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bn2TWpyR;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VDT9W77a;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bn2TWpyR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h63sQ3v7vz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 20:20:25 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5047B3E84;
	Fri, 24 Jul 2026 10:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784888422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SePwpieQyuy4I1jGDOGIB8gwV902Jt9JP/rZL79vbug=;
	b=VDT9W77aoBJtno7DnLsVeBLRgtj2LXvFKwTE0PXCYEdHHfO91QqREBPGaLCIhTGHDFNntC
	AiWg4dDHFY6+8unZqaryY3sp2ZEzsVaeyRKvQeyjkdTU3XMYZyz4UYgSLyTJ+7b3zMxUl0
	mY2USsenCuGvMW3sy4pS2u2oFzaGYYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784888422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SePwpieQyuy4I1jGDOGIB8gwV902Jt9JP/rZL79vbug=;
	b=bn2TWpyRVadTfHe1fCfM1+C+Z0Xe/9VGdfB1U9tnLWA+i0QkT9sJ6DMME1JIwKJpQvjKX1
	0vPiy8tbTwcCApAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VDT9W77a;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bn2TWpyR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784888422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SePwpieQyuy4I1jGDOGIB8gwV902Jt9JP/rZL79vbug=;
	b=VDT9W77aoBJtno7DnLsVeBLRgtj2LXvFKwTE0PXCYEdHHfO91QqREBPGaLCIhTGHDFNntC
	AiWg4dDHFY6+8unZqaryY3sp2ZEzsVaeyRKvQeyjkdTU3XMYZyz4UYgSLyTJ+7b3zMxUl0
	mY2USsenCuGvMW3sy4pS2u2oFzaGYYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784888422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SePwpieQyuy4I1jGDOGIB8gwV902Jt9JP/rZL79vbug=;
	b=bn2TWpyRVadTfHe1fCfM1+C+Z0Xe/9VGdfB1U9tnLWA+i0QkT9sJ6DMME1JIwKJpQvjKX1
	0vPiy8tbTwcCApAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C0E0779BA;
	Fri, 24 Jul 2026 10:20:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AJmVOWM8Y2oSaQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 24 Jul 2026 10:20:19 +0000
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
Subject: [PATCH 0/5] mm: add basic PTE const type-safety
Date: Fri, 24 Jul 2026 11:20:12 +0100
Message-ID: <20260724102017.141532-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.55.0
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
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5047B3E84
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[suse.de,arm.com,kernel.org,HansenPartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,infradead.org,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RL764437jfm1qe6abtk9nwyx8m)];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Since forever, MM code has thrown pte_t * around with no concern for const
safety, or typesafety of any kind. This is confusing. Attempt to address it
by:
1) Making sure pte_get*() helpers can cope with const pte_t * arguments
2) Constifying the pte_offset_map_ro_nolock() return type, which by definition
already pledges that users will not write to it.

These two simple steps were already able to uncover code smell from
khugepaged + do_swap_page().

Separate steps could include introducing pte_offset_map_ro_lock() for more
widespread usage of this.

Benefits of this include less confusion and better type-safety. It could also
futurely aid in efforts such as [0] which may want semantic annotation of these
accesses.

Based on mm-unstable and compile-tested on a handful of architectures.

No functional changes intended.

[CC list editorially trimmed for brevity reasons; apologies if you're not on it]

Link: https://lore.kernel.org/linux-mm/20260526-kpkeys-v8-0-eaaacdacc67c@arm.com/#t [0]
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org

Pedro Falcato (5):
  mm: constify generic pte_get*()
  mm/arm64: constify pte_get*() and contpte get logic
  mm/parisc: constify ptep_get() argument
  mm/powerpc/8xx: constify ptep_get() argument
  mm: constify the pte_offset_map_ro_nolock() return value

 arch/arm64/include/asm/pgtable.h             | 10 +++++-----
 arch/arm64/mm/contpte.c                      |  4 ++--
 arch/parisc/include/asm/pgtable.h            |  2 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  2 +-
 arch/powerpc/mm/pgtable.c                    |  2 +-
 include/linux/mm.h                           |  4 ++--
 include/linux/pgtable.h                      |  8 ++++----
 mm/filemap.c                                 |  2 +-
 mm/khugepaged.c                              |  2 +-
 mm/pgtable-generic.c                         |  4 ++--
 10 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.55.0


