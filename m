Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsPT00w0xzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 06:38:11 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2RJSf4E186294
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 15:38:09 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29f2w3kwb7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 15:38:09 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 28 Mar 2017 01:08:05 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2RJbwfT16122100
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 01:07:58 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2RJc1YC032448
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 01:08:03 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@samba.org>
Subject: [PATCH 1/2] powerpc: string: implement optimized memset variants
Date: Tue, 28 Mar 2017 01:07:40 +0530
In-Reply-To: <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
References: <20170322193030.GA8008@bombadil.infradead.org>
 <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <d6a1a353de6a87bb5474ca9f1c1ff7ab2c4a1eb4.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Based on Matthew Wilcox's patches for other architectures.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/string.h | 24 ++++++++++++++++++++++++
 arch/powerpc/lib/mem_64.S         | 19 ++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index da3cdffca440..b0e82466d4e8 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -23,6 +23,30 @@ extern void * memmove(void *,const void *,__kernel_size_t);
 extern int memcmp(const void *,const void *,__kernel_size_t);
 extern void * memchr(const void *,int,__kernel_size_t);
 
+#ifdef CONFIG_PPC64
+#define __HAVE_ARCH_MEMSET16
+#define __HAVE_ARCH_MEMSET32
+#define __HAVE_ARCH_MEMSET64
+
+extern void *__memset16(uint16_t *, uint16_t v, __kernel_size_t);
+extern void *__memset32(uint32_t *, uint32_t v, __kernel_size_t);
+extern void *__memset64(uint64_t *, uint64_t v, __kernel_size_t);
+
+static inline void *memset16(uint16_t *p, uint16_t v, __kernel_size_t n)
+{
+	return __memset16(p, v, n * 2);
+}
+
+static inline void *memset32(uint32_t *p, uint32_t v, __kernel_size_t n)
+{
+	return __memset32(p, v, n * 4);
+}
+
+static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
+{
+	return __memset64(p, v, n * 8);
+}
+#endif
 #endif /* __KERNEL__ */
 
 #endif	/* _ASM_POWERPC_STRING_H */
diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
index 85fa9869aec5..ec531de99996 100644
--- a/arch/powerpc/lib/mem_64.S
+++ b/arch/powerpc/lib/mem_64.S
@@ -13,6 +13,23 @@
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
 
+_GLOBAL(__memset16)
+	rlwimi	r4,r4,16,0,15
+	/* fall through */
+
+_GLOBAL(__memset32)
+	rldimi	r4,r4,32,0
+	/* fall through */
+
+_GLOBAL(__memset64)
+	neg	r0,r3
+	andi.	r0,r0,7
+	cmplw	cr1,r5,r0
+	b	.Lms
+EXPORT_SYMBOL(__memset16)
+EXPORT_SYMBOL(__memset32)
+EXPORT_SYMBOL(__memset64)
+
 _GLOBAL(memset)
 	neg	r0,r3
 	rlwimi	r4,r4,8,16,23
@@ -20,7 +37,7 @@ _GLOBAL(memset)
 	rlwimi	r4,r4,16,0,15
 	cmplw	cr1,r5,r0		/* do we get that far? */
 	rldimi	r4,r4,32,0
-	PPC_MTOCRF(1,r0)
+.Lms:	PPC_MTOCRF(1,r0)
 	mr	r6,r3
 	blt	cr1,8f
 	beq+	3f			/* if already 8-byte aligned */
-- 
2.11.1
