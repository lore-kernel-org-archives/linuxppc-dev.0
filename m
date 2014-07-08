Return-Path: <xerofoify@gmail.com>
Received: from mail-ig0-x22f.google.com (mail-ig0-x22f.google.com
 [IPv6:2607:f8b0:4001:c05::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD8E51A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 15:04:19 +1000 (EST)
Received: by mail-ig0-f175.google.com with SMTP id h3so271897igd.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jul 2014 22:04:17 -0700 (PDT)
From: Nicholas Krause <xerofoify@gmail.com>
To: benh@kernel.crashing.org
Subject: powerpc allyesconfig fix 
Date: Tue,  8 Jul 2014 01:04:09 -0400
Message-Id: <1404795849-25609-1-git-send-email-xerofoify@gmail.com>
Cc: mahesh@linux.vnet.ibm.com, agraf@suse.de, linux-kernel@vger.kernel.org,
 michael@ellerman.id.au, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc:allmodconfig has been failing for some time with the following
error.

arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:1312: Error: attempt to move .org backwards
make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1

A number of attempts to fix the problem by moving around code have been
unsuccessful and resulted in failed builds for some configurations and
the discovery of toolchain bugs.

Fix the problem by disabling RELOCATABLE for COMPILE_TEST builds instead.
While this is less than perfect, it avoids substantial code changes
which would otherwise be necessary just to make COMPILE_TEST builds
happy and might have undesired side effects.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/powerpc/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index bd6dd6e..fefe7c8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -414,7 +414,7 @@ config KEXEC
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
 	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
-	select RELOCATABLE if PPC64 || 44x || FSL_BOOKE
+	select RELOCATABLE if (PPC64 && !COMPILE_TEST) || 44x || FSL_BOOKE
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The same kernel binary can be used as production kernel and dump
@@ -1017,6 +1017,7 @@ endmenu
 if PPC64
 config RELOCATABLE
 	bool "Build a relocatable kernel"
+	depends on !COMPILE_TEST
 	select NONSTATIC_KERNEL
 	help
 	  This builds a kernel image that is capable of running anywhere
-- 
1.9.1
