Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZVP271n3zDqks
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 02:27:18 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MGOb5r136803
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 12:27:17 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q1qp3bpe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 12:27:17 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 21:57:13 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D419EE0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 22:00:53 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MGR9Mh43122858
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 21:57:10 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MGR7Yd025365
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 21:57:09 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: Matt Evans <matt@ozlabs.org>, Denis Kirjanov <kda@linux-powerpc.org>,
 Paul Mackerras <paulus@samba.org>, Alexei Starovoitov <ast@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Subject: [PATCHv2 2/7] ppc: bpf/jit: Fix/enhance 32-bit Load Immediate
 implementation
Date: Wed, 22 Jun 2016 21:55:02 +0530
In-Reply-To: <cover.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <d584015e9fb33ed526d693c5ab3c228d385f3c74.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing LI32() macro can sometimes result in a sign-extended 32-bit
load that does not clear the top 32-bits properly. As an example,
loading 0x7fffffff results in the register containing
0xffffffff7fffffff. While this does not impact classic BPF JIT
implementation (since that only uses the lower word for all operations),
we would like to share this macro between classic BPF JIT and extended
BPF JIT, wherein the entire 64-bit value in the register matters. Fix
this by first doing a shifted LI followed by ORI.

An additional optimization is with loading values between -32768 to -1,
where we now only need a single LI.

The new implementation now generates the same or less number of
instructions.

Cc: Matt Evans <matt@ozlabs.org>
Cc: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 889fd19..a9882db 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -232,10 +232,17 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 					     (((cond) & 0x3ff) << 16) |	      \
 					     (((dest) - (ctx->idx * 4)) &     \
 					      0xfffc))
-#define PPC_LI32(d, i)		do { PPC_LI(d, IMM_L(i));		      \
-		if ((u32)(uintptr_t)(i) >= 32768) {			      \
-			PPC_ADDIS(d, d, IMM_HA(i));			      \
+/* Sign-extended 32-bit immediate load */
+#define PPC_LI32(d, i)		do {					      \
+		if ((int)(uintptr_t)(i) >= -32768 &&			      \
+				(int)(uintptr_t)(i) < 32768)		      \
+			PPC_LI(d, i);					      \
+		else {							      \
+			PPC_LIS(d, IMM_H(i));				      \
+			if (IMM_L(i))					      \
+				PPC_ORI(d, d, IMM_L(i));		      \
 		} } while(0)
+
 #define PPC_LI64(d, i)		do {					      \
 		if (!((uintptr_t)(i) & 0xffffffff00000000ULL))		      \
 			PPC_LI32(d, i);					      \
-- 
2.8.2
