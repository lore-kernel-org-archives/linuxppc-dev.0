Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AA8E52C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 07:59:17 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 19 Feb 2014 15:59:15 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0458A38C804D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 15:59:12 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1JKxBAK9502998
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 20:59:11 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1JKv5ag015675
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 15:57:05 -0500
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v4 0/3] powerpc/pseries: fix issues in suspend/resume code 
Date: Wed, 19 Feb 2014 12:56:51 -0800
Message-Id: <1392843415-17153-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset fixes a couple of issues encountered in the suspend/resume code
base. First when using the kernel device tree update code update-nodes is
unnecessarily called more than once. Second the cpu cache lists are not
updated after a suspend/resume which under certain conditions may cause a
panic. Finally, since the cache list fix utilzes in kernel device tree update
code a means for telling drmgr that updating the device tree from userspace
is unnecessary.

Changes from v3:
- Updated patch descriptions to better reflect the behavior/interface changes
  and why they are acceptable per Ben's concerns.

Changes from v2:
- Moved dynamic configuration update code into pseries specific routine
  per Nathan's suggestion.

Changes from v1:
- Fixed several commit message typos
- Fixed authorship of first two patches

Haren Myneni (2):
  powerpc/pseries: Device tree should only be updated once after
    suspend/migrate
  powerpc/pseries: Update dynamic cache nodes for suspend/resume
    operation

Tyrel Datwyler (1):
  powerpc/pseries: Report in kernel device tree update to drmgr

 arch/powerpc/include/asm/rtas.h           |  1 +
 arch/powerpc/platforms/pseries/mobility.c | 26 +++++++-----------
 arch/powerpc/platforms/pseries/suspend.c  | 44 ++++++++++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 17 deletions(-)

-- 
1.7.12.2
