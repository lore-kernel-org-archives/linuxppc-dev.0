Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32E302C0077
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 11:38:17 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 19:38:15 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 777D419D8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:38:03 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5Q1cCQM149050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:38:12 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5Q1cCo9006826
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:38:12 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 00/6] Follow-up fixes for EEH on PowerNV
Date: Wed, 26 Jun 2013 09:38:02 +0800
Message-Id: <1372210688-12214-1-git-send-email-shangw@linux.vnet.ibm.com>
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

	- Check PCIe link after PHB complete reset
	- Restore config space for bridges
	- The EEH address cache wasn't built successfully
	- Misc cleanup on output messages
	- Misc cleanup on EEH flags maintained by "struct pnv_phb"
	- Misc cleanup on properties of functions to avoid build warnings
 
The series of patches have been verified on Juno-IOC-L machine:

Trigger frozen PE:

        echo 0x0000000002000000 > /sys/kernel/debug/powerpc/PCI0000/err_injct
        sleep 1
        echo 0x0 > /sys/kernel/debug/powerpc/PCI0000/err_injct

Trigger fenced PHB:

	echo 0x8000000000000000 > /sys/kernel/debug/powerpc/PCI0000/err_injct


Changelog:
==========

v2 -> v3:
	* Fix overwritten buffer while collecting data
	  from PCI config space.
v1 -> v2:
	* Remove the mechanism to block PCI-CFG and MMIO.
	* Add one patch to do cleanup on output messages.
	* Add one patch to avoid build warnings.
	* Split functions to restore BARs for PCI devices and bridges separately.

---

arch/powerpc/include/asm/eeh.h            |    4 +-
arch/powerpc/kernel/eeh.c                 |   43 ++++++--
arch/powerpc/kernel/eeh_cache.c           |    4 +-
arch/powerpc/kernel/eeh_pe.c              |  157 ++++++++++++++++++++++++++---
arch/powerpc/platforms/powernv/eeh-ioda.c |   33 ++++---
arch/powerpc/platforms/powernv/pci-ioda.c |    1 +
arch/powerpc/platforms/powernv/pci.c      |    4 +-
arch/powerpc/platforms/powernv/pci.h      |    7 +-
8 files changed, 207 insertions(+), 46 deletions(-)

Thanks,
Gavin
