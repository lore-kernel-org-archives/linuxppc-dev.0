Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B9CCFDDEEF
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 22:30:35 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Specify GNUTARGET on $(AR) invocations
Date: Wed, 16 May 2007 14:34:38 +0200
Message-Id: <11793188781691-git-send-email-segher@kernel.crashing.org>
Message-Id: <82e1fe849c00c7110db923fb914ab1359b7a4dba.1179318242.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Without this, some versions of GNU ar fail to create
an archive index if the object files it is packing
together are of a different object format than ar's
default format (for example, binutils compiled to
default to 64-bit, with 32-bit objects).

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index d6014a6..6238b58 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -29,7 +29,7 @@ CROSS32CC	:= $(CC) -m32
 CROSS32AS	:= $(AS) -a32
 CROSS32LD	:= $(LD) -m elf32ppc
 CROSS32OBJCOPY	:= $(OBJCOPY)
-CROSS32AR	:= $(AR)
+CROSS32AR	:= GNUTARGET=elf32-powerpc $(AR)
 endif
 endif
 
@@ -58,6 +58,7 @@ ifeq ($(HAS_BIARCH),y)
 override AS	+= -a$(SZ)
 override LD	+= -m elf$(SZ)ppc
 override CC	+= -m$(SZ)
+override AR	:= GNUTARGET=elf$(SZ)-powerpc $(AR)
 endif
 
 LDFLAGS_vmlinux	:= -Bstatic
-- 
1.5.2.rc0.g4342-dirty
