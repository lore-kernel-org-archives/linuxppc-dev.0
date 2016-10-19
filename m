Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szHCk13TgzDt1h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 14:16:34 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id r16so1084980pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 20:16:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 6/7] powerpc: switch to using thin archives if COMPILE_TEST is
 set
Date: Wed, 19 Oct 2016 14:15:59 +1100
Message-Id: <20161019031600.17933-7-npiggin@gmail.com>
In-Reply-To: <20161019031600.17933-1-npiggin@gmail.com>
References: <20161019031600.17933-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable thin archives build for powerpc when COMPILE_TEST is set.
Thin archives are explained in this commit:

  a5967db9af51a84f5e181600954714a9e4c69f1f

This is a gradual way to introduce the option to testers.

Some change to the way we invoke ar is required so it can be used
by scripts/link-vmlinux.sh.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig  | 1 +
 arch/powerpc/Makefile | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 65fba4c..00d9e31 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -80,6 +80,7 @@ config ARCH_HAS_DMA_SET_COHERENT_MASK
 config PPC
 	bool
 	default y
+	select THIN_ARCHIVES if COMPILE_TEST
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select BINFMT_ELF
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 0fcb47c..fe76cfe 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -23,7 +23,7 @@ CROSS32AR		:= $(CROSS32_COMPILE)ar
 ifeq ($(HAS_BIARCH),y)
 ifeq ($(CROSS32_COMPILE),)
 CROSS32CC	:= $(CC) -m32
-CROSS32AR	:= GNUTARGET=elf32-powerpc $(AR)
+KBUILD_ARFLAGS	+= --target=elf32-powerpc
 endif
 endif
 
@@ -85,7 +85,7 @@ ifeq ($(HAS_BIARCH),y)
 override AS	+= -a$(BITS)
 override LD	+= -m elf$(BITS)$(LDEMULATION)
 override CC	+= -m$(BITS)
-override AR	:= GNUTARGET=elf$(BITS)-$(GNUTARGET) $(AR)
+KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
 endif
 
 LDFLAGS_vmlinux-y := -Bstatic
-- 
2.9.3
