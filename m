Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3917DE8A1
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 04:25:22 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6NIPHPj017706
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:25:17 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6NIPGBN177112
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 12:25:16 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6NIPGaH029686
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 12:25:16 -0600
Date: Wed, 23 Jul 2008 13:25:16 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 02/16 v4] powerpc: Split processor entitlement retrieval
	and gat
Message-ID: <20080723182516.GE12905@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080723181932.GC12905@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hering to helper routines

=46rom: Nathan Fotenot <nfont@austin.ibm.com>

Split the retrieval and setting of processor entitlement and weight into
helper routines.  This also removes the printing of the raw values
returned from h_get_ppp, the values are already parsed and printed.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
Updated patch to remove checking the return code from the h_call for
H_PIC.  This reverts the reporting back to its original state.

---
 arch/powerpc/kernel/lparcfg.c |  166 ++++++++++++++++++++++---------------=
-----
 1 file changed, 88 insertions(+), 78 deletions(-)

Index: b/arch/powerpc/kernel/lparcfg.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -167,7 +167,8 @@ static unsigned int h_get_ppp(unsigned l
 	return rc;
 }
=20
-static void h_pic(unsigned long *pool_idle_time, unsigned long *num_procs)
+static unsigned h_pic(unsigned long *pool_idle_time,
+		      unsigned long *num_procs)
 {
 	unsigned long rc;
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
@@ -176,6 +177,51 @@ static void h_pic(unsigned long *pool_id
=20
 	*pool_idle_time =3D retbuf[0];
 	*num_procs =3D retbuf[1];
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
+	rc =3D h_get_ppp(&h_entitled, &h_unallocated, &h_aggregation,
+		       &h_resource);
+	if (rc)
+		return;
+
+	seq_printf(m, "partition_entitled_capacity=3D%ld\n", h_entitled);
+	seq_printf(m, "group=3D%ld\n", (h_aggregation >> 2 * 8) & 0xffff);
+	seq_printf(m, "system_active_processors=3D%ld\n",
+		   (h_resource >> 0 * 8) & 0xffff);
+
+	/* pool related entries are apropriate for shared configs */
+	if (lppaca[0].shared_proc) {
+		unsigned long pool_idle_time, pool_procs;
+
+		seq_printf(m, "pool=3D%ld\n", (h_aggregation >> 0 * 8) & 0xffff);
+
+		/* report pool_capacity in percentage */
+		seq_printf(m, "pool_capacity=3D%ld\n",
+			   ((h_resource >> 2 * 8) & 0xffff) * 100);
+
+		h_pic(&pool_idle_time, &pool_procs);
+		seq_printf(m, "pool_idle_time=3D%ld\n", pool_idle_time);
+		seq_printf(m, "pool_num_procs=3D%ld\n", pool_procs);
+	}
+
+	seq_printf(m, "unallocated_capacity_weight=3D%ld\n",
+		   (h_resource >> 4 * 8) & 0xFF);
+
+	seq_printf(m, "capacity_weight=3D%ld\n", (h_resource >> 5 * 8) & 0xFF);
+	seq_printf(m, "capped=3D%ld\n", (h_resource >> 6 * 8) & 0x01);
+	seq_printf(m, "unallocated_capacity=3D%ld\n", h_unallocated);
 }
=20
 #define SPLPAR_CHARACTERISTICS_TOKEN 20
@@ -302,60 +348,11 @@ static int pseries_lparcfg_data(struct s
 	partition_active_processors =3D lparcfg_count_active_processors();
=20
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		unsigned long h_entitled, h_unallocated;
-		unsigned long h_aggregation, h_resource;
-		unsigned long pool_idle_time, pool_procs;
-		unsigned long purr;
-
-		h_get_ppp(&h_entitled, &h_unallocated, &h_aggregation,
-			  &h_resource);
-
-		seq_printf(m, "R4=3D0x%lx\n", h_entitled);
-		seq_printf(m, "R5=3D0x%lx\n", h_unallocated);
-		seq_printf(m, "R6=3D0x%lx\n", h_aggregation);
-		seq_printf(m, "R7=3D0x%lx\n", h_resource);
-
-		purr =3D get_purr();
-
 		/* this call handles the ibm,get-system-parameter contents */
 		parse_system_parameter_string(m);
+		parse_ppp_data(m);
=20
-		seq_printf(m, "partition_entitled_capacity=3D%ld\n", h_entitled);
-
-		seq_printf(m, "group=3D%ld\n", (h_aggregation >> 2 * 8) & 0xffff);
-
-		seq_printf(m, "system_active_processors=3D%ld\n",
-			   (h_resource >> 0 * 8) & 0xffff);
-
-		/* pool related entries are apropriate for shared configs */
-		if (lppaca[0].shared_proc) {
-
-			h_pic(&pool_idle_time, &pool_procs);
-
-			seq_printf(m, "pool=3D%ld\n",
-				   (h_aggregation >> 0 * 8) & 0xffff);
-
-			/* report pool_capacity in percentage */
-			seq_printf(m, "pool_capacity=3D%ld\n",
-				   ((h_resource >> 2 * 8) & 0xffff) * 100);
-
-			seq_printf(m, "pool_idle_time=3D%ld\n", pool_idle_time);
-
-			seq_printf(m, "pool_num_procs=3D%ld\n", pool_procs);
-		}
-
-		seq_printf(m, "unallocated_capacity_weight=3D%ld\n",
-			   (h_resource >> 4 * 8) & 0xFF);
-
-		seq_printf(m, "capacity_weight=3D%ld\n",
-			   (h_resource >> 5 * 8) & 0xFF);
-
-		seq_printf(m, "capped=3D%ld\n", (h_resource >> 6 * 8) & 0x01);
-
-		seq_printf(m, "unallocated_capacity=3D%ld\n", h_unallocated);
-
-		seq_printf(m, "purr=3D%ld\n", purr);
-
+		seq_printf(m, "purr=3D%ld\n", get_purr());
 	} else {		/* non SPLPAR case */
=20
 		seq_printf(m, "system_active_processors=3D%d\n",
@@ -382,6 +379,41 @@ static int pseries_lparcfg_data(struct s
 	return 0;
 }
=20
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
+	retval =3D h_get_ppp(&current_entitled, &dummy, &dummy, &resource);
+	if (retval)
+		return retval;
+
+	current_weight =3D (resource >> 5 * 8) & 0xFF;
+
+	if (entitlement) {
+		new_weight =3D current_weight;
+		new_entitled =3D *entitlement;
+	} else if (weight) {
+		new_weight =3D *weight;
+		new_entitled =3D current_entitled;
+	} else
+		return -EINVAL;
+
+	pr_debug("%s: current_entitled =3D %lu, current_weight =3D %u\n",
+		 __FUNCTION__, current_entitled, current_weight);
+
+	pr_debug("%s: new_entitled =3D %lu, new_weight =3D %u\n",
+		 __FUNCTION__, new_entitled, new_weight);
+
+	retval =3D plpar_hcall_norets(H_SET_PPP, new_entitled, new_weight);
+	return retval;
+}
+
 /*
  * Interface for changing system parameters (variable capacity weight
  * and entitled capacity).  Format of input is "param_name=3Dvalue";
@@ -399,12 +431,6 @@ static ssize_t lparcfg_write(struct file
 	char *tmp;
 	u64 new_entitled, *new_entitled_ptr =3D &new_entitled;
 	u8 new_weight, *new_weight_ptr =3D &new_weight;
-
-	unsigned long current_entitled;	/* parameters for h_get_ppp */
-	unsigned long dummy;
-	unsigned long resource;
-	u8 current_weight;
-
 	ssize_t retval =3D -ENOMEM;
=20
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR) ||
@@ -432,33 +458,17 @@ static ssize_t lparcfg_write(struct file
 		*new_entitled_ptr =3D (u64) simple_strtoul(tmp, &endp, 10);
 		if (endp =3D=3D tmp)
 			goto out;
-		new_weight_ptr =3D &current_weight;
+
+		retval =3D update_ppp(new_entitled_ptr, NULL);
 	} else if (!strcmp(kbuf, "capacity_weight")) {
 		char *endp;
 		*new_weight_ptr =3D (u8) simple_strtoul(tmp, &endp, 10);
 		if (endp =3D=3D tmp)
 			goto out;
-		new_entitled_ptr =3D &current_entitled;
-	} else
-		goto out;
=20
-	/* Get our current parameters */
-	retval =3D h_get_ppp(&current_entitled, &dummy, &dummy, &resource);
-	if (retval) {
-		retval =3D -EIO;
+		retval =3D update_ppp(NULL, new_weight_ptr);
+	} else
 		goto out;
-	}
-
-	current_weight =3D (resource >> 5 * 8) & 0xFF;
-
-	pr_debug("%s: current_entitled =3D %lu, current_weight =3D %u\n",
-		 __func__, current_entitled, current_weight);
-
-	pr_debug("%s: new_entitled =3D %lu, new_weight =3D %u\n",
-		 __func__, *new_entitled_ptr, *new_weight_ptr);
-
-	retval =3D plpar_hcall_norets(H_SET_PPP, *new_entitled_ptr,
-				    *new_weight_ptr);
=20
 	if (retval =3D=3D H_SUCCESS || retval =3D=3D H_CONSTRAINED) {
 		retval =3D count;
