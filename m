Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 4C9121A000B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 00:08:13 +1100 (AEDT)
Subject: Re: [PATCH V11_RESEND 00/10] powerpc/perf: Enable SW branch filters
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1455604630-16214-1-git-send-email-khandual@linux.vnet.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <56C31F38.1030702@c-s.fr>
Date: Tue, 16 Feb 2016 14:08:08 +0100
MIME-Version: 1.0
In-Reply-To: <1455604630-16214-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Your patches seem to be under review in Patchwork, see 
https://patchwork.ozlabs.org/patch/526275/
Why do you resend it ?

Christophe

Le 16/02/2016 07:37, Anshuman Khandual a écrit :
> 	This is the continuation (rebased and reworked) of the series
> posted at https://lkml.org/lkml/2014/5/5/153 (which is V6). I remember
> to have incremented the version count for the re-send of the first four
> patches of the series to Peter Z for generic review which got pulled in
> last year. These patches here are the remaining powerpc part of the
> original series.
>
> NOTE: This patch series is logical extension and also dependent on the
> series posted at https://patchwork.ozlabs.org/patch/489544/
>
> Changes in V11
> ==============
> (1) Re-merged all the patches into this series like before
> (2) One patch got already merged into mainline
> (3) Dropped couple of patches as suggested
> (4) Changed the self test case to ignore incomplete branch records
> (5) Fixed build problem of the self test case on LE
> (6) Replaced all the direct addressing registers as rN instead in the test
> (7) Rebased against mainline kernel
>
> Changes in V10 (https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-June/130566.html)
> ==============
> (1) The patch series is split into two groups now for easier review
> (2) Changed the 'check_excludes' function as suggested by Daniel
> (3) Using logical inversion of 'mispred' inside 'insert_branch' function
> (4) Made 'insert_branch' function inline and changed its last argument
>
> Changes in V9 (https://patchwork.ozlabs.org/patch/484242/)
> =============
> (1) Changed some of the commit messages and fixed some typos
> (2) Variable 'bhrb_users' type changed from int to unsigned int
> (3) Replaced the last usage of 'get_cpu_var' with 'this_cpu_ptr'
> (4) Conditional checks for 'cpuhw->bhrb_users' changed to test against zero
> (5) Updated in-code documentation inside 'check_excludes' function
> (6) Changed the name & type of 'pred' variable in 'power_pmu_bhrb_read'
> (7) Changed the name of 'tmp' to 'to_addr' inside 'power_pmu_bhrb_read'
> (8) Changed return values for branch instruction analysis functions
> (9) Changed the name of 'flag' variable to 'select_branch' inside 'keep_branch'
> (10) Fixed one nested conditional statement inside 'keep_branch' function
> (11) Changed function name from 'update_branch_entry' to 'insert_branch'
> (12) Fixed copyright and license statements for new selftest related files
> (13) Improved helper assembly functions with some macro definitions
> (14) Improved the core test program at various places
> (15) Added .gitignore file for the new test case
>
> Changes in V8 (http://patchwork.ozlabs.org/patch/481848/)
> =============
> (1) Fixed BHRB privilege mode branch filter request processing
> (2) Dropped branch records where 'from' cannot be fetched
> (3) Added in-code documenation at various places in the patch series
> (4) Added one comprehensive seltest case to verify all the filters
>
> Changes in V7
> =============
> (1) Incremented the version count while requesting pull for generic changes
>
> Changes in V6 (https://lkml.org/lkml/2014/5/5/153)
> =============
> (1) Rebased the patchset against the master
> (2) Added "Reviewed-by: Andi Kleen" in the first four patches in the series which changes the
>      generic or X86 perf code. [https://lkml.org/lkml/2014/4/7/130]
>
> Changes in V5 (https://lkml.org/lkml/2014/3/7/101)
> =============
> (1) Added a precursor patch to cleanup the indentation problem in power_pmu_bhrb_read
> (2) Added a precursor patch to re-arrange P8 PMU BHRB filter config which improved the clarity
> (3) Merged the previous 10th patch into the 8th patch
> (4) Moved SW based branch analysis code from core perf into code-patching library as suggested by Michael
> (5) Simplified the logic in branch analysis library
> (6) Fixed some ambiguities in documentation at various places
> (7) Added some more in-code documentation blocks at various places
> (8) Renamed some local variable and function names
> (9) Fixed some indentation and white space errors in the code
> (10) Implemented almost all the review comments and suggestions made by Michael Ellerman on V4 patchset
> (11) Enabled privilege mode SW branch filter
> (12) Simplified and generalized the SW implemented conditional branch filter
> (13) PERF_SAMPLE_BRANCH_COND filter is now supported only through SW implementation
> (14) Adjusted other patches to deal with the above changes
>
> Changes in V4 (https://lkml.org/lkml/2013/12/4/168)
> =============
> (1) Changed the commit message for patch (01/10)
> (2) Changed the patch (02/10) to accommodate review comments from Michael Ellerman
> (3) Rebased the patchset against latest Linus's tree
>
> Changes in V3 (https://lkml.org/lkml/2013/10/16/59)
> =============
> (1) Split the SW branch filter enablement into multiple patches
> (2) Added PMU neutral SW branch filtering code, PMU specific HW branch filtering code
> (3) Added new instruction analysis functionality into powerpc code-patching library
> (4) Changed name for some of the functions
> (5) Fixed couple of spelling mistakes
> (6) Changed code documentation in multiple places
>
> Changes in V2 (https://lkml.org/lkml/2013/8/30/10)
> =============
> (1) Enabled PPC64 SW branch filtering support
> (2) Incorporated changes required for all previous comments
>
> Anshuman Khandual (10):
>    powerpc/perf: Change name & type of 'pred' in power_pmu_bhrb_read
>    powerpc/perf: Re organize PMU branch filter processing on POWER8
>    powerpc/perf: Restore privilege level filter support for BHRB
>    powerpc/perf: Re organize BHRB processing
>    powerpc/perf: Change the name of HW PMU branch filter tracking variable
>    powerpc/lib: Add new branch analysis support functions
>    powerpc/perf: Enable SW filtering in branch stack sampling framework
>    powerpc/perf: Change POWER8 PMU configuration to work with SW filters
>    powerpc/perf: Enable privilege mode SW branch filters
>    selftests/powerpc: Add test for BHRB branch filters (HW & SW)
>
>   arch/powerpc/include/asm/code-patching.h           |  15 +
>   arch/powerpc/include/asm/perf_event_server.h       |  10 +-
>   arch/powerpc/lib/code-patching.c                   |  60 +++
>   arch/powerpc/perf/core-book3s.c                    | 355 +++++++++++---
>   arch/powerpc/perf/power8-pmu.c                     |  70 ++-
>   tools/testing/selftests/powerpc/pmu/Makefile       |  11 +-
>   .../testing/selftests/powerpc/pmu/bhrb/.gitignore  |   1 +
>   tools/testing/selftests/powerpc/pmu/bhrb/Makefile  |  13 +
>   .../selftests/powerpc/pmu/bhrb/bhrb_filters.c      | 539 +++++++++++++++++++++
>   .../selftests/powerpc/pmu/bhrb/bhrb_filters.h      |  15 +
>   .../selftests/powerpc/pmu/bhrb/bhrb_filters_asm.S  | 257 ++++++++++
>   tools/testing/selftests/powerpc/pmu/event.h        |   5 +
>   12 files changed, 1263 insertions(+), 88 deletions(-)
>   create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/.gitignore
>   create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/Makefile
>   create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c
>   create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.h
>   create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters_asm.S
>
