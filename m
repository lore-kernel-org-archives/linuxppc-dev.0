Date: Thu, 28 Jun 2001 14:04:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-commit@ppcbk.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Cleanups of arch/ppc/boot/Makefile
Message-ID: <20010628140434.C18845@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey all.  After talking to paulus a bit, arch/ppc/boot/Makefile needs some
cleaning and fixing.  It doesn't always get deps and it's kinda ugly too.
I've changed it around to use subdir-$(CONFIG_ARCH) andwhatnot to get deps/
tools compiled.  My main problem is I couldn't get the subdirs done in a way
that I thought was clean & nice looking.  I've attached a patch vs 2_4_devel
of what I've done so far.  But if anyone can make the subdir-<target>-list
stuff look nice I'd appreaciate it.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="newboot.patch"

===== arch/ppc/Makefile 1.19 vs edited =====
--- 1.19/arch/ppc/Makefile	Wed Jun 27 11:39:50 2001
+++ edited/arch/ppc/Makefile	Wed Jun 27 14:07:57 2001
@@ -103,4 +103,4 @@
 archmrproper:

 archdep:
-	$(MAKEBOOT) dep
+	$(MAKEBOOT) fastdep
===== arch/ppc/boot/Makefile 1.12 vs edited =====
--- 1.12/arch/ppc/boot/Makefile	Tue May 22 13:42:21 2001
+++ edited/arch/ppc/boot/Makefile	Wed Jun 27 14:07:32 2001
@@ -10,17 +10,6 @@
 # modified by Cort (cort@cs.nmt.edu)
 #

-.c.s:
-	$(CC) $(CFLAGS) -S -o $*.s $<
-.s.o:
-	$(AS) -o $*.o $<
-.c.o:
-	$(CC) $(CFLAGS) -c -o $*.o $<
-.S.s:
-	$(CPP) $(AFLAGS) -traditional -o $*.o $<
-.S.o:
-	$(CC) $(AFLAGS) -traditional -c -o $*.o $<
-
 GZIP_FLAGS = -v9f

 CFLAGS	:= $(CPPFLAGS) -O2 -DSTDC_HEADERS -fno-builtin -D__BOOTER__ \
@@ -34,58 +23,67 @@
 TFTPSIMAGE=/tftpboot/sImage
 endif

-
 lib/zlib.a:
 	$(MAKE) -C lib

 images/vmlinux.gz: $(TOPDIR)/vmlinux
 	$(MAKE) -C images vmlinux.gz

-# Since gemini doesn't need/have it's own directory, we do znetboot* here
-ifdef CONFIG_GEMINI
-BOOT_TARGETS = zImage zImage.initrd
-else
-BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd
-endif
-
-# We go into the utils dir by hand to ensure HOSTCC builds
-$(BOOT_TARGETS): sImage vmapus lib/zlib.a images/vmlinux.gz
-ifneq ("xx$(CONFIG_8260)$(CONFIG_8xx)","xx")
-	$(MAKE) -C mbx $@
-endif
-ifdef CONFIG_ALL_PPC
-	$(MAKE) -C utils addnote piggyback mknote hack-coff mkprep
-	$(MAKE) -C chrp $@
-	$(MAKE) -C pmac $@
-	$(MAKE) -C prep $@
-endif
-ifdef CONFIG_4xx
-	$(MAKE) -C tree $@
-endif
-ifdef CONFIG_K2
-	$(MAKE) -C utils mkpmon
-	$(MAKE) -C pmon $@
-endif
-ifdef CONFIG_MENF1
-	$(MAKE) -C utils mkprep
-	$(MAKE) -C menf1 $@
-endif
-ifneq ("xx$(CONFIG_MVME5100)$(CONFIG_PRPMC750)$(CONFIG_MCPN765)","xx")
-	$(MAKE) -C utils mkbugboot mkprep
-	$(MAKE) -C pp3 $@
-endif
-ifdef CONFIG_PCORE
-	$(MAKE) -C pcore $@
-endif
-ifdef CONFIG_SANDPOINT
-	$(MAKE) -C sandpoint $@
-endif
-ifdef CONFIG_SPRUCE
-	$(MAKE) -C spruce $@
-endif
-ifdef CONFIG_ZX4500
-	$(MAKE) -C zx4500 $@
-endif
+# Subdirs and tools needed for each.
+subdir-$(CONFIG_ALL_PPC)	+= chrp pmac prep lib images common
+tools-$(CONFIG_ALL_PPC)		:= addnote piggyback mknote hack-coff mkprep
+subdir-$(CONFIG_8260)		+= mbx lib images common
+subdir-$(CONFIG_8xx)		+= mbx lib images common
+subdir-$(CONFIG_4xx)		+= tree lib images common
+subdir-$(CONFIG_K2)		+= pmon lib images common
+tools-$(CONFIG_K2)		:= mkpmon
+subdir-$(CONFIG_MENF1)		+= menf1 lib images common
+tools-$(CONFIG_MENF1)		:= mkprep
+subdir-$(CONFIG_MVME5100)	+= pp3 lib images common
+tools-$(CONFIG_MVME5100)	:= mkbugboot mkprep
+subdir-$(CONFIG_PRPMC750)	+= pp3 lib images common
+tools-$(CONFIG_PRPMC750)	:= mkbugboot mkprep
+subdir-$(CONFIG_MCPN765)	+= pp3 lib images common
+tools-$(CONFIG_MCPN750)		:= mkbugboot mkprep
+subdir-$(CONFIG_PCORE)		+= pcore lib images common
+subdir-$(CONFIG_SANDPOINT)	+= sandpoint lib images common
+subdir-$(CONFIG_SPRUCE)		+= spruce lib images common
+subdir-$(CONFIG_ZX4500)		+= zx4500 lib images
+
+# These are dirs we don't want to go into on BOOT_TARGETS
+NONBOOT				:= lib images common
+
+# These are the subdirs we want to use
+BOOTDIRS			= $(filter-out $(NONBOOT), $(subdir-y))
+
+# This will make the tools we need.  We do it like this to ensure that we use
+# HOSTCC. -- Tom
+maketools:
+	$(MAKE) -C utils $(tools-y)
+
+# How can this be done cleaner?  HELP! -- Tom
+subdir-zImage-list = $(sort $(patsubst %,_bdzI_%,$(BOOTDIRS)))
+$(subdir-zImage-list) : dummy
+	$(MAKE) -C $(patsubst _bdzI_%,%,$@) zImage
+
+subdir-zImage.initrd-list = $(sort $(patsubst %,_bdzIrd_%,$(BOOTDIRS)))
+boot_dirs_zImage.initrd: dummy $(subdir-zImage.initrd-list)
+$(subdir-zImage.initrd-list) : dummy
+	$(MAKE) -C $(patsubst _bdzIrd_%,%,$@) zImage.initrd
+
+subdir-znetboot-list = $(sort $(patsubst %,_bdzn_%,$(BOOTDIRS)))
+boot_dirs_znetboot: dummy $(subdir-znetboot-list)
+$(subdir-znetboot-list) : dummy
+	$(MAKE) -C $(patsubst _bdzn_%,%,$@) znetboot
+
+subdir-znetboot.initrd-list = $(sort $(patsubst %,_bdznrd_%,$(BOOTDIRS)))
+boot_dirs_znetboot.initrd: dummy $(subdir-znetboot.initrd-list)
+$(subdir-znetboot.initrd-list) : dummy
+	$(MAKE) -C $(patsubst _bdznrd_%,%,$@) znetboot.initrd
+
+zImage: sImage vmapus lib/zlib.a images/vmlinux.gz maketools $(subdir-zImage-list)
+zImage.initrd: sImage vmapus lib/zlib.a images/vmlinux.gz maketools boot_dirs_zImage.initrd
+znetboot.initrd: sImage vmapus lib/zlib.a images/vmlinux.gz maketools boot_dirs_znetboot.initrd

 sImage: $(TOPDIR)/vmlinux
 ifdef CONFIG_GEMINI
@@ -101,29 +99,16 @@
 ifdef CONFIG_GEMINI
 znetboot : zImage
 	cp images/sImage $(TFTPSIMAGE)
+else
+znetboot: sImage vmapus lib/zlib.a images/vmlinux.gz maketools boot_dirs_znetboot
 endif

-# Do the dirs
+# Clean up after ourselves.  We have to do it like this since only some dirs
+# need to be gone into. -- Tom
 clean:
 	$(MAKE) -C images clean
 	$(MAKE) -C spruce clean
 	$(MAKE) -C tree clean
 	$(MAKE) -C utils clean
-
-dep:
-	$(MAKE) -C chrp fastdep
-	$(MAKE) -C common fastdep
-	$(MAKE) -C lib fastdep
-	$(MAKE) -C mbx fastdep
-	$(MAKE) -C menf1 fastdep
-	$(MAKE) -C pcore fastdep
-	$(MAKE) -C pmac fastdep
-	$(MAKE) -C pmon fastdep
-	$(MAKE) -C pp3 fastdep
-	$(MAKE) -C prep fastdep
-	$(MAKE) -C sandpoint fastdep
-	$(MAKE) -C spruce fastdep
-	$(MAKE) -C tree fastdep
-	$(MAKE) -C zx4500 fastdep

 include $(TOPDIR)/Rules.make

--/04w6evG8XlLl3ft--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
