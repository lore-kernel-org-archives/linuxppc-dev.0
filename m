Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EBBC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 21:44:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5096020652
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 21:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5096020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XdX12GHyzF3J1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 08:44:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XdKr5ScqzF3Fb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 08:35:44 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9DLXnle061387
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 17:35:42 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n3ndjmu2a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 17:35:42 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sat, 13 Oct 2018 15:35:42 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 13 Oct 2018 15:35:39 -0600
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9DLZc0n18808880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 13 Oct 2018 14:35:38 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 887727805E;
 Sat, 13 Oct 2018 15:35:38 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47AD97805C;
 Sat, 13 Oct 2018 15:35:38 -0600 (MDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (unknown [9.40.195.192])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 13 Oct 2018 15:35:38 -0600 (MDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltcalpine2-lp9.aus.stglabs.ibm.com (Postfix) with ESMTP id DFAB620FBAB7;
 Sat, 13 Oct 2018 16:35:37 -0500 (CDT)
Subject: [PATCH v05 4/5] migration/memory: Evaluate LMB assoc changes
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mwb@linux.vnet.ibm.com
Date: Sat, 13 Oct 2018 16:35:37 -0500
In-Reply-To: <20181013213434.4237.33531.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
References: <20181013213434.4237.33531.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101321-0012-0000-0000-000016C80230
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009874; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01102233; UDB=6.00570430; IPR=6.00882279; 
 MB=3.00023746; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-13 21:35:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101321-0013-0000-0000-000054BF0BFE
Message-Id: <20181013213531.4237.95830.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-13_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810130202
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Juliet Kim <minkim@us.ibm.com>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

migration/memory: This patch adds code that recognizes changes to
the associativity of memory blocks described by the device-tree
properties in order to drive equivalent 'hotplug' operations to
update local and general kernel data structures to reflect those
changes.  These differences may include:

* Evaluate 'ibm,dynamic-memory' properties when processing the
  updated device-tree properties of the system during Post Migration
  events (migration_store).  The new functionality looks for changes
  to the aa_index values for each drc_index/LMB to identify any memory
  blocks that should be readded.

* In an LPAR migration scenario, the "ibm,associativity-lookup-arrays"
  property may change.  In the event that a row of the array differs,
  locate all assigned memory blocks with that 'aa_index' and 're-add'
  them to the system memory block data structures.  In the process of
  the 're-add', the system routines will update the corresponding entry
  for the memory in the LMB structures and any other relevant kernel
  data structures.

A number of previous extensions made to the DRMEM code for scanning
device-tree properties and creating LMB arrays are used here to
ensure that the resulting code is simpler and more usable:

* Use new paired list iterator for the DRMEM LMB info arrays to find
  differences in old and new versions of properties.
* Use new iterator for copies of the DRMEM info arrays to evaluate
  completely new structures.
* Combine common code for parsing and evaluating memory description
  properties based on the DRMEM LMB array model to greatly simplify
  extension from the older property 'ibm,dynamic-memory' to the new
  property model of 'ibm,dynamic-memory-v2'.

For support, add a new pseries hotplug action for DLPAR operations,
PSERIES_HP_ELOG_ACTION_READD_MULTIPLE.  It is a variant of the READD
operation which performs the action upon multiple instances of the
resource at one time.  The operation is to be triggered by device-tree
analysis of updates by RTAS events analyzed by 'migation_store' during
post-migration processing.  It will be used for memory updates,
initially.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in v05:
  -- Move common structure from numa.c + hotplug-memory.c to header file.
  -- Clarify some comments.
  -- Use walk_drmem_lmbs_pairs and callback instead of local loop
Changes in v04:
  -- Move dlpar_memory_readd_multiple() function definition and use
     into previous patch along with action constant definition.
  -- Correct spacing in patch
Changes in v03:
  -- Modify the code that parses the memory affinity attributes to
     mark relevant DRMEM LMB array entries using the internal_flags
     mechanism instead of generate unique hotplug actions for each
     memory block to be readded.  The change is intended to both
     simplify the code, and to require fewer resources on systems
     with huge amounts of memory.
  -- Save up notice about any all LMB entries until the end of the
     'migration_store' operation at which point a single action is
     queued to scan the entire DRMEM array.
  -- Add READD_MULTIPLE function for memory that scans the DRMEM
     array to identify multiple entries that were marked previously.
     The corresponding memory blocks are to be readded to the system
     to update relevant data structures outside of the powerpc-
     specific code.
  -- Change dlpar_memory_pmt_changes_action to directly queue worker
     to pseries work queue.
---
 arch/powerpc/include/asm/topology.h             |    7 +
 arch/powerpc/mm/numa.c                          |    6 -
 arch/powerpc/platforms/pseries/hotplug-memory.c |  207 +++++++++++++++++++----
 arch/powerpc/platforms/pseries/mobility.c       |    4 
 arch/powerpc/platforms/pseries/pseries.h        |    4 
 5 files changed, 183 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index a4a718d..fbe03df 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -135,5 +135,12 @@ static inline void shared_proc_topology_init(void) {}
 #endif
 #endif
 
+
+struct assoc_arrays {
+	u32 n_arrays;
+	u32 array_sz;
+	const __be32 *arrays;
+};
+
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_TOPOLOGY_H */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b5a71ba..ab881e3 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -368,12 +368,6 @@ static unsigned long read_n_cells(int n, const __be32 **buf)
 	return result;
 }
 
-struct assoc_arrays {
-	u32	n_arrays;
-	u32	array_sz;
-	const __be32 *arrays;
-};
-
 /*
  * Retrieve and validate the list of associativity arrays for drconf
  * memory from the ibm,associativity-lookup-arrays property of the
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 2b12deb..6df5722 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -542,8 +542,11 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
 		}
 	}
 
-	if (!lmb_found)
-		rc = -EINVAL;
+	if (!lmb_found) {
+		pr_info("Failed to update memory for drc index %lx\n",
+			(unsigned long) drc_index);
+		return -EINVAL;
+	}
 
 	if (rc)
 		pr_info("Failed to update memory at %llx\n",
@@ -1003,55 +1006,173 @@ static int pseries_add_mem_node(struct device_node *np)
 	return (ret < 0) ? -EINVAL : 0;
 }
 
-static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
+static int pmt_changes = 0;
+
+void dlpar_memory_pmt_changes_set(void)
+{
+	pmt_changes = 1;
+}
+
+void dlpar_memory_pmt_changes_clear(void)
 {
-	struct of_drconf_cell_v1 *new_drmem, *old_drmem;
+	pmt_changes = 0;
+}
+
+int dlpar_memory_pmt_changes(void)
+{
+	return pmt_changes;
+}
+
+void dlpar_memory_pmt_changes_action(void)
+{
+	if (dlpar_memory_pmt_changes()) {
+		struct pseries_hp_errorlog hp_errlog;
+
+		hp_errlog.resource = PSERIES_HP_ELOG_RESOURCE_MEM;
+		hp_errlog.action = PSERIES_HP_ELOG_ACTION_READD_MULTIPLE;
+		hp_errlog.id_type = 0;
+
+		queue_hotplug_event(&hp_errlog);
+
+		dlpar_memory_pmt_changes_clear();
+	}
+}
+
+struct dlpar_memory_lmb_chk_affinity_data {
 	unsigned long memblock_size;
-	u32 entries;
-	__be32 *p;
-	int i, rc = -EINVAL;
+};
+
+int dlpar_memory_lmb_chk_affinity(struct drmem_lmb *old_lmb,
+				  struct drmem_lmb *new_lmb,
+				  void *data)
+{
+	struct dlpar_memory_lmb_chk_affinity_data *ldata = data;
+	int rc = 1;
+
+	if (new_lmb->drc_index != old_lmb->drc_index)
+		return rc;
+
+	if ((old_lmb->flags & DRCONF_MEM_ASSIGNED) &&
+	    (!(new_lmb->flags & DRCONF_MEM_ASSIGNED))) {
+		rc = pseries_remove_memblock(
+				old_lmb->base_addr,
+				ldata->memblock_size);
+	} else if ((!(old_lmb->flags & DRCONF_MEM_ASSIGNED)) &&
+			(new_lmb->flags & DRCONF_MEM_ASSIGNED)) {
+		rc = memblock_add(old_lmb->base_addr,
+				ldata->memblock_size);
+		rc = (rc < 0) ? -EINVAL : 0;
+	} else if ((old_lmb->aa_index != new_lmb->aa_index) &&
+			(new_lmb->flags & DRCONF_MEM_ASSIGNED)) {
+		drmem_mark_lmb_update(old_lmb);
+		dlpar_memory_pmt_changes_set();
+	}
+
+	return rc;
+}
+
+static int pseries_update_drconf_memory(struct drmem_lmb_info *new_dinfo)
+{
+	struct dlpar_memory_lmb_chk_affinity_data data;
+	int rc = 0;
 
 	if (rtas_hp_event)
 		return 0;
 
-	memblock_size = pseries_memory_block_size();
-	if (!memblock_size)
+	data.memblock_size = pseries_memory_block_size();
+	if (!data.memblock_size)
 		return -EINVAL;
 
+	/* Arrays should have the same size and DRC indexes */
+	rc = walk_drmem_lmbs_pairs(new_dinfo,
+			dlpar_memory_lmb_chk_affinity, &data);
+	return rc;
+}
+
+static void pseries_update_ala_memory_aai(int aa_index)
+{
+	struct drmem_lmb *lmb;
+
+	/* Readd all LMBs which were previously using the
+	 * specified aa_index value.
+	 */
+	for_each_drmem_lmb(lmb) {
+		if ((lmb->aa_index == aa_index) &&
+			(lmb->flags & DRCONF_MEM_ASSIGNED)) {
+			drmem_mark_lmb_update(lmb);
+			dlpar_memory_pmt_changes_set();
+		}
+	}
+}
+
+static int pseries_update_ala_memory(struct of_reconfig_data *pr)
+{
+	struct assoc_arrays new_ala, old_ala;
+	__be32 *p;
+	int i, lim;
+
+	if (rtas_hp_event)
+		return 0;
+
+	/*
+	 * The layout of the ibm,associativity-lookup-arrays
+	 * property is a number N indicating the number of
+	 * associativity arrays, followed by a number M
+	 * indicating the size of each associativity array,
+	 * followed by a list of N associativity arrays.
+	 */
+
 	p = (__be32 *) pr->old_prop->value;
 	if (!p)
 		return -EINVAL;
+	old_ala.n_arrays = of_read_number(p++, 1);
+	old_ala.array_sz = of_read_number(p++, 1);
+	old_ala.arrays = p;
 
-	/* The first int of the property is the number of lmb's described
-	 * by the property. This is followed by an array of of_drconf_cell
-	 * entries. Get the number of entries and skip to the array of
-	 * of_drconf_cell's.
-	 */
-	entries = be32_to_cpu(*p++);
-	old_drmem = (struct of_drconf_cell_v1 *)p;
-
-	p = (__be32 *)pr->prop->value;
-	p++;
-	new_drmem = (struct of_drconf_cell_v1 *)p;
-
-	for (i = 0; i < entries; i++) {
-		if ((be32_to_cpu(old_drmem[i].flags) & DRCONF_MEM_ASSIGNED) &&
-		    (!(be32_to_cpu(new_drmem[i].flags) & DRCONF_MEM_ASSIGNED))) {
-			rc = pseries_remove_memblock(
-				be64_to_cpu(old_drmem[i].base_addr),
-						     memblock_size);
-			break;
-		} else if ((!(be32_to_cpu(old_drmem[i].flags) &
-			    DRCONF_MEM_ASSIGNED)) &&
-			    (be32_to_cpu(new_drmem[i].flags) &
-			    DRCONF_MEM_ASSIGNED)) {
-			rc = memblock_add(be64_to_cpu(old_drmem[i].base_addr),
-					  memblock_size);
-			rc = (rc < 0) ? -EINVAL : 0;
-			break;
+	p = (__be32 *) pr->prop->value;
+	if (!p)
+		return -EINVAL;
+	new_ala.n_arrays = of_read_number(p++, 1);
+	new_ala.array_sz = of_read_number(p++, 1);
+	new_ala.arrays = p;
+
+	lim = (new_ala.n_arrays > old_ala.n_arrays) ? old_ala.n_arrays :
+			new_ala.n_arrays;
+
+	if (old_ala.array_sz == new_ala.array_sz) {
+
+		/* Iterate comparing rows of the old and new
+		 * ibm,associativity-lookup-arrays looking for
+		 * changes.  If a row has changed, then mark all
+		 * memory blocks using that index for readd.
+		 */
+		for (i = 0; i < lim; i++) {
+			int index = (i * new_ala.array_sz);
+
+			if (!memcmp(&old_ala.arrays[index],
+				&new_ala.arrays[index],
+				new_ala.array_sz))
+				continue;
+
+			pseries_update_ala_memory_aai(i);
 		}
+
+		/* Reset any entries representing the extra rows.
+		 * There shouldn't be any, but just in case ...
+		 */
+		for (i = lim; i < new_ala.n_arrays; i++)
+			pseries_update_ala_memory_aai(i);
+
+	} else {
+		/* Update all entries representing these rows;
+		 * as all rows have different sizes, none can
+		 * have equivalent values.
+		 */
+		for (i = 0; i < lim; i++)
+			pseries_update_ala_memory_aai(i);
 	}
-	return rc;
+
+	return 0;
 }
 
 static int pseries_memory_notifier(struct notifier_block *nb,
@@ -1068,8 +1189,16 @@ static int pseries_memory_notifier(struct notifier_block *nb,
 		err = pseries_remove_mem_node(rd->dn);
 		break;
 	case OF_RECONFIG_UPDATE_PROPERTY:
-		if (!strcmp(rd->prop->name, "ibm,dynamic-memory"))
-			err = pseries_update_drconf_memory(rd);
+		if (!strcmp(rd->prop->name, "ibm,dynamic-memory")) {
+			struct drmem_lmb_info *dinfo =
+				drmem_lmbs_init(rd->prop);
+			if (!dinfo)
+				return -EINVAL;
+			err = pseries_update_drconf_memory(dinfo);
+			drmem_lmbs_free(dinfo);
+		} else if (!strcmp(rd->prop->name,
+				"ibm,associativity-lookup-arrays"))
+			err = pseries_update_ala_memory(rd);
 		break;
 	}
 	return notifier_from_errno(err);
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 2f0f512..0df0171 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -377,6 +377,10 @@ static ssize_t migration_store(struct class *class,
 		return rc;
 
 	post_mobility_fixup();
+
+	/* Apply any necessary changes identified during fixup */
+	dlpar_memory_pmt_changes_action();
+
 	return count;
 }
 
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 72c0b89..3352f90 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -71,6 +71,10 @@ static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 	return -EOPNOTSUPP;
 }
 #endif
+void dlpar_memory_pmt_changes_set(void);
+void dlpar_memory_pmt_changes_clear(void);
+int dlpar_memory_pmt_changes(void);
+void dlpar_memory_pmt_changes_action(void);
 
 #ifdef CONFIG_HOTPLUG_CPU
 int dlpar_cpu(struct pseries_hp_errorlog *hp_elog);

