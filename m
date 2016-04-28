Return-Path: <chandan.kumar@linux.vnet.ibm.com>
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwWm773fyzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 19:31:03 +1000 (AEST)
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <chandan.kumar@linux.vnet.ibm.com>;
 Thu, 28 Apr 2016 05:31:01 -0400
From: Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: acme@redhat.com, mpe@ellerman.id.au, jolsa@redhat.com,
 anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com,
 Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>
Subject: [PATCH 0/3] Add support for perf user stack dump in powerpc
Date: Thu, 28 Apr 2016 15:01:07 +0530
Message-Id: <1461835870-67778-1-git-send-email-chandan.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set enables perf user stack dump on powerpc

Example with "ls" command as user program
./perf record --call-graph=dwarf,8192 ls

./perf script
---------8< -----
..
...
perf 12549 75938.934539:       1771 cycles:ppp: 
                  210d90 .perf_event_exec (/boot/vmlinux)
                  34b914 .load_elf_binary (/boot/vmlinux)
                  2dcabc .search_binary_handler (/boot/vmlinux)
                  2dd6f0 .do_execveat_common.isra.28 (/boot/vmlinux)
                  2ddcd8 .sys_execve (/boot/vmlinux)
                   19258 system_call (/boot/vmlinux)

perf 12549 75938.934549:       8415 cycles:ppp: 
                  207a88 .perf_event_aux_ctx (/boot/vmlinux)
                       0 [unknown] ([unknown])
                  214ab8 .perf_event_comm (/boot/vmlinux)
                  2dcfb8 .__set_task_comm (/boot/vmlinux)
                  2ddb44 .setup_new_exec (/boot/vmlinux)
                  34b914 .load_elf_binary (/boot/vmlinux)
                  2dcabc .search_binary_handler (/boot/vmlinux)
                  2dd6f0 .do_execveat_common.isra.28 (/boot/vmlinux)
                  2ddcd8 .sys_execve (/boot/vmlinux)
                   19258 system_call (/boot/vmlinux)

ls 12549 75938.934562:      33745 cycles:ppp: 
                   ee570 .task_work_add (/boot/vmlinux)
                       0 [unknown] ([unknown])
                  2ce380 .filp_close (/boot/vmlinux)
                  2fc464 .do_close_on_exec (/boot/vmlinux)
                  2ddbd8 .setup_new_exec (/boot/vmlinux)
                  34b914 .load_elf_binary (/boot/vmlinux)
                  2dcabc .search_binary_handler (/boot/vmlinux)
                  2dd6f0 .do_execveat_common.isra.28 (/boot/vmlinux)
                  2ddcd8 .sys_execve (/boot/vmlinux)
                   19258 system_call (/boot/vmlinux)

ls 12549 75938.934587:     116078 cycles:ppp: 
                   6ff94 .__clear_user (/boot/vmlinux)
                  944400 .padzero ([kernel.vmlinux].text.unlikely)
                  34bd28 .load_elf_binary (/boot/vmlinux)
                  2dcabc .search_binary_handler (/boot/vmlinux)
                  2dd6f0 .do_execveat_common.isra.28 (/boot/vmlinux)
                  2ddcd8 .sys_execve (/boot/vmlinux)
                   19258 system_call (/boot/vmlinux)
...
..
----- 8< -----

Chandan Kumar (2):
  powerpc: Add HAVE_PERF_USER_STACK_DUMP support
  powerpc/perf: Add support for unwinding perf-stackdump

Naveen N. Rao (1):
  perf tools: Fix perf regs mask generation

 .../features/perf/perf-regs/arch-support.txt       |  2 +-
 .../features/perf/perf-stackdump/arch-support.txt  |  2 +-
 arch/powerpc/Kconfig                               |  1 +
 tools/perf/arch/powerpc/util/Build                 |  1 +
 tools/perf/arch/powerpc/util/unwind-libunwind.c    | 96 ++++++++++++++++++++++
 tools/perf/config/Makefile                         |  1 +
 tools/perf/util/perf_regs.c                        |  8 +-
 7 files changed, 105 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/unwind-libunwind.c

-- 
1.9.3
