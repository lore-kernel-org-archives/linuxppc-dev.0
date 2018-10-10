Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1B3C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 17:26:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44B72085B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 17:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44B72085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Vgxr5mN1zF33c
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 04:26:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=nfont@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VgvR0Q4CzF1fD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 04:24:34 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9AHM77e040281
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 13:24:32 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n1mpvtu1p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 13:24:31 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 10 Oct 2018 13:24:31 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 10 Oct 2018 13:24:29 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9AHOSAF25559184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Oct 2018 17:24:28 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEE98124052;
 Wed, 10 Oct 2018 14:24:14 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EAF6124053;
 Wed, 10 Oct 2018 14:24:14 -0400 (EDT)
Received: from oc6428688403.ibm.com (unknown [9.80.235.83])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 10 Oct 2018 14:24:14 -0400 (EDT)
Subject: Re: [PATCH v04 3/4] migration/memory: Evaluate LMB assoc changes
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20181009203520.26091.86781.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181009203651.26091.63890.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 10 Oct 2018 12:24:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009203651.26091.63890.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101017-0064-0000-0000-0000035D55E6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009855; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100709; UDB=6.00569515; IPR=6.00880757; 
 MB=3.00023699; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-10 17:24:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101017-0065-0000-0000-00003AEF72DB
Message-Id: <a554b6b4-35fe-c830-98d1-ade9042f05a3@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-10_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100165
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
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/09/2018 03:37 PM, Michael Bringmann wrote:
> migration/memory: This patch adds code that recognizes changes to
> the associativity of memory blocks described by the device-tree
> properties in order to drive equivalent 'hotplug' operations to
> update local and general kernel data structures to reflect those
> changes.  These differences may include:
> 
> * Evaluate 'ibm,dynamic-memory' properties when processing the
>   updated device-tree properties of the system during Post Migration
>   events (migration_store).  The new functionality looks for changes
>   to the aa_index values for each drc_index/LMB to identify any memory
>   blocks that should be readded.
> 
> * In an LPAR migration scenario, the "ibm,associativity-lookup-arrays"
>   property may change.  In the event that a row of the array differs,
>   locate all assigned memory blocks with that 'aa_index' and 're-add'
>   them to the system memory block data structures.  In the process of
>   the 're-add', the system routines will update the corresponding entry
>   for the memory in the LMB structures and any other relevant kernel
>   data structures.
> 
> A number of previous extensions made to the DRMEM code for scanning
> device-tree properties and creating LMB arrays are used here to
> ensure that the resulting code is simpler and more usable:
> 
> * Use new paired list iterator for the DRMEM LMB info arrays to find
>   differences in old and new versions of properties.
> * Use new iterator for copies of the DRMEM info arrays to evaluate
>   completely new structures.
> * Combine common code for parsing and evaluating memory description
>   properties based on the DRMEM LMB array model to greatly simplify
>   extension from the older property 'ibm,dynamic-memory' to the new
>   property model of 'ibm,dynamic-memory-v2'.
> 
> For support, add a new pseries hotplug action for DLPAR operations,
> PSERIES_HP_ELOG_ACTION_READD_MULTIPLE.  It is a variant of the READD
> operation which performs the action upon multiple instances of the
> resource at one time.  The operation is to be triggered by device-tree
> analysis of updates by RTAS events analyzed by 'migation_store' during
> post-migration processing.  It will be used for memory updates,
> initially.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> Changes in v04:
>   -- Move dlpar_memory_readd_multiple() function definition and use
>      into previous patch along with action constant definition.
>   -- Correct spacing in patch
> Changes in v03:
>   -- Modify the code that parses the memory affinity attributes to
>      mark relevant DRMEM LMB array entries using the internal_flags
>      mechanism instead of generate unique hotplug actions for each
>      memory block to be readded.  The change is intended to both
>      simplify the code, and to require fewer resources on systems
>      with huge amounts of memory.
>   -- Save up notice about any all LMB entries until the end of the
>      'migration_store' operation at which point a single action is
>      queued to scan the entire DRMEM array.
>   -- Add READD_MULTIPLE function for memory that scans the DRMEM
>      array to identify multiple entries that were marked previously.
>      The corresponding memory blocks are to be readded to the system
>      to update relevant data structures outside of the powerpc-
>      specific code.
>   -- Change dlpar_memory_pmt_changes_action to directly queue worker
>      to pseries work queue.
> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c |  189 +++++++++++++++++++----
>  arch/powerpc/platforms/pseries/mobility.c       |    4 
>  arch/powerpc/platforms/pseries/pseries.h        |    4 
>  3 files changed, 163 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index bf2420a..a7ca22e 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -534,8 +534,11 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
>  		}
>  	}
> 
> -	if (!lmb_found)
> -		rc = -EINVAL;
> +	if (!lmb_found) {
> +		pr_info("Failed to update memory for drc index %lx\n",
> +			(unsigned long) drc_index);
> +		return -EINVAL;
> +	}
> 
>  	if (rc)
>  		pr_info("Failed to update memory at %llx\n",
> @@ -1002,13 +1005,43 @@ static int pseries_add_mem_node(struct device_node *np)
>  	return (ret < 0) ? -EINVAL : 0;
>  }
> 
> -static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
> +static int pmt_changes = 0;
> +
> +void dlpar_memory_pmt_changes_set(void)
> +{
> +	pmt_changes = 1;
> +}
> +
> +void dlpar_memory_pmt_changes_clear(void)
> +{
> +	pmt_changes = 0;
> +}
> +
> +int dlpar_memory_pmt_changes(void)
> +{
> +	return pmt_changes;
> +}
> +
> +void dlpar_memory_pmt_changes_action(void)
> +{
> +	if (dlpar_memory_pmt_changes()) {
> +		struct pseries_hp_errorlog hp_errlog;
> +
> +		hp_errlog.resource = PSERIES_HP_ELOG_RESOURCE_MEM;
> +		hp_errlog.action = PSERIES_HP_ELOG_ACTION_READD_MULTIPLE;
> +		hp_errlog.id_type = 0;
> +
> +		queue_hotplug_event(&hp_errlog, NULL, NULL);
> +
> +		dlpar_memory_pmt_changes_clear();
> +	}
> +}
> +
> +static int pseries_update_drconf_memory(struct drmem_lmb_info *new_dinfo)
>  {
> -	struct of_drconf_cell_v1 *new_drmem, *old_drmem;
> +	struct drmem_lmb *old_lmb, *new_lmb;
>  	unsigned long memblock_size;
> -	u32 entries;
> -	__be32 *p;
> -	int i, rc = -EINVAL;
> +	int rc = 0;
> 
>  	if (rtas_hp_event)
>  		return 0;
> @@ -1017,42 +1050,122 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
>  	if (!memblock_size)
>  		return -EINVAL;
> 
> -	p = (__be32 *) pr->old_prop->value;
> -	if (!p)
> -		return -EINVAL;
> -
> -	/* The first int of the property is the number of lmb's described
> -	 * by the property. This is followed by an array of of_drconf_cell
> -	 * entries. Get the number of entries and skip to the array of
> -	 * of_drconf_cell's.
> -	 */
> -	entries = be32_to_cpu(*p++);
> -	old_drmem = (struct of_drconf_cell_v1 *)p;
> +	/* Arrays should have the same size and DRC indexes */
> +	for_each_pair_dinfo_lmb(drmem_info, old_lmb, new_dinfo, new_lmb) {
> 
> -	p = (__be32 *)pr->prop->value;
> -	p++;
> -	new_drmem = (struct of_drconf_cell_v1 *)p;
> +		if (new_lmb->drc_index != old_lmb->drc_index)
> +			continue;
> 
> -	for (i = 0; i < entries; i++) {
> -		if ((be32_to_cpu(old_drmem[i].flags) & DRCONF_MEM_ASSIGNED) &&
> -		    (!(be32_to_cpu(new_drmem[i].flags) & DRCONF_MEM_ASSIGNED))) {
> +		if ((old_lmb->flags & DRCONF_MEM_ASSIGNED) &&
> +		    (!(new_lmb->flags & DRCONF_MEM_ASSIGNED))) {
>  			rc = pseries_remove_memblock(
> -				be64_to_cpu(old_drmem[i].base_addr),
> -						     memblock_size);
> +				old_lmb->base_addr, memblock_size);
>  			break;
> -		} else if ((!(be32_to_cpu(old_drmem[i].flags) &
> -			    DRCONF_MEM_ASSIGNED)) &&
> -			    (be32_to_cpu(new_drmem[i].flags) &
> -			    DRCONF_MEM_ASSIGNED)) {
> -			rc = memblock_add(be64_to_cpu(old_drmem[i].base_addr),
> -					  memblock_size);
> +		} else if ((!(old_lmb->flags & DRCONF_MEM_ASSIGNED)) &&
> +			   (new_lmb->flags & DRCONF_MEM_ASSIGNED)) {
> +			rc = memblock_add(old_lmb->base_addr,
> +					memblock_size);
>  			rc = (rc < 0) ? -EINVAL : 0;
>  			break;
> +		} else if ((old_lmb->aa_index != new_lmb->aa_index) &&
> +			   (new_lmb->flags & DRCONF_MEM_ASSIGNED)) {
> +			drmem_mark_lmb_update(old_lmb);
> +			dlpar_memory_pmt_changes_set();
>  		}
>  	}
>  	return rc;
>  }
> 
> +static void pseries_update_ala_memory_aai(int aa_index)
> +{
> +	struct drmem_lmb *lmb;
> +
> +	/* Readd all LMBs which were previously using the
> +	 * specified aa_index value.
> +	 */
> +	for_each_drmem_lmb(lmb) {
> +		if ((lmb->aa_index == aa_index) &&
> +			(lmb->flags & DRCONF_MEM_ASSIGNED)) {
> +			drmem_mark_lmb_update(lmb);
> +			dlpar_memory_pmt_changes_set();
> +		}
> +	}
> +}
> +
> +struct assoc_arrays {
> +	u32 n_arrays;
> +	u32 array_sz;
> +	const __be32 *arrays;
> +};

This struct is also defined in arch/powerpc/mm/numa.c. May be a good idea to move the
definition to common place.

> +
> +static int pseries_update_ala_memory(struct of_reconfig_data *pr)
> +{
> +	struct assoc_arrays new_ala, old_ala;
> +	__be32 *p;
> +	int i, lim;
> +
> +	if (rtas_hp_event)
> +		return 0;
> +
> +	/*
> +	 * The layout of the ibm,associativity-lookup-arrays
> +	 * property is a number N indicating the number of
> +	 * associativity arrays, followed by a number M
> +	 * indicating the size of each associativity array,
> +	 * followed by a list of N associativity arrays.
> +	 */
> +
> +	p = (__be32 *) pr->old_prop->value;
> +	if (!p)
> +		return -EINVAL;
> +	old_ala.n_arrays = of_read_number(p++, 1);
> +	old_ala.array_sz = of_read_number(p++, 1);
> +	old_ala.arrays = p;
> +
> +	p = (__be32 *) pr->prop->value;
> +	if (!p)
> +		return -EINVAL;
> +	new_ala.n_arrays = of_read_number(p++, 1);
> +	new_ala.array_sz = of_read_number(p++, 1);
> +	new_ala.arrays = p;
> +
> +	lim = (new_ala.n_arrays > old_ala.n_arrays) ? old_ala.n_arrays :
> +			new_ala.n_arrays;
> +
> +	if (old_ala.array_sz == new_ala.array_sz) {
> +
> +		/* Reset any entries where the old and new rows
> +		 * the array have changed.

Small nit, the wording in that comment could be clearer.

-Nathan

> +		 */
> +		for (i = 0; i < lim; i++) {
> +			int index = (i * new_ala.array_sz);
> +
> +			if (!memcmp(&old_ala.arrays[index],
> +				&new_ala.arrays[index],
> +				new_ala.array_sz))
> +				continue;
> +
> +			pseries_update_ala_memory_aai(i);
> +		}
> +
> +		/* Reset any entries representing the extra rows.
> +		 * There shouldn't be any, but just in case ...
> +		 */
> +		for (i = lim; i < new_ala.n_arrays; i++)
> +			pseries_update_ala_memory_aai(i);
> +
> +	} else {
> +		/* Update all entries representing these rows;
> +		 * as all rows have different sizes, none can
> +		 * have equivalent values.
> +		 */
> +		for (i = 0; i < lim; i++)
> +			pseries_update_ala_memory_aai(i);
> +	}
> +
> +	return 0;
> +}
> +
>  static int pseries_memory_notifier(struct notifier_block *nb,
>  				   unsigned long action, void *data)
>  {
> @@ -1067,8 +1180,16 @@ static int pseries_memory_notifier(struct notifier_block *nb,
>  		err = pseries_remove_mem_node(rd->dn);
>  		break;
>  	case OF_RECONFIG_UPDATE_PROPERTY:
> -		if (!strcmp(rd->prop->name, "ibm,dynamic-memory"))
> -			err = pseries_update_drconf_memory(rd);
> +		if (!strcmp(rd->prop->name, "ibm,dynamic-memory")) {
> +			struct drmem_lmb_info *dinfo =
> +				drmem_lmbs_init(rd->prop);
> +			if (!dinfo)
> +				return -EINVAL;
> +			err = pseries_update_drconf_memory(dinfo);
> +			drmem_lmbs_free(dinfo);
> +		} else if (!strcmp(rd->prop->name,
> +				"ibm,associativity-lookup-arrays"))
> +			err = pseries_update_ala_memory(rd);
>  		break;
>  	}
>  	return notifier_from_errno(err);
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index eba7ef7..c9d3d80 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -373,6 +373,10 @@ static ssize_t migration_store(struct class *class,
>  		return rc;
> 
>  	post_mobility_fixup();
> +
> +	/* Apply any necessary changes identified during fixup */
> +	dlpar_memory_pmt_changes_action();
> +
>  	return count;
>  }
> 
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index 72c0b89..3352f90 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -71,6 +71,10 @@ static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>  	return -EOPNOTSUPP;
>  }
>  #endif
> +void dlpar_memory_pmt_changes_set(void);
> +void dlpar_memory_pmt_changes_clear(void);
> +int dlpar_memory_pmt_changes(void);
> +void dlpar_memory_pmt_changes_action(void);
> 
>  #ifdef CONFIG_HOTPLUG_CPU
>  int dlpar_cpu(struct pseries_hp_errorlog *hp_elog);
> 

