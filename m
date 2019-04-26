Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2DFC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:05:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46D4206E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="QGM+Lv3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46D4206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r3SF6T7yzDqdn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:05:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="QGM+Lv3d"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r3Kn3rTgzDqZX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 15:59:41 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44r3Kf6Zfqz9v1tk;
 Fri, 26 Apr 2019 07:59:34 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=QGM+Lv3d; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Jg00ZU2gQyHd; Fri, 26 Apr 2019 07:59:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44r3Kf5SGzz9v1tj;
 Fri, 26 Apr 2019 07:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556258374; bh=UO8QQZnCRrwLCnv6BvUzG0fF7tb6obsPVTDHehYDHTM=;
 h=From:Subject:To:Cc:Date:From;
 b=QGM+Lv3d8Yqykq7tesvcAXpQ0RwH/3pxaSrkRSmEtVqxC39PgwcgM0//PXyY6Kzyg
 TzQ9awMlVDuMS+V2xdpaA0wzoc7L2vdMLN5TGq/CpRkVC+QHj+eYwKmOI+hC5qOgNd
 wthlSrxBQDW8shHDaCPgx500Tlc26W1FpoDN6URs=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C9578B807;
 Fri, 26 Apr 2019 07:59:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id g41VuIoB4Wt6; Fri, 26 Apr 2019 07:59:35 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C0058B74C;
 Fri, 26 Apr 2019 07:59:35 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 51F5766278; Fri, 26 Apr 2019 05:59:35 +0000 (UTC)
Message-Id: <cover.1556258134.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 00/17] Reduce ifdef mess in hugetlbpage.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Fri, 26 Apr 2019 05:59:35 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is a split out of v1 series "Reduce ifdef mess in hugetlbpage.c and slice.c"

The main purpose of this series is to reduce the amount of #ifdefs in
hugetlbpage.c by moving subarch specific stuff in dedicated header files.

This series also drops all CONFIG_PPC_64K_PAGES related code in book3e
as it cannot be selected.

Compile test at http://kisskb.ellerman.id.au/kisskb/head/74280b305020ab2c50efe383d37fccff009e6b84/

Christophe Leroy (17):
  powerpc/mm: Don't BUG() in hugepd_page()
  powerpc/mm: don't BUG in add_huge_page_size()
  powerpc/book3e: drop mmu_get_tsize()
  powerpc/64: only book3s/64 supports CONFIG_PPC_64K_PAGES
  powerpc/book3e: hugetlbpage is only for CONFIG_PPC_FSL_BOOK3E
  powerpc/mm: move __find_linux_pte() out of hugetlbpage.c
  powerpc/mm: make hugetlbpage.c depend on CONFIG_HUGETLB_PAGE
  powerpc/mm: make gup_hugepte() static
  powerpc/mm: split asm/hugetlb.h into dedicated subarch files
  powerpc/mm: add a helper to populate hugepd
  powerpc/mm: cleanup ifdef mess in add_huge_page_size()
  powerpc/mm: move hugetlb_disabled into asm/hugetlb.h
  powerpc/mm: cleanup HPAGE_SHIFT setup
  powerpc/mm: cleanup remaining ifdef mess in hugetlbpage.c
  powerpc/mm: flatten function __find_linux_pte() step 1
  powerpc/mm: flatten function __find_linux_pte() step 2
  powerpc/mm: flatten function __find_linux_pte() step 3

 arch/powerpc/Kconfig                             |   3 +-
 arch/powerpc/include/asm/book3s/64/hugetlb.h     |  72 +++++++
 arch/powerpc/include/asm/hugetlb.h               |  87 +-------
 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h |  44 +++++
 arch/powerpc/include/asm/nohash/64/pgalloc.h     |   3 -
 arch/powerpc/include/asm/nohash/64/pgtable.h     |   4 -
 arch/powerpc/include/asm/nohash/hugetlb-book3e.h |  45 +++++
 arch/powerpc/include/asm/nohash/pte-book3e.h     |   5 -
 arch/powerpc/include/asm/page.h                  |  12 +-
 arch/powerpc/include/asm/pgtable-be-types.h      |   9 +-
 arch/powerpc/include/asm/pgtable-types.h         |   9 +-
 arch/powerpc/include/asm/pgtable.h               |   3 -
 arch/powerpc/include/asm/task_size_64.h          |   2 +-
 arch/powerpc/kernel/fadump.c                     |   1 +
 arch/powerpc/mm/Makefile                         |   4 +-
 arch/powerpc/mm/hash_utils_64.c                  |   1 +
 arch/powerpc/mm/hugetlbpage-book3e.c             |  52 ++---
 arch/powerpc/mm/hugetlbpage-hash64.c             |  16 ++
 arch/powerpc/mm/hugetlbpage.c                    | 240 +++--------------------
 arch/powerpc/mm/pgtable.c                        | 114 +++++++++++
 arch/powerpc/mm/tlb_low_64e.S                    |  31 ---
 arch/powerpc/mm/tlb_nohash.c                     |  13 --
 22 files changed, 366 insertions(+), 404 deletions(-)
 create mode 100644 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
 create mode 100644 arch/powerpc/include/asm/nohash/hugetlb-book3e.h

-- 
2.13.3

