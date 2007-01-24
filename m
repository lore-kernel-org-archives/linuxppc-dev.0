Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 52B6ADDFDD
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:08 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0OL76Zk028713
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:07:06 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l0OL75Bh007316
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:05 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKnShm008103
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:28 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 805354B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:04 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL74FE010558
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:07:04 -0600
Date: Wed, 24 Jan 2007 15:07:04 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/18] Set -msoft-float and assembler target options in the
	bootwrapper.
Message-ID: <20070124210704.GC10527@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Without -msoft-float, floating point state saving code can be executed
(at least with certain buggy versions of GCC, which don't clear bit 6 of
CR before calling a varargs function with no varargs parameters).

Without the assembler target option, the assembler will use the old
dedicated mftb/mftbu instructions, rather than mfspr.  This causes the
boot to hang on e500, which doesn't have the dedicated instructions.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Makefile      |    1 +
 arch/powerpc/boot/Makefile |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a00fe72..2309cdf 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -118,6 +118,7 @@ cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
 AFLAGS += $(cpu-as-y)
 CFLAGS += $(cpu-as-y)
+export cpu-as-y
 
 head-y				:= arch/powerpc/kernel/head_32.o
 head-$(CONFIG_PPC64)		:= arch/powerpc/kernel/head_64.o
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 906b166..e95c1b0 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -24,7 +24,8 @@ all: $(obj)/zImage
 
 HOSTCC		:= gcc
 BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -nostdinc -isystem \
-		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC
+		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC \
+		   $(cpu-as-y) -msoft-float
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
 ifeq ($(call cc-option-yn, -fstack-protector),y)
-- 
1.4.4
