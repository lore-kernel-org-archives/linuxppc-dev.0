Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQmNZ5MsbzDqxT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 22:31:58 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0NBTPkO014017
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:31:56 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fp2jwmcf4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:31:55 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 23 Jan 2018 11:31:52 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH v2 00/13] New driver to support OpenCAPI devices on POWER9
Date: Tue, 23 Jan 2018 12:31:35 +0100
Message-Id: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
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

Changelog:
v2:
All/many patches:
          use new SPDX tag for licensing info
          fix sparse warnings
patch 2:  set "From" field correctly
      	  don't activate the PCI fixup on platforms other than powernv
patch 4:  fix typos
patch 7:  map AFU interrupt trigger page write-only
patch 10: rephrase CONFIG help message
patch 12: add documentation for new sysfs files
patch 13: follow alphabetical order for new entry in MAINTAINERS



Andrew Donnellan (1):
  powerpc/powernv: Set correct configuration space size for opencapi
    devices

Frederic Barrat (12):
  powerpc/powernv: Introduce new PHB type for opencapi links
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

 Documentation/ABI/testing/sysfs-class-ocxl     |  35 ++
 Documentation/accelerators/ocxl.rst            | 160 ++++++
 Documentation/ioctl/ioctl-number.txt           |   1 +
 MAINTAINERS                                    |  12 +
 arch/powerpc/include/asm/opal-api.h            |   5 +-
 arch/powerpc/include/asm/opal.h                |   6 +
 arch/powerpc/include/asm/pnv-ocxl.h            |  36 ++
 arch/powerpc/platforms/powernv/Makefile        |   1 +
 arch/powerpc/platforms/powernv/npu-dma.c       |   2 +-
 arch/powerpc/platforms/powernv/ocxl.c          | 515 ++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   3 +
 arch/powerpc/platforms/powernv/pci-ioda.c      |  54 +-
 arch/powerpc/platforms/powernv/pci.c           |   4 +
 arch/powerpc/platforms/powernv/pci.h           |   8 +-
 drivers/misc/Kconfig                           |   1 +
 drivers/misc/Makefile                          |   1 +
 drivers/misc/cxl/pci.c                         |   2 -
 drivers/misc/ocxl/Kconfig                      |  31 ++
 drivers/misc/ocxl/Makefile                     |  11 +
 drivers/misc/ocxl/afu_irq.c                    | 202 +++++++
 drivers/misc/ocxl/config.c                     | 723 +++++++++++++++++++++++++
 drivers/misc/ocxl/context.c                    | 279 ++++++++++
 drivers/misc/ocxl/file.c                       | 432 +++++++++++++++
 drivers/misc/ocxl/link.c                       | 647 ++++++++++++++++++++++
 drivers/misc/ocxl/main.c                       |  33 ++
 drivers/misc/ocxl/ocxl_internal.h              | 131 +++++
 drivers/misc/ocxl/pasid.c                      | 107 ++++
 drivers/misc/ocxl/pci.c                        | 585 ++++++++++++++++++++
 drivers/misc/ocxl/sysfs.c                      | 142 +++++
 drivers/misc/ocxl/trace.c                      |   6 +
 drivers/misc/ocxl/trace.h                      | 182 +++++++
 include/misc/ocxl-config.h                     |  45 ++
 include/misc/ocxl.h                            | 214 ++++++++
 include/uapi/misc/ocxl.h                       |  49 ++
 34 files changed, 4650 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-ocxl
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
