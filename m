Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DBA1BDDF5E
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 03:07:04 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1FG6g8W208924
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 16:06:42 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1FG6ggh1798358
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 17:06:42 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1FG6WRm016355
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 17:06:40 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org, hch@infradead.org,
	bos@pathscale.com
Subject: [PATCH 2.6.21-rc1 5/5] ehca: query_port() returns LINK_UP instead
	UNKNOWN
Date: Thu, 15 Feb 2007 17:10:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702151710.06432.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

set port phys state as a result of ehca_query_port() to LINK_UP.
On pSeries ehca actually represents a logical HCA, whose phys/link state 
always is LINK_UP.


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_hca.c |    3 +++
 1 files changed, 3 insertions(+)


diff --git a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
index b7be950..30eb45d 100644
--- a/drivers/infiniband/hw/ehca/ehca_hca.c
+++ b/drivers/infiniband/hw/ehca/ehca_hca.c
@@ -162,6 +162,9 @@ int ehca_query_port(struct ib_device *ib
 	props->active_width    = IB_WIDTH_12X;
 	props->active_speed    = 0x1;
 
+	/* at the moment (logical) link state is always LINK_UP */
+	props->phys_state      = 0x5;
+
 query_port1:
 	ehca_free_fw_ctrlblock(rblock);
 
