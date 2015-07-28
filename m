Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 827501A06A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 15:31:06 +1000 (AEST)
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2EBBF1402D9
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 15:31:04 +1000 (AEST)
Received: by pdrg1 with SMTP id g1so64401596pdr.2
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 22:31:03 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 00/10] CXL EEH Handling
Date: Tue, 28 Jul 2015 15:28:33 +1000
Message-Id: <1438061323-20710-1-git-send-email-dja@axtens.net>
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

 - Patch 1 makes sure we don't touch the hardware when it has failed.
 
 - Patches 2-4 make the 'unplug' functions idempotent, so that if we
   get part way through recovery and then fail, being completely
   unplugged as part of removal doesn't cause us to oops out.

 - Patches 5 and 6 refactor init and teardown paths for the adapter
   and AFUs, so that they can be configured and deconfigured
   separately from their allocation and release.

 - Patch 7 stops cxl_reset from breaking EEH.

Patches 8 and 9 are parts of EEH.

 - Firstly we have a kernel flag that allows us to confidently assert
   the hardware will not change (be reflashed) when it it reset.

 - We then have the EEH support itself.

Finally, we add a CONFIG_CXL_EEH symbol that allows drivers to depend
on CXL EEH, or to be easily backportable if EEH is optional.

Changes from v1:
 - More comprehensive link down checks, including vPHB.
 - Rebased to apply cleanly to 4.2-rc4.
 - cxl reset changes.
 - CONFIG_CXL_EEH symbol addition.
 - add better vPHB support to EEH.

Daniel Axtens (10):
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
 drivers/misc/cxl/api.c                    |   9 +
 drivers/misc/cxl/context.c                |   6 +-
 drivers/misc/cxl/cxl.h                    |  41 ++-
 drivers/misc/cxl/file.c                   |  19 ++
 drivers/misc/cxl/irq.c                    |   9 +
 drivers/misc/cxl/native.c                 |  99 +++++-
 drivers/misc/cxl/pci.c                    | 521 ++++++++++++++++++++++++------
 drivers/misc/cxl/sysfs.c                  |  30 ++
 drivers/misc/cxl/vphb.c                   |  34 ++
 include/misc/cxl.h                        |  12 +
 12 files changed, 673 insertions(+), 123 deletions(-)

-- 
2.1.4
