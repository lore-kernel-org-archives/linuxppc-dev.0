Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77646C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:14:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADCD2175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="S1aUtcUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADCD2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PQlH0kwlzDq61
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:14:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="S1aUtcUr"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQYt6QstzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:06:41 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PQYk6v4wz9vByy;
 Wed, 20 Mar 2019 11:06:34 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=S1aUtcUr; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id MCxzExgMd-u1; Wed, 20 Mar 2019 11:06:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PQYk5k54z9vByx;
 Wed, 20 Mar 2019 11:06:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553076394; bh=TdkFaqEZaF4rEmRCkdUJ4i7IZPhv3teZiDofQzCOris=;
 h=From:Subject:To:Cc:Date:From;
 b=S1aUtcUr4Q0o53gWaQbmoATi2pbMjdkdstCgy8We7M0HMue3b83A8sehEJLxmBz0E
 hL/HmcJb015VZhbksPGK6mZqWHRbnmB83EZQUqHKUedi0LZR6X6rsT6KHTUfVuW4Rc
 iVRhnUBVXy1XPMETCIdkmizQ2MOluku1gYmqPNds=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D338B8B91A;
 Wed, 20 Mar 2019 11:06:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id NG4fGzSDtkKW; Wed, 20 Mar 2019 11:06:35 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A7C558B911;
 Wed, 20 Mar 2019 11:06:35 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 7CC3863AEF; Wed, 20 Mar 2019 10:06:35 +0000 (UTC)
Message-Id: <cover.1553076180.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 00/27] Reduce ifdef mess in hugetlbpage.c and slice.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 20 Mar 2019 10:06:35 +0000 (UTC)
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

The main purpose of this series is to reduce the amount of #ifdefs in
hugetlbpage.c and slice.c

At the same time, it does some cleanup by reducing the number of BUG_ON()
and dropping unused functions.

It also removes 64k pages related code in nohash/64 as 64k pages are
can only by selected on book3s/64

Christophe Leroy (27):
  powerpc/mm: Don't BUG() in hugepd_page()
  powerpc/mm: don't BUG in add_huge_page_size()
  powerpc/mm: don't BUG() in slice_mask_for_size()
  powerpc/book3e: drop mmu_get_tsize()
  powerpc/mm: drop slice_set_user_psize()
  powerpc/64: only book3s/64 supports CONFIG_PPC_64K_PAGES
  powerpc/book3e: hugetlbpage is only for CONFIG_PPC_FSL_BOOK3E
  powerpc/mm: move __find_linux_pte() out of hugetlbpage.c
  powerpc/mm: make hugetlbpage.c depend on CONFIG_HUGETLB_PAGE
  powerpc/mm: make gup_hugepte() static
  powerpc/mm: split asm/hugetlb.h into dedicated subarch files
  powerpc/mm: add a helper to populate hugepd
  powerpc/mm: define get_slice_psize() all the time
  powerpc/mm: no slice for nohash/64
  powerpc/mm: cleanup ifdef mess in add_huge_page_size()
  powerpc/mm: move hugetlb_disabled into asm/hugetlb.h
  powerpc/mm: cleanup HPAGE_SHIFT setup
  powerpc/mm: cleanup remaining ifdef mess in hugetlbpage.c
  powerpc/mm: drop slice DEBUG
  powerpc/mm: remove unnecessary #ifdef CONFIG_PPC64
  powerpc/mm: hand a context_t over to slice_mask_for_size() instead of
    mm_struct
  powerpc/mm: move slice_mask_for_size() into mmu.h
  powerpc/mm: remove a couple of #ifdef CONFIG_PPC_64K_PAGES in
    mm/slice.c
  powerpc: define subarch SLB_ADDR_LIMIT_DEFAULT
  powerpc/mm: flatten function __find_linux_pte()
  powerpc/mm: flatten function __find_linux_pte() step 2
  powerpc/mm: flatten function __find_linux_pte() step 3

 arch/powerpc/Kconfig                             |   3 +-
 arch/powerpc/include/asm/book3s/64/hugetlb.h     |  73 +++++++
 arch/powerpc/include/asm/book3s/64/mmu.h         |  22 +-
 arch/powerpc/include/asm/book3s/64/slice.h       |   7 +-
 arch/powerpc/include/asm/hugetlb.h               |  87 +-------
 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h |  45 +++++
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h     |  18 ++
 arch/powerpc/include/asm/nohash/32/slice.h       |   2 +
 arch/powerpc/include/asm/nohash/64/pgalloc.h     |   3 -
 arch/powerpc/include/asm/nohash/64/pgtable.h     |   4 -
 arch/powerpc/include/asm/nohash/64/slice.h       |  12 --
 arch/powerpc/include/asm/nohash/hugetlb-book3e.h |  45 +++++
 arch/powerpc/include/asm/nohash/pte-book3e.h     |   5 -
 arch/powerpc/include/asm/page.h                  |  12 +-
 arch/powerpc/include/asm/pgtable-be-types.h      |   7 +-
 arch/powerpc/include/asm/pgtable-types.h         |   7 +-
 arch/powerpc/include/asm/pgtable.h               |   3 -
 arch/powerpc/include/asm/slice.h                 |   8 +-
 arch/powerpc/include/asm/task_size_64.h          |   2 +-
 arch/powerpc/kernel/fadump.c                     |   1 +
 arch/powerpc/kernel/setup-common.c               |   8 +-
 arch/powerpc/mm/Makefile                         |   4 +-
 arch/powerpc/mm/hash_utils_64.c                  |   1 +
 arch/powerpc/mm/hugetlbpage-book3e.c             |  52 ++---
 arch/powerpc/mm/hugetlbpage-hash64.c             |  16 ++
 arch/powerpc/mm/hugetlbpage.c                    | 245 ++++-------------------
 arch/powerpc/mm/pgtable.c                        | 114 +++++++++++
 arch/powerpc/mm/slice.c                          | 132 ++----------
 arch/powerpc/mm/tlb_low_64e.S                    |  31 ---
 arch/powerpc/mm/tlb_nohash.c                     |  13 --
 arch/powerpc/platforms/Kconfig.cputype           |   4 +
 31 files changed, 438 insertions(+), 548 deletions(-)
 create mode 100644 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
 delete mode 100644 arch/powerpc/include/asm/nohash/64/slice.h
 create mode 100644 arch/powerpc/include/asm/nohash/hugetlb-book3e.h

-- 
2.13.3

