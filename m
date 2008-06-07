Return-Path: <segher@gcc17.fsffrance.org>
Received: from snail.fsffrance.org (eucd.info [88.191.250.43])
	by ozlabs.org (Postfix) with ESMTP id 958F5DDEE2
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jun 2008 10:30:21 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Get rid of CROSS32{AS,LD,OBJCOPY}
Date: Sun,  8 Jun 2008 01:42:52 +0200
Message-Id: <314854045ab90aab8170b8422e80d7639c60a916.1212882058.git.segher@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

CROSS32AS and CROSS32LD are never used (instead, CROSS32CC is used
with proper command line options).

CROSS32OBJCOPY isn't used anymore either, since the "wrapper" stuff
was added.

Remove these unused variables.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/Makefile |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index df59bbe..c7c1de9 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -18,22 +18,16 @@ HAS_BIARCH	:= $(call cc-option-yn, -m32)
 CROSS32_COMPILE ?=
 
 CROSS32CC		:= $(CROSS32_COMPILE)gcc
-CROSS32AS		:= $(CROSS32_COMPILE)as
-CROSS32LD		:= $(CROSS32_COMPILE)ld
 CROSS32AR		:= $(CROSS32_COMPILE)ar
-CROSS32OBJCOPY		:= $(CROSS32_COMPILE)objcopy
 
 ifeq ($(HAS_BIARCH),y)
 ifeq ($(CROSS32_COMPILE),)
 CROSS32CC	:= $(CC) -m32
-CROSS32AS	:= $(AS) -a32
-CROSS32LD	:= $(LD) -m elf32ppc
-CROSS32OBJCOPY	:= $(OBJCOPY)
 CROSS32AR	:= GNUTARGET=elf32-powerpc $(AR)
 endif
 endif
 
-export CROSS32CC CROSS32AS CROSS32LD CROSS32AR CROSS32OBJCOPY
+export CROSS32CC CROSS32AR
 
 ifeq ($(CROSS_COMPILE),)
 KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
-- 
1.5.5.1.g377d9.dirty
