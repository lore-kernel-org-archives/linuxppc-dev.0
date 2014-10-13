Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 578F21A0707
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 01:01:43 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 15/20] powerpc/maple: Use pm_power_off rather than
 ppc_md.power_off
Date: Mon, 13 Oct 2014 16:01:23 +0200
Message-Id: <1413208888-49211-16-git-send-email-agraf@suse.de>
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
 arch/powerpc/platforms/maple/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index cb1b0b3..56b85cd 100644
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
@@ -312,6 +312,7 @@ static int __init maple_probe(void)
 	alloc_dart_table();
 
 	hpte_init_native();
+	pm_power_off = maple_power_off;
 
 	return 1;
 }
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
