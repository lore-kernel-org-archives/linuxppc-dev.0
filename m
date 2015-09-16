Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52DCC1A035C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 07:24:45 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 17:24:42 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 09F6538C805C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 17:24:40 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8GLOdVb53346414
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 21:24:40 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8GLOdj1005067
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 17:24:39 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 00/30] cxlflash: Miscellaneous bug fixes and corrections
Date: Wed, 16 Sep 2015 16:23:55 -0500
Message-Id: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set contains various fixes and corrections for issues that
were found during test and code review. The series is based upon the
code upstreamed in 4.3 and is intended for the rc phase. The entire
set is bisectable. Please reference the changelog below for details
on what has been altered from previous versions of this patch set.

v2 Changes:
- Incorporate comments from Ian Munsie
- Rework commit messages to be more descriptive
- Add state change serialization patch

Manoj Kumar (3):
  cxlflash: Fix to avoid invalid port_sel value
  cxlflash: Replace magic numbers with literals
  cxlflash: Fix read capacity timeout

Matthew R. Ochs (27):
  cxlflash: Fix potential oops following LUN removal
  cxlflash: Fix data corruption when vLUN used over multiple cards
  cxlflash: Fix to avoid sizeof(bool)
  cxlflash: Fix context encode mask width
  cxlflash: Fix to avoid CXL services during EEH
  cxlflash: Check for removal when processing interrupt
  cxlflash: Correct naming of limbo state and waitq
  cxlflash: Make functions static
  cxlflash: Refine host/device attributes
  cxlflash: Fix to avoid spamming the kernel log
  cxlflash: Fix to avoid stall while waiting on TMF
  cxlflash: Fix location of setting resid
  cxlflash: Fix host link up event handling
  cxlflash: Fix async interrupt bypass logic
  cxlflash: Remove dual port online dependency
  cxlflash: Fix AFU version access/storage and add check
  cxlflash: Correct usage of scsi_host_put()
  cxlflash: Fix to prevent workq from accessing freed memory
  cxlflash: Correct behavior in device reset handler following EEH
  cxlflash: Remove unnecessary scsi_block_requests
  cxlflash: Fix function prolog parameters and return codes
  cxlflash: Fix MMIO and endianness errors
  cxlflash: Fix to prevent EEH recovery failure
  cxlflash: Correct spelling, grammar, and alignment mistakes
  cxlflash: Fix to prevent stale AFU RRQ
  cxlflash: Fix to avoid state change collision
  MAINTAINERS: Add cxlflash driver

 MAINTAINERS                       |    9 +
 drivers/scsi/cxlflash/common.h    |   29 +-
 drivers/scsi/cxlflash/lunmgt.c    |    9 +-
 drivers/scsi/cxlflash/main.c      | 1575 ++++++++++++++++++++-----------------
 drivers/scsi/cxlflash/main.h      |    1 +
 drivers/scsi/cxlflash/sislite.h   |    8 +-
 drivers/scsi/cxlflash/superpipe.c |  177 +++--
 drivers/scsi/cxlflash/superpipe.h |   11 +-
 drivers/scsi/cxlflash/vlun.c      |   39 +-
 9 files changed, 1036 insertions(+), 822 deletions(-)

-- 
2.1.0
