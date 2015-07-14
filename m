Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E28FB1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 12:31:46 +1000 (AEST)
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 07FBD140773
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2015 12:31:44 +1000 (AEST)
Received: by paciu1 with SMTP id iu1so15413149pac.0
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 19:31:42 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH 0/8] CXL EEH Handling
Date: Tue, 14 Jul 2015 12:29:26 +1000
Message-Id: <1436840974-3412-1-git-send-email-dja@axtens.net>
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

 - Patch 1 creates a kernel flag that allows us to confidently assert
   the hardware will not change when it's reset.
 
 - Patch 2 makes sure we don't touch the hardware when it has failed.
 
 - Patches 3-5 make the 'unplug' functions idempotent, so that if we
   get part way through recovery and then fail, being completely
   unplugged as part of removal doesn't cause us to oops out.

 - Patches 6 and 7 refactor init and teardown paths for the adapter
   and AFUs, so that they can be configured and deconfigured
   separately from their allocation and release.

Patch 8 enables EEH, both for the CXL card, and anything attached to
the virtual PHB. Only complete slot resets are supported.

Daniel Axtens (8):
  cxl: Allow the kernel to trust that an image won't change on PERST.
  cxl: Drop commands if the PCI channel is not in normal state
  cxl: Allocate and release the SPA with the AFU
  cxl: Make IRQ release idempotent
  cxl: Clean up adapter MMIO unmap path.
  cxl: Refactor adaptor init/teardown
  cxl: Refactor AFU init/teardown
  cxl: EEH support

 Documentation/ABI/testing/sysfs-class-cxl |  10 +
 drivers/misc/cxl/api.c                    |   7 +
 drivers/misc/cxl/cxl.h                    |  38 ++-
 drivers/misc/cxl/file.c                   |  20 ++
 drivers/misc/cxl/irq.c                    |   9 +
 drivers/misc/cxl/native.c                 | 100 +++++-
 drivers/misc/cxl/pci.c                    | 498 ++++++++++++++++++++++++------
 drivers/misc/cxl/sysfs.c                  |  26 ++
 include/misc/cxl.h                        |  10 +
 9 files changed, 602 insertions(+), 116 deletions(-)

-- 
2.1.4
