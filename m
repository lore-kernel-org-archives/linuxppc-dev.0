Date: Thu, 14 Aug 2003 21:34:41 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] simple/Makefile cleanup - step 1
Message-ID: <20030814193441.GB20672@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Tom.

Loom time ago I promised to take a look at the simple/Makefile.
I was reminded by the current thread.
The following is first step.

Use kbuild style assignment in simple/Makefile.
This results in a more readable Makefile.

	Sam

===== arch/ppc/boot/simple/Makefile 1.19 vs edited =====
--- 1.19/arch/ppc/boot/simple/Makefile	Wed Jul  2 02:01:18 2003
+++ edited/arch/ppc/boot/simple/Makefile	Thu Aug 14 21:17:31 2003
@@ -22,7 +22,6 @@
 # get_mem_size(), which is memory controller dependent.  Add in the correct
 # XXX_memory.o file for this to work, as well as editing the $(MISC) file.

-boot: zImage

 boot				:= arch/ppc/boot
 common				:= $(boot)/common
@@ -32,86 +31,90 @@

 # Normally, we use the 'misc.c' file for decompress_kernel and
 # whatnot.  Sometimes we need to override this however.
-MISC				:= misc.o
-ifeq ($(CONFIG_IBM_OPENBIOS),y)
-ZIMAGE				:= zImage-TREE
-ZIMAGEINITRD			:= zImage.initrd-TREE
-END				:= treeboot
-TFTPIMAGE			:= /tftpboot/zImage.$(END)
-MISC				:= misc-embedded.o
-endif
-ifeq ($(CONFIG_EMBEDDEDBOOT),y)
-TFTPIMAGE			:= /tftpboot/zImage.embedded
-MISC				:= misc-embedded.o
-endif
-ifeq ($(CONFIG_EBONY),y)
-ZIMAGE				:= zImage-TREE
-ZIMAGEINITRD			:= zImage.initrd-TREE
-END				:= ebony
-ENTRYPOINT			:= 0x01000000
-TFTPIMAGE			:= /tftpboot/zImage.$(END)
-endif
-ifeq ($(CONFIG_EV64260),y)
-EXTRA				:= misc-ev64260.o
-TFTPIMAGE			:= /tftpboot/zImage.ev64260
-endif
-ifeq ($(CONFIG_GEMINI),y)
-ZIMAGE				:= zImage-STRIPELF
-ZIMAGEINITRD			:= zImage.initrd-STRIPELF
-END				:= gemini
-TFTPIMAGE			:= /tftpboot/zImage.$(END)
-endif
-ifeq ($(CONFIG_K2),y)
-EXTRA				:= legacy.o
-TFTPIMAGE			:= /tftpboot/zImage.k2
-endif
-# kbuild-2.4 'feature', only one of these will ever by 'y' at a time.
+misc-y	:= misc.o
+
+#
+# See arch/ppc/kconfig and arch/ppc/platforms/Kconfig
+# for definition of what platform each config option refer to.
+#----------------------------------------------------------------------------
+      zimage-$(CONFIG_IBM_OPENBIOS)	:= zImage-TREE
+zimageinitrd-$(CONFIG_IBM_OPENBIOS)	:= zImage.initrd-TREE
+         end-$(CONFIG_IBM_OPENBIOS)	:= treeboot
+   tftpimage-$(CONFIG_IBM_OPENBIOS)	:= /tftpboot/zImage.$(end-y)
+        misc-$(CONFIG_IBM_OPENBIOS)	:= misc-embedded.o
+
+   tftpimage-$(CONFIG_EMBEDDEDBOOT)	:=  /tftpboot/zImage.embedded
+        misc-$(CONFIG_EMBEDDEDBOOT)	:= misc-embedded.o
+
+      zimage-$(CONFIG_EBONY)		:= zImage-TREE
+zimageinitrd-$(CONFIG_EBONY)		:= zImage.initrd-TREE
+     extra.o-$(CONFIG_EBONY)		:= direct.o
+         end-$(CONFIG_EBONY)		:= ebony
+  entrypoint-$(CONFIG_EBONY)		:= 0x01000000
+   tftpimage-$(CONFIG_EBONY)		:= /tftpboot/zImage.$(end-y)
+
+     extra.o-$(CONFIG_EV64260)		:= direct.o misc-ev64260.o
+   tftpimage-$(CONFIG_EV64260)		:= /tftpboot/zImage.ev64260
+
+      zimage-$(CONFIG_GEMINI)		:= zImage-STRIPELF
+zimageinitrd-$(CONFIG_GEMINI)		:= zImage.initrd-STRIPELF
+         end-$(CONFIG_GEMINI)		:= gemini
+   tftpimage-$(CONFIG_GEMINI)		:= /tftpboot/zImage.$(end-y)
+
+     extra.o-$(CONFIG_K2)		:= legacy.o
+   tftpimage-$(CONFIG_K2)		:= /tftpboot/zImage.k2
+
+# kconfig 'feature', only one of these will ever by 'y' at a time.
 # The rest will be unset.
-ifeq ($(CONFIG_MCPN765)$(CONFIG_MVME5100)$(CONFIG_PRPMC750)$(CONFIG_PRPMC800)$(CONFIG_LOPEC)$(CONFIG_PPLUS),y)
-ZIMAGE				:= zImage-PPLUS
-ZIMAGEINITRD			:= zImage.initrd-PPLUS
-TFTPIMAGE			:= /tftpboot/zImage.pplus
-ZNETBOOT			:= zImage.pplus
-ZNETBOOTRD			:= zImage.initrd.pplus
-endif
-ifeq ($(CONFIG_PPLUS),y)
-EXTRA				:= legacy.o
-endif
-ifeq ($(CONFIG_PCORE)$(CONFIG_POWERPMC250),y)
-ZIMAGE				:= zImage-STRIPELF
-ZIMAGEINITRD			:= zImage.initrd-STRIPELF
-EXTRA				:= chrpmap.o
-END				:= pcore
-TFTPIMAGE			:= /tftpboot/zImage.$(END)
-endif
-ifeq ($(CONFIG_SANDPOINT),y)
-TFTPIMAGE			:= /tftpboot/zImage.sandpoint
-endif
-ifeq ($(CONFIG_SPRUCE),y)
-ZIMAGE				:= zImage-TREE
-ZIMAGEINITRD			:= zImage.initrd-TREE
-END				:= spruce
-ENTRYPOINT			:= 0x00800000
-MISC				:= misc-spruce.o
-TFTPIMAGE			:= /tftpboot/zImage.$(END)
-endif
-ifeq ($(CONFIG_SMP),y)
-TFTPIMAGE			+= .smp
-endif
-ifeq ($(CONFIG_REDWOOD_4),y)
+multi := $(CONFIG_MCPN765)$(CONFIG_MVME5100)$(CONFIG_PRPMC750) \
+$(CONFIG_PRPMC800)$(CONFIG_LOPEC)$(CONFIG_PPLUS)
+      zimage-$(multi)			:= zImage-PPLUS
+zimageinitrd-$(multi)			:= zImage.initrd-PPLUS
+   tftpimage-$(multi)			:= /tftpboot/zImage.pplus
+    znetboot-$(multi)			:= zImage.pplus
+  znetbootrd-$(multi)			:= zImage.initrd.pplus
+
+#Overrides previous assingment
+     extra.o-$(CONFIG_PPLUS)		:= legacy.o
+
+      zimage-$(CONFIG_PCORE)		:= zImage-STRIPELF
+zimageinitrd-$(CONFIG_PCORE)		:= zImage.initrd-STRIPELF
+     extra.o-$(CONFIG_PCORE)		:= chrpmap.o
+         end-$(CONFIG_PCORE)		:= pcore
+   tftpimage-$(CONFIG_PCORE)		:= /tftpboot/zImage.$(end-y)
+
+      zimage-$(CONFIG_POWERPMC250)	:= zImage-STRIPELF
+zimageinitrd-$(CONFIG_POWERPMC250)	:= zImage.initrd-STRIPELF
+     extra.o-$(CONFIG_POWERPMC250)	:= chrpmap.o
+         end-$(CONFIG_POWERPMC250)	:= pcore
+   tftpimage-$(CONFIG_POWERPMC250)	:= /tftpboot/zImage.$(end-y)
+
+   tftpimage-$(CONFIG_SANDPOINT)	:= /tftpboot/zImage.sandpoint
+
+      zimage-$(CONFIG_SPRUCE)		:= zImage-TREE
+zimageinitrd-$(CONFIG_SPRUCE)		:= zImage.initrd-TREE
+         end-$(CONFIG_SPRUCE)		:= spruce
+  entrypoint-$(CONFIG_SPRUCE)		:= 0x00800000
+        misc-$(CONFIG_SPRUCE)		:= misc-spruce.o
+   tftpimage-$(CONFIG_SPRUCE)		:= /tftpboot/zImage.$(end-y)
+
+
+# tftp image is prefixed with .smp if compiled for SMP
+tftpimage-$(CONFIG_SMP)	+= .smp
+
 # This is a treeboot that needs init functions until the
 # boot rom is sorted out (i.e. this is short lived)
-EXTRA_AFLAGS			:= -Wa,-m405
-EXTRA				:= rw4/rw4_init.o rw4/rw4_init_brd.o
-endif
+extra-aflags-$(CONFIG_REDWOOD_4)	:= -Wa,-m405
+extra.o-$(CONFIG_REDWOOD_4)		:= rw4/rw4_init.o rw4/rw4_init_brd.o
+EXTRA_AFLAGS := $(extra-aflags-y)

 # Linker args.  This specifies where the image will be run at.
-LD_ARGS				= -T $(boot)/ld.script \
-					-Ttext $(CONFIG_BOOT_LOAD) -Bstatic
+LD_ARGS				:= -T $(boot)/ld.script \
+				   -Ttext $(CONFIG_BOOT_LOAD) -Bstatic
 OBJCOPY_ARGS			:= -O elf32-powerpc

 # head.o and relocate.o must be at the start.
-boot-y				:= head.o relocate.o $(EXTRA) $(MISC)
+boot-y				:= head.o relocate.o $(extra.o-y) $(misc-y)
 boot-$(CONFIG_40x)		+= embed_config.o
 boot-$(CONFIG_8xx)		+= embed_config.o
 boot-$(CONFIG_8260)		+= embed_config.o
@@ -160,40 +163,40 @@
 		-R .stabstr -R .sysmap

 # Sort-of dummy rules, that let us format the image we want.
-zImage: $(images)/$(ZIMAGE) $(obj)/zvmlinux
+zImage: $(images)/$(zimage-y) $(obj)/zvmlinux
 	cp -f $(obj)/zvmlinux $(images)/zImage.elf
 	rm -f $(obj)/zvmlinux

-zImage.initrd: $(images)/$(ZIMAGEINITRD) $(obj)/zvmlinux.initrd
+zImage.initrd: $(images)/$(zimageinitrd-y) $(obj)/zvmlinux.initrd
 	cp -f $(obj)/zvmlinux.initrd $(images)/zImage.initrd.elf
 	rm -f $(obj)/zvmlinux.initrd

 znetboot: zImage
 ifneq ($(ZNETBOOT),)
-	cp $(images)/$(ZNETBOOT) $(TFTPIMAGE)
+	cp $(images)/$(ZNETBOOT) $(tftpimage-y)
 else
-	cp $(images)/zImage.* $(TFTPIMAGE)
+	cp $(images)/zImage.* $(tftpimage-y)
 endif

 znetboot.initrd: zImage.initrd
-ifneq ($(ZNETBOOTRD),)
-	cp $(images)/$(ZNETBOOTRD) $(TFTPIMAGE)
+ifneq ($(znetbootrd-y),)
+	cp $(images)/$(znetbootrd-y) $(tftpimage-y)
 else
-	cp $(images)/zImage.* $(TFTPIMAGE)
+	cp $(images)/zImage.* $(tftpimage-y)
 endif

 $(images)/zImage-STRIPELF: $(obj)/zvmlinux
-	dd if=$(obj)/zvmlinux of=$(images)/zImage.$(END) skip=64 bs=1k
+	dd if=$(obj)/zvmlinux of=$(images)/zImage.$(end-y) skip=64 bs=1k

 $(images)/zImage.initrd-STRIPELF: $(obj)/zvmlinux.initrd
-	dd if=$(obj)/zvmlinux.initrd of=$(images)/zImage.initrd.$(END) \
+	dd if=$(obj)/zvmlinux.initrd of=$(images)/zImage.initrd.$(end-y) \
 		skip=64 bs=1k

 $(images)/zImage-TREE: $(obj)/zvmlinux $(MKTREE)
-	$(MKTREE) $(obj)/zvmlinux $(images)/zImage.$(END) $(ENTRYPOINT)
+	$(MKTREE) $(obj)/zvmlinux $(images)/zImage.$(end-y) $(ENTRYPOINT)

 $(images)/zImage.initrd-TREE: $(obj)/zvmlinux.initrd $(MKTREE)
-	$(MKTREE) $(obj)/zvmlinux.initrd $(images)/zImage.initrd.$(END) \
+	$(MKTREE) $(obj)/zvmlinux.initrd $(images)/zImage.initrd.$(end-y) \
 		$(ENTRYPOINT)

 $(images)/zImage-PPLUS: $(obj)/zvmlinux $(MKPREP) $(MKBUGBOOT)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
