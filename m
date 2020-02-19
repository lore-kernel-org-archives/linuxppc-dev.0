Return-Path: <SRS0=ebxO=4H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0BCC34031
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Feb 2020 00:06:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F36524655
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Feb 2020 00:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="rqIYKgRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F36524655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MdL90BNFzDqkD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Feb 2020 11:06:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MdJ56Yv7zDq6M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2020 11:04:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=rqIYKgRk; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 48MdJ55KRTz9sRh; Wed, 19 Feb 2020 11:04:37 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48MdJ54Bddz9sRk; Wed, 19 Feb 2020 11:04:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1582070677;
 bh=Mv6GHAx7R7ozUWxEOVr4jhO7uG4SlhIDpVyQSxenvS4=;
 h=From:To:Cc:Subject:Date:From;
 b=rqIYKgRkqs1dPsPwa1dIRESd0qm4SIM73lWKrAhvv3LP2E92GXuXAQv07EjqXFQvd
 RuMOd1KNA+0InEXuLKlvII+4tbW5u+L1C1FFSbbGjc6tTB7/wTONtbrsBydKZKWnA6
 ky5EBcBsl8tCTeHSee6xsCtzxOVZ8xO+KZDj2Oi2MY5TXUOhDiRT2LO1gInTSVLzJt
 KpIjjGmE/VsIBl1/g4iml1AOkelgPpohKFH5cYhUHzUpoPA5zaSnOEZd11mrfAwoaD
 ennMqqSWY8k8vEu0qMv7SQJBstG8Ny8NHTnEWcCHBmbsz8GgfSM2pfDtW7EgObX8jH
 7rdk2+mVpvJRg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/Makefile: Mark phony targets as PHONY
Date: Wed, 19 Feb 2020 11:04:34 +1100
Message-Id: <20200219000434.15872-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: masahiroy@kernel.org, linux-kbuild@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Some of our phony targets are not marked as such. This can lead to
confusing errors, eg:

  $ make clean
  $ touch install
  $ make install
  make: 'install' is up to date.
  $

Fix it by adding them to the PHONY variable which is marked phony in
the top-level Makefile, or in scripts/Makefile.build for the boot
Makefile.

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile      | 6 ++++++
 arch/powerpc/boot/Makefile | 2 ++
 2 files changed, 8 insertions(+)

v2: Use PHONY variable in boot/Makefile as well.

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index f35730548e42..cbe5ca4f0ee5 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -298,6 +298,7 @@ $(BOOT_TARGETS2): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
 
+PHONY += bootwrapper_install
 bootwrapper_install:
 	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
@@ -403,9 +404,11 @@ define archhelp
   @echo '  (minus the .dts extension).'
 endef
 
+PHONY += install
 install:
 	$(Q)$(MAKE) $(build)=$(boot) install
 
+PHONY += vdso_install
 vdso_install:
 ifdef CONFIG_PPC64
 	$(Q)$(MAKE) $(build)=arch/$(ARCH)/kernel/vdso64 $@
@@ -425,6 +428,7 @@ archprepare: checkbin
 ifdef CONFIG_STACKPROTECTOR
 prepare: stack_protector_prepare
 
+PHONY += stack_protector_prepare
 stack_protector_prepare: prepare0
 ifdef CONFIG_PPC64
 	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "PACA_CANARY") print $$3;}' include/generated/asm-offsets.h))
@@ -436,10 +440,12 @@ endif
 ifdef CONFIG_SMP
 prepare: task_cpu_prepare
 
+PHONY += task_cpu_prepare
 task_cpu_prepare: prepare0
 	$(eval KBUILD_CFLAGS += -D_TASK_CPU=$(shell awk '{if ($$2 == "TASK_CPU") print $$3;}' include/generated/asm-offsets.h))
 endif
 
+PHONY += checkbin
 # Check toolchain versions:
 # - gcc-4.6 is the minimum kernel-wide version so nothing required.
 checkbin:
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 0556bf4fc9e9..c53a1b8bba8b 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -445,6 +445,8 @@ install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 zInstall: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $^
 
+PHONY += install zInstall
+
 # anything not in $(targets)
 clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
 	zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
-- 
2.21.1

