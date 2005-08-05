Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 5 Aug 2005 17:47:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linuxppc64-dev@ozlabs.org
Message-Id: <20050805174705.731ffa05.sfr@canb.auug.org.au>
In-Reply-To: <688ba2276de281a9473b030a16a514c0@embeddededge.com>
References: <1123023575.2614.25.camel@cashmere.sps.mot.com>
	<688ba2276de281a9473b030a16a514c0@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] 1/2 Start header file merger (Was: Re: Beginning Merger
 Patch)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2 Aug 2005 19:10:56 -0400 Dan Malek <dan@embeddededge.com> wrote:
>
> On Aug 2, 2005, at 6:59 PM, Jon Loeliger wrote:
> 
> > ..... A stub is left
> > in asm-ppc and asm-ppc64 pointing to the unified files.
> 
> Why bother?  You may as well change all of the source
> files, too, or else that will never get done :-)

You actually don't need to modify (m)any source files.

Here is an alternative approach.  These patches depend on Olaf's
boot code cleanup for ppc64 (or similar).  Do the following:

cd linux/include
mkdir asm-powerpc
cd asm-ppc
for i in *
do
	[ -e ../asm-ppc64/$i ] || mv $i ../asm-powerpc/$i
done
cd ../asm-ppc64
for i in *
do
	[ -e ../asm-ppc/$i ] || mv $i ../asm-powerpc/$i
done
for i in *
do
	[ -f ../asm-ppc64/$i ] && cmp -s $i ../asm-ppc64/$i &&
		mv $i ../asm-powerpc/$i && rm ../asm-ppc64/$i
done

Then apply the patch below and the patch in the following email.

I have built this kernel for ppc (defconfig), ppc64 (iSeries, pSeries and
pmac).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus-powerpc.xx/arch/ppc/Makefile linus-powerpc.1/arch/ppc/Makefile
--- linus-powerpc.xx/arch/ppc/Makefile	2005-06-27 16:08:00.000000000 +1000
+++ linus-powerpc.1/arch/ppc/Makefile	2005-08-05 11:19:25.000000000 +1000
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
+LINUXINCLUDE	+= -Iinclude3
 
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
+	$(Q)if [ ! -d include3 ]; then mkdir -p include3; fi;
+	$(Q)ln -fsn $(srctree)/include/asm-powerpc include3/asm
+
 # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
 # to stdout and these checks are run even on install targets.
 TOUT	:= .tmp_gas_check
diff -ruNp linus-powerpc.xx/arch/ppc64/Makefile linus-powerpc.1/arch/ppc64/Makefile
--- linus-powerpc.xx/arch/ppc64/Makefile	2005-06-27 16:08:00.000000000 +1000
+++ linus-powerpc.1/arch/ppc64/Makefile	2005-08-05 11:19:50.000000000 +1000
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
+include/asm:	include3/asm
+include3/asm:
+	$(Q)if [ ! -d include3 ]; then mkdir -p include3; fi;
+	$(Q)ln -fsn $(srctree)/include/asm-powerpc include3/asm
+
 define archhelp
   echo  '* zImage       - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
   echo  '  zImage.initrd- Compressed kernel image with initrd attached,'
