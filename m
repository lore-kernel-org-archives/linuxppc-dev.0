Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF0606A31B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EzH5GoQE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKsRq21zqz2yb9;
	Thu, 05 Nov 2026 17:12:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793859175;
	cv=none; b=HTGkk0F56hvMHkPVhi5BBl0+ejqaSrcoZsRLs4z99sKxc8wwNsVfEJCZHLziKOh3fpgrH4LzaG30tLnBNFSUWuafevPgU6AnJn7SNTFiisoZWjwhxDGutOPQdDtY+smCyuaQyGLK8RibqRaiNrBccyV4taJBBpfhsAFCpTP6dik75UAQP94d5PMOKhVoqlf6Bsok6VYU0gcIHlJrf8JIGb9sCBWJih88+aRm/+a4s3fWSveoo0qHS2hJmtPrkMqtfQ5VzrHOqC5kUf5YGIxQOhv4D2GVPJm7Hhuqg14cVoti8Qg3UrT18PBAtSuRFz6a6WtBiJL5T1Z9Q8OM/5UuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793859175; c=relaxed/relaxed;
	bh=/SKim++0/v959SqW2Qj0ZN00Ia9M3Z26xYKJjxKUd6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD6R9WVAM1HEVoidli0fxs3ckt5vtJlUvqsAG9wWiKU1+uOknnsH9DaHp2ZXiqzNK5wsc5EkDQPjM3bgdttsB7oH1yRSyKULDh4n1w62vQ4Qhr/7u18e/LB/Lyj9l5e5/XBEyrLmOkUCklRAqnrEHqAXp6MI/5zgLHIISiYN1ZRyKGt1j1KHv7tnr9QmXp48IAG3Iv0t2+b+ptKB+jU5s4VFIek7XWRGYSkegViOVH3Psr8nEE8ZDCGulRVpJiohtMLg2/oXDW7R3ZKao/2x/7lATan3yXE+sePwIcvtDaWnyWKMUNk4N9qTJlf3obICGjlXssBVuUHNSWTg1IbxqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EzH5GoQE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EzH5GoQE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKsRp3mmmz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 17:12:54 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3ab41538192so1275148a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 22:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793859172; x=1794463972; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SKim++0/v959SqW2Qj0ZN00Ia9M3Z26xYKJjxKUd6k=;
        b=EzH5GoQEgJqR7U0A1oqkZNlo+4BZsnRpmnPhJ4qmvX6qH1kuJO20HPouajYLRjqKsZ
         zwOBfWGU6GPSYsYaKw0zBqWhONhUeva9GrKRgKQy4LczP9g5tiPurPsYNwamAHsecAmM
         gqQ0dW5nANvHD9bC3HBYdwVGQafm+A3mld6MqOS4AyUDYVyqnyYuJK6ErBVmQZSsqu6P
         Q9bMFyNtBHc3dIZ9XIIEIuBYmJJoHd84HGxtYDDbEnXEYnXIKTJL182AyeFM0fQqNipv
         hPU1fkBTcQ3bYK87flMgw5QVSaa1ccKlhGksP5LnYq32O6Rcv0+sjqEv3Mcf91tpWw10
         gYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793859172; x=1794463972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SKim++0/v959SqW2Qj0ZN00Ia9M3Z26xYKJjxKUd6k=;
        b=NhNWl9/s4dA3Sah5mV+Da6YxmrhjMxQWZY6e2RK1l7EC2KnowDgFa13nOCBF8AkOKG
         r6SONwK9dLH3INwHy2Ueke8yiru+NAPDaAUDnJ3mZsVOzhYcRxtR25oV9rv1qPB8Dibl
         WBo5rYizJDWq17x8z/74pxlj0jdHKS0/D9oCU+yx/+JY2MT/iKPHYFjT2nS75TOwI3s7
         0m9s70lRd2l5Lvx4IEXCx24auHwJyCACUiK+TfuIQ9fc907/gAOMwjcj4jCSPYQx9pMX
         MpbWxzCdbBIhVcNpYF6s341vyS0240LvPAotRfxjFGoMEt70Ebug2T0M8ZADJgmn0j/w
         oOJg==
X-Forwarded-Encrypted: i=1; AKwUvBwiETQNenzM9tG4v63qExJ45H/GbGMNJCShqC9LrcnrhOQp8eCaOgGpABzADIAuznkTVtcSylYwM+MOPAA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9hkTZw96e/J+YDHoawo+nxZyN8K9ajF7TDUxcCud1T6qKJ1O1r
	yg0EgUIAXXk2HFJ7dqo5Z4BafIs+jlbEKn5kgtcnazFb8XWU9Qo/mYDA58vJZQTU8cw=
X-Gm-Gg: AYBFou0c6HdSmlqL0BRceNG0v6jCM0OAC1MaRgpccrkBUbjG66MsG4XbAhi6jckzemb
	YREiNr18Cj9QEIINC4eBlWAWsen7s+70UjYqjztqngpP1RGnzpcHTeBQo73ZBMfY9yPfcyY/dFB
	Qh22OVGW0VCZr68JwHFyf2oYk6EnhIsFnS7ZQoFnrVb9AWQ1Nj5IWia0Y9cnPf9KKSjd7mbF6Do
	9P4Ypexrv8wVnUA0ARV3DZnwJZmBbVxRsRNbxqqL0Eh/b9XZcrc5Wzx69ElIjQjjpXvx2yOkoCJ
	pe1tAOqBCd7dzhXz7qdB/646QKz1Y8U4ImQP7Xkbv8Xht66RWx93yevXgU9uBDtxai3ZVOzh0hh
	Vj8DTxjYqwLsxueVrYdE7kMk0P0jjTjKgM8g3tUElIOjf2hSAM0Ue5YReLCkoJoG+SMCdDcJmpx
	JD5NszixJul8CJmwlMLY5odF8UM0CddfslBZlLs+LXYi6/vkWWgsH7hxlu/rCuRXf1IUt7B302K
	oxnZhRcbJdMBV6Zg0EYr2K4I2Fq/pwjRg5tjrAgNgI5y5voIKfDpF+/oAEnRf5OFdRVplca3f2+
	wDVulfOUX2gVj1ZQsk5etKabR6gftcja+A8v/4I6t+SiEDIcrD1i+BnwXXVFZG4zKvIZYq2NKE6
	RMiuPCRWJ/E8=
X-Received: by 2002:a17:90b:37d0:b0:3ad:c4e9:7beb with SMTP id 98e67ed59e1d1-3ae8979d2d3mr14790005a91.43.1793859171930;
        Wed, 04 Nov 2026 22:12:51 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323a1fdsm2107528a91.5.2026.11.04.22.12.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 22:12:51 -0800 (PST)
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
Subject: [PATCH v2 3/5] loongarch/mm: disable device DAX vmemmap optimization
Date: Thu,  5 Nov 2026 14:12:15 +0800
Message-ID: <20261105061217.13302-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105061217.13302-1-songmuchun@bytedance.com>
References: <20261105061217.13302-1-songmuchun@bytedance.com>
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


