Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB144100AC9
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:11:36 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 12:11:34 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7352738C86E7
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:05:58 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG5sme138756
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:05:56 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG5Stp031631
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 13:05:29 -0300
Date: Thu, 28 Jun 2012 00:05:25 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 00/16] powerpc/eeh: PE support
Message-ID: <20120627160525.GA7030@shangw>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm sorry that the subject should be:

[PATCH V2 00/21] powerpc/eeh: PE support

I forgot got change that when pulling it from V1 :-)

Thanks,
Gavin

>The series of patches address explicit PE support as well as probe type
>support. For explicit PE support, struct eeh_pe has been introduced.
>While designing the struct, following factors have been taken into
>account.
>
>   * For one particular PE, it might be composed of single PCI device,
>     or multiple PCI devices and its educed children PCI devices (e.g.
>     by PCIe bridges). The PE struct has included a linked list to refer
>     the included PCI devices. Also, the linked list of devices has relected
>     top-to-bottom fasion of the PCI subtree. That's to say, the first device
>     in the linked list should be the toppest element in the PCI subtree which
>     is being managed by the PE.
>   * PEs correlate to each other. So the existing PEs have to form hierarchy
>     levels. There're some fields in PE struct (e.g. parent/child/silbing)
>     have been introduced for the purpose.
>   * For one PE, it's only meaningful in the PHB domain.
>
>In addition, the mechniasm used to do memory bars restore, error report have
>been reworked based on PE. The eeh cache has been reworked for a little bit
>based on Ben's suggestion to trace eeh device. 
>
>In order for explicit probe support, either OF node or pci device, global
>variable and some inline functions are introduced. For pSeries platform, it's
>going to support OF node probe and figure out PEs from the corresponding OF
>nodes. In contrast, powernv platform has to use pci device probe type since
>the PEs are being constructed at PHB fixup time.
>
>The series of patches have been verified on Firebird-L machine using "errinjct"
>utility. Here's the command used for that.
>
>errinjct eeh -v -f 0 -p U78AE.001.WZS00M9-P1-C18-L1-T2 -a 0x0 -m 0x0
>
>V1 -> V2
>	* Rebase to 3.5.RC4.
>	* Use the link list to trace the relationships of PEs, PE and eeh
>	  devices according to Ram's suggestion.
>	* Simplify the PE tranverse function according to Ram's example.
>	* Move EEH initialization around according to Ben's suggestion so
>	  that we can do memory allocation through slab.
>	* Use kzmalloc() to allocate memory chunks for PE and eeh devices.
>	* More booting messages for EEH initialization functions.
>	* Introduce global EEH mutex to protect the PEs and eeh devices.
>	* Added functions to support PE removal.
>	* Comments cleanup
>	* Change on the comparison of PE or BDF (Bus/Device/Function)
>	  address so that code looks more readable.
>
>arch/powerpc/include/asm/eeh.h               |  132 ++++--
>arch/powerpc/include/asm/eeh_event.h         |    6 +-
>arch/powerpc/include/asm/pci-bridge.h        |    2 +
>arch/powerpc/include/asm/ppc-pci.h           |   15 +-
>arch/powerpc/kernel/rtas_pci.c               |    5 +-
>arch/powerpc/platforms/pseries/Makefile      |    5 +-
>arch/powerpc/platforms/pseries/eeh.c         |  527 +++++------------------
>arch/powerpc/platforms/pseries/eeh_cache.c   |   19 +-
>arch/powerpc/platforms/pseries/eeh_dev.c     |   14 +-
>arch/powerpc/platforms/pseries/eeh_driver.c  |  235 +++++------
>arch/powerpc/platforms/pseries/eeh_event.c   |   53 +--
>arch/powerpc/platforms/pseries/eeh_pe.c      |  583 ++++++++++++++++++++++++++
>arch/powerpc/platforms/pseries/eeh_pseries.c |  246 +++++++----
>arch/powerpc/platforms/pseries/eeh_sysfs.c   |    9 -
>arch/powerpc/platforms/pseries/msi.c         |    6 +-
>arch/powerpc/platforms/pseries/setup.c       |    2 -
>16 files changed, 1119 insertions(+), 740 deletions(-)
>create mode 100644 arch/powerpc/platforms/pseries/eeh_pe.c
>
>Thanks,
>Gavin
>
