Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5022A1A1848
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:22 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/20] powerpc/6xx/gamecube: Use pm_power_off rather than
 ppc_md.power_off
Date: Wed,  1 Oct 2014 15:27:58 +0200
Message-Id: <1412170086-57971-13-git-send-email-agraf@suse.de>
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
 arch/powerpc/platforms/embedded6xx/gamecube.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/embedded6xx/gamecube.c b/arch/powerpc/platforms/embedded6xx/gamecube.c
index a138e14..3ee7a8b 100644
--- a/arch/powerpc/platforms/embedded6xx/gamecube.c
+++ b/arch/powerpc/platforms/embedded6xx/gamecube.c
@@ -67,6 +67,8 @@ static int __init gamecube_probe(void)
 	if (!of_flat_dt_is_compatible(dt_root, "nintendo,gamecube"))
 		return 0;
 
+	pm_power_off = gamecube_power_off;
+
 	return 1;
 }
 
@@ -80,7 +82,6 @@ define_machine(gamecube) {
 	.probe			= gamecube_probe,
 	.init_early		= gamecube_init_early,
 	.restart		= gamecube_restart,
-	.power_off		= gamecube_power_off,
 	.halt			= gamecube_halt,
 	.init_IRQ		= flipper_pic_probe,
 	.get_irq		= flipper_pic_get_irq,
-- 
1.8.1.4
