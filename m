Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9BCC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 10:03:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8557A20811
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 10:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="KI0HM7kY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8557A20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Vy4D1Sm3zDqSq
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 21:03:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="KI0HM7kY"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vy044pWxzDqSS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 21:00:03 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Vxzy0lwlz9v1N8;
 Fri, 29 Mar 2019 10:59:58 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=KI0HM7kY; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id fBtcpYYs_2pE; Fri, 29 Mar 2019 10:59:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Vxzx6WpKz9v1N5;
 Fri, 29 Mar 2019 10:59:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553853597; bh=pAttTsWzSXfrR0mROgMC6mNQCOKqeHrRNNzfCd+2Ml4=;
 h=From:Subject:To:Cc:Date:From;
 b=KI0HM7kYSfpx8LITqHPvzbJsRCKR+MuVdSBMV3J1F6o6V7Dvy2K9hFvTn+bMEwsIs
 q1ffdIYD0l80FITpbuvolMQsQf5yIQZJNAJDVte/9ZWSJmD/YqteEb5pfFg3nsXCU7
 BByISZHYo0JMgpINeyNz8MubaaX4kxO6fOEFGJW8=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 057BF8B88A;
 Fri, 29 Mar 2019 10:59:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id v2Bt49-uaFr2; Fri, 29 Mar 2019 10:59:58 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D3BC78B889;
 Fri, 29 Mar 2019 10:59:58 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C1E166FC95; Fri, 29 Mar 2019 09:59:58 +0000 (UTC)
Message-Id: <cover.1553853405.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 0/4] powerpc: Split arch/powerpc/mm/ directory
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 29 Mar 2019 09:59:58 +0000 (UTC)
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

arch/powerpc/mm/ contains many files that are specific to subarches.

This series splits arch/powerpc/mm/ in three subparts:
- arch/powerpc/mm/book3s64
- arch/powerpc/mm/book3s32
- arch/powerpc/mm/nohash

Christophe Leroy (4):
  powerpc/mm: change #include "mmu_decl.h" to <mm/mmu_decl.h>
  powerpc/mm: Move book3s64 specifics in subdirectory mm/book3s64
  powerpc/mm: Move book3s32 specifics in subdirectory mm/book3s64
  powerpc/mm: Move nohash specifics in subdirectory mm/nohash

 arch/powerpc/mm/Makefile                           | 43 ++--------------------
 arch/powerpc/mm/book3s32/Makefile                  |  6 +++
 arch/powerpc/mm/{ => book3s32}/hash_low_32.S       |  0
 .../powerpc/mm/{ => book3s32}/mmu_context_hash32.c |  0
 arch/powerpc/mm/{ => book3s32}/ppc_mmu_32.c        |  2 +-
 arch/powerpc/mm/{ => book3s32}/tlb_hash32.c        |  2 +-
 arch/powerpc/mm/book3s64/Makefile                  | 28 ++++++++++++++
 arch/powerpc/mm/{ => book3s64}/hash64_4k.c         |  0
 arch/powerpc/mm/{ => book3s64}/hash64_64k.c        |  0
 arch/powerpc/mm/{ => book3s64}/hash_native_64.c    |  0
 arch/powerpc/mm/{ => book3s64}/hash_utils_64.c     |  0
 arch/powerpc/mm/{ => book3s64}/hugepage-hash64.c   |  0
 .../powerpc/mm/{ => book3s64}/hugetlbpage-hash64.c |  0
 arch/powerpc/mm/{ => book3s64}/hugetlbpage-radix.c |  0
 .../mm/{ => book3s64}/mmu_context_book3s64.c       |  0
 arch/powerpc/mm/{ => book3s64}/mmu_context_iommu.c |  0
 arch/powerpc/mm/{ => book3s64}/pgtable-book3s64.c  |  2 +-
 arch/powerpc/mm/{ => book3s64}/pgtable-hash64.c    |  2 +-
 arch/powerpc/mm/{ => book3s64}/pgtable-radix.c     |  0
 arch/powerpc/mm/{ => book3s64}/pkeys.c             |  0
 arch/powerpc/mm/{ => book3s64}/slb.c               |  0
 arch/powerpc/mm/{ => book3s64}/subpage-prot.c      |  0
 arch/powerpc/mm/{ => book3s64}/tlb-radix.c         |  0
 arch/powerpc/mm/{ => book3s64}/tlb_hash64.c        |  0
 arch/powerpc/mm/{ => book3s64}/vphn.c              |  0
 arch/powerpc/mm/{ => book3s64}/vphn.h              |  0
 arch/powerpc/mm/dma-noncoherent.c                  |  2 +-
 arch/powerpc/mm/init_32.c                          |  2 +-
 arch/powerpc/mm/init_64.c                          |  2 +-
 arch/powerpc/mm/mem.c                              |  2 +-
 arch/powerpc/mm/{ => nohash}/40x_mmu.c             |  2 +-
 arch/powerpc/mm/{ => nohash}/44x_mmu.c             |  2 +-
 arch/powerpc/mm/{ => nohash}/8xx_mmu.c             |  2 +-
 arch/powerpc/mm/nohash/Makefile                    | 21 +++++++++++
 arch/powerpc/mm/{ => nohash}/fsl_booke_mmu.c       |  2 +-
 arch/powerpc/mm/{ => nohash}/hugetlbpage-book3e.c  |  0
 arch/powerpc/mm/{ => nohash}/mmu_context_nohash.c  |  2 +-
 arch/powerpc/mm/{ => nohash}/pgtable-book3e.c      |  2 +-
 arch/powerpc/mm/{ => nohash}/tlb_low_64e.S         |  0
 arch/powerpc/mm/{ => nohash}/tlb_nohash.c          |  2 +-
 arch/powerpc/mm/{ => nohash}/tlb_nohash_low.S      |  0
 arch/powerpc/mm/numa.c                             |  2 +-
 arch/powerpc/mm/pgtable_32.c                       |  2 +-
 arch/powerpc/mm/pgtable_64.c                       |  2 +-
 44 files changed, 77 insertions(+), 57 deletions(-)
 create mode 100644 arch/powerpc/mm/book3s32/Makefile
 rename arch/powerpc/mm/{ => book3s32}/hash_low_32.S (100%)
 rename arch/powerpc/mm/{ => book3s32}/mmu_context_hash32.c (100%)
 rename arch/powerpc/mm/{ => book3s32}/ppc_mmu_32.c (99%)
 rename arch/powerpc/mm/{ => book3s32}/tlb_hash32.c (99%)
 create mode 100644 arch/powerpc/mm/book3s64/Makefile
 rename arch/powerpc/mm/{ => book3s64}/hash64_4k.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/hash64_64k.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/hash_native_64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/hash_utils_64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/hugepage-hash64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/hugetlbpage-hash64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/hugetlbpage-radix.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/mmu_context_book3s64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/mmu_context_iommu.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/pgtable-book3s64.c (99%)
 rename arch/powerpc/mm/{ => book3s64}/pgtable-hash64.c (99%)
 rename arch/powerpc/mm/{ => book3s64}/pgtable-radix.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/pkeys.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/slb.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/subpage-prot.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/tlb-radix.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/tlb_hash64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/vphn.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/vphn.h (100%)
 rename arch/powerpc/mm/{ => nohash}/40x_mmu.c (99%)
 rename arch/powerpc/mm/{ => nohash}/44x_mmu.c (99%)
 rename arch/powerpc/mm/{ => nohash}/8xx_mmu.c (99%)
 create mode 100644 arch/powerpc/mm/nohash/Makefile
 rename arch/powerpc/mm/{ => nohash}/fsl_booke_mmu.c (99%)
 rename arch/powerpc/mm/{ => nohash}/hugetlbpage-book3e.c (100%)
 rename arch/powerpc/mm/{ => nohash}/mmu_context_nohash.c (99%)
 rename arch/powerpc/mm/{ => nohash}/pgtable-book3e.c (99%)
 rename arch/powerpc/mm/{ => nohash}/tlb_low_64e.S (100%)
 rename arch/powerpc/mm/{ => nohash}/tlb_nohash.c (99%)
 rename arch/powerpc/mm/{ => nohash}/tlb_nohash_low.S (100%)

-- 
2.13.3

