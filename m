Return-Path: <anton@samba.org>
Date: Wed, 23 May 2012 14:47:48 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: tracing: Avoid tracepoint duplication with
 DECLARE_EVENT_CLASS
Message-ID: <20120523144748.288d2e4a@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


irq_entry, irq_exit, timer_interrupt_entry and timer_interrupt_exit
all do the same thing so use DECLARE_EVENT_CLASS to avoid duplicating
everything 4 times.

This saves quite a lot of space in both instruction text and data:

   text    data     bss     dec     hex filename
   9265   19622      16   28903    70e7 arch/powerpc/kernel/irq.o
   6817   19019      16   25852    64fc arch/powerpc/kernel/irq.o

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/include/asm/trace.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/trace.h	2012-05-23 13:30:51.235534219 +1000
+++ linux-build/arch/powerpc/include/asm/trace.h	2012-05-23 14:10:44.406639628 +1000
@@ -8,7 +8,7 @@
 
 struct pt_regs;
 
-TRACE_EVENT(irq_entry,
+DECLARE_EVENT_CLASS(ppc64_interrupt_class,
 
 	TP_PROTO(struct pt_regs *regs),
 
@@ -25,55 +25,32 @@ TRACE_EVENT(irq_entry,
 	TP_printk("pt_regs=%p", __entry->regs)
 );
 
-TRACE_EVENT(irq_exit,
+DEFINE_EVENT(ppc64_interrupt_class, irq_entry,
 
 	TP_PROTO(struct pt_regs *regs),
 
-	TP_ARGS(regs),
-
-	TP_STRUCT__entry(
-		__field(struct pt_regs *, regs)
-	),
-
-	TP_fast_assign(
-		__entry->regs = regs;
-	),
-
-	TP_printk("pt_regs=%p", __entry->regs)
+	TP_ARGS(regs)
 );
 
-TRACE_EVENT(timer_interrupt_entry,
+DEFINE_EVENT(ppc64_interrupt_class, irq_exit,
 
 	TP_PROTO(struct pt_regs *regs),
 
-	TP_ARGS(regs),
-
-	TP_STRUCT__entry(
-		__field(struct pt_regs *, regs)
-	),
-
-	TP_fast_assign(
-		__entry->regs = regs;
-	),
-
-	TP_printk("pt_regs=%p", __entry->regs)
+	TP_ARGS(regs)
 );
 
-TRACE_EVENT(timer_interrupt_exit,
+DEFINE_EVENT(ppc64_interrupt_class, timer_interrupt_entry,
 
 	TP_PROTO(struct pt_regs *regs),
 
-	TP_ARGS(regs),
+	TP_ARGS(regs)
+);
 
-	TP_STRUCT__entry(
-		__field(struct pt_regs *, regs)
-	),
+DEFINE_EVENT(ppc64_interrupt_class, timer_interrupt_exit,
 
-	TP_fast_assign(
-		__entry->regs = regs;
-	),
+	TP_PROTO(struct pt_regs *regs),
 
-	TP_printk("pt_regs=%p", __entry->regs)
+	TP_ARGS(regs)
 );
 
 #ifdef CONFIG_PPC_PSERIES
