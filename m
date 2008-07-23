Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 810DEDF543
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 04:36:04 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6NIZuii030557
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:35:56 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6NIZp42096568
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 12:35:52 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6NIZl4W002385
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 12:35:48 -0600
Date: Wed, 23 Jul 2008 13:35:48 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 15/16 v4] ibmvfc: Add support for collaborative memory
	overcommit
Message-ID: <20080723183548.GR12905@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080723181932.GC12905@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Brian King <brking@linux.vnet.ibm.com>

Adds support to the ibmvfc driver for collaborative memory overcommit.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
We would like to take this patch through linuxppc-dev with the full
change set for this feature.  We are copying linux-scsi for review and ack.

---
 drivers/scsi/ibmvscsi/ibmvfc.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: b/drivers/scsi/ibmvscsi/ibmvfc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3819,6 +3819,20 @@ static int ibmvfc_remove(struct vio_dev=20
 	return 0;
 }
=20
+/**
+ * ibmvfc_get_desired_dma - Calculate DMA resources needed by the driver
+ * @vdev:	vio device struct
+ *
+ * Return value:
+ *	Number of bytes the driver will need to DMA map at the same time in
+ *	order to perform well.
+ */
+static unsigned long ibmvfc_get_desired_dma(struct vio_dev *vdev)
+{
+	unsigned long pool_dma =3D max_requests * sizeof(union ibmvfc_iu);
+	return pool_dma + ((512 * 1024) * driver_template.cmd_per_lun);
+}
+
 static struct vio_device_id ibmvfc_device_table[] __devinitdata =3D {
 	{"fcp", "IBM,vfc-client"},
 	{ "", "" }
@@ -3829,6 +3843,7 @@ static struct vio_driver ibmvfc_driver =3D
 	.id_table =3D ibmvfc_device_table,
 	.probe =3D ibmvfc_probe,
 	.remove =3D ibmvfc_remove,
+	.get_desired_dma =3D ibmvfc_get_desired_dma,
 	.driver =3D {
 		.name =3D IBMVFC_NAME,
 		.owner =3D THIS_MODULE,
