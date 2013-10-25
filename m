Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8105C2C0141
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 06:25:22 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rcjenn@linux.vnet.ibm.com>;
 Sat, 26 Oct 2013 00:55:17 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id CE4021258051
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 00:55:49 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9PJP9k636307158
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 00:55:10 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9PJPCX2003720
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 00:55:12 +0530
From: Robert C Jennings <rcj@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] powerpc: Sparse fixes for numa.c
Date: Fri, 25 Oct 2013 14:25:05 -0500
Message-Id: <1382729107-13560-1-git-send-email-rcj@linux.vnet.ibm.com>
Cc: Robert C Jennings <rcj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cleaning out some stashed fixes for sparse warnings found while
working on 3be7db6: (powerpc: VPHN topology change updates all siblings)

I don't see a reason why the declarations in arch/powerpc/kernel/setup.h
can't live in arch/powerpc/include/asm/setup.h and .../mm/numa.c
should include these definitions.

Robert C Jennings (2):
  powerpc: Fix warnings for arch/powerpc/mm/numa.c
  powerpc: Move local setup.h declarations to arch includes

 arch/powerpc/include/asm/setup.h   | 5 +++++
 arch/powerpc/kernel/module.c       | 3 +--
 arch/powerpc/kernel/module_32.c    | 3 +--
 arch/powerpc/kernel/module_64.c    | 3 +--
 arch/powerpc/kernel/setup-common.c | 2 --
 arch/powerpc/kernel/setup.h        | 9 ---------
 arch/powerpc/kernel/setup_32.c     | 2 --
 arch/powerpc/kernel/setup_64.c     | 2 --
 arch/powerpc/kernel/vdso.c         | 3 +--
 arch/powerpc/mm/numa.c             | 8 ++++----
 10 files changed, 13 insertions(+), 27 deletions(-)
 delete mode 100644 arch/powerpc/kernel/setup.h

-- 
1.8.1.2
