Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vQghr36JtzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 06:59:40 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1IJwggW054355
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 14:59:37 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28pk9nhp3e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 14:59:36 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 19 Feb 2017 05:59:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DFF213578052
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 06:59:31 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1IJxNkA36831238
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 06:59:31 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1IJwxlS008299
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 06:58:59 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Add PROBENOP macro for debug
Date: Sun, 19 Feb 2017 01:28:34 +0530
Message-Id: <1487447914-7094-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From PowerISA v2.07, architecture provides a special NOP
instruction called "Probe-Nop" defined as "and 0,0,0".
This form of "and" is reserved for use exclusively by the
Performance Monitor.

Usage example:

Add PROBENOP() macro to __tlbie() in hash_native_64.c to
verify the number of TLBIE. Power8 provides "PM_TLBIE_FIN"
PMU event (r30058) to count "tlbie finished".

Power8 PMU event "PM_PROBE_NOP_DISP" (r40014) counts the
"ProbeNops dispatched".

With modified kernel booted, output from perf:

# ./perf stat -e r30058,r40014 ls
....
 Performance counter stats for 'ls':

                 7      r30058
                 7      r40014

       0.003296959 seconds time elapsed

Macro comes handy when want to count specific instructions
which may or may not have a PMU event.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index c4ced1d01d57..61c62a1a402c 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -462,4 +462,14 @@
 				       ((IH & 0x7) << 21))
 #define PPC_INVALIDATE_ERAT	PPC_SLBIA(7)
 
+/*
+ * From PowerISA v2.07, architecture provides a special NOP instruction
+ * called "Probe-Nop" defined as "and 0,0,0". This form of "and" is
+ * reserved for use exclusively by the Performance Monitor.
+ */
+#define _PROBENOP(x)	stringify_in_c(.long PPC_INST_AND	|	\
+						___PPC_RS(x)	|	\
+						___PPC_RA(x)	|	\
+						___PPC_RB(x))
+#define PROBENOP(x)	asm volatile(_PROBENOP(x))
 #endif /* _ASM_POWERPC_PPC_OPCODE_H */
-- 
2.7.4
