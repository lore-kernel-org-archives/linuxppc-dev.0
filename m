Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN1pT1XHczDqnc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 04:25:53 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72IPDOb093556
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 14:25:50 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3ekt1fpk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 14:25:50 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 3 Aug 2017 04:25:48 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v72IPkBN19071004
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 04:25:46 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v72IPifd020463
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 04:25:45 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Breno Leitao <leitao@debian.org>
Subject: [PATCH] powerpc/xmon: Exclude all of xmon/ from ftrace
Date: Wed,  2 Aug 2017 23:55:38 +0530
Message-Id: <20170802182538.26526-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Exclude core xmon files from ftrace (along with an xmon xive helper
outside of xmon/) to minimize impact of ftrace while within xmon.

Before patch:
  root@ubuntu:/sys/kernel/debug/tracing# cat available_filter_functions | grep -i xmon
  xmon_xive_do_dump
  xmon_dbgfs_get
  xmon_print_symbol
  xmon_show_stack
  xmon_dbgfs_ops_open
  xmon_init.part.2
  xmon_dbgfs_set
  sysrq_handle_xmon
  xmon_fault_handler
  cpus_are_in_xmon
  xmon_core
  xmon
  xmon_irq
  xmon_break_match
  xmon_iabr_match
  xmon_sstep
  xmon_bpt
  xmon_ipi
  xmon_write
  xmon_start_pagination
  xmon_end_pagination
  xmon_set_pagination_lpp
  xmon_putchar
  xmon_gets
  xmon_printf
  xmon_puts
  root@ubuntu:/sys/kernel/debug/tracing#

After patch:
  root@ubuntu:/sys/kernel/debug/tracing# cat available_filter_functions | grep -i xmon
  root@ubuntu:/sys/kernel/debug/tracing#

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
This is in addition to Breno's series to disable tracing while in xmon.
While this patch prevents xmon core functions from being traced,
Breno's series prevents other helpers used by xmon from logging entries
into the trace buffer.

- Naveen

 arch/powerpc/sysdev/xive/common.c |  6 +++---
 arch/powerpc/xmon/Makefile        | 13 +++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 6595462b1fc8..97e82a33b7be 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -190,7 +190,7 @@ static u32 xive_scan_interrupts(struct xive_cpu *xc, bool just_peek)
  * This is used to perform the magic loads from an ESB
  * described in xive.h
  */
-static u8 xive_poke_esb(struct xive_irq_data *xd, u32 offset)
+static notrace u8 xive_poke_esb(struct xive_irq_data *xd, u32 offset)
 {
 	u64 val;
 
@@ -204,7 +204,7 @@ static u8 xive_poke_esb(struct xive_irq_data *xd, u32 offset)
 }
 
 #ifdef CONFIG_XMON
-static void xive_dump_eq(const char *name, struct xive_q *q)
+static notrace void xive_dump_eq(const char *name, struct xive_q *q)
 {
 	u32 i0, i1, idx;
 
@@ -218,7 +218,7 @@ static void xive_dump_eq(const char *name, struct xive_q *q)
 		    q->toggle, i0, i1);
 }
 
-void xmon_xive_do_dump(int cpu)
+notrace void xmon_xive_do_dump(int cpu)
 {
 	struct xive_cpu *xc = per_cpu(xive_cpu, cpu);
 
diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 0b2f771593eb..5f95af64cb8f 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -7,6 +7,19 @@ UBSAN_SANITIZE := n
 
 ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
 
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_xmon.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_nonstdio.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
+ifdef CONFIG_XMON_DISASSEMBLY
+CFLAGS_REMOVE_ppc-dis.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_ppc-opc.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
+ifdef CONFIG_SPU_BASE
+CFLAGS_REMOVE_spu-dis.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_spu-opc.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
+endif
+endif
+endif
+
 obj-y			+= xmon.o nonstdio.o spr_access.o
 
 ifdef CONFIG_XMON_DISASSEMBLY
-- 
2.13.3
