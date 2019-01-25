Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F2BC282C6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 16:16:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C27218DE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 16:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C27218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mPKr0XPjzDqQF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 03:16:48 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mPDd4lPfzDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 03:12:17 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0PG9X1n121922
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 11:12:14 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q83mc76jd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 11:12:13 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 25 Jan 2019 16:12:12 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 25 Jan 2019 16:12:10 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0PGC9vD20709522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Jan 2019 16:12:09 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F41ECAE062;
 Fri, 25 Jan 2019 16:12:08 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D01DAE05C;
 Fri, 25 Jan 2019 16:12:08 +0000 (GMT)
Received: from oc8380061452.ibm.com (unknown [9.53.179.224])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 25 Jan 2019 16:12:08 +0000 (GMT)
Subject: Re: [RFC 5/6] powerpc/pci/hotplug: Use common drcinfo parsing
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com>
 <20181214205120.16435.46952.stgit@powerkvm6.aus.stglabs.ibm.com>
 <20190115002857.GG33971@google.com>
 <d49202ed-7886-8dd1-1f9e-801512b49827@linux.vnet.ibm.com>
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
Date: Fri, 25 Jan 2019 10:12:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d49202ed-7886-8dd1-1f9e-801512b49827@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012516-2213-0000-0000-00000344B52C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010475; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01151626; UDB=6.00600248; IPR=6.00931970; 
 MB=3.00025286; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-25 16:12:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012516-2214-0000-0000-00005D1CA029
Message-Id: <09e75552-fe02-a9ef-8f39-4855ee294ec4@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-25_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
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
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Juliet Kim <minkim@us.ibm.com>,
 Paul Mackerras <paulus@samba.org>, nathanl@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Adding Nathan Lynch.

On 1/24/19 6:29 PM, Tyrel Datwyler wrote:
> On 01/14/2019 04:28 PM, Bjorn Helgaas wrote:
>> On Fri, Dec 14, 2018 at 02:51:31PM -0600, Michael Bringmann wrote:
>>> The implementation of the pseries-specific drc info properties
>>> is currently implemented in pseries-specific and non-pseries-specific
>>> files.  This patch set uses a new implementation of the device-tree
>>> parsing code for the properties.
>>>
>>> This patch refactors parsing of the pseries-specific drc-info properties
>>> out of rpaphp_core.c to use the common parser.  In the case where an
>>> architecture does not use these properties, an __weak copy of the
>>> function is provided with dummy return values.  Changes include creating
>>> appropriate callback functions and passing callback-specific data
>>> blocks into arch_find_drc_match.  All functions that were used just
>>> to support the previous parsing implementation have been moved.
>>>
>>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>>
>> This is fine with me.  Any rpaphp_core.c maintainers want to comment?
>> Tyrel?
> 
> It greatly simplifies the code in rpaphp_core.c, and as far as I can tell the
> refactoring maintains the existing functionality.
> 
> Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> 
>>
>> $ ./scripts/get_maintainer.pl -f drivers/pci/hotplug/rpaphp_core.c
>> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> (supporter:IBM Power PCI Hotplug Driver for RPA-compliant...)
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))
>> Paul Mackerras <paulus@samba.org> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))
>> Michael Ellerman <mpe@ellerman.id.au> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))
>>
>>> ---
>>>  drivers/pci/hotplug/rpaphp_core.c |  232 ++++---------------------------------
>>>  1 file changed, 28 insertions(+), 204 deletions(-)
>>>
>>> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
>>> index bcd5d35..9ad7384 100644
>>> --- a/drivers/pci/hotplug/rpaphp_core.c
>>> +++ b/drivers/pci/hotplug/rpaphp_core.c
>>> @@ -154,182 +154,18 @@ static enum pci_bus_speed get_max_bus_speed(struct slot *slot)
>>>  	return speed;
>>>  }
>>>  
>>> -static int get_children_props(struct device_node *dn, const int **drc_indexes,
>>> -		const int **drc_names, const int **drc_types,
>>> -		const int **drc_power_domains)
>>> -{
>>> -	const int *indexes, *names, *types, *domains;
>>> -
>>> -	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
>>> -	names = of_get_property(dn, "ibm,drc-names", NULL);
>>> -	types = of_get_property(dn, "ibm,drc-types", NULL);
>>> -	domains = of_get_property(dn, "ibm,drc-power-domains", NULL);
>>> -
>>> -	if (!indexes || !names || !types || !domains) {
>>> -		/* Slot does not have dynamically-removable children */
>>> -		return -EINVAL;
>>> -	}
>>> -	if (drc_indexes)
>>> -		*drc_indexes = indexes;
>>> -	if (drc_names)
>>> -		/* &drc_names[1] contains NULL terminated slot names */
>>> -		*drc_names = names;
>>> -	if (drc_types)
>>> -		/* &drc_types[1] contains NULL terminated slot types */
>>> -		*drc_types = types;
>>> -	if (drc_power_domains)
>>> -		*drc_power_domains = domains;
>>> -
>>> -	return 0;
>>> -}
>>> -
>>> -
>>>  /* Verify the existence of 'drc_name' and/or 'drc_type' within the
>>> - * current node.  First obtain it's my-drc-index property.  Next,
>>> - * obtain the DRC info from it's parent.  Use the my-drc-index for
>>> - * correlation, and obtain/validate the requested properties.
>>> + * current node.
>>>   */
>>>  
>>> -static int rpaphp_check_drc_props_v1(struct device_node *dn, char *drc_name,
>>> -				char *drc_type, unsigned int my_index)
>>> -{
>>> -	char *name_tmp, *type_tmp;
>>> -	const int *indexes, *names;
>>> -	const int *types, *domains;
>>> -	int i, rc;
>>> -
>>> -	rc = get_children_props(dn->parent, &indexes, &names, &types, &domains);
>>> -	if (rc < 0) {
>>> -		return -EINVAL;
>>> -	}
>>> -
>>> -	name_tmp = (char *) &names[1];
>>> -	type_tmp = (char *) &types[1];
>>> -
>>> -	/* Iterate through parent properties, looking for my-drc-index */
>>> -	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
>>> -		if ((unsigned int) indexes[i + 1] == my_index)
>>> -			break;
>>> -
>>> -		name_tmp += (strlen(name_tmp) + 1);
>>> -		type_tmp += (strlen(type_tmp) + 1);
>>> -	}
>>> -
>>> -	if (((drc_name == NULL) || (drc_name && !strcmp(drc_name, name_tmp))) &&
>>> -	    ((drc_type == NULL) || (drc_type && !strcmp(drc_type, type_tmp))))
>>> -		return 0;
>>> -
>>> -	return -EINVAL;
>>> -}
>>> -
>>> -static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
>>> -				char *drc_type, unsigned int my_index)
>>> -{
>>> -	struct property *info;
>>> -	unsigned int entries;
>>> -	struct of_drc_info drc;
>>> -	const __be32 *value;
>>> -	char cell_drc_name[MAX_DRC_NAME_LEN];
>>> -	int j, fndit;
>>> -
>>> -	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
>>> -	if (info == NULL)
>>> -		return -EINVAL;
>>> -
>>> -	value = of_prop_next_u32(info, NULL, &entries);
>>> -	if (!value)
>>> -		return -EINVAL;
>>> -
>>> -	for (j = 0; j < entries; j++) {
>>> -		of_read_drc_info_cell(&info, &value, &drc);
>>> -
>>> -		/* Should now know end of current entry */
>>> -
>>> -		if (my_index > drc.last_drc_index)
>>> -			continue;
>>> -
>>> -		fndit = 1;
>>> -		break;
>>> -	}
>>> -	/* Found it */
>>> -
>>> -	if (fndit)
>>> -		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix, 
>>> -			my_index);
>>> -
>>> -	if (((drc_name == NULL) ||
>>> -	     (drc_name && !strcmp(drc_name, cell_drc_name))) &&
>>> -	    ((drc_type == NULL) ||
>>> -	     (drc_type && !strcmp(drc_type, drc.drc_type))))
>>> -		return 0;
>>> -
>>> -	return -EINVAL;
>>> -}
>>> -
>>>  int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
>>>  			char *drc_type)
>>>  {
>>> -	const unsigned int *my_index;
>>> -
>>> -	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
>>> -	if (!my_index) {
>>> -		/* Node isn't DLPAR/hotplug capable */
>>> -		return -EINVAL;
>>> -	}
>>> -
>>> -	if (firmware_has_feature(FW_FEATURE_DRC_INFO))
>>> -		return rpaphp_check_drc_props_v2(dn, drc_name, drc_type,
>>> -						*my_index);
>>> -	else
>>> -		return rpaphp_check_drc_props_v1(dn, drc_name, drc_type,
>>> -						*my_index);
>>> +	return arch_find_drc_match(dn, NULL, drc_type, drc_name,
>>> +				true, false, NULL);
>>>  }
>>>  EXPORT_SYMBOL_GPL(rpaphp_check_drc_props);
>>>  
>>> -
>>> -static int is_php_type(char *drc_type)
>>> -{
>>> -	unsigned long value;
>>> -	char *endptr;
>>> -
>>> -	/* PCI Hotplug nodes have an integer for drc_type */
>>> -	value = simple_strtoul(drc_type, &endptr, 10);
>>> -	if (endptr == drc_type)
>>> -		return 0;
>>> -
>>> -	return 1;
>>> -}
>>> -
>>> -/**
>>> - * is_php_dn() - return 1 if this is a hotpluggable pci slot, else 0
>>> - * @dn: target &device_node
>>> - * @indexes: passed to get_children_props()
>>> - * @names: passed to get_children_props()
>>> - * @types: returned from get_children_props()
>>> - * @power_domains:
>>> - *
>>> - * This routine will return true only if the device node is
>>> - * a hotpluggable slot. This routine will return false
>>> - * for built-in pci slots (even when the built-in slots are
>>> - * dlparable.)
>>> - */
>>> -static int is_php_dn(struct device_node *dn, const int **indexes,
>>> -		const int **names, const int **types, const int **power_domains)
>>> -{
>>> -	const int *drc_types;
>>> -	int rc;
>>> -
>>> -	rc = get_children_props(dn, indexes, names, &drc_types, power_domains);
>>> -	if (rc < 0)
>>> -		return 0;
>>> -
>>> -	if (!is_php_type((char *) &drc_types[1]))
>>> -		return 0;
>>> -
>>> -	*types = drc_types;
>>> -	return 1;
>>> -}
>>> -
>>>  /**
>>>   * rpaphp_add_slot -- declare a hotplug slot to the hotplug subsystem.
>>>   * @dn: device node of slot
>>> @@ -346,54 +182,42 @@ static int is_php_dn(struct device_node *dn, const int **indexes,
>>>   *
>>>   * To remove a slot, it suffices to call rpaphp_deregister_slot().
>>>   */
>>> -int rpaphp_add_slot(struct device_node *dn)
>>> +
>>> +static int rpaphp_add_slot_cb(struct device_node *dn,
>>> +			u32 drc_index, char *drc_name, char *drc_type,
>>> +			u32 drc_power_domain, void *data)
>>>  {
>>>  	struct slot *slot;
>>>  	int retval = 0;
>>> -	int i;
>>> -	const int *indexes, *names, *types, *power_domains;
>>> -	char *name, *type;
>>> -
>>> -	if (!dn->name || strcmp(dn->name, "pci"))
>>> -		return 0;
>>> -
>>> -	/* If this is not a hotplug slot, return without doing anything. */
>>> -	if (!is_php_dn(dn, &indexes, &names, &types, &power_domains))
>>> -		return 0;
>>> -
>>> -	dbg("Entry %s: dn=%pOF\n", __func__, dn);
>>>  
>>> -	/* register PCI devices */
>>> -	name = (char *) &names[1];
>>> -	type = (char *) &types[1];
>>> -	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
>>> -		int index;
>>> +	slot = alloc_slot_struct(dn, drc_index, drc_name, drc_power_domain);
>>> +	if (!slot)
>>> +		return -ENOMEM;
>>>  
>>> -		index = be32_to_cpu(indexes[i + 1]);
>>> -		slot = alloc_slot_struct(dn, index, name,
>>> -					 be32_to_cpu(power_domains[i + 1]));
>>> -		if (!slot)
>>> -			return -ENOMEM;
>>> +	slot->type = simple_strtoul(drc_type, NULL, 10);
>>> +	if (retval)
>>> +		return -EINVAL;
>>>  
>>> -		slot->type = simple_strtoul(type, NULL, 10);
>>> +	dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
>>> +		drc_index, drc_name, drc_type);
>>>  
>>> -		dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
>>> -				index, name, type);
>>> +	retval = rpaphp_enable_slot(slot);
>>> +	if (!retval)
>>> +		retval = rpaphp_register_slot(slot);
>>>  
>>> -		retval = rpaphp_enable_slot(slot);
>>> -		if (!retval)
>>> -			retval = rpaphp_register_slot(slot);
>>> +	if (retval)
>>> +		dealloc_slot_struct(slot);
>>>  
>>> -		if (retval)
>>> -			dealloc_slot_struct(slot);
>>> +	return retval;
>>> +}
>>>  
>>> -		name += strlen(name) + 1;
>>> -		type += strlen(type) + 1;
>>> -	}
>>> -	dbg("%s - Exit: rc[%d]\n", __func__, retval);
>>> +int rpaphp_add_slot(struct device_node *dn)
>>> +{
>>> +	if (!dn->name || strcmp(dn->name, "pci"))
>>> +		return 0;
>>>  
>>> -	/* XXX FIXME: reports a failure only if last entry in loop failed */
>>> -	return retval;
>>> +	return arch_find_drc_match(dn, rpaphp_add_slot_cb,
>>> +			NULL, NULL, false, true, NULL);
>>>  }
>>>  EXPORT_SYMBOL_GPL(rpaphp_add_slot);
>>>  
>>>
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

