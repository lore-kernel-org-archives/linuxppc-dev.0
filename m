Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 389362C038D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 20:02:06 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 06:02:04 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 948086E8039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 06:01:58 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PA1EMv339188
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 06:01:14 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PA19qR010383
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 07:01:10 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 00/6] Follow-up fixes for EEH on PowerNV
Date: Tue, 25 Jun 2013 18:00:55 +0800
Message-Id: <1372154461-29674-1-git-send-email-shangw@linux.vnet.ibm.com>
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
