Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEE6C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 15:32:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4DE20652
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 15:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4DE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P5rJ3kV6zF39p
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 01:32:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.196; helo=mail-oi1-f196.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P5hS3xWqzF31R
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 01:25:44 +1000 (AEST)
Received: by mail-oi1-f196.google.com with SMTP id l197-v6so11510485oib.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 08:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OzogrFexvBVWCFhoM4iFq+GU8ve19vvStlWEoVu1h2M=;
 b=XaPx999Qj9XkAo2eSIuCHX7+/Smv84kD5sItRI7/p0AkQzfHEDGb7eRYQcU0SO0AyZ
 y6g/frnY+99QOCt+dVzlmDsgnveCr2pP3degMSSnHLybZT3S5jPoViivbr4cKFymlyJi
 5pNYaM2wk8IMni8IzRi3xq4w/uQroY1Mqu7pv3WlsecuvIR98pNUcV6qncnjcruD5hkJ
 9jpX/uS2vt6VEzOLQ+OnihcMU4L6fa4FZcuaKJTxcMwYjUJPmhgNvHFH3C2jRb4twQbq
 aDxi21UdR7+9qcP3zpyF57xv7k2/yQld0qKCv687NzOS6uvlwAAfOKeDTTPcVwGxHK3i
 f66w==
X-Gm-Message-State: ABuFfogHLlk+xsj9xaINJNvgfBd/QaHTpjF6BGUeWgZEAtQkOieKtqmQ
 ImZepa1RozHgoaqiVvBcqg==
X-Google-Smtp-Source: ACcGV63GCZPsbYrJbmP3lX8eftcsCgXAizws0aM2B6yhFVJ9tSvAORegn8Ns6kttwjq55dhYOoiLOg==
X-Received: by 2002:aca:5195:: with SMTP id
 f143-v6mr4994809oib.336.1538407541845; 
 Mon, 01 Oct 2018 08:25:41 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 s203-v6sm2047035oif.33.2018.10.01.08.25.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Oct 2018 08:25:41 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v4 6/9] kbuild: consolidate Devicetree dtb build rules
Date: Mon,  1 Oct 2018 10:25:28 -0500
Message-Id: <20181001152531.3385-7-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001152531.3385-1-robh@kernel.org>
References: <20181001152531.3385-1-robh@kernel.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, Will Deacon <will.deacon@arm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 linux-xtensa@linux-xtensa.org, linux-kbuild@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Michal Marek <michal.lkml@markovi.net>,
 Vineet Gupta <vgupta@synopsys.com>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, nios2-dev@lists.rocketboards.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There is nothing arch specific about building dtb files other than their
location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
The dependencies and supported targets are all slightly different.
Also, a cross-compiler for each arch is needed, but really the host
compiler preprocessor is perfectly fine for building dtbs. Move the
build rules to a common location and remove the arch specific ones. This
is done in a single step to avoid warnings about overriding rules.

The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
These pull in several dependencies some of which need a target compiler
(specifically devicetable-offsets.h) and aren't needed to build dtbs.
All that is really needed is dtc, so adjust the dependencies to only be
dtc.

This change enables support 'dtbs_install' on some arches which were
missing the target.

Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Paul Burton <paul.burton@mips.com>
Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: linux-mips@linux-mips.org
Cc: nios2-dev@lists.rocketboards.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v4:
 - Make dtbs and %.dtb rules depend on arch/$ARCH/boot/dts path rather than
   CONFIG_OF_EARLY_FLATTREE
 - Fix install path missing kernel version for dtbs_install
 - Fix "make CONFIG_OF_ALL_DTBS=y" for arches like ARM which selectively
   enable CONFIG_OF (and therefore dtc)


 Makefile                          | 37 ++++++++++++++++++++++++++++++-
 arch/arc/Makefile                 |  6 -----
 arch/arm/Makefile                 | 20 +----------------
 arch/arm64/Makefile               | 17 +-------------
 arch/c6x/Makefile                 |  2 --
 arch/h8300/Makefile               | 11 +--------
 arch/microblaze/Makefile          |  4 +---
 arch/microblaze/boot/dts/Makefile |  2 ++
 arch/mips/Makefile                | 15 +------------
 arch/nds32/Makefile               |  2 +-
 arch/nios2/Makefile               |  7 ------
 arch/nios2/boot/Makefile          |  4 ----
 arch/powerpc/Makefile             |  3 ---
 arch/xtensa/Makefile              | 12 +---------
 scripts/Makefile                  |  3 +--
 scripts/Makefile.lib              |  2 +-
 scripts/dtc/Makefile              |  2 +-
 17 files changed, 48 insertions(+), 101 deletions(-)

diff --git a/Makefile b/Makefile
index 6c3da3e10f07..251875470c5b 100644
--- a/Makefile
+++ b/Makefile
@@ -1061,7 +1061,7 @@ include/config/kernel.release: $(srctree)/Makefile FORCE
 # Carefully list dependencies so we do not try to build scripts twice
 # in parallel
 PHONY += scripts
-scripts: scripts_basic asm-generic gcc-plugins $(autoksyms_h)
+scripts: scripts_basic scripts_dtc asm-generic gcc-plugins $(autoksyms_h)
 	$(Q)$(MAKE) $(build)=$(@)

 # Things we need to do before we recursively start building the kernel
@@ -1205,6 +1205,35 @@ kselftest-merge:
 		$(srctree)/tools/testing/selftests/*/config
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig

+# ---------------------------------------------------------------------------
+# Devicetree files
+
+ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
+dtstree := arch/$(SRCARCH)/boot/dts
+endif
+
+ifneq ($(dtstree),)
+
+%.dtb: prepare3 scripts_dtc
+	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
+
+PHONY += dtbs dtbs_install
+dtbs: prepare3 scripts_dtc
+	$(Q)$(MAKE) $(build)=$(dtstree)
+
+dtbs_install:
+	$(Q)$(MAKE) $(dtbinst)=$(dtstree)
+
+ifdef CONFIG_OF_EARLY_FLATTREE
+all: dtbs
+endif
+
+endif
+
+PHONY += scripts_dtc
+scripts_dtc: scripts_basic
+	$(Q)$(MAKE) $(build)=scripts/dtc
+
 # ---------------------------------------------------------------------------
 # Modules

@@ -1414,6 +1443,12 @@ help:
 	@echo  '  kselftest-merge - Merge all the config dependencies of kselftest to existing'
 	@echo  '                    .config.'
 	@echo  ''
+	@$(if $(dtstree), \
+		echo 'Devicetree:'; \
+		echo '* dtbs            - Build device tree blobs for enabled boards'; \
+		echo '  dtbs_install    - Install dtbs to $(INSTALL_DTBS_PATH)'; \
+		echo '')
+
 	@echo 'Userspace tools targets:'
 	@echo '  use "make tools/help"'
 	@echo '  or  "cd tools; make help"'
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 99cce77ab98f..caece8866080 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -124,11 +124,5 @@ boot_targets += uImage uImage.bin uImage.gz
 $(boot_targets): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@

-%.dtb %.dtb.S %.dtb.o: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
-
-dtbs: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts
-
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d1516f85f25d..161c2df6567e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -307,12 +307,7 @@ else
 KBUILD_IMAGE := $(boot)/zImage
 endif

-# Build the DT binary blobs if we have OF configured
-ifeq ($(CONFIG_USE_OF),y)
-KBUILD_DTBS := dtbs
-endif
-
-all:	$(notdir $(KBUILD_IMAGE)) $(KBUILD_DTBS)
+all:	$(notdir $(KBUILD_IMAGE))


 archheaders:
@@ -339,17 +334,6 @@ $(BOOT_TARGETS): vmlinux
 $(INSTALL_TARGETS):
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@

-%.dtb: | scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
-
-PHONY += dtbs dtbs_install
-
-dtbs: prepare scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts
-
-dtbs_install:
-	$(Q)$(MAKE) $(dtbinst)=$(boot)/dts
-
 PHONY += vdso_install
 vdso_install:
 ifeq ($(CONFIG_VDSO),y)
@@ -371,8 +355,6 @@ define archhelp
   echo  '  uImage        - U-Boot wrapped zImage'
   echo  '  bootpImage    - Combined zImage and initial RAM disk'
   echo  '                  (supply initrd image via make variable INITRD=<path>)'
-  echo  '* dtbs          - Build device tree blobs for enabled boards'
-  echo  '  dtbs_install  - Install dtbs to $(INSTALL_DTBS_PATH)'
   echo  '  install       - Install uncompressed kernel'
   echo  '  zinstall      - Install compressed kernel'
   echo  '  uinstall      - Install U-Boot wrapped compressed kernel'
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 106039d25e2f..b4e994cd3a42 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -113,9 +113,8 @@ core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 KBUILD_IMAGE	:= $(boot)/Image.gz
-KBUILD_DTBS	:= dtbs

-all:	Image.gz $(KBUILD_DTBS)
+all:	Image.gz


 Image: vmlinux
@@ -127,17 +126,6 @@ Image.%: Image
 zinstall install:
 	$(Q)$(MAKE) $(build)=$(boot) $@

-%.dtb: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
-
-PHONY += dtbs dtbs_install
-
-dtbs: prepare scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts
-
-dtbs_install:
-	$(Q)$(MAKE) $(dtbinst)=$(boot)/dts
-
 PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso $@
@@ -145,7 +133,6 @@ vdso_install:
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
-	$(Q)$(MAKE) $(clean)=$(boot)/dts

 # We need to generate vdso-offsets.h before compiling certain files in kernel/.
 # In order to do that, we should use the archprepare target, but we can't since
@@ -160,8 +147,6 @@ vdso_prepare: prepare0
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
-  echo  '* dtbs          - Build device tree blobs for enabled boards'
-  echo  '  dtbs_install  - Install dtbs to $(INSTALL_DTBS_PATH)'
   echo  '  install       - Install uncompressed kernel'
   echo  '  zinstall      - Install compressed kernel'
   echo  '                  Install using (your) ~/bin/installkernel or'
diff --git a/arch/c6x/Makefile b/arch/c6x/Makefile
index 3fe8a948e94c..b7aa854f7008 100644
--- a/arch/c6x/Makefile
+++ b/arch/c6x/Makefile
@@ -40,9 +40,7 @@ boot := arch/$(ARCH)/boot
 DTB:=$(subst dtbImage.,,$(filter dtbImage.%, $(MAKECMDGOALS)))
 export DTB

-ifneq ($(DTB),)
 core-y	+= $(boot)/dts/
-endif

 # With make 3.82 we cannot mix normal and wildcard targets

diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
index 58634e6bae92..4003ddc616e1 100644
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -31,21 +31,12 @@ CROSS_COMPILE := h8300-unknown-linux-
 endif

 core-y	+= arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/
-ifneq '$(CONFIG_H8300_BUILTIN_DTB)' '""'
-core-y += arch/h8300/boot/dts/
-endif
+core-y	+= arch/$(ARCH)/boot/dts/

 libs-y	+= arch/$(ARCH)/lib/

 boot := arch/h8300/boot

-%.dtb %.dtb.S %.dtb.o: | scripts
-	$(Q)$(MAKE) $(build)=arch/h8300/boot/dts arch/h8300/boot/dts/$@
-
-PHONY += dtbs
-dtbs: scripts
-	$(Q)$(MAKE) $(build)=arch/h8300/boot/dts
-
 archmrproper:

 archclean:
diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 4f3ab5707265..0823d291fbeb 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -65,9 +65,7 @@ boot := arch/microblaze/boot
 # Are we making a simpleImage.<boardname> target? If so, crack out the boardname
 DTB:=$(subst simpleImage.,,$(filter simpleImage.%, $(MAKECMDGOALS)))

-ifneq ($(DTB),)
-	core-y	+= $(boot)/dts/
-endif
+core-y	+= $(boot)/dts/

 # defines filename extension depending memory management type
 ifeq ($(CONFIG_MMU),)
diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
index 1f77913d404d..fe9af267f598 100644
--- a/arch/microblaze/boot/dts/Makefile
+++ b/arch/microblaze/boot/dts/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #

+ifneq ($(DTB),)
 obj-y += linked_dtb.o

 # Ensure system.dtb exists
@@ -11,6 +12,7 @@ ifneq ($(DTB),system)
 $(obj)/system.dtb: $(obj)/$(DTB).dtb
 	$(call if_changed,cp)
 endif
+endif

 quiet_cmd_cp = CP      $< $@$2
 	cmd_cp = cat $< >$@$2 || (rm -f $@ && echo false)
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d74b3742fa5d..d43eeaa6d75b 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -407,18 +407,7 @@ endif
 CLEAN_FILES += vmlinux.32 vmlinux.64

 # device-trees
-core-$(CONFIG_BUILTIN_DTB) += arch/mips/boot/dts/
-
-%.dtb %.dtb.S %.dtb.o: | scripts
-	$(Q)$(MAKE) $(build)=arch/mips/boot/dts arch/mips/boot/dts/$@
-
-PHONY += dtbs
-dtbs: scripts
-	$(Q)$(MAKE) $(build)=arch/mips/boot/dts
-
-PHONY += dtbs_install
-dtbs_install:
-	$(Q)$(MAKE) $(dtbinst)=arch/mips/boot/dts
+core-y += arch/mips/boot/dts/

 archprepare:
 ifdef CONFIG_MIPS32_N32
@@ -461,8 +450,6 @@ define archhelp
 	echo '  uImage.lzma          - U-Boot image (lzma)'
 	echo '  uImage.lzo           - U-Boot image (lzo)'
 	echo '  uzImage.bin          - U-Boot image (self-extracting)'
-	echo '  dtbs                 - Device-tree blobs for enabled boards'
-	echo '  dtbs_install         - Install dtbs to $(INSTALL_DTBS_PATH)'
 	echo
 	echo '  These will be default as appropriate for a configured platform.'
 	echo
diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index 3509fac10491..9f525ed70049 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -47,7 +47,7 @@ CHECKFLAGS      += -D__NDS32_EB__
 endif

 boot := arch/nds32/boot
-core-$(BUILTIN_DTB) += $(boot)/dts/
+core-y += $(boot)/dts/

 .PHONY: FORCE

diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
index db2e78fe65c7..52c03e60b114 100644
--- a/arch/nios2/Makefile
+++ b/arch/nios2/Makefile
@@ -56,12 +56,6 @@ all: vmImage
 archclean:
 	$(Q)$(MAKE) $(clean)=$(nios2-boot)

-%.dtb %.dtb.S %.dtb.o: | scripts
-	$(Q)$(MAKE) $(build)=$(nios2-boot)/dts $(nios2-boot)/dts/$@
-
-dtbs:
-	$(Q)$(MAKE) $(build)=$(nios2-boot)/dts
-
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@

@@ -74,5 +68,4 @@ define archhelp
   echo  '                     (your) ~/bin/$(INSTALLKERNEL) or'
   echo  '                     (distribution) /sbin/$(INSTALLKERNEL) or'
   echo  '                     install to $$(INSTALL_PATH)'
-  echo  '  dtbs            - Build device tree blobs for enabled boards'
 endef
diff --git a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile
index 0b48f1bf086d..37dfc7e584bc 100644
--- a/arch/nios2/boot/Makefile
+++ b/arch/nios2/boot/Makefile
@@ -31,9 +31,5 @@ $(obj)/zImage: $(obj)/compressed/vmlinux FORCE
 $(obj)/compressed/vmlinux: $(obj)/vmlinux.gz FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@

-targets += $(dtb-y)
-
-$(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
-
 install:
 	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 53ea887eb34e..42f225f6ec93 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -293,9 +293,6 @@ $(BOOT_TARGETS2): vmlinux
 bootwrapper_install:
 	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)

-%.dtb: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts $(patsubst %,$(boot)/dts/%,$@)
-
 # Used to create 'merged defconfigs'
 # To use it $(call) it with the first argument as the base defconfig
 # and the second argument as a space separated list of .config files to merge,
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index d67e30faff9c..be060dfb1cc3 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -80,28 +80,18 @@ LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 head-y		:= arch/xtensa/kernel/head.o
 core-y		+= arch/xtensa/kernel/ arch/xtensa/mm/
 core-y		+= $(buildvar) $(buildplf)
+core-y 		+= arch/xtensa/boot/dts/

 libs-y		+= arch/xtensa/lib/ $(LIBGCC)
 drivers-$(CONFIG_OPROFILE)	+= arch/xtensa/oprofile/

-ifneq ($(CONFIG_BUILTIN_DTB),"")
-core-$(CONFIG_OF) += arch/xtensa/boot/dts/
-endif
-
 boot		:= arch/xtensa/boot

 all Image zImage uImage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $@

-%.dtb:
-	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
-
-dtbs: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts
-
 define archhelp
   @echo '* Image       - Kernel ELF image with reset vector'
   @echo '* zImage      - Compressed kernel image (arch/xtensa/boot/images/zImage.*)'
   @echo '* uImage      - U-Boot wrapped image'
-  @echo '  dtbs        - Build device tree blobs for enabled boards'
 endef
diff --git a/scripts/Makefile b/scripts/Makefile
index 61affa300d25..ece52ff20171 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -39,8 +39,7 @@ build_unifdef: $(obj)/unifdef
 subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-y                     += mod
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
-subdir-$(CONFIG_DTC)         += dtc
 subdir-$(CONFIG_GDB_SCRIPTS) += gdb

 # Let clean descend into subdirs
-subdir-	+= basic kconfig package gcc-plugins
+subdir-	+= basic dtc kconfig package gcc-plugins
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 61e596650ed3..8fe4468f9bda 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -283,7 +283,7 @@ $(obj)/%.dtb.S: $(obj)/%.dtb FORCE

 quiet_cmd_dtc = DTC     $@
 cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
-	$(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
+	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
 	$(DTC) -O dtb -o $@ -b 0 \
 		$(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 1c943e03eaf2..e535b457babb 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # scripts/dtc makefile

-hostprogs-y	:= dtc
+hostprogs-$(CONFIG_DTC) := dtc
 always		:= $(hostprogs-y)

 dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
--
2.17.1
