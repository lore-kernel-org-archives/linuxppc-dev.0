Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CF14A67B46
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 17:24:35 +1000 (EST)
Received: from localhost (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id B18833682CD
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 17:24:35 +1000 (EST)
Date: Thu, 27 Apr 2006 17:21:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/4] powerpc: use a common vio_match_device routine
Message-Id: <20060427172146.4660a953.sfr@canb.auug.org.au>
In-Reply-To: <20060427171821.6ebdf3fb.sfr@canb.auug.org.au>
References: <20060427170902.51a5a098.sfr@canb.auug.org.au>
	<20060427171821.6ebdf3fb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This requires the compatible properties having vaules that are empty
strings instead of just being empty properties.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/vio.c              |    3 ++-
 arch/powerpc/platforms/iseries/setup.c |   10 +++++-----
 arch/powerpc/platforms/iseries/vio.c   |   12 ------------
 arch/powerpc/platforms/pseries/vio.c   |   12 ------------
 include/asm-powerpc/vio.h              |    1 -
 5 files changed, 7 insertions(+), 31 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

2c0c46b1d70d543203c547034bc1a78ab0fb10a9
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 9b46eed..1952929 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -47,7 +47,8 @@ static const struct vio_device_id *vio_m
 		const struct vio_device_id *ids, const struct vio_dev *dev)
 {
 	while (ids->type[0] != '\0') {
-		if (vio_bus_ops.match(ids, dev))
+		if ((strncmp(dev->type, ids->type, strlen(ids->type)) == 0) &&
+		    device_is_compatible(dev->dev.platform_data, ids->compat))
 			return ids;
 		ids++;
 	}
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 901acbc..befd36a 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -927,7 +927,7 @@ void dt_vdevices(struct iseries_flat_dt 
 	snprintf(buf, sizeof(buf), "viocons@%08x", reg);
 	dt_start_node(dt, buf);
 	dt_prop_str(dt, "device_type", "serial");
-	dt_prop_empty(dt, "compatible");
+	dt_prop_str(dt, "compatible", "");
 	dt_prop_u32(dt, "reg", reg);
 	dt_end_node(dt);
 	reg++;
@@ -949,7 +949,7 @@ void dt_vdevices(struct iseries_flat_dt 
 		snprintf(buf, 32, "vlan@%08x", reg + i);
 		dt_start_node(dt, buf);
 		dt_prop_str(dt, "device_type", "vlan");
-		dt_prop_empty(dt, "compatible");
+		dt_prop_str(dt, "compatible", "");
 		dt_prop_u32(dt, "reg", reg + i);
 		dt_prop_u32(dt, "linux,unit_address", i);
 
@@ -970,7 +970,7 @@ void dt_vdevices(struct iseries_flat_dt 
 		snprintf(buf, 32, "viodasd@%08x", reg + i);
 		dt_start_node(dt, buf);
 		dt_prop_str(dt, "device_type", "viodasd");
-		dt_prop_empty(dt, "compatible");
+		dt_prop_str(dt, "compatible", "");
 		dt_prop_u32(dt, "reg", reg + i);
 		dt_prop_u32(dt, "linux,unit_address", i);
 		dt_end_node(dt);
@@ -980,7 +980,7 @@ void dt_vdevices(struct iseries_flat_dt 
 		snprintf(buf, 32, "viocd@%08x", reg + i);
 		dt_start_node(dt, buf);
 		dt_prop_str(dt, "device_type", "viocd");
-		dt_prop_empty(dt, "compatible");
+		dt_prop_str(dt, "compatible", "");
 		dt_prop_u32(dt, "reg", reg + i);
 		dt_prop_u32(dt, "linux,unit_address", i);
 		dt_end_node(dt);
@@ -990,7 +990,7 @@ void dt_vdevices(struct iseries_flat_dt 
 		snprintf(buf, 32, "viotape@%08x", reg + i);
 		dt_start_node(dt, buf);
 		dt_prop_str(dt, "device_type", "viotape");
-		dt_prop_empty(dt, "compatible");
+		dt_prop_str(dt, "compatible", "");
 		dt_prop_u32(dt, "reg", reg + i);
 		dt_prop_u32(dt, "linux,unit_address", i);
 		dt_end_node(dt);
diff --git a/arch/powerpc/platforms/iseries/vio.c b/arch/powerpc/platforms/iseries/vio.c
index a689da6..bdd2b7d 100644
--- a/arch/powerpc/platforms/iseries/vio.c
+++ b/arch/powerpc/platforms/iseries/vio.c
@@ -50,18 +50,7 @@ static struct iommu_table *vio_build_iom
 	return &vio_iommu_table;
 }
 
-/**
- * vio_match_device_iseries: - Tell if a iSeries VIO device matches a
- *	vio_device_id
- */
-static int vio_match_device_iseries(const struct vio_device_id *id,
-		const struct vio_dev *dev)
-{
-	return strncmp(dev->type, id->type, strlen(id->type)) == 0;
-}
-
 static struct vio_bus_ops vio_bus_ops_iseries = {
-	.match = vio_match_device_iseries,
 	.build_iommu_table = vio_build_iommu_table,
 };
 
@@ -75,5 +64,4 @@ static int __init vio_bus_init_iseries(v
 	iSeries_vio_dev = &vio_bus_device.dev;
 	return vio_bus_init(&vio_bus_ops_iseries);
 }
-
 __initcall(vio_bus_init_iseries);
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index b3925ae..d289166 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -27,17 +27,6 @@ #include <asm/tce.h>
 extern struct subsystem devices_subsys; /* needed for vio_find_name() */
 
 /**
- * vio_match_device_pseries: - Tell if a pSeries VIO device matches a
- *	vio_device_id
- */
-static int vio_match_device_pseries(const struct vio_device_id *id,
-		const struct vio_dev *dev)
-{
-	return (strncmp(dev->type, id->type, strlen(id->type)) == 0) &&
-			device_is_compatible(dev->dev.platform_data, id->compat);
-}
-
-/**
  * vio_build_iommu_table: - gets the dma information from OF and
  *	builds the TCE tree.
  * @dev: the virtual device.
@@ -76,7 +65,6 @@ static struct iommu_table *vio_build_iom
 }
 
 static struct vio_bus_ops vio_bus_ops_pseries = {
-	.match = vio_match_device_pseries,
 	.build_iommu_table = vio_build_iommu_table,
 };
 
diff --git a/include/asm-powerpc/vio.h b/include/asm-powerpc/vio.h
index 0055d8e..9c09a8f 100644
--- a/include/asm-powerpc/vio.h
+++ b/include/asm-powerpc/vio.h
@@ -65,7 +65,6 @@ struct vio_driver {
 };
 
 struct vio_bus_ops {
-	int (*match)(const struct vio_device_id *id, const struct vio_dev *dev);
 	struct iommu_table *(*build_iommu_table)(struct vio_dev *dev);
 };
 
-- 
1.3.1
