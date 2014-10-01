Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53EB21A181F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:19 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 18/20] powerpc/ps3: Use pm_power_off rather than
 ppc_md.power_off
Date: Wed,  1 Oct 2014 15:28:04 +0200
Message-Id: <1412170086-57971-19-git-send-email-agraf@suse.de>
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
 arch/powerpc/platforms/ps3/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index 3f509f8..ce3b455 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -223,6 +223,8 @@ static void __init ps3_setup_arch(void)
 	ppc_md.power_save = ps3_power_save;
 	ps3_os_area_init();
 
+	pm_power_off = ps3_power_off;
+
 	DBG(" <- %s:%d\n", __func__, __LINE__);
 }
 
@@ -278,7 +280,6 @@ define_machine(ps3) {
 	.calibrate_decr			= ps3_calibrate_decr,
 	.progress			= ps3_progress,
 	.restart			= ps3_restart,
-	.power_off			= ps3_power_off,
 	.halt				= ps3_halt,
 #if defined(CONFIG_KEXEC)
 	.kexec_cpu_down			= ps3_kexec_cpu_down,
-- 
1.8.1.4
