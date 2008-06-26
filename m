Return-Path: <monstr@seznam.cz>
Received: from monstr.eu (238.225.broadband7.iol.cz [88.102.225.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 364EDDE5AD
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 23:26:37 +1000 (EST)
From: monstr@seznam.cz
To: linux-kernel@vger.kernel.org
Subject: [PATCH 02/60] microblaze_v4: Makefiles for Microblaze cpu
Date: Thu, 26 Jun 2008 14:29:31 +0200
Message-Id: <1214483429-32360-3-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-2-git-send-email-monstr@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	drepper@redhat.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michal Simek <monstr@monstr.eu>


Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/Makefile                  |   63 +++++++++++++++++++++++++++++
 arch/microblaze/boot/Makefile             |   17 ++++++++
 arch/microblaze/kernel/Makefile           |   17 ++++++++
 arch/microblaze/kernel/cpu/Makefile       |    8 ++++
 arch/microblaze/lib/Makefile              |    5 ++
 arch/microblaze/mm/Makefile               |    5 ++
 arch/microblaze/platform/Makefile         |    6 +++
 arch/microblaze/platform/generic/Makefile |    3 +
 8 files changed, 124 insertions(+), 0 deletions(-)
 create mode 100644 arch/microblaze/Makefile
 create mode 100644 arch/microblaze/boot/Makefile
 create mode 100644 arch/microblaze/kernel/Makefile
 create mode 100644 arch/microblaze/kernel/cpu/Makefile
 create mode 100644 arch/microblaze/lib/Makefile
 create mode 100644 arch/microblaze/mm/Makefile
 create mode 100644 arch/microblaze/platform/Makefile
 create mode 100644 arch/microblaze/platform/generic/Makefile

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
new file mode 100644
index 0000000..7e9e1b4
--- /dev/null
+++ b/arch/microblaze/Makefile
@@ -0,0 +1,63 @@
+UTS_SYSNAME = -DUTS_SYSNAME=\"uClinux\"
+
+# What CPU vesion are we building for, and crack it open
+# as major.minor.rev
+CPU_VER=$(subst ",,$(CONFIG_XILINX_MICROBLAZE0_HW_VER) )
+CPU_MAJOR=$(shell echo $(CPU_VER) | cut -d '.' -f 1)
+CPU_MINOR=$(shell echo $(CPU_VER) | cut -d '.' -f 2)
+CPU_REV=$(shell echo $(CPU_VER) | cut -d '.' -f 3)
+
+export CPU_VER CPU_MAJOR CPU_MINOR CPU_REV
+
+# Use cpu-related CONFIG_ vars to set compile options.
+
+# Work out HW multipler support.  This is icky.
+# 1. Spartan2 has no HW multiplers.
+# 2. MicroBlaze v3.x always uses them, except in Spartan 2
+# 3. All other FPGa/CPU ver combos, we can trust the CONFIG_ settings
+ifeq (,$(findstring spartan2,$(CONFIG_XILINX_MICROBLAZE0_FAMILY)))
+  ifeq ($(CPU_MAJOR),3)
+    CPUFLAGS-1 += -mno-xl-soft-mul
+  else
+    # USE_HW_MUL can be 0, 1, or 2, defining a heirarchy of HW Mul support.
+    CPUFLAGS-$(subst 1,,$(CONFIG_XILINX_MICROBLAZE0_USE_HW_MUL)) += -mxl-multiply-high
+    CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_HW_MUL) += -mno-xl-soft-mul
+  endif
+endif
+CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_DIV) += -mno-xl-soft-div
+CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_BARREL) += -mxl-barrel-shift
+CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP) += -mxl-pattern-compare
+
+CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
+
+# The various CONFIG_XILINX cpu features options are integers 0/1/2...
+# rather than bools y/n
+CFLAGS += $(CPUFLAGS-1)
+CFLAGS += $(CPUFLAGS-2)
+
+# r31 holds current when in kernel mode
+CFLAGS += -ffixed-r31
+
+LDFLAGS_BLOB := --format binary --oformat elf32-microblaze
+
+LIBGCC := $(shell $(CC) $(CFLAGS) -print-libgcc-file-name)
+
+head-y		:= arch/microblaze/kernel/head.o
+libs-y		+= arch/microblaze/lib/ $(LIBGCC)
+core-y		+= arch/microblaze/kernel/ arch/microblaze/mm/ \
+		   arch/microblaze/platform/
+
+boot := arch/$(ARCH)/boot
+
+all: linux.bin
+
+archclean:
+	$(Q)$(MAKE) $(clean)=$(boot)
+
+linux.bin linux.bin.gz: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
+define archhelp
+  echo  '* linux.bin    - Create raw binary'
+  echo  '  linux.bin.gz - Create compressed raw binary'
+endef
diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
new file mode 100644
index 0000000..844edf4
--- /dev/null
+++ b/arch/microblaze/boot/Makefile
@@ -0,0 +1,17 @@
+#
+# arch/microblaze/boot/Makefile
+#
+
+targets := linux.bin linux.bin.gz
+
+OBJCOPYFLAGS_linux.bin  := -O binary
+
+$(obj)/linux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
+	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
+
+$(obj)/linux.bin.gz: $(obj)/linux.bin FORCE
+	$(call if_changed,gzip)
+	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
+
+clean-kernel += linux.bin linux.bin.gz
diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
new file mode 100644
index 0000000..f7a6bb8
--- /dev/null
+++ b/arch/microblaze/kernel/Makefile
@@ -0,0 +1,17 @@
+#
+# Makefile
+#
+
+extra-y := head.o vmlinux.lds
+
+obj-y += entry.o exceptions.o \
+	hw_exception_handler.o init_task.o intc.o irq.o of_device.o \
+	process.o prom.o ptrace.o \
+	setup.o signal.o sys_microblaze.o timer.o traps.o
+
+obj-y += cpu/
+
+obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_SELFMOD)		+= selfmod.o
+obj-$(CONFIG_HEART_BEAT)	+= heartbeat.o
+obj-$(CONFIG_MODULES)		+= microblaze_ksyms.o module.o
diff --git a/arch/microblaze/kernel/cpu/Makefile b/arch/microblaze/kernel/cpu/Makefile
new file mode 100644
index 0000000..20646e5
--- /dev/null
+++ b/arch/microblaze/kernel/cpu/Makefile
@@ -0,0 +1,8 @@
+#
+# Build the appropriate CPU version support
+#
+
+EXTRA_CFLAGS += -DCPU_MAJOR=$(CPU_MAJOR) -DCPU_MINOR=$(CPU_MINOR) \
+		-DCPU_REV=$(CPU_REV)
+
+obj-y += cache.o cpuinfo.o cpuinfo-pvr-full.o cpuinfo-static.o mb.o pvr.o
diff --git a/arch/microblaze/lib/Makefile b/arch/microblaze/lib/Makefile
new file mode 100644
index 0000000..f0c36ff
--- /dev/null
+++ b/arch/microblaze/lib/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile
+#
+
+lib-y := memcpy.o memmove.o memset.o uaccess.o
diff --git a/arch/microblaze/mm/Makefile b/arch/microblaze/mm/Makefile
new file mode 100644
index 0000000..bf9e447
--- /dev/null
+++ b/arch/microblaze/mm/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile
+#
+
+obj-y := init.o
diff --git a/arch/microblaze/platform/Makefile b/arch/microblaze/platform/Makefile
new file mode 100644
index 0000000..ea1b75c
--- /dev/null
+++ b/arch/microblaze/platform/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for arch/microblaze/platform directory
+#
+#obj-$(CONFIG_PLATFORM_GENERIC) += generic/
+
+obj-y	+= platform.o
diff --git a/arch/microblaze/platform/generic/Makefile b/arch/microblaze/platform/generic/Makefile
new file mode 100644
index 0000000..9a8b1bd
--- /dev/null
+++ b/arch/microblaze/platform/generic/Makefile
@@ -0,0 +1,3 @@
+#
+# Empty Makefile to keep make clean happy
+#
-- 
1.5.4.GIT
