Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B74521A033F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 05:36:05 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 24 Sep 2015 15:36:01 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DB8B8C90045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 15:27:01 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8OJZoC050987088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 19:35:58 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8OJZOgZ024378
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 15:35:25 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 00/32] cxlflash: Miscellaneous bug fixes and corrections
Date: Thu, 24 Sep 2015 14:33:13 -0500
Message-Id: <1443123193-16498-1-git-send-email-mrochs@linux.vnet.ibm.com>
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

v3 Changes:
- Rebased the series on top of patch by Dan Carpenter ("a couple off...")
- Incorporate comments from David Laight
- Incorporate comments from Tomas Henzl
- Incorporate comments from Brian King
- Removed patch to stop interrupt processing on remove
- Removed double scsi_device_put() from "Fix potential oops"
- Fixed usage of scnprintf() in "Refine host/device attributes"
- Removed unnecessary parenthesis from "Fix read capacity timeout"
- Added patch to use correct operator for doubling delay
- Changed location of cancel_work_sync() in "Fix to prevent workq..."
- Removed local mutex from cxlflash_afu_sync() in "Fix to avoid state..."
- Added patch to correctly identify a failed function in a trace
- Added patch to fix a fops corruption bug

v2 Changes:
- Incorporate comments from Ian Munsie
- Rework commit messages to be more descriptive
- Add state change serialization patch

Manoj Kumar (4):
  cxlflash: Fix to avoid invalid port_sel value
  cxlflash: Replace magic numbers with literals
  cxlflash: Fix read capacity timeout
  cxlflash: Fix to double the delay each time

Matthew R. Ochs (28):
  cxlflash: Fix potential oops following LUN removal
  cxlflash: Fix data corruption when vLUN used over multiple cards
  cxlflash: Fix to avoid sizeof(bool)
  cxlflash: Fix context encode mask width
  cxlflash: Fix to avoid CXL services during EEH
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
  cxlflash: Fix to avoid corrupting adapter fops
  cxlflash: Correct trace string

 MAINTAINERS                       |    9 +
 drivers/scsi/cxlflash/common.h    |   30 +-
 drivers/scsi/cxlflash/lunmgt.c    |    9 +-
 drivers/scsi/cxlflash/main.c      | 1572 ++++++++++++++++++++-----------------
 drivers/scsi/cxlflash/main.h      |    1 +
 drivers/scsi/cxlflash/sislite.h   |    8 +-
 drivers/scsi/cxlflash/superpipe.c |  182 +++--
 drivers/scsi/cxlflash/superpipe.h |   11 +-
 drivers/scsi/cxlflash/vlun.c      |   39 +-
 9 files changed, 1028 insertions(+), 833 deletions(-)

-- 
2.1.0
