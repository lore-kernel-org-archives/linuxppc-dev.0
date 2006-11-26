Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Sun, 26 Nov 2006 17:36:15 +1100
Subject: [PATCH] Provide dummy hard_irq_enable/disable() for PPC32
Message-Id: <20061126063616.A186067B22@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, rutger@nospam.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To allow arch/powerpc/kernel/crash.c to build on 32-bit we need a
definition of hard_irq_disable(). 32-bit doesn't support the lazy
interrupt disabling mechanism, so on 32-bit hard_irq_disable() is
simply local_irq_disable(). Add a definition for hard_irq_enable()
just for completeness.

This allows (KEXEC=y && PPC32=y) to build again. Broken since
d04c56f73c30a5e593202ecfcf25ed43d42363a2.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
Paulus,

if this is OK by you, I think it should probably go in for 2.6.19.

---
 include/asm-powerpc/hw_irq.h |    3 +++
 1 file changed, 3 insertions(+)

Index: powerpc/include/asm-powerpc/hw_irq.h
===================================================================
--- powerpc.orig/include/asm-powerpc/hw_irq.h
+++ powerpc/include/asm-powerpc/hw_irq.h
@@ -92,6 +92,9 @@ static inline void local_irq_save_ptr(un
 #define local_irq_save(flags)	local_irq_save_ptr(&flags)
 #define irqs_disabled()		((mfmsr() & MSR_EE) == 0)
 
+#define hard_irq_enable()	local_irq_enable()
+#define hard_irq_disable()	local_irq_disable()
+
 #endif /* CONFIG_PPC64 */
 
 #define mask_irq(irq)						\
