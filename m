Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0lBG1jvNzDrcj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 02:21:42 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIFJJSx140216
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:21:39 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2exeguncvv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:21:39 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 15:21:35 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH 00/13] New driver to support OpenCAPI devices on POWER9
Date: Mon, 18 Dec 2017 16:21:13 +0100
Message-Id: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This series adds support for Open Coherent Accelerator (ocxl) devices
on POWER9 processor. OpenCAPI is a consortium developing the
specifications for an interface between processors and accelerators,
allowing sharing the host memory with the accelerators, using virtual
addresses.

The OpenCAPI device can also have its own local memory and provide
access to the host, though it is not supported by that series.

The OpenCAPI specification is processor agnostic, but this series adds
support specifically for powerpc.

Even though the underlying transport is not PCI, the firmware
abstracts the hardware like a PCI host bridge and Linux sees the
OpenCAPI devices as PCI devices. So a lot of existing infrastructure
and commands can be reused.

Patches 1-5:  add the platform-specific services needed by the driver
Patches 6-10: driver code
Patch 11:     small correction to existing cxl driver
Patch 12:     documentation

Current limitations, that will be addressed in later patches:
 - no capability to trigger a reset of the opencapi adapter
 - no support for the 'wake_host_thread' command
 - no support for adapters with a dual-link connection (none exists yet)
 - no access to the adapter-local memory

Many people contributed directly or indirectly, from the software,
hardware and bringup teams. In particular Andrew Donnellan and
Alastair D'Silva, who are developing the related firmware and library.

Feedback welcome!



Frederic Barrat (13):
  powerpc/powernv: Introduce new PHB type for opencapi links
  powerpc/powernv: Set correct configuration space size for opencapi
    devices
  powerpc/powernv: Add opal calls for opencapi
  powerpc/powernv: Add platform-specific services for opencapi
  powerpc/powernv: Capture actag information for the device
  ocxl: Driver code for 'generic' opencapi devices
  ocxl: Add AFU interrupt support
  ocxl: Add a kernel API for other opencapi drivers
  ocxl: Add trace points
  ocxl: Add Makefile and Kconfig
  cxl: Remove support for "Processing accelerators" class
  ocxl: Documentation
  ocxl: add MAINTAINERS entry

 Documentation/accelerators/ocxl.rst            | 151 +++++
 Documentation/ioctl/ioctl-number.txt           |   1 +
 MAINTAINERS                                    |  12 +
 arch/powerpc/include/asm/opal-api.h            |   5 +-
 arch/powerpc/include/asm/opal.h                |   6 +
 arch/powerpc/include/asm/pnv-ocxl.h            |  43 ++
 arch/powerpc/platforms/powernv/Makefile        |   1 +
 arch/powerpc/platforms/powernv/npu-dma.c       |   2 +-
 arch/powerpc/platforms/powernv/ocxl.c          | 519 ++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   3 +
 arch/powerpc/platforms/powernv/pci-ioda.c      |  56 +-
 arch/powerpc/platforms/powernv/pci.c           |   4 +
 arch/powerpc/platforms/powernv/pci.h           |   8 +-
 drivers/misc/Kconfig                           |   1 +
 drivers/misc/Makefile                          |   1 +
 drivers/misc/cxl/pci.c                         |   2 -
 drivers/misc/ocxl/Kconfig                      |  25 +
 drivers/misc/ocxl/Makefile                     |  10 +
 drivers/misc/ocxl/afu_irq.c                    | 209 +++++++
 drivers/misc/ocxl/config.c                     | 729 +++++++++++++++++++++++++
 drivers/misc/ocxl/context.c                    | 275 ++++++++++
 drivers/misc/ocxl/file.c                       | 438 +++++++++++++++
 drivers/misc/ocxl/link.c                       | 654 ++++++++++++++++++++++
 drivers/misc/ocxl/main.c                       |  40 ++
 drivers/misc/ocxl/ocxl_internal.h              | 138 +++++
 drivers/misc/ocxl/pasid.c                      | 114 ++++
 drivers/misc/ocxl/pci.c                        | 592 ++++++++++++++++++++
 drivers/misc/ocxl/sysfs.c                      | 150 +++++
 drivers/misc/ocxl/trace.c                      |  13 +
 drivers/misc/ocxl/trace.h                      | 189 +++++++
 include/misc/ocxl-config.h                     |  52 ++
 include/misc/ocxl.h                            | 221 ++++++++
 include/uapi/misc/ocxl.h                       |  56 ++
 33 files changed, 4702 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/accelerators/ocxl.rst
 create mode 100644 arch/powerpc/include/asm/pnv-ocxl.h
 create mode 100644 arch/powerpc/platforms/powernv/ocxl.c
 create mode 100644 drivers/misc/ocxl/Kconfig
 create mode 100644 drivers/misc/ocxl/Makefile
 create mode 100644 drivers/misc/ocxl/afu_irq.c
 create mode 100644 drivers/misc/ocxl/config.c
 create mode 100644 drivers/misc/ocxl/context.c
 create mode 100644 drivers/misc/ocxl/file.c
 create mode 100644 drivers/misc/ocxl/link.c
 create mode 100644 drivers/misc/ocxl/main.c
 create mode 100644 drivers/misc/ocxl/ocxl_internal.h
 create mode 100644 drivers/misc/ocxl/pasid.c
 create mode 100644 drivers/misc/ocxl/pci.c
 create mode 100644 drivers/misc/ocxl/sysfs.c
 create mode 100644 drivers/misc/ocxl/trace.c
 create mode 100644 drivers/misc/ocxl/trace.h
 create mode 100644 include/misc/ocxl-config.h
 create mode 100644 include/misc/ocxl.h
 create mode 100644 include/uapi/misc/ocxl.h

-- 
2.14.1
