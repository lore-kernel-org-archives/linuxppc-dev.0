Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A60B6DDE2B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 15:05:33 +1000 (EST)
Date: Tue, 8 May 2007 15:05:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: make HVC_ISERIES the default
Message-Id: <20070508150531.840b3bab.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes the new iSeries virtual console drivers (nvc_iseries) the
default and prevents viocons being built unless explicitly selected.
Also it makes no sense to have the console as a module.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/Kconfig |    4 +++-
 drivers/char/Kconfig                   |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
index 46c3a8e..761d9e9 100644
--- a/arch/powerpc/platforms/iseries/Kconfig
+++ b/arch/powerpc/platforms/iseries/Kconfig
@@ -7,7 +7,9 @@ menu "iSeries device drivers"
 	depends on PPC_ISERIES
 
 config VIOCONS
-	tristate "iSeries Virtual Console Support (Obsolete)"
+	bool "iSeries Virtual Console Support (Obsolete)"
+	depends on !HVC_ISERIES
+	default n
 	help
 	  This is the old virtual console driver for legacy iSeries.
 	  You should use the iSeries Hypervisor Virtual Console
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index a26d917..f888a79 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -631,7 +631,8 @@ config HVC_CONSOLE
 
 config HVC_ISERIES
 	bool "iSeries Hypervisor Virtual Console support"
-	depends on PPC_ISERIES && !VIOCONS
+	depends on PPC_ISERIES
+	default y
 	select HVC_DRIVER
 	help
 	  iSeries machines support a hypervisor virtual console.
-- 
1.5.1.3
