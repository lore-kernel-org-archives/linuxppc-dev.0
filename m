Return-Path: <fenkes@de.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E69FBDDE29
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 00:47:08 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id lASDl28e359556
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 13:47:02 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lASDl2Oc3043538
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 13:47:02 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lASDkjqr011920
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 13:46:46 GMT
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: Fix static rate if path faster than link
MIME-Version: 1.0
Date: Wed, 28 Nov 2007 15:46:28 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711281446.29085.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The formula would yield -1 for this, which is wrong in a bad way (max
throttling). Clamp to 0, which is the correct value.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---

This fixes another regression introduced in rc3.
Please review and apply for 2.6.24-rc4. Thanks!

 drivers/infiniband/hw/ehca/ehca_av.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_av.c b/drivers/infiniband/hw/ehca/ehca_av.c
index 453eb99..f7782c8 100644
--- a/drivers/infiniband/hw/ehca/ehca_av.c
+++ b/drivers/infiniband/hw/ehca/ehca_av.c
@@ -76,8 +76,12 @@ int ehca_calc_ipd(struct ehca_shca *shca, int port,
 
 	link = ib_width_enum_to_int(pa.active_width) * pa.active_speed;
 
-	/* IPD = round((link / path) - 1) */
-	*ipd = ((link + (path >> 1)) / path) - 1;
+	if (path >= link)
+		/* no need to throttle if path faster than link */
+		*ipd = 0;
+	else
+		/* IPD = round((link / path) - 1) */
+		*ipd = ((link + (path >> 1)) / path) - 1;
 
 	return 0;
 }
-- 
1.5.2
