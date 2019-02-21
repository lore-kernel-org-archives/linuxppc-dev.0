Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D166BC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:40:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DF42077B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="N1Wp1qaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DF42077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444rbT5FC8zDqPP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 21:40:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="N1Wp1qaL"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444rXN3YlnzDqNN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 21:37:56 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 444rXH5kvYz9tylR;
 Thu, 21 Feb 2019 11:37:51 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=N1Wp1qaL; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 38srmDrSOebu; Thu, 21 Feb 2019 11:37:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 444rXH4Yr8z9tylQ;
 Thu, 21 Feb 2019 11:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550745471; bh=gF6qyxoFEoDrWjO1hnj5M32V1KmsTcaENyZvWxSjtLg=;
 h=From:Subject:To:Cc:Date:From;
 b=N1Wp1qaLCpBHqcbLqid9ZtOiJC6t3n8EM0U0dVl7Bob3KXX4ZHBXvx9NoIqtlOzxv
 7QsOnpVyRlCnvPmj69oQADqXvnPajXNAR4rVa3AQhqJUQg+YWT2xI1I0hqc+BIRLFc
 U+m3DO/W3LDGQmpnEf1Qa32+ik6ErA/Ww0mN35Bo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C9B608B852;
 Thu, 21 Feb 2019 11:37:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id dEar_SrDm5n9; Thu, 21 Feb 2019 11:37:52 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 987A48B859;
 Thu, 21 Feb 2019 11:37:52 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 54A216E856; Thu, 21 Feb 2019 10:37:52 +0000 (UTC)
Message-Id: <cover.1550745320.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 00/10] Optimise TLB miss handlers on 6xx (603/e300)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 21 Feb 2019 10:37:52 +0000 (UTC)
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

The main purpose of this series is to optimise the handling of
TLB misses on the 603/e300.

Today the TLB miss handlers are implemented by more or less
copying the actions performed by the hash page handlers used
on processors having HASH pagetable.

This series brings some simplification.

It also improves TLB misses on all 6xx by storing the PGDIR phys address
in an SPRG instead of reading it from thread struct.

v2:
- Added a patch which frees SPRN_SPRG2 by saving RTAS entry stack pointer in
the thread struct, allowing to use it for storing the PGDIR for all 6xx.
- Now using SPRN_SPRG2 for storing the PGDIR instead of SPRN_SPRG5. This allows
the old 6xx having only 4 SPRGs to also get the benefit of this change.
- Removed the last patch of the series which was reordering the _PAGE_FLAGS bits
because it fails on hash 6xx. Will be re-added later once fixed.

Christophe Leroy (10):
  powerpc: simplify BDI switch
  powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while in
    RTAS
  powerpc/6xx: Store PGDIR physical address in a SPRG
  powerpc/603: use physical address directly in TLB miss handlers.
  powerpc/hash32: use physical address directly in hash handlers.
  powerpc/603: Don't handle kernel page TLB misses when not need
  powerpc/603: Don't handle _PAGE_RW and _PAGE_DIRTY on ITLB misses
  powerpc/603: let's handle PAGE_DIRTY directly
  powerpc/603: Don't worry about _PAGE_USER in TLB miss handlers
  powerpc/603: don't handle PAGE_ACCESSED in TLB miss handlers.

 arch/powerpc/include/asm/mmu.h       |   2 +
 arch/powerpc/include/asm/processor.h |   3 +
 arch/powerpc/include/asm/reg.h       |   2 +-
 arch/powerpc/kernel/asm-offsets.c    |   3 +
 arch/powerpc/kernel/cpu_setup_6xx.S  |   4 ++
 arch/powerpc/kernel/entry_32.S       |   5 +-
 arch/powerpc/kernel/head_32.S        | 111 ++++++++++++++++-------------------
 arch/powerpc/kernel/head_40x.S       |   5 +-
 arch/powerpc/kernel/head_8xx.S       |   1 +
 arch/powerpc/mm/8xx_mmu.c            |   7 +--
 arch/powerpc/mm/hash_low_32.S        |  65 +++++++++-----------
 arch/powerpc/mm/ppc_mmu_32.c         |   6 +-
 12 files changed, 104 insertions(+), 110 deletions(-)

-- 
2.13.3

