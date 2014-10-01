Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1832E1A1802
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:19 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/20] powerpc/cell/qpace: Use pm_power_off rather than
 ppc_md.power_off
Date: Wed,  1 Oct 2014 15:27:55 +0200
Message-Id: <1412170086-57971-10-git-send-email-agraf@suse.de>
In-Reply-To: <1412170086-57971-1-git-send-email-agraf@suse.de>
References: <1412170086-57971-1-git-send-email-agraf@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic power off callback is pm_power_off. Use that one rather than
the powerpc specific ppc_md.power_off.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/platforms/cell/qpace_setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/qpace_setup.c b/arch/powerpc/platforms/cell/qpace_setup.c
index 6e3409d..8488094 100644
--- a/arch/powerpc/platforms/cell/qpace_setup.c
+++ b/arch/powerpc/platforms/cell/qpace_setup.c
@@ -117,6 +117,8 @@ static void __init qpace_setup_arch(void)
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
+
+	pm_power_off = rtas_power_off;
 }
 
 static int __init qpace_probe(void)
@@ -137,7 +139,6 @@ define_machine(qpace) {
 	.setup_arch		= qpace_setup_arch,
 	.show_cpuinfo		= qpace_show_cpuinfo,
 	.restart		= rtas_restart,
-	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
 	.get_boot_time		= rtas_get_boot_time,
 	.get_rtc_time		= rtas_get_rtc_time,
-- 
1.8.1.4
