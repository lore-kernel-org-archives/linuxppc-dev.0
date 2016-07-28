Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0Gl73Bd9zDrKs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 12:58:27 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ez1so2701092pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 19:58:27 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Shuah Khan <shuahkh@osg.samsung.com>, Anton Blanchard <anton@samba.org>,
 Cyril Bur <cyrilbur@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linux-kselftest@vger.kernel.org
Subject: [PATCH v13 00/30] Add new powerpc specific ELF core notes
Date: Thu, 28 Jul 2016 10:57:29 +0800
Message-Id: <1469674679-8580-1-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patch series adds thirteen new ELF core note sections which can 
be used with existing ptrace request PTRACE_GETREG/SET-SETREGSET for 
accessing various transactional memory and other miscellaneous debug 
register sets on powerpc platform. 

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Test Result (All tests pass on both BE and LE) 
---------------------------------------------- 
ptrace-ebb	PASS 
ptrace-gpr	PASS 
ptrace-tm-gpr	PASS 
ptrace-tm-spd-gpr	PASS 
ptrace-tar	PASS 
ptrace-tm-tar	PASS 
ptrace-tm-spd-tar	PASS 
ptrace-vsx	PASS 
ptrace-tm-vsx	PASS 
ptrace-tm-spd-vsx	PASS 
ptrace-tm-spr	PASS 

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
V8:  https://lkml.org/lkml/2015/5/19/700
V9:  https://lkml.org/lkml/2015/10/8/522
V10: https://lkml.org/lkml/2016/2/16/219
V11: https://lkml.org/lkml/2016/7/16/231
V12: https://lkml.org/lkml/2016/7/27/134

Changes in V13: 
--------------- 
- Remove Cc lines from changelog
- Add more Signed-off-by lines of Simon Guo

Changes in V12: 
--------------- 
- Revert change which is trying to incoporate following patch:
  [PATCH 3/5] powerpc: tm: Always use fp_state and vr_state to store live registers
- Release share memory resource in all self test cases
- Optimize tfhar usage in ptrace-tm-spr.c

Changes in V11: 
--------------- 
- Rework based on following patch:
  [PATCH 3/5] powerpc: tm: Always use fp_state and vr_state to store live registers
- Split EBB/PMU register ptrace implementation.
- Clean some coding style warning
- Added more shared memory based sync between parent and child during TM tests
- Re worded some of the commit messages and cleaned them up
- selftests/powerpc/ebb/reg.h has already moved as selftests/powerpc/reg.h
  Dropped the previous patch doing the same thing
- Combined the definitions of SPRN_DSCR from dscr/ test cases
- Fixed dscr/ test cases for new SPRN_DSCR_PRIV definition available

Changes in V10: 
--------------- 
- Rebased against the latest mainline 
- Fixed couple of build failures in the test cases related to aux vector 

Changes in V9: 
-------------- 
- Fixed static build check failure after tm_orig_msr got dropped 
- Fixed asm volatile construct for used registers set 
- Fixed EBB, VSX, VMX tests for LE 
- Fixed TAR test which was failing because of system calls 
- Added checks for PPC_FEATURE2_HTM aux feature in the tests 
- Fixed copyright statements 

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
- Installed the active hooks for all the newly added regset core note
types 

Changes in V2: 
-------------- 
- Removed all the power specific ptrace requests corresponding to new
NT_PPC_* 
elf core note types. Now all the register sets can be accessed from
ptrace 
through PTRACE_GETREGSET/PTRACE_SETREGSET using the individual
NT_PPC* core 
note type instead 
- Fixed couple of attribute values for REGSET_TM_CGPR register set 
- Renamed flush_tmreg_to_thread as flush_tmregs_to_thread 
- Fixed 32 bit checkpointed GPR support 
- Changed commit messages accordingly 
-------------

Anshuman Khandual (30):
  elf: Add powerpc specific core note sections
  powerpc/process: Add the function flush_tmregs_to_thread
  powerpc/ptrace: Enable in transaction NT_PRFPREG ptrace requests
  powerpc/ptrace: Enable in transaction NT_PPC_VMX ptrace requests
  powerpc/ptrace: Enable in transaction NT_PPC_VSX ptrace requests
  powerpc/ptrace: Adapt gpr32_get, gpr32_set functions for transaction
  powerpc/ptrace: Enable support for NT_PPC_CGPR
  powerpc/ptrace: Enable support for NT_PPC_CFPR
  powerpc/ptrace: Enable support for NT_PPC_CVMX
  powerpc/ptrace: Enable support for NT_PPC_CVSX
  powerpc/ptrace: Enable support for TM SPR state
  powerpc/ptrace: Enable NT_PPC_TM_CTAR, NT_PPC_TM_CPPR, NT_PPC_TM_CDSCR
  powerpc/ptrace: Enable support for NT_PPPC_TAR, NT_PPC_PPR,
    NT_PPC_DSCR
  powerpc/ptrace: Enable support for EBB registers
  powerpc/ptrace: Enable support for Performance Monitor registers
  selftests/powerpc: Add more SPR numbers, TM & VMX instructions to
    'reg.h'
  selftests/powerpc: Use the new SPRN_DSCR_PRIV definiton
  selftests/powerpc: Add ptrace tests for EBB
  selftests/powerpc: Add ptrace tests for GPR/FPR registers
  selftests/powerpc: Add ptrace tests for GPR/FPR registers in TM
  selftests/powerpc: Add ptrace tests for GPR/FPR registers in suspended
    TM
  selftests/powerpc: Add ptrace tests for TAR, PPR, DSCR registers
  selftests/powerpc: Add ptrace tests for TAR, PPR, DSCR in TM
  selftests/powerpc: Add ptrace tests for TAR, PPR, DSCR in suspended TM
  selftests/powerpc: Add ptrace tests for VSX, VMX registers
  selftests/powerpc: Add ptrace tests for VSX, VMX registers in TM
  selftests/powerpc: Add ptrace tests for VSX, VMX registers in
    suspended TM
  selftests/powerpc: Add ptrace tests for TM SPR registers
  selftests/powerpc: Add .gitignore file for ptrace executables
  selftests/powerpc: Fix a build issue

 arch/powerpc/include/asm/switch_to.h               |    8 +
 arch/powerpc/include/uapi/asm/elf.h                |    5 +
 arch/powerpc/kernel/process.c                      |   20 +
 arch/powerpc/kernel/ptrace.c                       | 1740 ++++++++++++++++++--
 include/uapi/linux/elf.h                           |   13 +
 tools/testing/selftests/powerpc/Makefile           |    3 +-
 .../selftests/powerpc/context_switch/cp_abort.c    |    6 +-
 tools/testing/selftests/powerpc/dscr/dscr.h        |   10 +-
 tools/testing/selftests/powerpc/ptrace/.gitignore  |   11 +
 tools/testing/selftests/powerpc/ptrace/Makefile    |   13 +
 .../testing/selftests/powerpc/ptrace/ptrace-ebb.c  |  185 +++
 .../testing/selftests/powerpc/ptrace/ptrace-ebb.h  |  102 ++
 .../testing/selftests/powerpc/ptrace/ptrace-gpr.c  |  199 +++
 .../testing/selftests/powerpc/ptrace/ptrace-gpr.h  |   74 +
 .../testing/selftests/powerpc/ptrace/ptrace-tar.c  |  159 ++
 .../testing/selftests/powerpc/ptrace/ptrace-tar.h  |   50 +
 .../selftests/powerpc/ptrace/ptrace-tm-gpr.c       |  299 ++++
 .../selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c   |  327 ++++
 .../selftests/powerpc/ptrace/ptrace-tm-spd-tar.c   |  195 +++
 .../selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c   |  222 +++
 .../selftests/powerpc/ptrace/ptrace-tm-spr.c       |  186 +++
 .../selftests/powerpc/ptrace/ptrace-tm-tar.c       |  182 ++
 .../selftests/powerpc/ptrace/ptrace-tm-vsx.c       |  209 +++
 .../testing/selftests/powerpc/ptrace/ptrace-vsx.c  |  143 ++
 .../testing/selftests/powerpc/ptrace/ptrace-vsx.h  |  121 ++
 tools/testing/selftests/powerpc/ptrace/ptrace.S    |  396 +++++
 tools/testing/selftests/powerpc/ptrace/ptrace.h    |  783 +++++++++
 tools/testing/selftests/powerpc/reg.h              |   42 +-
 28 files changed, 5566 insertions(+), 137 deletions(-)
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

-- 
1.8.3.1
