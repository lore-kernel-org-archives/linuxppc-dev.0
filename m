Date: Sat, 22 Mar 2003 22:55:52 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@samba.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: ppc: Makefile tidy-up round 2
Message-ID: <20030322215552.GB15911@mars.ravnborg.org>
References: <20030320222759.GA12267@mars.ravnborg.org> <20030322215403.GA15911@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030322215403.GA15911@mars.ravnborg.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.872   -> 1.873
#	arch/ppc/boot/prep/Makefile	1.23    -> 1.24
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/22	sam@mars.ravnborg.org	1.873
# ppc: Fix initrd build for prep
# --------------------------------------------
#
diff -Nru a/arch/ppc/boot/prep/Makefile b/arch/ppc/boot/prep/Makefile
--- a/arch/ppc/boot/prep/Makefile	Sat Mar 22 22:46:58 2003
+++ b/arch/ppc/boot/prep/Makefile	Sat Mar 22 22:46:58 2003
@@ -45,7 +45,7 @@
 zImage.initrd: $(images)/zImage.initrd.prep
 	@echo '  kernel: $@ is ready ($<)'

-mages)/ramdisk.image.gz:
+$(images)/ramdisk.image.gz:
 	@echo '  MISSING $@'
 	@echo '          RAM disk image must be provided separatly'
 	@/bin/false
@@ -68,20 +68,28 @@

 LDFLAGS_zImage.bin		:= -Ttext 0x00800000 -Bstatic -T
 LDFLAGS_zImage.initrd.bin	:= -Ttext 0x00800000 -Bstatic -T
-targets				+= zImage.bin zImage.initrd.bin
-$(obj)/zImage$(initrd).bin: $(boot)/ld.script $(OBJS) $(obj)/image.o $(LIBS)
+targets += zImage.bin
+$(obj)/zImage.bin: $(boot)/ld.script $(OBJS) $(obj)/image.o $(LIBS)
+	$(call if_changed,ld)
+targets += zImage.initrd.bin
+$(obj)/zImage.initrd.bin: $(boot)/ld.script $(OBJS) $(obj)/image.initrd.o $(LIBS)
 	$(call if_changed,ld)

 OBJCOPYFLAGS_zImage		:= -R .comment -R .stab -R .stabstr
 OBJCOPYFLAGS_zImage.initrd	:= -R .comment -R .stab -R .stabstr
-targets				+= zImage zImage.initrd
-$(obj)/zImage$(initrd): %: %.bin FORCE
+targets += zImage
+$(obj)/zImage: %: %.bin FORCE
+	$(call if_changed,objcopy)
+targets += zImage.initrd
+$(obj)/zImage.initrd: %: %.bin FORCE
 	$(call if_changed,objcopy)

 quiet_cmd_mkprep = MKPREP  $@
       cmd_mkprep = $(utils)/mkprep -pbp $< $@

-$(images)/zImage$(initrd).prep: $(obj)/zImage$(initrd) $(utils)/mkprep FORCE
+$(images)/zImage.prep: $(obj)/zImage $(utils)/mkprep
+	$(call cmd,mkprep)
+$(images)/zImage.initrd.prep: $(obj)/zImage.initrd $(utils)/mkprep
 	$(call cmd,mkprep)

 #
@@ -90,5 +98,11 @@
 floppy: zImage
 	dd if=$(images)/zImage.prep of=/dev/fd0H1440 bs=64b

-znetboot.initrd : zImage$(initrd)
-	cp $(images)/zImage$(initrd).prep $(TFTPIMAGE)
+znetboot : zImage
+	cp $(images)/zImage.prep $(TFTPIMAGE)
+	@echo '  kernel: $@ is ready ($<)'
+
+znetboot.initrd : zImage.initrd
+	cp $(images)/zImage.initrd.prep $(TFTPIMAGE)
+	@echo '  kernel: $@ is ready ($<)'
+

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
