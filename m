Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2007 17:11:05 +1100
Subject: [PATCH 22/24] powerpc: Add mfspr/mtspr inline macros to 4xx
	bootwrapper
In-Reply-To: <1196403038.569525.367459803520.qpush@grosgo>
Message-Id: <20071130061207.A21AADDF04@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
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
--- linux-work.orig/arch/powerpc/boot/reg.h	2007-11-27 14:37:00.000000000 +1100
+++ linux-work/arch/powerpc/boot/reg.h	2007-11-27 14:37:58.000000000 +1100
@@ -16,6 +16,14 @@ static inline u32 mfpvr(void)
 	return pvr;
 }
 
+#define __stringify_1(x)	#x
+#define __stringify(x)		__stringify_1(x)
+
+#define mfspr(rn)	({unsigned long rval; \
+			asm volatile("mfspr %0," __stringify(rn) \
+				: "=r" (rval)); rval;})
+#define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : : "r" (v))
+
 register void *__stack_pointer asm("r1");
 #define get_sp()	(__stack_pointer)
 
