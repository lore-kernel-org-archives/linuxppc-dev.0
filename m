Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 76379DDF71
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 04:52:11 +1000 (EST)
Date: Mon, 12 May 2008 22:52:10 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/3] [POWERPC] fsl_soc: register mpc83xx_wdt for PPC_86xx
Message-ID: <20080512185210.GB25818@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, Wim Van Sebroeck <wim@iguana.be>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since mpc83xx_wdt driver is able to handle MPC86xx watchdogs now,
we want to regster the device appropriately.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/fsl_soc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index a5ceeef..85861c9 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -545,7 +545,7 @@ err:
 arch_initcall(fsl_i2c_of_init);
 #endif
 
-#ifdef CONFIG_PPC_83xx
+#if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_86xx)
 static int __init mpc83xx_wdt_init(void)
 {
 	struct resource r;
-- 
1.5.5.1
