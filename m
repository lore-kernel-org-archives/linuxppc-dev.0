Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xck176T8KzDrKb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 20:19:07 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alistair Popple <alistair@popple.id.au>, Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel 0/5] powerpc/eeh: Some cleanups
Date: Wed, 23 Aug 2017 20:18:56 +1000
Message-Id: <20170823101901.33961-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here are few patches to get rid of some cached pointers across EEH and
powernv code as I was struggling to figure out about lifetime of
structures and so on.


This is based on sha1
98b9f8a45499 Linus Torvalds Merge tag 'ext4_for_linus_stable' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4

Please comment. Thanks.



Alexey Kardashevskiy (5):
  powerpc/pci: Remove unused parameter from add_one_dev_pci_data()
  powerpc/eeh: Reduce to one the number of places where edev is
    allocated
  powerpc/eeh: Remove unnecessary pointer to phb from eeh_dev
  powerpc/eeh: Remove unnecessary config_addr from eeh_dev
  powerpc/eeh: Remove unnecessary node from pci_dn

 arch/powerpc/include/asm/eeh.h               |  5 +-
 arch/powerpc/include/asm/pci-bridge.h        |  1 -
 arch/powerpc/kernel/eeh.c                    | 16 ++---
 arch/powerpc/kernel/eeh_dev.c                |  2 -
 arch/powerpc/kernel/eeh_driver.c             |  2 +-
 arch/powerpc/kernel/eeh_pe.c                 | 90 ++++++++++++++++------------
 arch/powerpc/kernel/eeh_sysfs.c              |  3 -
 arch/powerpc/kernel/pci_dn.c                 | 22 +++----
 arch/powerpc/platforms/powernv/eeh-powernv.c | 29 +++------
 9 files changed, 78 insertions(+), 92 deletions(-)

-- 
2.11.0
