Return-Path: <alistair@popple.id.au>
Received: from ipmail05.adl6.internode.on.net (ipmail05.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:5])
 by ozlabs.org (Postfix) with ESMTP id 69EFD2C022C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 18:01:14 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: benh@kernel.crashing.org
Subject: [PATCH] ppc476: Enable a linker work around for IBM errata #46
Date: Mon, 24 Feb 2014 18:00:56 +1100
Message-Id: <1393225256-21122-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds an option to enable a work around for an icache bug on
476 that can cause execution of stale instructions when falling
through pages (IBM errata #46). It requires a recent version of
binutils which supports the --ppc476-workaround option.

The work around enables the appropriate linker options and ensures
that all module output sections are aligned to 4K page boundaries. The
work around is only required when building modules.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/Makefile                         |    5 +++++
 arch/powerpc/platforms/44x/Kconfig            |   14 ++++++++++++++
 arch/powerpc/platforms/44x/ppc476_modules.lds |   15 +++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 arch/powerpc/platforms/44x/ppc476_modules.lds

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 0f4344e..2b13616 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -158,6 +158,11 @@ CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)
 
 KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
 
+ifeq ($(CONFIG_476FPE_ERR46),y)
+	KBUILD_LDFLAGS_MODULE += --ppc476-workaround \
+		-T $(srctree)/arch/powerpc/platforms/44x/ppc476_modules.lds
+endif
+
 # No AltiVec or VSX instructions when building kernel
 KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
 KBUILD_CFLAGS += $(call cc-option,-mno-vsx)
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index d6c7506..b817bf58 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -324,6 +324,20 @@ config APM821xx
 	select IBM_EMAC_EMAC4
 	select IBM_EMAC_TAH
 
+config 476FPE_ERR46
+	depends on 476FPE
+	bool "Enable linker work around for PPC476FPE errata #46"
+	help
+	  This option enables a work around for an icache bug on 476
+	  that can cause execution of stale instructions when falling
+	  through pages (IBM errata #46). It requires a recent version
+	  of binutils which supports the --ppc476-workaround option.
+
+	  The work around enables the appropriate linker options and
+	  ensures that all module output sections are aligned to 4K
+	  page boundaries. The work around is only required when
+	  building modules.
+
 # 44x errata/workaround config symbols, selected by the CPU models above
 config IBM440EP_ERR42
 	bool
diff --git a/arch/powerpc/platforms/44x/ppc476_modules.lds b/arch/powerpc/platforms/44x/ppc476_modules.lds
new file mode 100644
index 0000000..9fec5d3
--- /dev/null
+++ b/arch/powerpc/platforms/44x/ppc476_modules.lds
@@ -0,0 +1,15 @@
+SECTIONS
+{
+	.text : ALIGN(4096)
+	{
+		*(.text .text.* .fixup)
+	}
+	.init.text : ALIGN(4096)
+	{
+		*(.init.text .init.text.*)
+	}
+	.exit.text : ALIGN(4096)
+	{
+		*(.exit.text .exit.text.*)
+	}
+}
-- 
1.7.10.4
