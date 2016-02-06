Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 978061A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Feb 2016 00:29:14 +1100 (AEDT)
Received: from localhost
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Sat, 6 Feb 2016 13:29:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 705332190023
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 13:28:53 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u16DT7l963635624
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 6 Feb 2016 13:29:07 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u16DT6Xu004073
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 6 Feb 2016 06:29:06 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: =?UTF-8?q?=5BPATCH=20v3=2000/18=5D=20cxl=3A=20Add=20support=20for=20powerVM=20guest=E2=80=8B?=
Date: Sat,  6 Feb 2016 14:28:47 +0100
Message-Id: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds support for a CAPI card in a powerVM guest.

It requires firmware FW840 and an activation code for CAPI.

Note that pHyp only claims support for cxlflash, and not generic
support for FPGA CAPI accelerators. cxlflash uses the (slightly
modified) Nallatech card, so the memcopy AFU is expected to
work. There's no support for the dedicated mode programming model.

It builds on top of the existing cxl driver for bare-metal. The cxl
module registers either a pci driver or a platform driver, based on
the environment (bare-metal or guest).

The differences in implementation have mostly 2 root causes:
1/ The CAPI card is not showing as a PCI device in the device tree
over pHyp. Instead, it is a new type of device found at the root of
the device tree. The AFU description(s) can be found in subfolder(s)
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
Patches 4-8 restructure existing code, to easily add the guest
implementation
Patches 9,10 define the interactions with pHyp
Patch 11 prepares the main data structures, separating common and
implementation-specific fields
Patch 12 introduces the core of the guest-specific code
The rest adds smaller, independent changes to better support guests:
sysfs, kernel API, flash of the adapter and failure handling, ...


Changelog:
v2->v3:
 - comment from Ian: external_pe is now an integer
 - add patch 3: the problem state is only defined at attach time
   when using the kernel API, not during context initialization
 - add patch 18: add tracepoints around CAPI hcalls for debugging
v1->v2: (v1 was privately reviewed)
 - integrate comments from Michael Neuling and Ian Munsie
 - add another patch to the series: adapter failure handling
 - base patchset on 4.5-rc1


Frederic Barrat (18):
  cxl: Move common code away from bare-metal-specific files
  cxl: Move bare-metal specific code to specialized files
  cxl: Define process problem state area at attach time only
  cxl: Introduce implementation-specific API
  cxl: Rename some bare-metal specific functions
  cxl: Isolate a few bare-metal-specific calls
  cxl: Update cxl_irq() prototype
  cxl: IRQ allocation for guests
  cxl: New possible return value from hcall
  cxl: New hcalls to support CAPI adapters
  cxl: Separate bare-metal fields in adapter and AFU data structures
  cxl: Add guest-specific code
  cxl: sysfs support for guests
  cxl: Support to flash a new image on the adapter from a guest
  cxl: Parse device tree and create CAPI device(s) at boot
  cxl: Support the cxl kernel API from a guest
  cxl: Adapter failure handling
  cxl: Add tracepoints around the CAPI hcall

 Documentation/ABI/testing/sysfs-class-cxl |    8 +-
 Documentation/powerpc/cxl.txt             |   60 ++
 arch/powerpc/include/asm/hvcall.h         |    1 +
 drivers/misc/cxl/Makefile                 |    1 +
 drivers/misc/cxl/api.c                    |   76 +-
 drivers/misc/cxl/base.c                   |   32 +
 drivers/misc/cxl/context.c                |   11 +-
 drivers/misc/cxl/cxl.h                    |  288 ++++---
 drivers/misc/cxl/debugfs.c                |    4 +
 drivers/misc/cxl/fault.c                  |   25 +-
 drivers/misc/cxl/file.c                   |   28 +-
 drivers/misc/cxl/flash.c                  |  515 +++++++++++++
 drivers/misc/cxl/guest.c                  | 1168 +++++++++++++++++++++++++++++
 drivers/misc/cxl/hcalls.c                 |  640 ++++++++++++++++
 drivers/misc/cxl/hcalls.h                 |  203 +++++
 drivers/misc/cxl/irq.c                    |  300 ++------
 drivers/misc/cxl/main.c                   |   91 ++-
 drivers/misc/cxl/native.c                 |  468 ++++++++++--
 drivers/misc/cxl/of.c                     |  529 +++++++++++++
 drivers/misc/cxl/pci.c                    |  249 +++---
 drivers/misc/cxl/sysfs.c                  |   70 +-
 drivers/misc/cxl/trace.h                  |  193 +++++
 drivers/misc/cxl/vphb.c                   |  158 ++--
 include/misc/cxl.h                        |    5 +
 24 files changed, 4410 insertions(+), 713 deletions(-)
 create mode 100644 drivers/misc/cxl/flash.c
 create mode 100644 drivers/misc/cxl/guest.c
 create mode 100644 drivers/misc/cxl/hcalls.c
 create mode 100644 drivers/misc/cxl/hcalls.h
 create mode 100644 drivers/misc/cxl/of.c

-- 
1.9.1
