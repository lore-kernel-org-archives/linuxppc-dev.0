Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 546881A03C3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 01:01:36 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 08/20] powerpc/celleb: Use pm_power_off rather than
 ppc_md.power_off
Date: Mon, 13 Oct 2014 16:01:16 +0200
Message-Id: <1413208888-49211-9-git-send-email-agraf@suse.de>
In-Reply-To: <1413208888-49211-1-git-send-email-agraf@suse.de>
References: <1413208888-49211-1-git-send-email-agraf@suse.de>
Cc: arnd@arndb.de, geoff@infradead.org, alistair@popple.id.au,
 scottwood@freescale.com, agust@denx.de, linux@roeck-us.net
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

v1 -> v2:

  - write pm_power_off in probe function
---
 arch/powerpc/platforms/cell/celleb_setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/celleb_setup.c b/arch/powerpc/platforms/cell/celleb_setup.c
index 34e8ce2..90be8ec 100644
--- a/arch/powerpc/platforms/cell/celleb_setup.c
+++ b/arch/powerpc/platforms/cell/celleb_setup.c
@@ -142,6 +142,7 @@ static int __init celleb_probe_beat(void)
 	powerpc_firmware_features |= FW_FEATURE_CELLEB_ALWAYS
 		| FW_FEATURE_BEAT | FW_FEATURE_LPAR;
 	hpte_init_beat_v3();
+	pm_power_off = beat_power_off;
 
 	return 1;
 }
@@ -190,6 +191,7 @@ static int __init celleb_probe_native(void)
 
 	powerpc_firmware_features |= FW_FEATURE_CELLEB_ALWAYS;
 	hpte_init_native();
+	pm_power_off = rtas_power_off;
 
 	return 1;
 }
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
