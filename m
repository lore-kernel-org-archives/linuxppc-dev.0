Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 254371A0065
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 15:43:45 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 yizhouzhou@ict.ac.cn
Subject: [PATCH] powerpc/jump_label: Use HAVE_JUMP_LABEL
Date: Thu, 30 Oct 2014 15:43:43 +1100
Message-Id: <1414644223-19491-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit d4fe0965e208 ("powerpc/jump_label: use HAVE_JUMP_LABEL?")
missed a few conversions. Change the remaining uses of
CONFIG_JUMP_LABEL to HAVE_JUMP_LABEL.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/powernv/opal-wrappers.S | 2 +-
 arch/powerpc/platforms/pseries/hvCall.S        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index feb549a..cf7266d 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -18,7 +18,7 @@
 	.section	".text"
 
 #ifdef CONFIG_TRACEPOINTS
-#ifdef CONFIG_JUMP_LABEL
+#ifdef HAVE_JUMP_LABEL
 #define OPAL_BRANCH(LABEL)					\
 	ARCH_STATIC_BRANCH(LABEL, opal_tracepoint_key)
 #else
diff --git a/arch/powerpc/platforms/pseries/hvCall.S b/arch/powerpc/platforms/pseries/hvCall.S
index 3fda3f1..ccd53f9 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -18,7 +18,7 @@
 	
 #ifdef CONFIG_TRACEPOINTS
 
-#ifndef CONFIG_JUMP_LABEL
+#ifndef HAVE_JUMP_LABEL
 	.section	".toc","aw"
 
 	.globl hcall_tracepoint_refcount
@@ -78,7 +78,7 @@ hcall_tracepoint_refcount:
 	mr	r5,BUFREG;					\
 	__HCALL_INST_POSTCALL
 
-#ifdef CONFIG_JUMP_LABEL
+#ifdef HAVE_JUMP_LABEL
 #define HCALL_BRANCH(LABEL)					\
 	ARCH_STATIC_BRANCH(LABEL, hcall_tracepoint_key)
 #else
-- 
1.9.1
