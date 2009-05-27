Return-Path: <nfont@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F4E0DDEDB
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 00:41:29 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4REapB1019561
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 10:36:51 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4REfOEP190460
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 10:41:24 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4REdI7k022401
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 10:39:18 -0400
Received: from [9.53.40.154] (mudbug-009053040154.austin.ibm.com [9.53.40.154])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n4REdFTM022205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 10:39:18 -0400
Message-ID: <4A1D5111.10505@austin.ibm.com>
Date: Wed, 27 May 2009 09:41:21 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] v2: Display processor virtualization resource allocations
	in lparcfg
References: <4A1C2E10.9020109@austin.ibm.com>
In-Reply-To: <4A1C2E10.9020109@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch updates the output from /proc/ppc64/lparcfg to display the
processor virtualization resource allocations for a shared processor
partition.

This information is already gathered via the h_get_ppp call, we just
have to make sure that the ibm,partition-performance-parameters-level
property is >= 1 to ensure that the information is valid.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: linux-2.6/arch/powerpc/kernel/lparcfg.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/lparcfg.c	2009-05-21 10:24:57.000000000 -0500
+++ linux-2.6/arch/powerpc/kernel/lparcfg.c	2009-05-27 08:27:34.000000000 -0500
@@ -169,6 +169,9 @@
 	u8	unallocated_weight;
 	u16	active_procs_in_pool;
 	u16	active_system_procs;
+	u16	phys_platform_procs;
+	u32	max_proc_cap_avail;
+	u32	entitled_proc_cap_avail;
 };
 
 /*
@@ -190,13 +193,18 @@
  *            XX - Unallocated Variable Processor Capacity Weight.
  *              XXXX - Active processors in Physical Processor Pool.
  *                  XXXX  - Processors active on platform.
+ *  R8 (QQQQRRRRRRSSSSSS). if ibm,partition-performance-parameters-level >= 1
+ *	XXXX - Physical platform procs allocated to virtualization.
+ *	    XXXXXX - Max procs capacity % available to the partitions pool.
+ *	          XXXXXX - Entitled procs capacity % available to the
+ *			   partitions pool.
  */
 static unsigned int h_get_ppp(struct hvcall_ppp_data *ppp_data)
 {
 	unsigned long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
 
-	rc = plpar_hcall(H_GET_PPP, retbuf);
+	rc = plpar_hcall9(H_GET_PPP, retbuf);
 
 	ppp_data->entitlement = retbuf[0];
 	ppp_data->unallocated_entitlement = retbuf[1];
@@ -210,6 +218,10 @@
 	ppp_data->active_procs_in_pool = (retbuf[3] >> 2 * 8) & 0xffff;
 	ppp_data->active_system_procs = retbuf[3] & 0xffff;
 
+	ppp_data->phys_platform_procs = retbuf[4] >> 6 * 8;
+	ppp_data->max_proc_cap_avail = (retbuf[4] >> 3 * 8) & 0xffffff;
+	ppp_data->entitled_proc_cap_avail = retbuf[4] & 0xffffff;
+
 	return rc;
 }
 
@@ -234,6 +246,8 @@
 static void parse_ppp_data(struct seq_file *m)
 {
 	struct hvcall_ppp_data ppp_data;
+	struct device_node *root;
+	const int *perf_level;
 	int rc;
 
 	rc = h_get_ppp(&ppp_data);
@@ -267,6 +281,28 @@
 	seq_printf(m, "capped=%d\n", ppp_data.capped);
 	seq_printf(m, "unallocated_capacity=%lld\n",
 		   ppp_data.unallocated_entitlement);
+
+	/* The last bits of information returned from h_get_ppp are only
+	 * valid if the ibm,partition-performance-parameters-level
+	 * property is >= 1.
+	 */
+	root = of_find_node_by_path("/");
+	if (root) {
+		perf_level = of_get_property(root,
+				"ibm,partition-performance-parameters-level",
+					     NULL);
+		if (perf_level && (*perf_level >= 1)) {
+			seq_printf(m,
+			    "physical_procs_allocated_to_virtualization=%d\n",
+				   ppp_data.phys_platform_procs);
+			seq_printf(m, "max_proc_capacity_available=%d\n",
+				   ppp_data.max_proc_cap_avail);
+			seq_printf(m, "entitled_proc_capacity_available=%d\n",
+				   ppp_data.entitled_proc_cap_avail);
+		}
+
+		of_node_put(root);
+	}
 }
 
 /**
