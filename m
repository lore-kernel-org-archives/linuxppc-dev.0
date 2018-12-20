Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E09C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 06:44:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EEE2176F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 06:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EEE2176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L2LK5gsSzDr31
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 17:44:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L2Fh264xzDqnZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 17:40:40 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43L2FZ0hSNz9vBLV;
 Thu, 20 Dec 2018 07:40:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id sEVh946JcXzW; Thu, 20 Dec 2018 07:40:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43L2FZ09jgz9vBJf;
 Thu, 20 Dec 2018 07:40:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D610E8B796;
 Thu, 20 Dec 2018 07:40:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QpDKGWTlCJ3l; Thu, 20 Dec 2018 07:40:34 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A6ABE8B755;
 Thu, 20 Dec 2018 07:40:34 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 6735371733; Thu, 20 Dec 2018 06:40:34 +0000 (UTC)
Message-Id: <cover.1545287470.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 0/3] KASAN for nohash PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 npiggin@gmail.com, aneesh.kumar@linux.ibm.com
Date: Thu, 20 Dec 2018 06:40:34 +0000 (UTC)
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

This serie adds KASAN support to nohash PPC32

Tested on 8xx

Changes in v2:
- Rebased.
- Using __set_pte_at() to build the early table.
- Worked around and got rid of the patch adding asm/page.h in asm/pgtable-types.h
    ==> might be fixed independently but needed for this serie.

In principle, this should also work on the 603. For now I have not been
able to boot, it stops before early console is active, so I'm quite blind at the
moment and don't really know what's wrong. Any idea ?

For hash32 (not 603), it cannot work as is because due to HASHPTE flag, we
can't use the same pagetable for several PGD entries.

Christophe Leroy (3):
  powerpc/mm: prepare kernel for KAsan on PPC32
  powerpc/32: Move early_init() in a separate file
  powerpc/nohash32: Add KASAN support

 arch/powerpc/Kconfig                         |  1 +
 arch/powerpc/include/asm/kasan.h             | 22 +++++++++
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +
 arch/powerpc/include/asm/ppc_asm.h           |  5 ++
 arch/powerpc/include/asm/setup.h             |  5 ++
 arch/powerpc/include/asm/string.h            | 14 ++++++
 arch/powerpc/kernel/Makefile                 |  5 +-
 arch/powerpc/kernel/cputable.c               |  4 +-
 arch/powerpc/kernel/early_32.c               | 35 +++++++++++++
 arch/powerpc/kernel/setup-common.c           |  2 +
 arch/powerpc/kernel/setup_32.c               | 31 ++----------
 arch/powerpc/lib/Makefile                    |  2 +
 arch/powerpc/lib/copy_32.S                   |  9 ++--
 arch/powerpc/mm/Makefile                     |  3 ++
 arch/powerpc/mm/dump_linuxpagetables.c       |  8 +++
 arch/powerpc/mm/kasan_init.c                 | 73 ++++++++++++++++++++++++++++
 arch/powerpc/mm/mem.c                        |  4 ++
 17 files changed, 191 insertions(+), 34 deletions(-)
 create mode 100644 arch/powerpc/include/asm/kasan.h
 create mode 100644 arch/powerpc/kernel/early_32.c
 create mode 100644 arch/powerpc/mm/kasan_init.c

-- 
2.13.3

