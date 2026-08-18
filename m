Return-Path: <linuxppc-dev+bounces-25940-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D983BC5DF67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:02:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPGH91Xkmz2yS6;
	Tue, 18 Aug 2026 14:01:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787025717;
	cv=none; b=b0l1Efzdbzc8n7IdeO0I0jwJ5IZa/YPioVZgPbBUS9XiTIRlRppbR+iAbhMJ7nnMB8+GwAcM+P6fJMX0LV1mpfI4kla2wwPlSaJwIZl0PwDxTpcJjvRT+G8h1GdCM8EkS7jl8hxsncDX5XvdK16BEuIsj+Zc0q7k2BydMU1W/qewPplrspab3N+6QAR0eEJfoeIQcE8SBrMWE2WePpXc7KIeXxNe+26v0Y7HMM46i3j4b/YUECTNzWEiKcRaugb4PY1adAxFBiPxpY/wuelhUquLGIzJ/Fux0Ul+2MzwtyUXrDh9yKaDCrAK55egKQpQhl1c5HLCl/jyNN0LKAw3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787025717; c=relaxed/relaxed;
	bh=omDZX1bufOD81zOaJjwGdpJ6E7g6fPFvf2RST58oZaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ho8qXCWxnn2Vm4h9QZ2KDzWYt3kEd2hAoljzxRfy86lZB7Bnt/6dSxY0F6lixIc1hg+Y9IOD0a05XP0epYMwdSnfMlrbEEL0io0X4kgDC4HqlZYP43xvXYBtc+1U5KGRorJm5AiljWVAnfvDxt9W6NToGQsmKdYdSe44lj3I7+OwHi8mGc2S9mLFGNcf4+VnDA7dHAjzAL5zpxzktc81OKprrbxPif3v7n799k5hHDJ7Bm5GeLJVEDa30SUvt8B7Ppb85tmic/dB6wVJXNtNOZNiS2sJrt1iKpVufj+u04sMlSzYdzXEx1e+H3e7HLmVNJe1LDah9z5maRomKLtuCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Mayvk+7Y; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Mayvk+7Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPGH76sncz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 14:01:55 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFC681A00;
	Mon, 17 Aug 2026 21:01:03 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3D303F66F;
	Mon, 17 Aug 2026 21:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787025667; bh=fvWsPm2RhovRhyeQja3vObvDm/dQnZu4xzhWldyViFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mayvk+7YyBI2v2eqdqjZoS2Z0dSe2CBNgITCjGmuVovDxkhyBaxSP1dLk5kNH1nez
	 idT86Nq/jZBkUaXw0freV4r8tdOSXnkHA9v9bqHpKf4rUtAsLWC+ksnp8Cx/gdMRyF
	 17IZ3guv1INHQU+zfmWJE2RLFpqbe6NzJqmu5VKg=
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
Subject: [RFC V3 6/8] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
Date: Tue, 18 Aug 2026 09:30:39 +0530
Message-ID: <20260818040041.1891769-7-anshuman.khandual@arm.com>
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

Stop using [p4d|pud|pmd]_ERROR() in __get_pte_phys() as the pgtable entries
are known to be NULL and hence could not really be accessed.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in RFC V3

- Added some pr_error() messages in __get_pte_phys()

 arch/sh/mm/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 9466ae6f9f16..8d65e60688dc 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -59,19 +59,19 @@ static pte_t *__get_pte_phys(unsigned long addr)
 
 	p4d = p4d_alloc(NULL, pgd, addr);
 	if (unlikely(!p4d)) {
-		p4d_ERROR(*p4d);
+		pr_err("allocating p4d table failed\n");
 		return NULL;
 	}
 
 	pud = pud_alloc(NULL, p4d, addr);
 	if (unlikely(!pud)) {
-		pud_ERROR(*pud);
+		pr_err("allocating pud table failed\n");
 		return NULL;
 	}
 
 	pmd = pmd_alloc(NULL, pud, addr);
 	if (unlikely(!pmd)) {
-		pmd_ERROR(*pmd);
+		pr_err("allocating pmd table failed\n");
 		return NULL;
 	}
 
-- 
2.43.0


