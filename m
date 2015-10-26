Return-Path: <anju@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4265A1A0A09
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 23:45:11 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 26 Oct 2015 22:45:09 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7EB3D2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 23:45:05 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9QCiwVD32571550
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 23:45:06 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9QCiWmc004636
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 23:44:32 +1100
From: Anju T <anju@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: sukadev@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, acme@redhat.com, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH V2 1/3] perf/powerpc:add ability to sample intr machine state
 in power
Date: Mon, 26 Oct 2015 18:14:06 +0530
Message-Id: <1445863448-5746-2-git-send-email-anju@linux.vnet.ibm.com>
In-Reply-To: <1445863448-5746-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1445863448-5746-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The enum definition assigns an 'id' to each register in "struct pt_regs" 
of arch/powerpc.The order of these values in the enum definition are 
based on the corresponding macros in 
arch/powerpc/include/uapi/asm/ptrace.h .

Signed-off-by: Anju T <anju@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/perf_regs.h | 55 +++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 arch/powerpc/include/uapi/asm/perf_regs.h

diff --git a/arch/powerpc/include/uapi/asm/perf_regs.h b/arch/powerpc/include/uapi/asm/perf_regs.h
new file mode 100644
index 0000000..b97727c
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/perf_regs.h
@@ -0,0 +1,55 @@
+#ifndef _ASM_POWERPC_PERF_REGS_H
+#define _ASM_POWERPC_PERF_REGS_H
+
+enum perf_event_powerpc_regs {
+	PERF_REG_POWERPC_GPR0,
+	PERF_REG_POWERPC_GPR1,
+	PERF_REG_POWERPC_GPR2,
+	PERF_REG_POWERPC_GPR3,
+	PERF_REG_POWERPC_GPR4,
+	PERF_REG_POWERPC_GPR5,
+	PERF_REG_POWERPC_GPR6,
+	PERF_REG_POWERPC_GPR7,
+	PERF_REG_POWERPC_GPR8,
+	PERF_REG_POWERPC_GPR9,
+	PERF_REG_POWERPC_GPR10,
+	PERF_REG_POWERPC_GPR11,
+	PERF_REG_POWERPC_GPR12,
+	PERF_REG_POWERPC_GPR13,
+	PERF_REG_POWERPC_GPR14,
+	PERF_REG_POWERPC_GPR15,
+	PERF_REG_POWERPC_GPR16,
+	PERF_REG_POWERPC_GPR17,
+	PERF_REG_POWERPC_GPR18,
+	PERF_REG_POWERPC_GPR19,
+	PERF_REG_POWERPC_GPR20,
+	PERF_REG_POWERPC_GPR21,
+	PERF_REG_POWERPC_GPR22,
+	PERF_REG_POWERPC_GPR23,
+	PERF_REG_POWERPC_GPR24,
+	PERF_REG_POWERPC_GPR25,
+	PERF_REG_POWERPC_GPR26,
+	PERF_REG_POWERPC_GPR27,
+	PERF_REG_POWERPC_GPR28,
+	PERF_REG_POWERPC_GPR29,
+	PERF_REG_POWERPC_GPR30,
+	PERF_REG_POWERPC_GPR31,
+	PERF_REG_POWERPC_NIP,
+	PERF_REG_POWERPC_MSR,
+	PERF_REG_POWERPC_ORIG_R3,
+	PERF_REG_POWERPC_CTR,
+	PERF_REG_POWERPC_LNK,
+	PERF_REG_POWERPC_XER,
+	PERF_REG_POWERPC_CCR,
+#ifdef __powerpc64__
+	PERF_REG_POWERPC_SOFTE,
+#else
+	PERF_REG_POWERPC_MQ,
+#endif
+	PERF_REG_POWERPC_TRAP,
+	PERF_REG_POWERPC_DAR,
+	PERF_REG_POWERPC_DSISR,
+	PERF_REG_POWERPC_RESULT,
+	PERF_REG_POWERPC_MAX,
+};
+#endif /* _ASM_POWERPC_PERF_REGS_H */
-- 
2.1.0
