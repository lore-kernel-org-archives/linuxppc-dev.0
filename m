Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BACC169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 17:09:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F4B2086C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 17:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F4B2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ptJT1SdRzDqMk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 04:09:13 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ptF45RQPzDqKj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 04:06:16 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0TGwrhV100543
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 12:06:14 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qaqx5u4bw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 12:06:14 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 29 Jan 2019 17:06:12 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 29 Jan 2019 17:06:11 -0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0TH6AGh19267698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Jan 2019 17:06:10 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31D6EBE058;
 Tue, 29 Jan 2019 17:06:10 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94E53BE059;
 Tue, 29 Jan 2019 17:06:09 +0000 (GMT)
Received: from oc8380061452.ibm.com (unknown [9.53.179.224])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 29 Jan 2019 17:06:09 +0000 (GMT)
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20190129165514.14612.16201.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [REPOST PATCH v07 4/5] migration/memory: Evaluate LMB assoc changes
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 mQENBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAG0LU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPokBOAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/UrkBDQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABiQEfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Tue, 29 Jan 2019 11:06:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012917-0016-0000-0000-0000097C4A69
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010499; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153539; UDB=6.00601409; IPR=6.00933905; 
 MB=3.00025341; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-29 17:06:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012917-0017-0000-0000-000041F4641B
Message-Id: <84cccd62-8aae-9bb4-b661-56407ae5df99@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-29_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290127
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
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, Juliet Kim <minkim@us.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Lynch <nathanl@linux.vnet.ibm.com>
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
Changes in v07:
  -- Ensure return value from dlpar_memory_readd_multiple
Changes in v06:
  -- Rebase to powerpc next branch to account for recent code changes.
  -- Fix prototype problem when CONFIG_MEMORY_HOTPLUG not defined.
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
 arch/powerpc/platforms/pseries/hotplug-memory.c |  209 +++++++++++++++++++----
 arch/powerpc/platforms/pseries/mobility.c       |    3 
 arch/powerpc/platforms/pseries/pseries.h        |    8 +
 5 files changed, 187 insertions(+), 46 deletions(-)

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
index 693ae1c..f1e7287 100644
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
index 9c76345..f7a40f4 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -537,8 +537,11 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
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
@@ -552,7 +555,7 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
 static int dlpar_memory_readd_multiple(void)
 {
 	struct drmem_lmb *lmb;
-	int rc;
+	int rc = 0;
 
 	pr_info("Attempting to update multiple LMBs\n");
 
@@ -998,55 +1001,173 @@ static int pseries_add_mem_node(struct device_node *np)
 	return (ret < 0) ? -EINVAL : 0;
 }
 
-static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
+static int pmt_changes = 0;
+
+void dlpar_memory_pmt_changes_set(void)
 {
-	struct of_drconf_cell_v1 *new_drmem, *old_drmem;
+	pmt_changes = 1;
+}
+
+void dlpar_memory_pmt_changes_clear(void)
+{
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
@@ -1063,8 +1184,16 @@ static int pseries_memory_notifier(struct notifier_block *nb,
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
index 7da222d..2557a42 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -380,6 +380,9 @@ static ssize_t migration_store(struct class *class,
 
 	post_mobility_fixup();
 
+	/* Apply any necessary changes identified during fixup */
+	dlpar_memory_pmt_changes_action();
+
 	start_topology_update();
 
 	return count;
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 72c0b89..0c33f79 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -63,13 +63,21 @@ extern struct device_node *dlpar_configure_connector(__be32,
 void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog);
 int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_errlog);
 
+void dlpar_memory_pmt_changes_set(void);
+void dlpar_memory_pmt_changes_clear(void);
+int dlpar_memory_pmt_changes(void);
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
+void dlpar_memory_pmt_changes_action(void);
 #else
 static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 {
 	return -EOPNOTSUPP;
 }
+static inline void dlpar_memory_pmt_changes_action(void)
+{
+}
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU

