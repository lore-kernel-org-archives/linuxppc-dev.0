Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19986606A331
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xD9kRPan
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJkyw4GVnz2xK7;
	Tue, 03 Nov 2026 21:17:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793701048;
	cv=none; b=a/yccqvNF8HDBiGH66++PaizBkxuNymdiRSLLdREK857dLBvplcsozp+lKjCqB/SLxq3NsjWF0foSTG51mkk4gTRBOkadbmTfA9G1sMR0Rh/tmfKAua6EOVFOk4t9Zrendt66wMIOECpYywNjjl8CJheU0AyUZUaI80QWfdkGzOyIJ7tUvowiODudSsNZO4WdRDSUHWS4sx5SuPE/Vl9QB3f0RV6u3cBczUfO7qtCgXlXzkxDnolMkDpi0trbS6LADH8rQnGaEF9XFtndhh6Ng0MmmgvN47FYMlRSOB4nzlv/yIw8DRyeYoJbYXmondCt7zumzFTiqyQs1U3mv9OoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793701048; c=relaxed/relaxed;
	bh=+SJoEqsvZ+TRv506SN0uWYqGOCHbvZTF1hg+QTdNQpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFdK9sfoGhAk7+1vLyTbUQXWYEnXZ2gY+2+rMEfxGvbl6jS2e1hWPl8kA/KJIkGL7VBldpgRQuHTTiMOZKOHRNwYFXRoLSnFq84cIOEbvvs78qe1U8ztIC5s7u9a2w6xHi3aM0LCdhiKJ5T4iTp3wADCZTvY9QvUPqQEiT+LHZvMcYHuQR6k0SX8b4EPywJTVYGPRzKRZSpPw9OTmjdhDJWm7VngqOd+Sq6yjw/TBnB7xls6Eu3D2IGpZLyhF1OXwJ2X9tnpXqdbUrOgqCGBH4QVM5U8mfJ8Ay3l5fqM1M1EbR5TO0GfCX8cX9/6VOUb6Cnbm2OPhWqSHTOgTDVuzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xD9kRPan; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xD9kRPan;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkyv6sGDz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 21:17:27 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-36661f953e4so6081242eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701046; x=1794305846; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+SJoEqsvZ+TRv506SN0uWYqGOCHbvZTF1hg+QTdNQpA=;
        b=xD9kRPanqGbPXCu6GFLhUafWaWmwy2B+Md15TEBPip1wkae9KvkFSMGsHoJqgo+Cb4
         kiGG7LtkB4KvQHkmRlh2EloD/wjabxj8YLNC6GWOyjKPnJQaaEw0L3qCwS1tsU/hUBhL
         McddLKZOrzWd53IGReUHXtogX2g/G4WUjZmGuT67dRD83ykqgCb1dNKc40a0IM+YjqCx
         5XomgDn12hWkg2X1DQkWVLiA3CFTxPUR27LZJSDimYJGpaVY6RHE0NjyembB1jTEgEA7
         EA4U42WiiDYrxndmyeenHPMLyIcPOB+MoeBk0VDoTnmqlZuqwUCAF5XhlcXPsnJ7YmNL
         xRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701046; x=1794305846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+SJoEqsvZ+TRv506SN0uWYqGOCHbvZTF1hg+QTdNQpA=;
        b=fIz0rd+UQf/LoEwXwr0cYaoSLl5b2LVlWhW5/d0NwO/UBfgvzykbU087NNJccWaSAk
         2Eet063iFMFJajh8A9+DeEUtjEw9MBVCs0PTCCIUsonNX0FYqUvwVQO54P/U+JjeC5Wl
         F+cxxLQzGgu9DhmLIaj1RRRxCOsgn2K7ckhsZEWsNHpBE8OrDuDRLvtd/UXvOxgFK5MH
         3aVRUl17LPXwFmecrYvR0828A3GuixjUiBfkft+EeeDf+5WmNvhyNt6i3iCCzShvfg1p
         dFZTmnlZTutzfXZHPibnueJTgyOd1gmQ9LV4lh916LEFLZzGEnsjD3hFXzuJeefDqXOn
         I2WQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrc71HmGsO19ZeS0jia2fLigMz+ri37gbhSbRDAXw1utiqu7CDcDpf+EoD8q/nTeoyMXO6IOT7F4j51n8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z80MAvbeEEDcCLA0X66buHIdFYqgCx4P9A+qorcjpg9BLCyc+an
	lJ3MOKrB9BBKuL852/2uVYdbhaAdvSRtaKPzFZL16roLwj+czSgBA7Xe
X-Gm-Gg: AYBFou3uSo6butgQaDfykhN8aECjgnSb8wZZC8eyv7GykV/rNZbpKgfSdThlSMHTQ4g
	zvnFOnPUu1M5zCwGhOBGjuZZYK0H3RfMP3TFJ/X2x4byhcE0zEgYOPv0x99G/oNxzSgtHf2Xqmv
	qj7i7bj6xxJy98k80DXOPMdOeWQLD7sO/r1zpKOFrD16zzbt7eb4d4lVW905lB912Gd9gvfr6gX
	/UZzSBeHMeRt+Z+bnRongtlqCAeYyJL47LFxlCgCDUeoABa2oCjZ9ozEBTu7MoLo8EoIReNmRne
	wK2+DsXlfPAaG8gTPTg7Z+SnrBwC3NN2qLaSaJgafo3GJ1/To83WEdla2TyiZGfNe45UVkvM/gb
	xrHP669wF0tkZLqNfpdPPfY3vnaW7pvhknfOvcC2ZjMy1Bu+InlO/YI5IiIsCWJ+9LjNj+Y2kF8
	tOFmNkLflPvng0raUAVYBwCXh8AejJGi0Rzx3z+QY0wSNY/BUSdz/rrwSZuxnJxkYYuHLiXIPWP
	99EcbUwUol5nJPxybpiO0VOK0jcXH2RzixeMWA8AhS+ij6EKBm9VjjXpxLe4TA6aZv+k9jdLG2s
	8wAea48IepUPuJcfjPmJ5N3ggife6g==
X-Received: by 2002:a05:693c:894e:20b0:368:7c9d:1577 with SMTP id 5a478bee46e88-36a4238420dmr18800136eec.20.1793701045554;
        Tue, 03 Nov 2026 02:17:25 -0800 (PST)
Received: from 027.. ([2409:8a20:4a5:7150:84fc:ce3c:7b09:dbca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm53145387eec.15.2026.11.03.02.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:17:25 -0800 (PST)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	linux-mm@kvack.org,
	urezki@gmail.com,
	will@kernel.org
Cc: Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com,
	anshuman.khandual@arm.com,
	baohua@kernel.org,
	chleroy@kernel.org,
	david@kernel.org,
	dev.jain@arm.com,
	jiangwen6@xiaomi.com,
	leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Subject: [PATCH v11 02/10] powerpc/8xx: add vmap_pte_set_huge()
Date: Tue,  3 Nov 2026 18:16:50 +0800
Message-Id: <20261103101658.766905-3-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
References: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wen Jiang <jiangwen6@xiaomi.com>

vmap installs PTE-level block mappings (SZ_16K/SZ_512K on powerpc/8xx)
by reusing set_huge_pte_at(), a HugeTLB helper gated by
CONFIG_HUGETLB_PAGE. This makes the feature silently unavailable on
CONFIG_HUGETLB_PAGE=n kernels and couples mm/vmalloc.c to HugeTLB
internals it does not otherwise need.

Add vmap_pte_set_huge() to powerpc/8xx, next to the existing
pmd_clear_huge()/pud_clear_huge() in mm/nohash/8xx.c. It builds the huge
PTE and writes it into the backing cells directly, without going through
set_huge_pte_at(), so it does not depend on CONFIG_HUGETLB_PAGE.

No vmap_pte_clear_huge() is needed: 8xx does not implement
arch_vmap_pte_range_unmap_size(), so the vmap unmap path never takes the
PTE-clearing branch.

In practice PPC_8xx selects HUGETLBFS unconditionally, so
CONFIG_HUGETLB_PAGE=n does not occur there today; this is a decoupling
cleanup rather than a new configuration.

There is no caller yet: mm/vmalloc.c is converted later in this series,
once the generic fallbacks are in place.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  4 +++
 arch/powerpc/mm/nohash/8xx.c                 | 29 ++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index e2ea8ba9f8ca..6ea854d67a2e 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -235,6 +235,10 @@ static inline pte_t ptep_get(pte_t *ptep)
 }
 #endif /* CONFIG_PPC_16K_PAGES */
 
+#define __HAVE_ARCH_VMAP_PTE_SET_HUGE
+void vmap_pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
+		  pgprot_t prot, unsigned long size);
+
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index a9d3f4729ead..54254182700c 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -220,3 +220,32 @@ int pmd_clear_huge(pmd_t *pmd)
 {
 	 return 0;
 }
+
+/*
+ * vmap PTE-level block mapping. Sets a present kernel mapping directly,
+ * so unlike set_huge_pte_at() it needs neither CONFIG_HUGETLB_PAGE nor
+ * set_pte_filter() (a no-op for non-exec kernel mappings).
+ */
+void vmap_pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
+		  pgprot_t prot, unsigned long size)
+{
+	pmd_t *pmdp = pmd_off(&init_mm, addr);
+	pte_t pte = pfn_pte(PHYS_PFN(phys), prot);
+	pte_basic_t val;
+	pte_basic_t *entry = (pte_basic_t *)ptep;
+	int num, i;
+
+	pte = arch_make_huge_pte(pte, ilog2(size), 0);
+	val = pte_val(pte);
+
+	/*
+	 * Make sure hardware valid bit is not set. We don't do
+	 * tlb flush for this update.
+	 */
+	VM_WARN_ON(pte_hw_valid(*ptep) && !pte_protnone(*ptep));
+
+	num = number_of_cells_per_pte(pmdp, val, 1);
+
+	for (i = 0; i < num; i++, entry++, val += SZ_4K)
+		*entry = val;
+}
-- 
2.34.1


