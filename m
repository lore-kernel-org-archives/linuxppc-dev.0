Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t82205D9hzDvMr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 19:53:28 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA28mWgo022647
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 04:53:26 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26fcmxs5xg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 04:53:26 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Wed, 2 Nov 2016 18:53:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 95A4D2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 19:53:21 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA28rLlg10354694
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 19:53:21 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA28rJcF005715
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 19:53:21 +1100
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, lsorense@csclub.uwaterloo.ca,
 oohall@gmail.com, naveen.n.rao@linux.vnet.ibm.com, ast@kernel.org,
 chris@distroguy.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, paul.gortmaker@windriver.com,
 bauerman@linux.vnet.ibm.com, viro@zeniv.linux.org.uk,
 christophe.leroy@c-s.fr, duwe@lst.de, oss@buserror.net,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc: Add encoding for couple of load/store
 instructions
Date: Wed,  2 Nov 2016 14:23:02 +0530
In-Reply-To: <1478076783-2872-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1478076783-2872-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1478076783-2872-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These encodings will be used in subsequent patch that test
emulate_step for load/store instructions.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 0132831..a17a09a 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -284,6 +284,13 @@
 #define PPC_INST_BRANCH_COND		0x40800000
 #define PPC_INST_LBZCIX			0x7c0006aa
 #define PPC_INST_STBCIX			0x7c0007aa
+#define PPC_INST_LWZX			0x7c00002e
+#define PPC_INST_LFSX			0x7c00042e
+#define PPC_INST_STFSX			0x7c00052e
+#define PPC_INST_LFDX			0x7c0004ae
+#define PPC_INST_STFDX			0x7c0005ae
+#define PPC_INST_LVX			0x7c0000ce
+#define PPC_INST_STVX			0x7c0001ce
 
 /* macros to insert fields into opcodes */
 #define ___PPC_RA(a)	(((a) & 0x1f) << 16)
-- 
1.8.3.1
