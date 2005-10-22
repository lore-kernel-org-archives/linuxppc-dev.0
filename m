Return-Path: <olh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8333685DE
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 05:55:57 +1000 (EST)
Date: Sat, 22 Oct 2005 21:55:52 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051022195552.GA3607@suse.de>
References: <20051022194626.GA3496@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051022194626.GA3496@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] snd_powermac depends on pmac specific config options
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


snd_powermac should depend on pmac specific .config options.
Since PMAC is always defined, but PMAC wont boot without either
CUDA or PMU, one of these options indicates that the kernel is
for a PowerMac.
CONFIG_PM can be selected unconditionally.

sound/ppc/pmac.c:1380: warning: `struct pmu_sleep_notifier' declared inside parameter list
sound/ppc/pmac.c:1380: warning: its scope is only this definition or declaration, which is probably not what you want
sound/ppc/pmac.c: In function `snd_pmac_sleep_notify':
sound/ppc/pmac.c:1388: error: `PBOOK_SLEEP_NOW' undeclared (first use in this function)
sound/ppc/pmac.c:1388: error: (Each undeclared identifier is reported only once
sound/ppc/pmac.c:1388: error: for each function it appears in.)
sound/ppc/pmac.c:1391: error: `PBOOK_WAKE' undeclared (first use in this function)
sound/ppc/pmac.c:1395: error: `PBOOK_SLEEP_OK' undeclared (first use in this function)
sound/ppc/pmac.c: At top level:
sound/ppc/pmac.c:1398: error: variable `snd_pmac_sleep_notifier' has initializer but incomplete type
sound/ppc/pmac.c:1399: warning: excess elements in struct initializer
sound/ppc/pmac.c:1399: warning: (near initialization for `snd_pmac_sleep_notifier')
sound/ppc/pmac.c:1399: error: `SLEEP_LEVEL_SOUND' undeclared here (not in a function)
sound/ppc/pmac.c:1399: warning: excess elements in struct initializer
sound/ppc/pmac.c:1399: warning: (near initialization for `snd_pmac_sleep_notifier')
sound/ppc/pmac.c: In function `snd_pmac_register_sleep_notifier':
sound/ppc/pmac.c:1407: warning: implicit declaration of function `pmu_register_sleep_notifier'
sound/ppc/pmac.c: In function `snd_pmac_unregister_sleep_notifier':
sound/ppc/pmac.c:1415: warning: implicit declaration of function `pmu_unregister_sleep_notifier'
sound/ppc/pmac.c: At top level:
sound/ppc/pmac.c:1398: error: storage size of `snd_pmac_sleep_notifier' isn't known
make[3]: *** [sound/ppc/pmac.o] Error 1

Signed-off-by: Olaf Hering <olh@suse.de>

 sound/ppc/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.14-rc5/sound/ppc/Kconfig
===================================================================
--- linux-2.6.14-rc5.orig/sound/ppc/Kconfig
+++ linux-2.6.14-rc5/sound/ppc/Kconfig
@@ -11,7 +11,7 @@ comment "ALSA PowerMac requires INPUT"
 
 config SND_POWERMAC
 	tristate "PowerMac (AWACS, DACA, Burgundy, Tumbler, Keywest)"
-	depends on SND && I2C && INPUT && PPC_PMAC
+	depends on SND && I2C && INPUT && PPC_PMAC && (ADB_CUDA || ADB_PMU)
 	select SND_PCM
 	select SND_GENERIC_DRIVER
 	help
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
