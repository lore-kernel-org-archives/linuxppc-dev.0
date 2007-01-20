Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B2555DDDE7
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jan 2007 02:24:02 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0KFNvHD126398
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jan 2007 15:23:57 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0KFNviV1560700
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jan 2007 15:23:57 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0KFNujL018379
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jan 2007 15:23:57 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openfabrics-ewg@openib.org,
	openib-general@openib.org
Subject: Re: [PATCH 2.6.20 2/2] ehca: ehca_irq.c: fix mismatched spin_unlock
	in irq handler
Date: Sat, 20 Jan 2007 16:20:15 +0100
References: <200701192251.01888.hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200701192251.01888.hnguyen@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701201620.16097.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hmm, code line too long. please ignore the previous patch. here is the one
with correct length of code line.
Thanks
Nam


This is a patch for ehca_irq.c that fixes an unproper use of spin_unlock
in irq handler.


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_irq.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index e7209af..fd1a5fb 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -440,7 +440,9 @@ void ehca_tasklet_eq(unsigned long data)
 					cq = idr_find(&ehca_cq_idr, token);
 
 					if (cq == NULL) {
-						spin_unlock(&ehca_cq_idr_lock);
+						spin_unlock_irqrestore(
+							&ehca_cq_idr_lock,
+							flags);
 						break;
 					}
 
