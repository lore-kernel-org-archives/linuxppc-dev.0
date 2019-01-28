Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C6EC282CF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 15:43:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A17D20880
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 15:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A17D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pDS950PszDqKJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 02:43:37 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pDQJ4GfCzDqJ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 02:42:00 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0SFadhG081078
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 10:41:57 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qa39gvm1p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 10:41:57 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 28 Jan 2019 15:41:57 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 28 Jan 2019 15:41:54 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0SFfr2e12189764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Jan 2019 15:41:53 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C2B9124052;
 Mon, 28 Jan 2019 15:41:53 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3074124053;
 Mon, 28 Jan 2019 15:41:52 +0000 (GMT)
Received: from oc8380061452.ibm.com (unknown [9.53.179.224])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 28 Jan 2019 15:41:52 +0000 (GMT)
Subject: Re: [PATCH] powerpc/pseries: Perform full re-add of CPU for topology
 update post-migration
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <154083861636.18916.18172276232185726281.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
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
Date: Mon, 28 Jan 2019 09:41:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154083861636.18916.18172276232185726281.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012815-0052-0000-0000-0000037F6B8A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010493; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153034; UDB=6.00601105; IPR=6.00933396; 
 MB=3.00025323; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-28 15:41:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012815-0053-0000-0000-00005FA1D132
Message-Id: <810d1cee-98ce-6e8f-f87b-f9acb8ba35f2@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-28_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280119
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
Cc: ldufour@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/29/18 1:43 PM, Nathan Fontenot wrote:
> On pseries systems, performing a partition migration can result in
> altering the nodes a CPU is assigned to on the destination system. For
> exampl, pre-migration on the source system CPUs are in node 1 and 3,
> post-migration on the destination system CPUs are in nodes 2 and 3.
> 
> Handling the node change for a CPU can cause corruption in the slab
> cache if we hit a timing where a CPUs node is changed while cache_reap()
> is invoked. The corruption occurs because the slab cache code appears
> to rely on the CPU and slab cache pages being on the same node.
> 
> The current dynamic updating of a CPUs node done in arch/powerpc/mm/numa.c
> does not prevent us from hitting this scenario.
> 
> Changing the device tree property update notification handler that
> recognizes an affinity change for a CPU to do a full DLPAR remove and
> add of the CPU instead of dynamically changing its node resolves this
> issue.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com
Signed-off-by: Michael W. Bringmann <mwb@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/topology.h          |    2 ++
>  arch/powerpc/mm/numa.c                       |    9 +--------
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |   19 +++++++++++++++++++
>  3 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index a4a718dbfec6..f85e2b01c3df 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -132,6 +132,8 @@ static inline void shared_proc_topology_init(void) {}
>  #define topology_sibling_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
>  #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
>  #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
> +
> +int dlpar_cpu_readd(int cpu);
>  #endif
>  #endif
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 693ae1c1acba..bb6a7b56bef7 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1461,13 +1461,6 @@ static void reset_topology_timer(void)
> 
>  #ifdef CONFIG_SMP
> 
> -static void stage_topology_update(int core_id)
> -{
> -	cpumask_or(&cpu_associativity_changes_mask,
> -		&cpu_associativity_changes_mask, cpu_sibling_mask(core_id));
> -	reset_topology_timer();
> -}
> -
>  static int dt_update_callback(struct notifier_block *nb,
>  				unsigned long action, void *data)
>  {
> @@ -1480,7 +1473,7 @@ static int dt_update_callback(struct notifier_block *nb,
>  		    !of_prop_cmp(update->prop->name, "ibm,associativity")) {
>  			u32 core_id;
>  			of_property_read_u32(update->dn, "reg", &core_id);
> -			stage_topology_update(core_id);
> +			rc = dlpar_cpu_readd(core_id);
>  			rc = NOTIFY_OK;
>  		}
>  		break;
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 2f8e62163602..97feb6e79f1a 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -802,6 +802,25 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
>  	return rc;
>  }
> 
> +int dlpar_cpu_readd(int cpu)
> +{
> +	struct device_node *dn;
> +	struct device *dev;
> +	u32 drc_index;
> +	int rc;
> +
> +	dev = get_cpu_device(cpu);
> +	dn = dev->of_node;
> +
> +	rc = of_property_read_u32(dn, "ibm,my-drc-index", &drc_index);
> +
> +	rc = dlpar_cpu_remove_by_index(drc_index);
> +	if (!rc)
> +		rc = dlpar_cpu_add(drc_index);
> +
> +	return rc;
> +}
> +
>  int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
>  {
>  	u32 count, drc_index;
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

