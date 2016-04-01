Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbxj53BvlzDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:00:57 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 20:00:54 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 10D562BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:00:40 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u31A0VRK7602606
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 21:00:39 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u31A06dS001761
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 21:00:07 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: oss@buserror.net, Matt Evans <matt@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Alexei Starovoitov <ast@fb.com>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [RFC PATCH 1/6] ppc: bpf/jit: Fix/enhance 32-bit Load Immediate
 implementation
Date: Fri,  1 Apr 2016 15:28:26 +0530
Message-Id: <770e1d46546d93be5248fb9d398bf57a925faa74.1459504223.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1459504222.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1459504222.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1459504222.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1459504222.git.naveen.n.rao@linux.vnet.ibm.com>
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
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
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
2.7.4
