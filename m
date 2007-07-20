Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 202F2DE185
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 23:51:25 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6KDp29p119892
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 13:51:02 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6KDp2132007168
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 15:51:02 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6KDotuQ028974
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 15:50:55 +0200
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org
Subject: [PATCH 3/5] ehca: Make ehca2ib_return_code() non-inline
Date: Fri, 20 Jul 2007 16:02:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707201602.46415.hnguyen@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, raisch@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Joachim Fenkes <fenkes@de.ibm.com>
Date: Thu, 19 Jul 2007 21:13:57 +0200
Subject: [PATCH 3/5] IB/ehca: Make ehca2ib_return_code() non-inline

It's nowhere in the main path and making it non-inline saves ~1.5K of code.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_main.c  |   17 +++++++++++++++++
 drivers/infiniband/hw/ehca/ehca_tools.h |   19 +------------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 34661c3..3bd7afb 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -130,6 +130,23 @@ void ehca_free_fw_ctrlblock(void *ptr)
 }
 #endif
 
+int ehca2ib_return_code(u64 ehca_rc)
+{
+	switch (ehca_rc) {
+	case H_SUCCESS:
+		return 0;
+	case H_RESOURCE:             /* Resource in use */
+	case H_BUSY:
+		return -EBUSY;
+	case H_NOT_ENOUGH_RESOURCES: /* insufficient resources */
+	case H_CONSTRAINED:          /* resource constraint */
+	case H_NO_MEM:
+		return -ENOMEM;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ehca_create_slab_caches(void)
 {
 	int ret;
diff --git a/drivers/infiniband/hw/ehca/ehca_tools.h b/drivers/infiniband/hw/ehca/ehca_tools.h
index 678b813..57c77a7 100644
--- a/drivers/infiniband/hw/ehca/ehca_tools.h
+++ b/drivers/infiniband/hw/ehca/ehca_tools.h
@@ -154,24 +154,7 @@ extern int ehca_debug_level;
 #define EHCA_BMASK_GET(mask, value) \
 	(EHCA_BMASK_MASK(mask) & (((u64)(value)) >> EHCA_BMASK_SHIFTPOS(mask)))
 
-
 /* Converts ehca to ib return code */
-static inline int ehca2ib_return_code(u64 ehca_rc)
-{
-	switch (ehca_rc) {
-	case H_SUCCESS:
-		return 0;
-	case H_RESOURCE:             /* Resource in use */
-	case H_BUSY:
-		return -EBUSY;
-	case H_NOT_ENOUGH_RESOURCES: /* insufficient resources */
-	case H_CONSTRAINED:          /* resource constraint */
-	case H_NO_MEM:
-		return -ENOMEM;
-	default:
-		return -EINVAL;
-	}
-}
-
+int ehca2ib_return_code(u64 ehca_rc);
 
 #endif /* EHCA_TOOLS_H */
-- 
1.5.2
