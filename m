Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbxj64FRpzDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:00:58 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 20:00:56 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 421DE2BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:00:47 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u31A0dB1721280
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 21:00:47 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u31A0DRC002107
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 21:00:14 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: oss@buserror.net, Matt Evans <matt@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Alexei Starovoitov <ast@fb.com>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [RFC PATCH 2/6] ppc: bpf/jit: Optimize 64-bit Immediate loads
Date: Fri,  1 Apr 2016 15:28:27 +0530
Message-Id: <0ee6c297b15afae8391cd058ff03f999d62d8fa9.1459504223.git.naveen.n.rao@linux.vnet.ibm.com>
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

Similar to the LI32() optimization, if the value can be represented
in 32-bits, use LI32(). Also handle loading a few specific forms of
immediate values in an optimum manner.

While at it, remove the semicolon at the end of the macro!

Cc: Matt Evans <matt@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index a9882db..4c1e055 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -244,20 +244,25 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 		} } while(0)
 
 #define PPC_LI64(d, i)		do {					      \
-		if (!((uintptr_t)(i) & 0xffffffff00000000ULL))		      \
+		if ((long)(i) >= -2147483648 &&				      \
+				(long)(i) < 2147483648)			      \
 			PPC_LI32(d, i);					      \
 		else {							      \
-			PPC_LIS(d, ((uintptr_t)(i) >> 48));		      \
-			if ((uintptr_t)(i) & 0x0000ffff00000000ULL)	      \
-				PPC_ORI(d, d,				      \
-					((uintptr_t)(i) >> 32) & 0xffff);     \
+			if (!((uintptr_t)(i) & 0xffff800000000000ULL))	      \
+				PPC_LI(d, ((uintptr_t)(i) >> 32) & 0xffff);   \
+			else {						      \
+				PPC_LIS(d, ((uintptr_t)(i) >> 48));	      \
+				if ((uintptr_t)(i) & 0x0000ffff00000000ULL)   \
+					PPC_ORI(d, d,			      \
+					  ((uintptr_t)(i) >> 32) & 0xffff);   \
+			}						      \
 			PPC_SLDI(d, d, 32);				      \
 			if ((uintptr_t)(i) & 0x00000000ffff0000ULL)	      \
 				PPC_ORIS(d, d,				      \
 					 ((uintptr_t)(i) >> 16) & 0xffff);    \
 			if ((uintptr_t)(i) & 0x000000000000ffffULL)	      \
 				PPC_ORI(d, d, (uintptr_t)(i) & 0xffff);	      \
-		} } while (0);
+		} } while (0)
 
 #ifdef CONFIG_PPC64
 #define PPC_FUNC_ADDR(d,i) do { PPC_LI64(d, i); } while(0)
-- 
2.7.4
