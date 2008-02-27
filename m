Return-Path: <agx@sigxcpu.org>
Received: from honk.sigxcpu.org (static-87-79-238-240.netcologne.de
	[87.79.238.240])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "honk.sigxcpu.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38C79DDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 01:38:21 +1100 (EST)
Date: Wed, 27 Feb 2008 15:16:27 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Export pmu_* variables unconditionally
Message-ID: <20080227141627.GA10374@bogon.ms20.nix>
References: <20080227141452.GA10345@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080227141452.GA10345@bogon.ms20.nix>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Otherwise without CONFIG_SUSPEND we have:

ERROR: "pmu_batteries" [drivers/macintosh/apm_emu.ko] undefined!
ERROR: "pmu_battery_count" [drivers/macintosh/apm_emu.ko] undefined!
ERROR: "pmu_power_flags" [drivers/macintosh/apm_emu.ko] undefined!

on PPC32. The variables aren't wrapped in '#if defined(CONFIG_SUSPEND)'
so we probably shouldn't wrap the exports either. Fixes compilation on
ppc32.

Signed-off-by: Guido Guenther <agx@sigxcpu.org>
---
 drivers/macintosh/via-pmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 296edcb..399fc7f 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -2528,7 +2528,7 @@ EXPORT_SYMBOL(pmu_wait_complete);
 EXPORT_SYMBOL(pmu_suspend);
 EXPORT_SYMBOL(pmu_resume);
 EXPORT_SYMBOL(pmu_unlock);
-#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
+#if defined(CONFIG_PPC32)
 EXPORT_SYMBOL(pmu_enable_irled);
 EXPORT_SYMBOL(pmu_battery_count);
 EXPORT_SYMBOL(pmu_batteries);
-- 
1.5.4.2
