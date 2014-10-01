Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 324121A1815
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:19 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/20] powerpc/maple: Use pm_power_off rather than
 ppc_md.power_off
Date: Wed,  1 Oct 2014 15:28:01 +0200
Message-Id: <1412170086-57971-16-git-send-email-agraf@suse.de>
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
 arch/powerpc/platforms/maple/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index cb1b0b3..34a08db 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -169,7 +169,7 @@ static void __init maple_use_rtas_reboot_and_halt_if_present(void)
 	if (rtas_service_present("system-reboot") &&
 	    rtas_service_present("power-off")) {
 		ppc_md.restart = rtas_restart;
-		ppc_md.power_off = rtas_power_off;
+		pm_power_off = rtas_power_off;
 		ppc_md.halt = rtas_halt;
 	}
 }
@@ -189,6 +189,7 @@ void __init maple_setup_arch(void)
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
+	pm_power_off = maple_power_off;
 	maple_use_rtas_reboot_and_halt_if_present();
 
 	printk(KERN_DEBUG "Using native/NAP idle loop\n");
@@ -325,7 +326,6 @@ define_machine(maple) {
 	.pci_irq_fixup		= maple_pci_irq_fixup,
 	.pci_get_legacy_ide_irq	= maple_pci_get_legacy_ide_irq,
 	.restart		= maple_restart,
-	.power_off		= maple_power_off,
 	.halt			= maple_halt,
        	.get_boot_time		= maple_get_boot_time,
        	.set_rtc_time		= maple_set_rtc_time,
-- 
1.8.1.4
