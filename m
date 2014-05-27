Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD2DF1A0643
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:41:12 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 27 May 2014 18:41:11 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AF7982BB005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:41:09 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4R8JT1U29229066
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:19:32 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4R8erj3009913
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:40:53 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v7 0/3] EEH Support for VFIO PCI Device
Date: Tue, 27 May 2014 18:40:49 +1000
Message-Id: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, agraf@suse.de, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches intends to support EEH for PCI devices, which are
passed through to PowerKVM based guest via VFIO. The implementation is
straightforward based on the issues or problems we have to resolve to
support EEH for PowerKVM based guest.

- Emulation for EEH RTAS requests. All EEH RTAS requests goes to QEMU firstly.
  If QEMU can't handle it, the request will be sent to host via newly introduced
  VFIO container IOCTL command (VFIO_EEH_OP) and gets handled in host kernel.

The series of patches requires corresponding QEMU changes.

Change log
==========
v1 -> v2:
        * EEH RTAS requests are routed to QEMU, and then possiblly to host kerenl.
          The mechanism KVM in-kernel handling is dropped.
        * Error injection is reimplemented based syscall, instead of KVM in-kerenl
          handling. The logic for error injection token management is moved to
          QEMU. The error injection request is routed to QEMU and then possiblly
          to host kernel.
v2 -> v3:
        * Make the fields in struct eeh_vfio_pci_addr, struct vfio_eeh_info based
          on the comments from Alexey.
        * Define macros for EEH VFIO operations (Alexey).
        * Clear frozen state after successful PE reset. 
        * Merge original [PATCH 1/2/3] to one.
v3 -> v4:
        * Remove the error injection from the patchset. Mike or I will work on that
          later.
        * Rename CONFIG_VFIO_EEH to VFIO_PCI_EEH.
        * Rename the IOCTL command to VFIO_EEH_OP and it's handled by VFIO-PCI device
          instead of VFIO container.
        * Rename the IOCTL argument structure to "vfio_eeh_op" accordingly. Also, more
          fields added to hold return values for RTAS requests.
        * The address mapping stuff is totally removed. When opening or releasing VFIO
          PCI device, notification sent to EEH to update the flags indicates the device
          is passed to guest or not.
        * Change pr_warn() to pr_debug() to avoid DOS as pointed by Alex.W
        * Argument size check issue pointed by Alex.W.
v4 -> v5:
        * Functions for VFIO PCI EEH support are moved to eeh.c and exported from there.
          VFIO PCI driver just uses those functions to tackle IOCTL command VFIO_EEH_OP.
          All of this is to make the code organized in a good way as suggested by Alex.G.
          Another potential benefit is PowerNV/pSeries are sharing "eeh_ops" and same
          infrastructure could possiblly work for KVM_PR and KVM_HV mode at the same time.
        * Don't clear error injection registers after finishing PE reset as the patchset
          is doing nothing related to error injection.
        * Amending Documentation/vfio.txt, which was missed in last revision.
        * No QEMU changes for this revision. "v4" works well. Also, remove "RFC" from the
          subject as the design is basically recognized.
v5 -> v6:
        * CONFIG_VFIO_PCI_EEH removed. Instead to use CONFIG_EEH.
        * Split one ioctl command to 5.
        * In eeh.c, description has been added for those exported functions. Also, the
          functions have negative return values for error and information with other values.
          All digital numbers have been replaced by macros defined in eeh.h. The comments,
          including the function names have been amended not to mention "guest" or "vfio".
        * Add one mutex to protect flag in eeh_dev_open()/release().
        * More information on how to use those ioctl commands to Documentation/vfio.txt.
v6 -> v7:
	* Remove ioctl command VFIO_EEH_PE_GET_ADDR, the PE address will be figured out
	  in userland (e.g. QEMU) as Alex.G suggested.
	* Let sPAPR VFIO container process the ioctl commands as VFIO container is naturally
	  corresponds to IOMMU group (aka PE on sPAPR platform).
	* All VFIO PCI EEH ioctl commands have "argsz+flags" for its companion data struct.
	* For VFIO PCI EEH ioctl commands, ioctl() returns negative number to indicate error
	  or zero for success. Additinal output information is transported by the companion
	  data struct.
	* Explaining PE in Documentation/vfio.txt, typo fixes, more comments suggested by
	  Alex.G.
	* Split/merge patches according to suggestions from Alex.G and Alex.W.
	* To have EEH stub in drivers/vfio/pci/, which was suggested by Alex.W.
	* Define various EEH options as macros in vfio.h for userland to use.

Gavin Shan (3):
  powerpc/eeh: Avoid event on passed PE
  powerpc/eeh: EEH support for VFIO PCI device
  drivers/vfio: EEH support for VFIO PCI device

Documentation/vfio.txt                    |  92 +++++++++++++++++++++++++++++++++++++++++++-
arch/powerpc/include/asm/eeh.h            |  47 +++++++++++++++++++++++
arch/powerpc/kernel/eeh.c                 | 294 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/powerpc/platforms/powernv/eeh-ioda.c |   3 +-
drivers/vfio/pci/Makefile                 |   1 +
drivers/vfio/pci/vfio_pci.c               |  20 +++++++---
drivers/vfio/pci/vfio_pci_eeh.c           |  46 ++++++++++++++++++++++
drivers/vfio/pci/vfio_pci_private.h       |   5 +++
drivers/vfio/vfio_iommu_spapr_tce.c       |  85 +++++++++++++++++++++++++++++++++++++++++
include/uapi/linux/vfio.h                 |  66 ++++++++++++++++++++++++++++++++
10 files changed, 651 insertions(+), 8 deletions(-)

-- 
1.8.3.2
