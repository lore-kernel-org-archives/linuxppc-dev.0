Return-Path: <SRS0=eeko=PU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000AAC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 11:18:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D6E20657
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 11:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D6E20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43cHKH4x4YzDrB3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 22:18:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43cHHT4rXmzDr7G
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 22:16:37 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43cHHM3bBbz9vBK9;
 Sat, 12 Jan 2019 12:16:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id MB9UhAN4a18M; Sat, 12 Jan 2019 12:16:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43cHHM2yXyz9vBJm;
 Sat, 12 Jan 2019 12:16:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 56A418B77F;
 Sat, 12 Jan 2019 12:16:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id cM2U0KOIla5y; Sat, 12 Jan 2019 12:16:34 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2321F8B74C;
 Sat, 12 Jan 2019 12:16:34 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id D9D40717D8; Sat, 12 Jan 2019 11:16:33 +0000 (UTC)
Message-Id: <cover.1547289808.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 0/3] KASAN for powerpc/32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
Date: Sat, 12 Jan 2019 11:16:33 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This serie adds KASAN support to powerpc/32

Tested on nohash/32 (8xx) and book3s/32 (mpc832x ie 603)

Changes in v3:
- Removed the printk() in kasan_early_init() to avoid build failure (see https://github.com/linuxppc/issues/issues/218)
- Added necessary changes in asm/book3s/32/pgtable.h to get it work on powerpc 603 family
- Added a few KASAN_SANITIZE_xxx.o := n to successfully boot on powerpc 603 family

Changes in v2:
- Rebased.
- Using __set_pte_at() to build the early table.
- Worked around and got rid of the patch adding asm/page.h in asm/pgtable-types.h
    ==> might be fixed independently but not needed for this serie.

For book3s/32 (not 603), it cannot work as is because due to HASHPTE flag, we
can't use the same pagetable for several PGD entries.

Christophe Leroy (3):
  powerpc/mm: prepare kernel for KAsan on PPC32
  powerpc/32: Move early_init() in a separate file
  powerpc/32: Add KASAN support

 arch/powerpc/Kconfig                         |  1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +
 arch/powerpc/include/asm/kasan.h             | 24 ++++++++++
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +
 arch/powerpc/include/asm/ppc_asm.h           |  5 ++
 arch/powerpc/include/asm/setup.h             |  5 ++
 arch/powerpc/include/asm/string.h            | 14 ++++++
 arch/powerpc/kernel/Makefile                 |  6 ++-
 arch/powerpc/kernel/cputable.c               |  4 +-
 arch/powerpc/kernel/early_32.c               | 36 ++++++++++++++
 arch/powerpc/kernel/prom_init_check.sh       |  1 +
 arch/powerpc/kernel/setup-common.c           |  2 +
 arch/powerpc/kernel/setup_32.c               | 31 ++----------
 arch/powerpc/lib/Makefile                    |  3 ++
 arch/powerpc/lib/copy_32.S                   |  9 ++--
 arch/powerpc/mm/Makefile                     |  3 ++
 arch/powerpc/mm/dump_linuxpagetables.c       |  8 ++++
 arch/powerpc/mm/kasan_init.c                 | 72 ++++++++++++++++++++++++++++
 arch/powerpc/mm/mem.c                        |  4 ++
 19 files changed, 198 insertions(+), 34 deletions(-)
 create mode 100644 arch/powerpc/include/asm/kasan.h
 create mode 100644 arch/powerpc/kernel/early_32.c
 create mode 100644 arch/powerpc/mm/kasan_init.c

-- 
2.13.3

