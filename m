Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5029A1A184B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:22 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 14/20] powerpc/6xx/wii: Use pm_power_off rather than
 ppc_md.power_off
Date: Wed,  1 Oct 2014 15:28:00 +0200
Message-Id: <1412170086-57971-15-git-send-email-agraf@suse.de>
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
 arch/powerpc/platforms/embedded6xx/wii.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 6d8dadf..24d656d 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -158,6 +158,8 @@ static void __init wii_setup_arch(void)
 		clrbits32(hw_gpio + HW_GPIO_OUT(0),
 			  HW_GPIO_SLOT_LED | HW_GPIO_SENSOR_BAR);
 	}
+
+	pm_power_off = wii_power_off;
 }
 
 static void wii_restart(char *cmd)
@@ -226,7 +228,6 @@ define_machine(wii) {
 	.init_early		= wii_init_early,
 	.setup_arch		= wii_setup_arch,
 	.restart		= wii_restart,
-	.power_off		= wii_power_off,
 	.halt			= wii_halt,
 	.init_IRQ		= wii_pic_probe,
 	.get_irq		= flipper_pic_get_irq,
-- 
1.8.1.4
