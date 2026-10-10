Return-Path: <linuxppc-dev+bounces-29169-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A68CA9EBE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 07:59:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1x2S2jSPz3bdq;
	Sat, 10 Oct 2026 18:59:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791619152;
	cv=none; b=njBmFD+8YYB7DsoOwHurKma88P0KuoJ24mppAZ2bK5tme7ohc4KBlr0IYfr5bbeS6fTDqY2SC1F8lYzEM0uZPwVbdbeBbeU0ZjVdzAFJfH4braOLvI9r4GOGCabtj2tKCmfFBtZ8R1e7i5nntT1RXlCz42RFcUi+qnpwyEeraPpWlLkH9t672hZVia9+r4i06ulsRYlCqdcC/mrbmNXd1ysI+Z+lNK5kGBDtS7UPweLX+ABPrOFvdmnFlLrQsC1s4mKJSVKxFFsYjP99WvfXQFoDLeTh2ipbZBFmaiiOrf574fdE7k+X5R+/UICuuP+MmbopBMS62kVZLUZjAo5SfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791619152; c=relaxed/relaxed;
	bh=JUYV9kBM40++h+Iuf/kFSxpEvNiJz1Gg8/l7n+m9rxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiRNlWd9kwdjyWBNqJM5XKadVsqBHOKD6Prg2EezjtsWLCrzFvcVncnYevMWAwPiqgIdGxXvei/WdjJoefUh1OnKVU7xQrI+g0PHn+dG8jmaPJ5voCahGQkK3j2L3OGGKuJIwnqIt7XvmKEipxnEAwtk33ajExllzJv9/JLR+Orp4W/kvZQEX4thsI11eDVIhKis7pdFDp3Vpfkx9Goe4EmOCjx/V0r0mOagGws9MuyLRSfCwKF3scbmR/CGNzehDSRTWYvRrwvefgbRkdFWbS4RV7r9RxGjIICG2ol3AJGdMiVO4PkUjV+OzirZdyZzC2PEHxlO0aVz6ChNipJ0UQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ld8pTkWM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ld8pTkWM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1x2R50Tzz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 18:59:11 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3a4c47bb6e3so169885a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791619149; x=1792223949; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JUYV9kBM40++h+Iuf/kFSxpEvNiJz1Gg8/l7n+m9rxI=;
        b=ld8pTkWM8EACiCHBVG0mHwcOCuK8rRAniaPHHHYapuKBT1Sk7bEwMjmlccLzUY7uh2
         RYH6ZdfAX76iVQXAg4yedJIExP2w/dutGozuczHjgk/YMwBqh2/vsoHKrnZHSQY1jo6G
         uNk6pAEiODjSJMbUEncZrZ29aFf7JOmLNFf20LS4/Lxqv+XpPOsGxgCrJMz3soLtROu1
         mMoveFP4jymW/QoKrcQH07ku6qkmKAiQIWI/DYeIsJM06t4em70JQSuXCeca8ouHkzKm
         FIGLlxxq0s4MQ5RMsTd0JzPaAJs7DeSgRDx83GZCB7Wh0pJf3uUahILnryYnwk93uXun
         aJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619149; x=1792223949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JUYV9kBM40++h+Iuf/kFSxpEvNiJz1Gg8/l7n+m9rxI=;
        b=WUCMyc+xo5V/DAaoxFL+mue20uQ9qqh4N0s32UEAaKI7cKswS1Ou6jfrxBqrhFKaCK
         1SgMYUtxKPbqrzXh8aKPugOF+m9acIAE6/VLuJKPCxQhku/Ck1Y8I99Nw2ZnrfoDoz+P
         UemcTCEkoaUPrg+WGjGcNXa1mkC2T1waMPpaAdYEE5RXQKzRwZujpQ46HJUtDily2sMo
         j9/cCN/kTokcBIcntWfEq+yAxBfA/WGG1wEiqFFYYbpSq5xSFIAy+2iFmNfAihcogCMv
         kGvoNGSfttrtSOk1nRiiXeOsNe+3IFPODmwHXhO17NTTqoUfn8Jhsk3ne8g5j5qn99r4
         pbvg==
X-Forwarded-Encrypted: i=1; AKwUvBxnRmpe+nyH0wSfQnG43XPZAnpVY/5YNETvJoR4fQ7aUbtt3B6lAruDZXrYlphSI9NJliongNDf6pfgSc8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKEz0e8QytPkN6MBPSwctNjEnwg2/3xrT19BJIAt1M1BgcvZnMo
	HBcvPD+0rOiAv9ahrmk98osLToV9Un6gQJ58OwgmKxOIvmiIa4NvwNTjKLG9cvCBS1Q=
X-Gm-Gg: AYBFou2N48GglB972I+I/2RtuTscFKBkjwZ+QTGb1EMhZ0rLIYFmVWKWqHWPfigIuF3
	RZvDim4afS4mEhTEJBdssxrc0DxAOw3AdXPfELUKOlZQaRe2k6eCYTekXW8RxBsQhf7YcoZKtfF
	1FYb4x4SktIAMDuKgFgGe+JwVgiVaGKzDT6HTmu24EMiHhNTwEFkrG6UVPKwZlc6udORlhPZtnh
	Ckb/Y+8s8gV87ATYqPnlevFnQ9qHaMolMbi/h2yVEMURhKM+VN32GVfHVwzk9oQN7M+/cqH/YG3
	o2vNss99pkaYji7+hs0UVQdTbc947EZNeKf0a1sfjmWMqxii0WHGCd8+iHLKMr3FGBIaxl4+H9u
	ljCK0JkuIAT8XJzo70CT8Wx3AQEcxsAbz94Vr+JDzWv6IVUzgphOJnsNkOMr3By3+5u8qJMffi+
	j5LdaMX2b8qLQgtjRSOS8MhRMWlhcWXauCr+uyitJON/hRLxTV3wABhWZEYDl2jiUlO+E2BwoKn
	xFbe2cOLFpIQeIkN0TWOlGO3H/tP4bp5wj4lg==
X-Received: by 2002:a17:90b:2d86:b0:3a7:d2b5:2e99 with SMTP id 98e67ed59e1d1-3ab3a60d1eamr3205394a91.20.1791619149216;
        Sat, 10 Oct 2026 00:59:09 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab57c05724sm3473569a91.4.2026.10.10.00.59.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 00:59:08 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v4 5/6] mm/sparse-vmemmap: open-code vmemmap_populate_address()
Date: Sat, 10 Oct 2026 15:57:54 +0800
Message-ID: <20261010075755.83339-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261010075755.83339-1-songmuchun@bytedance.com>
References: <20261010075755.83339-1-songmuchun@bytedance.com>
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

vmemmap_populate_address() no longer has any callers that need the
returned PTE.  Its only remaining user, vmemmap_populate_range(), only
checks whether population succeeded.

Open-code vmemmap_populate_address() directly in
vmemmap_populate_basepages(), remove the now-redundant range helper,
and return -ENOMEM directly on failure.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v4:
- Collect Reviewed-by from Lance Yang

v2:
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 54 ++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 07188cdf00f6..40eba70c0048 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -352,8 +352,8 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 	return pgd;
 }
 
-static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
-						  struct vmem_altmap *altmap)
+int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
+					 int node, struct vmem_altmap *altmap)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -361,48 +361,28 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd_t *pmd;
 	pte_t *pte;
 
-	pgd = vmemmap_pgd_populate(addr, node);
-	if (!pgd)
-		return NULL;
-	p4d = vmemmap_p4d_populate(pgd, addr, node);
-	if (!p4d)
-		return NULL;
-	pud = vmemmap_pud_populate(p4d, addr, node);
-	if (!pud)
-		return NULL;
-	pmd = vmemmap_pmd_populate(pud, addr, node);
-	if (!pmd)
-		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap);
-	if (!pte)
-		return NULL;
-	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
-
-	return pte;
-}
-
-static int __meminit vmemmap_populate_range(unsigned long start,
-					    unsigned long end, int node,
-					    struct vmem_altmap *altmap)
-{
-	unsigned long addr = start;
-	pte_t *pte;
-
-	for (; addr < end; addr += PAGE_SIZE) {
-		pte = vmemmap_populate_address(addr, node, altmap);
+	for (unsigned long addr = start; addr < end; addr += PAGE_SIZE) {
+		pgd = vmemmap_pgd_populate(addr, node);
+		if (!pgd)
+			return -ENOMEM;
+		p4d = vmemmap_p4d_populate(pgd, addr, node);
+		if (!p4d)
+			return -ENOMEM;
+		pud = vmemmap_pud_populate(p4d, addr, node);
+		if (!pud)
+			return -ENOMEM;
+		pmd = vmemmap_pmd_populate(pud, addr, node);
+		if (!pmd)
+			return -ENOMEM;
+		pte = vmemmap_pte_populate(pmd, addr, node, altmap);
 		if (!pte)
 			return -ENOMEM;
+		vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 	}
 
 	return 0;
 }
 
-int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
-					 int node, struct vmem_altmap *altmap)
-{
-	return vmemmap_populate_range(start, end, node, altmap);
-}
-
 /*
  * Write protect the mirrored tail page structs for HVO. This will be
  * called from the hugetlb code when gathering and initializing the
-- 
2.54.0


