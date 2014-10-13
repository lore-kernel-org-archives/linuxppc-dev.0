Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47D201A06FE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 01:01:43 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 11/20] powerpc/chrp: Use pm_power_off rather than
 ppc_md.power_off
Date: Mon, 13 Oct 2014 16:01:19 +0200
Message-Id: <1413208888-49211-12-git-send-email-agraf@suse.de>
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
 arch/powerpc/platforms/chrp/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 5b77b19..dbe7d16 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -585,6 +585,8 @@ static int __init chrp_probe(void)
 	DMA_MODE_READ = 0x44;
 	DMA_MODE_WRITE = 0x48;
 
+	pm_power_off = rtas_power_off,
+
 	return 1;
 }
 
@@ -597,7 +599,6 @@ define_machine(chrp) {
 	.show_cpuinfo		= chrp_show_cpuinfo,
 	.init_IRQ		= chrp_init_IRQ,
 	.restart		= rtas_restart,
-	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
 	.time_init		= chrp_time_init,
 	.set_rtc_time		= chrp_set_rtc_time,
-- 
1.8.1.4
