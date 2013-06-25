Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CBAD52C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 15:55:28 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 01:55:24 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9D6A238C8042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:55:21 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P5tMG757475076
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:55:22 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P5tLlG023974
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:55:22 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 00/10] powerpc/eeh: Remove eeh_mutex
Date: Tue, 25 Jun 2013 13:55:07 +0800
Message-Id: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches are follow-up in order to make EEH workable for PowerNV
platform on Juno-IOC-L machine. Couple of issues have been fixed with help of
Ben:
	- eeh_lock() and eeh_unlock() were introduced to protect the PE hierarchy
	  tree. However, we already had one kthread ("eehd"). So that's not necessary
	  any more.
	- When PHB gets fenced, we need do complete reset for the PHB in order
	  for recovery. However, we never checked the downstream PCIe links are
	  ready again.
	- Introduce mechanism to block accessing to PCI-CFG and MMIO. The hardware
	  should return 0xFF's while the PHB is fenced. So we needn't access PCI-CFG
	  and MMIO during the stage (before the PHB gets complete reset).
	- EEH address cache wasn't populated on PowerNV.
	- PCI-CFG for PCI bridges (PCI_COMMAND) wasn't restored correctly.
	- While PHB gets fenced, TG3 driver is still trying to access MMIO with loop.
	  That's unnecessary.

The series of patches have been verified on Juno-IOC-L machine:

Trigger frozen PE:

        echo 0x0000000002000000 > /sys/kernel/debug/powerpc/PCI0000/err_injct
        sleep 1
        echo 0x0 > /sys/kernel/debug/powerpc/PCI0000/err_injct

Trigger fenced PHB:

	echo 0x8000000000000000 > /sys/kernel/debug/powerpc/PCI0000/err_injct

---

arch/powerpc/include/asm/eeh.h               |  251 ++++++++++++++++++++------
arch/powerpc/include/asm/io.h                |   67 ++++---
arch/powerpc/kernel/eeh.c                    |   85 ++++++---
arch/powerpc/kernel/eeh_cache.c              |    2 +-
arch/powerpc/kernel/eeh_driver.c             |   11 ++
arch/powerpc/kernel/eeh_event.c              |    3 +-
arch/powerpc/kernel/eeh_pe.c                 |  150 ++++++++++++----
arch/powerpc/platforms/powernv/eeh-ioda.c    |   88 +++++++++-
arch/powerpc/platforms/powernv/eeh-powernv.c |   42 ++++-
arch/powerpc/platforms/powernv/pci-ioda.c    |    1 +
arch/powerpc/platforms/powernv/pci.c         |   63 +++++--
arch/powerpc/platforms/powernv/pci.h         |   16 ++-
arch/powerpc/platforms/pseries/eeh_pseries.c |   44 +++++
drivers/net/ethernet/broadcom/tg3.c          |   36 ++++
14 files changed, 685 insertions(+), 174 deletions(-)

Thanks,
Gavin
