Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C70502C011E
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 22:57:01 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Apr 2013 18:21:40 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5C13B1258023
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 18:28:24 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3GCuoBM4194704
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 18:26:50 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3GCurtf001532
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 22:56:54 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] powerpc,
 perf: BHRB based branch stack enablement on POWER8
Date: Tue, 16 Apr 2013 18:26:35 +0530
Message-Id: <1366117000-10979-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

		Branch History Rolling Buffer (BHRB) is a new PMU feaure in IBM
POWER8 processor which records the branch instructions inside the execution
pipeline. This patchset enables the basic functionality of the feature through
generic perf branch stack sampling framework.

Sample output
-------------
$./perf record -b top
$./perf report

Overhead  Command  Source Shared Object                           Source Symbol  Target Shared Object                        Target Symbol
# ........  .......  ....................  ......................................  ....................  ...................................
#

     7.82%      top  libc-2.11.2.so        [k] _IO_vfscanf                         libc-2.11.2.so        [k] _IO_vfscanf                    
     6.17%      top  libc-2.11.2.so        [k] _IO_vfscanf                         [unknown]             [k] 00000000                       
     2.37%      top  [unknown]             [k] 0xf7aafb30                          [unknown]             [k] 00000000                       
     1.80%      top  [unknown]             [k] 0x0fe07978                          libc-2.11.2.so        [k] _IO_vfscanf                    
     1.60%      top  libc-2.11.2.so        [k] _IO_vfscanf                         [kernel.kallsyms]     [k] .do_task_stat                  
     1.20%      top  [kernel.kallsyms]     [k] .do_task_stat                       [kernel.kallsyms]     [k] .do_task_stat                  
     1.02%      top  libc-2.11.2.so        [k] vfprintf                            libc-2.11.2.so        [k] vfprintf                       
     0.92%      top  top                   [k] _init                               [unknown]             [k] 0x0fe037f4                     

Anshuman Khandual (5):
  powerpc, perf: Add new BHRB related instructions on POWER8
  powerpc, perf: Add basic assembly code to read BHRB entries on POWER8
  powerpc, perf: Add new BHRB related generic functions, data and flags
  powerpc, perf: Define BHRB generic functions, data and flags for POWER8
  powerpc, perf: Enable branch stack sampling framework support with BHRB

 arch/powerpc/include/asm/perf_event_server.h |  6 ++
 arch/powerpc/include/asm/ppc-opcode.h        |  7 ++
 arch/powerpc/perf/Makefile                   |  2 +-
 arch/powerpc/perf/bhrb.S                     | 34 ++++++++++
 arch/powerpc/perf/core-book3s.c              | 96 +++++++++++++++++++++++++++-
 arch/powerpc/perf/perf_event_bhrb.c          | 75 ++++++++++++++++++++++
 arch/powerpc/perf/power8-pmu.c               | 57 ++++++++++++++++-
 7 files changed, 272 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/perf/bhrb.S
 create mode 100644 arch/powerpc/perf/perf_event_bhrb.c

-- 
1.7.11.7
