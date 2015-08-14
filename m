Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D47F41A1D37
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 17:44:07 +1000 (AEST)
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A0C541401DE
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 17:44:06 +1000 (AEST)
Received: by pabyb7 with SMTP id yb7so54699044pab.0
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:44:03 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v5 00/11] CXL EEH Handling
Date: Fri, 14 Aug 2015 17:41:16 +1000
Message-Id: <1439538087-32137-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CXL accelerators are unfortunately not immune from failure. This patch
set enables them to particpate in the Extended Error Handling process.

This series starts with a number of preparatory patches:

 - Patch 1 is cleanup: converting macros to static inlines.

 - Patch 2 makes sure we don't touch the hardware when it has failed.
 
 - Patches 3-5 make the 'unplug' functions idempotent, so that if we
   get part way through recovery and then fail, being completely
   unplugged as part of removal doesn't cause us to oops out.

 - Patches 6 and 7 refactor init and teardown paths for the adapter
   and AFUs, so that they can be configured and deconfigured
   separately from their allocation and release.

 - Patch 8 stops cxl_reset from breaking EEH.

Patches 9 and 10 are parts of EEH.

 - Firstly we have a kernel flag that allows us to confidently assert
   the hardware will not change (be reflashed) when it it reset. We
   need this in order to be able to safely do EEH recovery.

 - We then have the EEH support itself.

Finally, we add a CONFIG_CXL_EEH symbol. This allows drivers to depend
on the API we provide to enable CXL EEH, or to be easily backportable
if EEH is optional.

Changes from v4 are trivial:
 - Undo the rc/if split - this will be redone in a follow-up patch.
 - Rebase on top of mpe's next tree so as to solve some merge
   conflicts.

Changes from v3 are minor:
 - Clarification of responsibility of CXL driver vs driver bound to
   vPHB with regards to preventing inappropriate access of hardware
   during recovery.
 - Clean up unused rc in cxl_alloc_adapter, thanks David Laight.
 - Break setting rc and testing rc into different lines, thanks mpe
   and Cyril.
 - If we fail to init an AFU, don't try to select the best mode.

Changes from v2 are mostly minor cleanups, reflecting some review and
further testing.
 - Use static inlines instead of macros.
 - Propagate PCI link state to devices on the vPHB.
 - Various cleanup, thanks Cyril Bur.
 - Use pci_channel_offline instead of a direct check.
 - Don't ifdef, just provide the symbol so that drivers know that the
   new API is available. Thanks to Cyril for patiently explaining this
   to me about 3 times before I understood.

Changes from v1:
 - More comprehensive link down checks, including vPHB.
 - Rebased to apply cleanly to 4.2-rc4.
 - cxl reset changes.
 - CONFIG_CXL_EEH symbol addition.
 - add better vPHB support to EEH.

Daniel Axtens (11):
  cxl: Convert MMIO read/write macros to inline functions
  cxl: Drop commands if the PCI channel is not in normal state
  cxl: Allocate and release the SPA with the AFU
  cxl: Make IRQ release idempotent
  cxl: Clean up adapter MMIO unmap path.
  cxl: Refactor adaptor init/teardown
  cxl: Refactor AFU init/teardown
  cxl: Don't remove AFUs/vPHBs in cxl_reset
  cxl: Allow the kernel to trust that an image won't change on PERST.
  cxl: EEH support
  cxl: Add CONFIG_CXL_EEH symbol

 Documentation/ABI/testing/sysfs-class-cxl |  10 +
 drivers/misc/cxl/Kconfig                  |   6 +
 drivers/misc/cxl/api.c                    |   7 +
 drivers/misc/cxl/context.c                |   6 +-
 drivers/misc/cxl/cxl.h                    |  84 ++++-
 drivers/misc/cxl/file.c                   |  19 ++
 drivers/misc/cxl/irq.c                    |   9 +
 drivers/misc/cxl/native.c                 | 105 +++++-
 drivers/misc/cxl/pci.c                    | 525 ++++++++++++++++++++++++------
 drivers/misc/cxl/sysfs.c                  |  26 ++
 drivers/misc/cxl/vphb.c                   |  34 ++
 include/misc/cxl.h                        |  10 +
 12 files changed, 708 insertions(+), 133 deletions(-)

-- 
2.1.4
