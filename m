Return-Path: <brking@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 850D2B7E13
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 May 2010 08:04:59 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4EM3BpH027969
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2010 16:03:11 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4EM4ibX099326
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2010 16:04:46 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4EM4hXN012572
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2010 16:04:44 -0600
Message-ID: <4BEDC8F9.1010104@linux.vnet.ibm.com>
Date: Fri, 14 May 2010 17:04:41 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCHv3 2/3] powerpc: Switch VIO Bus PM to use generic helpers
References: <201005102053.o4AKrFJL017810@d03av05.boulder.ibm.com>
	<1273556129.21352.3.camel@pasglop>
In-Reply-To: <1273556129.21352.3.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Switch to use the generic power management helpers.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/vio.c |   25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff -puN arch/powerpc/kernel/vio.c~powerpc_vio_bus_pm2 arch/powerpc/kernel/vio.c
--- powerpc.git/arch/powerpc/kernel/vio.c~powerpc_vio_bus_pm2	2010-05-11 09:49:58.000000000 -0500
+++ powerpc.git-bjking1/arch/powerpc/kernel/vio.c	2010-05-11 09:50:44.000000000 -0500
@@ -1381,29 +1381,6 @@ static int vio_hotplug(struct device *de
 	return 0;
 }
 
-static int vio_pm_suspend(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm && pm->suspend)
-		return pm->suspend(dev);
-	return 0;
-}
-
-static int vio_pm_resume(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm && pm->resume)
-		return pm->resume(dev);
-	return 0;
-}
-
-const struct dev_pm_ops vio_dev_pm_ops = {
-	.suspend = vio_pm_suspend,
-	.resume = vio_pm_resume,
-};
-
 static struct bus_type vio_bus_type = {
 	.name = "vio",
 	.dev_attrs = vio_dev_attrs,
@@ -1411,7 +1388,7 @@ static struct bus_type vio_bus_type = {
 	.match = vio_bus_match,
 	.probe = vio_bus_probe,
 	.remove = vio_bus_remove,
-	.pm = &vio_dev_pm_ops,
+	.pm = GENERIC_SUBSYS_PM_OPS,
 };
 
 /**
_
