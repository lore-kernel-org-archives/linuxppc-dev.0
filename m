Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A632685B2
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 05:46:31 +1000 (EST)
Date: Sat, 22 Oct 2005 21:46:26 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051022194626.GA3496@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] dmasound_pmac depends on pmac specific config options
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


dmasound_pmac should depend on pmac specific .config options.
Since PMAC is always defined, but PMAC wont boot without either
CUDA or PMU, one of these options indicates that the kernel is
for a PowerMac.
CONFIG_PM can be selected unconditionally.

sound/oss/dmasound/dmasound_awacs.c:262: warning: `struct pmu_sleep_notifier' declared inside parameter list
sound/oss/dmasound/dmasound_awacs.c:262: warning: its scope is only this definition or declaration, which is probably not what you want
sound/oss/dmasound/dmasound_awacs.c:263: error: variable `awacs_sleep_notifier' has initializer but incomplete type
sound/oss/dmasound/dmasound_awacs.c:264: warning: excess elements in struct initializer
sound/oss/dmasound/dmasound_awacs.c:264: warning: (near initialization for `awacs_sleep_notifier')
sound/oss/dmasound/dmasound_awacs.c:264: error: `SLEEP_LEVEL_SOUND' undeclared here (not in a function)
sound/oss/dmasound/dmasound_awacs.c:264: warning: excess elements in struct initializer
sound/oss/dmasound/dmasound_awacs.c:264: warning: (near initialization for `awacs_sleep_notifier')
sound/oss/dmasound/dmasound_awacs.c: In function `PMacIrqCleanup':
sound/oss/dmasound/dmasound_awacs.c:679: warning: implicit declaration of function `pmu_unregister_sleep_notifier'
sound/oss/dmasound/dmasound_awacs.c: At top level:
sound/oss/dmasound/dmasound_awacs.c:1424: error: conflicting types for `awacs_sleep_notify'
sound/oss/dmasound/dmasound_awacs.c:262: error: previous declaration of `awacs_sleep_notify'
sound/oss/dmasound/dmasound_awacs.c: In function `awacs_sleep_notify':
sound/oss/dmasound/dmasound_awacs.c:1428: error: `PBOOK_SLEEP_NOW' undeclared (first use in this function)
sound/oss/dmasound/dmasound_awacs.c:1428: error: (Each undeclared identifier is reported only once
sound/oss/dmasound/dmasound_awacs.c:1428: error: for each function it appears in.)
sound/oss/dmasound/dmasound_awacs.c:1481: error: `PBOOK_WAKE' undeclared (first use in this function)
sound/oss/dmasound/dmasound_awacs.c:1552: error: `PBOOK_SLEEP_OK' undeclared (first use in this function)
sound/oss/dmasound/dmasound_awacs.c: In function `dmasound_awacs_init':
sound/oss/dmasound/dmasound_awacs.c:3057: warning: implicit declaration of function `pmu_register_sleep_notifier'
sound/oss/dmasound/dmasound_awacs.c: At top level:
sound/oss/dmasound/dmasound_awacs.c:263: error: storage size of `awacs_sleep_notifier' isn't known

Signed-off-by: Olaf Hering <olh@suse.de>

 sound/oss/dmasound/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.14-rc5/sound/oss/dmasound/Kconfig
===================================================================
--- linux-2.6.14-rc5.orig/sound/oss/dmasound/Kconfig
+++ linux-2.6.14-rc5/sound/oss/dmasound/Kconfig
@@ -14,7 +14,7 @@ config DMASOUND_ATARI
 
 config DMASOUND_PMAC
 	tristate "PowerMac DMA sound support"
-	depends on PPC32 && PPC_PMAC && SOUND && I2C
+	depends on PPC32 && PPC_PMAC && SOUND && I2C && (ADB_CUDA || ADB_PMU)
  	select DMASOUND
 	help
 	  If you want to use the internal audio of your PowerMac in Linux,
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
