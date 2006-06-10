Return-Path: <anton@ozlabs.org>
Date: Sat, 10 Jun 2006 20:23:54 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Optimise some TOC usage
Message-ID: <20060610102354.GJ23891@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Micro-optimisation - add no-minimal-toc to some more arch/powerpc Makefiles.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/lib/Makefile
===================================================================
--- build.orig/arch/powerpc/lib/Makefile	2006-05-27 09:52:19.000000000 +1000
+++ build/arch/powerpc/lib/Makefile	2006-05-27 09:52:27.000000000 +1000
@@ -2,6 +2,10 @@
 # Makefile for ppc-specific library files..
 #
 
+ifeq ($(CONFIG_PPC64),y)
+EXTRA_CFLAGS		+= -mno-minimal-toc
+endif
+
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-y			:= string.o strcase.o
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o checksum_32.o
Index: build/arch/powerpc/oprofile/Makefile
===================================================================
--- build.orig/arch/powerpc/oprofile/Makefile	2006-05-27 09:52:19.000000000 +1000
+++ build/arch/powerpc/oprofile/Makefile	2006-05-27 09:52:27.000000000 +1000
@@ -1,3 +1,7 @@
+ifeq ($(CONFIG_PPC64),y)
+EXTRA_CFLAGS	+= -mno-minimal-toc
+endif
+
 obj-$(CONFIG_OPROFILE) += oprofile.o
 
 DRIVER_OBJS := $(addprefix ../../../drivers/oprofile/, \
Index: build/arch/powerpc/sysdev/Makefile
===================================================================
--- build.orig/arch/powerpc/sysdev/Makefile	2006-05-27 09:52:19.000000000 +1000
+++ build/arch/powerpc/sysdev/Makefile	2006-05-27 09:52:27.000000000 +1000
@@ -1,3 +1,7 @@
+ifeq ($(CONFIG_PPC64),y)
+EXTRA_CFLAGS			+= -mno-minimal-toc
+endif
+
 obj-$(CONFIG_MPIC)		+= mpic.o
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
Index: build/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- build.orig/arch/powerpc/platforms/pseries/Makefile	2006-05-27 09:52:19.000000000 +1000
+++ build/arch/powerpc/platforms/pseries/Makefile	2006-05-27 09:52:27.000000000 +1000
@@ -1,3 +1,7 @@
+ifeq ($(CONFIG_PPC64),y)
+EXTRA_CFLAGS		+= -mno-minimal-toc
+endif
+
 obj-y			:= pci.o lpar.o hvCall.o nvram.o reconfig.o \
 			   setup.o iommu.o ras.o rtasd.o pci_dlpar.o \
 			   firmware.o
