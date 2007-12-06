Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Dec 2007 19:00:21 +1100
Subject: [PATCH 22/25] powerpc: Add mfspr/mtspr inline macros to 4xx
	bootwrapper
In-Reply-To: <1196927999.714593.205329520306.qpush@grosgo>
Message-Id: <20071206080132.E2202DE127@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 4xx bootwrapper occasionally needs to access SPR registers,
this adds mfspr/mtspr wrappers to it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

===================================================================
 arch/powerpc/boot/reg.h |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-work/arch/powerpc/boot/reg.h
===================================================================
--- linux-work.orig/arch/powerpc/boot/reg.h	2007-12-03 11:48:00.000000000 +1100
+++ linux-work/arch/powerpc/boot/reg.h	2007-12-03 13:44:06.000000000 +1100
@@ -16,6 +16,14 @@ static inline u32 mfpvr(void)
 	return pvr;
 }
 
+#define __stringify_1(x)	#x
+#define __stringify(x)		__stringify_1(x)
+
+#define mfspr(rn)	({unsigned long rval; \
+			asm volatile("mfspr %0," __stringify(rn) \
+				: "=r" (rval)); rval; })
+#define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : : "r" (v))
+
 register void *__stack_pointer asm("r1");
 #define get_sp()	(__stack_pointer)
 
