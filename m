Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 39A592C0099
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 10:02:55 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 21 Jan 2014 16:02:52 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 76CF21FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 16:02:18 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0LN2a208389036
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 00:02:36 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0LN2nER012197
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 16:02:50 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] powerpc/pseries: fix issues in suspend/resume code
Date: Tue, 21 Jan 2014 17:55:46 -0500
Message-Id: <1390344949-3983-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com
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

Tyrel Datwyler (3):
  powerpc/pseries: Device tree should only be updated once after
    suspend/migrate
  powerpc/pseries: Update dynamic cache nodes for suspend/resume
    operation
  powerpc/pseries: Report in kernel device tree update to drmgr

 arch/powerpc/include/asm/rtas.h           |  4 ++++
 arch/powerpc/kernel/rtas.c                | 17 +++++++++++++++++
 arch/powerpc/kernel/time.c                |  6 ++++++
 arch/powerpc/platforms/pseries/mobility.c | 26 ++++++++++----------------
 arch/powerpc/platforms/pseries/suspend.c  | 25 ++++++++++++++++++++++++-
 5 files changed, 61 insertions(+), 17 deletions(-)

-- 
1.7.12.4
