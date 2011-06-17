Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A14E5B6F6E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 11:59:52 +1000 (EST)
Subject: [PATCH 3/5] powerpc/udbg: Register udbg console generically
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Jun 2011 11:08:37 +1000
Message-ID: <1308272917.2516.107.camel@pasglop>
Mime-Version: 1.0
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_PPC_EARLY_DEBUG is set, call register_early_udbg_console()
early from generic code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/udbg.c            |    2 ++
 arch/powerpc/platforms/pseries/lpar.c |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 23d65ab..a57e61e 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -68,6 +68,8 @@ void __init udbg_early_init(void)
 
 #ifdef CONFIG_PPC_EARLY_DEBUG
 	console_loglevel = 10;
+
+	register_early_udbg_console();
 #endif
 }
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 39e6e0a..e3a96c4 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -193,8 +193,6 @@ void __init udbg_init_debug_lpar(void)
 	udbg_putc = udbg_putcLP;
 	udbg_getc = udbg_getcLP;
 	udbg_getc_poll = udbg_getc_pollLP;
-
-	register_early_udbg_console();
 }
 
 /* returns 0 if couldn't find or use /chosen/stdout as console */
