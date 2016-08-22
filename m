Return-Path: <david.engraf@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [176.9.12.79])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHxV62SzZzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 00:56:30 +1000 (AEST)
From: David Engraf <david.engraf@sysgo.com>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Engraf <david.engraf@sysgo.com>
Subject: [PATCH] powerpc64: Enable CONFIG_E500 and CONFIG_PPC_E500MC for
 e5500/e6500
Date: Mon, 22 Aug 2016 16:46:43 +0200
Message-Id: <1471877203-29327-1-git-send-email-david.engraf@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PowerPC e5500/e6500 architecture is based on the e500mc core. Enable
CONFIG_E500 and CONFIG_PPC_E500MC when e5500/e6500 is used.

This will also fix using CONFIG_PPC_QEMU_E500 on PPC64.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 arch/powerpc/platforms/Kconfig.cputype | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f32edec..0382da7 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -125,11 +125,13 @@ config POWER8_CPU
 
 config E5500_CPU
 	bool "Freescale e5500"
-	depends on E500
+	select E500
+	select PPC_E500MC
 
 config E6500_CPU
 	bool "Freescale e6500"
-	depends on E500
+	select E500
+	select PPC_E500MC
 
 endchoice
 
-- 
1.9.1
