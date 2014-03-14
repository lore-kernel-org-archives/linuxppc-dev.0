Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9DC782C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 11:01:13 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 00/10] powerpc/booke64: critical and mcheck support
Date: Thu, 13 Mar 2014 19:00:39 -0500
Message-ID: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tiejun Chen <tiejun.chen@windriver.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset adds the state saving required to safely take
critical and machine check exceptions on 64-bit booke, including
TLB misses from inside such exceptions.  Previously, the kernel simply
hung when encountering such an exception.

Scott Wood (8):
  powerpc/booke64: Fix exception numbers
  powerpc/e6500: Make TLB lock recursive
  powerpc/booke64: Use SPRG7 for VDSO
  powerpc/booke64: Use SPRG_TLB_EXFRAME on bolted handlers
  powerpc/booke64: Remove ints from EXCEPTION_COMMON
  powerpc/booke64: Add crit/mc/debug support to EXCEPTION_COMMON
  powerpc/booke64: Critical and machine check exception support
  Revert "powerpc/watchdog: Don't enable interrupt on PPC64 BookE"

Tiejun Chen (2):
  powerpc/book3e: initialize crit/mc/dbg kernel stack pointers
  powerpc/book3e: store crit/mc/dbg exception thread info

 arch/powerpc/include/asm/exception-64e.h    |  15 +-
 arch/powerpc/include/asm/kvm_booke_hv_asm.h |  17 +-
 arch/powerpc/include/asm/mmu-book3e.h       |   9 +-
 arch/powerpc/include/asm/paca.h             |   9 +-
 arch/powerpc/include/asm/reg.h              |  13 +-
 arch/powerpc/kernel/asm-offsets.c           |   2 +-
 arch/powerpc/kernel/exceptions-64e.S        | 435 +++++++++++++++++++++-------
 arch/powerpc/kernel/setup_64.c              |  20 +-
 arch/powerpc/kernel/vdso.c                  |   8 +-
 arch/powerpc/kernel/vdso32/getcpu.S         |   2 +-
 arch/powerpc/kernel/vdso64/getcpu.S         |   2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S     |   4 +-
 arch/powerpc/kvm/book3s_interrupts.S        |   4 +-
 arch/powerpc/kvm/bookehv_interrupts.S       |  24 +-
 arch/powerpc/mm/tlb_low_64e.S               |  63 ++--
 arch/powerpc/mm/tlb_nohash.c                |  11 +
 drivers/watchdog/booke_wdt.c                |   8 -
 17 files changed, 461 insertions(+), 185 deletions(-)

-- 
1.8.3.2
