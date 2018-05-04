Return-Path: <raj.khem@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40d23z5MqPzDr4X
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 05:23:24 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id j20so3852439pff.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 12:23:24 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Khem Raj <raj.khem@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/ptrace: Disable array-bounds warning with gcc8
Date: Fri,  4 May 2018 12:23:13 -0700
Message-Id: <20180504192313.18625-2-raj.khem@gmail.com>
In-Reply-To: <20180504192313.18625-1-raj.khem@gmail.com>
References: <20180504192313.18625-1-raj.khem@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This masks the new gcc8 warning

regset.h:270:4: error: 'memcpy' offset [-527, -529] is out
of the bounds [0, 16] of object 'vrsave' with type 'union <anonymous>'

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 7ac5a68ad6b1..ab159a34704a 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -4,6 +4,7 @@
 #
 
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"' $(call cc-disable-warning, attribute-alias)
+CFLAGS_ptrace.o		+= $(call cc-disable-warning, array-bounds)
 CFLAGS_syscalls.o	+= $(call cc-disable-warning, attribute-alias)
 
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
-- 
2.17.0
