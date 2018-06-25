Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41DvdD5PkFzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 02:24:16 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5PGO1oK092804
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 12:24:13 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ju322te1v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 12:24:12 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 25 Jun 2018 17:24:11 +0100
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: alastair@au1.ibm.com, andrew.donnellan@au1.ibm.com, vaibhav@linux.ibm.com,
 clombard@linux.ibm.com, felix@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: huyn@mellanox.com
Subject: [PATCH 00/10] cxl: Remove abandonned capi support for the Mellanox CX4
Date: Mon, 25 Jun 2018 18:23:56 +0200
Message-Id: <20180625162406.10813-1-fbarrat@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An attempt was made to add capi support for the Mellanox CX4 card, so
that it could operate in "traditional" PCI mode or capi mode. The
project ended up being canceled and a different approach was taken for
CX5. Mellanox never upstreamed any capi support in their CX4 driver.

CX4 was not following exactly the CAIA 1.0 model, so some CX4-specific
code was added. That code is now dead and hasn't been tested for a
while, so it's probably broken anyway. Let's remove it. It has been
agreed with engineers at Mellanox, of course.

No user API is affected. Some (unused) symbols exported by cxl are removed.

Most of the patch set consists of reverts of older patches, with
sometimes very minor tweaking. The last patch aggregates a few changes
where reverting was not possible easily.

Tests run to prevent regressions:
-  memcpy tests on POWER8 and POWER9
-  Mellanox CX5, which uses a different code path, based on cxllib
-  cxlflash tests on POWER8


Alastair D'Silva (7):
  Revert "cxl: Add kernel API to allow a context to operate with
    relocate disabled"
  Revert "cxl: Add support for interrupts on the Mellanox CX4"
  Revert "cxl: Add preliminary workaround for CX4 interrupt limitation"
  Revert "cxl: Add kernel APIs to get & set the max irqs per context"
  Revert "cxl: Add cxl_check_and_switch_mode() API to switch bi-modal
    cards"
  Revert "cxl: Add support for using the kernel API with a real PHB"
  Revert "powerpc/powernv: Add support for the cxl kernel api on the
    real phb"

Frederic Barrat (3):
  Revert "cxl: Add cxl_slot_is_supported API"
  Revert "cxl: Allow a default context to be associated with an external
    pci_dev"
  cxl: Remove abandonned capi support for the Mellanox CX4, final
    cleanup

 arch/powerpc/include/asm/pnv-pci.h        |   7 -
 arch/powerpc/platforms/powernv/pci-cxl.c  | 199 ------------
 arch/powerpc/platforms/powernv/pci-ioda.c |  22 +-
 arch/powerpc/platforms/powernv/pci.h      |  15 -
 drivers/misc/cxl/Kconfig                  |   8 -
 drivers/misc/cxl/Makefile                 |   2 +-
 drivers/misc/cxl/api.c                    | 132 --------
 drivers/misc/cxl/base.c                   |  83 -----
 drivers/misc/cxl/context.c                |   3 +-
 drivers/misc/cxl/cxl.h                    |  33 --
 drivers/misc/cxl/debugfs.c                |   5 -
 drivers/misc/cxl/guest.c                  |   3 -
 drivers/misc/cxl/main.c                   |   5 -
 drivers/misc/cxl/native.c                 |   3 +-
 drivers/misc/cxl/pci.c                    | 351 ++--------------------
 drivers/misc/cxl/phb.c                    |  44 ---
 drivers/misc/cxl/vphb.c                   |  46 +--
 include/misc/cxl-base.h                   |  10 -
 include/misc/cxl.h                        |  68 -----
 19 files changed, 58 insertions(+), 981 deletions(-)
 delete mode 100644 drivers/misc/cxl/phb.c

-- 
2.17.1
