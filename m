Return-Path: <fenkes@de.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 308D5DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 02:16:04 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l7TGFm17484352
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 16:15:48 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7TGFlgf503978
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 17:15:47 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7TGFUnN023006
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 17:15:31 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2.6.23] ibmebus: Prevent bus_id collisions
Date: Wed, 29 Aug 2007 18:15:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708291815.18197.fenkes@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previously, ibmebus derived a device's bus_id from its location code. The
location code is not guaranteed to be unique, so we might get bus_id
collisions if two devices share the same location code. The OFDT full_name,
however, is unique, so we use that instead.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---

The patch has been tested and works fine. If you think it's too much change
for 2.6.23-rc5, please schedule for 2.6.24 instead.

 arch/powerpc/kernel/ibmebus.c |   30 +++++++++---------------------
 1 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 9a8c9af..d6a38cd 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -188,33 +188,21 @@ static struct ibmebus_dev* __devinit ibmebus_register_device_node(
 	struct device_node *dn)
 {
 	struct ibmebus_dev *dev;
-	const char *loc_code;
-	int length;
-
-	loc_code = of_get_property(dn, "ibm,loc-code", NULL);
-	if (!loc_code) {
-                printk(KERN_WARNING "%s: node %s missing 'ibm,loc-code'\n",
-		       __FUNCTION__, dn->name ? dn->name : "<unknown>");
-		return ERR_PTR(-EINVAL);
-        }
-
-	if (strlen(loc_code) == 0) {
-	        printk(KERN_WARNING "%s: 'ibm,loc-code' is invalid\n",
-		       __FUNCTION__);
-		return ERR_PTR(-EINVAL);
-	}
+	int i, len, bus_len;
 
 	dev = kzalloc(sizeof(struct ibmebus_dev), GFP_KERNEL);
-	if (!dev) {
+	if (!dev)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	dev->ofdev.node = of_node_get(dn);
 
-	length = strlen(loc_code);
-	memcpy(dev->ofdev.dev.bus_id, loc_code
-		+ (length - min(length, BUS_ID_SIZE - 1)),
-		min(length, BUS_ID_SIZE - 1));
+	len = strlen(dn->full_name + 1);
+	bus_len = min(len, BUS_ID_SIZE - 1);
+	memcpy(dev->ofdev.dev.bus_id, dn->full_name + 1
+	       + (len - bus_len), bus_len);
+	for (i = 0; i < bus_len; i++)
+		if (dev->ofdev.dev.bus_id[i] == '/')
+			dev->ofdev.dev.bus_id[i] = '_';
 
 	/* Register with generic device framework. */
 	if (ibmebus_register_device_common(dev, dn->name) != 0) {
-- 
1.5.2
