Date: Sat, 22 Mar 2003 22:56:25 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@samba.org>
Subject: Re: ppc: Makefile tidy-up round 2
Message-ID: <20030322215625.GC15911@mars.ravnborg.org>
References: <20030320222759.GA12267@mars.ravnborg.org> <20030322215403.GA15911@mars.ravnborg.org> <20030322215552.GB15911@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030322215552.GB15911@mars.ravnborg.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.873   -> 1.874
#	arch/ppc/boot/openfirmware/Makefile	1.23    -> 1.24
#	               (new)	        -> 1.1     arch/ppc/boot/openfirmware/dummy.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/22	sam@mars.ravnborg.org	1.874
# ppc: boot/openfirmware/Makefile rewrite
#
# Utilises kbuild infrastructure to build the images
# Sample output with "make V=0":
#   AS      arch/ppc/boot/openfirmware/coffcrt0.o
#   GEN     arch/ppc/boot/openfirmware/image.o
#   COFF    arch/ppc/boot/openfirmware/coffboot
#   COFF    arch/ppc/boot/images/vmlinux.coff
#   AS      arch/ppc/boot/openfirmware/crt0.o
#   CC      arch/ppc/boot/openfirmware/newworldmain.o
#   ELF     arch/ppc/boot/images/vmlinux.elf-pmac
#   CC      arch/ppc/boot/openfirmware/chrpmain.o
#   CHRP    arch/ppc/boot/images/zImage.chrp
#   ADDNOTE arch/ppc/boot/images/zImage.chrp-rs6k
#   GEN     arch/ppc/boot/images/miboot.image
#   kernel: zImage is ready (arch/ppc/boot/images/vmlinux.coff)
# --------------------------------------------
#
diff -Nru a/arch/ppc/boot/openfirmware/Makefile b/arch/ppc/boot/openfirmware/Makefile
--- a/arch/ppc/boot/openfirmware/Makefile	Sat Mar 22 22:47:05 2003
+++ b/arch/ppc/boot/openfirmware/Makefile	Sat Mar 22 22:47:05 2003
@@ -10,36 +10,34 @@
 #	Merged 'chrp' and 'pmac' into 'openfirmware', and cleaned up the
 #	rules.

-clean-files := note coffboot coffboot.initrd
+zImage.initrd znetboot.initrd: del-ramdisk-sec	:= -R .ramdisk
+zImage.initrd znetboot.initrd: initrd		:= .initrd

-boot: zImage

-boot := arch/ppc/boot
-common := $(boot)/common
-utils := $(boot)/utils
-bootlib := $(boot)/lib
-of1275 := $(boot)/of1275
-images := $(boot)/images
-
-OBJCOPY_ARGS = -O aixcoff-rs6000 -R .stab -R .stabstr -R .comment
-COFF_LD_ARGS = -T $(boot)/ld.script -e _start -Ttext 0x00700000 -Bstatic
-CHRP_LD_ARGS = -T $(boot)/ld.script -e _start -Ttext 0x00800000
-NEWWORLD_LD_ARGS = -T $(boot)/ld.script -e _start -Ttext 0x01000000
+boot	:= arch/ppc/boot
+common	:= $(boot)/common
+utils	:= $(boot)/utils
+bootlib	:= $(boot)/lib
+of1275	:= $(boot)/of1275
+images	:= $(boot)/images
+
+OBJCOPY_ARGS	:= -O aixcoff-rs6000 -R .stab -R .stabstr -R .comment
+COFF_LD_ARGS	:= -T $(boot)/ld.script -e _start -Ttext 0x00700000 -Bstatic
+CHRP_LD_ARGS	:= -T $(boot)/ld.script -e _start -Ttext 0x00800000
+NEWWORLD_LD_ARGS:= -T $(boot)/ld.script -e _start -Ttext 0x01000000

 COMMONOBJS	:= start.o misc.o common.o
 COFFOBJS	:= coffcrt0.o $(COMMONOBJS) coffmain.o
-CHRPOBJS	:= crt0.o $(COMMONOBJS) chrpmain.o
-NEWWORLDOBJS	:= crt0.o $(COMMONOBJS) newworldmain.o
+CHRPOBJS	:= crt0.o     $(COMMONOBJS) chrpmain.o
+NEWWORLDOBJS	:= crt0.o     $(COMMONOBJS) newworldmain.o

-EXTRA_TARGETS := $(COFFOBJS) $(CHRPOBJS) $(NEWWORLDOBJS)
+targets 	:= $(COFFOBJS) $(CHRPOBJS) $(NEWWORLDOBJS) dummy.o
 COFFOBJS	:= $(addprefix $(obj)/, $(COFFOBJS))
 CHRPOBJS	:= $(addprefix $(obj)/, $(CHRPOBJS))
 NEWWORLDOBJS	:= $(addprefix $(obj)/, $(NEWWORLDOBJS))

-LIBS = lib/lib.a $(bootlib)/lib.a $(of1275)/lib.a $(common)/lib.a
+LIBS		:= lib/lib.a $(bootlib)/lib.a $(of1275)/lib.a $(common)/lib.a

-ADDNOTE := $(utils)/addnote
-MKNOTE := $(utils)/mknote
 HACKCOFF := $(utils)/hack-coff

 ifdef CONFIG_SMP
@@ -49,108 +47,136 @@
 END += .64
 endif

-TFTPIMAGE=/tftpboot/zImage.

-$(obj)/dummy.o: $(common)/dummy.c
-	$(CC) -c -o $@ $(common)/dummy.c
-
-$(obj)/image.o: $(images)/vmlinux.gz $(obj)/dummy.o
-	$(OBJCOPY) $(obj)/dummy.o $@ -R .comment \
-		--add-section=.image=$(images)/vmlinux.gz \
-		--set-section-flags=.image=contents,alloc,load,readonly,data
-ifdef CONFIG_XMON
-	$(OBJCOPY) $@ $@ \
-		--add-section=.sysmap=$(TOPDIR)/System.map \
-		--set-section-flags=.sysmap=contents,alloc,load,readonly,data
-endif
+$(images)/ramdisk.image.gz:
+	@echo '  MISSING $@'
+	@echo '          RAM disk image must be provided seperatly'
+	@/bin/false
+
+objcpxmon-$(CONFIG_XMON) := --add-section=.sysmap=System.map \
+	--set-section-flags=.sysmap=contents,alloc,load,readonly,data
+quiet_cmd_genimage = GEN     $@
+      cmd_genimage = $(OBJCOPY) -R .comment       \
+	--add-section=.image=$(images)/vmlinux.gz \
+	--set-section-flags=.image=contents,alloc,load,readonly,data \
+	$(objcpxmon-y) $< $@
+
+targets += image.o
+$(obj)/image.o: $(obj)/dummy.o $(images)/vmlinux.gz FORCE
+	$(call if_changed,genimage)

 # Place the ramdisk in the initrd image.
-$(obj)/image-initrd.o: $(obj)/image.o $(images)/ramdisk.image.gz
-	$(OBJCOPY) $(obj)/image.o $@ \
-		--add-section=.ramdisk=$(images)/ramdisk.image.gz \
-		--set-section-flags=.ramdisk=contents,alloc,load,readonly,data
+quiet_cmd_genimage-initrd = GEN     $@
+      cmd_genimage-initrd = $(OBJCOPY) $< $@ \
+	--add-section=.ramdisk=$(images)/ramdisk.image.gz \
+	--set-section-flags=.ramdisk=contents,alloc,load,readonly,data
+targets += image.initrd.o
+$(obj)/image.initrd.o: $(obj)/image.o $(images)/ramdisk.image.gz FORCE
+	$(call if_changed,genimage-initrd)

 # Create the note section for New-World PowerMacs.
-$(obj)/note: $(MKNOTE)
-	$(MKNOTE) > $(obj)/note
-
-znetboot: $(images)/vmlinux.coff $(images)/vmlinux.elf-pmac $(images)/zImage.chrp
-	cp $(images)/vmlinux.coff $(TFTPIMAGE).pmac$(END)
-	cp $(images)/vmlinux.elf-pmac $(TFTPIMAGE).pmac$(END)elf
-	cp $(images)/zImage.chrp $(TFTPIMAGE).chrp$(END)
-
-znetboot.initrd: $(images)/vmlinux.initrd.coff \
-		$(images)/vmlinux.initrd.elf-pmac \
-		$(images)/zImage.initrd.chrp
-	cp $(images)/vmlinux.initrd.coff $(TFTPIMAGE).pmac$(END)
-	cp $(images)/vmlinux.initrd.elf-pmac $(TFTPIMAGE).pmac$(END).elf
-	cp $(images)/zImage.initrd.chrp $(TFTPIMAGE).chrp$(END)
+quit_cmd_mknote  = MKNOTE  $@
+     cmd_mknote  = $(utils)/mknote > $@
+targets		+= note
+$(obj)/note: $(utils)/mknote FORCE
+	$(call if_changed,mknote)
+
+
+$(obj)/coffcrt0.o: EXTRA_AFLAGS := -traditional -DXCOFF
+$(obj)/crt0.o:     EXTRA_AFLAGS := -traditional
+targets += coffcrt0.o crt0.o
+$(obj)/coffcrt0.o $(obj)/crt0.o: $(common)/crt0.S FORCE
+	$(call if_changed_dep,as_o_S)
+
+quiet_cmd_gencoffb = COFF    $@
+      cmd_gencoffb = $(LD) -o $@ $(COFF_LD_ARGS) $(filter-out FORCE,$^) && \
+                     $(OBJCOPY) $@ $@ -R .comment $(del-ramdisk-sec)
+targets += coffboot
+$(obj)/coffboot: $(COFFOBJS) $(obj)/image.o $(LIBS) FORCE
+	$(call if_changed,gencoffb)
+targets += coffboot.initrd
+$(obj)/coffboot.initrd: $(COFFOBJS) $(obj)/image.initrd.o $(LIBS) FORCE
+	$(call if_changed,gencoffb)
+
+
+quiet_cmd_gen-coff = COFF    $@
+      cmd_gen-coff = $(OBJCOPY) $(OBJCOPY_ARGS) $< $@ && \
+			$(HACKCOFF) $@ && \
+			ln -sf $(notdir $@) $(images)/zImage$(initrd).pmac
+
+$(images)/vmlinux.coff: $(obj)/coffboot
+	$(call cmd,gen-coff)
+
+$(images)/vmlinux.initrd.coff: $(obj)/coffboot.initrd
+	$(call cmd,gen-coff)
+
+quiet_cmd_gen-elf-pmac = ELF     $@
+      cmd_gen-elf-pmac = $(LD) $(NEWWORLD_LD_ARGS) -o $@ \
+				$(NEWWORLDOBJS) $(LIBS) $< && \
+			$(OBJCOPY) $@ $@ --add-section=.note=$(obj)/note \
+					 -R .comment $(del-ramdisk-sec)
+
+$(images)/vmlinux.elf-pmac: $(obj)/image.o $(NEWWORLDOBJS) $(LIBS) $(obj)/note
+	$(call cmd,gen-elf-pmac)
+$(images)/vmlinux.initrd.elf-pmac: $(obj)/image.initrd.o $(NEWWORLDOBJS) \
+				   $(LIBS) $(obj)/note
+	$(call cmd,gen-elf-pmac)
+
+quiet_cmd_gen-chrp = CHRP    $@
+      cmd_gen-chrp = $(LD) $(CHRP_LD_ARGS) -o $@ $^ && \
+			$(OBJCOPY) $@ $@ -R .comment $(del-ramdisk-sec)

+$(images)/zImage.chrp: $(CHRPOBJS) $(obj)/image.o $(LIBS)
+	$(call cmd,gen-chrp)
+$(images)/zImage.initrd.chrp: $(CHRPOBJS) $(obj)/image.initrd.o $(LIBS)
+	$(call cmd,gen-chrp)
+
+quiet_cmd_addnote = ADDNOTE $@
+      cmd_addnote = cat $< > $@ && $(utils)/addnote $@
+$(images)/zImage.chrp-rs6k $(images)/zImage.initrd.chrp-rs6k: \
+	%-rs6k: %
+	$(call cmd,addnote)
+
+quiet_cmd_gen-miboot = GEN     $@
+      cmd_gen-miboot = $(OBJCOPY) $(OBJCOPY_ARGS) \
+		       --add-section=image=$(word 2, $^) $< $@
 $(images)/miboot.image: $(obj)/dummy.o $(images)/vmlinux.gz
-	$(OBJCOPY) $(OBJCOPY_ARGS) --add-section=image=$(images)/vmlinux.gz \
-		$(obj)/dummy.o $@
+	$(call cmd,gen-miboot)

 $(images)/miboot.initrd.image: $(images)/miboot.image $(images)/ramdisk.image.gz
-	$(OBJCOPY) $(OBJCOPY_ARGS) \
-		--add-section=initrd=$(images)/ramdisk.image.gz \
-		$(images)/miboot.image $@
-
-$(obj)/coffcrt0.o: $(common)/crt0.S
-	$(CC) $(AFLAGS) -DXCOFF -traditional -c -o $@ $(common)/crt0.S
-
-$(obj)/crt0.o: $(common)/crt0.S
-	$(CC) $(AFLAGS) -traditional -c -o $@ $(common)/crt0.S
-
-$(obj)/coffboot: $(COFFOBJS) $(obj)/image.o $(LIBS)
-	$(LD) -o $@ $(COFF_LD_ARGS) $^
-	$(OBJCOPY) $@ $@ -R .comment -R .ramdisk
-
-$(obj)/coffboot.initrd: $(COFFOBJS) $(obj)/image-initrd.o $(LIBS)
-	$(LD) -o $@ $(COFF_LD_ARGS) $^
-	$(OBJCOPY) $@ $@ -R .comment
-
-$(images)/vmlinux.coff: $(obj)/coffboot $(HACKCOFF)
-	$(OBJCOPY) $(OBJCOPY_ARGS) $(obj)/coffboot $@
-	$(HACKCOFF) $@
-	ln -sf vmlinux.coff $(images)/zImage.pmac
-
-$(images)/vmlinux.initrd.coff: $(obj)/coffboot.initrd $(HACKCOFF)
-	$(OBJCOPY) $(OBJCOPY_ARGS) $(obj)/coffboot.initrd $@
-	$(HACKCOFF) $@
-	ln -sf vmlinux.initrd.coff $(images)/zImage.initrd.pmac
-
-$(images)/vmlinux.elf-pmac: $(NEWWORLDOBJS) $(LIBS) $(obj)/image.o $(obj)/note
-	$(LD) $(NEWWORLD_LD_ARGS) -o $@ $(NEWWORLDOBJS) $(LIBS) $(obj)/image.o
-	$(OBJCOPY) $@ $@ \
-		--add-section=.note=$(obj)/note -R .comment -R .ramdisk
-
-$(images)/vmlinux.initrd.elf-pmac: $(NEWWORLDOBJS) $(LIBS) \
-		$(obj)/image-initrd.o $(obj)/note
-	$(LD) $(NEWWORLD_LD_ARGS) -o $@ $(NEWWORLDOBJS) $(LIBS) \
-		$(obj)/image-initrd.o
-	$(OBJCOPY) $@ $@ \
-		--add-section=.note=$(obj)/note -R .comment
+	$(call cmd,gen-miboot)

-$(images)/zImage.chrp: $(CHRPOBJS) $(obj)/image.o $(LIBS)
-	$(LD) $(CHRP_LD_ARGS) -o $@ $^
-	$(OBJCOPY) $@ $@ -R .comment -R .ramdisk
+# The targets used on the make command-line
+
+.PHONY: zImage zImage.initrd
+zImage:		 $(images)/vmlinux.coff 	\
+		 $(images)/vmlinux.elf-pmac	\
+		 $(images)/zImage.chrp		\
+		 $(images)/zImage.chrp-rs6k	\
+		 $(images)/miboot.image
+	@echo '  kernel: $@ is ready ($<)'
+zImage.initrd:	 $(images)/vmlinux.initrd.coff 		\
+		 $(images)/vmlinux.initrd.elf-pmac	\
+		 $(images)/zImage.initrd.chrp		\
+		 $(images)/zImage.initrd.chrp-rs6k	\
+		 $(images)/miboot.initrd.image
+	@echo '  kernel: $@ is ready ($<)'
+
+TFTPIMAGE	:= /tftpboot/zImage.
+
+.PHONY: znetboot znetboot.initrd
+znetboot:	$(images)/vmlinux.coff		\
+		$(images)/vmlinux.elf-pmac	\
+		$(images)/zImage.chrp
+	cp $(images)/vmlinux.coff     $(TFTPIMAGE).pmac$(END)
+	cp $(images)/vmlinux.elf-pmac $(TFTPIMAGE).pmac$(END).elf
+	cp $(images)/zImage.chrp      $(TFTPIMAGE).chrp$(END)
+	@echo '  kernel: $@ is ready ($<)'
+znetboot.initrd:$(images)/vmlinux.initrd.coff		\
+		$(images)/vmlinux.initrd.elf-pmac	\
+		$(images)/zImage.initrd.chrp
+	cp $(images)/vmlinux.initrd.coff     $(TFTPIMAGE).pmac$(END)
+	cp $(images)/vmlinux.initrd.elf-pmac $(TFTPIMAGE).pmac$(END).elf
+	cp $(images)/zImage.initrd.chrp      $(TFTPIMAGE).chrp$(END)
+	@echo '  kernel: $@ is ready ($<)'

-$(images)/zImage.initrd.chrp: $(CHRPOBJS) $(obj)/image-initrd.o $(LIBS)
-	$(LD) $(CHRP_LD_ARGS) -o $@ $^
-	$(OBJCOPY) $@ $@ -R .comment
-
-$(images)/zImage.chrp-rs6k: $(images)/zImage.chrp $(ADDNOTE)
-	cp $(images)/zImage.chrp $@
-	$(ADDNOTE) $@
-
-$(images)/zImage.initrd.chrp-rs6k: $(images)/zImage.initrd.chrp $(ADDNOTE)
-	cp $(images)/zImage.initrd.chrp $@
-	$(ADDNOTE) $@
-
-zImage: $(images)/vmlinux.coff $(images)/vmlinux.elf-pmac \
-		$(images)/zImage.chrp $(images)/zImage.chrp-rs6k \
-		$(images)/miboot.image
-
-zImage.initrd: $(images)/vmlinux.initrd.coff $(images)/vmlinux.initrd.elf-pmac\
-		$(images)/zImage.initrd.chrp $(images)/zImage.initrd.chrp-rs6k\
-		$(images)/miboot.initrd.image
diff -Nru a/arch/ppc/boot/openfirmware/dummy.c b/arch/ppc/boot/openfirmware/dummy.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/boot/openfirmware/dummy.c	Sat Mar 22 22:47:05 2003
@@ -0,0 +1,4 @@
+int main(void)
+{
+	return 0;
+}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
