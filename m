Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84D38B6F18
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Apr 2011 21:07:13 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p3CB78ul023456
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Apr 2011 06:07:09 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: disable Suspend support if SMP enabled
Date: Tue, 12 Apr 2011 06:07:08 -0500
Message-Id: <1302606428-20227-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We currently dont have CPU Hotplug support working on 85xx so we need to
disable Suspsend support as it will force enabling of CPU Hotplug.

arch/powerpc/kernel/built-in.o: In function `cpu_die': arch/powerpc/kernel/smp.c:702: undefined reference to `start_secondary_resume'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b6ff882..8f4d50b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -209,7 +209,7 @@ config ARCH_HIBERNATION_POSSIBLE
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
-		   PPC_85xx || PPC_86xx || PPC_PSERIES || 44x || 40x
+		   (PPC_85xx && !SMP) || PPC_86xx || PPC_PSERIES || 44x || 40x
 
 config PPC_DCR_NATIVE
 	bool
-- 
1.7.3.4
