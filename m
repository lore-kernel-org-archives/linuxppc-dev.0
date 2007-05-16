Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3A84DDE2B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 22:39:48 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l4GCdinB053486
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 12:39:44 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l4GCdcZg3137582
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 14:39:43 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l4GCdSmf015410
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 14:39:28 +0200
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org
Subject: [PATCH 2.6.22] ehca: return proper error code if register_mr fails
Date: Wed, 16 May 2007 14:50:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705161450.55848.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch sets the return code of ehca_register_mr() to ENOMEM
if corresponding firmware call fails due to out of resources.
Some of error codes were mapped to EINVAL. They are now mapped
to default case, which already returns EINVAL anyway.


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_mrmw.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
index 84c5bb4..add79bd 100644
--- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -2050,13 +2050,10 @@ int ehca_mrmw_map_hrc_alloc(const u64 hi
 	switch (hipz_rc) {
 	case H_SUCCESS:	             /* successful completion */
 		return 0;
-	case H_ADAPTER_PARM:         /* invalid adapter handle */
-	case H_RT_PARM:              /* invalid resource type */
 	case H_NOT_ENOUGH_RESOURCES: /* insufficient resources */
-	case H_MLENGTH_PARM:         /* invalid memory length */
-	case H_MEM_ACCESS_PARM:      /* invalid access controls */
 	case H_CONSTRAINED:          /* resource constraint */
-		return -EINVAL;
+	case H_NO_MEM:
+		return -ENOMEM;
 	case H_BUSY:                 /* long busy */
 		return -EBUSY;
 	default:
