Date: Mon, 1 Dec 2003 22:29:31 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] boot/ld.script dependency missing
Message-ID: <20031201212931.GA10959@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


fiddling with ld.script doesnt trigger a rebuild of the boot files.


diff -purNX /home/olaf/kernel/kernel_exclude.txt linux-2.6.0-test11.orig/arch/ppc/boot/openfirmware/Makefile linux-2.6.0-test11.SuSE/arch/ppc/boot/openfirmware/Makefile
--- linux-2.6.0-test11.orig/arch/ppc/boot/openfirmware/Makefile	2003-11-26 20:43:32.000000000 +0000
+++ linux-2.6.0-test11.SuSE/arch/ppc/boot/openfirmware/Makefile	2003-11-30 17:55:30.000000000 +0000
@@ -104,10 +104,10 @@ quiet_cmd_gen-coff = COFF    $@
 			$(HACKCOFF) $@ && \
 			ln -sf $(notdir $@) $(images)/zImage$(initrd).pmac

-$(images)/vmlinux.coff: $(obj)/coffboot
+$(images)/vmlinux.coff: $(obj)/coffboot $(boot)/ld.script
 	$(call cmd,gen-coff)

-$(images)/vmlinux.initrd.coff: $(obj)/coffboot.initrd
+$(images)/vmlinux.initrd.coff: $(obj)/coffboot.initrd $(boot)/ld.script
 	$(call cmd,gen-coff)

 quiet_cmd_gen-elf-pmac = ELF     $@
@@ -116,19 +116,19 @@ quiet_cmd_gen-elf-pmac = ELF     $@
 			$(OBJCOPY) $@ $@ --add-section=.note=$(obj)/note \
 					 -R .comment $(del-ramdisk-sec)

-$(images)/vmlinux.elf-pmac: $(obj)/image.o $(NEWWORLDOBJS) $(LIBS) $(obj)/note
+$(images)/vmlinux.elf-pmac: $(obj)/image.o $(NEWWORLDOBJS) $(LIBS) $(obj)/note $(boot)/ld.script
 	$(call cmd,gen-elf-pmac)
 $(images)/vmlinux.initrd.elf-pmac: $(obj)/image.initrd.o $(NEWWORLDOBJS) \
-				   $(LIBS) $(obj)/note
+				   $(LIBS) $(obj)/note $(boot)/ld.script
 	$(call cmd,gen-elf-pmac)

 quiet_cmd_gen-chrp = CHRP    $@
       cmd_gen-chrp = $(LD) $(CHRP_LD_ARGS) -o $@ $^ && \
 			$(OBJCOPY) $@ $@ -R .comment $(del-ramdisk-sec)

-$(images)/zImage.chrp: $(CHRPOBJS) $(obj)/image.o $(LIBS)
+$(images)/zImage.chrp: $(CHRPOBJS) $(obj)/image.o $(LIBS) $(boot)/ld.script
 	$(call cmd,gen-chrp)
-$(images)/zImage.initrd.chrp: $(CHRPOBJS) $(obj)/image.initrd.o $(LIBS)
+$(images)/zImage.initrd.chrp: $(CHRPOBJS) $(obj)/image.initrd.o $(LIBS) $(boot)/ld.script
 	$(call cmd,gen-chrp)

 quiet_cmd_addnote = ADDNOTE $@
--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
