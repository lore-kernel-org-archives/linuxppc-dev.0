Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECA571A085C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:30:23 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 20 May 2014 18:30:22 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EAB812BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:30:19 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4K88sbl64946370
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:08:54 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4K8UJCx029987
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:30:19 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH RFCv4 0/4] EEH Support for VFIO PCI device
Date: Tue, 20 May 2014 18:30:08 +1000
Message-Id: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

Testing on P7
=============

- Emulex adapter

Testing on P8
=============
Need testing for more after the code is finalized. The logic is required by P7/P8
machines shouldn't be different.

Gavin Shan (4):
  drivers/vfio: Introduce CONFIG_VFIO_PCI_EEH
  powerpc/eeh: Flags for passed device and PE
  drivers/vfio: New IOCTL command VFIO_EEH_INFO
  powerpc/eeh: Avoid event on passed PE

 arch/powerpc/include/asm/eeh.h            |  32 +++
 arch/powerpc/kernel/eeh.c                 |   8 +
 arch/powerpc/platforms/powernv/Makefile   |   1 +
 arch/powerpc/platforms/powernv/eeh-ioda.c |   3 +-
 arch/powerpc/platforms/powernv/eeh-vfio.c | 445 ++++++++++++++++++++++++++++++
 drivers/vfio/pci/Kconfig                  |   6 +
 drivers/vfio/pci/vfio_pci.c               |  24 +-
 drivers/vfio/pci/vfio_pci_private.h       |  16 ++
 include/uapi/linux/vfio.h                 |  43 +++
 9 files changed, 571 insertions(+), 7 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/eeh-vfio.c

-- 
1.8.3.2
