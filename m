Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 99678140085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:09 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 14 May 2014 14:12:08 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7EC452BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:05 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4E3obFW63242266
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 13:50:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4E4C46w013818
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH RFC v3 0/8] EEH Support for VFIO PCI device
Date: Wed, 14 May 2014 14:11:54 +1000
Message-Id: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
  VFIO container IOCTL command (VFIO_EEH_INFO) and gets handled in host kernel.

- The error injection infrastructure need support request from the userland
  utility "errinjct" and PowerKVM based guest. The userland utility "errinjct"
  works on pSeries platform well with dedicated syscall, which helps invoking
  RTAS service to fulfil error injection in kernel. From the perspective, it's
  reasonable to extend the syscall to support PowerNV platform so that OPAL call
  can be invoked in host kernel for injecting errors. The data transported
  between userland and kerenl is still following "struct rtas_args" for both
  cases of PowerNV (OPAL) and pSeries (RTAS).

The series of patches requires corresponding firmware changes from Mike Qiu to
support error injection and QEMU changes to support EEH for guest. QEMU patchset
will be sent separately.

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

Testing on P7
=============

- Emulex adapter

Testing on P8
=============

- Need more testing after design is finalized.

-----

Gavin Shan (8):
  drivers/vfio: Introduce CONFIG_VFIO_EEH
  powerpc/eeh: Info to trace passed devices
  drivers/vfio: New IOCTL command VFIO_EEH_INFO
  powerpc/eeh: Avoid event on passed PE
  powerpc/powernv: Sync OPAL header file with firmware
  powerpc: Extend syscall ppc_rtas()
  powerpc/powernv: Implement ppc_call_opal()
  powerpc/powernv: Error injection infrastructure

 arch/powerpc/include/asm/eeh.h                 |  52 +++
 arch/powerpc/include/asm/opal.h                |  74 ++-
 arch/powerpc/include/asm/rtas.h                |  10 +-
 arch/powerpc/include/asm/syscalls.h            |   2 +-
 arch/powerpc/include/asm/systbl.h              |   2 +-
 arch/powerpc/include/uapi/asm/unistd.h         |   2 +-
 arch/powerpc/kernel/eeh.c                      |   8 +
 arch/powerpc/kernel/eeh_pe.c                   |  80 ++++
 arch/powerpc/kernel/rtas.c                     |  57 +--
 arch/powerpc/kernel/syscalls.c                 |  50 +++
 arch/powerpc/platforms/powernv/Makefile        |   3 +-
 arch/powerpc/platforms/powernv/eeh-ioda.c      |   3 +-
 arch/powerpc/platforms/powernv/eeh-vfio.c      | 593 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/errinject.c     | 224 ++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/opal.c          |  93 ++++
 drivers/vfio/Kconfig                           |   6 +
 drivers/vfio/vfio_iommu_spapr_tce.c            |  12 +
 include/uapi/linux/vfio.h                      |  57 +++
 kernel/sys_ni.c                                |   2 +-
 20 files changed, 1278 insertions(+), 53 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/eeh-vfio.c
 create mode 100644 arch/powerpc/platforms/powernv/errinject.c

Thanks,
Gavin
