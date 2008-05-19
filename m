Return-Path: <brking@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 66B74DE07D
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 01:28:05 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4JFRw7r008731
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 11:27:58 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4JFRw8v152772
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 11:27:58 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4JFRvcU021146
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 11:27:58 -0400
Subject: [PATCH 1/1] ibmvscsi: Non SCSI error status fixup
To: James.Bottomley@HansenPartnership.com
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 19 May 2008 10:27:56 -0500
Message-Id: <12112108763801-patch-mail.ibm.com>
Cc: sfr@canb.auug.org.au, linux-scsi@vger.kernel.org, linuxppc-dev@ozlabs.org,
	anton@samba.org, brking@linux.vnet.ibm.com,
	rcjenn@linux.vnet.ibm.com, santil@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Some versions of the Virtual I/O Server on Power
return 0x99 in the non-SCSI error status field as success,
rather than 0. This fixes the ibmvscsi driver to treat this
response as success.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 linux-2.6-bjking1/drivers/scsi/ibmvscsi/ibmvscsi.c |    2 +-
 linux-2.6-bjking1/drivers/scsi/ibmvscsi/viosrp.h   |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/scsi/ibmvscsi/viosrp.h~ibmvscsi_non_scsi_status_workaround drivers/scsi/ibmvscsi/viosrp.h
--- linux-2.6/drivers/scsi/ibmvscsi/viosrp.h~ibmvscsi_non_scsi_status_workaround	2008-05-19 10:01:00.000000000 -0500
+++ linux-2.6-bjking1/drivers/scsi/ibmvscsi/viosrp.h	2008-05-19 10:01:33.000000000 -0500
@@ -65,7 +65,8 @@ enum viosrp_crq_status {
 	VIOSRP_VIOLATES_MAX_XFER = 0x2,
 	VIOSRP_PARTNER_PANIC = 0x3,
 	VIOSRP_DEVICE_BUSY = 0x8,
-	VIOSRP_ADAPTER_FAIL = 0x10
+	VIOSRP_ADAPTER_FAIL = 0x10,
+	VIOSRP_OK2 = 0x99,
 };
 
 struct viosrp_crq {
diff -puN drivers/scsi/ibmvscsi/ibmvscsi.c~ibmvscsi_non_scsi_status_workaround drivers/scsi/ibmvscsi/ibmvscsi.c
--- linux-2.6/drivers/scsi/ibmvscsi/ibmvscsi.c~ibmvscsi_non_scsi_status_workaround	2008-05-19 10:01:44.000000000 -0500
+++ linux-2.6-bjking1/drivers/scsi/ibmvscsi/ibmvscsi.c	2008-05-19 10:02:24.000000000 -0500
@@ -1348,7 +1348,7 @@ void ibmvscsi_handle_crq(struct viosrp_c
 
 	del_timer(&evt_struct->timer);
 
-	if (crq->status != VIOSRP_OK && evt_struct->cmnd)
+	if ((crq->status != VIOSRP_OK && crq->status != VIOSRP_OK2) && evt_struct->cmnd)
 		evt_struct->cmnd->result = DID_ERROR << 16;
 	if (evt_struct->done)
 		evt_struct->done(evt_struct);
_
