Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D297BC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 02:27:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590EF20856
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 02:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590EF20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QcHC6MdPzF39V
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 12:27:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=nfont@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QcDB1Z2RzF36s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 12:24:56 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w942Nq4H128573
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Oct 2018 22:24:54 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mw83tbjkk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Oct 2018 22:24:54 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 3 Oct 2018 20:24:53 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 3 Oct 2018 20:24:52 -0600
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w942OpER50397314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Oct 2018 19:24:51 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43B44C605F;
 Wed,  3 Oct 2018 20:24:51 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4C71C6057;
 Wed,  3 Oct 2018 20:24:49 -0600 (MDT)
Received: from oc6428688403.ibm.com (unknown [9.85.152.87])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed,  3 Oct 2018 20:24:49 -0600 (MDT)
Subject: Re: [PATCH v03 1/5] powerpc/drmem: Export 'dynamic-memory' loader
To: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20181001125846.2676.89826.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001125924.2676.54786.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <87y3bfkfnx.fsf@concordia.ellerman.id.au>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 3 Oct 2018 21:24:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87y3bfkfnx.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100402-0020-0000-0000-00000E720915
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009818; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01097538; UDB=6.00567607; IPR=6.00877580; 
 MB=3.00023603; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-04 02:24:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100402-0021-0000-0000-000063400F57
Message-Id: <3dde35eb-4997-5d61-c94f-d036bd57de18@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-04_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810040023
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

On 10/02/2018 08:00 PM, Michael Ellerman wrote:
> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> 
>> powerpc/drmem: Export many of the functions of DRMEM to parse
>> "ibm,dynamic-memory" and "ibm,dynamic-memory-v2" during hotplug
>> operations and for Post Migration events.
> 
> This isn't a criticism of your patch, but I think the drmem.c code
> should be moved into platforms/pseries.
> 
> That would then make most of it private to platforms/pseries and we
> wouldn't need to export things in arch/powerpc/include/asm.

I don't have an issue with moving it to platform/pseries. I originally
put it in arch/powerpc/mm because the numa code also uses the drmem code.

The numa code was updated so that it could just be given a lmb struct
instead of having to parse the device tree directly for dynamic
reconfiguration memory. Having to support two versions of this dt
property this made more sense.

-Nathan

> 
> 
>> Also modify the DRMEM initialization code to allow it to,
>>
>> * Be called after system initialization
>> * Provide a separate user copy of the LMB array that is produces
>> * Free the user copy upon request
> 
> Is there any reason those can't be done as separate patches?
> 
>> In addition, a couple of changes were made to make the creation
>> of additional copies of the LMB array more useful including,
>>
>> * Add new iterator to work through a pair of drmem_info arrays.
>> * Modify DRMEM code to replace usages of dt_root_addr_cells, and
>>   dt_mem_next_cell, as these are only available at first boot.
> 
> Likewise?
> 
> cheers
> 
>> diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
>> index ce242b9..b0e70fd 100644
>> --- a/arch/powerpc/include/asm/drmem.h
>> +++ b/arch/powerpc/include/asm/drmem.h
>> @@ -35,6 +35,18 @@ struct drmem_lmb_info {
>>  		&drmem_info->lmbs[0],				\
>>  		&drmem_info->lmbs[drmem_info->n_lmbs - 1])
>>  
>> +#define for_each_dinfo_lmb(dinfo, lmb)				\
>> +	for_each_drmem_lmb_in_range((lmb),			\
>> +		&dinfo->lmbs[0],				\
>> +		&dinfo->lmbs[dinfo->n_lmbs - 1])
>> +
>> +#define for_each_pair_dinfo_lmb(dinfo1, lmb1, dinfo2, lmb2)	\
>> +	for ((lmb1) = (&dinfo1->lmbs[0]),			\
>> +	     (lmb2) = (&dinfo2->lmbs[0]);			\
>> +	     ((lmb1) <= (&dinfo1->lmbs[dinfo1->n_lmbs - 1])) &&	\
>> +	     ((lmb2) <= (&dinfo2->lmbs[dinfo2->n_lmbs - 1]));	\
>> +	     (lmb1)++, (lmb2)++)
>> +
>>  /*
>>   * The of_drconf_cell_v1 struct defines the layout of the LMB data
>>   * specified in the ibm,dynamic-memory device tree property.
>> @@ -94,6 +106,9 @@ void __init walk_drmem_lmbs(struct device_node *dn,
>>  			void (*func)(struct drmem_lmb *, const __be32 **));
>>  int drmem_update_dt(void);
>>  
>> +struct drmem_lmb_info *drmem_lmbs_init(struct property *prop);
>> +void drmem_lmbs_free(struct drmem_lmb_info *dinfo);
>> +
>>  #ifdef CONFIG_PPC_PSERIES
>>  void __init walk_drmem_lmbs_early(unsigned long node,
>>  			void (*func)(struct drmem_lmb *, const __be32 **));
>> diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
>> index 3f18036..13d2abb 100644
>> --- a/arch/powerpc/mm/drmem.c
>> +++ b/arch/powerpc/mm/drmem.c
>> @@ -20,6 +20,7 @@
>>  
>>  static struct drmem_lmb_info __drmem_info;
>>  struct drmem_lmb_info *drmem_info = &__drmem_info;
>> +static int n_root_addr_cells;
>>  
>>  u64 drmem_lmb_memory_max(void)
>>  {
>> @@ -193,12 +194,13 @@ int drmem_update_dt(void)
>>  	return rc;
>>  }
>>  
>> -static void __init read_drconf_v1_cell(struct drmem_lmb *lmb,
>> +static void read_drconf_v1_cell(struct drmem_lmb *lmb,
>>  				       const __be32 **prop)
>>  {
>>  	const __be32 *p = *prop;
>>  
>> -	lmb->base_addr = dt_mem_next_cell(dt_root_addr_cells, &p);
>> +	lmb->base_addr = of_read_number(p, n_root_addr_cells);
>> +	p += n_root_addr_cells;
>>  	lmb->drc_index = of_read_number(p++, 1);
>>  
>>  	p++; /* skip reserved field */
>> @@ -209,7 +211,7 @@ static void __init read_drconf_v1_cell(struct drmem_lmb *lmb,
>>  	*prop = p;
>>  }
>>  
>> -static void __init __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
>> +static void __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
>>  			void (*func)(struct drmem_lmb *, const __be32 **))
>>  {
>>  	struct drmem_lmb lmb;
>> @@ -225,13 +227,14 @@ static void __init __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
>>  	}
>>  }
>>  
>> -static void __init read_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
>> +static void read_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
>>  				       const __be32 **prop)
>>  {
>>  	const __be32 *p = *prop;
>>  
>>  	dr_cell->seq_lmbs = of_read_number(p++, 1);
>> -	dr_cell->base_addr = dt_mem_next_cell(dt_root_addr_cells, &p);
>> +	dr_cell->base_addr = of_read_number(p, n_root_addr_cells);
>> +	p += n_root_addr_cells;
>>  	dr_cell->drc_index = of_read_number(p++, 1);
>>  	dr_cell->aa_index = of_read_number(p++, 1);
>>  	dr_cell->flags = of_read_number(p++, 1);
>> @@ -239,7 +242,7 @@ static void __init read_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
>>  	*prop = p;
>>  }
>>  
>> -static void __init __walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *usm,
>> +static void __walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *usm,
>>  			void (*func)(struct drmem_lmb *, const __be32 **))
>>  {
>>  	struct of_drconf_cell_v2 dr_cell;
>> @@ -275,6 +278,9 @@ void __init walk_drmem_lmbs_early(unsigned long node,
>>  	const __be32 *prop, *usm;
>>  	int len;
>>  
>> +	if (n_root_addr_cells == 0)
>> +		n_root_addr_cells = dt_root_addr_cells;
>> +
>>  	prop = of_get_flat_dt_prop(node, "ibm,lmb-size", &len);
>>  	if (!prop || len < dt_root_size_cells * sizeof(__be32))
>>  		return;
>> @@ -353,24 +359,26 @@ void __init walk_drmem_lmbs(struct device_node *dn,
>>  	}
>>  }
>>  
>> -static void __init init_drmem_v1_lmbs(const __be32 *prop)
>> +static void init_drmem_v1_lmbs(const __be32 *prop,
>> +				struct drmem_lmb_info *dinfo)
>>  {
>>  	struct drmem_lmb *lmb;
>>  
>> -	drmem_info->n_lmbs = of_read_number(prop++, 1);
>> -	if (drmem_info->n_lmbs == 0)
>> +	dinfo->n_lmbs = of_read_number(prop++, 1);
>> +	if (dinfo->n_lmbs == 0)
>>  		return;
>>  
>> -	drmem_info->lmbs = kcalloc(drmem_info->n_lmbs, sizeof(*lmb),
>> +	dinfo->lmbs = kcalloc(dinfo->n_lmbs, sizeof(*lmb),
>>  				   GFP_KERNEL);
>> -	if (!drmem_info->lmbs)
>> +	if (!dinfo->lmbs)
>>  		return;
>>  
>> -	for_each_drmem_lmb(lmb)
>> +	for_each_dinfo_lmb(dinfo, lmb)
>>  		read_drconf_v1_cell(lmb, &prop);
>>  }
>>  
>> -static void __init init_drmem_v2_lmbs(const __be32 *prop)
>> +static void init_drmem_v2_lmbs(const __be32 *prop,
>> +				struct drmem_lmb_info *dinfo)
>>  {
>>  	struct drmem_lmb *lmb;
>>  	struct of_drconf_cell_v2 dr_cell;
>> @@ -386,12 +394,12 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
>>  	p = prop;
>>  	for (i = 0; i < lmb_sets; i++) {
>>  		read_drconf_v2_cell(&dr_cell, &p);
>> -		drmem_info->n_lmbs += dr_cell.seq_lmbs;
>> +		dinfo->n_lmbs += dr_cell.seq_lmbs;
>>  	}
>>  
>> -	drmem_info->lmbs = kcalloc(drmem_info->n_lmbs, sizeof(*lmb),
>> +	dinfo->lmbs = kcalloc(dinfo->n_lmbs, sizeof(*lmb),
>>  				   GFP_KERNEL);
>> -	if (!drmem_info->lmbs)
>> +	if (!dinfo->lmbs)
>>  		return;
>>  
>>  	/* second pass, read in the LMB information */
>> @@ -402,10 +410,10 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
>>  		read_drconf_v2_cell(&dr_cell, &p);
>>  
>>  		for (j = 0; j < dr_cell.seq_lmbs; j++) {
>> -			lmb = &drmem_info->lmbs[lmb_index++];
>> +			lmb = &dinfo->lmbs[lmb_index++];
>>  
>>  			lmb->base_addr = dr_cell.base_addr;
>> -			dr_cell.base_addr += drmem_info->lmb_size;
>> +			dr_cell.base_addr += dinfo->lmb_size;
>>  
>>  			lmb->drc_index = dr_cell.drc_index;
>>  			dr_cell.drc_index++;
>> @@ -416,11 +424,38 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
>>  	}
>>  }
>>  
>> +void drmem_lmbs_free(struct drmem_lmb_info *dinfo)
>> +{
>> +	if (dinfo) {
>> +		kfree(dinfo->lmbs);
>> +		kfree(dinfo);
>> +	}
>> +}
>> +
>> +struct drmem_lmb_info *drmem_lmbs_init(struct property *prop)
>> +{
>> +	struct drmem_lmb_info *dinfo;
>> +
>> +	dinfo = kzalloc(sizeof(*dinfo), GFP_KERNEL);
>> +	if (!dinfo)
>> +		return NULL;
>> +
>> +	if (!strcmp("ibm,dynamic-memory", prop->name))
>> +		init_drmem_v1_lmbs(prop->value, dinfo);
>> +	else if (!strcmp("ibm,dynamic-memory-v2", prop->name))
>> +		init_drmem_v2_lmbs(prop->value, dinfo);
>> +
>> +	return dinfo;
>> +}
>> +
>>  static int __init drmem_init(void)
>>  {
>>  	struct device_node *dn;
>>  	const __be32 *prop;
>>  
>> +	if (n_root_addr_cells == 0)
>> +		n_root_addr_cells = dt_root_addr_cells;
>> +
>>  	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
>>  	if (!dn) {
>>  		pr_info("No dynamic reconfiguration memory found\n");
>> @@ -434,11 +469,11 @@ static int __init drmem_init(void)
>>  
>>  	prop = of_get_property(dn, "ibm,dynamic-memory", NULL);
>>  	if (prop) {
>> -		init_drmem_v1_lmbs(prop);
>> +		init_drmem_v1_lmbs(prop, drmem_info);
>>  	} else {
>>  		prop = of_get_property(dn, "ibm,dynamic-memory-v2", NULL);
>>  		if (prop)
>> -			init_drmem_v2_lmbs(prop);
>> +			init_drmem_v2_lmbs(prop, drmem_info);
>>  	}
>>  
>>  	of_node_put(dn);
> 

