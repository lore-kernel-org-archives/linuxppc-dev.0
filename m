Return-Path: <osstklei@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D7CB67D9F
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 03:48:36 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id kA3GmO7J109670
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 16:48:27 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kA3GpMGS3055776
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 17:51:22 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kA3GmNFg031342
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 17:48:24 +0100
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.19-rc4 3/3] ehea: 64K page support fix
Date: Fri, 3 Nov 2006 17:48:23 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200611031748.23785.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes 64k page support by using PAGE_MASK and appropriate pagesize defines in several places.

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
----
 drivers/net/ehea/ehea_ethtool.c |    2 +-
 drivers/net/ehea/ehea_main.c    |   26 +++++++++++++-------------
 drivers/net/ehea/ehea_phyp.c    |    2 +-
 drivers/net/ehea/ehea_phyp.h    |    6 ++++--
 drivers/net/ehea/ehea_qmr.c     |   13 +++++++------
 5 files changed, 26 insertions(+), 23 deletions(-)

diff -Nurp git.linux-2.6.base/drivers/net/ehea/ehea_ethtool.c git.linux-2.6/drivers/net/ehea/ehea_ethtool.c
--- git.linux-2.6.base/drivers/net/ehea/ehea_ethtool.c	2006-11-03 16:41:36.000000000 +0100
+++ git.linux-2.6/drivers/net/ehea/ehea_ethtool.c	2006-11-03 12:43:16.000000000 +0100
@@ -238,7 +238,7 @@ static void ehea_get_ethtool_stats(struc
 	data[i++] = port->port_res[0].swqe_refill_th;
 	data[i++] = port->resets;
 
-	cb6 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb6 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb6) {
 		ehea_error("no mem for cb6");
 		return;
diff -Nurp git.linux-2.6.base/drivers/net/ehea/ehea_main.c git.linux-2.6/drivers/net/ehea/ehea_main.c
--- git.linux-2.6.base/drivers/net/ehea/ehea_main.c	2006-11-03 16:41:36.000000000 +0100
+++ git.linux-2.6/drivers/net/ehea/ehea_main.c	2006-11-03 12:43:16.000000000 +0100
@@ -92,7 +92,7 @@ static struct net_device_stats *ehea_get
 
 	memset(stats, 0, sizeof(*stats));
 
-	cb2 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb2 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb2) {
 		ehea_error("no mem for cb2");
 		goto out;
@@ -586,8 +586,8 @@ int ehea_sense_port_attr(struct ehea_por
 	u64 hret;
 	struct hcp_ehea_port_cb0 *cb0;
 
-	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_ATOMIC);   /* May be called via */
-	if (!cb0) {                                  /* ehea_neq_tasklet() */
+	cb0 = kzalloc(PAGE_SIZE, GFP_ATOMIC);   /* May be called via */
+	if (!cb0) {                             /* ehea_neq_tasklet() */
 		ehea_error("no mem for cb0");
 		ret = -ENOMEM;
 		goto out;
@@ -670,7 +670,7 @@ int ehea_set_portspeed(struct ehea_port 
 	u64 hret;
 	int ret = 0;
 
-	cb4 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb4 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb4) {
 		ehea_error("no mem for cb4");
 		ret = -ENOMEM;
@@ -985,7 +985,7 @@ static int ehea_configure_port(struct eh
 	struct hcp_ehea_port_cb0 *cb0;
 
 	ret = -ENOMEM;
-	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb0 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb0)
 		goto out;
 
@@ -1443,7 +1443,7 @@ static int ehea_set_mac_addr(struct net_
 		goto out;
 	}
 
-	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb0 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb0) {
 		ehea_error("no mem for cb0");
 		ret = -ENOMEM;
@@ -1501,7 +1501,7 @@ static void ehea_promiscuous(struct net_
 	if ((enable && port->promisc) || (!enable && !port->promisc))
 		return;
 
-	cb7 = kzalloc(H_CB_ALIGNMENT, GFP_ATOMIC);
+	cb7 = kzalloc(PAGE_SIZE, GFP_ATOMIC);
 	if (!cb7) {
 		ehea_error("no mem for cb7");
 		goto out;
@@ -1870,7 +1870,7 @@ static void ehea_vlan_rx_register(struct
 
 	port->vgrp = grp;
 
-	cb1 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb1 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb1) {
 		ehea_error("no mem for cb1");
 		goto out;
@@ -1899,7 +1899,7 @@ static void ehea_vlan_rx_add_vid(struct 
 	int index;
 	u64 hret;
 
-	cb1 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb1 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb1) {
 		ehea_error("no mem for cb1");
 		goto out;
@@ -1935,7 +1935,7 @@ static void ehea_vlan_rx_kill_vid(struct
 	if (port->vgrp)
 		port->vgrp->vlan_devices[vid] = NULL;
 
-	cb1 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb1 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb1) {
 		ehea_error("no mem for cb1");
 		goto out;
@@ -1968,7 +1968,7 @@ int ehea_activate_qp(struct ehea_adapter
 	u64 dummy64 = 0;
 	struct hcp_modify_qp_cb0* cb0;
 
-	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb0 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb0) {
 		ret = -ENOMEM;
 		goto out;
@@ -2269,7 +2269,7 @@ int ehea_sense_adapter_attr(struct ehea_
 	u64 hret;
 	int ret;
 
-	cb = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb) {
 		ret = -ENOMEM;
 		goto out;
@@ -2340,7 +2340,7 @@ static int ehea_setup_single_port(struct
 		goto out;
 
 	/* Enable Jumbo frames */
-	cb4 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb4 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb4) {
 		ehea_error("no mem for cb4");
 	} else {
diff -Nurp git.linux-2.6.base/drivers/net/ehea/ehea_phyp.c git.linux-2.6/drivers/net/ehea/ehea_phyp.c
--- git.linux-2.6.base/drivers/net/ehea/ehea_phyp.c	2006-11-03 16:41:36.000000000 +0100
+++ git.linux-2.6/drivers/net/ehea/ehea_phyp.c	2006-11-03 12:43:16.000000000 +0100
@@ -506,7 +506,7 @@ u64 ehea_h_register_rpage_mr(const u64 a
 			     const u8 pagesize, const u8 queue_type,
 			     const u64 log_pageaddr, const u64 count)
 {
-	if ((count > 1) && (log_pageaddr & 0xfff)) {
+	if ((count > 1) && (log_pageaddr & ~PAGE_MASK)) {
 		ehea_error("not on pageboundary");
 		return H_PARAMETER;
 	}
diff -Nurp git.linux-2.6.base/drivers/net/ehea/ehea_phyp.h git.linux-2.6/drivers/net/ehea/ehea_phyp.h
--- git.linux-2.6.base/drivers/net/ehea/ehea_phyp.h	2006-11-03 16:41:36.000000000 +0100
+++ git.linux-2.6/drivers/net/ehea/ehea_phyp.h	2006-11-03 12:43:16.000000000 +0100
@@ -81,14 +81,16 @@ static inline u32 get_longbusy_msecs(int
 static inline void hcp_epas_ctor(struct h_epas *epas, u64 paddr_kernel,
 				 u64 paddr_user)
 {
-	epas->kernel.addr = ioremap(paddr_kernel, PAGE_SIZE);
+	/* To support 64k pages we must round to 64k page boundary */
+	epas->kernel.addr = ioremap((paddr_kernel & PAGE_MASK), PAGE_SIZE) +
+			    (paddr_kernel & ~PAGE_MASK);
 	epas->user.addr = paddr_user;
 }
 
 static inline void hcp_epas_dtor(struct h_epas *epas)
 {
 	if (epas->kernel.addr)
-		iounmap(epas->kernel.addr);
+		iounmap((void __iomem*)((u64)epas->kernel.addr & PAGE_MASK));
 
 	epas->user.addr = 0;
 	epas->kernel.addr = 0;
diff -Nurp git.linux-2.6.base/drivers/net/ehea/ehea_qmr.c git.linux-2.6/drivers/net/ehea/ehea_qmr.c
--- git.linux-2.6.base/drivers/net/ehea/ehea_qmr.c	2006-11-03 17:04:11.000000000 +0100
+++ git.linux-2.6/drivers/net/ehea/ehea_qmr.c	2006-11-03 12:43:16.000000000 +0100
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
