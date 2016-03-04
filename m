Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D35D1A045E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 22:26:52 +1100 (AEDT)
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 11:26:49 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2F60E17D8042
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:27:12 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24BQkat459146
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 11:26:46 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24BQjq6006938
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 04:26:46 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 00/20] cxl: Add support for powerVM guest
Date: Fri,  4 Mar 2016 12:26:24 +0100
Message-Id: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds support for a cxl card in a powerVM guest.

It requires firmware FW840 and an activation code for cxl (CAPI).
Note that pHyp only claims support for cxlflash, and not generic
support for FPGA CAPI accelerators. cxlflash uses the (slightly
modified) Nallatech card, so the memcopy AFU is expected to
work. There's no support for the dedicated mode programming model.

It builds on top of the existing cxl driver for bare-metal. The cxl
module registers either a pci driver or a platform driver, based on
the environment (bare-metal or guest).

The differences in implementation have mostly 2 root causes:
1/ The cxl card is not showing as a PCI device in the device tree over
pHyp. Instead, it is a new type of device found at the root of the
device tree. The AFU description(s) can be found in subfolder(s)
2/ When interacting with the card, the operating system doesn't have
access to the p1 registers, which are the most privileged and reserved
for the hypervisor. It can theoretically access the p2 registers,
though there are hcalls defined for most cases. We only rely on p2
registers for SLB invalidation, for which there is no hcall.

The interactions with the hypervisor are defined in an extension of
the PAPR.

Roughly 3/4 of the code is common between the 2 types of driver. When
the code needs to call a platform-specific implementation, it does so
through an API. The bare-metal and guest implementations each describe
their own definition. See struct cxl_backend_ops.

It has been tested in little-endian and big-endian environments, using
the memcpy and cxlflash AFUs.

The first 3 patches are mostly cleanup and fixes, separating the
bare-metal-specific code from the code which will also be used in a
guest.
Patches 4-8 restructure existing code, to easily add the guest implementation
Patches 9,10 define the interactions with pHyp
Patch 11 prepares the main data structures, separating common and
implementation-specific fields
Patch 12 introduces the core of the guest-specific code
The rest adds smaller, independent changes to better support guests:
sysfs, kernel API, flash of the adapter and failure handling, ...




Changelog:
v5->v6:
 - address comments from v5
     remove useless memset (patch 14, Manoj)
     make sure cxl_adapter_image's size is constant (patch 14, Ian)
     fix prefix in commit header (patch 9, Mikey)
 - fix problem in sysfs (patch 13):
     pp_mmio_off is not available on powerVM, so hide it there
 - add patch to have cxlflash use the new cxl_read_adapter_vpd() API
     agreed with/tested by cxlflash team
 - add patch to remove cxl_get_phys_dev() kernel API
v4->v5:
 Address comments from Manoj
 - prefer the term 'cxl' over 'capi' throughout the patchset
 - fix some typos in comments and commit messages
 - fix a couple of Coding Style issues
v3->v4:
 Address comments from Ian:
 - patch 3: cxl_psa_map() now fails immediately if context is not attached
 - patch 5: rephrase commit message
 - patch 8: add better comment
 - patch 10: improve pr_devel traces
 - patch 11: rework some error paths
 - patch 12: improve debug traces
 - patch 14: (big) rework of the user API for adapter device
 - patch 16: return EPERM instead of EIO
v2->v3:
 - comment from Ian: external_pe is now an integer
 - add patch 3: the problem state is only defined at attach time when
   using the kernel API, not during context initialization
 - add patch 18: add tracepoints around CAPI hcalls for debugging
v1->v2: (v1 was privately reviewed)
 - integrate comments from Michael Neuling and Ian Munsie
 - add another patch to the series: adapter failure handling
 - base patchset on 4.5-rc1



  cxl: Move common code away from bare-metal-specific files
  cxl: Move bare-metal specific code to specialized files
  cxl: Define process problem state area at attach time only
  cxl: Introduce implementation-specific API
  cxl: Rename some bare-metal specific functions
  cxl: Isolate a few bare-metal-specific calls
  cxl: Update cxl_irq() prototype
  cxl: IRQ allocation for guests
  powerpc: New possible return value from hcall
  cxl: New hcalls to support cxl adapters
  cxl: Separate bare-metal fields in adapter and AFU data structures
  cxl: Add guest-specific code
  cxl: sysfs support for guests
  cxl: Support to flash a new image on the adapter from a guest
  cxl: Parse device tree and create cxl device(s) at boot
  cxl: Support the cxl kernel API from a guest
  cxl: Adapter failure handling
  cxl: Add tracepoints around the cxl hcall
  cxlflash: Use new cxl_pci_read_adapter_vpd() API
  cxl: Remove cxl_get_phys_dev() kernel API

 Documentation/ABI/testing/sysfs-class-cxl |   10 +-
 Documentation/powerpc/cxl.txt             |   55 ++
 arch/powerpc/include/asm/hvcall.h         |    1 +
 drivers/misc/cxl/Makefile                 |    1 +
 drivers/misc/cxl/api.c                    |   83 +-
 drivers/misc/cxl/base.c                   |   32 +
 drivers/misc/cxl/context.c                |   11 +-
 drivers/misc/cxl/cxl.h                    |  286 ++++---
 drivers/misc/cxl/debugfs.c                |    4 +
 drivers/misc/cxl/fault.c                  |   25 +-
 drivers/misc/cxl/file.c                   |   28 +-
 drivers/misc/cxl/flash.c                  |  538 +++++++++++++
 drivers/misc/cxl/guest.c                  | 1177 +++++++++++++++++++++++++++++
 drivers/misc/cxl/hcalls.c                 |  648 ++++++++++++++++
 drivers/misc/cxl/hcalls.h                 |  203 +++++
 drivers/misc/cxl/irq.c                    |  309 ++------
 drivers/misc/cxl/main.c                   |  117 ++-
 drivers/misc/cxl/native.c                 |  469 ++++++++++--
 drivers/misc/cxl/of.c                     |  513 +++++++++++++
 drivers/misc/cxl/pci.c                    |  262 +++----
 drivers/misc/cxl/sysfs.c                  |  123 ++-
 drivers/misc/cxl/trace.h                  |  193 +++++
 drivers/misc/cxl/vphb.c                   |  158 ++--
 drivers/scsi/cxlflash/common.h            |    1 -
 drivers/scsi/cxlflash/main.c              |   18 +-
 include/misc/cxl.h                        |    8 +-
 include/uapi/misc/cxl.h                   |   24 +
 27 files changed, 4540 insertions(+), 757 deletions(-)
 create mode 100644 drivers/misc/cxl/flash.c
 create mode 100644 drivers/misc/cxl/guest.c
 create mode 100644 drivers/misc/cxl/hcalls.c
 create mode 100644 drivers/misc/cxl/hcalls.h
 create mode 100644 drivers/misc/cxl/of.c

-- 
1.9.1
