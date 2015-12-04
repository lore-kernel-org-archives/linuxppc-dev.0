Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49BE01A000B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 02:24:23 +1100 (AEDT)
From: Torsten Duwe <duwe@lst.de>
Date: Fri, 4 Dec 2015 15:45:29 +0100
Subject: [PATCH v5 0/9] ftrace with regs + live patching for ppc64 LE (ABI v2)
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Denis Kirjanov <kda@linux-powerpc.org>,
 Petr Mladek <pmladek@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20151204152419.28E0D691D2@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes since v4:
  * change comment style in entry_64.S to C89
    (nobody is using assembler syntax comments there).
  * the bool function restore_r2 shouldn't return 2,
    that's a little confusing.
  * Test whether the compiler supports -mprofile-kernel
    and only then define CC_USING_MPROFILE_KERNEL
  * also make the return value of klp_check_compiler_support
    depend on that.

Major changes since v3:
  * the graph tracer works now.
    It turned out the stack frame it tried to manipulate does not
    exist at that point.
  * changes only needed in order to support -mprofile-kernel are now
    in a separate patch, prepended.
  * Kconfig cleanup so this is only selectable on ppc64le.



Torsten Duwe (9):
  ppc64 (le): prepare for -mprofile-kernel
  ppc64le FTRACE_WITH_REGS implementation
  ppc use ftrace_modify_all_code default
  ppc64 ftrace_with_regs configuration variables
  ppc64 ftrace_with_regs: spare early boot and low level
  ppc64 ftrace: disable profiling for some functions
  ppc64 ftrace: disable profiling for some files
  Implement kernel live patching for ppc64le (ABIv2)
  Enable LIVEPATCH to be configured on ppc64le and add livepatch.o if it
    is selected.

 arch/powerpc/Kconfig                 |   7 ++
 arch/powerpc/Makefile                |  10 +++
 arch/powerpc/include/asm/ftrace.h    |   5 ++
 arch/powerpc/include/asm/livepatch.h |  45 ++++++++++
 arch/powerpc/kernel/Makefile         |  13 +--
 arch/powerpc/kernel/entry_64.S       | 164 ++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/ftrace.c         |  88 ++++++++++++++-----
 arch/powerpc/kernel/livepatch.c      |  38 ++++++++
 arch/powerpc/kernel/module_64.c      |  38 +++++++-
 arch/powerpc/kernel/process.c        |   2 +-
 arch/powerpc/lib/Makefile            |   4 +-
 arch/powerpc/mm/fault.c              |   2 +-
 arch/powerpc/mm/hash_utils_64.c      |  18 ++--
 arch/powerpc/mm/hugetlbpage-hash64.c |   2 +-
 arch/powerpc/mm/hugetlbpage.c        |   4 +-
 arch/powerpc/mm/mem.c                |   2 +-
 arch/powerpc/mm/pgtable_64.c         |   2 +-
 arch/powerpc/mm/slb.c                |   6 +-
 arch/powerpc/mm/slice.c              |   8 +-
 kernel/trace/Kconfig                 |   5 ++
 20 files changed, 409 insertions(+), 54 deletions(-)
 create mode 100644 arch/powerpc/include/asm/livepatch.h
 create mode 100644 arch/powerpc/kernel/livepatch.c

-- 
1.8.5.6
