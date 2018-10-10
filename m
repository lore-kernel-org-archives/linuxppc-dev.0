Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE5CC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:14:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6C02087D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6C02087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VfL54JKhzF31q
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 03:14:05 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VfHq2484zF1Q2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 03:12:06 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9AGA5JV135986
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 12:12:04 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n1kghbsjk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 12:12:03 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 10 Oct 2018 12:12:03 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 10 Oct 2018 12:11:59 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9AGBwig66781414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Oct 2018 16:11:58 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F473124058;
 Wed, 10 Oct 2018 13:11:45 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AC42124053;
 Wed, 10 Oct 2018 13:11:44 -0400 (EDT)
Received: from oc6428688403.ibm.com (unknown [9.80.235.83])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 10 Oct 2018 13:11:44 -0400 (EDT)
Subject: Re: [PATCH v3 -next] powerpc/pseries/memory-hotplug: Fix return value
 type of find_aa_index
To: YueHaibing <yuehaibing@huawei.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
References: <20181009135913.14616-1-yuehaibing@huawei.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 10 Oct 2018 11:11:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009135913.14616-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101016-0068-0000-0000-0000034AEBD7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009854; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100685; UDB=6.00569501; IPR=6.00880734; 
 MB=3.00023698; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-10 16:12:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101016-0069-0000-0000-00004606489F
Message-Id: <4fe7e5b0-f1f3-5667-b0d5-8c05ffbf5303@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-10_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=856 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100158
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/09/2018 08:59 AM, YueHaibing wrote:
> 'aa_index' is defined as an unsigned value, but find_aa_index
> may return -1 when dlpar_clone_property fails. So change 
> find_aa_index return value type to bool, which indicate 'aa_index'
> whether found or not.
> 
> Fixes: c05a5a40969e ("powerpc/pseries: Dynamic add entires to associativity lookup array")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Nathan Fontenot nfont@linux.vnet.ibm.com>
 
> ---
> v3: change find_aa_index return type to bool
> v2: use 'rc' track the validation of aa_index
> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c | 61 ++++++++++++-------------
>  1 file changed, 28 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index d26a771..4db510f 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -101,11 +101,12 @@ static struct property *dlpar_clone_property(struct property *prop,
>  	return new_prop;
>  }
> 
> -static u32 find_aa_index(struct device_node *dr_node,
> -			 struct property *ala_prop, const u32 *lmb_assoc)
> +static bool find_aa_index(struct device_node *dr_node,
> +			 struct property *ala_prop,
> +			 const u32 *lmb_assoc, u32 *aa_index)
>  {
> -	u32 *assoc_arrays;
> -	u32 aa_index;
> +	u32 *assoc_arrays, new_prop_size;
> +	struct property *new_prop;
>  	int aa_arrays, aa_array_entries, aa_array_sz;
>  	int i, index;
> 
> @@ -121,46 +122,39 @@ static u32 find_aa_index(struct device_node *dr_node,
>  	aa_array_entries = be32_to_cpu(assoc_arrays[1]);
>  	aa_array_sz = aa_array_entries * sizeof(u32);
> 
> -	aa_index = -1;
>  	for (i = 0; i < aa_arrays; i++) {
>  		index = (i * aa_array_entries) + 2;
> 
>  		if (memcmp(&assoc_arrays[index], &lmb_assoc[1], aa_array_sz))
>  			continue;
> 
> -		aa_index = i;
> -		break;
> +		*aa_index = i;
> +		return true;
>  	}
> 
> -	if (aa_index == -1) {
> -		struct property *new_prop;
> -		u32 new_prop_size;
> -
> -		new_prop_size = ala_prop->length + aa_array_sz;
> -		new_prop = dlpar_clone_property(ala_prop, new_prop_size);
> -		if (!new_prop)
> -			return -1;
> -
> -		assoc_arrays = new_prop->value;
> +	new_prop_size = ala_prop->length + aa_array_sz;
> +	new_prop = dlpar_clone_property(ala_prop, new_prop_size);
> +	if (!new_prop)
> +		return false;
> 
> -		/* increment the number of entries in the lookup array */
> -		assoc_arrays[0] = cpu_to_be32(aa_arrays + 1);
> +	assoc_arrays = new_prop->value;
> 
> -		/* copy the new associativity into the lookup array */
> -		index = aa_arrays * aa_array_entries + 2;
> -		memcpy(&assoc_arrays[index], &lmb_assoc[1], aa_array_sz);
> +	/* increment the number of entries in the lookup array */
> +	assoc_arrays[0] = cpu_to_be32(aa_arrays + 1);
> 
> -		of_update_property(dr_node, new_prop);
> +	/* copy the new associativity into the lookup array */
> +	index = aa_arrays * aa_array_entries + 2;
> +	memcpy(&assoc_arrays[index], &lmb_assoc[1], aa_array_sz);
> 
> -		/*
> -		 * The associativity lookup array index for this lmb is
> -		 * number of entries - 1 since we added its associativity
> -		 * to the end of the lookup array.
> -		 */
> -		aa_index = be32_to_cpu(assoc_arrays[0]) - 1;
> -	}
> +	of_update_property(dr_node, new_prop);
> 
> -	return aa_index;
> +	/*
> +	 * The associativity lookup array index for this lmb is
> +	 * number of entries - 1 since we added its associativity
> +	 * to the end of the lookup array.
> +	 */
> +	*aa_index = be32_to_cpu(assoc_arrays[0]) - 1;
> +	return true;
>  }
> 
>  static int update_lmb_associativity_index(struct drmem_lmb *lmb)
> @@ -169,6 +163,7 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
>  	struct property *ala_prop;
>  	const u32 *lmb_assoc;
>  	u32 aa_index;
> +	bool is_found;
> 
>  	parent = of_find_node_by_path("/");
>  	if (!parent)
> @@ -200,11 +195,11 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
>  		return -ENODEV;
>  	}
> 
> -	aa_index = find_aa_index(dr_node, ala_prop, lmb_assoc);
> +	is_found = find_aa_index(dr_node, ala_prop, lmb_assoc, &aa_index);
> 
>  	dlpar_free_cc_nodes(lmb_node);
> 
> -	if (aa_index < 0) {
> +	if (!is_found) {
>  		pr_err("Could not find LMB associativity\n");
>  		return -1;
>  	}
> 

