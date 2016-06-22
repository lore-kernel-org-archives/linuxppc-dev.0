Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZVP23xJxzDqhc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 02:27:18 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MGOd7b113487
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 12:27:16 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23qd1h98ua-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 12:27:16 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 21:57:13 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6825D125805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 21:59:47 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MGRAMW262544
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 21:57:10 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MGR8uK025378
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 21:57:10 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: Matt Evans <matt@ozlabs.org>, Denis Kirjanov <kda@linux-powerpc.org>,
 Paul Mackerras <paulus@samba.org>, Alexei Starovoitov <ast@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Subject: [PATCHv2 3/7] ppc: bpf/jit: Optimize 64-bit Immediate loads
Date: Wed, 22 Jun 2016 21:55:03 +0530
In-Reply-To: <cover.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <ea92fc972da7acb37c33071c96f66ea748724d0c.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
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
2.8.2
