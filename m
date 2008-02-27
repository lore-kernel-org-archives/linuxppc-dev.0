Return-Path: <agx@sigxcpu.org>
Received: from honk.sigxcpu.org (static-87-79-238-240.netcologne.de
	[87.79.238.240])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "honk.sigxcpu.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 801F5DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 01:38:21 +1100 (EST)
Date: Wed, 27 Feb 2008 15:14:52 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Always define pmu_sys_suspended
Message-ID: <20080227141452.GA10345@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In current Linus git pmu_sys_suspended is only defined if
CONFIG_SUSPEND is set, so compilation fails with:

drivers/built-in.o: In function `pmu_led_set':
via-pmu-led.c:(.text+0x48622): undefined reference to `pmu_sys_suspended'
via-pmu-led.c:(.text+0x48626): undefined reference to `pmu_sys_suspended'
drivers/built-in.o: In function `pmu_req_done':
via-pmu-led.c:(.text+0x48696): undefined reference to `pmu_sys_suspended'
via-pmu-led.c:(.text+0x4869a): undefined reference to `pmu_sys_suspended'
make: *** [.tmp_vmlinux1] Error 1

since via-pmu-led.c uses it unconditionally. Instead of adding more '#ifdef'
clutter I moved it out of the #ifdef so it's always available. Need to fix
compilation on PPC32 without CONFIG_SUSPEND.

Signed-off-by: Guido Guenther <agx@sigxcpu.org>
---
 drivers/macintosh/via-pmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index ebec663..296edcb 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -2437,8 +2437,8 @@ void pmu_blink(int n)
 }
 #endif /* DEBUG_SLEEP */
 
-#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
 int pmu_sys_suspended;
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
 
 static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
 {
-- 
1.5.4.2
