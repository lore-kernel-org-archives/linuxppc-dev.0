Date: Fri, 16 Apr 2004 10:56:41 +0200
To: linuxppc-dev@lists.linuxppc.org
Subject: zImage.chrp broken in 2.6.5, patch provided, please someone apply it.
Message-ID: <20040416085641.GA21264@pegasos>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hello,

Find here attached a patch to enable zImage.chrp to work again (and
probably zImage.chrp-rs6k too). This was broken in 2.6.5, when akpm
introduced the ld.script dependency, without fixing the cmd_gen-chrp
to not take $^ to link, but the individual objects, as done for the
pmac case.

I hope i did the right fix.

Friendly,

Sven Luther

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="Makefile.diff"

--- arch/ppc/boot/openfirmware/Makefile.orig	2004-04-16 10:49:09.675252096 +0200
+++ arch/ppc/boot/openfirmware/Makefile	2004-04-16 10:52:02.941911560 +0200
@@ -123,10 +123,10 @@
 	$(call cmd,gen-elf-pmac)

 quiet_cmd_gen-chrp = CHRP    $@
-      cmd_gen-chrp = $(LD) $(CHRP_LD_ARGS) -o $@ $^ && \
+      cmd_gen-chrp = $(LD) $(CHRP_LD_ARGS) -o $@ $(CHRPOBJS) $(LIBS) $< && \
 			$(OBJCOPY) $@ $@ -R .comment $(del-ramdisk-sec)

-$(images)/zImage.chrp: $(CHRPOBJS) $(obj)/image.o $(LIBS) $(boot)/ld.script
+$(images)/zImage.chrp: $(obj)/image.o $(CHRPOBJS) $(LIBS) $(boot)/ld.script
 	$(call cmd,gen-chrp)
 $(images)/zImage.initrd.chrp: $(CHRPOBJS) $(obj)/image.initrd.o $(LIBS) $(boot)/ld.script
 	$(call cmd,gen-chrp)

--mP3DRpeJDSE+ciuQ--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
