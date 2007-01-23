Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12CE9DDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 10:16:17 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0NNGCo6097752
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 23:16:12 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0NNGBqO2449652
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 00:16:11 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0NNGBVx008561
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 00:16:11 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openib-general@openib.org, openfabrics-ewg@openib.org
Subject: [PATCH 2.6.21 2/4] ehca: fix mismatched use of spin_unlock in irq
	handler
Date: Wed, 24 Jan 2007 00:12:30 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701240012.31621.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a patch for ehca_irq.c that fixes mismatched use of spin_unlock
in irq handler.
Thanks
Nam


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_irq.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_irq.c infiniband_work/drivers/infiniband/hw/ehca/ehca_irq.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_irq.c	2007-01-19 19:40:32.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_irq.c	2007-01-23 22:38:02.000000000 +0100
@@ -440,7 +440,8 @@ void ehca_tasklet_eq(unsigned long data)
 					cq = idr_find(&ehca_cq_idr, token);
 
 					if (cq == NULL) {
-						spin_unlock(&ehca_cq_idr_lock);
+						spin_unlock_irqrestore(&ehca_cq_idr_lock,
+								       flags);
 						break;
 					}
 
