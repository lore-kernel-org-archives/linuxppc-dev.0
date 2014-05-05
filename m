Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ED3A2140172
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:55 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:27:54 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8809F2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:51 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s451RaWE10682878
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:36 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451RoS5013606
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:51 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH RFC 00/22] EEH Support for VFIO PCI devices on PowerKVM guest
Date: Mon,  5 May 2014 11:27:49 +1000
Message-Id: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches intends to support EEH for PCI devices, which have been
passed through to PowerKVM based guest via VFIO. The implementation is
straightforward based on the issues or problems we have to resolve to support
EEH for PowerKVM based guest.

- Emulation for EEH RTAS requests. Thanksfully, we already have infrastructure
  to emulate XICS. Without introducing new mechanism, we just extend that
  existing infrastructure to support EEH RTAS emulation. EEH RTAS requests
  initiated from guest are posted to host where the requests get handled or
  delivered to underly firmware for further handling. For that, the host kerenl
  has to maintain the PCI address (host domain/bus/slot/function to guest's
  PHB BUID/bus/slot/function) mapping via KVM VFIO device. The address mapping
  will be built when initializing VFIO device in QEMU and destroied when the
  VFIO device in QEMU is going to offline, or VM is destroy.

- The infrastructure for error injection is introduced. The emulation for the
  related RTAS services is similar to what we do for EEH/XICS RTAS requests.
  For now, we just support PCI error injection. We need extend it for injecting
  other types of errors in future.

The series of patches requires corresponding firmware changes from Mike Qiu to
support error injection and QEMU changes to support EEH for guest. It also needs
QEMU changes to support it. QEMU patchset will be sent separately.

I usually use command line (not virsh) to start PowerKVM based guests on Firebird-L
machine with different types of PCI devices assigend (passed through) to guest.
Following cases have been tested. The EEH error can be injected by utility "errinjct"
running on guest successfully and we can recover from the EEH error successfully.

Testing on P7
=============

- Emulex adapter
- USB (OHCI) PCI adapter

Testing on P8
=============

- MLX4 adapter (Partially)
- USB (xHCI) PCI adapter

-----

arch/powerpc/include/asm/book3s_errinjct.h     |  97 ++++++++++++++++++++++++
arch/powerpc/include/asm/eeh.h                 |  78 ++++++++++++++++++++
arch/powerpc/include/asm/kvm_ppc.h             |   7 ++
arch/powerpc/include/asm/opal.h                |  65 ++++++++++++++++
arch/powerpc/kernel/eeh.c                      |   8 ++
arch/powerpc/kernel/eeh_pe.c                   | 297 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/powerpc/kvm/Kconfig                       |  17 +++++
arch/powerpc/kvm/Makefile                      |   6 ++
arch/powerpc/kvm/book3s_errinjct.c             | 329 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/powerpc/kvm/book3s_hv.c                   |   2 +
arch/powerpc/kvm/book3s_rtas.c                 |  67 +++++++++++++++++
arch/powerpc/platforms/powernv/Makefile        |   2 +
arch/powerpc/platforms/powernv/eeh-ioda.c      |   3 +-
arch/powerpc/platforms/powernv/eeh-rtas.c      | 551 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/powerpc/platforms/powernv/errinjct.c      | 215 +++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
include/linux/kvm_host.h                       |  21 ++++++
include/uapi/linux/kvm.h                       |  10 +++
virt/kvm/vfio.c                                |  60 ++++++++++++++-
19 files changed, 1834 insertions(+), 2 deletions(-)
create mode 100644 arch/powerpc/include/asm/book3s_errinjct.h
create mode 100644 arch/powerpc/kvm/book3s_errinjct.c
create mode 100644 arch/powerpc/platforms/powernv/eeh-rtas.c
create mode 100644 arch/powerpc/platforms/powernv/errinjct.c

Thanks,
Gavin
