Date: Wed, 10 Dec 2003 13:28:40 +0100
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] boot/ld.script dependency missing
Message-ID: <20031210122840.GA11183@suse.de>
References: <20031201212931.GA10959@suse.de> <20031203160958.GF912@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20031203160958.GF912@stop.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Wed, Dec 03, Tom Rini wrote:

> On Mon, Dec 01, 2003 at 10:29:31PM +0100, Olaf Hering wrote:
>
> > fiddling with ld.script doesnt trigger a rebuild of the boot files.

This one is for 2.4.23.


--- ./arch/ppc/boot/pmac/Makefile~	2003-08-25 13:44:40.000000000 +0200
+++ ./arch/ppc/boot/pmac/Makefile	2003-12-10 13:11:52.000000000 +0100
@@ -84,7 +84,7 @@ vmlinux.initrd.coff: coffboot.initrd $(H
 	rm -f coffboot.initrd
 	ln -sf vmlinux.initrd.coff ../images/zImage.initrd.pmac

-vmlinux.elf-pmac: $(CHRPOBJS) $(LIBS) $(MKNOTE) image.o
+vmlinux.elf-pmac: $(CHRPOBJS) $(LIBS) $(MKNOTE) image.o ../ld.script
 	$(LD) $(CHRP_LD_ARGS) -o ../images/$@ $(CHRPOBJS) $(LIBS) image.o
 	$(MKNOTE) > note
 	$(OBJCOPY) ../images/$@ ../images/$@ --add-section=.note=note \
@@ -92,7 +92,7 @@ vmlinux.elf-pmac: $(CHRPOBJS) $(LIBS) $(
 	rm -f note

 vmlinux.initrd.elf-pmac: $(CHRPOBJS) $(LIBS) $(MKNOTE) image.o \
-		../images/ramdisk.image.gz
+		../images/ramdisk.image.gz ../ld.script
 	$(OBJCOPY) image.o image-elf.o \
 		--add-section=.ramdisk=../images/ramdisk.image.gz \
 		--set-section-flags=.ramdisk=contents,alloc,load,readonly,data
--- ./arch/ppc/boot/chrp/Makefile~	2003-06-13 16:51:31.000000000 +0200
+++ ./arch/ppc/boot/chrp/Makefile	2003-12-10 13:11:25.000000000 +0100
@@ -50,13 +50,13 @@ ifdef CONFIG_XMON
 		--set-section-flags=.sysmap=contents,alloc,load,readonly,data
 endif

-zImage: $(OBJS) $(LIBS) $(ADDNOTE)
+zImage: $(OBJS) $(LIBS) $(ADDNOTE) ../ld.script
 	$(LD) $(LD_ARGS) -o ../images/$@.chrp $(OBJS) $(LIBS)
 	$(OBJCOPY) ../images/$@.chrp ../images/$@.chrp -R .comment -R .ramdisk
 	cp ../images/$@.chrp ../images/$@.chrp-rs6k
 	$(ADDNOTE) ../images/$@.chrp-rs6k

-zImage.initrd: $(OBJS) $(LIBS) $(ADDNOTE) ../images/ramdisk.image.gz
+zImage.initrd: $(OBJS) $(LIBS) $(ADDNOTE) ../images/ramdisk.image.gz ../ld.script
 	$(OBJCOPY) image.o image.o \
 		--add-section=.ramdisk=../images/ramdisk.image.gz \
 		--set-section-flags=.ramdisk=contents,alloc,load,readonly,data

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
