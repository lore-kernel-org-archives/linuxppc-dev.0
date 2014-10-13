Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 558A41A0704
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 01:01:43 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 18/20] powerpc/ps3: Use pm_power_off rather than
 ppc_md.power_off
Date: Mon, 13 Oct 2014 16:01:26 +0200
Message-Id: <1413208888-49211-19-git-send-email-agraf@suse.de>
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
 arch/powerpc/platforms/ps3/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index 3f509f8..009a200 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -248,6 +248,7 @@ static int __init ps3_probe(void)
 	ps3_mm_init();
 	ps3_mm_vas_create(&htab_size);
 	ps3_hpte_init(htab_size);
+	pm_power_off = ps3_power_off;
 
 	DBG(" <- %s:%d\n", __func__, __LINE__);
 	return 1;
@@ -278,7 +279,6 @@ define_machine(ps3) {
 	.calibrate_decr			= ps3_calibrate_decr,
 	.progress			= ps3_progress,
 	.restart			= ps3_restart,
-	.power_off			= ps3_power_off,
 	.halt				= ps3_halt,
 #if defined(CONFIG_KEXEC)
 	.kexec_cpu_down			= ps3_kexec_cpu_down,
-- 
1.8.1.4
