Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D558C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 15:07:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B054F213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 15:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B054F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V0w566DMzF3N3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 02:07:49 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TzD83GyczF110
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:51:35 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42TzCr5mtHz9ttSf;
 Tue,  9 Oct 2018 15:51:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id M-VgruSCwP0F; Tue,  9 Oct 2018 15:51:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42TzCr59BMz9ttRm;
 Tue,  9 Oct 2018 15:51:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 58A868B80B;
 Tue,  9 Oct 2018 15:51:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ZGIyHmey_uoR; Tue,  9 Oct 2018 15:51:32 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 159C98B80A;
 Tue,  9 Oct 2018 15:51:32 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id DAC6D6F444; Tue,  9 Oct 2018 13:51:31 +0000 (UTC)
Message-Id: <cover.1539092111.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 00/24] ban the use of _PAGE_XXX flags outside platform
 specific code
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 aneesh.kumar@linux.vnet.ibm.com
Date: Tue,  9 Oct 2018 13:51:31 +0000 (UTC)
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
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Today flags like for instance _PAGE_RW or _PAGE_USER are used through
common parts of code.
Using those directly in common parts of code have proven to lead to
mistakes or misbehaviour, because their use is not always as trivial
as one could think.

For instance, (flags & _PAGE_USER) == 0 isn't enough to tell
that a page is a kernel page, because some targets are using
_PAGE_PRIVILEDGED and not _PAGE_USER, so the test has to be 
(flags & (_PAGE_USER | _PAGE_PRIVILEDGED)) == _PAGE_PRIVILEDGED
This has too (bad) consequences:

 - All targets must define every bit, even the unsupported ones,
   leading to a lot of useless #define _PAGE_XXX 0
 - If someone forgets to take into account all possible _PAGE_XXX bits
   for the case, we can get unexpected behaviour on some targets.

This becomes even more complex when we come to using _PAGE_RW.
Testing (flags & _PAGE_RW) is not enough to test whether a page
if writable or not, because:

 - Some targets have _PAGE_RO instead, which has to be unset to tell
   a page is writable
 - Some targets have _PAGE_R and _PAGE_W, in which case
   _PAGE_RW = _PAGE_R | _PAGE_W
 - Even knowing whether a page is readable is not always trivial because:
   - Some targets requires to check that _PAGE_R is set to ensure page
   is readable
   - Some targets requires to check that _PAGE_NA is not set
   - Some targets requires to check that _PAGE_RO or _PAGE_RW is set

Etc ....

In order to work around all those issues and minimise the risks of errors,
this serie aims at removing all use of _PAGE_XXX flags from powerpc code
and always use pte_xxx() and pte_mkxxx() accessors instead. Those accessors
are then defined in platform specific parts of the kernel code.

Compared to the RFC, v2 adds three things:
- A work on ioremap() alike functions: properly set the base flags
  by all callers and removed the hack which sets the base flags when
  the caller don't give them.
- _PAGE_EXEC flag is replaced by a bool in the call to hash_preload()
- Optimisation of pte_mkXXX() helpers on book3s64 to avoid multiple
endian conversions.

v2:
 - Takes into account comments received on the RFC.
 - compilation test result: http://kisskb.ellerman.id.au/kisskb/head/51b7f5d55900688c7c07cdb945d34b3314befa36/

v3:
 - rebased on lastest 'merge' powerpc branch
 - added a new helper pte_hw_valid() and using it in set_pte_at(), see discussion at https://patchwork.ozlabs.org/patch/972630/
 - compilation result: http://kisskb.ellerman.id.au/kisskb/head/914a399c8f1434f3c52013e625fb1665571033ef/

Christophe Leroy (24):
  powerpc/32: Add ioremap_wt() and ioremap_coherent()
  drivers/video/fbdev: use ioremap_wc/wt() instead of __ioremap()
  drivers/block/z2ram: use ioremap_wt() instead of
    __ioremap(_PAGE_WRITETHRU)
  soc/fsl/qbman: use ioremap_cache() instead of ioremap_prot(0)
  powerpc: don't use ioremap_prot() nor __ioremap() unless really
    needed.
  powerpc/mm: properly set PAGE_KERNEL flags in ioremap()
  powerpc: handover page flags with a pgprot_t parameter
  powerpc/mm: don't use _PAGE_EXEC in book3s/32
  powerpc/mm: move some nohash pte helpers in nohash/[32:64]/pgtable.h
  powerpc/mm: add pte helpers to query and change pte flags
  powerpc/mm: don't use _PAGE_EXEC for calling hash_preload()
  powerpc/mm: use pte helpers in generic code
  powerpc/mm: Split dump_pagelinuxtables flag_array table
  powerpc/mm: drop unused page flags
  powerpc/mm: move __P and __S tables in the common pgtable.h
  powerpc/book3s/32: do not include pte-common.h
  powerpc/mm: Move pte_user() into nohash/pgtable.h
  powerpc/mm: Distribute platform specific PAGE and PMD flags and
    definitions
  powerpc/nohash/64: do not include pte-common.h
  powerpc/mm: Allow platforms to redefine some helpers
  powerpc/mm: Define platform default caches related flags
  powerpc/mm: Get rid of pte-common.h
  powerpc/8xx: change name of a few page flags to avoid confusion
  powerpc/book3s64: Avoid multiple endian conversion in pte helpers

 arch/powerpc/include/asm/book3s/32/pgtable.h       | 151 ++++++++++++--
 arch/powerpc/include/asm/book3s/64/hash.h          |   3 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       | 133 +++++++------
 arch/powerpc/include/asm/fixmap.h                  |   2 +-
 arch/powerpc/include/asm/io.h                      |  13 +-
 arch/powerpc/include/asm/machdep.h                 |   2 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |  66 ++++++-
 arch/powerpc/include/asm/nohash/32/pte-40x.h       |  48 +++++
 arch/powerpc/include/asm/nohash/32/pte-44x.h       |  35 ++++
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |  92 ++++++++-
 arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h |  38 ++++
 arch/powerpc/include/asm/nohash/64/pgtable.h       |  40 +++-
 arch/powerpc/include/asm/nohash/pgtable.h          |  98 ++++++---
 arch/powerpc/include/asm/nohash/pte-book3e.h       |  30 +++
 arch/powerpc/include/asm/pgtable.h                 |  19 ++
 arch/powerpc/include/asm/pte-common.h              | 219 ---------------------
 arch/powerpc/kernel/btext.c                        |   2 +-
 arch/powerpc/kernel/crash_dump.c                   |   2 +-
 arch/powerpc/kernel/head_8xx.S                     |   6 +-
 arch/powerpc/kernel/io-workarounds.c               |   4 +-
 arch/powerpc/kernel/isa-bridge.c                   |   6 +-
 arch/powerpc/kernel/pci_64.c                       |   2 +-
 arch/powerpc/lib/code-patching.c                   |   3 +-
 arch/powerpc/mm/8xx_mmu.c                          |   5 +-
 arch/powerpc/mm/Makefile                           |   7 +
 arch/powerpc/mm/dma-noncoherent.c                  |   2 +-
 arch/powerpc/mm/dump_linuxpagetables-8xx.c         |  82 ++++++++
 arch/powerpc/mm/dump_linuxpagetables-book3s64.c    | 115 +++++++++++
 arch/powerpc/mm/dump_linuxpagetables-generic.c     |  82 ++++++++
 arch/powerpc/mm/dump_linuxpagetables.c             | 155 +--------------
 arch/powerpc/mm/dump_linuxpagetables.h             |  19 ++
 arch/powerpc/mm/hash_utils_64.c                    |   3 +-
 arch/powerpc/mm/mem.c                              |  13 +-
 arch/powerpc/mm/mmu_decl.h                         |   2 +-
 arch/powerpc/mm/pgtable-book3e.c                   |   9 +-
 arch/powerpc/mm/pgtable-hash64.c                   |   7 +-
 arch/powerpc/mm/pgtable.c                          |  27 +--
 arch/powerpc/mm/pgtable_32.c                       |  70 ++++---
 arch/powerpc/mm/pgtable_64.c                       |  55 +++---
 arch/powerpc/mm/ppc_mmu_32.c                       |   2 +-
 arch/powerpc/platforms/4xx/ocm.c                   |   7 +-
 arch/powerpc/platforms/85xx/smp.c                  |   4 +-
 arch/powerpc/platforms/pasemi/dma_lib.c            |   2 +-
 arch/powerpc/platforms/ps3/spu.c                   |   3 +-
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c          |   8 +-
 arch/powerpc/xmon/xmon.c                           |  12 +-
 drivers/block/z2ram.c                              |   3 +-
 drivers/pcmcia/electra_cf.c                        |   2 +-
 drivers/soc/fsl/qbman/qman_ccsr.c                  |   2 +-
 drivers/video/fbdev/chipsfb.c                      |   3 +-
 drivers/video/fbdev/controlfb.c                    |   5 +-
 drivers/video/fbdev/platinumfb.c                   |   5 +-
 drivers/video/fbdev/valkyriefb.c                   |  12 +-
 53 files changed, 1094 insertions(+), 643 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/pte-common.h
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-8xx.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-book3s64.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-generic.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables.h

-- 
2.13.3

