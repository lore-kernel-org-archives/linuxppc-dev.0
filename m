Return-Path: <fenkes@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B299DDE1D
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 01:49:08 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l6CFn3o7245726
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 15:49:03 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l6CFllD83006508
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 16:47:47 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6CFlkrY005651
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 16:47:47 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 02/10] IB/ehca: Fix HW level autodetection
References: <200707121745.27592.fenkes@de.ibm.com>
In-Reply-To: <200707121745.27592.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Thu, 12 Jul 2007 17:47:45 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707121747.46618.fenkes@de.ibm.com>
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

Autodetection was missing a few HW revisions, causing certain eHCA1
revisions to be treated like eHCA2. Fixed.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_main.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index d9a37dc..57c551e 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -282,22 +282,27 @@ int ehca_sense_attributes(struct ehca_shca *shca)
 
 		ehca_gen_dbg(" ... hardware version=%x:%x", hcaaver, revid);
 
-		if ((hcaaver == 1) && (revid == 0))
-			shca->hw_level = 0x11;
-		else if ((hcaaver == 1) && (revid == 1))
-			shca->hw_level = 0x12;
-		else if ((hcaaver == 1) && (revid == 2))
-			shca->hw_level = 0x13;
-		else if ((hcaaver == 2) && (revid == 0))
-			shca->hw_level = 0x21;
-		else if ((hcaaver == 2) && (revid == 0x10))
-			shca->hw_level = 0x22;
-		else {
+		if (hcaaver == 1) {
+			if (revid <= 3)
+				shca->hw_level = 0x10 | (revid + 1);
+			else
+				shca->hw_level = 0x14;
+		} else if (hcaaver == 2) {
+			if (revid == 0)
+				shca->hw_level = 0x21;
+			else if (revid == 0x10)
+				shca->hw_level = 0x22;
+			else if (revid == 0x20 || revid == 0x21)
+				shca->hw_level = 0x23;
+		}
+
+		if (!shca->hw_level) {
 			ehca_gen_warn("unknown hardware version"
 				      " - assuming default level");
 			shca->hw_level = 0x22;
 		}
-	}
+	} else
+		shca->hw_level = ehca_hw_level;
 	ehca_gen_dbg(" ... hardware level=%x", shca->hw_level);
 
 	shca->sport[0].rate = IB_RATE_30_GBPS;
-- 
1.5.2
