Return-Path: <linuxppc-dev+bounces-25711-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ACBC5B56A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 04:22:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJz3c1GHTz305D;
	Tue, 11 Aug 2026 14:22:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786422124;
	cv=none; b=UUBXxj3fEfli56yflG05aL72QI+ghsBHXxBfiQNsAUUXoKhH9anQiLh1niRZr+RWXJCGLSQPRNOkoZBbvXlsSHyTzLI6lZocN/lpGXyvUZgn/5I1mE0V9sjeaCnoUawGO7ubA99X7HYC61Wa9Keg4YZ1D+8ie0WFMuty5yYlgDKJcwYPL4Zas6wJsKVwiU0uQRQATLPM/oC86ANjaSGfIiTlqf3elf6MV+FCKJUkYRT8cshjCNzwn7PPS4PgeCrRTdpSO24kmZ3FlMut3hrK6SliYADrZzClCHRt4+fl28hAk3WybjoFEqHRFsgj8cihDDreXzjplALMY2aT+C4aRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786422124; c=relaxed/relaxed;
	bh=3fcryMXJ9mdlfh5fhkYvdWhUX0S8rMy1cCwqOeeyztA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ntFTVklve3dUqcMZsTBd6hCqAXHOXOnaBjzy4TfWVf/aWre/CGKiGFOwVY53O7p66r+z+Lbq/MPt3goFVdGKqIhE3NUbAYGNov5YOrBhArj0RXBR1VD/m158U3SGlx5GK8mZ+Tjt3qbJMlOTej/9Ro0hYzgazPZ4X3+Xd6q6PZhRr5gdDE398xImxBUaDXxGUi8AAw8m9lWE2TXthjdJbAvyFBEDPexqQv4x38K4QGFxTXla4ojo4Eoc00efKNPh7/bPa4uYy03MADwnjIB3v5Lqi0aLNWbfrSxwZzXx2dqlbxVgLlQ0abkXvA9PIvZsrCH2GdblriOkuPJsgwXuaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GopI0I0f; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GopI0I0f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJz3X6Bprz2yrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 14:21:58 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39B3114BF;
	Mon, 10 Aug 2026 21:21:21 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E55B3F673;
	Mon, 10 Aug 2026 21:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786422085; bh=U4Z1uTiwNPlptM0+2YMoqojdlsHVf+3xXUYXjiCQ8pk=;
	h=From:To:Cc:Subject:Date:From;
	b=GopI0I0fYfwHaaeo2Y1tRcsF2e/amGL0odHVP/X1kESNXKYqhycXNoTsAuQ3kbLz6
	 6aWj1XpWWD5XHhdxDVLSsmNEIV5BHzcUh5zug5WGO5oBPaTxRMDHz11rcK3BnPzn8e
	 wSjaNCIByq50FgWv0gwZJCSc7yloLZqXMTvqJhr0=
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
Subject: [RFC V2 0/6] mm: Drop pxd_ERROR()
Date: Tue, 11 Aug 2026 09:51:13 +0530
Message-ID: <20260811042119.3652929-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
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

pxd_ERROR() macros have been provided by all platforms, which are very much
identical and can be dropped off completely if these pgtable printing could
be moved to callers in generic MM aka all pxd_clear_bad().

But first cleanups and re-organizations are required in some platforms that
are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
macros have been completely dropped from the entire tree.

This series is based on v7.2-rc7 after the following patch. This has also
been built tested on multiple platforms.

https://lore.kernel.org/all/20260709044334.1741263-1-anshuman.khandual@arm.com/

Changes in RFC V2:

- Added clean up patches for platforms with existing pxd_ERROR() usage
- Dropped __FILE__ and __LINE__ from all pgtable entry printing

Changes in RFC V1:

https://lore.kernel.org/all/20260806080639.1916749-1-anshuman.khandual@arm.com/

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: linux-alpha@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-openrisc@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (6):
  loongarch/mm: Stop using pte_ERROR()
  parisc/mm: Directly use generic [pmd|pgd]_clear_bad()
  sh/mm: Stop using pte_ERROR()
  sh/mm: Stop using [p4d|pud|pmd]_ERROR()
  sh/mm: Stop using pgd_ERROR()
  mm: Drop pxd_ERROR()

 arch/alpha/include/asm/pgtable.h              |  7 ----
 arch/arc/include/asm/pgtable-levels.h         | 11 -----
 arch/arm/include/asm/pgtable.h                |  7 ----
 arch/arm/kernel/traps.c                       | 17 --------
 arch/arm64/include/asm/pgtable.h              | 15 -------
 arch/csky/include/asm/pgtable.h               |  4 --
 arch/hexagon/include/asm/pgtable.h            |  3 --
 arch/loongarch/include/asm/pgtable.h          | 13 ------
 arch/loongarch/mm/init.c                      |  2 +-
 arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
 arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
 arch/m68k/include/asm/sun3_pgtable.h          |  7 ----
 arch/microblaze/include/asm/pgtable.h         |  7 ----
 arch/mips/include/asm/pgtable-32.h            | 10 -----
 arch/mips/include/asm/pgtable-64.h            | 13 ------
 arch/nios2/include/asm/pgtable.h              |  7 ----
 arch/openrisc/include/asm/pgtable.h           |  7 ----
 arch/parisc/include/asm/pgtable.h             |  9 ----
 arch/parisc/kernel/pci-dma.c                  |  6 +--
 arch/powerpc/include/asm/book3s/32/pgtable.h  |  2 -
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  7 ----
 arch/powerpc/include/asm/nohash/32/pgtable.h  |  2 -
 .../include/asm/nohash/64/pgtable-4k.h        |  3 --
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  5 ---
 arch/riscv/include/asm/pgtable-64.h           |  9 ----
 arch/riscv/include/asm/pgtable.h              |  4 --
 arch/s390/include/asm/pgtable.h               | 11 -----
 arch/sh/include/asm/pgtable-3level.h          |  3 --
 arch/sh/include/asm/pgtable_32.h              | 13 ------
 arch/sh/mm/init.c                             | 27 ++++++------
 arch/sparc/include/asm/pgtable_32.h           |  3 --
 arch/sparc/include/asm/pgtable_64.h           | 10 -----
 arch/um/include/asm/pgtable-2level.h          |  7 ----
 arch/um/include/asm/pgtable-4level.h          | 13 ------
 arch/x86/include/asm/pgtable-2level.h         |  5 ---
 arch/x86/include/asm/pgtable-3level.h         | 11 -----
 arch/x86/include/asm/pgtable_64.h             | 18 --------
 arch/xtensa/include/asm/pgtable.h             |  4 --
 include/asm-generic/pgtable-nop4d.h           |  1 -
 include/asm-generic/pgtable-nopmd.h           |  1 -
 include/asm-generic/pgtable-nopud.h           |  1 -
 include/linux/mm_types.h                      | 41 +++++++++++++++++++
 mm/memory.c                                   | 41 +------------------
 mm/pgtable-generic.c                          | 21 ++++++++--
 44 files changed, 76 insertions(+), 346 deletions(-)

-- 
2.43.0


