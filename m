Return-Path: <brking@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 61D55B7CF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Feb 2010 11:02:51 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1NNt6g7030642
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2010 16:55:06 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o1O02RE7175314
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2010 17:02:28 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1O02R5t031113
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2010 17:02:27 -0700
Message-Id: <201002240002.o1O02QL4031086@d03av05.boulder.ibm.com>
Subject: [PATCH 2/2] powerpc: Add power management support to VIO bus
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Tue, 23 Feb 2010 18:02:36 -0600
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Adds support for suspend/resume for VIO devices. This is needed for
support for HMC initiated hibernation.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/vio.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff -puN arch/powerpc/kernel/vio.c~powerpc_vio_bus_pm arch/powerpc/kernel/vio.c
--- linux-2.6/arch/powerpc/kernel/vio.c~powerpc_vio_bus_pm	2010-02-21 09:56:18.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/kernel/vio.c	2010-02-21 09:57:53.000000000 -0600
@@ -1357,6 +1357,29 @@ static int vio_hotplug(struct device *de
 	return 0;
 }
 
+static int vio_pm_suspend(struct device *dev)
+{
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+
+	if (pm && pm->suspend)
+		return pm->suspend(dev);
+	return 0;
+}
+
+static int vio_pm_resume(struct device *dev)
+{
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+
+	if (pm && pm->resume)
+		return pm->resume(dev);
+	return 0;
+}
+
+const struct dev_pm_ops vio_dev_pm_ops = {
+	.suspend = vio_pm_suspend,
+	.resume = vio_pm_resume,
+};
+
 static struct bus_type vio_bus_type = {
 	.name = "vio",
 	.dev_attrs = vio_dev_attrs,
@@ -1364,6 +1387,7 @@ static struct bus_type vio_bus_type = {
 	.match = vio_bus_match,
 	.probe = vio_bus_probe,
 	.remove = vio_bus_remove,
+	.pm = &vio_dev_pm_ops,
 };
 
 /**
_
