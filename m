Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkr0257K1zDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jun 2017 04:09:06 +1000 (AEST)
Subject: patch "powerpc: ps3: use dev_groups and not dev_attrs for bus_type"
 added to driver-core-next
To: gregkh@linuxfoundation.org, benh@kernel.crashing.org, geoff@infradead.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 09 Jun 2017 20:08:17 +0200
Message-ID: <14970316970107@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    powerpc: ps3: use dev_groups and not dev_attrs for bus_type

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


>From 892533e191a46ec478615e13426921ebe45fa297 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 6 Jun 2017 14:17:17 +0200
Subject: powerpc: ps3: use dev_groups and not dev_attrs for bus_type

The dev_attrs field has long been "depreciated" and is finally being
removed, so move the driver to use the "correct" dev_groups field
instead for struct bus_type.

Seems-ok: Geoff Levand <geoff@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@lists.ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/ps3/system-bus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 2d2e5f80a3d3..5cc35d6b94b6 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -471,11 +471,13 @@ static ssize_t modalias_show(struct device *_dev, struct device_attribute *a,
 
 	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
 }
+static DEVICE_ATTR_RO(modalias);
 
-static struct device_attribute ps3_system_bus_dev_attrs[] = {
-	__ATTR_RO(modalias),
-	__ATTR_NULL,
+static struct attribute *ps3_system_bus_dev_attrs[] = {
+	&dev_attr_modalias.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(ps3_system_bus_dev);
 
 struct bus_type ps3_system_bus_type = {
 	.name = "ps3_system_bus",
@@ -484,7 +486,7 @@ struct bus_type ps3_system_bus_type = {
 	.probe = ps3_system_bus_probe,
 	.remove = ps3_system_bus_remove,
 	.shutdown = ps3_system_bus_shutdown,
-	.dev_attrs = ps3_system_bus_dev_attrs,
+	.dev_groups = ps3_system_bus_dev_groups,
 };
 
 static int __init ps3_system_bus_init(void)
-- 
2.13.1
