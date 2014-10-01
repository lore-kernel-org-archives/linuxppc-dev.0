Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9A1F1A072D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:15 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/20] powerpc/celleb: Use pm_power_off rather than
 ppc_md.power_off
Date: Wed,  1 Oct 2014 15:27:54 +0200
Message-Id: <1412170086-57971-9-git-send-email-agraf@suse.de>
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
 arch/powerpc/platforms/cell/celleb_setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/celleb_setup.c b/arch/powerpc/platforms/cell/celleb_setup.c
index 1d5a4d8..011cc88 100644
--- a/arch/powerpc/platforms/cell/celleb_setup.c
+++ b/arch/powerpc/platforms/cell/celleb_setup.c
@@ -130,6 +130,7 @@ static void __init celleb_setup_arch_beat(void)
 #endif
 
 	celleb_setup_arch_common();
+	pm_power_off = beat_power_off;
 }
 
 static int __init celleb_probe_beat(void)
@@ -178,6 +179,7 @@ static void __init celleb_setup_arch_native(void)
 	/* XXX: nvram initialization should be added */
 
 	celleb_setup_arch_common();
+	pm_power_off = rtas_power_off;
 }
 
 static int __init celleb_probe_native(void)
@@ -204,7 +206,6 @@ define_machine(celleb_beat) {
 	.setup_arch		= celleb_setup_arch_beat,
 	.show_cpuinfo		= celleb_show_cpuinfo,
 	.restart		= beat_restart,
-	.power_off		= beat_power_off,
 	.halt			= beat_halt,
 	.get_rtc_time		= beat_get_rtc_time,
 	.set_rtc_time		= beat_set_rtc_time,
@@ -230,7 +231,6 @@ define_machine(celleb_native) {
 	.setup_arch		= celleb_setup_arch_native,
 	.show_cpuinfo		= celleb_show_cpuinfo,
 	.restart		= rtas_restart,
-	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
 	.get_boot_time		= rtas_get_boot_time,
 	.get_rtc_time		= rtas_get_rtc_time,
-- 
1.8.1.4
