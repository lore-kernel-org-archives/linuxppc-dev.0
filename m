Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPRd15L8wzDqHd
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 08:51:17 +1000 (AEST)
Message-ID: <1465339861.3263.24.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix IBM_ARCH_VEC_NRCORES_OFFSET value
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Thomas Huth <thuth@redhat.com>
Cc: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 08 Jun 2016 08:51:01 +1000
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

Commit 7cc851039d643a2ee7df4d18177150f2c3a484f5
"powerpc/pseries: Add POWER8NVL support to ibm,client-architecture-support call"
introduced a regression by adding fields to the beginning of the
ibm_architecture_vec structure without updating IBM_ARCH_VEC_NRCORES_OFFSET.

This causes the kernel to print a warning at boot and to fail to adjust
the number of cores based on the number of threads before doing the CAS
call to firmware.

This is quite a fragile piece of code sadly, we should try to find a way
to avoid that hard coded offset at some point, but for now this fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index ccd2037..6ee4b72 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -719,7 +719,7 @@ unsigned char ibm_architecture_vec[] = {
 	 * must match by the macro below. Update the definition if
 	 * the structure layout changes.
 	 */
-#define IBM_ARCH_VEC_NRCORES_OFFSET	125
+#define IBM_ARCH_VEC_NRCORES_OFFSET	133
 	W(NR_CPUS),			/* number of cores supported */
 	0,
 	0,
