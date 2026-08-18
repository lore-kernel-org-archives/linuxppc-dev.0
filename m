Return-Path: <linuxppc-dev+bounces-25938-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D60C5DF67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:01:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPGGh3Sqtz2yjV;
	Tue, 18 Aug 2026 14:01:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787025692;
	cv=none; b=gyKD92QdlYJoFVZnCnSA2rtDWBFXlgU1sIP5e2JdvtV8BOF0ERJvyeQs9V8+Rj9eW15FipZZDoM2ipT346/lTXhGUfSh0yOXbx+aJRl9qG/LoDy4e3UCP3EBCVm9UJt99fP8TyfjAiR+wdaJqI+pZx4Y47n9SpSKuuWLBlmjRJ+J2bbLQrY6dOrMjx4r66RCGXz+bY8AK9cdhaqfRhVUDJNaPgZxYF1td94s2eBADdOaEPbjeuEzQpZ6/Gb5H87yV7Cdlx8WRH5M/FrdxOSdVn61YWYEjRvZBoaOtsZgFWXOQSnURTbCePa1WhhG5+va6Qbve0p6Vp+YMsjHJaIFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787025692; c=relaxed/relaxed;
	bh=JgNJFkCkXVBCFeyWnDgafPWJnvI4aeQ+9PWN4ml6THI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUbbTR2Z2KTFwprskZJ9AsYBY0pNY6OYTSwGmGrUdxHMycQqSs1T3nszTj/fwKeOF+d4Dn/704B/f+GaOs38GlAAefdS59/olr6PAyDC5/0gFvoIRvXNdiKFWbghoL8+BjaR1Oph1EfgaghoSSWUEx5mbP2BavxvvgD35D3WVB2V2pcW82kP8FPbPmptLf6k4p6BQL8FAymrH+C2nCXSs0Xgs48pwsEqj6ukmIQnEXc3hlctZbxqT6wHGpYTGEpQphghMYyjPekK/vi9fvF8TBKnC9RTop9yCkryIvPeDfRgNqTAwFL1nvUPp3x/KFdk3boni6VlK0SjKfpbMBy4Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=utTgpugZ; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=utTgpugZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPGGg5BRKz2xxr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 14:01:31 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 552C0176C;
	Mon, 17 Aug 2026 21:00:56 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 439313F66F;
	Mon, 17 Aug 2026 21:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787025660; bh=jNvZ3ph4tfzqvfYMPDWyq7xHUxNcpHCKh93HJ34Xlag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utTgpugZygTuDjhpwxzKPuJMIDZz0EKonCrgJRpvQKS6INxHgHOfXIDFV+nOSQ7jF
	 7Bgl85I45aBhnw6MHWp+5DDIFHvHyFt07H8kgzKVC+zsqZqfrwYRzS13GPJp69yMK5
	 AJqMStMFmVH1+FyJHrLz9sBA+2QOVy632/sBTjjU=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC V3 4/8] parisc/mm: Directly use generic [pmd|pgd]_clear_bad()
Date: Tue, 18 Aug 2026 09:30:37 +0530
Message-ID: <20260818040041.1891769-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818040041.1891769-1-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
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

Drop [pmd|pgd]_ERROR() followed by [pmd|pgd]_clear() instances. But instead
directly use semantically equivalent generic helpers [pmd|pgd]_clear_bad()
in unmap_uncached_[pte|pmd]() which helps in dropping their corresponding
[pmd|pgd]_ERROR() macros across the tree.

Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/parisc/kernel/pci-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index bf9f192c826e..84e7309a8266 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -160,8 +160,7 @@ static inline void unmap_uncached_pte(pmd_t * pmd, unsigned long vaddr,
 	if (pmd_none(*pmd))
 		return;
 	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
+		pmd_clear_bad(pmd);
 		return;
 	}
 	pte = pte_offset_kernel(pmd, vaddr);
@@ -196,8 +195,7 @@ static inline void unmap_uncached_pmd(pgd_t * dir, unsigned long vaddr,
 	if (pgd_none(*dir))
 		return;
 	if (pgd_bad(*dir)) {
-		pgd_ERROR(*dir);
-		pgd_clear(dir);
+		pgd_clear_bad(dir);
 		return;
 	}
 	pmd = pmd_offset(pud_offset(p4d_offset(dir, vaddr), vaddr), vaddr);
-- 
2.43.0


