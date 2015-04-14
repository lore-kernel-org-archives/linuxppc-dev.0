Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3DD3F1A113C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:34:17 +1000 (AEST)
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 70CF21402AE
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 14:34:16 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so124990514pac.1
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 21:34:15 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [RFC PATCH 0/2] First steps to using generic controller ops
Date: Tue, 14 Apr 2015 14:33:59 +1000
Message-Id: <1428986041-25657-1-git-send-email-dja@axtens.net>
Cc: Yijing Wang <wangyijing@huawei.com>, Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recently I reviewed some patches from Yijing Wang that added a generic
PHB operations structure. I said that we needed further work on our
end to take full advantage of it.

This is a proposed set of first steps to do that.

In short, it allows us to trivially kill off another ppc_md function. :)

In more detail:

 - Previously, the generic ops were set in pci-common.c: the same ops
   were used across all of PowerPC. This moves generic ops to our
   pci_controller structure, next to our existing pci_controller_ops
   structure. [1] The idea is that we'll progressively move ops out of
   pci_controller_ops and into pci_host_bridge_ops, until
   pci_controller_ops is just arch-specific ops.

 - pci_ops are moved from pci_controller to pci_host_bridge_ops.

 - pseries is the only platform that defines a ppc_md hook for
   pcibios_set_root_bus_speed. That's in the new generic structure, so
   move the function into that. Delete the ppc_md pointer and the
   pcibios call that calls it.

I haven't figured out a good way to handle scan_bus. Currently, it's
populated with the generic function in a way that's a bit dirty, so
I'd like to make that a bit cleaner. There are also a couple of cases
of similar-ish code (in pci-hotplug.c and pci_of_scan.c); it'd be nice to
see if we could simplify that all down a bit... Suggestions welcome.

Regards,
Daniel

[1] Having ops specfied on a per PHB basis is helpful for the case of
    multiple types of PHB, which occurs with CXL (aka CAPI).

Daniel Axtens (2):
  powerpc: Add pci_controller.generic_ops and move pci_controller.ops in
  powerpc: Migrate pseries to host_bridge_ops, remove
    pcibios_set_root_bus_speed

 arch/powerpc/include/asm/machdep.h          |  2 --
 arch/powerpc/include/asm/pci-bridge.h       |  2 +-
 arch/powerpc/kernel/pci-common.c            | 21 +++++++--------------
 arch/powerpc/kernel/rtas_pci.c              |  2 +-
 arch/powerpc/platforms/52xx/efika.c         |  2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c   |  2 +-
 arch/powerpc/platforms/chrp/pci.c           |  6 +++---
 arch/powerpc/platforms/maple/pci.c          |  6 +++---
 arch/powerpc/platforms/pasemi/pci.c         |  2 +-
 arch/powerpc/platforms/powermac/pci.c       | 12 ++++++------
 arch/powerpc/platforms/powernv/pci-ioda.c   |  2 +-
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  2 +-
 arch/powerpc/platforms/pseries/setup.c      |  7 +++++--
 arch/powerpc/sysdev/fsl_pci.c               |  6 +++---
 arch/powerpc/sysdev/indirect_pci.c          |  2 +-
 arch/powerpc/sysdev/ppc4xx_pci.c            |  2 +-
 arch/powerpc/sysdev/tsi108_pci.c            |  2 +-
 17 files changed, 37 insertions(+), 43 deletions(-)

-- 
2.1.4
