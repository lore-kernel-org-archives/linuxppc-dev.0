Return-Path: <anton@samba.org>
Date: Wed, 18 Apr 2012 14:45:28 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/4] powerpc: Add 64-bit CPU targets for gcc
Message-ID: <20120418144528.65b70fbb@kryten>
In-Reply-To: <20120418144254.3286ce94@kryten>
References: <20120418144254.3286ce94@kryten>
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


Add a menu to select various 64-bit CPU targets for gcc. We
default to -mtune=power7 and if gcc doesn't understand that we
fallback to -mtune=power4.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/Makefile
===================================================================
--- linux-build.orig/arch/powerpc/Makefile	2012-04-18 14:31:31.614666419 +1000
+++ linux-build/arch/powerpc/Makefile	2012-04-18 14:37:08.680708678 +1000
@@ -69,6 +69,16 @@ LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
 
 CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=no -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 -mmultiple
+
+CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power7,-mtune=power4)
+CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
+CFLAGS-$(CONFIG_POWER4_CPU) += $(call cc-option,-mcpu=power4)
+CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
+CFLAGS-$(CONFIG_POWER6_CPU) += $(call cc-option,-mcpu=power6)
+CFLAGS-$(CONFIG_POWER7_CPU) += $(call cc-option,-mcpu=power7)
+
+CFLAGS-$(CONFIG_TUNE_CELL) += $(call cc-option,-mtune=cell)
+
 KBUILD_CPPFLAGS	+= -Iarch/$(ARCH)
 KBUILD_AFLAGS	+= -Iarch/$(ARCH)
 KBUILD_CFLAGS	+= -msoft-float -pipe -Iarch/$(ARCH) $(CFLAGS-y)
@@ -76,22 +86,11 @@ CPP		= $(CC) -E $(KBUILD_CFLAGS)
 
 CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
 
-ifeq ($(CONFIG_PPC64),y)
-ifeq ($(CONFIG_POWER4_ONLY),y)
-	KBUILD_CFLAGS += $(call cc-option,-mcpu=power4)
-else
-	KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
-endif
-endif
-
 KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
 
-ifeq ($(CONFIG_TUNE_CELL),y)
-	KBUILD_CFLAGS += $(call cc-option,-mtune=cell)
-endif
-
-# No AltiVec instruction when building kernel
+# No AltiVec or VSX instructions when building kernel
 KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
+KBUILD_CFLAGS += $(call cc-option,-mno-vsx)
 
 # No SPE instruction when building kernel
 # (We use all available options to help semi-broken compilers)
Index: linux-build/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- linux-build.orig/arch/powerpc/platforms/Kconfig.cputype	2012-04-18 14:31:25.134549903 +1000
+++ linux-build/arch/powerpc/platforms/Kconfig.cputype	2012-04-18 14:36:40.576207829 +1000
@@ -78,6 +78,36 @@ config PPC_BOOK3E_64
 
 endchoice
 
+choice
+	prompt "CPU selection"
+	depends on PPC64
+	default GENERIC_CPU
+	help
+	  This will create a kernel which is optimised for a particular CPU.
+	  The resulting kernel may not run on other CPUs, so use this with care.
+
+	  If unsure, select Generic.
+
+config GENERIC_CPU
+	bool "Generic"
+
+config CELL_CPU
+	bool "Cell Broadband Engine"
+
+config POWER4_CPU
+	bool "POWER4"
+
+config POWER5_CPU
+	bool "POWER5"
+
+config POWER6_CPU
+	bool "POWER6"
+
+config POWER7_CPU
+	bool "POWER7"
+
+endchoice
+
 config PPC_BOOK3S
 	def_bool y
 	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64
