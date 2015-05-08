Return-Path: <emunson@akamai.com>
Received: from prod-mail-xrelay02.akamai.com (prod-mail-xrelay02.akamai.com
 [72.246.2.14])
 by lists.ozlabs.org (Postfix) with ESMTP id A7E231A0862
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2015 05:40:03 +1000 (AEST)
From: Eric B Munson <emunson@akamai.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] Allow user to request memory to be locked on page fault
Date: Fri,  8 May 2015 15:33:43 -0400
Message-Id: <1431113626-19153-1-git-send-email-emunson@akamai.com>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuahkh@osg.samsung.com>, Eric B Munson <emunson@akamai.com>,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mlock() allows a user to control page out of program memory, but this
comes at the cost of faulting in the entire mapping when it is
allocated.  For large mappings where the entire area is not necessary
this is not ideal.

This series introduces new flags for mmap() and mlockall() that allow a
user to specify that the covered are should not be paged out, but only
after the memory has been used the first time.

The performance cost of these patches are minimal on the two benchmarks
I have tested (stream and kernbench).

Avg throughput in MB/s from stream using 1000000 element arrays
Test     4.1-rc2      4.1-rc2+lock-on-fault
Copy:    10,979.08    10,917.34
Scale:   11,094.45    11,023.01
Add:     12,487.29    12,388.65
Triad:   12,505.77    12,418.78

Kernbench optimal load
                 4.1-rc2  4.1-rc2+lock-on-fault
Elapsed Time     71.046   71.324
User Time        62.117   62.352
System Time      8.926    8.969
Context Switches 14531.9  14542.5
Sleeps           14935.9  14939

Eric B Munson (3):
  Add flag to request pages are locked after page fault
  Add mlockall flag for locking pages on fault
  Add tests for lock on fault

 arch/alpha/include/uapi/asm/mman.h          |   2 +
 arch/mips/include/uapi/asm/mman.h           |   2 +
 arch/parisc/include/uapi/asm/mman.h         |   2 +
 arch/powerpc/include/uapi/asm/mman.h        |   2 +
 arch/sparc/include/uapi/asm/mman.h          |   2 +
 arch/tile/include/uapi/asm/mman.h           |   2 +
 arch/xtensa/include/uapi/asm/mman.h         |   2 +
 include/linux/mm.h                          |   1 +
 include/linux/mman.h                        |   3 +-
 include/uapi/asm-generic/mman.h             |   2 +
 mm/mlock.c                                  |  13 ++-
 mm/mmap.c                                   |   4 +-
 mm/swap.c                                   |   3 +-
 tools/testing/selftests/vm/Makefile         |   8 +-
 tools/testing/selftests/vm/lock-on-fault.c  | 145 ++++++++++++++++++++++++++++
 tools/testing/selftests/vm/on-fault-limit.c |  47 +++++++++
 tools/testing/selftests/vm/run_vmtests      |  23 +++++
 17 files changed, 254 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/vm/lock-on-fault.c
 create mode 100644 tools/testing/selftests/vm/on-fault-limit.c

Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: linux-api@vger.kernel.org

-- 
1.9.1
