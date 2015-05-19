Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE75F1A05D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:08:42 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0A93E140DBC
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:08:41 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:38:40 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id F182D3940063
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:35 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JF8Sn128442748
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:29 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8OYM027607
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:28 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 00/28] Add new powerpc specific ELF core notes
Date: Tue, 19 May 2015 20:37:56 +0530
Message-Id: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, nacc@linux.vnet.ibm.com, emachado@linux.vnet.ibm.com,
 oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com,
 Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, tglx@linutronix.de,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <anshuman@localhost.localdomain>

	This patch series adds twelve new ELF core note sections which can
be used with existing ptrace request PTRACE_GETREGSET-SETREGSET for accessing
various transactional memory and other miscellaneous debug register sets on
powerpc platform.

Previous versions:
==================
RFC: https://lkml.org/lkml/2014/4/1/292
V1:  https://lkml.org/lkml/2014/4/2/43
V2:  https://lkml.org/lkml/2014/5/5/88
V3:  https://lkml.org/lkml/2014/5/23/486
V4:  https://lkml.org/lkml/2014/11/11/6
V5:  https://lkml.org/lkml/2014/11/25/134
V6:  https://lkml.org/lkml/2014/12/2/98
V7:  https://lkml.org/lkml/2015/1/14/19

Changes in V8:
--------------
- Split the misc register set into individual ELF core notes
- Implemented support for VSX register set (on and off TM)
- Implemented support for EBB register set
- Implemented review comments on previous versions
- Some code re-arrangements, re-writes and documentation
- Added comprehensive list of test cases into selftests

Changes in V7:
--------------
- Fixed a config directive in the MISC code
- Merged the two gitignore patches into a single one

Changes in V6:
--------------
- Added two git ignore patches for powerpc selftests
- Re-formatted all in-code function definitions in kernel-doc format

Changes in V5:
--------------
- Changed flush_tmregs_to_thread, so not to take into account self tracing
- Dropped the 3rd patch in the series which had merged two functions
- Fixed one build problem for the misc debug register patch
- Accommodated almost all the review comments from Suka on the 6th patch
- Minor changes to the self test program
- Changed commit messages for some of the patches

Changes in V4:
--------------
- Added one test program into the powerpc selftest bucket in this regard
- Split the 2nd patch in the previous series into four different patches
- Accommodated most of the review comments on the previous patch series
- Added a patch to merge functions __switch_to_tm and tm_reclaim_task

Changes in V3:
--------------
- Added two new error paths in every TM related get/set functions when regset
  support is not present on the system (ENODEV) or when the process does not
  have any transaction active (ENODATA) in the context
- Installed the active hooks for all the newly added regset core note types

Changes in V2:
--------------
- Removed all the power specific ptrace requests corresponding to new NT_PPC_*
  elf core note types. Now all the register sets can be accessed from ptrace
  through PTRACE_GETREGSET/PTRACE_SETREGSET using the individual NT_PPC* core
  note type instead
- Fixed couple of attribute values for REGSET_TM_CGPR register set
- Renamed flush_tmreg_to_thread as flush_tmregs_to_thread
- Fixed 32 bit checkpointed GPR support
- Changed commit messages accordingly

Test Result
-----------
ptrace-ebb		PASS
ptrace-gpr		PASS
ptrace-tm-gpr		PASS
ptrace-tm-spd-gpr	PASS
ptrace-tar		FAIL
ptrace-tm-tar		FAIL
ptrace-tm-spd-tar	FAIL
ptrace-vsx		PASS
ptrace-tm-vsx		PASS
ptrace-tm-spd-vsx	PASS
ptrace-tm-spr		PASS

NOTE: The above three test case failures are due to PPR context save/restore
in various paths. Still continue to debug the issue.

Anshuman Khandual (28):
  elf: Add powerpc specific core note sections
  powerpc, process: Add the function flush_tmregs_to_thread
  powerpc, ptrace: Enable in transaction NT_PRFPREG ptrace requests
  powerpc, ptrace: Enable in transaction NT_PPC_VMX ptrace requests
  powerpc, ptrace: Enable in transaction NT_PPC_VSX ptrace requests
  powerpc, ptrace: Adapt gpr32_get, gpr32_set functions for transaction
  powerpc, ptrace: Enable support for NT_PPC_CGPR
  powerpc, ptrace: Enable support for NT_PPC_CFPR
  powerpc, ptrace: Enable support for NT_PPC_CVMX
  powerpc, ptrace: Enable support for NT_PPC_CVSX
  powerpc, ptrace: Enable support for TM SPR state
  powerpc, ptrace: Enable NT_PPC_TM_CTAR, NT_PPC_TM_CPPR, NT_PPC_TM_CDSCR
  powerpc, ptrace: Enable support for NT_PPPC_TAR, NT_PPC_PPR, NT_PPC_DSCR
  powerpc, ptrace: Enable support for EBB registers
  selftests, powerpc: Move 'reg.h' file outside of 'ebb' sub directory
  selftests, powerpc: Add more SPR numbers, TM & VMX instructions to 'reg.h'
  selftests, powerpc: Add ptrace tests for EBB
  selftests, powerpc: Add ptrace tests for GPR/FPR registers
  selftests, powerpc: Add ptrace tests for GPR/FPR registers in TM
  selftests, powerpc: Add ptrace tests for GPR/FPR registers in suspended TM
  selftests, powerpc: Add ptrace tests for TAR, PPR, DSCR registers
  selftests, powerpc: Add ptrace tests for TAR, PPR, DSCR in TM
  selftests, powerpc: Add ptrace tests for TAR, PPR, DSCR in suspended TM
  selftests, powerpc: Add ptrace tests for VSX, VMX registers
  selftests, powerpc: Add ptrace tests for VSX, VMX registers in TM
  selftests, powerpc: Add ptrace tests for VSX, VMX registers in suspended TM
  selftests, powerpc: Add ptrace tests for TM SPR registers
  selftests, powerpc: Add .gitignore file for ptrace executables

 arch/powerpc/include/asm/switch_to.h               |    8 +
 arch/powerpc/include/uapi/asm/elf.h                |    5 +
 arch/powerpc/kernel/process.c                      |   20 +
 arch/powerpc/kernel/ptrace.c                       | 1737 ++++++++++++++++++--
 include/uapi/linux/elf.h                           |   12 +
 tools/testing/selftests/powerpc/Makefile           |    2 +-
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c      |    2 +-
 tools/testing/selftests/powerpc/pmu/ebb/ebb.h      |    2 +-
 .../selftests/powerpc/pmu/ebb/ebb_handler.S        |    2 +-
 tools/testing/selftests/powerpc/pmu/ebb/reg.h      |   49 -
 .../selftests/powerpc/pmu/ebb/reg_access_test.c    |    2 +-
 tools/testing/selftests/powerpc/ptrace/.gitignore  |   11 +
 tools/testing/selftests/powerpc/ptrace/Makefile    |   12 +
 .../testing/selftests/powerpc/ptrace/ptrace-ebb.c  |  144 ++
 .../testing/selftests/powerpc/ptrace/ptrace-ebb.h  |   98 ++
 .../testing/selftests/powerpc/ptrace/ptrace-gpr.c  |  191 +++
 .../testing/selftests/powerpc/ptrace/ptrace-gpr.h  |   73 +
 .../testing/selftests/powerpc/ptrace/ptrace-tar.c  |  151 ++
 .../testing/selftests/powerpc/ptrace/ptrace-tar.h  |   50 +
 .../selftests/powerpc/ptrace/ptrace-tm-gpr.c       |  287 ++++
 .../selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c   |  318 ++++
 .../selftests/powerpc/ptrace/ptrace-tm-spd-tar.c   |  184 +++
 .../selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c   |  211 +++
 .../selftests/powerpc/ptrace/ptrace-tm-spr.c       |  156 ++
 .../selftests/powerpc/ptrace/ptrace-tm-tar.c       |  169 ++
 .../selftests/powerpc/ptrace/ptrace-tm-vsx.c       |  195 +++
 .../testing/selftests/powerpc/ptrace/ptrace-vsx.c  |  138 ++
 .../testing/selftests/powerpc/ptrace/ptrace-vsx.h  |   83 +
 tools/testing/selftests/powerpc/ptrace/ptrace.S    |  403 +++++
 tools/testing/selftests/powerpc/ptrace/ptrace.h    |  765 +++++++++
 tools/testing/selftests/powerpc/reg.h              |   70 +
 31 files changed, 5372 insertions(+), 178 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/pmu/ebb/reg.h
 create mode 100644 tools/testing/selftests/powerpc/ptrace/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/ptrace/Makefile
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-gpr.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-gpr.h
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tar.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tar.h
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-tar.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-vsx.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-vsx.h
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace.S
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace.h
 create mode 100644 tools/testing/selftests/powerpc/reg.h

-- 
2.1.0
