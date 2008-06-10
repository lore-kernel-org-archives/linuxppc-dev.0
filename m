Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DCF98DDF11
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 00:45:00 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5AEl4tp020727
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 10:47:04 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5AEibVV207696
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 10:44:37 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5AEiadO004841
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 10:44:37 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rolandd@cisco.com>, Paul Mackerras <paulus@samba.org>,
	"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-EWG" <ewg@lists.openfabrics.org>, general@lists.openfabrics.org
Subject: [PATCH REPOST] IB/ehca: In case of lost interrupts,
	trigger EOI to reenable interrupts
Date: Tue, 10 Jun 2008 16:44:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200806101644.34693.ossrosch@linux.vnet.ibm.com>
Cc: TKLEIN@de.ibm.com, fenkes@de.ibm.com, raisch@de.ibm.com, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

During corner case testing, we noticed that some versions of ehca 
do not properly transition to interrupt done in special load situations.
This can be resolved by periodically triggering EOI through H_EOI, 
if eqes are pending.

Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>

---
This patch replaces my previous patch-set.
As Paul suggested, this version of the patch calls H_EOI directly and doesn't need
any ibmebus changes.
 
 drivers/infiniband/hw/ehca/ehca_main.c |   11 +++++++++--
 drivers/infiniband/hw/ehca/hcp_if.c    |   11 +++++++++++
 drivers/infiniband/hw/ehca/hcp_if.h    |    1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 482103e..add4ff4 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -937,6 +937,7 @@ static struct of_platform_driver ehca_driver = {
 void ehca_poll_eqs(unsigned long data)
 {
 	struct ehca_shca *shca;
+	u64 ret;
 
 	spin_lock(&shca_list_lock);
 	list_for_each_entry(shca, &shca_list, shca_list) {
@@ -955,8 +956,14 @@ void ehca_poll_eqs(unsigned long data)
 				spin_unlock_irqrestore(&eq->spinlock, flags);
 				max--;
 			} while (q_ofs == q_ofs2 && max > 0);
-			if (q_ofs == q_ofs2)
-				ehca_process_eq(shca, 0);
+			if (q_ofs == q_ofs2) {
+				ret = hipz_h_eoi(eq->ist);
+				if (ret != H_SUCCESS)
+					ehca_err(&shca->ib_device,
+						 "bad return code EOI -"
+						 "rc = %ld\n", ret);
+				tasklet_hi_schedule(&shca->eq.interrupt_task);
+			}
 		}
 	}
 	mod_timer(&poll_eqs_timer, round_jiffies(jiffies + HZ));
diff --git a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
index 5245e13..7084efd 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -933,3 +933,14 @@ u64 hipz_h_error_data(const struct ipz_adapter_handle adapter_handle,
 				       r_cb,
 				       0, 0, 0, 0);
 }
+
+u64 hipz_h_eoi(int irq)
+{
+	int value;
+	unsigned long xirr;
+
+	iosync();
+	value = (0xff << 24) | irq;
+	xirr = value & 0xffffffff;
+	return plpar_hcall_norets(H_EOI, xirr);
+}
diff --git a/drivers/infiniband/hw/ehca/hcp_if.h b/drivers/infiniband/hw/ehca/hcp_if.h
index 60ce02b..2c3c6e0 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.h
+++ b/drivers/infiniband/hw/ehca/hcp_if.h
@@ -260,5 +260,6 @@ u64 hipz_h_error_data(const struct ipz_adapter_handle adapter_handle,
 		      const u64 ressource_handle,
 		      void *rblock,
 		      unsigned long *byte_count);
+u64 hipz_h_eoi(int irq);
 
 #endif /* __HCP_IF_H__ */
-- 
1.5.5
