Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A59EF2C073E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 15:24:04 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 15 Aug 2013 01:24:01 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2AB566E803A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 01:23:53 -0400 (EDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7F5Nwej193952
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 01:23:58 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7F5Nvfr015102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:23:58 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/8] powerpc/pseries: fix/cleanup broken mobility device-tree
 update code
Date: Wed, 14 Aug 2013 22:23:44 -0700
Message-Id: <1376544232-24936-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we still perform updating of the device tree after a suspend or
migration from drmgr in userspace through the ugly /proc/ppc64/ofdt interface.
Code exists to do this update from within the kernel, but testing revealed it
to be severely broken to the point that the system hardlocks up stuck in an
infinite loop with irqs disabled.

The first 4 patches in the series fix several issues encountered tyring to
perform node property updates as dictated by the ibm,update-properties rtas
call. The next 2 patches refactor the logic of dlpar_configure_connector to
enusre that nodes created in a device nodes subtree are initialized
correctly. The remainder of the patchset fixes a couple problems with node
removal.

Tyrel Datwyler (8):
  powerpc/pseries: fix creation of loop in device node property list
  powerpc/pseries: fix over writing of rtas return code in
    update_dt_node
  powerpc/pseries: pack update_props_workarea to map correctly to rtas
    buffer header
  powerpc/pseries: fix parsing of initial node path in update_dt_node
  powerpc/pseries: do all node initialization in dlpar_parse_cc_node
  powerpc/pseries: make dlpar_configure_connector parent node aware
  powerpc/pseries: add mising of_node_put in delete_dt_node
  powerpc/pseries: child nodes are not detached by dlpar_detach_node

 arch/powerpc/platforms/pseries/dlpar.c    | 67 ++++++++++++++++++-------------
 arch/powerpc/platforms/pseries/mobility.c | 45 ++++++++++-----------
 arch/powerpc/platforms/pseries/pseries.h  |  2 +-
 3 files changed, 62 insertions(+), 52 deletions(-)

-- 
1.7.12.4
