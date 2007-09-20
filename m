Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 864EEDDDFB
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 00:00:25 +1000 (EST)
Date: Thu, 20 Sep 2007 16:00:11 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/3 v2] powerpc clk.h interface for platforms
Message-ID: <20070920140011.GK32628@nd47.coderock.org>
References: <20070711093113.GE4375@moe.telargo.com>
	<20070711093220.GF4375@moe.telargo.com>
	<20070806065857.GN4529@moe.telargo.com>
	<18160.39896.132391.625791@cargo.ozlabs.ibm.com>
	<20070919051157.GH32628@nd47.coderock.org>
	<18162.1.982956.610996@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18162.1.982956.610996@cargo.ozlabs.ibm.com>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Sylvain Munaut <tnt@246tNt.com>
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
On 20/09/07 15:07 +1000, Paul Mackerras wrote:
> Domen Puncer writes:
> 
> > 52xx
> > Reason for adding it to all was that EXPORT_SYMBOL's would clash if
> > one were to add clk support for another platform.
> 
> What I meant was, why aren't you using a config symbol so that we
> don't build it on platforms that don't need any "clk" support at all?

Right, doh!

> 
> Paul.


 arch/powerpc/Kconfig                |    4 +
 arch/powerpc/kernel/Makefile        |    1 
 arch/powerpc/kernel/clock.c         |   82 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/Kconfig |    1 
 include/asm-powerpc/clk_interface.h |   20 ++++++++
 5 files changed, 108 insertions(+)

Index: linux.git/arch/powerpc/kernel/clock.c
===================================================================
--- /dev/null
+++ linux.git/arch/powerpc/kernel/clock.c
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
Index: linux.git/include/asm-powerpc/clk_interface.h
===================================================================
--- /dev/null
+++ linux.git/include/asm-powerpc/clk_interface.h
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
Index: linux.git/arch/powerpc/kernel/Makefile
===================================================================
--- linux.git.orig/arch/powerpc/kernel/Makefile
+++ linux.git/arch/powerpc/kernel/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
 obj-$(CONFIG_PPC_OF)		+= of_device.o of_platform.o prom_parse.o
+obj-$(CONFIG_PPC_CLOCK)		+= clock.o
 procfs-$(CONFIG_PPC64)		:= proc_ppc64.o
 obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
 rtaspci-$(CONFIG_PPC64)-$(CONFIG_PCI)	:= rtas_pci.o
Index: linux.git/arch/powerpc/Kconfig
===================================================================
--- linux.git.orig/arch/powerpc/Kconfig
+++ linux.git/arch/powerpc/Kconfig
@@ -664,3 +664,7 @@ config KEYS_COMPAT
 	default y
 
 source "crypto/Kconfig"
+
+config PPC_CLOCK
+	bool
+	default n
Index: linux.git/arch/powerpc/platforms/52xx/Kconfig
===================================================================
--- linux.git.orig/arch/powerpc/platforms/52xx/Kconfig
+++ linux.git/arch/powerpc/platforms/52xx/Kconfig
@@ -1,6 +1,7 @@
 config PPC_MPC52xx
 	bool
 	select FSL_SOC
+	select PPC_CLOCK
 	default n
 
 config PPC_MPC5200
