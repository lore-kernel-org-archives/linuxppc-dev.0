Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF48C43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:03:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDA82077B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TMVBPPzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDA82077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rJkg0v6HzDqBy
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 02:03:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="TMVBPPzj"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rJcF18D8zDqQV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 01:58:03 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44rJc53SbZz9v0yN;
 Fri, 26 Apr 2019 17:57:57 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=TMVBPPzj; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id JDtwAN5XxmpI; Fri, 26 Apr 2019 17:57:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44rJc52P1Gz9v0yM;
 Fri, 26 Apr 2019 17:57:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556294277; bh=1+acrHFJLr9UrRjdl8XyLYhyxj6dEcynOoW4q8cZozM=;
 h=From:Subject:To:Cc:Date:From;
 b=TMVBPPzjmehsmCf/jqqhT66Y/Je04iwlu3YCvHHpUrpPovp1HiOxru8Maz/QSaFHN
 tGHUnXqoI71gRDt2ZRBEJXh7nzgNpdorKhUGdD5xki341r8sSyXWCJXQFT3cAhQG70
 v4BVt3MANoOseKrEFgQeY3btf3kbFWJiloboVa00=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DCA4B8B94A;
 Fri, 26 Apr 2019 17:57:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id W7R2WclulTzX; Fri, 26 Apr 2019 17:57:58 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AF1A88B82F;
 Fri, 26 Apr 2019 17:57:58 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 75EC6666FE; Fri, 26 Apr 2019 15:57:58 +0000 (UTC)
Message-Id: <cover.1556293738.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 00/15] Refactor pgalloc stuff
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Fri, 26 Apr 2019 15:57:58 +0000 (UTC)
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

This series converts book3e64 to pte_fragment and refactor
things that are common among subarches.

Changes in v2:
- Rebased on latest merge branch (b251649c77625b7ad4430e518dc0f1608be9edf4)
- Resolved conflicts, especially due to the addition of MAX_PHYSMEM_BITS in
asm/nohash/64/mmu.h ==> moved it to asm/nohash/mmu-book3e.h
- compilation test at http://kisskb.ellerman.id.au/kisskb/head/cf0b6c1ff5ca934bbe02f88b1b1ba533b386225e/

Christophe Leroy (15):
  powerpc/mm: drop __bad_pte()
  powerpc/mm: define __pud_free_tlb() at all time on nohash/64
  powerpc/mm: convert Book3E 64 to pte_fragment
  powerpc/mm: move pgtable_t in asm/mmu.h
  powerpc/mm: get rid of nohash/32/mmu.h and nohash/64/mmu.h
  powerpc/Kconfig: select PPC_MM_SLICES from subarch type
  powerpc/book3e: move early_alloc_pgtable() to init section
  powerpc/mm: don't use pte_alloc_kernel() until slab is available on
    PPC32
  powerpc/mm: inline pte_alloc_one_kernel() and pte_alloc_one() on PPC32
  powerpc/mm: refactor pte_alloc_one() and pte_free() families
    definition.
  powerpc/mm: refactor definition of pgtable_cache[]
  powerpc/mm: Only keep one version of pmd_populate() functions on
    nohash/32
  powerpc/mm: refactor pgtable freeing functions on nohash
  powerpc/mm: refactor pmd_pgtable()
  powerpc/mm: refactor pgd_alloc() and pgd_free() on nohash

 arch/powerpc/include/asm/book3s/32/mmu-hash.h |   4 -
 arch/powerpc/include/asm/book3s/32/pgalloc.h  |  41 ---------
 arch/powerpc/include/asm/book3s/64/mmu.h      |   8 --
 arch/powerpc/include/asm/book3s/64/pgalloc.h  |  49 ----------
 arch/powerpc/include/asm/mmu.h                |   3 +
 arch/powerpc/include/asm/mmu_context.h        |   6 --
 arch/powerpc/include/asm/nohash/32/mmu.h      |  25 ------
 arch/powerpc/include/asm/nohash/32/pgalloc.h  | 123 ++------------------------
 arch/powerpc/include/asm/nohash/64/mmu.h      |  14 ---
 arch/powerpc/include/asm/nohash/64/pgalloc.h  | 117 +-----------------------
 arch/powerpc/include/asm/nohash/mmu-book3e.h  |   2 +
 arch/powerpc/include/asm/nohash/mmu.h         |  16 +++-
 arch/powerpc/include/asm/nohash/pgalloc.h     |  56 ++++++++++++
 arch/powerpc/include/asm/pgalloc.h            |  51 +++++++++++
 arch/powerpc/mm/Makefile                      |   4 +-
 arch/powerpc/mm/mmu_context.c                 |   2 +-
 arch/powerpc/mm/pgtable-book3e.c              |   4 +-
 arch/powerpc/mm/pgtable_32.c                  |  42 +++++----
 arch/powerpc/platforms/Kconfig.cputype        |   4 +-
 19 files changed, 167 insertions(+), 404 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/nohash/32/mmu.h
 delete mode 100644 arch/powerpc/include/asm/nohash/64/mmu.h

-- 
2.13.3

