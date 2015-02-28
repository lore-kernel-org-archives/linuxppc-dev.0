Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4B421A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2015 13:25:00 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 27 Feb 2015 19:24:58 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 66CAF19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 19:16:03 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1S2OrWQ42795194
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 19:24:53 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1S2Osqq025302
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 19:24:54 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] powerpc/pseries: Fixes and cleanup of suspend/migration
 code
Date: Fri, 27 Feb 2015 18:24:40 -0800
Message-Id: <1425090283-27694-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, cyrilbur@gmail.com,
 nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset simplifies the usage of rtas_ibm_suspend_me() by removing an
extraneous function parameter, fixes device tree updating on little endian
platforms, and adds a mechanism for informing drmgr that the kernel is cabable of
performing the whole migration including device tree update itself.

Tyrel Datwyler (3):
  powerpc/pseries: Simplify check for suspendability during
    suspend/migration
  powerpc/pseries: Little endian fixes for post mobility device tree
    update
  powerpc/pseries: Expose post-migration in kernel device tree update
    to drmgr

 arch/powerpc/include/asm/rtas.h           |  2 +-
 arch/powerpc/kernel/rtas.c                | 15 ++++-----
 arch/powerpc/platforms/pseries/mobility.c | 55 ++++++++++++++++++-------------
 3 files changed, 40 insertions(+), 32 deletions(-)

-- 
1.7.12.2
