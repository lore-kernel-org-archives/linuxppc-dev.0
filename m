Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3nVk68nNzDt2x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 22:15:10 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i85so22529474pfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 04:15:10 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Shuah Khan <shuah@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Cyril Bur <cyrilbur@gmail.com>, Chris Smart <chris@distroguy.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>, Jack Miller <jack@codezen.org>,
 Rashmica Gupta <rashmicy@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: [PATCH v16 00/15] selftests/powerpc: Add ptrace tests for ppc
 registers
Date: Wed, 26 Oct 2016 19:13:42 +0800
Message-Id: <1477480437-12937-1-git-send-email-wei.guo.simon@gmail.com>
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

This selftest suite is for PPC register ptrace functionality. It
is also useful for Transaction Memory functionality verification.

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
V13: https://lkml.org/lkml/2016/7/27/656
V14: https://lkml.org/lkml/2016/9/12/57
V15: https://lkml.org/lkml/2016/9/29/722

Changes in V16:
---------------
- Correct expected SIER value in HV mode.
- rebased to latest ppc tree.

Changes in V15:
---------------
- Squash patch 1 and 2 to avoid compile error after patch 1.
- Reorganize some code across patch 3 and 4 to avoid compile error
- Created a new directory utility under tools/testing/selftesting/powerpc
to organize common APIs across selftests.
- Use "tbegin." instead of TBEGIN macro. The same for other TM instructions.
- Correct while(ptr); loop without memory barrier.
- Remove an invalid checking on TEXASR in tm-spd-spr.c.
- Use FAIL_IF() as possible to indicate failure line conveniently.
- Consolidate some asm code on GPR/FPR load/save into reg.h/reg.S
- rebased to recent ppc git tree.

Changes in V14: 
--------------- 
- Remove duplicated NT_PPC_xxx register macro in 
tools/testing/selftests/powerpc/ptrace/ptrace.h
- Clean some coding style warning

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

Anshuman Khandual (14):
  selftests/powerpc: Add more SPR numbers, TM & VMX instructions to
    'reg.h'/'instructions.h'
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

Simon Guo (1):
  selftests/powerpc: move shared utility files into new utility/ dir

 tools/testing/selftests/powerpc/Makefile           |   5 +-
 tools/testing/selftests/powerpc/alignment/Makefile |   2 +-
 tools/testing/selftests/powerpc/basic_asm.h        |  70 --
 .../testing/selftests/powerpc/benchmarks/Makefile  |   2 +-
 .../selftests/powerpc/benchmarks/context_switch.c  |   2 +-
 .../selftests/powerpc/context_switch/Makefile      |   2 +-
 .../selftests/powerpc/context_switch/cp_abort.c    |   6 +-
 .../testing/selftests/powerpc/copyloops/validate.c |   2 +-
 tools/testing/selftests/powerpc/dscr/dscr.h        |  10 +-
 tools/testing/selftests/powerpc/fpu_asm.h          |  80 ---
 tools/testing/selftests/powerpc/gpr_asm.h          |  96 ---
 tools/testing/selftests/powerpc/instructions.h     |  68 --
 tools/testing/selftests/powerpc/math/fpu_asm.S     |   4 +-
 tools/testing/selftests/powerpc/math/vmx_asm.S     |   4 +-
 tools/testing/selftests/powerpc/math/vsx_asm.S     |   4 +-
 tools/testing/selftests/powerpc/mm/Makefile        |   2 +-
 tools/testing/selftests/powerpc/pmu/Makefile       |   4 +-
 tools/testing/selftests/powerpc/pmu/ebb/Makefile   |   2 +-
 tools/testing/selftests/powerpc/ptrace/.gitignore  |  11 +
 tools/testing/selftests/powerpc/ptrace/Makefile    |  14 +
 .../testing/selftests/powerpc/ptrace/ptrace-ebb.c  | 188 +++++
 .../testing/selftests/powerpc/ptrace/ptrace-ebb.h  | 100 +++
 .../testing/selftests/powerpc/ptrace/ptrace-gpr.c  | 123 ++++
 .../testing/selftests/powerpc/ptrace/ptrace-gpr.h  |  74 ++
 .../testing/selftests/powerpc/ptrace/ptrace-tar.c  | 135 ++++
 .../testing/selftests/powerpc/ptrace/ptrace-tar.h  |  50 ++
 .../selftests/powerpc/ptrace/ptrace-tm-gpr.c       | 158 +++++
 .../selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c   | 169 +++++
 .../selftests/powerpc/ptrace/ptrace-tm-spd-tar.c   | 174 +++++
 .../selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c   | 185 +++++
 .../selftests/powerpc/ptrace/ptrace-tm-spr.c       | 168 +++++
 .../selftests/powerpc/ptrace/ptrace-tm-tar.c       | 160 +++++
 .../selftests/powerpc/ptrace/ptrace-tm-vsx.c       | 168 +++++
 .../testing/selftests/powerpc/ptrace/ptrace-vsx.c  | 117 ++++
 .../testing/selftests/powerpc/ptrace/ptrace-vsx.h  | 127 ++++
 tools/testing/selftests/powerpc/ptrace/ptrace.h    | 771 +++++++++++++++++++++
 tools/testing/selftests/powerpc/reg.h              |  60 --
 tools/testing/selftests/powerpc/signal/Makefile    |   2 +-
 tools/testing/selftests/powerpc/signal/signal.S    |   2 +-
 .../testing/selftests/powerpc/stringloops/memcmp.c |   2 +-
 tools/testing/selftests/powerpc/tm/Makefile        |   2 +-
 tools/testing/selftests/powerpc/tm/tm-signal.S     |  10 +-
 tools/testing/selftests/powerpc/tm/tm.h            |   2 +-
 .../testing/selftests/powerpc/utility/basic_asm.h  |  73 ++
 tools/testing/selftests/powerpc/utility/fpu_asm.h  |  80 +++
 tools/testing/selftests/powerpc/utility/gpr_asm.h  |  96 +++
 .../selftests/powerpc/utility/instructions.h       |  68 ++
 tools/testing/selftests/powerpc/utility/reg.S      | 397 +++++++++++
 tools/testing/selftests/powerpc/utility/reg.h      | 150 ++++
 tools/testing/selftests/powerpc/utility/utils.c    |  87 +++
 tools/testing/selftests/powerpc/utility/utils.h    |  77 ++
 tools/testing/selftests/powerpc/utility/vmx_asm.h  |  96 +++
 tools/testing/selftests/powerpc/utility/vsx_asm.h  |  71 ++
 tools/testing/selftests/powerpc/utils.c            |  87 ---
 tools/testing/selftests/powerpc/utils.h            |  77 --
 tools/testing/selftests/powerpc/vmx_asm.h          |  96 ---
 tools/testing/selftests/powerpc/vsx_asm.h          |  71 --
 57 files changed, 4122 insertions(+), 741 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/basic_asm.h
 delete mode 100644 tools/testing/selftests/powerpc/fpu_asm.h
 delete mode 100644 tools/testing/selftests/powerpc/gpr_asm.h
 delete mode 100644 tools/testing/selftests/powerpc/instructions.h
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
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace.h
 delete mode 100644 tools/testing/selftests/powerpc/reg.h
 create mode 100644 tools/testing/selftests/powerpc/utility/basic_asm.h
 create mode 100644 tools/testing/selftests/powerpc/utility/fpu_asm.h
 create mode 100644 tools/testing/selftests/powerpc/utility/gpr_asm.h
 create mode 100644 tools/testing/selftests/powerpc/utility/instructions.h
 create mode 100644 tools/testing/selftests/powerpc/utility/reg.S
 create mode 100644 tools/testing/selftests/powerpc/utility/reg.h
 create mode 100644 tools/testing/selftests/powerpc/utility/utils.c
 create mode 100644 tools/testing/selftests/powerpc/utility/utils.h
 create mode 100644 tools/testing/selftests/powerpc/utility/vmx_asm.h
 create mode 100644 tools/testing/selftests/powerpc/utility/vsx_asm.h
 delete mode 100644 tools/testing/selftests/powerpc/utils.c
 delete mode 100644 tools/testing/selftests/powerpc/utils.h
 delete mode 100644 tools/testing/selftests/powerpc/vmx_asm.h
 delete mode 100644 tools/testing/selftests/powerpc/vsx_asm.h

-- 
1.8.3.1
