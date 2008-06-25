Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BDC32DF7CB
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 06:18:55 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5PKIoT9030330
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:18:50 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5PKIoFn179326
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:18:50 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5PKIoBo011167
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:18:50 -0400
Date: Wed, 25 Jun 2008 15:18:46 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 14/18 v2] powerpc: hvcs enablement for CMO
Message-ID: <20080625201846.GP17020@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080625201202.GB17020@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Robert Jennings <rcj@linux.vnet.ibm.com>

Define a get_io_entitlement function so that it can function in a
Cooperative Memory Overcommitment (CMO) environment (it returns 0 to
indicate that no IO entitlement is required, as the driver does not
perform DMA operations).

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 drivers/char/hvcs.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: b/drivers/char/hvcs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/char/hvcs.c
+++ b/drivers/char/hvcs.c
@@ -756,6 +756,11 @@ static int hvcs_get_index(void)
 	return -1;
 }
=20
+unsigned long hvcs_get_io_entitlement(struct vio_dev *vdev)
+{
+	return 0;
+}
+
 static int __devinit hvcs_probe(
 	struct vio_dev *dev,
 	const struct vio_device_id *id)
@@ -869,6 +874,7 @@ static struct vio_driver hvcs_vio_driver
 	.id_table	=3D hvcs_driver_table,
 	.probe		=3D hvcs_probe,
 	.remove		=3D hvcs_remove,
+	.get_io_entitlement =3D hvcs_get_io_entitlement,
 	.driver		=3D {
 		.name	=3D hvcs_driver_name,
 		.owner	=3D THIS_MODULE,
