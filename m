Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 579021A183E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:22 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/20] powerpc/cell: Use pm_power_off rather than
 ppc_md.power_off
Date: Wed,  1 Oct 2014 15:27:56 +0200
Message-Id: <1412170086-57971-11-git-send-email-agraf@suse.de>
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
 arch/powerpc/platforms/cell/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 6ae25fb..b6a27d7 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -248,6 +248,7 @@ static void __init cell_setup_arch(void)
 #endif
 
 	mmio_nvram_init();
+	pm_power_off = rtas_power_off;
 }
 
 static int __init cell_probe(void)
@@ -269,7 +270,6 @@ define_machine(cell) {
 	.setup_arch		= cell_setup_arch,
 	.show_cpuinfo		= cell_show_cpuinfo,
 	.restart		= rtas_restart,
-	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
 	.get_boot_time		= rtas_get_boot_time,
 	.get_rtc_time		= rtas_get_rtc_time,
-- 
1.8.1.4
