Return-Path: <nfont@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87702DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 04:54:54 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6MIsnOn020072
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:54:49 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6MIrnok225440
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:53:49 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6MIrn6F008184
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:53:49 -0400
Message-ID: <48862CBC.5000503@austin.ibm.com>
Date: Tue, 22 Jul 2008 13:53:48 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 02/16 v3] powerpc: Split processor entitlement retrieval
	and gathering to helper routines
References: <20080704125122.GC1310@linux.vnet.ibm.com>
In-Reply-To: <20080704125122.GC1310@linux.vnet.ibm.com>
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

Updated patch to remove checking the return code from the h_call for
H_PIC.  This reverts the reporting back to its original state.

Split the retrieval and setting of processor entitlement and weight into
helper routines.  This also removes the printing of the raw values
returned from h_get_ppp, the values are already parsed and printed.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 arch/powerpc/kernel/lparcfg.c |  168 ++++++++++++++++++++++-------------------
 1 file changed, 90 insertions(+), 78 deletions(-)

Index: linux-2.6.git/arch/powerpc/kernel/lparcfg.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/lparcfg.c	2008-07-22 10:35:13.000000000 -0500
+++ linux-2.6.git/arch/powerpc/kernel/lparcfg.c	2008-07-22 12:50:47.000000000 -0500
@@ -167,7 +167,8 @@
 	return rc;
 }
 
-static void h_pic(unsigned long *pool_idle_time, unsigned long *num_procs)
+static unsigned h_pic(unsigned long *pool_idle_time,
+		      unsigned long *num_procs)
 {
 	unsigned long rc;
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
@@ -176,6 +177,51 @@
 
 	*pool_idle_time = retbuf[0];
 	*num_procs = retbuf[1];
+
+	return rc;
+}
+
+/*
+ * parse_ppp_data
+ * Parse out the data returned from h_get_ppp and h_pic
+ */
+static void parse_ppp_data(struct seq_file *m)
+{
+	unsigned long h_entitled, h_unallocated;
+	unsigned long h_aggregation, h_resource;
+	int rc;
+
+	rc = h_get_ppp(&h_entitled, &h_unallocated, &h_aggregation,
+		       &h_resource);
+	if (rc)
+		return;
+
+	seq_printf(m, "partition_entitled_capacity=%ld\n", h_entitled);
+	seq_printf(m, "group=%ld\n", (h_aggregation >> 2 * 8) & 0xffff);
+	seq_printf(m, "system_active_processors=%ld\n",
+		   (h_resource >> 0 * 8) & 0xffff);
+
+	/* pool related entries are apropriate for shared configs */
+	if (lppaca[0].shared_proc) {
+		unsigned long pool_idle_time, pool_procs;
+
+		seq_printf(m, "pool=%ld\n", (h_aggregation >> 0 * 8) & 0xffff);
+
+		/* report pool_capacity in percentage */
+		seq_printf(m, "pool_capacity=%ld\n",
+			   ((h_resource >> 2 * 8) & 0xffff) * 100);
+
+		h_pic(&pool_idle_time, &pool_procs);
+		seq_printf(m, "pool_idle_time=%ld\n", pool_idle_time);
+		seq_printf(m, "pool_num_procs=%ld\n", pool_procs);
+	}
+
+	seq_printf(m, "unallocated_capacity_weight=%ld\n",
+		   (h_resource >> 4 * 8) & 0xFF);
+
+	seq_printf(m, "capacity_weight=%ld\n", (h_resource >> 5 * 8) & 0xFF);
+	seq_printf(m, "capped=%ld\n", (h_resource >> 6 * 8) & 0x01);
+	seq_printf(m, "unallocated_capacity=%ld\n", h_unallocated);
 }
 
 #define SPLPAR_CHARACTERISTICS_TOKEN 20
@@ -302,60 +348,11 @@
 	partition_active_processors = lparcfg_count_active_processors();
 
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		unsigned long h_entitled, h_unallocated;
-		unsigned long h_aggregation, h_resource;
-		unsigned long pool_idle_time, pool_procs;
-		unsigned long purr;
-
-		h_get_ppp(&h_entitled, &h_unallocated, &h_aggregation,
-			  &h_resource);
-
-		seq_printf(m, "R4=0x%lx\n", h_entitled);
-		seq_printf(m, "R5=0x%lx\n", h_unallocated);
-		seq_printf(m, "R6=0x%lx\n", h_aggregation);
-		seq_printf(m, "R7=0x%lx\n", h_resource);
-
-		purr = get_purr();
-
 		/* this call handles the ibm,get-system-parameter contents */
 		parse_system_parameter_string(m);
+		parse_ppp_data(m);
 
-		seq_printf(m, "partition_entitled_capacity=%ld\n", h_entitled);
-
-		seq_printf(m, "group=%ld\n", (h_aggregation >> 2 * 8) & 0xffff);
-
-		seq_printf(m, "system_active_processors=%ld\n",
-			   (h_resource >> 0 * 8) & 0xffff);
-
-		/* pool related entries are apropriate for shared configs */
-		if (lppaca[0].shared_proc) {
-
-			h_pic(&pool_idle_time, &pool_procs);
-
-			seq_printf(m, "pool=%ld\n",
-				   (h_aggregation >> 0 * 8) & 0xffff);
-
-			/* report pool_capacity in percentage */
-			seq_printf(m, "pool_capacity=%ld\n",
-				   ((h_resource >> 2 * 8) & 0xffff) * 100);
-
-			seq_printf(m, "pool_idle_time=%ld\n", pool_idle_time);
-
-			seq_printf(m, "pool_num_procs=%ld\n", pool_procs);
-		}
-
-		seq_printf(m, "unallocated_capacity_weight=%ld\n",
-			   (h_resource >> 4 * 8) & 0xFF);
-
-		seq_printf(m, "capacity_weight=%ld\n",
-			   (h_resource >> 5 * 8) & 0xFF);
-
-		seq_printf(m, "capped=%ld\n", (h_resource >> 6 * 8) & 0x01);
-
-		seq_printf(m, "unallocated_capacity=%ld\n", h_unallocated);
-
-		seq_printf(m, "purr=%ld\n", purr);
-
+		seq_printf(m, "purr=%ld\n", get_purr());
 	} else {		/* non SPLPAR case */
 
 		seq_printf(m, "system_active_processors=%d\n",
@@ -382,6 +379,41 @@
 	return 0;
 }
 
+static ssize_t update_ppp(u64 *entitlement, u8 *weight)
+{
+	unsigned long current_entitled;
+	unsigned long dummy;
+	unsigned long resource;
+	u8 current_weight, new_weight;
+	u64 new_entitled;
+	ssize_t retval;
+
+	/* Get our current parameters */
+	retval = h_get_ppp(&current_entitled, &dummy, &dummy, &resource);
+	if (retval)
+		return retval;
+
+	current_weight = (resource >> 5 * 8) & 0xFF;
+
+	if (entitlement) {
+		new_weight = current_weight;
+		new_entitled = *entitlement;
+	} else if (weight) {
+		new_weight = *weight;
+		new_entitled = current_entitled;
+	} else
+		return -EINVAL;
+
+	pr_debug("%s: current_entitled = %lu, current_weight = %u\n",
+		 __FUNCTION__, current_entitled, current_weight);
+
+	pr_debug("%s: new_entitled = %lu, new_weight = %u\n",
+		 __FUNCTION__, new_entitled, new_weight);
+
+	retval = plpar_hcall_norets(H_SET_PPP, new_entitled, new_weight);
+	return retval;
+}
+
 /*
  * Interface for changing system parameters (variable capacity weight
  * and entitled capacity).  Format of input is "param_name=value";
@@ -399,12 +431,6 @@
 	char *tmp;
 	u64 new_entitled, *new_entitled_ptr = &new_entitled;
 	u8 new_weight, *new_weight_ptr = &new_weight;
-
-	unsigned long current_entitled;	/* parameters for h_get_ppp */
-	unsigned long dummy;
-	unsigned long resource;
-	u8 current_weight;
-
 	ssize_t retval = -ENOMEM;
 
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR) ||
@@ -432,33 +458,17 @@
 		*new_entitled_ptr = (u64) simple_strtoul(tmp, &endp, 10);
 		if (endp == tmp)
 			goto out;
-		new_weight_ptr = &current_weight;
+
+		retval = update_ppp(new_entitled_ptr, NULL);
 	} else if (!strcmp(kbuf, "capacity_weight")) {
 		char *endp;
 		*new_weight_ptr = (u8) simple_strtoul(tmp, &endp, 10);
 		if (endp == tmp)
 			goto out;
-		new_entitled_ptr = &current_entitled;
-	} else
-		goto out;
 
-	/* Get our current parameters */
-	retval = h_get_ppp(&current_entitled, &dummy, &dummy, &resource);
-	if (retval) {
-		retval = -EIO;
+		retval = update_ppp(NULL, new_weight_ptr);
+	} else
 		goto out;
-	}
-
-	current_weight = (resource >> 5 * 8) & 0xFF;
-
-	pr_debug("%s: current_entitled = %lu, current_weight = %u\n",
-		 __func__, current_entitled, current_weight);
-
-	pr_debug("%s: new_entitled = %lu, new_weight = %u\n",
-		 __func__, *new_entitled_ptr, *new_weight_ptr);
-
-	retval = plpar_hcall_norets(H_SET_PPP, *new_entitled_ptr,
-				    *new_weight_ptr);
 
 	if (retval == H_SUCCESS || retval == H_CONSTRAINED) {
 		retval = count;
