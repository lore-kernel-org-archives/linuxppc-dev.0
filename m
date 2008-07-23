Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26AAEDE82E
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 04:27:35 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6NIRUEK000593
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:27:30 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6NIRUMB200532
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:27:30 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6NIRUWw027951
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:27:30 -0400
Date: Wed, 23 Jul 2008 13:27:30 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 03/16 v4] powerpc: Add memory entitlement capabilities to
	/proc/ppc64/lparcfg
Message-ID: <20080723182730.GF12905@linux.vnet.ibm.com>
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

=46rom: Nathan Fontenot <nfont@austin.ibm.com>

Update /proc/ppc64/lparcfg to enable displaying of Cooperative Memory
Overcommitment statistics as reported by the H_GET_MPP hcall.  This also
updates the lparcfg interface to allow setting memory entitlement and
weight.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
Updated patch, increment the lparcfg module version number.

---
 arch/powerpc/kernel/lparcfg.c |  121 +++++++++++++++++++++++++++++++++++++=
+++++
 include/asm-powerpc/hvcall.h  |   18 ++++++
 2 files changed, 137 insertions(+), 2 deletions(-)

Index: b/arch/powerpc/kernel/lparcfg.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -35,7 +35,7 @@
 #include <asm/prom.h>
 #include <asm/vdso_datapage.h>
=20
-#define MODULE_VERS "1.7"
+#define MODULE_VERS "1.8"
 #define MODULE_NAME "lparcfg"
=20
 /* #define LPARCFG_DEBUG */
@@ -129,6 +129,35 @@ static int iseries_lparcfg_data(struct s
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
+	rc =3D plpar_hcall9(H_GET_MPP, retbuf);
+
+	mpp_data->entitled_mem =3D retbuf[0];
+	mpp_data->mapped_mem =3D retbuf[1];
+
+	mpp_data->group_num =3D (retbuf[2] >> 2 * 8) & 0xffff;
+	mpp_data->pool_num =3D retbuf[2] & 0xffff;
+
+	mpp_data->mem_weight =3D (retbuf[3] >> 7 * 8) & 0xff;
+	mpp_data->unallocated_mem_weight =3D (retbuf[3] >> 6 * 8) & 0xff;
+	mpp_data->unallocated_entitlement =3D retbuf[3] & 0xffffffffffff;
+
+	mpp_data->pool_size =3D retbuf[4];
+	mpp_data->loan_request =3D retbuf[5];
+	mpp_data->backing_mem =3D retbuf[6];
+
+	return rc;
+}
+EXPORT_SYMBOL(h_get_mpp);
+
 /*
  * H_GET_PPP hcall returns info in 4 parms.
  *  entitled_capacity,unallocated_capacity,
@@ -224,6 +253,44 @@ static void parse_ppp_data(struct seq_fi
 	seq_printf(m, "unallocated_capacity=3D%ld\n", h_unallocated);
 }
=20
+/**
+ * parse_mpp_data
+ * Parse out data returned from h_get_mpp
+ */
+static void parse_mpp_data(struct seq_file *m)
+{
+	struct hvcall_mpp_data mpp_data;
+	int rc;
+
+	rc =3D h_get_mpp(&mpp_data);
+	if (rc)
+		return;
+
+	seq_printf(m, "entitled_memory=3D%ld\n", mpp_data.entitled_mem);
+
+	if (mpp_data.mapped_mem !=3D -1)
+		seq_printf(m, "mapped_entitled_memory=3D%ld\n",
+		           mpp_data.mapped_mem);
+
+	seq_printf(m, "entitled_memory_group_number=3D%d\n", mpp_data.group_num);
+	seq_printf(m, "entitled_memory_pool_number=3D%d\n", mpp_data.pool_num);
+
+	seq_printf(m, "entitled_memory_weight=3D%d\n", mpp_data.mem_weight);
+	seq_printf(m, "unallocated_entitled_memory_weight=3D%d\n",
+	           mpp_data.unallocated_mem_weight);
+	seq_printf(m, "unallocated_io_mapping_entitlement=3D%ld\n",
+	           mpp_data.unallocated_entitlement);
+
+	if (mpp_data.pool_size !=3D -1)
+		seq_printf(m, "entitled_memory_pool_size=3D%ld bytes\n",
+		           mpp_data.pool_size);
+
+	seq_printf(m, "entitled_memory_loan_request=3D%ld\n",
+	           mpp_data.loan_request);
+
+	seq_printf(m, "backing_memory=3D%ld bytes\n", mpp_data.backing_mem);
+}
+
 #define SPLPAR_CHARACTERISTICS_TOKEN 20
 #define SPLPAR_MAXLENGTH 1026*(sizeof(char))
=20
@@ -351,6 +418,7 @@ static int pseries_lparcfg_data(struct s
 		/* this call handles the ibm,get-system-parameter contents */
 		parse_system_parameter_string(m);
 		parse_ppp_data(m);
+		parse_mpp_data(m);
=20
 		seq_printf(m, "purr=3D%ld\n", get_purr());
 	} else {		/* non SPLPAR case */
@@ -414,6 +482,43 @@ static ssize_t update_ppp(u64 *entitleme
 	return retval;
 }
=20
+/**
+ * update_mpp
+ *
+ * Update the memory entitlement and weight for the partition.  Caller must
+ * specify either a new entitlement or weight, not both, to be updated
+ * since the h_set_mpp call takes both entitlement and weight as parameter=
s.
+ */
+static ssize_t update_mpp(u64 *entitlement, u8 *weight)
+{
+	struct hvcall_mpp_data mpp_data;
+	u64 new_entitled;
+	u8 new_weight;
+	ssize_t rc;
+
+	rc =3D h_get_mpp(&mpp_data);
+	if (rc)
+		return rc;
+
+	if (entitlement) {
+		new_weight =3D mpp_data.mem_weight;
+		new_entitled =3D *entitlement;
+	} else if (weight) {
+		new_weight =3D *weight;
+		new_entitled =3D mpp_data.entitled_mem;
+	} else
+		return -EINVAL;
+
+	pr_debug("%s: current_entitled =3D %lu, current_weight =3D %u\n",
+	         __FUNCTION__, mpp_data.entitled_mem, mpp_data.mem_weight);
+
+	pr_debug("%s: new_entitled =3D %lu, new_weight =3D %u\n",
+	         __FUNCTION__, new_entitled, new_weight);
+
+	rc =3D plpar_hcall_norets(H_SET_MPP, new_entitled, new_weight);
+	return rc;
+}
+
 /*
  * Interface for changing system parameters (variable capacity weight
  * and entitled capacity).  Format of input is "param_name=3Dvalue";
@@ -467,6 +572,20 @@ static ssize_t lparcfg_write(struct file
 			goto out;
=20
 		retval =3D update_ppp(NULL, new_weight_ptr);
+	} else if (!strcmp(kbuf, "entitled_memory")) {
+		char *endp;
+		*new_entitled_ptr =3D (u64) simple_strtoul(tmp, &endp, 10);
+		if (endp =3D=3D tmp)
+			goto out;
+
+		retval =3D update_mpp(new_entitled_ptr, NULL);
+	} else if (!strcmp(kbuf, "entitled_memory_weight")) {
+		char *endp;
+		*new_weight_ptr =3D (u8) simple_strtoul(tmp, &endp, 10);
+		if (endp =3D=3D tmp)
+			goto out;
+
+		retval =3D update_mpp(NULL, new_weight_ptr);
 	} else
 		goto out;
=20
Index: b/include/asm-powerpc/hvcall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-powerpc/hvcall.h
+++ b/include/asm-powerpc/hvcall.h
@@ -210,7 +210,9 @@
 #define H_JOIN			0x298
 #define H_VASI_STATE            0x2A4
 #define H_ENABLE_CRQ		0x2B0
-#define MAX_HCALL_OPCODE	H_ENABLE_CRQ
+#define H_SET_MPP		0x2D0
+#define H_GET_MPP		0x2D4
+#define MAX_HCALL_OPCODE	H_GET_MPP
=20
 #ifndef __ASSEMBLY__
=20
@@ -270,6 +272,20 @@ struct hcall_stats {
 };
 #define HCALL_STAT_ARRAY_SIZE	((MAX_HCALL_OPCODE >> 2) + 1)
=20
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
