Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E67951A01B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:26 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 16 Jul 2014 15:50:26 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 322E33578057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6G5RcXM65994836
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:27:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6G5oLnW024762
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:21 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] EEH Cleanup
Date: Wed, 16 Jul 2014 15:50:13 +1000
Message-Id: <1405489819-26211-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patchset is EEH cleanup and expected to be merged during 3.17
window. The the patchset is expected to be applied after:

   |    EEH support for guest
   |    2 more bug fixes for EEH support for guest
   |    M64 related EEH changes
   |    2 bug fixes from Mike Qiu
   |
   +->  The current patchset

Except the following 2 patches, all patches are for cleanup:
Refactoring EEH log, replacing pr_warning() with pr_warn(),
reducing length of EEH log dump etc:

PATCH[2/6]: We have to enable I/O path before collecting EEH log.
            Otherwise, 0xFF is always returned from PCI config
            of devices in frozen PE. the problem is only existing
            on PHB3.
PATCH[6/6]: It's something related to EEH guest log retrieval.
	    Currently, all PEs in one specific PHB are sharing
	    diag-data blob for storing EEH log. It's possible
	    for diag-data blob overwritten before being collected
            by guest. The patch introduce auxillary data for PE,
            which is maintained by backend. On PowerNV, that's used
            for EEH log.

Gavin Shan (6):
  powerpc/eeh: Refactor EEH flag accessors
  powerpc/eeh: Selectively enable IO for error log
  powerpc/eeh: Reduce lines of log dump
  powerpc/eeh: Replace pr_warning() with pr_warn()
  powerpc/eeh: Make diag-data not endian dependent
  powerpc/eeh: Aux PE data for error log

 arch/powerpc/include/asm/eeh.h               |  43 ++++-----
 arch/powerpc/include/asm/opal.h              | 128 +++++++++++++--------------
 arch/powerpc/kernel/eeh.c                    |  73 ++++++++++-----
 arch/powerpc/kernel/eeh_cache.c              |   9 +-
 arch/powerpc/kernel/eeh_dev.c                |   3 +-
 arch/powerpc/kernel/eeh_driver.c             |  16 ++--
 arch/powerpc/kernel/eeh_pe.c                 |  29 +++++-
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 103 +++++++++++++--------
 arch/powerpc/platforms/powernv/eeh-powernv.c |  32 +++++--
 arch/powerpc/platforms/powernv/pci-ioda.c    |   1 -
 arch/powerpc/platforms/powernv/pci.c         |  68 ++++++++------
 arch/powerpc/platforms/pseries/eeh_pseries.c |  32 +++----
 12 files changed, 323 insertions(+), 214 deletions(-)

-- 
1.8.3.2
