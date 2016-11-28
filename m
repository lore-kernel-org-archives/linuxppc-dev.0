Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tRwS25jN0zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 16:37:38 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id x23so12074022pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2016 21:37:38 -0800 (PST)
Date: Mon, 28 Nov 2016 16:37:06 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Segher Boessenkool
 <segher@kernel.crashing.org>, Oliver O'Halloran <oohall@gmail.com>, Alan
 Modra <amodra@gmail.com>, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v3] powerpc/64be: option to use ELFv2 ABI for big endian
 kernels
Message-ID: <20161128163334.7a346e47@roar.ozlabs.ibm.com>
In-Reply-To: <20161127135439.6f56ff23@roar.ozlabs.ibm.com>
References: <20161126033338.13892-1-npiggin@gmail.com>
 <20161127135439.6f56ff23@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Provide an option to use ELFv2 ABI for big endian builds. The
toolchain check can't be done at configure-time, so the way this
option is provided can result in unbuildable kernel on older
toolchains. Being experimental expert option there isn't a need
to add a lot of fallback logic to make this build.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Hi,

Sorry for spamming this patch, kconfig has been more than a
match for me. Hopefully 3rd time's a charm.

Changes since v1:
- Fix kconfig so it (hopefully) works as expected with all combinations
  of EXPERT and endianness.
- Rebased to new "powerpc: allow compilation on cross-endian toolchain"

Changes since v2:
- Use a big-endian specific config option to avoid silently enabling
  ELFv2 when switching from LE to BE builds.


 arch/powerpc/Kconfig            | 19 +++++++++++++++++++
 arch/powerpc/Makefile           | 15 ++++++++++-----
 arch/powerpc/boot/Makefile      |  2 ++
 drivers/crypto/vmx/Makefile     |  6 +++++-
 drivers/crypto/vmx/aesp8-ppc.pl |  2 +-
 drivers/crypto/vmx/ppc-xlate.pl | 11 +++++++----
 6 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 65fba4c..6cb4c9e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -146,6 +146,7 @@ config PPC
 	select HAVE_ARCH_AUDITSYSCALL
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select DCACHE_WORD_ACCESS if PPC64 && CPU_LITTLE_ENDIAN
+	select BUILD_ELF_V2 if PPC64 && CPU_LITTLE_ENDIAN
 	select NO_BOOTMEM
 	select HAVE_GENERIC_RCU_GUP
 	select HAVE_PERF_EVENTS_NMI if PPC64
@@ -455,6 +456,24 @@ config KEXEC
 	  interface is strongly in flux, so no good recommendation can be
 	  made.
 
+config BUILD_ELF_V2
+	bool
+
+config BUILD_BIG_ENDIAN_ELF_V2
+	bool "Build big-endian kernel using ELFv2 ABI (EXPERIMENTAL)"
+	depends on PPC64 && CPU_BIG_ENDIAN && EXPERT
+	default n
+	select BUILD_ELF_V2
+	help
+	  This builds the kernel image using the ELFv2 ABI, which has a
+	  reduced stack overhead and faster function calls. This does not
+	  affect the userspace ABIs.
+
+	  ELFv2 is the standard ABI for little-endian, but for big-endian
+	  this is an experimental option that is not well tested (kernel or
+	  toolchain). This requires gcc 4.9 or newer and binutils 2.24 or
+	  newer.
+
 config RELOCATABLE
 	bool "Build a relocatable kernel"
 	depends on (PPC64 && !COMPILE_TEST) || (FLATMEM && (44x || FSL_BOOKE))
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a389ee0..9fbc1c8 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -73,10 +73,14 @@ MULTIPLEWORD	:= -mmultiple
 endif
 
 ifdef CONFIG_PPC64
-cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
-cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mcall-aixdesc)
-aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
-aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
+ifdef CONFIG_BUILD_ELF_V2
+cflags-y				+= $(call cc-option,-mabi=elfv2,$(call cc-option,-mcall-aixdesc))
+aflags-y				+= $(call cc-option,-mabi=elfv2)
+else
+cflags-y				+= $(call cc-option,-mabi=elfv1)
+cflags-y				+= $(call cc-option,-mcall-aixdesc)
+aflags-y				+= $(call cc-option,-mabi=elfv1)
+endif
 endif
 
 cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
@@ -116,7 +120,7 @@ endif
 endif
 
 CFLAGS-$(CONFIG_PPC64)	:= $(call cc-option,-mtraceback=no)
-ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
+ifdef CONFIG_BUILD_ELF_V2
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2,$(call cc-option,-mcall-aixdesc))
 AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2)
 else
@@ -124,6 +128,7 @@ CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcall-aixdesc)
 AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 endif
+
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 7c46cf3..0442516 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -31,8 +31,10 @@ BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 # PPC64_BOOT_WRAPPER is little-endian specific.
 ifdef CONFIG_PPC64_BOOT_WRAPPER
 BOOTCFLAGS	+= -m64
+ifdef CONFIG_BUILD_ELF_V2
 BOOTCFLAGS	+= $(call cc-option,-mabi=elfv2)
 endif
+endif
 
 ifdef CONFIG_CPU_BIG_ENDIAN
 BOOTCFLAGS	+= -mbig-endian
diff --git a/drivers/crypto/vmx/Makefile b/drivers/crypto/vmx/Makefile
index de6e241..b47da00 100644
--- a/drivers/crypto/vmx/Makefile
+++ b/drivers/crypto/vmx/Makefile
@@ -1,11 +1,15 @@
 obj-$(CONFIG_CRYPTO_DEV_VMX_ENCRYPT) += vmx-crypto.o
 vmx-crypto-objs := vmx.o aesp8-ppc.o ghashp8-ppc.o aes.o aes_cbc.o aes_ctr.o aes_xts.o ghash.o
 
-ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
+ifdef CONFIG_CPU_LITTLE_ENDIAN
 TARGET := linux-ppc64le
 else
+ifdef CONFIG_BUILD_ELF_V2
+TARGET := linux-ppc64v2
+else
 TARGET := linux-ppc64
 endif
+endif
 
 quiet_cmd_perl = PERL $@
       cmd_perl = $(PERL) $(<) $(TARGET) > $(@)
diff --git a/drivers/crypto/vmx/aesp8-ppc.pl b/drivers/crypto/vmx/aesp8-ppc.pl
index 0b4a293..6d423f6 100644
--- a/drivers/crypto/vmx/aesp8-ppc.pl
+++ b/drivers/crypto/vmx/aesp8-ppc.pl
@@ -61,7 +61,7 @@ if ($flavour =~ /64/) {
 	$SHL	="slwi";
 } else { die "nonsense $flavour"; }
 
-$LITTLE_ENDIAN = ($flavour=~/le$/) ? $SIZE_T : 0;
+$LITTLE_ENDIAN = ($flavour=~/ppc64le/) ? $SIZE_T : 0;
 
 $0 =~ m/(.*[\/\\])[^\/\\]+$/; $dir=$1;
 ( $xlate="${dir}ppc-xlate.pl" and -f $xlate ) or
diff --git a/drivers/crypto/vmx/ppc-xlate.pl b/drivers/crypto/vmx/ppc-xlate.pl
index b18e67d..0355a1e 100644
--- a/drivers/crypto/vmx/ppc-xlate.pl
+++ b/drivers/crypto/vmx/ppc-xlate.pl
@@ -8,6 +8,8 @@ open STDOUT,">$output" || die "can't open $output: $!";
 
 my %GLOBALS;
 my $dotinlocallabels=($flavour=~/linux/)?1:0;
+my $abielfv2=(($flavour =~ /linux-ppc64le/) or ($flavour =~ /linux-ppc64v2/))?1:0;
+my $dotfunctions=($abielfv2=~1)?0:1;
 
 ################################################################
 # directives which need special treatment on different platforms
@@ -37,9 +39,10 @@ my $globl = sub {
     $$global = $name;
     $ret;
 };
+
 my $text = sub {
     my $ret = ($flavour =~ /aix/) ? ".csect\t.text[PR],7" : ".text";
-    $ret = ".abiversion	2\n".$ret	if ($flavour =~ /linux.*64le/);
+    $ret = ".abiversion	2\n".$ret	if ($abielfv2);
     $ret;
 };
 my $machine = sub {
@@ -55,8 +58,8 @@ my $size = sub {
     if ($flavour =~ /linux/)
     {	shift;
 	my $name = shift; $name =~ s|^[\.\_]||;
-	my $ret  = ".size	$name,.-".($flavour=~/64$/?".":"").$name;
-	$ret .= "\n.size	.$name,.-.$name" if ($flavour=~/64$/);
+	my $ret  = ".size	$name,.-".($dotfunctions?".":"").$name;
+	$ret .= "\n.size	.$name,.-.$name" if ($dotfunctions);
 	$ret;
     }
     else
@@ -141,7 +144,7 @@ my $vmr = sub {
 
 # Some ABIs specify vrsave, special-purpose register #256, as reserved
 # for system use.
-my $no_vrsave = ($flavour =~ /linux-ppc64le/);
+my $no_vrsave = ($abielfv2);
 my $mtspr = sub {
     my ($f,$idx,$ra) = @_;
     if ($idx == 256 && $no_vrsave) {
-- 
2.10.2
