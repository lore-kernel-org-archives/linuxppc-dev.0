Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0QpB4swRzDvYB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 11:01:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: segher@kernel.crashing.org,
	anton@samba.org
Subject: [PATCH] powerpc/book3s64: Always build for power4 or later
Date: Fri, 21 Oct 2016 11:01:51 +1100
Message-Id: <1477008111-9160-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we're not compiling for a specific CPU, ie. none of the
CONFIG_POWERx_CPU options are set, and CONFIG_GENERIC_CPU *is* set, we
currently don't pass any -mcpu option to the compiler. This means the
compiler builds for a "generic" Power CPU.

But back in 2014 we dropped support for pre power4 CPUs in commit
468a33028edd ("powerpc: Drop support for pre-POWER4 cpus").

Given that, there's no point in building the kernel to run on pre power4
cpus. So update the flags we pass to the compiler when
CONFIG_GENERIC_CPU is set, to specify -mcpu=power4.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 617dece67924..041fda1e2a5d 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -121,6 +121,7 @@ CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
 
 ifeq ($(CONFIG_PPC_BOOK3S_64),y)
 CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power7,-mtune=power4)
+CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=power4
 else
 CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
 endif
-- 
2.7.4
