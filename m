Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20AFC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 14:23:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D06A2098A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 14:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D06A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QJCh1HRqzF37B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 00:23:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QJ9M233wzDqh2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 00:21:26 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w93EEvYm129385
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Oct 2018 10:21:24 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mvwvm4ptu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Oct 2018 10:21:23 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 3 Oct 2018 08:21:22 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 3 Oct 2018 08:21:20 -0600
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w93ELJsE52166678
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Oct 2018 07:21:19 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02EA5C6061;
 Wed,  3 Oct 2018 08:21:19 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12C50C6055;
 Wed,  3 Oct 2018 08:21:17 -0600 (MDT)
Received: from oc5000245537.ibm.com (unknown [9.80.203.154])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  3 Oct 2018 08:21:17 -0600 (MDT)
Subject: Re: [PATCH v03 4/5] migration/memory: Evaluate LMB assoc changes
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20181001125846.2676.89826.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001130003.2676.44217.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <e5e6c3a5-5bc6-4f64-a045-312b9892e59f@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 xsBNBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAHNLU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPsLAeAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/Us7ATQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABwsBfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Wed, 3 Oct 2018 09:21:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e5e6c3a5-5bc6-4f64-a045-312b9892e59f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100314-0036-0000-0000-00000A437266
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009814; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01097297; UDB=6.00567463; IPR=6.00877339; 
 MB=3.00023600; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-03 14:21:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100314-0037-0000-0000-0000492786FB
Message-Id: <153a4d9d-cd8e-a0e9-fe8d-4c70348b89c8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-03_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810030139
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
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, Juliet Kim <minkim@us.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/02/2018 04:08 PM, Tyrel Datwyler wrote:
> On 10/01/2018 06:00 AM, Michael Bringmann wrote:
>> migration/memory: This patch adds code that recognizes changes to
>> the associativity of memory blocks described by the device-tree
>> properties in order to drive equivalent 'hotplug' operations to
>> update local and general kernel data structures to reflect those
>> changes.  These differences may include:
>>
>> * Evaluate 'ibm,dynamic-memory' properties when processing the
>>   updated device-tree properties of the system during Post Migration
>>   events (migration_store).  The new functionality looks for changes
>>   to the aa_index values for each drc_index/LMB to identify any memory
>>   blocks that should be readded.
>>
>> * In an LPAR migration scenario, the "ibm,associativity-lookup-arrays"
>>   property may change.  In the event that a row of the array differs,
>>   locate all assigned memory blocks with that 'aa_index' and 're-add'
>>   them to the system memory block data structures.  In the process of
>>   the 're-add', the system routines will update the corresponding entry
>>   for the memory in the LMB structures and any other relevant kernel
>>   data structures.
>>
>> A number of previous extensions made to the DRMEM code for scanning
>> device-tree properties and creating LMB arrays are used here to
>> ensure that the resulting code is simpler and more usable:
>>
>> * Use new paired list iterator for the DRMEM LMB info arrays to find
>>   differences in old and new versions of properties.
>> * Use new iterator for copies of the DRMEM info arrays to evaluate
>>   completely new structures.
>> * Combine common code for parsing and evaluating memory description
>>   properties based on the DRMEM LMB array model to greatly simplify
>>   extension from the older property 'ibm,dynamic-memory' to the new
>>   property model of 'ibm,dynamic-memory-v2'.
>>
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> ---
>> Changes in v03:
>>   -- Modify the code that parses the memory affinity attributes to
>>      mark relevant DRMEM LMB array entries using the internal_flags
>>      mechanism instead of generate unique hotplug actions for each
>>      memory block to be readded.  The change is intended to both
>>      simplify the code, and to require fewer resources on systems
>>      with huge amounts of memory.
>>   -- Save up notice about any all LMB entries until the end of the
>>      'migration_store' operation at which point a single action is
>>      queued to scan the entire DRMEM array.
>>   -- Add READD_MULTIPLE function for memory that scans the DRMEM
>>      array to identify multiple entries that were marked previously.
>>      The corresponding memory blocks are to be readded to the system
>>      to update relevant data structures outside of the powerpc-
>>      specific code.
>>   -- Change dlpar_memory_pmt_changes_action to directly queue worker
>>      to pseries work queue.
>> ---
>>  arch/powerpc/platforms/pseries/hotplug-memory.c |  220 +++++++++++++++++++----
>>  arch/powerpc/platforms/pseries/mobility.c       |    4 
>>  arch/powerpc/platforms/pseries/pseries.h        |    4 
>>  3 files changed, 194 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> index c1578f5..68bde2e 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> @@ -561,8 +561,11 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
>>  		}
>>  	}
>>
>> -	if (!lmb_found)
>> -		rc = -EINVAL;
>> +	if (!lmb_found) {
>> +		pr_info("Failed to update memory for drc index %lx\n",
>> +			(unsigned long) drc_index);
>> +		return -EINVAL;
>> +	}
>>
>>  	if (rc)
>>  		pr_info("Failed to update memory at %llx\n",
>> @@ -573,6 +576,30 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
>>  	return rc;
>>  }
>>
>> +static int dlpar_memory_readd_multiple(void)
>> +{
>> +	struct drmem_lmb *lmb;
>> +	int rc;
>> +
>> +	pr_info("Attempting to update multiple LMBs\n");
>> +
>> +	for_each_drmem_lmb(lmb) {
>> +		if (drmem_lmb_update(lmb)) {
>> +			rc = dlpar_remove_lmb(lmb);
>> +
>> +			if (!rc) {
>> +				rc = dlpar_add_lmb(lmb);
>> +				if (rc)
>> +					dlpar_release_drc(lmb->drc_index);
>> +			}
>> +
>> +			drmem_remove_lmb_update(lmb);
>> +		}
>> +	}
>> +
>> +	return rc;
>> +}
>> +
> 
> Actually, in retrospect this function should have been independently implemented in your 3rd patch where you define the flag. So, disregard moving the define into this patch and instead move the function implementation into patch 3 where the commit message talks about adding this operation.

Okay.  It won't hurt to decouple these changes.
> 
>>  static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
>>  {
>>  	struct drmem_lmb *lmb, *start_lmb, *end_lmb;
>> @@ -673,6 +700,10 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
>>  {
>>  	return -EOPNOTSUPP;
>>  }
>> +static int dlpar_memory_readd_multiple(void)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
> 
> Same as above commit obviously.

Okay.
> 
>>
>>  static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
>>  {
>> @@ -952,6 +983,9 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>>  		drc_index = hp_elog->_drc_u.drc_index;
>>  		rc = dlpar_memory_readd_by_index(drc_index);
>>  		break;
>> +	case PSERIES_HP_ELOG_ACTION_READD_MULTIPLE:
>> +		rc = dlpar_memory_readd_multiple();
>> +		break;
> 
> And this as well.

Okay.

> 
> -Tyrel

Michael

> 
>>  	default:
>>  		pr_err("Invalid action (%d) specified\n", hp_elog->action);
>>  		rc = -EINVAL;
>> @@ -994,13 +1028,43 @@ static int pseries_add_mem_node(struct device_node *np)
>>  	return (ret < 0) ? -EINVAL : 0;
>>  }
>>
>> -static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
>> +static int pmt_changes = 0;
>> +
>> +void dlpar_memory_pmt_changes_set(void)
>> +{
>> +	pmt_changes = 1;
>> +}
>> +
>> +void dlpar_memory_pmt_changes_clear(void)
>> +{
>> +	pmt_changes = 0;
>> +}
>> +
>> +int dlpar_memory_pmt_changes(void)
>> +{
>> +	return pmt_changes;
>> +}
>> +
>> +void dlpar_memory_pmt_changes_action(void)
>> +{
>> +	if (dlpar_memory_pmt_changes()) {
>> +		struct pseries_hp_errorlog hp_errlog;
>> +
>> +        	hp_errlog.resource = PSERIES_HP_ELOG_RESOURCE_MEM;
>> +        	hp_errlog.action = PSERIES_HP_ELOG_ACTION_READD_MULTIPLE;
>> +        	hp_errlog.id_type = 0;
>> +
>> +        	queue_hotplug_event(&hp_errlog, NULL, NULL);
>> +
>> +		dlpar_memory_pmt_changes_clear();
>> +	}
>> +}
>> +
>> +static int pseries_update_drconf_memory(struct drmem_lmb_info *new_dinfo)
>>  {
>> -	struct of_drconf_cell_v1 *new_drmem, *old_drmem;
>> +	struct drmem_lmb *old_lmb, *new_lmb;
>>  	unsigned long memblock_size;
>> -	u32 entries;
>> -	__be32 *p;
>> -	int i, rc = -EINVAL;
>> +	int rc = 0;
>>
>>  	if (rtas_hp_event)
>>  		return 0;
>> @@ -1009,42 +1073,122 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
>>  	if (!memblock_size)
>>  		return -EINVAL;
>>
>> -	p = (__be32 *) pr->old_prop->value;
>> -	if (!p)
>> -		return -EINVAL;
>> -
>> -	/* The first int of the property is the number of lmb's described
>> -	 * by the property. This is followed by an array of of_drconf_cell
>> -	 * entries. Get the number of entries and skip to the array of
>> -	 * of_drconf_cell's.
>> -	 */
>> -	entries = be32_to_cpu(*p++);
>> -	old_drmem = (struct of_drconf_cell_v1 *)p;
>> +	/* Arrays should have the same size and DRC indexes */
>> +	for_each_pair_dinfo_lmb(drmem_info, old_lmb, new_dinfo, new_lmb) {
>>
>> -	p = (__be32 *)pr->prop->value;
>> -	p++;
>> -	new_drmem = (struct of_drconf_cell_v1 *)p;
>> +		if (new_lmb->drc_index != old_lmb->drc_index)
>> +			continue;
>>
>> -	for (i = 0; i < entries; i++) {
>> -		if ((be32_to_cpu(old_drmem[i].flags) & DRCONF_MEM_ASSIGNED) &&
>> -		    (!(be32_to_cpu(new_drmem[i].flags) & DRCONF_MEM_ASSIGNED))) {
>> +		if ((old_lmb->flags & DRCONF_MEM_ASSIGNED) &&
>> +		    (!(new_lmb->flags & DRCONF_MEM_ASSIGNED))) {
>>  			rc = pseries_remove_memblock(
>> -				be64_to_cpu(old_drmem[i].base_addr),
>> -						     memblock_size);
>> +				old_lmb->base_addr, memblock_size);
>>  			break;
>> -		} else if ((!(be32_to_cpu(old_drmem[i].flags) &
>> -			    DRCONF_MEM_ASSIGNED)) &&
>> -			    (be32_to_cpu(new_drmem[i].flags) &
>> -			    DRCONF_MEM_ASSIGNED)) {
>> -			rc = memblock_add(be64_to_cpu(old_drmem[i].base_addr),
>> -					  memblock_size);
>> +		} else if ((!(old_lmb->flags & DRCONF_MEM_ASSIGNED)) &&
>> +			   (new_lmb->flags & DRCONF_MEM_ASSIGNED)) {
>> +			rc = memblock_add(old_lmb->base_addr,
>> +					memblock_size);
>>  			rc = (rc < 0) ? -EINVAL : 0;
>>  			break;
>> +		} else if ((old_lmb->aa_index != new_lmb->aa_index) &&
>> +			   (new_lmb->flags & DRCONF_MEM_ASSIGNED)) {
>> +			drmem_mark_lmb_update(old_lmb);
>> +			dlpar_memory_pmt_changes_set();
>>  		}
>>  	}
>>  	return rc;
>>  }
>>
>> +static void pseries_update_ala_memory_aai(int aa_index)
>> +{
>> +	struct drmem_lmb *lmb;
>> +
>> +	/* Readd all LMBs which were previously using the
>> +	 * specified aa_index value.
>> +	 */
>> +	for_each_drmem_lmb(lmb) {
>> +		if ((lmb->aa_index == aa_index) &&
>> +			(lmb->flags & DRCONF_MEM_ASSIGNED)) {
>> +			drmem_mark_lmb_update(lmb);
>> +			dlpar_memory_pmt_changes_set();
>> +		}
>> +	}
>> +}
>> +
>> +struct assoc_arrays {
>> +	u32 n_arrays;
>> +	u32 array_sz;
>> +	const __be32 *arrays;
>> +};
>> +
>> +static int pseries_update_ala_memory(struct of_reconfig_data *pr)
>> +{
>> +	struct assoc_arrays new_ala, old_ala;
>> +	__be32 *p;
>> +	int i, lim;
>> +
>> +	if (rtas_hp_event)
>> +		return 0;
>> +
>> +	/*
>> +	 * The layout of the ibm,associativity-lookup-arrays
>> +	 * property is a number N indicating the number of
>> +	 * associativity arrays, followed by a number M
>> +	 * indicating the size of each associativity array,
>> +	 * followed by a list of N associativity arrays.
>> +	 */
>> +
>> +	p = (__be32 *) pr->old_prop->value;
>> +	if (!p)
>> +		return -EINVAL;
>> +	old_ala.n_arrays = of_read_number(p++, 1);
>> +	old_ala.array_sz = of_read_number(p++, 1);
>> +	old_ala.arrays = p;
>> +
>> +	p = (__be32 *) pr->prop->value;
>> +	if (!p)
>> +		return -EINVAL;
>> +	new_ala.n_arrays = of_read_number(p++, 1);
>> +	new_ala.array_sz = of_read_number(p++, 1);
>> +	new_ala.arrays = p;
>> +
>> +	lim = (new_ala.n_arrays > old_ala.n_arrays) ? old_ala.n_arrays :
>> +			new_ala.n_arrays;
>> +
>> +	if (old_ala.array_sz == new_ala.array_sz) {
>> +
>> +		/* Reset any entries where the old and new rows
>> +		 * the array have changed.
>> +		 */
>> +		for (i = 0; i < lim; i++) {
>> +			int index = (i * new_ala.array_sz);
>> +
>> +			if (!memcmp(&old_ala.arrays[index],
>> +				&new_ala.arrays[index],
>> +				new_ala.array_sz))
>> +				continue;
>> +
>> +			pseries_update_ala_memory_aai(i);
>> +		}
>> +
>> +		/* Reset any entries representing the extra rows.
>> +		 * There shouldn't be any, but just in case ...
>> +		 */
>> +		for (i = lim; i < new_ala.n_arrays; i++)
>> +			pseries_update_ala_memory_aai(i);
>> +
>> +	} else {
>> +		/* Update all entries representing these rows;
>> +		 * as all rows have different sizes, none can
>> +		 * have equivalent values.
>> +		 */
>> +		for (i = 0; i < lim; i++)
>> +			pseries_update_ala_memory_aai(i);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int pseries_memory_notifier(struct notifier_block *nb,
>>  				   unsigned long action, void *data)
>>  {
>> @@ -1059,8 +1203,16 @@ static int pseries_memory_notifier(struct notifier_block *nb,
>>  		err = pseries_remove_mem_node(rd->dn);
>>  		break;
>>  	case OF_RECONFIG_UPDATE_PROPERTY:
>> -		if (!strcmp(rd->prop->name, "ibm,dynamic-memory"))
>> -			err = pseries_update_drconf_memory(rd);
>> +		if (!strcmp(rd->prop->name, "ibm,dynamic-memory")) {
>> +			struct drmem_lmb_info *dinfo =
>> +				drmem_lmbs_init(rd->prop);
>> +			if (!dinfo)
>> +				return -EINVAL;
>> +			err = pseries_update_drconf_memory(dinfo);
>> +			drmem_lmbs_free(dinfo);
>> +		} else if (!strcmp(rd->prop->name,
>> +				"ibm,associativity-lookup-arrays"))
>> +			err = pseries_update_ala_memory(rd);
>>  		break;
>>  	}
>>  	return notifier_from_errno(err);
>> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
>> index 23fb9ac..6c0456f 100644
>> --- a/arch/powerpc/platforms/pseries/mobility.c
>> +++ b/arch/powerpc/platforms/pseries/mobility.c
>> @@ -383,6 +383,10 @@ static ssize_t migration_store(struct class *class,
>>  		return rc;
>>
>>  	post_mobility_fixup();
>> +
>> +	/* Apply any necessary changes identified during fixup */
>> +	dlpar_memory_pmt_changes_action();
>> +
>>  	return count;
>>  }
>>
>> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
>> index 60db2ee..b238634 100644
>> --- a/arch/powerpc/platforms/pseries/pseries.h
>> +++ b/arch/powerpc/platforms/pseries/pseries.h
>> @@ -69,6 +69,10 @@ static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>>  	return -EOPNOTSUPP;
>>  }
>>  #endif
>> +void dlpar_memory_pmt_changes_set(void);
>> +void dlpar_memory_pmt_changes_clear(void);
>> +int dlpar_memory_pmt_changes(void);
>> +void dlpar_memory_pmt_changes_action(void);
>>
>>  #ifdef CONFIG_HOTPLUG_CPU
>>  int dlpar_cpu(struct pseries_hp_errorlog *hp_elog);
>>
> 
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

