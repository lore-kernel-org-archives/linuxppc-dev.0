Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46840606A31B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lHMaEbEO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLBBF2Xp7z2xN4;
	Fri, 06 Nov 2026 05:47:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::58"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793904437;
	cv=none; b=PYOpx6geR7hvEnRqyrZ2bPtN7X45EQcDeJhHTc/i89R7Pzl64NVWfYqv5ihtcbG6VaTv/ERdgTTR0JfZZYy1xgrz8oDsgsipzZb3SCblLkOOc0bfgX4prsrSS8AepDi0HJBjJaI5JbxqxoLwJyBLif/ItLOlh4Q2KxkJfThuQyzuCS5S6plS/WiTxVRBB0beXdKH3NRi9xbRCMr+UwXj6Kp2GGjJ5quzojle5kCMCp7ciZeT3+aW94Ro8mn61/At4e6SIkZwhdjOnw0Po5BHEkLxJ6Tdor6le9vzfqgvpRtzprKoEddSRt692rsu71s/Z+UcDxZSaL6uod58XjFbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793904437; c=relaxed/relaxed;
	bh=S1LeOnb9CDFOnmMEzFnVdGeJ3OTcUQn2u1YwjX7C1y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvqjbiVVxYoGY8/Ktjup+4l4Gt8gTlJftbj0nI6nnreZ4wMg4mXOXKcIuGm8JhM0/nPPIPbu+2lDK7yoGL9JUkNgDw7DahrR+IK35OS+SpLapAhRbq/I7ddq1zl5tR4qhvA49/fTMddBJLfLnU4plu9fuvH+K4RcQinG6hLecYMZ1CIo8RaQP+QA7UnKxli7s4GuHhwYb8/96r/bjxZjeYrblIBoqoZtidkLWjed20VLSsgbFlvyY0Yr+CV0BILv420Gz+QfwdnAh7E6FB8w+fZZ8a6aUYIyknE895Baawwl1ExnozvUXvM6LV4IrnOrbnlt000K8AFhINj0tOsD3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lHMaEbEO; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::58; helo=mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lHMaEbEO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::58; helo=mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 319 seconds by postgrey-1.37 at boromir; Fri, 06 Nov 2026 05:47:14 AEDT
Received: from mta0.migadu.com (out-88.mta0.migadu.com [IPv6:2001:41d0:1004:224b::58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLBBB08Wsz2x9c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 05:47:13 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=XHwomVe1Ix4OLLbQmSLS20ZMN+cx9WZ34HyiAIQySOU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793904415; v=1; x=1794509215;
 b=lHMaEbEOlNPj3Hzosj3DQG9/SLCJAfsAAjwQvPr877QDkQYZH2s84DMl33KvYIfwOW6Eqz69
 vRI+YQDvL2nzDpDb4kLIGBV8GecNvrXf7RxLmAfAwFQ/mGV/AeZdBZ8xjU3YvSrhddquoqFHex4
 xUcENrfK3pd9lX11x4xIjktg=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id e0c6df93f7b2e87a;
	Thu, 05 Nov 2026 18:40:09 +0000
X-Mizu-Trace-ID: e0c6df93f7b2e87a
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	ljs@kernel.org,
	ziy@nvidia.com,
	linux-mm@kvack.org
Cc: chenhuacai@kernel.org,
	ying.huang@linux.alibaba.com,
	Baoquan He <baoquan.he@linux.dev>,
	willy@infradead.org,
	youngjun.park@lge.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	alex@ghiti.fr,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	Liam R. Howlett <liam@infradead.org>,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	nphamcs@gmail.com,
	shikemeng@huaweicloud.com,
	yosry@kernel.org,
	qi.zheng@linux.dev,
	luizcap@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v9 04/32] powerpc: mm: add PMD swap-exclusive helpers
Date: Thu,  5 Nov 2026 10:38:48 -0800
Message-ID: <20261105183940.2236717-5-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105183940.2236717-1-usama.arif@linux.dev>
References: <20261105183940.2236717-1-usama.arif@linux.dev>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prepare for keeping a PMD-mapped anonymous THP mapped by a PMD across the
swap round-trip, which makes PG_anon_exclusive have to survive in a swap
PMD and not just in a swap PTE.

book3s64 builds a swap PMD by running the PTE encoding over pmd_pte(), so
the PMD helpers wrap the PTE ones and reuse _PAGE_SWP_EXCLUSIVE, exactly
as the soft-dirty PMD helpers next to them do. It is also the only powerpc
variant that selects ARCH_HAS_PMD_SOFTLEAVES, via PPC_THP.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index dff8790a047db..458c85cebfa65 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1060,6 +1060,12 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #endif
 #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
+#ifdef CONFIG_ARCH_HAS_PMD_SOFTLEAVES
+#define pmd_swp_mkexclusive(pmd)	pte_pmd(pte_swp_mkexclusive(pmd_pte(pmd)))
+#define pmd_swp_exclusive(pmd)		pte_swp_exclusive(pmd_pte(pmd))
+#define pmd_swp_clear_exclusive(pmd)	pte_pmd(pte_swp_clear_exclusive(pmd_pte(pmd)))
+#endif
+
 #ifdef CONFIG_ARCH_HAS_PTE_PROTNONE
 static inline int pmd_protnone(pmd_t pmd)
 {
-- 
2.53.0-Meta


