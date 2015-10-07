Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 010181A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:48:35 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, Michael Ellerman
 <mpe@ellerman.id.au>, <kexec@lists.infradead.org>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH v2 00/18] powerpc/fsl-book3e-64: kexec/kdump support
Date: Tue, 6 Oct 2015 22:48:04 -0500
Message-ID: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset adds support for kexec and kdump to e5500 and e6500 based
systems running 64-bit kernels.  It depends on the kexec-tools patch
http://patchwork.ozlabs.org/patch/527050/ ("ppc64: Add a flag to tell the
kernel it's booting from kexec").

Scott Wood (12):
  powerpc/fsl-booke-64: Allow booting from the secondary thread
  powerpc/fsl-corenet: Disable coreint if kexec is enabled
  powerpc/85xx: Don't use generic timebase sync on 64-bit
  powerpc/fsl_pci: Don't set up inbound windows in kdump crash kernel
  powerpc/85xx: Load all early TLB entries at once
  powerpc/fsl-booke-64: Don't limit ppc64_rma_size to one TLB entry
  powerpc/e6500: kexec: Handle hardware threads
  powerpc/book3e/kdump: Enable crash_kexec_wait_realmode
  powerpc/book3e-64: Don't limit paca to 256 MiB
  powerpc/book3e-64/kexec: Enable SMP release
  powerpc/booke: Only use VIRT_PHYS_OFFSET on booke32
  powerpc/book3e-64/kexec: Set "r4 = 0" when entering spinloop

Tiejun Chen (6):
  powerpc/85xx: Implement 64-bit kexec support
  powerpc/book3e-64: rename interrupt_end_book3e with __end_interrupts
  powerpc/booke64: Fix args to copy_and_flush
  powerpc/book3e: support CONFIG_RELOCATABLE
  powerpc/book3e-64/kexec: create an identity TLB mapping
  powerpc/book3e-64: Enable kexec

 Documentation/devicetree/bindings/chosen.txt  |  8 +++
 arch/powerpc/Kconfig                          |  2 +-
 arch/powerpc/include/asm/exception-64e.h      |  4 +-
 arch/powerpc/include/asm/page.h               |  7 ++-
 arch/powerpc/kernel/crash.c                   |  6 +-
 arch/powerpc/kernel/exceptions-64e.S          | 17 ++++--
 arch/powerpc/kernel/head_64.S                 | 43 ++++++++++++--
 arch/powerpc/kernel/machine_kexec_64.c        | 18 ++++++
 arch/powerpc/kernel/misc_64.S                 | 60 ++++++++++++++++++-
 arch/powerpc/kernel/paca.c                    |  6 +-
 arch/powerpc/kernel/setup_64.c                | 25 +++++++-
 arch/powerpc/mm/fsl_booke_mmu.c               | 35 ++++++++---
 arch/powerpc/mm/mmu_decl.h                    |  4 +-
 arch/powerpc/mm/tlb_nohash.c                  | 41 ++++++++++---
 arch/powerpc/mm/tlb_nohash_low.S              | 63 ++++++++++++++++++++
 arch/powerpc/platforms/85xx/corenet_generic.c |  4 ++
 arch/powerpc/platforms/85xx/smp.c             | 86 ++++++++++++++++++++++++---
 arch/powerpc/sysdev/fsl_pci.c                 | 84 +++++++++++++++++++-------
 18 files changed, 443 insertions(+), 70 deletions(-)

-- 
2.1.4
