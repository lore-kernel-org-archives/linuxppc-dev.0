Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D56001A0629
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 14:17:52 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 10 Apr 2015 14:17:51 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5D2222BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 14:17:48 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A4HdsK12189798
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 14:17:48 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A4HEOw028020
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 14:17:14 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v4 0/4] powerpc/tm: Abort syscalls in active transactions
Date: Fri, 10 Apr 2015 14:16:46 +1000
Message-Id: <cover.1428639350.git.sam.bobroff@au1.ibm.com>
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


v4:
Patch 3/4: selftests/powerpc: Add transactional syscall test

Incorporated changes suggested by Michael Ellerman:
I added a GPL header, fixed up some formatting, and switched to
__builtin_get_texasru() which works for 32-bit.


v3:
Patch 1/4: powerpc/tm: Abort syscalls in active transactions

Use "TABORT()" macro to allow building on versions of gcc that don't support
the "tabort." instruction.


v2:
Patch 1/4: powerpc/tm: Abort syscalls in active transactions

Also update the failure code table.

Patch 3/4: selftests/powerpc: Add transactional syscall test

Further testing has shown that the success or failure of the transactions was
affected by minor changes to the code, compiler optimisation and linker
settings.

To address this, I've moved the transactional part of the test to a separate
function, written in assembly. I've also extended the test to as many
transactions as it can fit into ten seconds, to better test for failures that
occur more rarely. This has stabilised the results, and it's no longer
necessary to use special compiler or linker flags.

Patch 4/4: powerpc/tm: Correct minor documentation typos

Discovered some typos while updating the documentation.


Sam Bobroff (4):
  powerpc/tm: Abort syscalls in active transactions
  selftests/powerpc: Move get_auxv_entry() to harness.c
  selftests/powerpc: Add transactional syscall test
  powerpc/tm: Correct minor documentation typos

 Documentation/powerpc/transactional_memory.txt     |   36 +++---
 arch/powerpc/include/uapi/asm/tm.h                 |    2 +-
 arch/powerpc/kernel/entry_64.S                     |   19 +++
 tools/testing/selftests/powerpc/harness.c          |   47 ++++++++
 tools/testing/selftests/powerpc/pmu/lib.c          |   47 --------
 tools/testing/selftests/powerpc/pmu/lib.h          |    1 -
 tools/testing/selftests/powerpc/tm/.gitignore      |    1 +
 tools/testing/selftests/powerpc/tm/Makefile        |    5 +-
 .../testing/selftests/powerpc/tm/tm-syscall-asm.S  |   27 +++++
 tools/testing/selftests/powerpc/tm/tm-syscall.c    |  121 ++++++++++++++++++++
 tools/testing/selftests/powerpc/utils.h            |    2 +-
 11 files changed, 239 insertions(+), 69 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-syscall-asm.S
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-syscall.c

-- 
1.7.10.4
