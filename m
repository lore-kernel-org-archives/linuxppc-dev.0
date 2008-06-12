Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1D9BDE98A
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 08:23:31 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5CMNSsV003950
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 18:23:28 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5CMNScx058216
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 18:23:28 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5CMNSEi020950
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 18:23:28 -0400
Date: Thu, 12 Jun 2008 17:21:58 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 14/19] powerpc: hvc enablement for CMO
Message-ID: <20080612222157.GV30916@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080612215312.GF30916@linux.vnet.ibm.com>
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
 drivers/char/hvc_vio.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: b/drivers/char/hvc_vio.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/char/hvc_vio.c
+++ b/drivers/char/hvc_vio.c
@@ -82,6 +82,11 @@ static struct hv_ops hvc_get_put_ops =3D {
 	.put_chars =3D hvc_put_chars,
 };
=20
+unsigned long hvc_io_entitlement(struct vio_dev *vdev)
+{
+	return 0;
+}
+
 static int __devinit hvc_vio_probe(struct vio_dev *vdev,
 				const struct vio_device_id *id)
 {
@@ -111,6 +116,7 @@ static struct vio_driver hvc_vio_driver=20
 	.id_table	=3D hvc_driver_table,
 	.probe		=3D hvc_vio_probe,
 	.remove		=3D hvc_vio_remove,
+	.get_io_entitlement =3D hvc_io_entitlement,
 	.driver		=3D {
 		.name	=3D hvc_driver_name,
 		.owner	=3D THIS_MODULE,
