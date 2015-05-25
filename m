Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 180A81A0E3A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 08:53:48 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 behanw@converseincode.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/6] llvm: A few Makefile hacks
Date: Tue, 26 May 2015 08:53:30 +1000
Message-Id: <1432594410-31198-7-git-send-email-anton@samba.org>
In-Reply-To: <1432594410-31198-1-git-send-email-anton@samba.org>
References: <1432594410-31198-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

llvm accepts -fno-delete-null-pointer-checks but complains about it.
Wrap it to avoid getting enormous numbers of warnings.

Also add -no-integrated-as to disable the llvm integrated assembler,
lots of stuff currently relies on gas.
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index eae539d..451290f 100644
--- a/Makefile
+++ b/Makefile
@@ -609,7 +609,12 @@ all: vmlinux
 
 include arch/$(SRCARCH)/Makefile
 
+ifneq ($(COMPILER),clang)
 KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
+endif
+
+KBUILD_CFLAGS  += $(call cc-option,-no-integrated-as,)
+KBUILD_AFLAGS  += $(call cc-option,-no-integrated-as,)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= -Os $(call cc-disable-warning,maybe-uninitialized,)
-- 
2.1.4
