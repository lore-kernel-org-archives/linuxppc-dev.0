Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 501C9B6FA5
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jun 2011 02:26:00 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p52GPucX023448
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Jun 2011 11:25:57 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl_rio: Fix compile error when CONFIG_FSL_RIO not set
Date: Thu,  2 Jun 2011 11:25:56 -0500
Message-Id: <1307031956-11686-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/kernel/built-in.o: In function `machine_check_e500mc':
arch/powerpc/kernel/traps.c:429: undefined reference to `fsl_rio_mcheck_exception'
arch/powerpc/kernel/built-in.o: In function `machine_check_e500': arch/powerpc/kernel/traps.c:519:
undefined reference to `fsl_rio_mcheck_exception'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/rio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/rio.h b/arch/powerpc/include/asm/rio.h
index d902abd..b1d2dec 100644
--- a/arch/powerpc/include/asm/rio.h
+++ b/arch/powerpc/include/asm/rio.h
@@ -14,7 +14,7 @@
 #define ASM_PPC_RIO_H
 
 extern void platform_rio_init(void);
-#ifdef CONFIG_RAPIDIO
+#ifdef CONFIG_FSL_RIO
 extern int fsl_rio_mcheck_exception(struct pt_regs *);
 #else
 static inline int fsl_rio_mcheck_exception(struct pt_regs *regs) {return 0; }
-- 
1.7.3.4
