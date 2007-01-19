Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 099FBDDDF9
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jan 2007 12:11:50 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0JLsif4139854
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 21:54:44 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0JLshsQ2990154
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 22:54:43 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0JLshJH023920
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 22:54:43 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openfabrics-ewg@openib.org,
	openib-general@openib.org
Subject: [PATCH 2.6.20 2/2] ehca: ehca_irq.c: fix mismatched spin_unlock in
	irq handler
Date: Fri, 19 Jan 2007 22:51:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701192251.01888.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Roland!
This is a patch for ehca_irq.c that fixes an unproper use of spin_unlock
in irq handler.
Thanks
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_irq.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index e7209af..93788d8 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -440,7 +440,7 @@ void ehca_tasklet_eq(unsigned long data)
 					cq = idr_find(&ehca_cq_idr, token);
 
 					if (cq == NULL) {
-						spin_unlock(&ehca_cq_idr_lock);
+						spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 						break;
 					}
 
