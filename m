Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 22E54B6FAA
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2012 13:52:42 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Mon, 5 Mar 2012 02:44:36 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q252kqpS2150546
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:46:54 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q252qQ57007482
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:52:26 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/13] powerpc: Improve behaviour of irq tracing on 64-bit
 exception entry
Date: Mon,  5 Mar 2012 13:51:23 +1100
Message-Id: <1330915891-19523-6-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
References: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some exceptions would unconditionally disable interrupts on entry,
which is fine, but calling lockdep every time not only adds more
overhead than strictly needed, but also means we get quite a few
"redudant" disable logged, which makes it hard to spot the really
bad ones.

So instead, split the macro used by the exception code into a
normal one and a separate one used when CONFIG_TRACE_IRQFLAGS is
enabled, and make the later skip th tracing if interrupts were
already disabled.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/exception-64s.h |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index bdc9eeb..7f4718c 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -272,15 +272,34 @@ label##_hv:								\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
 				    EXC_HV, SOFTEN_TEST_HV)
 
+/*
+ * Our exception common code can be passed various "additions"
+ * to specify the behaviour of interrupts, whether to kick the
+ * runlatch, etc...
+ */
+
+/* Exception addition: Hard disable interrupts */
+#ifdef CONFIG_TRACE_IRQFLAGS
 #define DISABLE_INTS				\
+	lbz	r10,PACASOFTIRQEN(r13);		\
 	li	r11,0;				\
-	stb	r11,PACASOFTIRQEN(r13);		\
+	cmpwi	cr0,r10,0;			\
 	stb	r11,PACAHARDIRQEN(r13);		\
-	TRACE_DISABLE_INTS
+	beq	44f;				\
+	stb	r11,PACASOFTIRQEN(r13);		\
+	TRACE_DISABLE_INTS;			\
+44:
+#else
+#define DISABLE_INTS				\
+	li	r11,0;				\
+	stb	r11,PACASOFTIRQEN(r13);		\
+	stb	r11,PACAHARDIRQEN(r13)
+#endif /* CONFIG_TRACE_IRQFLAGS */
 
+/* Exception addition: Keep interrupt state */
 #define ENABLE_INTS				\
-	ld	r12,_MSR(r1);			\
 	mfmsr	r11;				\
+	ld	r12,_MSR(r1);			\
 	rlwimi	r11,r12,0,MSR_EE;		\
 	mtmsrd	r11,1
 
-- 
1.7.9
