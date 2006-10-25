Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F256167D82
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 22:01:36 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id k9PC1Wcv128518
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 12:01:32 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k9PC477h2519188
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 13:04:07 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k9PC1VHh009942
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 13:01:31 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 2.6.19-rc3 2/2] ehea: 64K page support fix
Date: Wed, 25 Oct 2006 13:12:01 +0200
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200610251312.01235.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the 64K page support

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
---
 drivers/net/ehea/ehea.h      |    2 +-
 drivers/net/ehea/ehea_phyp.h |   14 +++++++++++++-
 drivers/net/ehea/ehea_qmr.c  |   13 +++++++------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index b40724f..cd412b5 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -39,7 +39,7 @@ #include <asm/abs_addr.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0034"
+#define DRV_VERSION	"EHEA_0040"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
diff --git a/drivers/net/ehea/ehea_phyp.h b/drivers/net/ehea/ehea_phyp.h
index fa51e3b..59ab646 100644
--- a/drivers/net/ehea/ehea_phyp.h
+++ b/drivers/net/ehea/ehea_phyp.h
@@ -81,15 +81,27 @@ #define NELR_PORTSTATE_CHG	EHEA_BMASK_IB
 static inline void hcp_epas_ctor(struct h_epas *epas, u64 paddr_kernel,
 				 u64 paddr_user)
 {
+#ifdef CONFIG_PPC_64K_PAGES
+	/* To support 64k pages we must round to 64k page boundary */
+	epas->kernel.addr =
+		ioremap((paddr_kernel & 0xFFFFFFFFFFFF0000), PAGE_SIZE) +
+		(paddr_kernel & 0xFFFF);
+#else
 	epas->kernel.addr = ioremap(paddr_kernel, PAGE_SIZE);
+#endif
 	epas->user.addr = paddr_user;
 }
 
 static inline void hcp_epas_dtor(struct h_epas *epas)
 {
+#ifdef CONFIG_PPC_64K_PAGES
+	if (epas->kernel.addr)
+		iounmap((void __iomem*)((u64)epas->kernel.addr &
+					0xFFFFFFFFFFFF0000));
+#else
 	if (epas->kernel.addr)
 		iounmap(epas->kernel.addr);
-
+#endif
 	epas->user.addr = 0;
 	epas->kernel.addr = 0;
 }
diff --git a/drivers/net/ehea/ehea_qmr.c b/drivers/net/ehea/ehea_qmr.c
index 3e18623..3daedfa 100644
--- a/drivers/net/ehea/ehea_qmr.c
+++ b/drivers/net/ehea/ehea_qmr.c
@@ -512,7 +512,7 @@ int ehea_reg_mr_adapter(struct ehea_adap
 
 	start = KERNELBASE;
 	end = (u64)high_memory;
-	nr_pages = (end - start) / PAGE_SIZE;
+	nr_pages = (end - start) / EHEA_PAGESIZE;
 
 	pt =  kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!pt) {
@@ -538,9 +538,9 @@ int ehea_reg_mr_adapter(struct ehea_adap
 		if (nr_pages > 1) {
 			u64 num_pages = min(nr_pages, (u64)512);
 			for (i = 0; i < num_pages; i++)
-				pt[i] = virt_to_abs((void*)(((u64)start)
-							     + ((k++) *
-								PAGE_SIZE)));
+				pt[i] = virt_to_abs((void*)(((u64)start) +
+							    ((k++) *
+							     EHEA_PAGESIZE)));
 
 			hret = ehea_h_register_rpage_mr(adapter->handle,
 							adapter->mr.handle, 0,
@@ -548,8 +548,9 @@ int ehea_reg_mr_adapter(struct ehea_adap
 							num_pages);
 			nr_pages -= num_pages;
 		} else {
-			u64 abs_adr = virt_to_abs((void*)(((u64)start)
-							   + (k * PAGE_SIZE)));
+			u64 abs_adr = virt_to_abs((void*)(((u64)start) +
+							  (k * EHEA_PAGESIZE)));
+
 			hret = ehea_h_register_rpage_mr(adapter->handle,
 							adapter->mr.handle, 0,
 							0, abs_adr,1);
