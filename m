Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D8C8DDF78
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 23:33:48 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8BDXhIA180228
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 13:33:43 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8BDXgY62265206
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 15:33:43 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8BDXfBW008706
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 15:33:42 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 09/12] IB/ehca: Add check for max #SGE to create_qp()
References: <200709111518.26276.fenkes@de.ibm.com>
In-Reply-To: <200709111518.26276.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Tue, 11 Sep 2007 15:33:40 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709111533.41250.fenkes@de.ibm.com>
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

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_qp.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index d2ab84a..7154f62 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -513,7 +513,7 @@ static struct ehca_qp *internal_create_qp(
 			} else if (init_attr->cap.max_send_wr > 255) {
 				ehca_err(pd->device,
 					 "Invalid Number of "
-					 "ax_send_wr=%x for UD QP_TYPE=%x",
+					 "max_send_wr=%x for UD QP_TYPE=%x",
 					 init_attr->cap.max_send_wr, qp_type);
 				return ERR_PTR(-EINVAL);
 			}
@@ -524,6 +524,18 @@ static struct ehca_qp *internal_create_qp(
 			return ERR_PTR(-EINVAL);
 			break;
 		}
+	} else {
+		int max_sge = (qp_type == IB_QPT_UD || qp_type == IB_QPT_SMI
+			       || qp_type == IB_QPT_GSI) ? 250 : 252;
+
+		if (init_attr->cap.max_send_sge > max_sge
+		    || init_attr->cap.max_recv_sge > max_sge) {
+			ehca_err(pd->device, "Invalid number of SGEs requested "
+				 "send_sge=%x recv_sge=%x max_sge=%x",
+				 init_attr->cap.max_send_sge,
+				 init_attr->cap.max_recv_sge, max_sge);
+			return ERR_PTR(-EINVAL);
+		}
 	}
 
 	if (pd->uobject && udata)
-- 
1.5.2
