Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 791BEDDEEC
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 14:14:38 +1000 (EST)
Message-Id: <20080515035918.745026737@goodmis.org>
References: <20080515034942.109223655@goodmis.org>
Date: Wed, 14 May 2008 23:49:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 1/2] ftrace ppc: add irqs_disabled_flags to ppc
Cc: proski@gnu.org, a.p.zijlstra@chello.nl, pq@iki.fi,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <srostedt@redhat.com>, linuxppc-dev@ozlabs.org,
	sandmann@redhat.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PPC doesn't have the irqs_disabled_flags needed by ftrace.
This patch adds it.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 include/asm-powerpc/hw_irq.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-sched-devel.git/include/asm-powerpc/hw_irq.h
===================================================================
--- linux-sched-devel.git.orig/include/asm-powerpc/hw_irq.h	2008-05-14 18:12:21.000000000 -0700
+++ linux-sched-devel.git/include/asm-powerpc/hw_irq.h	2008-05-14 19:24:59.000000000 -0700
@@ -59,6 +59,11 @@ extern void iseries_handle_interrupts(vo
 		get_paca()->hard_enabled = 0;	\
 	} while(0)
 
+static inline int irqs_disabled_flags(unsigned long flags)
+{
+	return flags == 0;
+}
+
 #else
 
 #if defined(CONFIG_BOOKE)
@@ -113,6 +118,11 @@ static inline void local_irq_save_ptr(un
 #define hard_irq_enable()	local_irq_enable()
 #define hard_irq_disable()	local_irq_disable()
 
+static inline int irqs_disabled_flags(unsigned long flags)
+{
+	return (flags & MSR_EE) == 0;
+}
+
 #endif /* CONFIG_PPC64 */
 
 /*

-- 
