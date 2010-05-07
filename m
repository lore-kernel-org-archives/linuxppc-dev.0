Return-Path: <brking@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A8D1B7D7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 May 2010 04:59:23 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o47Iu4CP025655
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 May 2010 12:56:04 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o47Ix1Yu117318
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 May 2010 12:59:02 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o47BwxdQ013704
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 May 2010 05:59:00 -0600
Message-Id: <201005071158.o47BwxPT013700@d03av03.boulder.ibm.com>
Subject: [PATCH 2/2] powerpc: Add power management support to VIO bus
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 07 May 2010 13:58:55 -0500
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
--- linux-2.6/arch/powerpc/kernel/vio.c~powerpc_vio_bus_pm	2010-05-07 13:49:16.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/kernel/vio.c	2010-05-07 13:49:16.000000000 -0500
@@ -1358,6 +1358,29 @@ static int vio_hotplug(struct device *de
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
@@ -1365,6 +1388,7 @@ static struct bus_type vio_bus_type = {
 	.match = vio_bus_match,
 	.probe = vio_bus_probe,
 	.remove = vio_bus_remove,
+	.pm = &vio_dev_pm_ops,
 };
 
 /**
_
