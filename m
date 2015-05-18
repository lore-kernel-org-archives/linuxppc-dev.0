Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B3911A04EF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 20:56:26 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 18 May 2015 16:26:23 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1A057E0069
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 16:29:25 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4IAuHTa63045648
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 16:26:17 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4IAFLSH026083
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 15:45:21 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 00/13] POWER DSCR fixes, improvements, docs and tests
Date: Mon, 18 May 2015 16:26:03 +0530
Message-Id: <1431946576-1009-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, shuahkh@osg.samsung.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	This patch series has patches for POWER DSCR fixes, improvements,
in code documentaion, kernel support user documentation and selftest based
test cases. It has got five test cases which are derived from Anton's DSCR
test bucket which can be listed as follows.

(1) http://ozlabs.org/~anton/junkcode/dscr_default_test.c
(2) http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c
(3) http://ozlabs.org/~anton/junkcode/dscr_inherit_exec_test.c
(4) http://ozlabs.org/~anton/junkcode/dscr_inherit_test.c
(5) http://ozlabs.org/~anton/junkcode/user_dscr_test.c

NOTE1: Anton's original inherit exec test expected the child to have system
default DSCR value instead of the inherited DSCR value from it's parent.
But looks like thats not the case when we execute the test, it always
inherits it's parent's DSCR value over the exec call as well. So I have
changed the test program assuming its correct to have the inherited DSCR
value in the fork/execed child program. Please let me know if thats not
correct and I am missing something there.

Changes in V4:
- Restoring the system DSCR default value in test cases before exiting
- Removed new-line from all the perror() calls
- Some minor cosmetic changes to the test cases
- Added Anton's SOB to the above mentioned five derived test cases

Changes in V3:
-------------
- Minor changes to last couple of sysfs test cases
- Added .gitignore file for the new test directory

Changes in V2: (https://lkml.org/lkml/2015/1/13/148)
-------------
- Updated the thread struct DSCR value inside mtspr facility exception path
- Modified the in code documentation to follow the kernel-doc format
- Added seven selftest based DSCR related test cases under powerpc

Original V1:
------------
- Posted here at https://patchwork.ozlabs.org/patch/418583/

Anshuman Khandual (13):
  powerpc: Fix handling of DSCR related facility unavailable exception
  powerpc, process: Remove the unused extern dscr_default
  powerpc, offset: Change PACA_DSCR to PACA_DSCR_DEFAULT
  powerpc, dscr: Added some in-code documentation
  documentation, powerpc: Add documentation for DSCR support
  selftests, powerpc: Add test for system wide DSCR default
  selftests, powerpc: Add test for explicitly changing DSCR value
  selftests, powerpc: Add test for DSCR SPR numbers
  selftests, powerpc: Add test for DSCR value inheritence across fork
  selftests, powerpc: Add test for DSCR inheritence across fork & exec
  selftests, powerpc: Add test for all DSCR sysfs interfaces
  selftests, powerpc: Add thread based stress test for DSCR sysfs interfaces
  selftests, powerpc: Add gitignore file for the new DSCR tests

 Documentation/powerpc/00-INDEX                     |   2 +
 Documentation/powerpc/dscr.txt                     |  83 +++++++++++++
 arch/powerpc/include/asm/processor.h               |   9 ++
 arch/powerpc/kernel/asm-offsets.c                  |   2 +-
 arch/powerpc/kernel/entry_64.S                     |   2 +-
 arch/powerpc/kernel/process.c                      |   1 -
 arch/powerpc/kernel/sysfs.c                        |  38 ++++++
 arch/powerpc/kernel/tm.S                           |   4 +-
 arch/powerpc/kernel/traps.c                        |  45 +++++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   2 +-
 tools/testing/selftests/powerpc/Makefile           |   2 +-
 tools/testing/selftests/powerpc/dscr/.gitignore    |   7 ++
 tools/testing/selftests/powerpc/dscr/Makefile      |  19 +++
 tools/testing/selftests/powerpc/dscr/dscr.h        | 120 +++++++++++++++++++
 .../selftests/powerpc/dscr/dscr_default_test.c     | 128 +++++++++++++++++++++
 .../selftests/powerpc/dscr/dscr_explicit_test.c    |  72 ++++++++++++
 .../powerpc/dscr/dscr_inherit_exec_test.c          | 118 +++++++++++++++++++
 .../selftests/powerpc/dscr/dscr_inherit_test.c     |  96 ++++++++++++++++
 .../selftests/powerpc/dscr/dscr_sysfs_test.c       |  98 ++++++++++++++++
 .../powerpc/dscr/dscr_sysfs_thread_test.c          | 123 ++++++++++++++++++++
 .../selftests/powerpc/dscr/dscr_user_test.c        |  62 ++++++++++
 21 files changed, 1021 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/powerpc/dscr.txt
 create mode 100644 tools/testing/selftests/powerpc/dscr/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/dscr/Makefile
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr.h
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_default_test.c
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_user_test.c

-- 
1.9.3
