Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53CAFDDDAE
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 16:10:02 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1C59uMU014069
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 23:09:57 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix warnings from make headers_check
Date: Wed, 11 Feb 2009 23:09:56 -0600
Message-Id: <1234415396-29409-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

include/asm/bootx.h:12: include of <linux/types.h> is preferred over <asm/types.h>
include/asm/bootx.h:57: found __[us]{8,16,32,64} type without #include <linux/types.h>
include/asm/elf.h:5: include of <linux/types.h> is preferred over <asm/types.h>
include/asm/kvm.h:23: include of <linux/types.h> is preferred over <asm/types.h>
include/asm/kvm.h:26: found __[us]{8,16,32,64} type without #include <linux/types.h>
include/asm/ps3fb.h:33: found __[us]{8,16,32,64} type without #include <linux/types.h>
include/asm/spu_info.h:27: found __[us]{8,16,32,64} type without #include <linux/types.h>
include/asm/swab.h:11: include of <linux/types.h> is preferred over <asm/types.h>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/bootx.h    |    2 +-
 arch/powerpc/include/asm/elf.h      |    3 ++-
 arch/powerpc/include/asm/kvm.h      |    2 +-
 arch/powerpc/include/asm/ps3fb.h    |    1 +
 arch/powerpc/include/asm/spu_info.h |    3 ++-
 arch/powerpc/include/asm/swab.h     |    2 +-
 6 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/bootx.h b/arch/powerpc/include/asm/bootx.h
index 57b82e3..60a3c9e 100644
--- a/arch/powerpc/include/asm/bootx.h
+++ b/arch/powerpc/include/asm/bootx.h
@@ -9,7 +9,7 @@
 #ifndef __ASM_BOOTX_H__
 #define __ASM_BOOTX_H__
 
-#include <asm/types.h>
+#include <linux/types.h>
 
 #ifdef macintosh
 #include <Types.h>
diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index cd46f02..c125da7 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -7,7 +7,8 @@
 #include <asm/string.h>
 #endif
 
-#include <asm/types.h>
+#include <linux/types.h>
+
 #include <asm/ptrace.h>
 #include <asm/cputable.h>
 #include <asm/auxvec.h>
diff --git a/arch/powerpc/include/asm/kvm.h b/arch/powerpc/include/asm/kvm.h
index f993e41..4e0cf65 100644
--- a/arch/powerpc/include/asm/kvm.h
+++ b/arch/powerpc/include/asm/kvm.h
@@ -20,7 +20,7 @@
 #ifndef __LINUX_KVM_POWERPC_H
 #define __LINUX_KVM_POWERPC_H
 
-#include <asm/types.h>
+#include <linux/types.h>
 
 struct kvm_regs {
 	__u64 pc;
diff --git a/arch/powerpc/include/asm/ps3fb.h b/arch/powerpc/include/asm/ps3fb.h
index 3f121fe..1a91daf 100644
--- a/arch/powerpc/include/asm/ps3fb.h
+++ b/arch/powerpc/include/asm/ps3fb.h
@@ -20,6 +20,7 @@
 #define _ASM_POWERPC_PS3FB_H_
 
 #include <linux/ioctl.h>
+#include <linux/types.h>
 
 /* ioctl */
 #define PS3FB_IOCTL_SETMODE       _IOW('r',  1, int) /* set video mode */
diff --git a/arch/powerpc/include/asm/spu_info.h b/arch/powerpc/include/asm/spu_info.h
index 3545efb..1286c82 100644
--- a/arch/powerpc/include/asm/spu_info.h
+++ b/arch/powerpc/include/asm/spu_info.h
@@ -23,9 +23,10 @@
 #ifndef _SPU_INFO_H
 #define _SPU_INFO_H
 
+#include <linux/types.h>
+
 #ifdef __KERNEL__
 #include <asm/spu.h>
-#include <linux/types.h>
 #else
 struct mfc_cq_sr {
 	__u64 mfc_cq_data0_RW;
diff --git a/arch/powerpc/include/asm/swab.h b/arch/powerpc/include/asm/swab.h
index ef824ae..c581e3e 100644
--- a/arch/powerpc/include/asm/swab.h
+++ b/arch/powerpc/include/asm/swab.h
@@ -8,7 +8,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <asm/types.h>
+#include <linux/types.h>
 #include <linux/compiler.h>
 
 #ifdef __GNUC__
-- 
1.5.6.6
