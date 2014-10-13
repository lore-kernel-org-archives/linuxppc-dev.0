Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8F2B1A067A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 01:01:39 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 13/20] powerpc/6xx/linkstation: Use pm_power_off rather
 than ppc_md.power_off
Date: Mon, 13 Oct 2014 16:01:21 +0200
Message-Id: <1413208888-49211-14-git-send-email-agraf@suse.de>
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
 arch/powerpc/platforms/embedded6xx/linkstation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 168e1d8..540eeb5 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -147,6 +147,9 @@ static int __init linkstation_probe(void)
 
 	if (!of_flat_dt_is_compatible(root, "linkstation"))
 		return 0;
+
+	pm_power_off = linkstation_power_off;
+
 	return 1;
 }
 
@@ -158,7 +161,6 @@ define_machine(linkstation){
 	.show_cpuinfo 		= linkstation_show_cpuinfo,
 	.get_irq 		= mpic_get_irq,
 	.restart 		= linkstation_restart,
-	.power_off 		= linkstation_power_off,
 	.halt	 		= linkstation_halt,
 	.calibrate_decr 	= generic_calibrate_decr,
 };
-- 
1.8.1.4
