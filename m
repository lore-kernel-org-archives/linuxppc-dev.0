Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 261C8B6F9F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jul 2011 07:02:22 +1000 (EST)
Date: Mon, 25 Jul 2011 16:02:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: mtspr/mtmsr should take an unsigned long
Message-ID: <20110725210210.GA3777@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a cast in case the caller passes in a different type, as it would
if mtspr/mtmsr were functions.

Previously, if a 64-bit type was passed in on 32-bit, GCC would bind the
constraint to a pair of registers, and would substitute the first register
in the pair in the asm code.  This corresponds to the upper half of the
64-bit register, which is generally not the desired behavior.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
If you're wondering why you'd pass a 64-bit value to one of these macros
on 32-bit, it came up when trying to load an SPR from kvm_vcpu_arch_shared.

 arch/powerpc/include/asm/reg.h |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 213d1d7..1b45133 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1007,13 +1007,16 @@
 #define mtmsrd(v)	__mtmsrd((v), 0)
 #define mtmsr(v)	mtmsrd(v)
 #else
-#define mtmsr(v)	asm volatile("mtmsr %0" : : "r" (v) : "memory")
+#define mtmsr(v)	asm volatile("mtmsr %0" : \
+				     : "r" ((unsigned long)(v)) \
+				     : "memory")
 #endif
 
 #define mfspr(rn)	({unsigned long rval; \
 			asm volatile("mfspr %0," __stringify(rn) \
 				: "=r" (rval)); rval;})
-#define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : : "r" (v)\
+#define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : \
+				     : "r" ((unsigned long)(v)) \
 				     : "memory")
 
 #ifdef __powerpc64__
-- 
1.7.4.1
