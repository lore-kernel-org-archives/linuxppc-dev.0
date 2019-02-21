Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B67FC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 19:13:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126FF20836
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 19:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="tanko+J6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126FF20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4453yx0qwBzDqRh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 06:13:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="tanko+J6"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4453sj0rmXzDqRb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:08:41 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4453sd0j5hz9vCN3;
 Thu, 21 Feb 2019 20:08:37 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=tanko+J6; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id xggTZ6ssBRoY; Thu, 21 Feb 2019 20:08:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4453sc6dLGz9v0dl;
 Thu, 21 Feb 2019 20:08:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550776116; bh=B/XybEfiqzGEJL3gRyWOPCck3ZgQ37JUCYEidrkfae8=;
 h=From:Subject:To:Cc:Date:From;
 b=tanko+J6rXTp76rdDu/UyMtg2hJ37lgONKWiSnCUI8p7erB660UAyXfCFuKpPS7Fp
 Lp0zAEOIbty7xqUXKOAw7JxQyQqw5irFZ4OyNKWjVTq8PLTJZNNxooqK48hknsoijy
 nopihmR1Eg7WNvniiPEUGeZ3ewkc15X3Vrjdu/Ok=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EA4278B86A;
 Thu, 21 Feb 2019 20:08:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id MS8K1hHNTBPR; Thu, 21 Feb 2019 20:08:36 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AE8178B852;
 Thu, 21 Feb 2019 20:08:36 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 6681C6EF61; Thu, 21 Feb 2019 19:08:36 +0000 (UTC)
Message-Id: <cover.1550775950.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 00/16] powerpc/32: Use BATs/LTLBs for STRICT_KERNEL_RWX
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Thu, 21 Feb 2019 19:08:36 +0000 (UTC)
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

The purpose of this serie is to:
- use BATs with STRICT_KERNEL_RWX on book3s (See patch 13 for details.)
- use LTLBs with STRICT_KERNEL_RWX on 8xx (See patch 15 for a few details.)

v5:
- Changed var type from unsigned long to phys_addr_t in mapin_ram()
to fix build failure due to type mismatch in min() macro (patch 4).

v4:
- Fixed mapin_ram() to only map mem below total_lowmem (patch 4)
- Fixed sparse warning by making __mmu_mapin_ram static (patch 13)

v3:
- Reordered to avoid build failure due to setibat() not being used for several steps in the serie.
Now the patch using setibat() is next to the one adding setibat().
- Fixed mmu_mapin_ram() in patch 3 to return base in all cases, thanks Jonathan for the test
- Fixed build failure on 8xx when CONFIG_PERF_EVENTS is set due to too many instructions in Exception 0x1200
- Made 8M alignment for data the default on 8xx when STRICT_KERNEL_RWX is selected.
- Added patch 1 to not set additionnal bat on the wii when requesting nobats. The only purpose of this patch
is to be backported, as this function is removed later in the series.

v2:
- Fix patch 2 (was patch 3 in v1) based on feedback from Jonathan.
- Added support for 8xx with LTLBs.
- Added systematic population of pagetables for Abatron BDI.

Christophe Leroy (16):
  powerpc/wii: properly disable use of BATs when requested.
  powerpc/mm/32: add base address to mmu_mapin_ram()
  powerpc/mm/32s: rework mmu_mapin_ram()
  powerpc/mm/32s: use generic mmu_mapin_ram() for all blocks.
  powerpc/32: always populate page tables for Abatron BDI.
  powerpc/wii: remove wii_mmu_mapin_mem2()
  powerpc/mm/32s: use _PAGE_EXEC in setbat()
  powerpc/32: add helper to write into segment registers
  powerpc/mmu: add is_strict_kernel_rwx() helper
  powerpc/kconfig: define PAGE_SHIFT inside Kconfig
  powerpc/kconfig: define CONFIG_DATA_SHIFT and CONFIG_ETEXT_SHIFT
  powerpc/mm/32s: add setibat() clearibat() and update_bats()
  powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX
  powerpc/kconfig: make _etext and data areas alignment configurable on
    Book3s 32
  powerpc/8xx: don't disable large TLBs with CONFIG_STRICT_KERNEL_RWX
  powerpc/kconfig: make _etext and data areas alignment configurable on
    8xx

 arch/powerpc/Kconfig                          |  60 +++++++++
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |   2 +
 arch/powerpc/include/asm/book3s/32/pgtable.h  |  11 ++
 arch/powerpc/include/asm/mmu.h                |  11 ++
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h  |   3 +-
 arch/powerpc/include/asm/page.h               |  13 +-
 arch/powerpc/include/asm/reg.h                |   5 +
 arch/powerpc/kernel/head_32.S                 |  35 +++++
 arch/powerpc/kernel/head_8xx.S                |  54 ++++++--
 arch/powerpc/kernel/vmlinux.lds.S             |   9 +-
 arch/powerpc/mm/40x_mmu.c                     |   2 +-
 arch/powerpc/mm/44x_mmu.c                     |   2 +-
 arch/powerpc/mm/8xx_mmu.c                     |  33 ++++-
 arch/powerpc/mm/fsl_booke_mmu.c               |   2 +-
 arch/powerpc/mm/init_32.c                     |   6 +-
 arch/powerpc/mm/mmu_decl.h                    |  10 +-
 arch/powerpc/mm/pgtable_32.c                  |  42 +++---
 arch/powerpc/mm/ppc_mmu_32.c                  | 180 ++++++++++++++++++++++----
 arch/powerpc/platforms/embedded6xx/wii.c      |  24 ----
 19 files changed, 393 insertions(+), 111 deletions(-)

-- 
2.13.3

