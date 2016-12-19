Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj1hZ4KtxzDwMM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 00:18:54 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJDEw4x078515
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 08:18:52 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27eg5grk3b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 08:18:52 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 23:18:50 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0B1192BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 00:18:48 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBJDImpv2752886
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 00:18:48 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBJDIkaE011244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 00:18:47 +1100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com, mhiramat@kernel.org,
 anju@linux.vnet.ibm.com
Subject: [PATCH V3 1/4] powerpc: asm/ppc-opcode.h: introduce __PPC_SH64()
Date: Mon, 19 Dec 2016 18:48:26 +0530
In-Reply-To: <1482153507-17350-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1482153507-17350-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1482153507-17350-4-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

Introduce __PPC_SH64() as a 64-bit variant to encode shift field in some
of the shift and rotate instructions operating on double-words. Convert
some of the BPF instruction macros to use the same.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |  1 +
 arch/powerpc/net/bpf_jit.h            | 11 +++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 0132831..630127b 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -306,6 +306,7 @@
 #define __PPC_WC(w)	(((w) & 0x3) << 21)
 #define __PPC_WS(w)	(((w) & 0x1f) << 11)
 #define __PPC_SH(s)	__PPC_WS(s)
+#define __PPC_SH64(s)	(__PPC_SH(s) | (((s) & 0x20) >> 4))
 #define __PPC_MB(s)	(((s) & 0x1f) << 6)
 #define __PPC_ME(s)	(((s) & 0x1f) << 1)
 #define __PPC_MB64(s)	(__PPC_MB(s) | ((s) & 0x20))
diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 89f7007..30cf03f 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -157,8 +157,7 @@
 #define PPC_SRAD(d, a, s)	EMIT(PPC_INST_SRAD | ___PPC_RA(d) |	      \
 				     ___PPC_RS(a) | ___PPC_RB(s))
 #define PPC_SRADI(d, a, i)	EMIT(PPC_INST_SRADI | ___PPC_RA(d) |	      \
-				     ___PPC_RS(a) | __PPC_SH(i) |             \
-				     (((i) & 0x20) >> 4))
+				     ___PPC_RS(a) | __PPC_SH64(i))
 #define PPC_RLWINM(d, a, i, mb, me)	EMIT(PPC_INST_RLWINM | ___PPC_RA(d) | \
 					___PPC_RS(a) | __PPC_SH(i) |	      \
 					__PPC_MB(mb) | __PPC_ME(me))
@@ -166,11 +165,11 @@
 					___PPC_RS(a) | __PPC_SH(i) |	      \
 					__PPC_MB(mb) | __PPC_ME(me))
 #define PPC_RLDICL(d, a, i, mb)		EMIT(PPC_INST_RLDICL | ___PPC_RA(d) | \
-					___PPC_RS(a) | __PPC_SH(i) |	      \
-					__PPC_MB64(mb) | (((i) & 0x20) >> 4))
+					___PPC_RS(a) | __PPC_SH64(i) |	      \
+					__PPC_MB64(mb))
 #define PPC_RLDICR(d, a, i, me)		EMIT(PPC_INST_RLDICR | ___PPC_RA(d) | \
-					___PPC_RS(a) | __PPC_SH(i) |	      \
-					__PPC_ME64(me) | (((i) & 0x20) >> 4))
+					___PPC_RS(a) | __PPC_SH64(i) |	      \
+					__PPC_ME64(me))
 
 /* slwi = rlwinm Rx, Ry, n, 0, 31-n */
 #define PPC_SLWI(d, a, i)	PPC_RLWINM(d, a, i, 0, 31-(i))
-- 
2.7.4
