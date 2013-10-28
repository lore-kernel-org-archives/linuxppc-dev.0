Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 005052C0345
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 01:21:03 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rcjenn@linux.vnet.ibm.com>;
 Mon, 28 Oct 2013 19:51:02 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6FFE4E001A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 19:52:35 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9SEKtcj48889894
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 19:50:55 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9SEKvE2025653
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 19:50:57 +0530
From: Robert C Jennings <rcj@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] powerpc: Sparse fixes for numa.c
Date: Mon, 28 Oct 2013 09:20:49 -0500
Message-Id: <1382970051-8251-1-git-send-email-rcj@linux.vnet.ibm.com>
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

 arch/powerpc/include/asm/setup.h   | 4 ++++
 arch/powerpc/kernel/module.c       | 3 +--
 arch/powerpc/kernel/module_32.c    | 3 +--
 arch/powerpc/kernel/module_64.c    | 3 +--
 arch/powerpc/kernel/setup-common.c | 2 --
 arch/powerpc/kernel/setup.h        | 9 ---------
 arch/powerpc/kernel/setup_32.c     | 2 --
 arch/powerpc/kernel/setup_64.c     | 2 --
 arch/powerpc/kernel/vdso.c         | 3 +--
 arch/powerpc/mm/numa.c             | 8 ++++----
 10 files changed, 12 insertions(+), 27 deletions(-)
 delete mode 100644 arch/powerpc/kernel/setup.h

-- 
1.8.1.2
