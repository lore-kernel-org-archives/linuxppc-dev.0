Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 589491A1823
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:19 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 17/20] powerpc/powernv: Use pm_power_off rather than
 ppc_md.power_off
Date: Wed,  1 Oct 2014 15:28:03 +0200
Message-Id: <1412170086-57971-18-git-send-email-agraf@suse.de>
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
 arch/powerpc/platforms/powernv/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 5a0e2dc..60d137b 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -260,7 +260,7 @@ static void __init pnv_setup_machdep_opal(void)
 	ppc_md.get_rtc_time = opal_get_rtc_time;
 	ppc_md.set_rtc_time = opal_set_rtc_time;
 	ppc_md.restart = pnv_restart;
-	ppc_md.power_off = pnv_power_off;
+	pm_power_off = pnv_power_off;
 	ppc_md.halt = pnv_halt;
 	ppc_md.machine_check_exception = opal_machine_check;
 	ppc_md.mce_check_early_recovery = opal_mce_check_early_recovery;
@@ -277,7 +277,7 @@ static void __init pnv_setup_machdep_rtas(void)
 		ppc_md.set_rtc_time = rtas_set_rtc_time;
 	}
 	ppc_md.restart = rtas_restart;
-	ppc_md.power_off = rtas_power_off;
+	pm_power_off = rtas_power_off;
 	ppc_md.halt = rtas_halt;
 }
 #endif /* CONFIG_PPC_POWERNV_RTAS */
-- 
1.8.1.4
