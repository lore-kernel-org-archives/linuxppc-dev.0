Return-Path: <nfont@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 073D5DDFBB
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 04:56:35 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6MIuW5C015524
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:56:32 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6MItGJ1232318
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:55:16 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6MItFAM015056
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:55:15 -0400
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m6MItEwL014883
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:55:15 -0400
Message-ID: <48862D12.3050108@austin.ibm.com>
Date: Tue, 22 Jul 2008 13:55:14 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/16 v3] powerpc: Add memory entitlement capabilities
	to	/proc/ppc64/lparcfg
References: <20080704125147.GD1310@linux.vnet.ibm.com>
In-Reply-To: <20080704125147.GD1310@linux.vnet.ibm.com>
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

Updated patch, increment the lparcfg module version number.

Update /proc/ppc64/lparcfg to enable displaying of Cooperative Memory
Overcommitment statistics as reported by the H_GET_MPP hcall.  This also
updates the lparcfg interface to allow setting memory entitlement and
weight.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 arch/powerpc/kernel/lparcfg.c |  119 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/hvcall.h  |   18 ++++++
 2 files changed, 136 insertions(+), 1 deletion(-)

Index: linux-2.6.git/arch/powerpc/kernel/lparcfg.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/lparcfg.c	2008-07-22 12:50:47.000000000 -0500
+++ linux-2.6.git/arch/powerpc/kernel/lparcfg.c	2008-07-22 13:16:58.000000000 -0500
@@ -35,7 +35,7 @@
 #include <asm/prom.h>
 #include <asm/vdso_datapage.h>
 
-#define MODULE_VERS "1.7"
+#define MODULE_VERS "1.8"
 #define MODULE_NAME "lparcfg"
 
 /* #define LPARCFG_DEBUG */
@@ -129,6 +129,35 @@
 /*
  * Methods used to fetch LPAR data when running on a pSeries platform.
  */
+/**
+ * h_get_mpp
+ * H_GET_MPP hcall returns info in 7 parms
+ */
+int h_get_mpp(struct hvcall_mpp_data *mpp_data)
+{
+	int rc;
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+
+	rc = plpar_hcall9(H_GET_MPP, retbuf);
+
+	mpp_data->entitled_mem = retbuf[0];
+	mpp_data->mapped_mem = retbuf[1];
+
+	mpp_data->group_num = (retbuf[2] >> 2 * 8) & 0xffff;
+	mpp_data->pool_num = retbuf[2] & 0xffff;
+
+	mpp_data->mem_weight = (retbuf[3] >> 7 * 8) & 0xff;
+	mpp_data->unallocated_mem_weight = (retbuf[3] >> 6 * 8) & 0xff;
+	mpp_data->unallocated_entitlement = retbuf[3] & 0xffffffffffff;
+
+	mpp_data->pool_size = retbuf[4];
+	mpp_data->loan_request = retbuf[5];
+	mpp_data->backing_mem = retbuf[6];
+
+	return rc;
+}
+EXPORT_SYMBOL(h_get_mpp);
+
 /*
  * H_GET_PPP hcall returns info in 4 parms.
  *  entitled_capacity,unallocated_capacity,
@@ -224,6 +253,44 @@
 	seq_printf(m, "unallocated_capacity=%ld\n", h_unallocated);
 }
 
+/**
+ * parse_mpp_data
+ * Parse out data returned from h_get_mpp
+ */
+static void parse_mpp_data(struct seq_file *m)
+{
+	struct hvcall_mpp_data mpp_data;
+	int rc;
+
+	rc = h_get_mpp(&mpp_data);
+	if (rc)
+		return;
+
+	seq_printf(m, "entitled_memory=%ld\n", mpp_data.entitled_mem);
+
+	if (mpp_data.mapped_mem != -1)
+		seq_printf(m, "mapped_entitled_memory=%ld\n",
+		           mpp_data.mapped_mem);
+
+	seq_printf(m, "entitled_memory_group_number=%d\n", mpp_data.group_num);
+	seq_printf(m, "entitled_memory_pool_number=%d\n", mpp_data.pool_num);
+
+	seq_printf(m, "entitled_memory_weight=%d\n", mpp_data.mem_weight);
+	seq_printf(m, "unallocated_entitled_memory_weight=%d\n",
+	           mpp_data.unallocated_mem_weight);
+	seq_printf(m, "unallocated_io_mapping_entitlement=%ld\n",
+	           mpp_data.unallocated_entitlement);
+
+	if (mpp_data.pool_size != -1)
+		seq_printf(m, "entitled_memory_pool_size=%ld bytes\n",
+		           mpp_data.pool_size);
+
+	seq_printf(m, "entitled_memory_loan_request=%ld\n",
+	           mpp_data.loan_request);
+
+	seq_printf(m, "backing_memory=%ld bytes\n", mpp_data.backing_mem);
+}
+
 #define SPLPAR_CHARACTERISTICS_TOKEN 20
 #define SPLPAR_MAXLENGTH 1026*(sizeof(char))
 
@@ -351,6 +418,7 @@
 		/* this call handles the ibm,get-system-parameter contents */
 		parse_system_parameter_string(m);
 		parse_ppp_data(m);
+		parse_mpp_data(m);
 
 		seq_printf(m, "purr=%ld\n", get_purr());
 	} else {		/* non SPLPAR case */
@@ -414,6 +482,43 @@
 	return retval;
 }
 
+/**
+ * update_mpp
+ *
+ * Update the memory entitlement and weight for the partition.  Caller must
+ * specify either a new entitlement or weight, not both, to be updated
+ * since the h_set_mpp call takes both entitlement and weight as parameters.
+ */
+static ssize_t update_mpp(u64 *entitlement, u8 *weight)
+{
+	struct hvcall_mpp_data mpp_data;
+	u64 new_entitled;
+	u8 new_weight;
+	ssize_t rc;
+
+	rc = h_get_mpp(&mpp_data);
+	if (rc)
+		return rc;
+
+	if (entitlement) {
+		new_weight = mpp_data.mem_weight;
+		new_entitled = *entitlement;
+	} else if (weight) {
+		new_weight = *weight;
+		new_entitled = mpp_data.entitled_mem;
+	} else
+		return -EINVAL;
+
+	pr_debug("%s: current_entitled = %lu, current_weight = %u\n",
+	         __FUNCTION__, mpp_data.entitled_mem, mpp_data.mem_weight);
+
+	pr_debug("%s: new_entitled = %lu, new_weight = %u\n",
+	         __FUNCTION__, new_entitled, new_weight);
+
+	rc = plpar_hcall_norets(H_SET_MPP, new_entitled, new_weight);
+	return rc;
+}
+
 /*
  * Interface for changing system parameters (variable capacity weight
  * and entitled capacity).  Format of input is "param_name=value";
@@ -467,6 +572,20 @@
 			goto out;
 
 		retval = update_ppp(NULL, new_weight_ptr);
+	} else if (!strcmp(kbuf, "entitled_memory")) {
+		char *endp;
+		*new_entitled_ptr = (u64) simple_strtoul(tmp, &endp, 10);
+		if (endp == tmp)
+			goto out;
+
+		retval = update_mpp(new_entitled_ptr, NULL);
+	} else if (!strcmp(kbuf, "entitled_memory_weight")) {
+		char *endp;
+		*new_weight_ptr = (u8) simple_strtoul(tmp, &endp, 10);
+		if (endp == tmp)
+			goto out;
+
+		retval = update_mpp(NULL, new_weight_ptr);
 	} else
 		goto out;
 
Index: linux-2.6.git/include/asm-powerpc/hvcall.h
===================================================================
--- linux-2.6.git.orig/include/asm-powerpc/hvcall.h	2008-07-22 12:48:55.000000000 -0500
+++ linux-2.6.git/include/asm-powerpc/hvcall.h	2008-07-22 13:16:36.000000000 -0500
@@ -210,7 +210,9 @@
 #define H_JOIN			0x298
 #define H_VASI_STATE            0x2A4
 #define H_ENABLE_CRQ		0x2B0
-#define MAX_HCALL_OPCODE	H_ENABLE_CRQ
+#define H_SET_MPP		0x2D0
+#define H_GET_MPP		0x2D4
+#define MAX_HCALL_OPCODE	H_GET_MPP
 
 #ifndef __ASSEMBLY__
 
@@ -270,6 +272,20 @@
 };
 #define HCALL_STAT_ARRAY_SIZE	((MAX_HCALL_OPCODE >> 2) + 1)
 
+struct hvcall_mpp_data {
+	unsigned long entitled_mem;
+	unsigned long mapped_mem;
+	unsigned short group_num;
+	unsigned short pool_num;
+	unsigned char mem_weight;
+	unsigned char unallocated_mem_weight;
+	unsigned long unallocated_entitlement;  /* value in bytes */
+	unsigned long pool_size;
+	signed long loan_request;
+	unsigned long backing_mem;
+};
+
+int h_get_mpp(struct hvcall_mpp_data *);
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_HVCALL_H */
