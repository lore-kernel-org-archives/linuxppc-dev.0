Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10186C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 12:46:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6611B20855
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 12:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6611B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433RVS1q3szDqMg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 23:46:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433RR717hnzDqS0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 23:43:11 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAQCclci063377
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 07:43:09 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p0f1fnvcy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 07:43:09 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 26 Nov 2018 12:43:08 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 26 Nov 2018 12:43:04 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAQCh4es44105820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Nov 2018 12:43:04 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 021CB112061;
 Mon, 26 Nov 2018 12:43:04 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95B43112064;
 Mon, 26 Nov 2018 12:43:03 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.68.112])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 26 Nov 2018 12:43:03 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id B75152E2DEA; Mon, 26 Nov 2018 18:12:54 +0530 (IST)
Date: Mon, 26 Nov 2018 18:12:54 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH] cpufreq: powernv: add of_node_put()
References: <20181120125731.19368-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120125731.19368-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18112612-0060-0000-0000-000002D8D8CF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010123; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123011; UDB=6.00582947; IPR=6.00903140; 
 MB=3.00024335; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-26 12:43:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112612-0061-0000-0000-0000475293B3
Message-Id: <20181126124254.GC21536@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-26_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260117
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
Reply-To: ego@linux.vnet.ibm.com
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Yangtao Li,

On Tue, Nov 20, 2018 at 07:57:31AM -0500, Yangtao Li wrote:
> use of_node_put() to release the refcount.
>

Thanks for the patch.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index bf6519cf64bc..7e7ad3879c4e 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -253,18 +253,18 @@ static int init_powernv_pstates(void)
> 
>  	if (of_property_read_u32(power_mgt, "ibm,pstate-min", &pstate_min)) {
>  		pr_warn("ibm,pstate-min node not found\n");
> -		return -ENODEV;
> +		goto out;
>  	}
> 
>  	if (of_property_read_u32(power_mgt, "ibm,pstate-max", &pstate_max)) {
>  		pr_warn("ibm,pstate-max node not found\n");
> -		return -ENODEV;
> +		goto out;
>  	}
> 
>  	if (of_property_read_u32(power_mgt, "ibm,pstate-nominal",
>  				 &pstate_nominal)) {
>  		pr_warn("ibm,pstate-nominal not found\n");
> -		return -ENODEV;
> +		goto out;
>  	}
> 
>  	if (of_property_read_u32(power_mgt, "ibm,pstate-ultra-turbo",
> @@ -293,14 +293,14 @@ static int init_powernv_pstates(void)
>  	pstate_ids = of_get_property(power_mgt, "ibm,pstate-ids", &len_ids);
>  	if (!pstate_ids) {
>  		pr_warn("ibm,pstate-ids not found\n");
> -		return -ENODEV;
> +		goto out;
>  	}
> 
>  	pstate_freqs = of_get_property(power_mgt, "ibm,pstate-frequencies-mhz",
>  				      &len_freqs);
>  	if (!pstate_freqs) {
>  		pr_warn("ibm,pstate-frequencies-mhz not found\n");
> -		return -ENODEV;
> +		goto out;
>  	}
> 
>  	if (len_ids != len_freqs) {
> @@ -311,7 +311,7 @@ static int init_powernv_pstates(void)
>  	nr_pstates = min(len_ids, len_freqs) / sizeof(u32);
>  	if (!nr_pstates) {
>  		pr_warn("No PStates found\n");
> -		return -ENODEV;
> +		goto out;
>  	}
> 
>  	powernv_pstate_info.nr_pstates = nr_pstates;
> @@ -352,7 +352,12 @@ static int init_powernv_pstates(void)
> 
>  	/* End of list marker entry */
>  	powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
> +
> +	of_node_put(power_mgt);
>  	return 0;
> +out:
> +	of_node_put(power_mgt);
> +	return -ENODEV;
>  }
> 
>  /* Returns the CPU frequency corresponding to the pstate_id. */
> -- 
> 2.17.0
> 

