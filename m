Date: Fri, 16 Apr 2004 15:22:43 +0200
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: zImage.chrp broken in 2.6.5, patch provided, please someone apply it.
Message-ID: <20040416132243.GA11434@pegasos>
References: <20040416085641.GA21264@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040416085641.GA21264@pegasos>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Apr 16, 2004 at 10:56:41AM +0200, Sven Luther wrote:
> Hello,
>
> Find here attached a patch to enable zImage.chrp to work again (and
> probably zImage.chrp-rs6k too). This was broken in 2.6.5, when akpm
> introduced the ld.script dependency, without fixing the cmd_gen-chrp
> to not take $^ to link, but the individual objects, as done for the
> pmac case.
>
> I hope i did the right fix.
>
> Friendly,
>
> Sven Luther

Ah, the patch didn't work after all, while this one does :

diff -urN kernel-source-2.6.5/arch/ppc/boot/openfirmware/Makefile kernel-source-2.6.5-powerpc/arch/ppc/boot/openfirmware/Makefile
--- kernen-source-2.6.5/arch/ppc/boot/openfirmware/Makefile.orig	2004-04-16 10:49:09.675252096 +0200
+++ kernel-source-2.6.5-powerpc/arch/ppc/boot/openfirmware/Makefile	2004-04-16 10:52:02.941911560 +0200
@@ -123,10 +123,10 @@
 	$(call cmd,gen-elf-pmac)

 quiet_cmd_gen-chrp = CHRP    $@
-      cmd_gen-chrp = $(LD) $(CHRP_LD_ARGS) -o $@ $^ && \
+      cmd_gen-chrp = $(LD) $(CHRP_LD_ARGS) -o $@ $(CHRPOBJS) $< $(LIBS) && \
 			$(OBJCOPY) $@ $@ -R .comment $(del-ramdisk-sec)

-$(images)/zImage.chrp: $(CHRPOBJS) $(obj)/image.o $(LIBS) $(boot)/ld.script
+$(images)/zImage.chrp: $(obj)/image.o $(CHRPOBJS) $(LIBS) $(boot)/ld.script
 	$(call cmd,gen-chrp)
 $(images)/zImage.initrd.chrp: $(CHRPOBJS) $(obj)/image.initrd.o $(LIBS) $(boot)/ld.script
 	$(call cmd,gen-chrp)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
