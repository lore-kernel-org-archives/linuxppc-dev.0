Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B0008B7148
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 22:12:28 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <6631719f88ad0e9231d95656e9d34306637a93fc.1244722339.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Only build prom_init.o when
	CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
Date: Thu, 11 Jun 2009 22:12:28 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 28794d34 ("powerpc/kconfig: Kill PPC_MULTIPLATFORM"), added
CONFIG_PPC_OF_BOOT_TRAMPOLINE to control the buliding of prom_init.o

However the Makefile still unconditionally builds prom_init_check,
the script that checks prom_init.o for symbol usage, and so in turn
prom_init.o is still always being built. (it's not linked though)

So surround all the prom_init_check logic with an ifeq block testing
if CONFIG_PPC_OF_BOOT_TRAMPOLINE is set.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 110ec6d..655b724 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -124,6 +124,7 @@ PHONY += systbl_chk
 systbl_chk: $(src)/systbl_chk.sh $(obj)/systbl_chk.i
 	$(call cmd,systbl_chk)
 
+ifeq ($(CONFIG_PPC_OF_BOOT_TRAMPOLINE),y)
 $(obj)/built-in.o:		prom_init_check
 
 quiet_cmd_prom_init_check = CALL    $<
@@ -132,5 +133,6 @@ quiet_cmd_prom_init_check = CALL    $<
 PHONY += prom_init_check
 prom_init_check: $(src)/prom_init_check.sh $(obj)/prom_init.o
 	$(call cmd,prom_init_check)
+endif
 
 clean-files := vmlinux.lds
-- 
1.6.2.1
