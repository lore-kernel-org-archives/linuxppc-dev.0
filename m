Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6EADADE195
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 08:12:45 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5CMCfD4024226
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 18:12:41 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5CMCf4e175702
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 16:12:41 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5CMCei7032523
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 16:12:40 -0600
Date: Thu, 12 Jun 2008 17:11:10 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 04/19] powerpc: Split retrieval of processor entitlement
	data into a helper routine
Message-ID: <20080612221110.GK30916@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080612215312.GF30916@linux.vnet.ibm.com>
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

=46rom: Nathan Fontenot <nfont@austin.ibm.com>

Split the retrieval of processor entitlement data returned in the H_GET_PPP
hcall into its own helper routine.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

---
 arch/powerpc/kernel/lparcfg.c |   80 ++++++++++++++++++++++++-------------=
-----
 1 file changed, 45 insertions(+), 35 deletions(-)

Index: b/arch/powerpc/kernel/lparcfg.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -158,6 +158,18 @@ int h_get_mpp(struct hvcall_mpp_data *mp
 }
 EXPORT_SYMBOL(h_get_mpp);
=20
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
@@ -178,20 +190,24 @@ EXPORT_SYMBOL(h_get_mpp);
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
=20
 	rc =3D plpar_hcall(H_GET_PPP, retbuf);
=20
-	*entitled =3D retbuf[0];
-	*unallocated =3D retbuf[1];
-	*aggregation =3D retbuf[2];
-	*resource =3D retbuf[3];
+	ppp_data->entitlement =3D retbuf[0];
+	ppp_data->unallocated_entitlement =3D retbuf[1];
+
+	ppp_data->group_num =3D (retbuf[2] >> 2 * 8) & 0xffff;
+	ppp_data->pool_num =3D retbuf[2] & 0xffff;
+
+	ppp_data->capped =3D (retbuf[3] >> 6 * 8) & 0x01;
+	ppp_data->weight =3D (retbuf[3] >> 5 * 8) & 0xff;
+	ppp_data->unallocated_weight =3D (retbuf[3] >> 4 * 8) & 0xff;
+	ppp_data->active_procs_in_pool =3D (retbuf[3] >> 2 * 8) & 0xffff;
+	ppp_data->active_system_procs =3D retbuf[3] & 0xffff;
=20
 	return rc;
 }
@@ -216,29 +232,27 @@ static unsigned int h_pic(unsigned long=20
  */
 static void parse_ppp_data(struct seq_file *m)
 {
-	unsigned long h_entitled, h_unallocated;
-	unsigned long h_aggregation, h_resource;
+	struct hvcall_ppp_data ppp_data;
 	int rc;
=20
-	rc =3D h_get_ppp(&h_entitled, &h_unallocated, &h_aggregation,
-		       &h_resource);
+	rc =3D h_get_ppp(&ppp_data);
 	if (rc)
 		return;
=20
-	seq_printf(m, "partition_entitled_capacity=3D%ld\n", h_entitled);
-	seq_printf(m, "group=3D%ld\n", (h_aggregation >> 2 * 8) & 0xffff);
-	seq_printf(m, "system_active_processors=3D%ld\n",
-		   (h_resource >> 0 * 8) & 0xffff);
+	seq_printf(m, "partition_entitled_capacity=3D%ld\n",
+	           ppp_data.entitlement);
+	seq_printf(m, "group=3D%d\n", ppp_data.group_num);
+	seq_printf(m, "system_active_processors=3D%d\n",
+	           ppp_data.active_system_procs);
=20
 	/* pool related entries are apropriate for shared configs */
 	if (lppaca[0].shared_proc) {
 		unsigned long pool_idle_time, pool_procs;
=20
-		seq_printf(m, "pool=3D%ld\n", (h_aggregation >> 0 * 8) & 0xffff);
+		seq_printf(m, "pool=3D%d\n", ppp_data.pool_num);
=20
 		/* report pool_capacity in percentage */
-		seq_printf(m, "pool_capacity=3D%ld\n",
-			   ((h_resource >> 2 * 8) & 0xffff) * 100);
+		seq_printf(m, "pool_capacity=3D%d\n", ppp_data.group_num * 100);
=20
 		rc =3D h_pic(&pool_idle_time, &pool_procs);
 		if (! rc) {
@@ -247,12 +261,12 @@ static void parse_ppp_data(struct seq_fi
 		}
 	}
=20
-	seq_printf(m, "unallocated_capacity_weight=3D%ld\n",
-		   (h_resource >> 4 * 8) & 0xFF);
-
-	seq_printf(m, "capacity_weight=3D%ld\n", (h_resource >> 5 * 8) & 0xFF);
-	seq_printf(m, "capped=3D%ld\n", (h_resource >> 6 * 8) & 0x01);
-	seq_printf(m, "unallocated_capacity=3D%ld\n", h_unallocated);
+	seq_printf(m, "unallocated_capacity_weight=3D%d\n",
+		   ppp_data.unallocated_weight);
+	seq_printf(m, "capacity_weight=3D%d\n", ppp_data.weight);
+	seq_printf(m, "capped=3D%d\n", ppp_data.capped);
+	seq_printf(m, "unallocated_capacity=3D%ld\n",
+		   ppp_data.unallocated_entitlement);
 }
=20
 /**
@@ -452,30 +466,26 @@ static int pseries_lparcfg_data(struct s
=20
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
=20
 	/* Get our current parameters */
-	retval =3D h_get_ppp(&current_entitled, &dummy, &dummy, &resource);
+	retval =3D h_get_ppp(&ppp_data);
 	if (retval)
 		return retval;
=20
-	current_weight =3D (resource >> 5 * 8) & 0xFF;
-
 	if (entitlement) {
-		new_weight =3D current_weight;
+		new_weight =3D ppp_data.weight;
 		new_entitled =3D *entitlement;
 	} else {
 		new_weight =3D *weight;
-		new_entitled =3D current_entitled;
+		new_entitled =3D ppp_data.entitlement;
 	}
=20
 	pr_debug("%s: current_entitled =3D %lu, current_weight =3D %u\n",
-		 __FUNCTION__, current_entitled, current_weight);
+	         __FUNCTION__, ppp_data.entitlement, ppp_data.weight);
=20
 	pr_debug("%s: new_entitled =3D %lu, new_weight =3D %u\n",
 		 __FUNCTION__, new_entitled, new_weight);
