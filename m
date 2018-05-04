Return-Path: <raj.khem@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40d23z5CgYzDr4K
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 05:23:24 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id g20-v6so9379260pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 12:23:24 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Khem Raj <raj.khem@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc: Disable attribute-alias warnings from gcc8
Date: Fri,  4 May 2018 12:23:12 -0700
Message-Id: <20180504192313.18625-1-raj.khem@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes
alias between functions of incompatible types warnings
which are new with gcc8

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2b4c40b255e4..7ac5a68ad6b1 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the linux kernel.
 #
 
-CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
+CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"' $(call cc-disable-warning, attribute-alias)
+CFLAGS_syscalls.o	+= $(call cc-disable-warning, attribute-alias)
 
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
-- 
2.17.0
