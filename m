Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 58B52DDE05
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 19:44:32 +1000 (EST)
Date: Wed, 11 Jul 2007 11:32:20 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc clk.h interface for platforms
Message-ID: <20070711093220.GF4375@moe.telargo.com>
References: <20070711093113.GE4375@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070711093113.GE4375@moe.telargo.com>
Cc: David Brownell <david-b@pacbell.net>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

clk interface for arch/powerpc, platforms should fill
clk_functions.

Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 arch/powerpc/kernel/Makefile        |    3 -
 arch/powerpc/kernel/clock.c         |   82 ++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/clk_interface.h |   20 ++++++++
 3 files changed, 104 insertions(+), 1 deletion(-)

Index: work-powerpc.git/arch/powerpc/kernel/clock.c
===================================================================
--- /dev/null
+++ work-powerpc.git/arch/powerpc/kernel/clock.c
@@ -0,0 +1,82 @@
+/*
+ * Dummy clk implementations for powerpc.
+ * These need to be overridden in platform code.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <asm/clk_interface.h>
+
+struct clk_interface clk_functions;
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	if (clk_functions.clk_get)
+		return clk_functions.clk_get(dev, id);
+	return ERR_PTR(-ENOSYS);
+}
+EXPORT_SYMBOL(clk_get);
+
+void clk_put(struct clk *clk)
+{
+	if (clk_functions.clk_put)
+		clk_functions.clk_put(clk);
+}
+EXPORT_SYMBOL(clk_put);
+
+int clk_enable(struct clk *clk)
+{
+	if (clk_functions.clk_enable)
+		return clk_functions.clk_enable(clk);
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+	if (clk_functions.clk_disable)
+		clk_functions.clk_disable(clk);
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	if (clk_functions.clk_get_rate)
+		return clk_functions.clk_get_rate(clk);
+	return 0;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (clk_functions.clk_round_rate)
+		return clk_functions.clk_round_rate(clk, rate);
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	if (clk_functions.clk_set_rate)
+		return clk_functions.clk_set_rate(clk, rate);
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	if (clk_functions.clk_get_parent)
+		return clk_functions.clk_get_parent(clk);
+	return ERR_PTR(-ENOSYS);
+}
+EXPORT_SYMBOL(clk_get_parent);
+
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	if (clk_functions.clk_set_parent)
+		return clk_functions.clk_set_parent(clk, parent);
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(clk_set_parent);
Index: work-powerpc.git/include/asm-powerpc/clk_interface.h
===================================================================
--- /dev/null
+++ work-powerpc.git/include/asm-powerpc/clk_interface.h
@@ -0,0 +1,20 @@
+#ifndef __ASM_POWERPC_CLK_INTERFACE_H
+#define __ASM_POWERPC_CLK_INTERFACE_H
+
+#include <linux/clk.h>
+
+struct clk_interface {
+	struct clk*	(*clk_get)	(struct device *dev, const char *id);
+	int		(*clk_enable)	(struct clk *clk);
+	void		(*clk_disable)	(struct clk *clk);
+	unsigned long	(*clk_get_rate)	(struct clk *clk);
+	void		(*clk_put)	(struct clk *clk);
+	long		(*clk_round_rate) (struct clk *clk, unsigned long rate);
+	int 		(*clk_set_rate)	(struct clk *clk, unsigned long rate);
+	int		(*clk_set_parent) (struct clk *clk, struct clk *parent);
+	struct clk*	(*clk_get_parent) (struct clk *clk);
+};
+
+extern struct clk_interface clk_functions;
+
+#endif /* __ASM_POWERPC_CLK_INTERFACE_H */
Index: work-powerpc.git/arch/powerpc/kernel/Makefile
===================================================================
--- work-powerpc.git.orig/arch/powerpc/kernel/Makefile
+++ work-powerpc.git/arch/powerpc/kernel/Makefile
@@ -12,7 +12,8 @@ endif
 
 obj-y				:= semaphore.o cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
-				   init_task.o process.o systbl.o idle.o
+				   init_task.o process.o systbl.o idle.o \
+				   clock.o
 obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o binfmt_elf32.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
