Return-Path: <arnd@arndb.de>
Message-Id: <20070822170731.984791109@arndb.de>
References: <20070822170124.764128591@arndb.de>
Date: Wed, 22 Aug 2007 19:01:25 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [patch 1/5] spu_manage: use newer physical-id attribute
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
	Christian Krafft <krafft@de.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Krafft <krafft@de.ibm.com>
Legacy device tree used the reg property for the physical id of an spe.
On newer device tree layouts the reg property contains the "correct" value
in the reg attribute. So there has been intoduced the "physical-id" on newer
devicetree layouts. The id is stored by spu_manage into the spu struct as spe_id.
cbe_thermal has been changed to use the spu->spe_id.
There's no need for the thermal code has to check devicetree attributes for itself.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Cc: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

Jeremy, please Ack

Index: linux-2.6/arch/powerpc/platforms/cell/cbe_thermal.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_thermal.c
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_thermal.c
@@ -88,17 +88,13 @@ static struct cbe_pmd_regs __iomem *get_
 /* returns the value for a given spu in a given register */
 static u8 spu_read_register_value(struct sys_device *sysdev, union spe_reg __iomem *reg)
 {
-	const unsigned int *id;
 	union spe_reg value;
 	struct spu *spu;
 
-	/* getting the id from the reg attribute will not work on future device-tree layouts
-	 * in future we should store the id to the spu struct and use it here */
 	spu = container_of(sysdev, struct spu, sysdev);
-	id = of_get_property(spu_devnode(spu), "reg", NULL);
 	value.val = in_be64(&reg->val);
 
-	return value.spe[*id];
+	return value.spe[spu->spe_id];
 }
 
 static ssize_t spu_show_temp(struct sys_device *sysdev, char *buf)
Index: linux-2.6/arch/powerpc/platforms/cell/spu_manage.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_manage.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_manage.c
@@ -48,7 +48,7 @@ static u64 __init find_spu_unit_number(s
 {
 	const unsigned int *prop;
 	int proplen;
-	prop = of_get_property(spe, "unit-id", &proplen);
+	prop = of_get_property(spe, "physical-id", &proplen);
 	if (proplen == 4)
 		return (u64)*prop;
 

--
