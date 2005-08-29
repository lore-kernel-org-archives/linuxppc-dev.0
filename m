Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 60DFE68127
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 15:47:13 +1000 (EST)
Received: from oak (unknown [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 3F205368024
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 15:47:13 +1000 (EST)
Date: Mon, 29 Aug 2005 13:15:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050829131550.39e97cf3.sfr@canb.auug.org.au>
In-Reply-To: <20050829130133.519391c6.sfr@canb.auug.org.au>
References: <20050829130133.519391c6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Resent-Message-Id: <20050829154708.3a9f2cea.sfr@canb.auug.org.au>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, linuxppc-dev@samba.org
Subject: [PATCH 1/3] Create include/asm-powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ppc and ppc64 trees are hopefully going to merge over time, so this
patch begins the process by creating a place for the merging of the
header files.

Create include/asm-powerpc (and move linkage.h into it from
asm-{ppc,ppc64} since we don't like empty directories).  Modify the
ppc and ppc64 Makefiles to cope.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/ppc/Makefile             |   11 ++++++++++-
 arch/ppc64/Makefile           |    9 +++++++++
 include/asm-powerpc/linkage.h |    6 ++++++
 include/asm-ppc/linkage.h     |    6 ------
 include/asm-ppc64/linkage.h   |    6 ------
 5 files changed, 25 insertions(+), 13 deletions(-)
 create mode 100644 include/asm-powerpc/linkage.h
 delete mode 100644 include/asm-ppc/linkage.h
 delete mode 100644 include/asm-ppc64/linkage.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

c12b44d5844f3c8a48fb30bb880db49029d0d8cb
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -21,11 +21,13 @@ CC		:= $(CC) -m32
 endif
 
 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
-CPPFLAGS	+= -Iarch/$(ARCH)
+CPPFLAGS	+= -Iarch/$(ARCH) -Iinclude3
 AFLAGS		+= -Iarch/$(ARCH)
 CFLAGS		+= -Iarch/$(ARCH) -msoft-float -pipe \
 		-ffixed-r2 -mmultiple
 CPP		= $(CC) -E $(CFLAGS)
+# Temporary hack until we have migrated to asm-powerpc
+LINUXINCLUDE    += -Iinclude3
 
 CHECKFLAGS	+= -D__powerpc__
 
@@ -101,6 +103,7 @@ endef
 
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/ppc/boot
+	$(Q)rm -rf include3
 
 prepare: include/asm-$(ARCH)/offsets.h checkbin
 
@@ -110,6 +113,12 @@ arch/$(ARCH)/kernel/asm-offsets.s: inclu
 include/asm-$(ARCH)/offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
 	$(call filechk,gen-asm-offsets)
 
+# Temporary hack until we have migrated to asm-powerpc
+include/asm: include3/asm
+include3/asm:
+	$(Q)if [ ! -d include3 ]; then mkdir -p include3; fi
+	$(Q)ln -fsn $(srctree)/include/asm-powerpc include3/asm
+
 # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
 # to stdout and these checks are run even on install targets.
 TOUT	:= .tmp_gas_check
diff --git a/arch/ppc64/Makefile b/arch/ppc64/Makefile
--- a/arch/ppc64/Makefile
+++ b/arch/ppc64/Makefile
@@ -55,6 +55,8 @@ LDFLAGS		:= -m elf64ppc
 LDFLAGS_vmlinux	:= -Bstatic -e $(KERNELLOAD) -Ttext $(KERNELLOAD)
 CFLAGS		+= -msoft-float -pipe -mminimal-toc -mtraceback=none \
 		   -mcall-aixdesc
+# Temporary hack until we have migrated to asm-powerpc
+CPPFLAGS	+= -Iinclude3
 
 GCC_VERSION     := $(call cc-version)
 GCC_BROKEN_VEC	:= $(shell if [ $(GCC_VERSION) -lt 0400 ] ; then echo "y"; fi ;)
@@ -112,6 +114,7 @@ all: $(KBUILD_IMAGE)
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
+	$(Q)rm -rf include3
 
 prepare: include/asm-ppc64/offsets.h
 
@@ -121,6 +124,12 @@ arch/ppc64/kernel/asm-offsets.s: include
 include/asm-ppc64/offsets.h: arch/ppc64/kernel/asm-offsets.s
 	$(call filechk,gen-asm-offsets)
 
+# Temporary hack until we have migrated to asm-powerpc
+include/asm: include3/asm
+include3/asm:
+	$(Q)if [ ! -d include3 ]; then mkdir -p include3; fi;
+	$(Q)ln -fsn $(srctree)/include/asm-powerpc include3/asm
+
 define archhelp
   echo  '* zImage       - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
   echo  '  zImage.initrd- Compressed kernel image with initrd attached,'
diff --git a/include/asm-powerpc/linkage.h b/include/asm-powerpc/linkage.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/linkage.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif
diff --git a/include/asm-ppc/linkage.h b/include/asm-ppc/linkage.h
deleted file mode 100644
--- a/include/asm-ppc/linkage.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_LINKAGE_H
-#define __ASM_LINKAGE_H
-
-/* Nothing to see here... */
-
-#endif
diff --git a/include/asm-ppc64/linkage.h b/include/asm-ppc64/linkage.h
deleted file mode 100644
--- a/include/asm-ppc64/linkage.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_LINKAGE_H
-#define __ASM_LINKAGE_H
-
-/* Nothing to see here... */
-
-#endif
