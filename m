Return-Path: <linuxppc-dev+bounces-26219-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0A0C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 05:45:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYHxq1f3Mz2yvT;
	Mon, 31 Aug 2026 15:44:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788155087;
	cv=none; b=MQdEvFG+m0CKh56pzU0qkw4ENNYLkDVPIuYgp/4dRnOF02yV5PyoLxkfR/rJV6PyZp2okl2WcBB4zUNCeNm91tGEvwU75+lDedbIVtME1Potw+ZwlOc80aVFNWVVInA2SzRni31Xt2KMUeXe8Jp1AXaFoaOvY3xx+UPyWImCRtoKIkdBm7A8o1+h5/z1t1AmpG9D/35rFR2b+OlwzjQjKyqwHRGJsVDQseqnHiRKNF2Xy6SzumyhK8ztIvW2cDAEFr3nj/YWOTZxWo3l7tdzREOXWU69xFDKO8gCnst+dPukyRB8kZCmUaJIHg4hGMg4WYXfCy8dxy8FWC1Y9C2w2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788155087; c=relaxed/relaxed;
	bh=l8tEaJoybxgEHiydhpmRrd0zyZxOUOa5tuSqtahiLM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAqUdrobTgJMrevVT8v+/nkeKJTCM1OEwT2SFJt85QM5jFz4uMGzm7ZGK+FMRkjXHvtfQB40rAbH+/Brtkaxt1/JRzABK7i4nw2ha6EA4qXD3OXu71zffWW8udNSQrsfQVT5vHt0E1RPElW3uoFwnjN0bHM8sCQ1+65aff87tfHenSvmpw04OV792vVpFBHMwfp2vgzYtTsDMj4aqvVp+XFvnQTjLiG0hyuaQzBO4lsDQ93D/K71Fia548xvDuYLTifww2Ixm469T3ecoxUqAY4kVog0mDP11QSKydgNrHeJp5BIWUktQ/DtJl4RrIXQxE2vjYN96GfPWBTRNg4bng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=U0L19rtb; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=U0L19rtb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYHxn1bwFz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 15:44:44 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CF061A32;
	Sun, 30 Aug 2026 22:43:56 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6785C3F85F;
	Sun, 30 Aug 2026 22:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788155040; bh=19JNL2aQ1m2bgjsQFbzvNHwUtw8tQlkca/Xxp7GPwo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0L19rtbEHy9Bp2X2iUVLKKtbExFWVCCT5piVe9NpoUB1AFhA8YHZQbH1wlPAPfX4
	 Ay2S64IR505XEPoJ0IN4Oh6nslmTu7PwulMz8Lw7NqgU8iCXl/uxnUPMxcESRtkCpw
	 mWcDca7zBkcW4qfWA9izm/4P351I4KVkwzyARqd8=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: samuel.holland@sifive.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
Subject: [PATCH 7/8] sh/mm: Stop using pgd_ERROR()
Date: Mon, 31 Aug 2026 11:13:29 +0530
Message-ID: <20260831054331.625505-8-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
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

Stop using pgd_ERROR() in __get_pte_phys() when page table entry is already
known to be empty.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sh/mm/init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 8d65e60688dc..93921109f4e6 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -52,10 +52,8 @@ static pte_t *__get_pte_phys(unsigned long addr)
 	pmd_t *pmd;
 
 	pgd = pgd_offset_k(addr);
-	if (pgd_none(*pgd)) {
-		pgd_ERROR(*pgd);
+	if (pgd_none(*pgd))
 		return NULL;
-	}
 
 	p4d = p4d_alloc(NULL, pgd, addr);
 	if (unlikely(!p4d)) {
-- 
2.43.0


