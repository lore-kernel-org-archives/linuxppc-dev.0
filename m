Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsvbX41c6zDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 02:14:49 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2SFE6IU113860
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 11:14:42 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29fsrejk1p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 11:14:42 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 28 Mar 2017 16:14:40 +0100
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH V3 0/7] cxl: Add support for Coherent Accelerator Interface
 Architecture 2.0
Date: Tue, 28 Mar 2017 17:14:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1490714052-18902-1-git-send-email-clombard@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds support for a cxl card which supports the Coherent
Accelerator Interface Architecture 2.0.

It requires IBM Power9 system and the Power Service Layer, version 9.
The PSL provides the address translation and system memory cache for
CAIA compliant Accelerators.
the PSL attaches to the IBM Processor chip through the PCIe link using
the PSL-specific “CAPI Protocol” Transaction Layer Packets.
The PSL and CAPP communicate using PowerBus packets. 
When using a PCIe link the PCIe Host Bridge (PHB) decodes the CAPI
Protocol Packets from the PSL and forwards them as PowerBus data
packets. The PSL also has an optional DMA feature which allows the AFU
to send native PCIe reads and writes to the Processor.

CAIA 2 introduces new features: 
* There are several similarities among the two programming models:
Dedicated-Process and shared models.
* DMA support
* Nest MMU to handle translation addresses.
* ...

It builds on top of the existing cxl driver for the first version of
CAIA. Today only the bare-metal environment supports these new features.

Compatibility with the CAIA, version 1, allows applications and system
software to migrate from one implementation to another with minor
changes.
Most of the differences are:
* Power Service Layer registers: p1 and p2 registers. These new
registers require reworking The service layer API (in cxl.h).
* Support of Radix mode. Power9 consist of multiple memory management
model. So we need to select the right Translation mechanism mode.
* Dedicated-Shared Process Programming Model
* Process element entry. Structure cxl_process_element_common is
redefined.
* Translation Fault Handling. Only a page fault is now handle by the
driver cxl when a translation fault is occured. 

Roughly 3/4 of the code is common between the two CAIA version. When
the code needs to call a specific implementation, it does so
through an API. The PSL8 and PSL9 implementations each describe
their own definition. See struct cxl_service_layer_ops.

The first 3 patches are mostly cleanup and fixes, separating the
psl8-specific code from the code which will also be used for psl9.
Patches 4 restructure existing code, to easily add the psl
implementation.
Patch 5 and 6 rename and isolate implementation-specific code.
Patch 7 introduces the core of the PSL9-specific code.

Tested on Simulation environment.

Changelog[v3]
 - Rebase to latest upstream.
 - Integrate comments from Andrew Donnellan and Frederic Barrat.
 - patch2: - Rename pid and tid to "reserved" in the struct cxl_irq_info.
 - patch3: - Update commit message.
	   - Reset ctx->mm to NULL.
	   - Simplify slightly the function _cxl_slbia() using the mm
	     associated to a context.
	   - Remove cxl_context_mm_users_get().
 - patch4: - Some prototypes are not supposed to depend on CONFIG_DEBUG_FS.
 - patch6: - Regroup the sste_lock and sst alloc under the same "if"
	     statement. 
 - patch7: - New functions to cover page fault and segment miss.
	   - Rework the code to avoid duplication.
	   - Add a new parameter for the function cxl_alloc_spa().
	   - Invalidation of all ERAT entries is no longer required by
	     CAIA2.
	   - Keep original version of cxl_native_register_serr_irq().
	   - ASB_Notify messages and Non-Blocking queues not supported
	     on DD1.
	   - Change the allocation of the apc machines.

Changelog[v2]
 - Rebase to latest upstream.
 - Integrate comments from Andrew Donnellan and Frederic Barrat.


Christophe Lombard (7):
  cxl: Read vsec perst load image
  cxl: Remove unused values in bare-metal environment.
  cxl: Keep track of mm struct associated with a context
  cxl: Update implementation service layer
  cxl: Rename some psl8 specific functions
  cxl: Isolate few psl8 specific calls
  cxl: Add psl9 specific code

 drivers/misc/cxl/api.c     |  17 ++-
 drivers/misc/cxl/context.c |  65 +++++++--
 drivers/misc/cxl/cxl.h     | 240 ++++++++++++++++++++++++------
 drivers/misc/cxl/debugfs.c |  41 ++++--
 drivers/misc/cxl/fault.c   | 136 ++++++-----------
 drivers/misc/cxl/file.c    |  15 +-
 drivers/misc/cxl/guest.c   |  10 +-
 drivers/misc/cxl/hcalls.c  |   4 +-
 drivers/misc/cxl/irq.c     |  55 ++++++-
 drivers/misc/cxl/main.c    |  12 +-
 drivers/misc/cxl/native.c  | 312 +++++++++++++++++++++++++++++++++------
 drivers/misc/cxl/pci.c     | 356 ++++++++++++++++++++++++++++++++++++++-------
 drivers/misc/cxl/trace.h   |  43 ++++++
 13 files changed, 1023 insertions(+), 283 deletions(-)

-- 
2.7.4
