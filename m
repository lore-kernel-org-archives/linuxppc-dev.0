Return-Path: <nfont@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3FA84DE074
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 04:57:05 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6MIv0Bv010500
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:57:00 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6MIumjF097230
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 12:56:48 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6MIum6f031570
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 12:56:48 -0600
Message-ID: <48862D6F.80102@austin.ibm.com>
Date: Tue, 22 Jul 2008 13:56:47 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 04/16 v3] powerpc: Split retrieval of processor entitlement
	data into a helper routine
References: <20080704125207.GE1310@linux.vnet.ibm.com>
In-Reply-To: <20080704125207.GE1310@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updated patch to correct the reporting of pool_capcity.

Split the retrieval of processor entitlement data returned in the H_GET_PPP
hcall into its own helper routine.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 arch/powerpc/kernel/lparcfg.c |   80 ++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 35 deletions(-)

Index: linux-2.6.git/arch/powerpc/kernel/lparcfg.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/lparcfg.c	2008-07-22 13:16:58.000000000 -0500
+++ linux-2.6.git/arch/powerpc/kernel/lparcfg.c	2008-07-22 13:17:25.000000000 -0500
@@ -158,6 +158,18 @@
 }
 EXPORT_SYMBOL(h_get_mpp);
 
+struct hvcall_ppp_data {
+	u64	entitlement;
+	u64	unallocated_entitlement;
+	u16	group_num;
+	u16	pool_num;
+	u8	capped;
+	u8	weight;
+	u8	unallocated_weight;
+	u16	active_procs_in_pool;
+	u16	active_system_procs;
+};
+
 /*
  * H_GET_PPP hcall returns info in 4 parms.
  *  entitled_capacity,unallocated_capacity,
@@ -178,20 +190,24 @@
  *              XXXX - Active processors in Physical Processor Pool.
  *                  XXXX  - Processors active on platform.
  */
-static unsigned int h_get_ppp(unsigned long *entitled,
-			      unsigned long *unallocated,
-			      unsigned long *aggregation,
-			      unsigned long *resource)
+static unsigned int h_get_ppp(struct hvcall_ppp_data *ppp_data)
 {
 	unsigned long rc;
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 
 	rc = plpar_hcall(H_GET_PPP, retbuf);
 
-	*entitled = retbuf[0];
-	*unallocated = retbuf[1];
-	*aggregation = retbuf[2];
-	*resource = retbuf[3];
+	ppp_data->entitlement = retbuf[0];
+	ppp_data->unallocated_entitlement = retbuf[1];
+
+	ppp_data->group_num = (retbuf[2] >> 2 * 8) & 0xffff;
+	ppp_data->pool_num = retbuf[2] & 0xffff;
+
+	ppp_data->capped = (retbuf[3] >> 6 * 8) & 0x01;
+	ppp_data->weight = (retbuf[3] >> 5 * 8) & 0xff;
+	ppp_data->unallocated_weight = (retbuf[3] >> 4 * 8) & 0xff;
+	ppp_data->active_procs_in_pool = (retbuf[3] >> 2 * 8) & 0xffff;
+	ppp_data->active_system_procs = retbuf[3] & 0xffff;
 
 	return rc;
 }
@@ -216,41 +232,40 @@
  */
 static void parse_ppp_data(struct seq_file *m)
 {
-	unsigned long h_entitled, h_unallocated;
-	unsigned long h_aggregation, h_resource;
+	struct hvcall_ppp_data ppp_data;
 	int rc;
 
-	rc = h_get_ppp(&h_entitled, &h_unallocated, &h_aggregation,
-		       &h_resource);
+	rc = h_get_ppp(&ppp_data);
 	if (rc)
 		return;
 
-	seq_printf(m, "partition_entitled_capacity=%ld\n", h_entitled);
-	seq_printf(m, "group=%ld\n", (h_aggregation >> 2 * 8) & 0xffff);
-	seq_printf(m, "system_active_processors=%ld\n",
-		   (h_resource >> 0 * 8) & 0xffff);
+	seq_printf(m, "partition_entitled_capacity=%ld\n",
+	           ppp_data.entitlement);
+	seq_printf(m, "group=%d\n", ppp_data.group_num);
+	seq_printf(m, "system_active_processors=%d\n",
+	           ppp_data.active_system_procs);
 
 	/* pool related entries are apropriate for shared configs */
 	if (lppaca[0].shared_proc) {
 		unsigned long pool_idle_time, pool_procs;
 
-		seq_printf(m, "pool=%ld\n", (h_aggregation >> 0 * 8) & 0xffff);
+		seq_printf(m, "pool=%d\n", ppp_data.pool_num);
 
 		/* report pool_capacity in percentage */
-		seq_printf(m, "pool_capacity=%ld\n",
-			   ((h_resource >> 2 * 8) & 0xffff) * 100);
+		seq_printf(m, "pool_capacity=%d\n",
+			   ppp_data.active_procs_in_pool * 100);
 
 		h_pic(&pool_idle_time, &pool_procs);
 		seq_printf(m, "pool_idle_time=%ld\n", pool_idle_time);
 		seq_printf(m, "pool_num_procs=%ld\n", pool_procs);
 	}
 
-	seq_printf(m, "unallocated_capacity_weight=%ld\n",
-		   (h_resource >> 4 * 8) & 0xFF);
-
-	seq_printf(m, "capacity_weight=%ld\n", (h_resource >> 5 * 8) & 0xFF);
-	seq_printf(m, "capped=%ld\n", (h_resource >> 6 * 8) & 0x01);
-	seq_printf(m, "unallocated_capacity=%ld\n", h_unallocated);
+	seq_printf(m, "unallocated_capacity_weight=%d\n",
+		   ppp_data.unallocated_weight);
+	seq_printf(m, "capacity_weight=%d\n", ppp_data.weight);
+	seq_printf(m, "capped=%d\n", ppp_data.capped);
+	seq_printf(m, "unallocated_capacity=%ld\n",
+		   ppp_data.unallocated_entitlement);
 }
 
 /**
@@ -449,31 +464,27 @@
 
 static ssize_t update_ppp(u64 *entitlement, u8 *weight)
 {
-	unsigned long current_entitled;
-	unsigned long dummy;
-	unsigned long resource;
-	u8 current_weight, new_weight;
+	struct hvcall_ppp_data ppp_data;
+	u8 new_weight;
 	u64 new_entitled;
 	ssize_t retval;
 
 	/* Get our current parameters */
-	retval = h_get_ppp(&current_entitled, &dummy, &dummy, &resource);
+	retval = h_get_ppp(&ppp_data);
 	if (retval)
 		return retval;
 
-	current_weight = (resource >> 5 * 8) & 0xFF;
-
 	if (entitlement) {
-		new_weight = current_weight;
+		new_weight = ppp_data.weight;
 		new_entitled = *entitlement;
 	} else if (weight) {
 		new_weight = *weight;
-		new_entitled = current_entitled;
+		new_entitled = ppp_data.entitlement;
 	} else
 		return -EINVAL;
 
 	pr_debug("%s: current_entitled = %lu, current_weight = %u\n",
-		 __FUNCTION__, current_entitled, current_weight);
+	         __FUNCTION__, ppp_data.entitlement, ppp_data.weight);
 
 	pr_debug("%s: new_entitled = %lu, new_weight = %u\n",
 		 __FUNCTION__, new_entitled, new_weight);
