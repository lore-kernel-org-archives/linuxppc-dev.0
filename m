Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D1BC282C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 16:13:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFED218D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 16:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFED218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mPFz3KPlzDqQF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 03:13:27 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mPC76SSWzDqPN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 03:10:59 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0PG96tg066505
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 11:10:57 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q837t869y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 11:10:57 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 25 Jan 2019 16:10:55 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 25 Jan 2019 16:10:54 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0PGArTq23003244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Jan 2019 16:10:53 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6540DAE063;
 Fri, 25 Jan 2019 16:10:53 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0BAAAE062;
 Fri, 25 Jan 2019 16:10:52 +0000 (GMT)
Received: from oc8380061452.ibm.com (unknown [9.53.179.224])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 25 Jan 2019 16:10:52 +0000 (GMT)
Subject: Re: [RFC 3/6] pseries/drcinfo: Pseries impl of arch_find_drc_info
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
References: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com>
 <20181214205047.16435.19045.stgit@powerkvm6.aus.stglabs.ibm.com>
 <1ae1ff5e-d95d-3437-fc84-169f6f7d44a7@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
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
Date: Fri, 25 Jan 2019 10:10:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1ae1ff5e-d95d-3437-fc84-169f6f7d44a7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012516-2213-0000-0000-00000344B510
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010475; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01151625; UDB=6.00600248; IPR=6.00931969; 
 MB=3.00025286; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-25 16:10:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012516-2214-0000-0000-00005D1C9EF4
Message-Id: <7deadd90-3033-3d55-c4f0-c2a8458cbe97@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-25_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901250129
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
 nathanl@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Adding Nathan Lynch.

Yes.  We can amend the title.

On 1/24/19 6:04 PM, Tyrel Datwyler wrote:
> On 12/14/2018 12:51 PM, Michael Bringmann wrote:
>> This patch provides a common interface to parse ibm,drc-indexes,
>> ibm,drc-names, ibm,drc-types, ibm,drc-power-domains, or ibm,drc-info.
>> The generic interface arch_find_drc_match is provided which accepts
>> callback functions that may be applied to examine the data for each
>> entry.
>>
> 
> The title of your patch is "pseries/drcinfo: Pseries impl of arch_find_drc_info"
> but the name of the function you are ultimately implementing is
> arch_find_drc_match if I'm not mistaken.
> 
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/prom.h             |    3 
>>  arch/powerpc/platforms/pseries/of_helpers.c |  299 +++++++++++++++++++++++++++
>>  include/linux/topology.h                    |    2 
>>  3 files changed, 298 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
>> index b04c5ce..910d1dc 100644
>> --- a/arch/powerpc/include/asm/prom.h
>> +++ b/arch/powerpc/include/asm/prom.h
>> @@ -91,9 +91,6 @@ struct of_drc_info {
>>  	u32 last_drc_index;
>>  };
>>  
>> -extern int of_read_drc_info_cell(struct property **prop,
>> -			const __be32 **curval, struct of_drc_info *data);
>> -
>>  
>>  /*
>>   * There are two methods for telling firmware what our capabilities are.
>> diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
>> index 0185e50..11c90cd 100644
>> --- a/arch/powerpc/platforms/pseries/of_helpers.c
>> +++ b/arch/powerpc/platforms/pseries/of_helpers.c
>> @@ -1,5 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  
>> +#define pr_fmt(fmt) "drc: " fmt
>> +
>>  #include <linux/string.h>
>>  #include <linux/err.h>
>>  #include <linux/slab.h>
>> @@ -11,6 +13,12 @@
>>  
>>  #define	MAX_DRC_NAME_LEN 64
>>  
>> +static int drc_debug;
>> +#define dbg(args...) if (drc_debug) { printk(KERN_DEBUG args); }
>> +#define err(arg...) printk(KERN_ERR args);
>> +#define info(arg...) printk(KERN_INFO args);
>> +#define warn(arg...) printk(KERN_WARNING args);
> 
> Its pretty standard these days to use the pr_debug, pr_err, pr_info, pr_warn
> variations over printk(LEVEL args).
> 
>> +
>>  /**
>>   * pseries_of_derive_parent - basically like dirname(1)
>>   * @path:  the full_name of a node to be added to the tree
>> @@ -46,7 +54,8 @@ struct device_node *pseries_of_derive_parent(const char *path)
>>  
>>  /* Helper Routines to convert between drc_index to cpu numbers */
>>  
>> -int of_read_drc_info_cell(struct property **prop, const __be32 **curval,
>> +static int of_read_drc_info_cell(struct property **prop,
>> +			const __be32 **curval,
>>  			struct of_drc_info *data)
>>  {
>>  	const char *p;
>> @@ -90,4 +99,290 @@ int of_read_drc_info_cell(struct property **prop, const __be32 **curval,
>>  
>>  	return 0;
>>  }
>> -EXPORT_SYMBOL(of_read_drc_info_cell);
>> +
>> +static int walk_drc_info(struct device_node *dn,
>> +		bool (*usercb)(struct of_drc_info *drc,
>> +				void *data,
>> +				int *ret_code),
>> +		char *opt_drc_type,
>> +		void *data)
>> +{
>> +	struct property *info;
>> +	unsigned int entries;
>> +	struct of_drc_info drc;
>> +	const __be32 *value;
>> +	int j, ret_code = -EINVAL;
>> +	bool done = false;
>> +
>> +	info = of_find_property(dn, "ibm,drc-info", NULL);
>> +	if (info == NULL)
>> +		return -EINVAL;
>> +
>> +	value = info->value;
>> +	entries = of_read_number(value++, 1);
>> +
>> +	for (j = 0, done = 0; (j < entries) && (!done); j++) {
>> +		of_read_drc_info_cell(&info, &value, &drc);
>> +
>> +		if (opt_drc_type && strcmp(opt_drc_type, drc.drc_type))
>> +			continue;
>> +
>> +		done = usercb(&drc, data, &ret_code);
>> +	}
>> +
>> +	return ret_code;
>> +}
>> +
>> +static int get_children_props(struct device_node *dn, const int **drc_indexes,
>> +		const int **drc_names, const int **drc_types,
>> +		const int **drc_power_domains)
>> +{
>> +	const int *indexes, *names, *types, *domains;
>> +
>> +	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
>> +	names = of_get_property(dn, "ibm,drc-names", NULL);
>> +	types = of_get_property(dn, "ibm,drc-types", NULL);
>> +	domains = of_get_property(dn, "ibm,drc-power-domains", NULL);
>> +
>> +	if (!indexes || !names || !types || !domains) {
>> +		/* Slot does not have dynamically-removable children */
>> +		return -EINVAL;
>> +	}
>> +	if (drc_indexes)
>> +		*drc_indexes = indexes;
>> +	if (drc_names)
>> +		/* &drc_names[1] contains NULL terminated slot names */
>> +		*drc_names = names;
>> +	if (drc_types)
>> +		/* &drc_types[1] contains NULL terminated slot types */
>> +		*drc_types = types;
>> +	if (drc_power_domains)
>> +		*drc_power_domains = domains;
>> +
>> +	return 0;
>> +}
>> +
>> +static int is_php_type(char *drc_type)
>> +{
>> +	unsigned long value;
>> +	char *endptr;
>> +
>> +	/* PCI Hotplug nodes have an integer for drc_type */
>> +	value = simple_strtoul(drc_type, &endptr, 10);
>> +	if (endptr == drc_type)
>> +		return 0;
>> +
>> +	return 1;
>> +}
>> +
>> +/**
>> + * is_php_dn() - return 1 if this is a hotpluggable pci slot, else 0
>> + * @dn: target &device_node
>> + * @indexes: passed to get_children_props()
>> + * @names: passed to get_children_props()
>> + * @types: returned from get_children_props()
>> + * @power_domains:
>> + *
>> + * This routine will return true only if the device node is
>> + * a hotpluggable slot. This routine will return false
>> + * for built-in pci slots (even when the built-in slots are
>> + * dlparable.)
>> + */
>> +static int is_php_dn(struct device_node *dn, const int **indexes,
>> +		const int **names, const int **types,
>> +		const int **power_domains)
>> +{
>> +	const int *drc_types;
>> +	int rc;
>> +
>> +	rc = get_children_props(dn, indexes, names, &drc_types,
>> +				power_domains);
>> +	if (rc < 0)
>> +		return 0;
>> +
>> +	if (!is_php_type((char *) &drc_types[1]))
>> +		return 0;
>> +
>> +	*types = drc_types;
>> +	return 1;
>> +}
>> +
>> +struct find_drc_match_cb_struct {
>> +	struct device_node *dn;
>> +	bool (*usercb)(struct device_node *dn,
>> +			u32 drc_index, char *drc_name,
>> +			char *drc_type, u32 drc_power_domain,
>> +			void *data);
>> +	char *drc_type;
>> +	char *drc_name;
>> +	u32 drc_index;
>> +	bool match_drc_index;
>> +	bool add_slot;
>> +	void *data;
>> +};
>> +
>> +static int find_drc_match_v1(struct device_node *dn, void *data)
>> +{
>> +	struct find_drc_match_cb_struct *cdata = data;
>> +	int i, retval = 0;
>> +	const int *indexes, *names, *types, *domains;
>> +	char *name, *type;
>> +	struct device_node *root = dn;
>> +
>> +	if (cdata->match_drc_index)
>> +		root = dn->parent;
>> +
>> +	if (cdata->add_slot) {
>> +		/* If this is not a hotplug slot, return without doing
>> +		 * anything.
>> +		 */
>> +		if (!is_php_dn(root, &indexes, &names, &types, &domains))
>> +			return 0;
>> +	} else {
>> +		if (get_children_props(root, &indexes, &names, &types,
>> +			&domains) < 0)
>> +			return 0;
>> +	}
>> +
>> +	dbg("Entry %s: dn=%pOF\n", __func__, dn);
>> +
>> +	name = (char *) &names[1];
>> +	type = (char *) &types[1];
>> +	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
>> +
>> +		if (cdata->match_drc_index &&
>> +			((unsigned int) indexes[i + 1] != cdata->drc_index)) {
>> +			name += strlen(name) + 1;
>> +			type += strlen(type) + 1;
>> +			continue;
>> +		}
>> +
>> +		if (((cdata->drc_name == NULL) ||
>> +		     (cdata->drc_name && !strcmp(cdata->drc_name, name))) &&
>> +		    ((cdata->drc_type == NULL) ||
>> +		     (cdata->drc_type && !strcmp(cdata->drc_type, type)))) {
>> +
>> +			if (cdata->usercb) {
>> +				retval = cdata->usercb(dn,
>> +					be32_to_cpu(indexes[i + 1]),
>> +					name, type,
>> +					be32_to_cpu(domains[i + 1]),
>> +					cdata->data);
>> +				if (!retval)
>> +					return retval;
>> +			} else {
>> +				return 0;
>> +			}
>> +		}
>> +
>> +		name += strlen(name) + 1;
>> +		type += strlen(type) + 1;
>> +	}
>> +
>> +	dbg("%s - Exit: rc[%d]\n", __func__, retval);
>> +
>> +	/* XXX FIXME: reports a failure only if last entry in loop failed */
>> +	return retval;
>> +}
>> +
>> +static bool find_drc_match_v2_cb(struct of_drc_info *drc, void *data,
>> +				int *ret_code)
>> +{
>> +	struct find_drc_match_cb_struct *cdata = data;
>> +	u32 drc_index;
>> +	char drc_name[MAX_DRC_NAME_LEN];
>> +	int i, retval;
>> +
>> +	(*ret_code) = -EINVAL;
>> +
>> +	/* This set not a PHP type? */
>> +	if (cdata->add_slot) {
>> +		if (!is_php_type((char *) drc->drc_type)) {
>> +			return false;
>> +		}
>> +	}
>> +
>> +	/* Anything to use from this set? */
>> +	if (cdata->match_drc_index && (cdata->drc_index > drc->last_drc_index))
>> +		return false;
>> +	if ((cdata->drc_type && strcmp(cdata->drc_type, drc->drc_type))
>> +		return false;
>> +
>> +	/* Check the drc-index entries of this set */
>> +	for (i = 0, drc_index = drc->drc_index_start;
>> +		i < drc->num_sequential_elems; i++, drc_index++) {
>> +
>> +		if (cdata->match_drc_index && (cdata->drc_index != drc_index))
>> +			continue;
>> +
>> +		sprintf(drc_name, "%s%d", drc->drc_name_prefix,
>> +			drc_index - drc->drc_index_start +
>> +			drc->drc_name_suffix_start);
>> +
>> +		if ((cdata->drc_name == NULL) ||
>> +		    (cdata->drc_name && !strcmp(cdata->drc_name, drc_name))) {
>> +
>> +			if (cdata->usercb) {
>> +				retval = cdata->usercb(cdata->dn,
>> +						drc_index, drc_name,
>> +						drc->drc_type,
>> +						drc->drc_power_domain,
>> +						cdata->data);
>> +				if (!retval) {
>> +					(*ret_code) = retval;
>> +					return true;
>> +				}
>> +			} else {
>> +				(*ret_code) = 0;
>> +				return true;
>> +			}
>> +		}
>> +	}
>> +
>> +	(*ret_code) = retval;
>> +	return false;
>> +}
>> +
>> +static int find_drc_match_v2(struct device_node *dn, void *data)
>> +{
>> +	struct find_drc_match_cb_struct *cdata = data;
>> +	struct device_node *root = cdata->dn;
>> +
>> +	if (!cdata->add_slot) {
>> +		if (!cdata->drc_type ||
>> +			(cdata->drc_type && strcmp(cdata->drc_type, "SLOT")))
>> +			root = dn->parent;
>> +	}
>> +
>> +	return walk_drc_info(root, find_drc_match_v2_cb, NULL, data);
>> +}
>> +
>> +int arch_find_drc_match(struct device_node *dn,
>> +			bool (*usercb)(struct device_node *dn,
>> +				u32 drc_index, char *drc_name,
>> +				char *drc_type, u32 drc_power_domain,
>> +				void *data),
>> +			char *opt_drc_type, char *opt_drc_name,
>> +			bool match_drc_index, bool add_slot,
>> +			void *data)
>> +{
>> +	struct find_drc_match_cb_struct cdata = { dn, usercb,
>> +			opt_drc_type, opt_drc_name, 0,
>> +			match_drc_index, add_slot, data };
>> +
>> +	if (match_drc_index) {
>> +		const int *my_index =
>> +			of_get_property(dn, "ibm,my-drc-index", NULL);
>> +		if (!my_index) {
>> +			/* Node isn't DLPAR/hotplug capable */
>> +			return -EINVAL;
>> +		}
>> +		cdata.drc_index = *my_index;
>> +	}
>> +
>> +	if (firmware_has_feature(FW_FEATURE_DRC_INFO))
>> +		return find_drc_match_v2(dn, &cdata);
>> +	else
>> +		return find_drc_match_v1(dn, &cdata);
>> +}
>> +EXPORT_SYMBOL(arch_find_drc_match);
>> diff --git a/include/linux/topology.h b/include/linux/topology.h
>> index df97f5f..c3dfa53 100644
>> --- a/include/linux/topology.h
>> +++ b/include/linux/topology.h
>> @@ -50,7 +50,7 @@ int arch_find_drc_match(struct device_node *dn,
>>  				char *drc_type, u32 drc_power_domain,
>>  				void *data),
>>  			char *opt_drc_type, char *opt_drc_name,
>> -			bool match_drc_index, bool ck_php_type,
>> +			bool match_drc_index, bool add_slot,
>>  			void *data);
> 
> Why are you making a change to the prototype here? You should just define it in
> your first patch instead of touching it again here.
> 
> -Tyrel
> 
>>  
>>  /* Conform to ACPI 2.0 SLIT distance definitions */
>>
> 
> 

-- 
Michael W. Bringmann
Linux I/O, Networking and Security Development
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

