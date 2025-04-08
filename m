Return-Path: <linuxppc-dev+bounces-7528-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB674C3600C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Apr 2025 09:54:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZX1cm57Rbz30Lt;
	Tue,  8 Apr 2025 19:54:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744106040;
	cv=none; b=L4m0itRT301IpiWLWWW0TDCwSAo9eh2iodOFHc4uiIvFAW43ynvCfe41XiSy6b8WPmvhqHMq1J09vP3W1RT2aR6ZOByZSxyPjpva2AXX6b5am5C+zjoqyYcin/O45R6NkRWVtQeCuvwEzG/RcSrkmvk7mPVdIoHFs7II4nzelurVpSXb7YJd0Q72aoExtrn4HhwzLX9ivd/iwduWeUmcpBodC5ZZezFzee6OIO5hXOxPjd9sw/9qtS8w7s5P15+4dOQVcKGEeD/tAS2iiKAxjwiYexmkrJ/JsBwPaHJ7K/oSmLbYvHlJxcKZW9EhladLx8cSOe0aceQE4HZBBIEjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744106040; c=relaxed/relaxed;
	bh=tEBbZMuK7OXxaJSao4EKWfZ44UXf7uN/ZmWU7nnmgv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g64nVJLSo3JnqfZohLMIhWGF/l8AVGkZOreCnWj6v1S/2unr9C87AqIL+tPsHiDdVTtBwOBMkRZ+bOhyEwLPf7MGfO/pHla2YwZJQwhxyikb2/ejVr2tf3t5CwdbmcakUasLIymtB3VLRpM0B8Khm5EPb2pgfLPYKTUldykr29Bln9yYK81ewy1aQWbtj2tn5iKsbxjsQPJRZlyriOZP6uk3f8ibpSWhjAdyAAdwI9afDfqgEH93MWJ1Ec14fjbQ+dHKBX8I4bCKWLItio8o4Dm5YNGM2GgXq1v3vpmcsR5MnddBUzv4iw+O/3SRMt9wGV0XHODe8KVkXxSttbvJXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZX1cm0xGCz2yrt
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Apr 2025 19:54:00 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 211432308;
	Tue,  8 Apr 2025 02:53:30 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3DDB3F6A8;
	Tue,  8 Apr 2025 02:53:24 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 04/12] m68k: mm: Call ctor/dtor for kernel PTEs
Date: Tue,  8 Apr 2025 10:52:14 +0100
Message-ID: <20250408095222.860601-5-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250408095222.860601-1-kevin.brodsky@arm.com>
References: <20250408095222.860601-1-kevin.brodsky@arm.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic implementation of pte_{alloc_one,free}_kernel now calls
the [cd]tor. Align the m68k/ColdFire implementation of those
functions by calling the [cd]tor explicitly.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/m68k/include/asm/mcf_pgalloc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 465a71101b7d..fc5454d37da3 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -7,7 +7,7 @@
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	pagetable_free(virt_to_ptdesc(pte));
+	pagetable_dtor_free(virt_to_ptdesc(pte));
 }
 
 extern const char bad_pmd_string[];
@@ -19,6 +19,10 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
 	if (!ptdesc)
 		return NULL;
+	if (!pagetable_pte_ctor(mm, ptdesc)) {
+		pagetable_free(ptdesc);
+		return NULL;
+	}
 
 	return ptdesc_address(ptdesc);
 }
-- 
2.47.0


