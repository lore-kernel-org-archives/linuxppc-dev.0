Return-Path: <linuxppc-dev+bounces-25939-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BC4C5DF7F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:02:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPGH90Kg4z2yFt;
	Tue, 18 Aug 2026 14:01:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787025717;
	cv=none; b=HrqPpZwNiMUB+yYgIkgFiPdS2x7uF1KhP0rvGh01FMx/hMGWk7G8LjEEHDgbp8dMTpld7cExEuIcMdKvGPpgwJ6KuSGnYerIND/gwj8JSHSaPNRXwSx8bHY69ieZBlexBt2e9QbYp94yBScJiQ/ngIpBFZpgGlBM8r3btQeocfXSwgMcK3Z2FVmY0DAl6ExG11R1EQT+VuIIIBqQjEy5h6Kb5Do2lOSwOglXTWmPNvTQEN03u0GESi1NveXh7s/1WbQQFud9cpzWYCdGqxythRMRlCx3aL08fC8i5R64hTIXfMe+0qxbP4EzUe/OaJj36PIRNhYNYDAXcsLiknZZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787025717; c=relaxed/relaxed;
	bh=VAaSq06o5eLcDNJ2uS+etL1R98Fm8iCuW38Uswmm3gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPgbB57oq8zi8ST6C7URLL9CZJ9gLdgQO8cMIR/PaHzU14PJfI11SWoD2/tZzvMqaXVlAj1sh+UtdaMo+VOjoQ8MC16286j0hvR56PdlApq8cHe5aMq71UVJ4H0PlQwbJ75SmjVUVoeG4NT4Ivc3P88nqo9CnWiurUwHQez64rDhGH5FTkmXSfpTc1HXisX38bzDkBF1esaKsqi4ODxZy7dvysLMe8basKFFo0KJLAtSGNibHe60CPi5bQKIE/iRUWCmsHS1uVuZcuRbKgWbC50A8mN+Voc1LmkP6dWmfXxsXGljwJ9/9j48FxoRoiNj3OSXz+e3/0DigTUyfIw8GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tc5newTU; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tc5newTU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPGH76tH0z2yFP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 14:01:55 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB111A25;
	Mon, 17 Aug 2026 21:01:07 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 808DB3F66F;
	Mon, 17 Aug 2026 21:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787025671; bh=bPcYhQD4bzcwPSxJ8xkr0nWAdwCuI4IUaFLUJoGzm0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tc5newTUC09VdGP5B76jtkjpI9sci0rMLtuInHFPNr66B6IGS4L8Sm6tk4cwRiJ/b
	 5h9Qek1XhXsg75s765gvhzEXLlsEvx2RUEZ09z5Yy66pdJ94V8xeAxBFwA0Aq2SxNr
	 PoXj1cVq1/8qvOSP1sQSfrCVEOq/UFl8/jpp1jbo=
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
Subject: [RFC V3 7/8] sh/mm: Stop using pgd_ERROR()
Date: Tue, 18 Aug 2026 09:30:40 +0530
Message-ID: <20260818040041.1891769-8-anshuman.khandual@arm.com>
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

Stop using pgd_ERROR() in __get_pte_phys() when page table entry is already
known to be empty.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
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


