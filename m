Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 452BF1A09D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:44:50 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 19 Mar 2015 14:44:48 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 39B8D357804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:44:46 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2J4ibYA22806732
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:44:46 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2J4iCsP031733
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:44:12 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 0/3] powerpc/tm: Abort syscalls in active transactions
Date: Thu, 19 Mar 2015 15:43:45 +1100
Message-Id: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
Cc: mikey@neuling.org, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


See the first patch for a description of the reasoning behind this
change.

This set includes the change, a kernel selftest for it and
some slight refactoring of the selftest code.


Sam Bobroff (3):
  powerpc/tm: Abort syscalls in active transactions
  selftests/powerpc: Move get_auxv_entry() to harness.c
  selftests/powerpc: Add transactional syscall test

 Documentation/powerpc/transactional_memory.txt  |   33 +++----
 arch/powerpc/include/uapi/asm/tm.h              |    2 +-
 arch/powerpc/kernel/entry_64.S                  |   19 ++++
 tools/testing/selftests/powerpc/harness.c       |   47 ++++++++++
 tools/testing/selftests/powerpc/pmu/lib.c       |   47 ----------
 tools/testing/selftests/powerpc/pmu/lib.h       |    1 -
 tools/testing/selftests/powerpc/tm/Makefile     |    3 +-
 tools/testing/selftests/powerpc/tm/tm-syscall.c |  113 +++++++++++++++++++++++
 tools/testing/selftests/powerpc/utils.h         |    2 +-
 9 files changed, 200 insertions(+), 67 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-syscall.c

-- 
1.7.10.4
