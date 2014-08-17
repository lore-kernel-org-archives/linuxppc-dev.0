Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 250791A0042
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 16:43:06 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sun, 17 Aug 2014 16:43:01 +1000
Received: from d23relay07.au.ibm.com (unknown [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B8B562F40A96
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 13:02:56 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7H33Jfs12517512
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 13:03:20 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7H32Z8l010075
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 13:02:35 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5] powerpc: EEH fixes
Date: Sun, 17 Aug 2014 13:02:24 +1000
Message-Id: <1408244549-10221-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches is to fix recursive EEH error during recovery
for VFIO-PCI except some cleanup. The recursive EEH error is caused
by MMIO access when the PE is under reset or the PCI device isn't
enabled yet. The solution is to freeze the PE until the PCI device
is enabled after PE reset.

Another issue is that one specific PE is frozen when being passed
through. It caused the device can't work properly in userland (e.g.
QEMU). The fix is to clear the frozen state when passing PE to
userland.

Gavin Shan (5):
  powerpc/eeh: Drop unused argument in eeh_check_failure()
  powerpc/eeh: Add eeh_pe_state sysfs entry
  powerpc/eeh: Freeze PE before PE reset
  powerpc/eeh: Reenable PCI devices after reset
  powerpc/eeh: Clear frozen state on passing device

 arch/powerpc/include/asm/eeh.h               |  30 +++----
 arch/powerpc/kernel/eeh.c                    | 116 +++++++++++++++++++++------
 arch/powerpc/kernel/eeh_sysfs.c              |  61 +++++++++++++-
 arch/powerpc/platforms/powernv/eeh-ioda.c    |  43 +++++++---
 arch/powerpc/platforms/pseries/eeh_pseries.c |   4 +-
 5 files changed, 203 insertions(+), 51 deletions(-)

-- 
1.8.3.2
