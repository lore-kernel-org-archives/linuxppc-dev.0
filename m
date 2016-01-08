Return-Path: <anju@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F2231A0406
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 20:03:36 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Fri, 8 Jan 2016 19:03:34 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 15DD42CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 20:03:33 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u08933NY37552180
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jan 2016 20:03:11 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u08930RB017820
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jan 2016 20:03:00 +1100
From: Anju T <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: khandual@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, acme@redhat.com, sukadev@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V8 3/4] tools/perf: Map the ID values with register names
Date: Fri,  8 Jan 2016 14:32:30 +0530
Message-Id: <1452243751-382-4-git-send-email-anju@linux.vnet.ibm.com>
In-Reply-To: <1452243751-382-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1452243751-382-1-git-send-email-anju@linux.vnet.ibm.com>
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

178329381464 0x138 [0x180]: PERF_RECORD_SAMPLE(IP, 0x1): 7803/7803: 0xc00000000000fd9c period: 1 addr: 0
... intr regs: mask 0x3ffffffffff ABI 64-bit
.... gpr0  0xc0000000001a6420
.... gpr1  0xc000001e4df039b0
.... gpr2  0xc000000000cdd100
.... gpr3  0x1
.... gpr4  0xc000001e4a96d000
.... gpr5  0x29854255ba
.... gpr6  0xc000000ffa3050b8
.... gpr7  0x0
.... gpr8  0x0
.... gpr9  0x0
.... gpr10 0x0
.... gpr11 0x0
.... gpr12 0x24022822
.... gpr13 0xc00000000fe03000
.... gpr14 0x0
.... gpr15 0xc000000000d763f8
.... gpr16 0x0
.... gpr17 0xc000001e4ddcf000
.... gpr18 0x0
.... gpr19 0xc000000ffa305000
.... gpr20 0xc000001e4df038c0
.... gpr21 0xc000001e40ed7a00
.... gpr22 0xc0000000000aa28c
.... gpr23 0xc000000000cdd100
.... gpr24 0x0
.... gpr25 0xc000000000cdd100
.... gpr26 0xc000001e4df038b0
.... gpr27 0xfffffffffffffeae
.... gpr28 0xc000001e4df03880
.... gpr29 0xc000000000dce900
.... gpr30 0xc000001e4df03890
.... gpr31 0xc000001e355c7a30
.... nip   0xc0000000001a62d8
.... msr   0x9000000000009032
.... orig_r3 0xc0000000001a6320
.... ctr   0xc0000000000a7be0
.... lnk   0xc0000000001a6428
.... xer   0x0
.... ccr   0x24022888
.... trap  0xf01
.... dar   0xc000001e40ed7a00
.... dsisr 0x3000c0060000004
 ... thread: :7803:7803
 ...... dso: /root/.debug/.build-id/d0/eb47b06c0d294143af13c50616f638c2d88658
           :7803  7803   178.329381:          1 cycles:  c00000000000fd9c .arch_local_irq_restore (/boot/vmlinux)


Signed-off-by: Anju T <anju@linux.vnet.ibm.com>
Reviewed-by  : Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/include/perf_regs.h | 64 +++++++++++++++++++++++++++++
 tools/perf/config/Makefile                  |  5 +++
 2 files changed, 69 insertions(+)
 create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h

diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
new file mode 100644
index 0000000..c725834
--- /dev/null
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -0,0 +1,64 @@
+#ifndef ARCH_PERF_REGS_H
+#define ARCH_PERF_REGS_H
+
+#include <stdlib.h>
+#include <linux/types.h>
+#include <asm/perf_regs.h>
+
+#define PERF_REGS_MASK  ((1ULL << PERF_REG_POWERPC_MAX) - 1)
+#define PERF_REGS_MAX   PERF_REG_POWERPC_MAX
+#define PERF_SAMPLE_REGS_ABI   PERF_SAMPLE_REGS_ABI_64
+
+#define PERF_REG_IP     PERF_REG_POWERPC_NIP
+#define PERF_REG_SP     PERF_REG_POWERPC_GPR1
+
+static const char *reg_names[] = {
+	[PERF_REG_POWERPC_GPR0] = "gpr0",
+	[PERF_REG_POWERPC_GPR1] = "gpr1",
+	[PERF_REG_POWERPC_GPR2] = "gpr2",
+	[PERF_REG_POWERPC_GPR3] = "gpr3",
+	[PERF_REG_POWERPC_GPR4] = "gpr4",
+	[PERF_REG_POWERPC_GPR5] = "gpr5",
+	[PERF_REG_POWERPC_GPR6] = "gpr6",
+	[PERF_REG_POWERPC_GPR7] = "gpr7",
+	[PERF_REG_POWERPC_GPR8] = "gpr8",
+	[PERF_REG_POWERPC_GPR9] = "gpr9",
+	[PERF_REG_POWERPC_GPR10] = "gpr10",
+	[PERF_REG_POWERPC_GPR11] = "gpr11",
+	[PERF_REG_POWERPC_GPR12] = "gpr12",
+	[PERF_REG_POWERPC_GPR13] = "gpr13",
+	[PERF_REG_POWERPC_GPR14] = "gpr14",
+	[PERF_REG_POWERPC_GPR15] = "gpr15",
+	[PERF_REG_POWERPC_GPR16] = "gpr16",
+	[PERF_REG_POWERPC_GPR17] = "gpr17",
+	[PERF_REG_POWERPC_GPR18] = "gpr18",
+	[PERF_REG_POWERPC_GPR19] = "gpr19",
+	[PERF_REG_POWERPC_GPR20] = "gpr20",
+	[PERF_REG_POWERPC_GPR21] = "gpr21",
+	[PERF_REG_POWERPC_GPR22] = "gpr22",
+	[PERF_REG_POWERPC_GPR23] = "gpr23",
+	[PERF_REG_POWERPC_GPR24] = "gpr24",
+	[PERF_REG_POWERPC_GPR25] = "gpr25",
+	[PERF_REG_POWERPC_GPR26] = "gpr26",
+	[PERF_REG_POWERPC_GPR27] = "gpr27",
+	[PERF_REG_POWERPC_GPR28] = "gpr28",
+	[PERF_REG_POWERPC_GPR29] = "gpr29",
+	[PERF_REG_POWERPC_GPR30] = "gpr30",
+	[PERF_REG_POWERPC_GPR31] = "gpr31",
+	[PERF_REG_POWERPC_NIP] = "nip",
+	[PERF_REG_POWERPC_MSR] = "msr",
+	[PERF_REG_POWERPC_ORIG_R3] = "orig_r3",
+	[PERF_REG_POWERPC_CTR] = "ctr",
+	[PERF_REG_POWERPC_LNK] = "lnk",
+	[PERF_REG_POWERPC_XER] = "xer",
+	[PERF_REG_POWERPC_CCR] = "ccr",
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
index 38a0853..acf0302 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -23,6 +23,11 @@ $(call detected_var,ARCH)
 
 NO_PERF_REGS := 1
 
+# Additional ARCH settings for ppc64
+ifeq ($(ARCH),powerpc)
+	NO_PERF_REGS := 0
+endif
+
 # Additional ARCH settings for x86
 ifeq ($(ARCH),x86)
   $(call detected,CONFIG_X86)
-- 
2.1.0
