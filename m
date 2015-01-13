Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB0881A03DB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:22:56 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 13 Jan 2015 20:22:56 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A73752CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:22:51 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0DAMnjq12255300
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:22:51 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0DAMmgI021234
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:22:49 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/12] POWER DSCR fixes, improvements, docs and tests
Date: Tue, 13 Jan 2015 15:52:28 +0530
Message-Id: <1421144560-15901-1-git-send-email-khandual@linux.vnet.ibm.com>
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

So the derivied test cases have Anton's copyright along with mine but the
commit message as of now has only my signed-off-by statement. As Anton
mentioned before he would put his signed-off-by after reviewing these
modified test cases.

NOTE1: Anton's original inherit exec test expected the child to have system
default DSCR value instead of the inherited DSCR value from it's parent.
But looks like thats not the case when we execute the test, it always
inherits it's parent's DSCR value over the exec call as well. So I have
changed the test program assuming its correct to have the inherited DSCR
value in the fork/execed child program. Please let me know if thats not
correct and I am missing something there.

NOTE2: The selftests/powerpc/.gitignore will be added and will get updated
through a different patch series related to ptrace instead of this one.

Changes in V2:
-------------
- Updated the thread struct DSCR value inside mtspr facility exception path
- Modified the in code documentation to follow the kernel-doc format
- Added seven selftest based DSCR related test cases under powerpc

Original V1:
------------
- Posted here at https://patchwork.ozlabs.org/patch/418583/

Anshuman Khandual (12):
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

 Documentation/powerpc/00-INDEX                     |   2 +
 Documentation/powerpc/dscr.txt                     |  83 ++++++++++++++
 arch/powerpc/include/asm/processor.h               |   9 ++
 arch/powerpc/kernel/asm-offsets.c                  |   2 +-
 arch/powerpc/kernel/entry_64.S                     |   2 +-
 arch/powerpc/kernel/process.c                      |   2 -
 arch/powerpc/kernel/sysfs.c                        |  38 +++++++
 arch/powerpc/kernel/tm.S                           |   4 +-
 arch/powerpc/kernel/traps.c                        |  45 +++++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   2 +-
 tools/testing/selftests/powerpc/Makefile           |   2 +-
 tools/testing/selftests/powerpc/dscr/Makefile      |  19 ++++
 tools/testing/selftests/powerpc/dscr/dscr.h        | 120 ++++++++++++++++++++
 .../selftests/powerpc/dscr/dscr_default_test.c     | 121 +++++++++++++++++++++
 .../selftests/powerpc/dscr/dscr_explicit_test.c    |  72 ++++++++++++
 .../powerpc/dscr/dscr_inherit_exec_test.c          | 118 ++++++++++++++++++++
 .../selftests/powerpc/dscr/dscr_inherit_test.c     |  96 ++++++++++++++++
 .../selftests/powerpc/dscr/dscr_sysfs_test.c       |  89 +++++++++++++++
 .../powerpc/dscr/dscr_sysfs_thread_test.c          | 114 +++++++++++++++++++
 .../selftests/powerpc/dscr/dscr_user_test.c        |  62 +++++++++++
 20 files changed, 989 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/powerpc/dscr.txt
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
