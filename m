Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C31C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:03:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BC72082F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BC72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435RkD1P9HzDqgk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 06:03:16 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 435Rfl3m4dzDrFD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 06:00:15 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 435Rfg660tz9vGFM;
 Thu, 29 Nov 2018 20:00:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ORYJSePtUn2O; Thu, 29 Nov 2018 20:00:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 435Rfg5Z5Fz9vGDx;
 Thu, 29 Nov 2018 20:00:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9387D8B8DA;
 Thu, 29 Nov 2018 20:00:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id TCMEa3rbyeXJ; Thu, 29 Nov 2018 20:00:11 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B21F38B8D3;
 Thu, 29 Nov 2018 20:00:10 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 6CCB169B39; Thu, 29 Nov 2018 19:00:10 +0000 (UTC)
Message-Id: <cover.1543517818.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 00/13] powerpc/32s: Use BATs for STRICT_KERNEL_RWX
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Thu, 29 Nov 2018 19:00:10 +0000 (UTC)
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

The purpose of this serie is to use BATs with STRICT_KERNEL_RWX
See patch 12 for details.

Christophe Leroy (13):
  powerpc/mm: add exec protection on powerpc 603
  powerpc/mm/32: add base address to mmu_mapin_ram()
  powerpc/mm/32s: rework mmu_mapin_ram()
  powerpc/mm/32s: use generic mmu_mapin_ram() for all blocks.
  powerpc/wii: remove wii_mmu_mapin_mem2()
  powerpc/mm/32s: use _PAGE_EXEC in setbat()
  powerpc/mm/32s: add setibat() clearibat() and update_bats()
  powerpc/32: add helper to write into segment registers
  powerpc/mmu: add is_strict_kernel_rwx() helper
  powerpc/kconfig: define PAGE_SHIFT inside Kconfig
  powerpc/kconfig: define CONFIG_DATA_SHIFT and CONFIG_ETEXT_SHIFT
  powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX
  powerpc/kconfig: make _etext and data areas alignment configurable on
    Book3s 32

 arch/powerpc/Kconfig                           |  46 +++++++
 arch/powerpc/include/asm/book3s/32/hash.h      |   1 +
 arch/powerpc/include/asm/book3s/32/mmu-hash.h  |   2 +
 arch/powerpc/include/asm/book3s/32/pgtable.h   |  29 ++--
 arch/powerpc/include/asm/cputable.h            |   8 +-
 arch/powerpc/include/asm/mmu.h                 |  11 ++
 arch/powerpc/include/asm/page.h                |  13 +-
 arch/powerpc/include/asm/reg.h                 |   5 +
 arch/powerpc/kernel/head_32.S                  |  37 ++++-
 arch/powerpc/kernel/vmlinux.lds.S              |   9 +-
 arch/powerpc/mm/40x_mmu.c                      |   2 +-
 arch/powerpc/mm/44x_mmu.c                      |   2 +-
 arch/powerpc/mm/8xx_mmu.c                      |   2 +-
 arch/powerpc/mm/dump_linuxpagetables-generic.c |   2 -
 arch/powerpc/mm/fsl_booke_mmu.c                |   2 +-
 arch/powerpc/mm/init_32.c                      |   6 +-
 arch/powerpc/mm/mmu_decl.h                     |  10 +-
 arch/powerpc/mm/pgtable.c                      |  20 +--
 arch/powerpc/mm/pgtable_32.c                   |  35 +++--
 arch/powerpc/mm/ppc_mmu_32.c                   | 178 +++++++++++++++++++++----
 arch/powerpc/platforms/embedded6xx/wii.c       |  24 ----
 21 files changed, 324 insertions(+), 120 deletions(-)

-- 
2.13.3

