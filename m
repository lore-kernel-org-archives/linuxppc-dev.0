Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C9C1E2C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 13:21:04 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r443L0li008990
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 22:21:01 -0500
Message-ID: <1367637660.4389.136.camel@pasglop>
Subject: [PATCH] powerpc/powerpnv: Properly handle failure starting CPUs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Sat, 04 May 2013 13:21:00 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If OPAL returns an error, propagate it upward rather than spinning
seconds waiting for a CPU that will never show up

Signed-off-by: Benjamin Herrenschmidt  <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/smp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 0bdc735..6a3ecca 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -77,9 +77,11 @@ int pnv_smp_kick_cpu(int nr)
 	if (!paca[nr].cpu_start && firmware_has_feature(FW_FEATURE_OPALv2)) {
 		pr_devel("OPAL: Starting CPU %d (HW 0x%x)...\n", nr, pcpu);
 		rc = opal_start_cpu(pcpu, start_here);
-		if (rc != OPAL_SUCCESS)
+		if (rc != OPAL_SUCCESS) {
 			pr_warn("OPAL Error %ld starting CPU %d\n",
 				rc, nr);
+			return -ENODEV;
+		}
 	}
 	return smp_generic_kick_cpu(nr);
 }
