Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC24DC43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:40:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800B22081C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pExlI/QS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800B22081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qfxC1crNzDqZB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 00:40:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="pExlI/QS"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qfhZ51PzzDqZT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 00:29:32 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44qfhP5GCMz9v06X;
 Thu, 25 Apr 2019 16:29:25 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=pExlI/QS; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id V_UJf2bk2lNM; Thu, 25 Apr 2019 16:29:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44qfhP3ppvz9v06V;
 Thu, 25 Apr 2019 16:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556202565; bh=ZAk5oInFteIZFLfsYCErnhXj4xJ5HcEpKVF+oTA5mHo=;
 h=From:Subject:To:Cc:Date:From;
 b=pExlI/QSxTsT5a/b0I+Iga4XMKht5bLQs2e5x9FFnamAj2c/FCkoZpkhFGfCbf2fJ
 RkFqNMLBSlYe2lYx/FxzJtDZkc9ANmikQL6cE7nh4UcY0ZiCNPJhlNiHNqJqBJiZ+f
 Ykwn2pYBCpFK6bl/LyTi8UUf+SGzlShAxrvXN9dU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A4518B931;
 Thu, 25 Apr 2019 16:29:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id vHbBjXE-_eMi; Thu, 25 Apr 2019 16:29:27 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E835A8B923;
 Thu, 25 Apr 2019 16:29:26 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 89E4266276; Thu, 25 Apr 2019 14:29:26 +0000 (UTC)
Message-Id: <cover.1556202028.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 00/11] Reduce ifdef mess in slice.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Thu, 25 Apr 2019 14:29:26 +0000 (UTC)
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

This series is a split out of the v1 series "Reduce ifdef mess in hugetlbpage.c and slice.c".

It is also rebased after the series from Aneesh to reduce context size for Radix.

See http://kisskb.ellerman.id.au/kisskb/branch/chleroy/head/f263887b4ca31f4bb0fe77823e301c28ba27c796/ for wide compilation.

Christophe Leroy (11):
  powerpc/mm: fix erroneous duplicate slb_addr_limit init
  powerpc/mm: no slice for nohash/64
  powerpc/mm: hand a context_t over to slice_mask_for_size() instead of
    mm_struct
  powerpc/mm: move slice_mask_for_size() into mmu.h
  powerpc/mm: get rid of mm_ctx_slice_mask_xxx()
  powerpc/mm: remove unnecessary #ifdef CONFIG_PPC64
  powerpc/mm: remove a couple of #ifdef CONFIG_PPC_64K_PAGES in
    mm/slice.c
  powerpc/8xx: get rid of #ifdef CONFIG_HUGETLB_PAGE for slices
  powerpc/mm: define get_slice_psize() all the time
  powerpc/mm: define subarch SLB_ADDR_LIMIT_DEFAULT
  powerpc/mm: drop slice DEBUG

 arch/powerpc/include/asm/book3s/64/mmu.h     |  29 +++---
 arch/powerpc/include/asm/book3s/64/slice.h   |   2 +
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  51 +++++------
 arch/powerpc/include/asm/nohash/32/slice.h   |   2 +
 arch/powerpc/include/asm/nohash/64/slice.h   |  12 ---
 arch/powerpc/include/asm/slice.h             |   9 +-
 arch/powerpc/kernel/setup-common.c           |   6 --
 arch/powerpc/mm/hash_utils_64.c              |   2 +-
 arch/powerpc/mm/hugetlbpage.c                |   4 +-
 arch/powerpc/mm/slice.c                      | 132 ++++-----------------------
 arch/powerpc/mm/tlb_nohash.c                 |   4 +-
 arch/powerpc/platforms/Kconfig.cputype       |   4 +
 12 files changed, 69 insertions(+), 188 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/nohash/64/slice.h

-- 
2.13.3

