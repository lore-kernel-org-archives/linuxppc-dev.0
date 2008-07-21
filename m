Return-Path: <fenkes@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D8582DDEFA
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 21:16:44 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m6LBGdIY051600
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 11:16:39 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6LBGcWI2633870
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 12:16:38 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6LBGbA7000843
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 12:16:38 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 2/2] IB/ehca: Default value for Local CA ACK Delay
References: <200807211313.23648.fenkes@de.ibm.com>
In-Reply-To: <200807211313.23648.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Mon, 21 Jul 2008 13:16:36 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807211316.37224.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Alexander Schmidt <alexschm@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some firmware versions report a Local CA ACK Delay of 0. In that case,
return a more sensible default value of 12 (-> 16 msec) instead.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_hca.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
index bc3b37d..4628822 100644
--- a/drivers/infiniband/hw/ehca/ehca_hca.c
+++ b/drivers/infiniband/hw/ehca/ehca_hca.c
@@ -114,7 +114,9 @@ int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props)
 	}
 
 	props->max_pkeys           = 16;
-	props->local_ca_ack_delay  = min_t(u8, rblock->local_ca_ack_delay, 255);
+	/* Some FW versions say 0 here; insert sensible value in that case */
+	props->local_ca_ack_delay  = rblock->local_ca_ack_delay ?
+		min_t(u8, rblock->local_ca_ack_delay, 255) : 12;
 	props->max_raw_ipv6_qp     = limit_uint(rblock->max_raw_ipv6_qp);
 	props->max_raw_ethy_qp     = limit_uint(rblock->max_raw_ethy_qp);
 	props->max_mcast_grp       = limit_uint(rblock->max_mcast_grp);
-- 
1.5.5
