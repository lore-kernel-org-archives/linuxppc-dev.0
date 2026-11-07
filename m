Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21397606A332
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 04:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=M4P15kVt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jM36x4HGXz2y71;
	Sat, 07 Nov 2026 15:32:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794025945;
	cv=none; b=R2dS8WmSea8tPMaDanHgjO0r5h59Q/67r/AvaIxV6H0DXsUVlwliVavYs6WeTboKz3chsOS6/9TcXBw3PkbPZ7B3yMDvM5NOa5u3VeLSXc5AcCHlnvcMb/kVVx7SH4ljYt78VjHs6/QVLeSKjLFFrCzU92OoW67T01GCS1/VLxPFmFBtv/m5XDbLU7DLeFSpEtDIXAuPE5imtkF790PJC+IQVlM5hjZOJqKzmi7jXe179jpFW0h13qvoH9In9Yh0I/skyagKyuURawkEubfmzhnSFm+kRM+2+b734Luj/SCzr5m2vLz+g0yPA3bM2hVJsJlD/2JiuSIRAukZDyad1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794025945; c=relaxed/relaxed;
	bh=/SKim++0/v959SqW2Qj0ZN00Ia9M3Z26xYKJjxKUd6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BB7EhUmxDDOnp1oaORt1FGoWfIxB9Xc5dLH8R4+7xQVJZEd9F7/nNOKMqKJgy8mmtKYbWgXZ0GRHL3v+TzYQCTqnecTihRWHOiswkcS1nuGupvotP2TO+i/7cL6P2LiHvi9b+KNdqaXS1dqjpSUjmE7G/7X+rKId0li1/vmIOKmXNOKrU8N/FgJ1sR+x+pyM8r+slxIW6Ps/h7bOt6S6QOCJLRhA8ogxk73y17Q/hMaK3WoOYa6z3D3Nq2duwIxms+8n0VJP4gZjlF4nHYpWHqz56rrZoDY4EHIEI9czwdxoaM+1xWqKOhLPeNnSnOSaJczrQU0sbBhoy8EkIyYyOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=M4P15kVt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=M4P15kVt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jM36w6jPtz2xS6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 15:32:24 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3b1015a4259so361372a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 20:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794025943; x=1794630743; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SKim++0/v959SqW2Qj0ZN00Ia9M3Z26xYKJjxKUd6k=;
        b=M4P15kVtnk4mC5BDTJbuGLCN0bgiE/wwsZPsVYO2XUZTEwSyhVYV+HqCUDd1BPKq/G
         /aGBt5KBDqB94bxOPLf7ps9sOULOdVohicbLs2BfYRHhZ338+mcbfRnTx/3yI2PI+ZTH
         VP/S8qM3wfDZZUZeUe+e/bZ9vw/N7vncQtAnHlRb/SUUOBYUKPhSyGnT+lmICrkTCVQT
         n52EbAEW2euldDpem78hKedQw5ChSKvJikupJkYCH9PdxWlOYFg9FBZU0cKYpnD6qP+Y
         I3FE3U/7BsLLouMUXrks2ao6XseItuDTR6Qiqjvkh0cXsktKg+Y2b+36IMWfr/FAnXlC
         y9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794025943; x=1794630743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SKim++0/v959SqW2Qj0ZN00Ia9M3Z26xYKJjxKUd6k=;
        b=tGRUP1Vo9/ciQwxJTZNrVNH4/bVb0NlxyDNqHgG5+vone1FKhgbn6/RCeYMsdE1lwy
         p027tFx36ZTA4v/3lUo+yM7Vw5K1zAwK0lR+lajSoqSCWh5l969nhPaddyI6l5OwsO05
         kCATCh6lxtUA8jBfFVPBl/zQPYkj9PEXoL7M+peg0MGPeyOmnRbGzKe3cHBEApTNSghf
         HAnC2rOw+mYfOnKSh/8mcnuc8VfY1prmpZvf8HBrL48Ft3GG1V+9KGDK/VNwLRkKIkrM
         CuFBzOovO6Yk81PiEtEw4us3NCP7nf2JLXGudSs5qmPaBvBEFt/dniCPYkLydWu560r4
         Bmig==
X-Forwarded-Encrypted: i=1; AL+hErFURzuTONxbYmnsYg1wIQMKD8QiNtlugrwx+R0VlJj/Hkhqa+VVnaYW190J18UHCrPcOp3ru8oOPOEqFNg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/sPt/oheTsO3pkdkf59hlOCxmA0Kz3exxPa5A2FI8wiXGOxkP8
	e6W7a9pIR27Ecaj985z3Rngm5Pcdg7TWGRkjiwAFVlnOF2vzOezKTgjq1fX9n2oqEcY=
X-Gm-Gg: AYBFou23rVOZgsgQYZpbJfHKs3L+KoOoTgis838uHn7q6yst7GXlmg30d4gVWnfuB+V
	/LSULEfFHpZSlWEGM4u6pJUCd9OKW7fGBRNnF9lGvKRVe41dAB+QyX9vZeuGfid10/6FizNpv4B
	JDyJ1n5YHm0eWYeooLuoJZ7IGfDdP2DvQ8XPkQHp0O7QfJj7stg7vIRcKxmTme1Gc8DuI2pdj+k
	h/2EK7iVqLJNiSgwe5b4F58X3UQ0oLgiXLt9oW/DFfUGWdcZPSBXvkBnApSbcH2/9K9kDgQ79EI
	jyUYMc7kKyVNTviUShUIRkaOyJDKHv47iJsxgdOHjpQHeWEurQVj5QorH0qONoeyag1R9iIfINK
	IFjl1PO3Gl01UCbS0X6Ge6oNmgrmceD2QZj8JUuB9NJhgILLYL4Mpp6G76eln0CzGIW4l6VqMk9
	o0PkcHaXA8QnmAP53qNBWNGlnwK+GT8KTg2rbuCGSRX6r1n0IGe7e2hvjEBqdKSqjl9rsOkhuil
	zUhQxtAwLu9LZT9tQ+RD/mKUnRtspz1l8rT3r+TGNGFLrjSTezJuZGvFQfqXw9CUQ82be/k/tXq
	nkpM+DPoXkt8EBPWf5OOBULyUcDM6UwWIkpRipnkjFeFt4rL6uR0xQaifw0Q
X-Received: by 2002:a17:90b:5608:b0:3ac:c024:b275 with SMTP id 98e67ed59e1d1-3b0db605906mr4825186a91.9.1794025942667;
        Fri, 06 Nov 2026 20:32:22 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:c8de:13da:804b:a0fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10584b66bsm1578451a91.14.2026.11.06.20.32.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 20:32:22 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 3/5] loongarch/mm: disable device DAX vmemmap optimization
Date: Sat,  7 Nov 2026 12:31:20 +0800
Message-ID: <20261107043122.25650-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107043122.25650-1-songmuchun@bytedance.com>
References: <20261107043122.25650-1-songmuchun@bytedance.com>
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

LoongArch selects ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP but not
ARCH_WANT_OPTIMIZE_DAX_VMEMMAP. Its vmemmap_free() implementation is also
empty, so it cannot tear down optimized Device DAX mappings.

A later change removes the generic Device DAX architecture gate and lets
vmemmap_populate() decide whether a section can use optimization. Clear the
section compound order in the LoongArch path so Device DAX keeps using
unoptimized mappings.

This does not affect HugeTLB HVO: LoongArch does not support gigantic
pages, so HugeTLB does not use section-based vmemmap optimization there.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- New patch using section_vmemmap_optimization_disable() to keep Device
  DAX vmemmap optimization disabled on LoongArch (reported by Sashiko)
---
 arch/loongarch/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index f801f7097f03..ea769e479241 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -15,6 +15,7 @@
 #include <linux/memblock.h>
 #include <linux/memremap.h>
 #include <linux/mm.h>
+#include <linux/vmemmap-optimization.h>
 #include <linux/mman.h>
 #include <linux/highmem.h>
 #include <linux/swap.h>
@@ -143,6 +144,7 @@ void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 int __meminit vmemmap_populate(unsigned long start, unsigned long end,
 			       int node, struct vmem_altmap *altmap)
 {
+	section_vmemmap_optimization_disable(start, end);
 #if CONFIG_PGTABLE_LEVELS == 2
 	return vmemmap_populate_basepages(start, end, node, NULL);
 #else
-- 
2.54.0


