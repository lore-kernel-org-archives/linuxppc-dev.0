Return-Path: <anju@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B37C91A0937
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 16:04:28 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Sat, 20 Feb 2016 15:04:27 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7E9A82CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 16:04:26 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1K54Is28847834
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 16:04:26 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1K53rWJ001827
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 16:03:54 +1100
From: Anju T <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mpe@ellerman.id.au, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, acme@redhat.com, sukadev@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V11 3/4] tools/perf: Map the ID values with register names
Date: Sat, 20 Feb 2016 10:32:47 +0530
Message-Id: <1455944568-7231-4-git-send-email-anju@linux.vnet.ibm.com>
In-Reply-To: <1455944568-7231-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1455944568-7231-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Map ID values with corresponding register names. These names are then
displayed when user issues perf record with the -I option
followed by perf report/script with -D option.

To test this patchset,
Eg:
$ perf record -I ls   # record machine state at interrupt
$ perf script -D      # read the perf.data file

Sample output obtained for this patch / output looks like as follows:

496768515470 0x1988 [0x188]: PERF_RECORD_SAMPLE(IP, 0x1): 4522/4522: 0xc0000000001e538c period: 1 addr: 0
... intr regs: mask 0x7ffffffffff ABI 64-bit
.... r0    0xc0000000001e5e34
.... r1    0xc000000fe733f9a0
.... r2    0xc000000001523100
.... r3    0xc000000ffaadeb60
.... r4    0xc000000003456800
.... r5    0x73a9b5e000
.... r6    0x1e000000
.... r7    0x0
.... r8    0x0
.... r9    0x0
.... r10   0x1
.... r11   0x0
.... r12   0x24022822
.... r13   0xc00000000feec180
.... r14   0x0
.... r15   0xc000001e4be18800
.... r16   0x0
.... r17   0xc000000ffaac5000
.... r18   0xc000000fe733f8a0
.... r19   0xc000000001523100
.... r20   0xc00000000009fd1c
.... r21   0xc000000fcaa69000
.... r22   0xc0000000001e4968
.... r23   0xc000000001523100
.... r24   0xc000000fe733f850
.... r25   0xc000000fcaa69000
.... r26   0xc000000003b8fcf0
.... r27   0xfffffffffffffead
.... r28   0x0
.... r29   0xc000000fcaa69000
.... r30   0x1
.... r31   0x0
.... nip   0xc0000000001dd320
.... msr   0x9000000000009032
.... orig_r3 0xc0000000001e538c
.... ctr   0xc00000000009d550
.... link  0xc0000000001e5e34
.... xer   0x0
.... ccr   0x84022882
.... softe 0x0
.... trap  0xf01
.... dar   0x0
.... dsisr 0xf00040060000004
 ... thread: :4522:4522
 ...... dso: /root/.debug/.build-id/b0/ef11b1a1629e62ac9de75199117ee5ef9469e9
           :4522  4522   496.768515:          1 cycles:  c0000000001e538c .perf_event_context_sched_in (/boot/vmlinux)

Signed-off-by: Anju T <anju@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/include/perf_regs.h | 69 +++++++++++++++++++++++++++++
 tools/perf/config/Makefile                  |  5 +++
 2 files changed, 74 insertions(+)
 create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h

diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
new file mode 100644
index 0000000..0b77a93
--- /dev/null
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -0,0 +1,69 @@
+#ifndef ARCH_PERF_REGS_H
+#define ARCH_PERF_REGS_H
+
+#include <stdlib.h>
+#include <linux/types.h>
+#include <asm/perf_regs.h>
+
+#define PERF_REGS_MASK  ((1ULL << PERF_REG_POWERPC_MAX) - 1)
+#define PERF_REGS_MAX   PERF_REG_POWERPC_MAX
+#ifdef __powerpc64__
+	#define PERF_SAMPLE_REGS_ABI	PERF_SAMPLE_REGS_ABI_64
+#else
+	#define PERF_SAMPLE_REGS_ABI	PERF_SAMPLE_REGS_ABI_32
+#endif
+
+#define PERF_REG_IP     PERF_REG_POWERPC_NIP
+#define PERF_REG_SP     PERF_REG_POWERPC_R1
+
+static const char *reg_names[] = {
+	[PERF_REG_POWERPC_R0] = "r0",
+	[PERF_REG_POWERPC_R1] = "r1",
+	[PERF_REG_POWERPC_R2] = "r2",
+	[PERF_REG_POWERPC_R3] = "r3",
+	[PERF_REG_POWERPC_R4] = "r4",
+	[PERF_REG_POWERPC_R5] = "r5",
+	[PERF_REG_POWERPC_R6] = "r6",
+	[PERF_REG_POWERPC_R7] = "r7",
+	[PERF_REG_POWERPC_R8] = "r8",
+	[PERF_REG_POWERPC_R9] = "r9",
+	[PERF_REG_POWERPC_R10] = "r10",
+	[PERF_REG_POWERPC_R11] = "r11",
+	[PERF_REG_POWERPC_R12] = "r12",
+	[PERF_REG_POWERPC_R13] = "r13",
+	[PERF_REG_POWERPC_R14] = "r14",
+	[PERF_REG_POWERPC_R15] = "r15",
+	[PERF_REG_POWERPC_R16] = "r16",
+	[PERF_REG_POWERPC_R17] = "r17",
+	[PERF_REG_POWERPC_R18] = "r18",
+	[PERF_REG_POWERPC_R19] = "r19",
+	[PERF_REG_POWERPC_R20] = "r20",
+	[PERF_REG_POWERPC_R21] = "r21",
+	[PERF_REG_POWERPC_R22] = "r22",
+	[PERF_REG_POWERPC_R23] = "r23",
+	[PERF_REG_POWERPC_R24] = "r24",
+	[PERF_REG_POWERPC_R25] = "r25",
+	[PERF_REG_POWERPC_R26] = "r26",
+	[PERF_REG_POWERPC_R27] = "r27",
+	[PERF_REG_POWERPC_R28] = "r28",
+	[PERF_REG_POWERPC_R29] = "r29",
+	[PERF_REG_POWERPC_R30] = "r30",
+	[PERF_REG_POWERPC_R31] = "r31",
+	[PERF_REG_POWERPC_NIP] = "nip",
+	[PERF_REG_POWERPC_MSR] = "msr",
+	[PERF_REG_POWERPC_ORIG_R3] = "orig_r3",
+	[PERF_REG_POWERPC_CTR] = "ctr",
+	[PERF_REG_POWERPC_LNK] = "link",
+	[PERF_REG_POWERPC_XER] = "xer",
+	[PERF_REG_POWERPC_CCR] = "ccr",
+	[PERF_REG_POWERPC_SOFTE] = "softe",
+	[PERF_REG_POWERPC_TRAP] = "trap",
+	[PERF_REG_POWERPC_DAR] = "dar",
+	[PERF_REG_POWERPC_DSISR] = "dsisr"
+};
+
+static inline const char *perf_reg_name(int id)
+{
+	return reg_names[id];
+}
+#endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index 38a0853..2de6bd4 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -23,6 +23,11 @@ $(call detected_var,ARCH)
 
 NO_PERF_REGS := 1
 
+# Additional ARCH settings for ppc
+ifeq ($(ARCH),powerpc)
+  NO_PERF_REGS := 0
+endif
+
 # Additional ARCH settings for x86
 ifeq ($(ARCH),x86)
   $(call detected,CONFIG_X86)
-- 
2.1.0
