Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F667DE450
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 23:36:06 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id lBDCa1MM282560
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 12:36:01 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lBDCa1mE2973852
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 13:36:01 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lBDCa0ko023253
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 13:36:00 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: Fix lock flag location, bump version number
MIME-Version: 1.0
Date: Thu, 13 Dec 2007 13:35:57 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712131335.58136.fenkes@de.ibm.com>
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

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---

This addresses a comment of Roland and bumps the version number. If it's not
too late, please apply for 2.6.24. Thanks!

 drivers/infiniband/hw/ehca/ehca_classes.h |    1 +
 drivers/infiniband/hw/ehca/ehca_main.c    |    2 +-
 drivers/infiniband/hw/ehca/hcp_if.c       |    1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 87f12d4..74d2b72 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -322,6 +322,7 @@ extern int ehca_static_rate;
 extern int ehca_port_act_time;
 extern int ehca_use_hp_mr;
 extern int ehca_scaling_code;
+extern int ehca_lock_hcalls;
 
 struct ipzu_queue_resp {
 	u32 qe_size;      /* queue entry size */
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index c7bff3e..6a56d86 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -50,7 +50,7 @@
 #include "ehca_tools.h"
 #include "hcp_if.h"
 
-#define HCAD_VERSION "0024"
+#define HCAD_VERSION "0025"
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
diff --git a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
index 331b5e8..7029aa6 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -89,7 +89,6 @@
 #define HCALL9_REGS_FORMAT HCALL7_REGS_FORMAT " r11=%lx r12=%lx"
 
 static DEFINE_SPINLOCK(hcall_lock);
-extern int ehca_lock_hcalls;
 
 static u32 get_longbusy_msecs(int longbusy_rc)
 {
-- 
1.5.2
