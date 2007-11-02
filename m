Return-Path: <fenkes@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6FCFDDDDF5
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Nov 2007 00:34:25 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id lA2DYLa0094912
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 13:34:21 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id lA2DYKm12130138
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 13:34:20 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lA2DY2A5021721
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 13:34:03 GMT
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 1/2] IB/ehca: Return physical link information in query_port()
Date: Fri, 2 Nov 2007 15:33:51 +0200
References: <200711021432.50203.fenkes@de.ibm.com>
In-Reply-To: <200711021432.50203.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711021433.51565.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Newer firmware versions return physical port information to the partition,
so hand that information to the consumer if it's present.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_hca.c |   20 ++++++++++++++------
 drivers/infiniband/hw/ehca/hipz_hw.h  |    6 +++++-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
index 15806d1..5bd7b59 100644
--- a/drivers/infiniband/hw/ehca/ehca_hca.c
+++ b/drivers/infiniband/hw/ehca/ehca_hca.c
@@ -151,7 +151,6 @@ int ehca_query_port(struct ib_device *ibdev,
 	}
 
 	memset(props, 0, sizeof(struct ib_port_attr));
-	props->state = rblock->state;
 
 	switch (rblock->max_mtu) {
 	case 0x1:
@@ -188,11 +187,20 @@ int ehca_query_port(struct ib_device *ibdev,
 	props->subnet_timeout  = rblock->subnet_timeout;
 	props->init_type_reply = rblock->init_type_reply;
 
-	props->active_width    = IB_WIDTH_12X;
-	props->active_speed    = 0x1;
-
-	/* at the moment (logical) link state is always LINK_UP */
-	props->phys_state      = 0x5;
+	if (rblock->state && rblock->phys_width) {
+		props->phys_state      = rblock->phys_pstate;
+		props->state           = rblock->phys_state;
+		props->active_width    = rblock->phys_width;
+		props->active_speed    = rblock->phys_speed;
+	} else {
+		/* old firmware releases don't report physical
+		 * port info, so use default values
+		 */
+		props->phys_state      = 5;
+		props->state           = rblock->state;
+		props->active_width    = IB_WIDTH_12X;
+		props->active_speed    = 0x1;
+	}
 
 query_port1:
 	ehca_free_fw_ctrlblock(rblock);
diff --git a/drivers/infiniband/hw/ehca/hipz_hw.h b/drivers/infiniband/hw/ehca/hipz_hw.h
index d9739e5..485b840 100644
--- a/drivers/infiniband/hw/ehca/hipz_hw.h
+++ b/drivers/infiniband/hw/ehca/hipz_hw.h
@@ -402,7 +402,11 @@ struct hipz_query_port {
 	u64 max_msg_sz;
 	u32 max_mtu;
 	u32 vl_cap;
-	u8  reserved2[1900];
+	u32 phys_pstate;
+	u32 phys_state;
+	u32 phys_speed;
+	u32 phys_width;
+	u8  reserved2[1884];
 	u64 guid_entries[255];
 } __attribute__ ((packed));
 
-- 
1.5.2
