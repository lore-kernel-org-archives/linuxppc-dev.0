Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E79B02C0095
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 18:44:34 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 8 Sep 2012 04:44:31 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 767EA38C8039
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 04:44:28 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q888iSLJ106990
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 04:44:28 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q888iR6b005829
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 04:44:28 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/22 V4] powerpc/eeh: PE support
Date: Sat,  8 Sep 2012 16:44:01 +0800
Message-Id: <1347093863-6319-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches address explicit PE support as well as probe type
support. For explicit PE support, struct eeh_pe has been introduced.
While designing the struct, following factors have been taken into
account.

   * For one particular PE, it might be composed of single PCI device,
     or multiple PCI devices and its educed children PCI devices (e.g.
     by PCIe bridges). The PE struct has included a linked list to refer
     the included PCI devices. Also, the linked list of devices has relected
     top-to-bottom fasion of the PCI subtree. That's to say, the first device
     in the linked list should be the toppest element in the PCI subtree which
     is being managed by the PE.
   * PEs correlate to each other. So the existing PEs have to form hierarchy
     levels. There're some fields in PE struct (e.g. parent/child/silbing)
     have been introduced for the purpose.
   * For one PE, it's only meaningful in the PHB domain.

In addition, the mechniasm used to do memory bars restore, error report have
been reworked based on PE. The eeh cache has been reworked for a little bit
based on Ben's suggestion to trace eeh device. 

In order for explicit probe support, either OF node or pci device, global
variable and some inline functions are introduced. For pSeries platform, it's
going to support OF node probe and figure out PEs from the corresponding OF
nodes. In contrast, powernv platform has to use pci device probe type since
the PEs are being constructed at PHB fixup time.

The series of patches have been verified on Firebird-L machine using "errinjct"
utility. Here's the command used for that.

errinjct eeh -v -f 0 -p U78AE.001.WZS00M9-P1-C18-L1-T2 -a 0x0 -m 0x0

V3 -> V4:
	* The V4 patches were built on 3.6.RC4 as V3 did.
	* Changelog changes according to Ben's comments. More specificly,
	  change FDT with device tree or similiar terminology.
	* Print return value when failing to register platform dependent EEH
	  operations in eeh_pseries_init().
	* Introduce function eeh_pe_alloc() to allocate instance of EEH PE
	  and initialize its link lists. The PE type and corresponding PHB
	  are also assigned during PE creation time.
	* Change eeh_phb_pe_create() to use eeh_pe_alloc().
	* Introduce function eeh_add_to_parent_pe() to replace the original
	  function eeh_pe_create().
	* Change pr_info() to pr_debug() while associating EEH device with its
	  parent PE to reduce output from system console.
	* Rename eeh_pe_remove() to eeh_rmv_from_parent_pe().
	* Change pr_err() to pr_warning() when we can't find the parent PE for
	  the given EEH device in eeh_rmv_from_parent_pe().
	* Fix the experssion to check if the given PE is PHB sensitive PE in
	  function eeh_rmv_from_parent_pe().
	* Rename EEH_PROBE_MODE_FDT to EEH_PROBE_MODE_DEVTREE.
	* Rename function eeh_probe_mode_fdt() to eeh_probe_mode_devtree().
	* Cleanup on function names for EEH cache so that they have prefix "eeh"
	  and more short. Besides, the printk() has been replaced with pr_warning()
	  or pr_debug().
V2 -> V3:
	* Rebase to 3.6.RC4.
V1 -> V2:
	* Rebase to 3.5.RC4.
	* Use the link list to trace the relationships of PEs, PE and eeh
	  devices according to Ram's suggestion.
	* Simplify the PE tranverse function according to Ram's example.
	* Move EEH initialization around according to Ben's suggestion so
	  that we can do memory allocation through slab.
	* Use kzmalloc() to allocate memory chunks for PE and eeh devices.
	* More booting messages for EEH initialization functions.
	* Introduce global EEH mutex to protect the PEs and eeh devices.
	* Added functions to support PE removal.
	* Comments cleanup
	* Change on the comparison of PE or BDF (Bus/Device/Function)
	  address so that code looks more readable.

-----

arch/powerpc/include/asm/eeh.h               |  136 +++++--
arch/powerpc/include/asm/eeh_event.h         |    6 +-
arch/powerpc/include/asm/pci-bridge.h        |    2 +
arch/powerpc/include/asm/ppc-pci.h           |   20 +-
arch/powerpc/kernel/rtas_pci.c               |    5 +-
arch/powerpc/platforms/pseries/Makefile      |    5 +-
arch/powerpc/platforms/pseries/eeh.c         |  531 +++++------------------
arch/powerpc/platforms/pseries/eeh_cache.c   |   57 ++--
arch/powerpc/platforms/pseries/eeh_dev.c     |   14 +-
arch/powerpc/platforms/pseries/eeh_driver.c  |  235 +++++------
arch/powerpc/platforms/pseries/eeh_event.c   |   54 +--
arch/powerpc/platforms/pseries/eeh_pe.c      |  591 ++++++++++++++++++++++++++
arch/powerpc/platforms/pseries/eeh_pseries.c |  247 ++++++++----
arch/powerpc/platforms/pseries/eeh_sysfs.c   |    9 -
arch/powerpc/platforms/pseries/msi.c         |    6 +-
arch/powerpc/platforms/pseries/pci.c         |    2 +-
arch/powerpc/platforms/pseries/setup.c       |    2 -
17 files changed, 1154 insertions(+), 768 deletions(-)
create mode 100644 arch/powerpc/platforms/pseries/eeh_pe.c

Thanks,
Gavin
