Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E39C43143
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 20:27:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C487206B7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 20:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C487206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MNWs1H5rzF3Lh
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 06:27:21 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MNTg17lpzDqSk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 06:25:26 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8SKNvLA137146
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 16:25:25 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2msqswgtau-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 16:25:24 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 28 Sep 2018 16:25:23 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 28 Sep 2018 16:25:22 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8SKPLNk45875286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Sep 2018 20:25:21 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67744124053;
 Fri, 28 Sep 2018 17:25:22 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84ABF124052;
 Fri, 28 Sep 2018 17:25:21 -0400 (EDT)
Received: from oc6428688403.ibm.com (unknown [9.41.179.188])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
 Fri, 28 Sep 2018 17:25:21 -0400 (EDT)
Subject: Re: [PATCH -next] powerpc/pseries/memory-hotplug: Fix return value
 type of find_aa_index
To: YueHaibing <yuehaibing@huawei.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
References: <20180921103759.24976-1-yuehaibing@huawei.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 28 Sep 2018 15:25:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921103759.24976-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092820-0072-0000-0000-000003AC4AE3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009787; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01095025; UDB=6.00566095; IPR=6.00875060; 
 MB=3.00023547; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-28 20:25:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092820-0073-0000-0000-000049945160
Message-Id: <8428ad73-f817-5d8b-5472-67b9b33b8626@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-09-28_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=774 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280200
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

On 09/21/2018 05:37 AM, YueHaibing wrote:
> find_aa_index will return -1 when dlpar_clone_property fails,
> its return value type should be int. Also the caller
> update_lmb_associativity_index should use a int variable to
> get it,then compared with 0.

The aa_index that we are handling here is defined as an unsigned value
in the PAPR so I'm a little hesitant in changing it to a signed value.
Also, changing the aa_index to be signed, we still assign it to the
u32 lmb->aa_index.

There are some other places where the aa_index is treated as a signed value
in finc_aa_index(). Perhaps the better solution is use an rc value to track
the validation of finding the aa_index instead of the aa_index value itself.

-Nathan 

> 
> Fixes: c05a5a40969e ("powerpc/pseries: Dynamic add entires to associativity lookup array")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 9a15d39..6aad17c 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -101,13 +101,12 @@ static struct property *dlpar_clone_property(struct property *prop,
>  	return new_prop;
>  }
> 
> -static u32 find_aa_index(struct device_node *dr_node,
> +static int find_aa_index(struct device_node *dr_node,
>  			 struct property *ala_prop, const u32 *lmb_assoc)
>  {
>  	u32 *assoc_arrays;
> -	u32 aa_index;
>  	int aa_arrays, aa_array_entries, aa_array_sz;
> -	int i, index;
> +	int i, index, aa_index;
> 
>  	/*
>  	 * The ibm,associativity-lookup-arrays property is defined to be
> @@ -168,7 +167,7 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
>  	struct device_node *parent, *lmb_node, *dr_node;
>  	struct property *ala_prop;
>  	const u32 *lmb_assoc;
> -	u32 aa_index;
> +	int aa_index;
> 
>  	parent = of_find_node_by_path("/");
>  	if (!parent)
> 

