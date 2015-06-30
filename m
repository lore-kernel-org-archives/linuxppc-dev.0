Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA82B1A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 18:34:37 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F168814030B
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 18:34:36 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 30 Jun 2015 14:04:34 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4EA4FE0060
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 14:08:10 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5U8YQMd7406072
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 14:04:29 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5U8YP3U020301
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 14:04:26 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, dja@axtens.net,
 mpe@ellerman.id.au
Subject: [PATCH V10 0/8] powerpc/perf: Enable SW branch filters
Date: Tue, 30 Jun 2015 14:04:14 +0530
Message-Id: <1435653262-24258-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	This is the continuation (rebased and reworked) of the series
posted at https://lkml.org/lkml/2014/5/5/153 (which is V6). I remember
to have incremented the version count for the re-send of the first four
patches of the series to Peter Z for generic review which got pulled in
last year. These patches here are the remaining powerpc part of the
original series.

NOTE: This patch series is logical extension and also dependent on the
series posted at https://patchwork.ozlabs.org/patch/489544/

Changes in V10
==============
(1) The patch series is split into two groups now for easier review
(2) Changed the 'check_excludes' function as suggested by Daniel
(3) Using logical inversion of 'mispred' inside 'insert_branch' function 
(4) Made 'insert_branch' function inline and changed its last argument

Changes in V9 (https://patchwork.ozlabs.org/patch/484242/)
=============
(1) Changed some of the commit messages and fixed some typos
(2) Variable 'bhrb_users' type changed from int to unsigned int
(3) Replaced the last usage of 'get_cpu_var' with 'this_cpu_ptr'
(4) Conditional checks for 'cpuhw->bhrb_users' changed to test against zero
(5) Updated in-code documentation inside 'check_excludes' function
(6) Changed the name & type of 'pred' variable in 'power_pmu_bhrb_read'
(7) Changed the name of 'tmp' to 'to_addr' inside 'power_pmu_bhrb_read'
(8) Changed return values for branch instruction analysis functions
(9) Changed the name of 'flag' variable to 'select_branch' inside 'keep_branch'
(10) Fixed one nested conditional statement inside 'keep_branch' function
(11) Changed function name from 'update_branch_entry' to 'insert_branch'
(12) Fixed copyright and license statements for new selftest related files
(13) Improved helper assembly functions with some macro definitions
(14) Improved the core test program at various places
(15) Added .gitignore file for the new test case

Changes in V8 (http://patchwork.ozlabs.org/patch/481848/)
=============
(1) Fixed BHRB privilege mode branch filter request processing
(2) Dropped branch records where 'from' cannot be fetched
(3) Added in-code documenation at various places in the patch series
(4) Added one comprehensive seltest case to verify all the filters

Changes in V7
=============
(1) Incremented the version count while requesting pull for generic changes

Changes in V6 (https://lkml.org/lkml/2014/5/5/153)
=============
(1) Rebased the patchset against the master
(2) Added "Reviewed-by: Andi Kleen" in the first four patches in the series which changes the
    generic or X86 perf code. [https://lkml.org/lkml/2014/4/7/130]

Changes in V5 (https://lkml.org/lkml/2014/3/7/101)
=============
(1) Added a precursor patch to cleanup the indentation problem in power_pmu_bhrb_read
(2) Added a precursor patch to re-arrange P8 PMU BHRB filter config which improved the clarity
(3) Merged the previous 10th patch into the 8th patch
(4) Moved SW based branch analysis code from core perf into code-patching library as suggested by Michael
(5) Simplified the logic in branch analysis library
(6) Fixed some ambiguities in documentation at various places
(7) Added some more in-code documentation blocks at various places
(8) Renamed some local variable and function names
(9) Fixed some indentation and white space errors in the code
(10) Implemented almost all the review comments and suggestions made by Michael Ellerman on V4 patchset
(11) Enabled privilege mode SW branch filter
(12) Simplified and generalized the SW implemented conditional branch filter
(13) PERF_SAMPLE_BRANCH_COND filter is now supported only through SW implementation
(14) Adjusted other patches to deal with the above changes

Changes in V4 (https://lkml.org/lkml/2013/12/4/168)
=============
(1) Changed the commit message for patch (01/10)
(2) Changed the patch (02/10) to accommodate review comments from Michael Ellerman
(3) Rebased the patchset against latest Linus's tree

Changes in V3 (https://lkml.org/lkml/2013/10/16/59)
=============
(1) Split the SW branch filter enablement into multiple patches
(2) Added PMU neutral SW branch filtering code, PMU specific HW branch filtering code
(3) Added new instruction analysis functionality into powerpc code-patching library
(4) Changed name for some of the functions
(5) Fixed couple of spelling mistakes
(6) Changed code documentation in multiple places

Changes in V2 (https://lkml.org/lkml/2013/8/30/10)
=============
(1) Enabled PPC64 SW branch filtering support
(2) Incorporated changes required for all previous comments


Anshuman Khandual (8):
  powerpc/perf: Restore privilege level filter support for BHRB
  powerpc/perf: Re organize BHRB processing
  powerpc/perf: Change the name of HW PMU branch filter tracking variable
  powerpc/lib: Add new branch analysis support functions
  powerpc/perf: Enable SW filtering in branch stack sampling framework
  powerpc/perf: Change POWER8 PMU configuration to work with SW filters
  powerpc/perf: Enable privilege mode SW branch filters
  selftests/powerpc: Add test for BHRB branch filters (HW & SW)

 arch/powerpc/include/asm/code-patching.h           |  15 +
 arch/powerpc/include/asm/perf_event_server.h       |  10 +-
 arch/powerpc/lib/code-patching.c                   |  60 +++
 arch/powerpc/perf/core-book3s.c                    | 358 +++++++++++---
 arch/powerpc/perf/power8-pmu.c                     |  64 ++-
 tools/testing/selftests/powerpc/pmu/Makefile       |  11 +-
 .../testing/selftests/powerpc/pmu/bhrb/.gitignore  |   1 +
 tools/testing/selftests/powerpc/pmu/bhrb/Makefile  |  13 +
 .../selftests/powerpc/pmu/bhrb/bhrb_filters.c      | 535 +++++++++++++++++++++
 .../selftests/powerpc/pmu/bhrb/bhrb_filters.h      |  15 +
 .../selftests/powerpc/pmu/bhrb/bhrb_filters_asm.S  | 263 ++++++++++
 tools/testing/selftests/powerpc/pmu/event.h        |   5 +
 12 files changed, 1266 insertions(+), 84 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/Makefile
 create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.h
 create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters_asm.S

-- 
2.1.0
