Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 86FF72C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 07:06:13 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 22 Jan 2014 13:06:10 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C5BB019D8051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 13:05:57 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0MK5q1d50987078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 21:05:52 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0MK65gQ012344
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 13:06:06 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/3] powerpc/pseries: fix issues in suspend/resume code
Date: Wed, 22 Jan 2014 14:58:34 -0500
Message-Id: <1390420717-23907-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
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
code a means for telling drmgr not to perform a device tree update from
userspace is required.

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

 arch/powerpc/include/asm/rtas.h           |  4 ++++
 arch/powerpc/kernel/rtas.c                | 17 +++++++++++++++++
 arch/powerpc/kernel/time.c                |  6 ++++++
 arch/powerpc/platforms/pseries/mobility.c | 26 ++++++++++----------------
 arch/powerpc/platforms/pseries/suspend.c  | 25 ++++++++++++++++++++++++-
 5 files changed, 61 insertions(+), 17 deletions(-)

-- 
1.7.12.4
