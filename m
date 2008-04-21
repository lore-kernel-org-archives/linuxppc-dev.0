Return-Path: <fenkes@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12948DE1BF
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 18:06:15 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m3L869nX155154
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 08:06:09 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m3L869l02158722
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 09:06:09 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m3L869lD008269
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 08:06:09 GMT
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 3/5] IB/ehca: Remove mr_largepage parameter
References: <200804211003.10695.fenkes@de.ibm.com>
In-Reply-To: <200804211003.10695.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Mon, 21 Apr 2008 09:06:08 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804211006.08849.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Always enable large page support; didn't seem to cause problems for anyone.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_main.c |   22 +++-------------------
 1 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 4379bef..ab02ac8 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -60,7 +60,6 @@ MODULE_VERSION(HCAD_VERSION);
 static int ehca_open_aqp1     = 0;
 static int ehca_hw_level      = 0;
 static int ehca_poll_all_eqs  = 1;
-static int ehca_mr_largepage  = 1;
 
 int ehca_debug_level   = 0;
 int ehca_nr_ports      = 2;
@@ -79,7 +78,6 @@ module_param_named(port_act_time, ehca_port_act_time, int, S_IRUGO);
 module_param_named(poll_all_eqs,  ehca_poll_all_eqs,  int, S_IRUGO);
 module_param_named(static_rate,   ehca_static_rate,   int, S_IRUGO);
 module_param_named(scaling_code,  ehca_scaling_code,  int, S_IRUGO);
-module_param_named(mr_largepage,  ehca_mr_largepage,  int, S_IRUGO);
 module_param_named(lock_hcalls,   ehca_lock_hcalls,   bool, S_IRUGO);
 
 MODULE_PARM_DESC(open_aqp1,
@@ -104,9 +102,6 @@ MODULE_PARM_DESC(static_rate,
 		 "set permanent static rate (default: disabled)");
 MODULE_PARM_DESC(scaling_code,
 		 "set scaling code (0: disabled/default, 1: enabled)");
-MODULE_PARM_DESC(mr_largepage,
-		 "use large page for MR (0: use PAGE_SIZE (default), "
-		 "1: use large page depending on MR size");
 MODULE_PARM_DESC(lock_hcalls,
 		 "serialize all hCalls made by the driver "
 		 "(default: autodetect)");
@@ -357,11 +352,9 @@ static int ehca_sense_attributes(struct ehca_shca *shca)
 
 	/* translate supported MR page sizes; always support 4K */
 	shca->hca_cap_mr_pgsize = EHCA_PAGESIZE;
-	if (ehca_mr_largepage) { /* support extra sizes only if enabled */
-		for (i = 0; i < ARRAY_SIZE(pgsize_map); i += 2)
-			if (rblock->memory_page_size_supported & pgsize_map[i])
-				shca->hca_cap_mr_pgsize |= pgsize_map[i + 1];
-	}
+	for (i = 0; i < ARRAY_SIZE(pgsize_map); i += 2)
+		if (rblock->memory_page_size_supported & pgsize_map[i])
+			shca->hca_cap_mr_pgsize |= pgsize_map[i + 1];
 
 	/* query max MTU from first port -- it's the same for all ports */
 	port = (struct hipz_query_port *)rblock;
@@ -663,14 +656,6 @@ static ssize_t ehca_show_adapter_handle(struct device *dev,
 }
 static DEVICE_ATTR(adapter_handle, S_IRUGO, ehca_show_adapter_handle, NULL);
 
-static ssize_t ehca_show_mr_largepage(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
-{
-	return sprintf(buf, "%d\n", ehca_mr_largepage);
-}
-static DEVICE_ATTR(mr_largepage, S_IRUGO, ehca_show_mr_largepage, NULL);
-
 static struct attribute *ehca_dev_attrs[] = {
 	&dev_attr_adapter_handle.attr,
 	&dev_attr_num_ports.attr,
@@ -687,7 +672,6 @@ static struct attribute *ehca_dev_attrs[] = {
 	&dev_attr_cur_mw.attr,
 	&dev_attr_max_pd.attr,
 	&dev_attr_max_ah.attr,
-	&dev_attr_mr_largepage.attr,
 	NULL
 };
 
-- 
1.5.5
