Return-Path: <linuxppc-dev+bounces-25714-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A66C5AD7B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 04:22:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJz3l5hyVz301Y;
	Tue, 11 Aug 2026 14:22:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786422131;
	cv=none; b=mz+x2GSahMWLiHK7TTRfxE9yZaytOK7mS52kLeZMZxIJ7T65rCXdcRYXarIFDuWj7wQxAs2OwVyWJ5wC3Bm1ILnB/hBpZr1FHGWCRAHH++y0h5OkCINq35/G+6Cs7Dsbho1LDveZOGJ+dh4gNYQd0cvggEwxWwrztsWpAi6/lEOvZSIiJWPm28g998/C053ftDLleQTSpndHxj3WTXATyi6IpQHiWBrgu1TvdyhY9zKNNt+fi4XiwydERLUI0Bcd+C40DcwwQr4MIUuKRjiR67/uPwhRaShKealkNNIYzAfwklQtw2cDpKf/MBQeKXfpbVDOMo95Tipkj8kNsMU/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786422131; c=relaxed/relaxed;
	bh=poodNdxA7WPULNKhYdttvzFWmhwiFf+VlcVKFtQPX94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAMgJXQiZGGgRiDQllvk6bxOZsHWyqNSdQqK8tn3QUqs434oIsVpPJ0WmrFSYa4yO4ftS9d+Pa5mlMn+Dod9/1uNgIjhVa+lrfyPEev6iYRYahpnGQWj6FJ/OvLXGOfO6H58BESaD9/w1tmyMamA2KjhA4E7Wg0p7Qxro7KN1tDU+S20Grn7EFUgJTc3qYp2d4a3GzyJsU8TRbivXMjS9ED1gU9OcTovI75Z7yB0Rm5Ek9OyXpSnWBWpiwXOcKzPMI0ZuawUtTSuPVgGb5rwBPqL6EMbmd6SCWug81hveIIQUtkhZZSYSYYmtM2R/OyQ+xC8ppZtgt9vHiyI2CpiDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NDnTBVj2; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NDnTBVj2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJz3l0Lmkz304r
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 14:22:10 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 977B6168F;
	Mon, 10 Aug 2026 21:21:35 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD6F33F673;
	Mon, 10 Aug 2026 21:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786422099; bh=OKKk+J7eMHIWw8QjhuEJW1LEtsSDjKpxvNzpv83/ug8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDnTBVj22FStQ+XK0HLwvJKJro3KeX1TWQm5rzPJ0S7csuqOhawi++Hc637b87GPD
	 Hvinpr7iTMbSodkYtTOTqdZ/yXYwlvbKLRTdNZffXQArm0ptKBDdXtxSDLXybURVE7
	 0SmAxajLRK1u+03/uA3LFe6J/WvE1OGUYKFOsK0Q=
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
Subject: [RFC V2 4/6] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
Date: Tue, 11 Aug 2026 09:51:17 +0530
Message-ID: <20260811042119.3652929-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811042119.3652929-1-anshuman.khandual@arm.com>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
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
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sh/mm/init.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index b3c7fd84ceb4..0bb8555568a4 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -58,22 +58,16 @@ static pte_t *__get_pte_phys(unsigned long addr)
 	}
 
 	p4d = p4d_alloc(NULL, pgd, addr);
-	if (unlikely(!p4d)) {
-		p4d_ERROR(*p4d);
+	if (unlikely(!p4d))
 		return NULL;
-	}
 
 	pud = pud_alloc(NULL, p4d, addr);
-	if (unlikely(!pud)) {
-		pud_ERROR(*pud);
+	if (unlikely(!pud))
 		return NULL;
-	}
 
 	pmd = pmd_alloc(NULL, pud, addr);
-	if (unlikely(!pmd)) {
-		pmd_ERROR(*pmd);
+	if (unlikely(!pmd))
 		return NULL;
-	}
 
 	return pte_offset_kernel(pmd, addr);
 }
-- 
2.43.0


