Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6F3F1A0010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 11:16:06 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: Don't skip ePAPR spin-table CPUs
Date: Tue, 24 Jun 2014 20:15:51 -0500
Message-ID: <1403658951-23158-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, Michael Neuling <mikey@neuling.org>,
 stable@vger.kernel.org, Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 59a53afe70fd530040bdc69581f03d880157f15a "powerpc: Don't setup
CPUs with bad status" broke ePAPR SMP booting.  ePAPR says that CPUs
that aren't presently running shall have status of disabled, with
enable-method being used to determine whether the CPU can be enabled.

Fix by checking for spin-table, which is currently the only supported
enable-method.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/setup-common.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index e239df3..e5b022c 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -469,9 +469,17 @@ void __init smp_setup_cpu_maps(void)
 		}
 
 		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
+			bool avail;
+
 			DBG("    thread %d -> cpu %d (hard id %d)\n",
 			    j, cpu, be32_to_cpu(intserv[j]));
-			set_cpu_present(cpu, of_device_is_available(dn));
+
+			avail = of_device_is_available(dn);
+			if (!avail)
+				avail = !of_property_match_string(dn,
+						"enable-method", "spin-table");
+
+			set_cpu_present(cpu, avail);
 			set_hard_smp_processor_id(cpu, be32_to_cpu(intserv[j]));
 			set_cpu_possible(cpu, true);
 			cpu++;
-- 
1.9.1
