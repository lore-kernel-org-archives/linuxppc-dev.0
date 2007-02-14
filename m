Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 15E7ADE15C
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 03:45:15 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1EGjBfT044314
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:45:11 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1EGjBY61687604
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 17:45:11 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1EGjAxW027053
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 17:45:11 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: rolandd@cisco.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openib-general@openib.org, hch@infradead.org
Subject: [PATCH 2.6.21-rc1 5/5] ehca: query_port() returns LINK_UP instead
	UNKNOWN
Date: Wed, 14 Feb 2007 17:41:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702141741.45135.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com, h.carstens@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
this patch sets port phys state as a result of ehca_query_port() to LINK_UP.
On pSeries ehca actually represents a logical HCA, whose phys/link state always
is LINK_UP. 
Thanks
Nam


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_hca.c |    3 +++
 1 files changed, 3 insertions(+)


diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_hca.c infiniband_work/drivers/infiniband/hw/ehca/ehca_hca.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_hca.c       2007-02-14 13:11:45.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_hca.c       2007-02-14 12:53:52.000000000 +0100
@@ -162,6 +162,9 @@ int ehca_query_port(struct ib_device *ib
        props->active_width    = IB_WIDTH_12X;
        props->active_speed    = 0x1;

+       /* at the moment (logical) link state is always LINK_UP */
+       props->phys_state      = 0x5;
+
 query_port1:
        ehca_free_fw_ctrlblock(rblock);
