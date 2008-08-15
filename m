Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 15 Aug 2008 17:11:31 +1000
Subject: [PATCH] powerpc: Fix lockdep IRQ tracing bug
Message-Id: <20080815071200.61259DE140@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A small bogon sneaked into the ppc64 lockdep support. A test is
branching slightly off causing a clobbered register value to
overwrite the irq state under some circumstances.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This explains some of the reported weird lockdep errors, maybe
even all of them, we'll see.

We should probably backport that to 2.6.26-stable too, any candidate ?

 arch/powerpc/include/asm/irqflags.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/irqflags.h	2008-08-15 16:48:43.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/irqflags.h	2008-08-15 16:51:02.000000000 +1000
@@ -20,7 +20,7 @@
 #define TRACE_ENABLE_INTS	bl .trace_hardirqs_on
 #define TRACE_DISABLE_INTS	bl .trace_hardirqs_off
 #define TRACE_AND_RESTORE_IRQ_PARTIAL(en,skip)	\
-	cmpdi	en, 0;				\
+	cmpdi	en,0;				\
 	bne	95f;				\
 	stb	en,PACASOFTIRQEN(r13);		\
 	bl	.trace_hardirqs_off;		\
@@ -29,7 +29,8 @@
 	li	en,1;
 #define TRACE_AND_RESTORE_IRQ(en)		\
 	TRACE_AND_RESTORE_IRQ_PARTIAL(en,96f);	\
-96:	stb	en,PACASOFTIRQEN(r13)
+	stb	en,PACASOFTIRQEN(r13);	        \
+96:
 #else
 #define TRACE_ENABLE_INTS
 #define TRACE_DISABLE_INTS
