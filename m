Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7Q1v05G8zDqqP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 07:52:18 +1100 (AEDT)
Subject: [PATCH 2/2] powermac: Improve a size determination in five functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5188c0b3-476a-6a14-bab5-052ad0f4dae0@users.sourceforge.net>
Message-ID: <97bf4b4e-811e-58c4-214e-7d60c014a3d0@users.sourceforge.net>
Date: Thu, 5 Oct 2017 22:52:05 +0200
MIME-Version: 1.0
In-Reply-To: <5188c0b3-476a-6a14-bab5-052ad0f4dae0@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 5 Oct 2017 22:40:39 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/powermac/low_i2c.c    | 6 +++---
 arch/powerpc/platforms/powermac/pfunc_core.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index ecd166b5549b..46b7eb1a0f5f 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -492,7 +492,7 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
 	const u32		*psteps, *prate, *addrp;
 	u32			steps;
 
-	host = kzalloc(sizeof(struct pmac_i2c_host_kw), GFP_KERNEL);
+	host = kzalloc(sizeof(*host), GFP_KERNEL);
 	if (!host)
 		return NULL;
 
@@ -571,7 +571,7 @@ static void __init kw_i2c_add(struct pmac_i2c_host_kw *host,
 {
 	struct pmac_i2c_bus *bus;
 
-	bus = kzalloc(sizeof(struct pmac_i2c_bus), GFP_KERNEL);
+	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
 	if (bus == NULL)
 		return;
 
@@ -1253,7 +1253,7 @@ static void* pmac_i2c_do_begin(struct pmf_function *func, struct pmf_args *args)
 	 * near OOM that need to be resolved, the allocator itself should
 	 * probably make GFP_NOIO implicit during suspend
 	 */
-	inst = kzalloc(sizeof(struct pmac_i2c_pf_inst), GFP_KERNEL);
+	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
 	if (inst == NULL) {
 		pmac_i2c_close(bus);
 		return NULL;
diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c b/arch/powerpc/platforms/powermac/pfunc_core.c
index df3c93bef228..e0462fedcdb8 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -643,7 +643,7 @@ static int pmf_add_function_prop(struct pmf_device *dev, void *driverdata,
 
 	while (length >= 12) {
 		/* Allocate a structure */
-		func = kzalloc(sizeof(struct pmf_function), GFP_KERNEL);
+		func = kzalloc(sizeof(*func), GFP_KERNEL);
 		if (func == NULL)
 			goto bail;
 		kref_init(&func->ref);
@@ -719,7 +719,7 @@ int pmf_register_driver(struct device_node *np,
 		return -EBUSY;
 	}
 
-	dev = kzalloc(sizeof(struct pmf_device), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev == NULL) {
 		DBG("pmf: no memory !\n");
 		return -ENOMEM;
-- 
2.14.2
