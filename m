Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 128C5DDEDE
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 01:11:41 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m45FBZQK012223
	for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2008 11:11:35 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m45FBZcx191546
	for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2008 11:11:35 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m45FBZmn018334
	for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2008 11:11:35 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>,
	"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: Change function return types to correct type.
Date: Mon, 5 May 2008 17:11:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200805051711.15281.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also remove duplicate assignment of local_ca_ack_delay
and change min_t check for local_ca_ack_delay to u8 instead of int.

Signed-off-by: Stefan Roscher <stefan.roscher at de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_hca.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
index 2515cbd..bc3b37d 100644
--- a/drivers/infiniband/hw/ehca/ehca_hca.c
+++ b/drivers/infiniband/hw/ehca/ehca_hca.c
@@ -101,7 +101,6 @@ int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props)
 	props->max_ee          = limit_uint(rblock->max_rd_ee_context);
 	props->max_rdd         = limit_uint(rblock->max_rd_domain);
 	props->max_fmr         = limit_uint(rblock->max_mr);
-	props->local_ca_ack_delay  = limit_uint(rblock->local_ca_ack_delay);
 	props->max_qp_rd_atom  = limit_uint(rblock->max_rr_qp);
 	props->max_ee_rd_atom  = limit_uint(rblock->max_rr_ee_context);
 	props->max_res_rd_atom = limit_uint(rblock->max_rr_hca);
@@ -115,7 +114,7 @@ int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props)
 	}
 
 	props->max_pkeys           = 16;
-	props->local_ca_ack_delay  = limit_uint(rblock->local_ca_ack_delay);
+	props->local_ca_ack_delay  = min_t(u8, rblock->local_ca_ack_delay, 255);
 	props->max_raw_ipv6_qp     = limit_uint(rblock->max_raw_ipv6_qp);
 	props->max_raw_ethy_qp     = limit_uint(rblock->max_raw_ethy_qp);
 	props->max_mcast_grp       = limit_uint(rblock->max_mcast_grp);
@@ -136,7 +135,7 @@ query_device1:
 	return ret;
 }
 
-static int map_mtu(struct ehca_shca *shca, u32 fw_mtu)
+static enum ib_mtu map_mtu(struct ehca_shca *shca, u32 fw_mtu)
 {
 	switch (fw_mtu) {
 	case 0x1:
@@ -156,7 +155,7 @@ static int map_mtu(struct ehca_shca *shca, u32 fw_mtu)
 	}
 }
 
-static int map_number_of_vls(struct ehca_shca *shca, u32 vl_cap)
+static u8 map_number_of_vls(struct ehca_shca *shca, u32 vl_cap)
 {
 	switch (vl_cap) {
 	case 0x1:
-- 
1.5.5
