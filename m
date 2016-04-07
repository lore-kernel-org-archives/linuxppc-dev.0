Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgcbn2pD2zDq6L
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 19:24:05 +1000 (AEST)
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qgcbm2g4Wz9sCy
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2016 19:24:04 +1000 (AEST)
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 7 Apr 2016 10:23:59 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id EE90C17D805D
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2016 10:24:31 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u379NoAJ5701914
 for <linuxppc-dev@ozlabs.org>; Thu, 7 Apr 2016 09:23:50 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u379NlkL017031
 for <linuxppc-dev@ozlabs.org>; Thu, 7 Apr 2016 05:23:50 -0400
Subject: Re: [PATCH V10 00/28] Add new powerpc specific ELF core notes
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, emachado@linux.vnet.ibm.com, oleg@redhat.com,
 davem@davemloft.net, dhowells@redhat.com, Ulrich.Weigand@de.ibm.com,
 kirjanov@gmail.com, davej@redhat.com, akpm@linux-foundation.org,
 sukadev@linux.vnet.ibm.com, tglx@linutronix.de, sam.bobroff@au1.ibm.com
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Message-ID: <57062722.5090706@linux.vnet.ibm.com>
Date: Thu, 7 Apr 2016 11:23:46 +0200
MIME-Version: 1.0
In-Reply-To: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/02/2016 09:59, Anshuman Khandual wrote:
> 	This patch series adds twelve new ELF core note sections which can
> be used with existing ptrace request PTRACE_GETREGSET-SETREGSET for accessing
> various transactional memory and other miscellaneous debug register sets on
> powerpc platform.

Hi Michael,

This series is required to handle TM state in CRIU.
Is there a chance to get it upstream soon ?

Thanks,
Laurent.

> 
> Test Result (All tests pass on both BE and LE)
> ----------------------------------------------
> ptrace-ebb		PASS
> ptrace-gpr		PASS
> ptrace-tm-gpr		PASS
> ptrace-tm-spd-gpr	PASS
> ptrace-tar		PASS
> ptrace-tm-tar		PASS
> ptrace-tm-spd-tar	PASS
> ptrace-vsx		PASS
> ptrace-tm-vsx		PASS
> ptrace-tm-spd-vsx	PASS
> ptrace-tm-spr		PASS
> 
> Previous versions:
> ==================
> RFC: https://lkml.org/lkml/2014/4/1/292
> V1:  https://lkml.org/lkml/2014/4/2/43
> V2:  https://lkml.org/lkml/2014/5/5/88
> V3:  https://lkml.org/lkml/2014/5/23/486
> V4:  https://lkml.org/lkml/2014/11/11/6
> V5:  https://lkml.org/lkml/2014/11/25/134
> V6:  https://lkml.org/lkml/2014/12/2/98
> V7:  https://lkml.org/lkml/2015/1/14/19
> V8:  https://lkml.org/lkml/2015/5/19/700
> V9:  https://lkml.org/lkml/2015/10/8/522
> 
> Changes in V10:
> ---------------
> - Rebased against the latest mainline
> - Fixed couple of build failures in the test cases related to aux vector
> 
> Changes in V9:
> --------------
> - Fixed static build check failure after tm_orig_msr got dropped
> - Fixed asm volatile construct for used registers set
> - Fixed EBB, VSX, VMX tests for LE
> - Fixed TAR test which was failing because of system calls
> - Added checks for PPC_FEATURE2_HTM aux feature in the tests
> - Fixed copyright statements
> 
> Changes in V8:
> --------------
> - Split the misc register set into individual ELF core notes
> - Implemented support for VSX register set (on and off TM)
> - Implemented support for EBB register set
> - Implemented review comments on previous versions
> - Some code re-arrangements, re-writes and documentation
> - Added comprehensive list of test cases into selftests
> 
> Changes in V7:
> --------------
> - Fixed a config directive in the MISC code
> - Merged the two gitignore patches into a single one
> 
> Changes in V6:
> --------------
> - Added two git ignore patches for powerpc selftests
> - Re-formatted all in-code function definitions in kernel-doc format
> 
> Changes in V5:
> --------------
> - Changed flush_tmregs_to_thread, so not to take into account self tracing
> - Dropped the 3rd patch in the series which had merged two functions
> - Fixed one build problem for the misc debug register patch
> - Accommodated almost all the review comments from Suka on the 6th patch
> - Minor changes to the self test program
> - Changed commit messages for some of the patches
> 
> Changes in V4:
> --------------
> - Added one test program into the powerpc selftest bucket in this regard
> - Split the 2nd patch in the previous series into four different patches
> - Accommodated most of the review comments on the previous patch series
> - Added a patch to merge functions __switch_to_tm and tm_reclaim_task
> 
> Changes in V3:
> --------------
> - Added two new error paths in every TM related get/set functions when regset
>   support is not present on the system (ENODEV) or when the process does not
>   have any transaction active (ENODATA) in the context
> - Installed the active hooks for all the newly added regset core note types
> 
> Changes in V2:
> --------------
> - Removed all the power specific ptrace requests corresponding to new NT_PPC_*
>   elf core note types. Now all the register sets can be accessed from ptrace
>   through PTRACE_GETREGSET/PTRACE_SETREGSET using the individual NT_PPC* core
>   note type instead
> - Fixed couple of attribute values for REGSET_TM_CGPR register set
> - Renamed flush_tmreg_to_thread as flush_tmregs_to_thread
> - Fixed 32 bit checkpointed GPR support
> - Changed commit messages accordingly
> 
> 
> Anshuman Khandual (28):
>   elf: Add powerpc specific core note sections
>   powerpc, process: Add the function flush_tmregs_to_thread
>   powerpc, ptrace: Enable in transaction NT_PRFPREG ptrace requests
>   powerpc, ptrace: Enable in transaction NT_PPC_VMX ptrace requests
>   powerpc, ptrace: Enable in transaction NT_PPC_VSX ptrace requests
>   powerpc, ptrace: Adapt gpr32_get, gpr32_set functions for transaction
>   powerpc, ptrace: Enable support for NT_PPC_CGPR
>   powerpc, ptrace: Enable support for NT_PPC_CFPR
>   powerpc, ptrace: Enable support for NT_PPC_CVMX
>   powerpc, ptrace: Enable support for NT_PPC_CVSX
>   powerpc, ptrace: Enable support for TM SPR state
>   powerpc, ptrace: Enable NT_PPC_TM_CTAR, NT_PPC_TM_CPPR, NT_PPC_TM_CDSCR
>   powerpc, ptrace: Enable support for NT_PPPC_TAR, NT_PPC_PPR, NT_PPC_DSCR
>   powerpc, ptrace: Enable support for EBB registers
>   selftests, powerpc: Move 'reg.h' file outside of 'ebb' sub directory
>   selftests, powerpc: Add more SPR numbers, TM & VMX instructions to 'reg.h'
>   selftests, powerpc: Add ptrace tests for EBB
>   selftests, powerpc: Add ptrace tests for GPR/FPR registers
>   selftests, powerpc: Add ptrace tests for GPR/FPR registers in TM
>   selftests, powerpc: Add ptrace tests for GPR/FPR registers in suspended TM
>   selftests, powerpc: Add ptrace tests for TAR, PPR, DSCR registers
>   selftests, powerpc: Add ptrace tests for TAR, PPR, DSCR in TM
>   selftests, powerpc: Add ptrace tests for TAR, PPR, DSCR in suspended TM
>   selftests, powerpc: Add ptrace tests for VSX, VMX registers
>   selftests, powerpc: Add ptrace tests for VSX, VMX registers in TM
>   selftests, powerpc: Add ptrace tests for VSX, VMX registers in suspended TM
>   selftests, powerpc: Add ptrace tests for TM SPR registers
>   selftests, powerpc: Add .gitignore file for ptrace executables
> 
>  arch/powerpc/include/asm/switch_to.h               |    8 +
>  arch/powerpc/include/uapi/asm/elf.h                |    6 +
>  arch/powerpc/kernel/process.c                      |   20 +
>  arch/powerpc/kernel/ptrace.c                       | 1737 ++++++++++++++++++--
>  include/uapi/linux/elf.h                           |   12 +
>  tools/testing/selftests/powerpc/Makefile           |    3 +-
>  tools/testing/selftests/powerpc/pmu/ebb/ebb.c      |    2 +-
>  tools/testing/selftests/powerpc/pmu/ebb/ebb.h      |    2 +-
>  .../selftests/powerpc/pmu/ebb/ebb_handler.S        |    2 +-
>  tools/testing/selftests/powerpc/pmu/ebb/reg.h      |   49 -
>  .../selftests/powerpc/pmu/ebb/reg_access_test.c    |    2 +-
>  tools/testing/selftests/powerpc/ptrace/.gitignore  |   11 +
>  tools/testing/selftests/powerpc/ptrace/Makefile    |   12 +
>  .../testing/selftests/powerpc/ptrace/ptrace-ebb.c  |  150 ++
>  .../testing/selftests/powerpc/ptrace/ptrace-ebb.h  |  103 ++
>  .../testing/selftests/powerpc/ptrace/ptrace-gpr.c  |  191 +++
>  .../testing/selftests/powerpc/ptrace/ptrace-gpr.h  |   73 +
>  .../testing/selftests/powerpc/ptrace/ptrace-tar.c  |  151 ++
>  .../testing/selftests/powerpc/ptrace/ptrace-tar.h  |   50 +
>  .../selftests/powerpc/ptrace/ptrace-tm-gpr.c       |  288 ++++
>  .../selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c   |  319 ++++
>  .../selftests/powerpc/ptrace/ptrace-tm-spd-tar.c   |  184 +++
>  .../selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c   |  212 +++
>  .../selftests/powerpc/ptrace/ptrace-tm-spr.c       |  157 ++
>  .../selftests/powerpc/ptrace/ptrace-tm-tar.c       |  170 ++
>  .../selftests/powerpc/ptrace/ptrace-tm-vsx.c       |  196 +++
>  .../testing/selftests/powerpc/ptrace/ptrace-vsx.c  |  138 ++
>  .../testing/selftests/powerpc/ptrace/ptrace-vsx.h  |  104 ++
>  tools/testing/selftests/powerpc/ptrace/ptrace.S    |  396 +++++
>  tools/testing/selftests/powerpc/ptrace/ptrace.h    |  766 +++++++++
>  tools/testing/selftests/powerpc/reg.h              |   70 +
>  31 files changed, 5406 insertions(+), 178 deletions(-)
>  delete mode 100644 tools/testing/selftests/powerpc/pmu/ebb/reg.h
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/Makefile
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-gpr.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-gpr.h
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tar.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tar.h
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-tar.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-vsx.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-vsx.h
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace.S
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace.h
>  create mode 100644 tools/testing/selftests/powerpc/reg.h
> 
