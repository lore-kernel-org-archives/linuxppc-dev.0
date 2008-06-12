Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id DD454DDF06
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 04:11:35 +1000 (EST)
Date: Thu, 12 Jun 2008 20:12:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: powerpc build failure
Message-ID: <20080612181214.GB2271@uranus.ravnborg.org>
References: <20080611192748.686236fd.sfr@canb.auug.org.au>
	<20080611095951.GB14033@elte.hu>
	<18512.32267.636550.47385@cargo.ozlabs.ibm.com>
	<20080612053335.GA22035@bubble.grove.modra.org>
	<20080612170505.6049fa75.sfr@canb.auug.org.au>
	<20080612172403.4b04713b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080612172403.4b04713b.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Alan Modra <amodra@bigpond.net.au>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2008 at 05:24:03PM +1000, Stephen Rothwell wrote:
> On Thu, 12 Jun 2008 17:05:05 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > So, I will disable FTRACE on powerpc for now by removing HAVE_FTRACE from
> > being selected in arch/powerpc/Kconfig.
> 
> That got rid of the initial errors, but now it fails for relocations
> on .memcmp and some others.
> 
> Next guess:  I have reverted commit
> a7815807f749669d3e06529b2d448390f2ef0f9d ("kbuild: simplify vmlinux link
> stage") and powerpc allmodconfig builds again.  (even with FTRACE reenabled)
> 
> [For those that came in late (Sam):  a powerpc allyesconfig build was
> getting errors like this:
> 
> net/ipx/af_ipx.c:1830: relocation truncated to fit: R_PPC64_REL24 against symbol `._mcount' defined in .text section in vmlinux.o
> 
> which I surmised was caused by ftrace adding -pg to KBUILD_CFLAGS.]

I do not get if this was fixed by the revert of the kbuild patch or
this was a ftrace bug?

I have the following pending (awaiting testing feedback from Jeff Dike).

	Sam

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 06cbc09..4eb0b07 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -104,7 +104,7 @@ archprepare: $(ARCH_SYMLINKS) $(ARCH_DIR)/include/user_constants.h
 prepare: $(ARCH_DIR)/include/kern_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -rpath /lib -rpath /usr/lib
+LINK-$(CONFIG_LD_SCRIPT_DYN) += -L/lib -L/usr/lib
 
 CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
 	$(call cc-option, -fno-stack-protector,) \
@@ -118,7 +118,13 @@ CPPFLAGS_vmlinux.lds = -U$(SUBARCH) -DSTART=$(START) -DELF_ARCH=$(ELF_ARCH) \
 
 # The wrappers will select whether using "malloc" or the kernel allocator.
 LDFLAGS_vmlinux := $(LINK-y) --wrap malloc --wrap free --wrap calloc
-KBUILD_VMLINUX_EXTRA := -lutil
+KBUILD_VMLINUX_EXTRA := \
+$(shell $(CC) -print-file-name=crt1.o)        \
+$(shell $(CC) -print-file-name=crti.o)        \
+$(shell $(CC) -print-file-name=libgcc_s.so)   \
+$(shell $(CC) -print-file-name=ld-linux.so.2) \
+$(shell $(CC) -print-file-name=libutil.so)    \
+$(shell $(CC) -print-file-name=libc.so)
 
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index b9ecff5..e8fc6ab 100644
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -95,8 +95,7 @@ mksysmap()
 tell LD vmlinux.o
 ${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -r -o vmlinux.o      \
 	${KBUILD_VMLINUX_INIT}                           \
-        --start-group ${KBUILD_VMLINUX_MAIN} --end-group \
-	${KBUILD_VMLINUX_EXTRA}
+        --start-group ${KBUILD_VMLINUX_MAIN} --end-group
 
 # modpost vmlinux.o
 ${MAKE} -f ${srctree}/scripts/Makefile.modpost vmlinux.o
@@ -121,19 +120,19 @@ fi
 
 # First stage of fully linked vmlinux
 tell LD ${VMLINUX}
-${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${VMLINUX} \
-      -T ${KBUILD_VMLINUX_LDS} vmlinux.o
+${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} ${KBUILD_VMLINUX_EXTRA} \
+        -o ${VMLINUX} -T ${KBUILD_VMLINUX_LDS} vmlinux.o
 
 if [ "${CONFIG_KALLSYMS}" = "y" ]; then
 
 	# Do an extra pass to link in kallsyms data
 	${NM} -n .tmp_vmlinux | scripts/kallsyms > .tmp_kallsyms.S
-        ${CC} ${KBUILD_AFLAGS} ${KBUILD_CPPFLAGS} -c -o .tmp_kallsyms.o \
-	      .tmp_kallsyms.S
+        ${CC} ${KBUILD_AFLAGS} ${AFLAGS_KERNEL} ${KBUILD_CPPFLAGS} -c \
+	      -o .tmp_kallsyms.o .tmp_kallsyms.S
         # link in kalll symbols
 	tell LD vmlinux
-        ${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o vmlinux \
-         -T ${KBUILD_VMLINUX_LDS} vmlinux.o .tmp_kallsyms.o
+        ${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} ${KBUILD_VMLINUX_EXTRA} \
+	      -o vmlinux -T ${KBUILD_VMLINUX_LDS} vmlinux.o .tmp_kallsyms.o
 fi
 
 tell SYSMAP System.map
