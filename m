Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 132012C02ED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 15:51:10 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 23:51:08 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6FAE719D8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:50:56 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5R5p5rb235064
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:51:05 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5R5p5Qj022446
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:51:05 -0600
Date: Thu, 27 Jun 2013 13:51:03 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: From: Gavin Shan <shangw@linux.vnet.ibm.com>
Message-ID: <20130627055103.GA14126@shangw.(null)>
References: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 27, 2013 at 01:46:41PM +0800, Gavin Shan wrote:

The subject went wrong. I didn't make the format correct and here's
the makeup:

[PATCH v4 00/8] Follow-up fixes for EEH on PowerNV

>The series of patches are follow-up in order to make EEH workable for PowerNV
>platform on Juno-IOC-L machine. Couple of issues have been fixed with help of
>Ben:
>
>	- Check PCIe link after PHB complete reset
>	- Restore config space for bridges
>	- The EEH address cache wasn't built successfully
>	- Misc cleanup on output messages
>	- Misc cleanup on EEH flags maintained by "struct pnv_phb"
>	- Misc cleanup on properties of functions to avoid build warnings
>	- Let PCI config accessors rely on device node
>	- Do hotplug during reset for those devices whose drivers can't
>	  support EEH
>
>---
>
>Trigger frozen PE:
>
>        echo 0x0000000002000000 > /sys/kernel/debug/powerpc/PCI0000/err_injct
>        sleep 1
>        echo 0x0 > /sys/kernel/debug/powerpc/PCI0000/err_injct
>
>Trigger fenced PHB:
>
>	echo 0x8000000000000000 > /sys/kernel/debug/powerpc/PCI0000/err_injct
>
>
>---
>
>Changelog:
>==========
>v3 -> v4:
>	* Add more output messages in EEH core to let users know what the EEH
>	  core is doing.
>	* Add one patch to use device node in the PCI config accessors since
>	  the accessors used by EEH and it's not safe enough to refer PCI device
>	  and bus. We instead fully utilize the information from PCI_DN.
>	* Add one patch to remove those deivces whose drivers can't support EEH
>	  before reset, and add them to the system after reset. 
>v2 -> v3:
>	* Fix overwritten buffer while collecting data from PCI config space.
>v1 -> v2:
>	* Remove the mechanism to block PCI-CFG and MMIO.
>	* Add one patch to do cleanup on output messages.
>	* Add one patch to avoid build warnings.
>	* Split functions to restore BARs for PCI devices and bridges separately.
>
>---
>
>arch/powerpc/include/asm/eeh.h               |    8 +-
>arch/powerpc/include/asm/pci.h               |    1 +
>arch/powerpc/kernel/eeh.c                    |   43 +++++--
>arch/powerpc/kernel/eeh_cache.c              |    4 +-
>arch/powerpc/kernel/eeh_driver.c             |  157 +++++++++++++++++++++++-
>arch/powerpc/kernel/eeh_pe.c                 |  166 ++++++++++++++++++++++++--
>arch/powerpc/kernel/pci_hotplug.c            |    8 +-
>arch/powerpc/platforms/powernv/eeh-ioda.c    |   33 +++--
>arch/powerpc/platforms/powernv/eeh-powernv.c |   44 +-------
>arch/powerpc/platforms/powernv/pci-ioda.c    |    1 +
>arch/powerpc/platforms/powernv/pci.c         |  124 ++++++++++++--------
>arch/powerpc/platforms/powernv/pci.h         |   11 ++-
>drivers/pci/probe.c                          |    6 +-
>13 files changed, 462 insertions(+), 144 deletions(-)
>
>Thanks,
>Gavin
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
>
